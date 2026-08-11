[CmdletBinding()]
param(
    [string]$SourcePath = "C:\Luyenthi\Requirementlab",
    [string]$OutputPath = "C:\Luyenthi\Requirementlab\converted-md",
    [string]$PythonPath = "C:\AI\AIKnowledgeBase\.venv\Scripts\python.exe",
    [switch]$Force,
    [switch]$IncludePptx,
    [switch]$IncludeLargeFiles
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $SourcePath)) {
    throw "Source path not found: $SourcePath"
}

if (-not (Test-Path -LiteralPath $PythonPath)) {
    throw "Python not found: $PythonPath"
}

New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null

$supportedExtensions = @(".pdf")
if ($IncludePptx) {
    $supportedExtensions += ".pptx"
}

$maxDefaultBytes = 150MB

function Convert-ToSafeFileName {
    param([Parameter(Mandatory)][string]$Value)

    $safe = $Value -replace '[^\p{L}\p{Nd}\.\-_ ]+', '_'
    $safe = $safe.Trim(" .")
    if ([string]::IsNullOrWhiteSpace($safe)) {
        return "document"
    }
    return $safe
}

function Remove-VietnameseDiacritics {
    param([Parameter(Mandatory)][string]$Value)

    $normalized = $Value.Normalize([Text.NormalizationForm]::FormD)
    $builder = [Text.StringBuilder]::new()
    foreach ($char in $normalized.ToCharArray()) {
        $category = [Globalization.CharUnicodeInfo]::GetUnicodeCategory($char)
        if ($category -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$builder.Append($char)
        }
    }

    $result = $builder.ToString().Normalize([Text.NormalizationForm]::FormC)
    $result = $result.Replace([string][char]0x0111, "d")
    $result = $result.Replace([string][char]0x0110, "D")
    return $result
}

function Get-Category {
    param([Parameter(Mandatory)][System.IO.FileInfo]$File)

    $name = Remove-VietnameseDiacritics -Value $File.Name
    $name = $name.ToLowerInvariant()

    if ($name -match 'spk|san|phu|tn4000') {
        return "san-phu-khoa"
    }
    if ($name -match 'gp|giai phau|giac quan|quang quyen') {
        return "giai-phau"
    }
    if ($name -match 'sdh|ck1|pnt') {
        return "old-exams"
    }
    return "misc"
}

function Convert-OneFile {
    param([Parameter(Mandatory)][System.IO.FileInfo]$File)

    if (-not $IncludeLargeFiles -and $File.Length -gt $maxDefaultBytes) {
        $sizeMb = [math]::Round($File.Length / 1MB, 1)
        Write-Host "Skipped large file: $($File.Name) ($sizeMb MB). Use -IncludeLargeFiles to convert."
        return
    }

    $category = Get-Category -File $File
    $categoryPath = Join-Path $OutputPath $category
    New-Item -ItemType Directory -Force -Path $categoryPath | Out-Null

    $safeName = Convert-ToSafeFileName -Value ([IO.Path]::GetFileNameWithoutExtension($File.Name))
    $mdPath = Join-Path $categoryPath "$safeName.md"

    if (-not $Force -and (Test-Path -LiteralPath $mdPath)) {
        $outItem = Get-Item -LiteralPath $mdPath
        if ($outItem.LastWriteTime -ge $File.LastWriteTime) {
            Write-Host "Unchanged: $mdPath"
            return
        }
    }

    $tempPath = Join-Path $categoryPath "$safeName.markitdown.tmp.md"
    $errPath = Join-Path $categoryPath "$safeName.markitdown.err.txt"

    if (Test-Path -LiteralPath $tempPath) {
        Remove-Item -LiteralPath $tempPath -Force
    }
    if (Test-Path -LiteralPath $errPath) {
        Remove-Item -LiteralPath $errPath -Force
    }

    Write-Host "Converting: $($File.FullName)"
    & $PythonPath -m markitdown $File.FullName -o $tempPath 2> $errPath
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "MarkItDown failed for $($File.Name). See $errPath"
        if (Test-Path -LiteralPath $tempPath) {
            Remove-Item -LiteralPath $tempPath -Force
        }
        return
    }

    $body = ""
    if (Test-Path -LiteralPath $tempPath) {
        $body = Get-Content -Raw -Encoding UTF8 -LiteralPath $tempPath -ErrorAction SilentlyContinue
    }

    $headerLines = @(
        "---",
        "title: `"$safeName`"",
        "source_file: `"$($File.FullName)`"",
        "source_name: `"$($File.Name)`"",
        "source_size_bytes: $($File.Length)",
        "converted_with: `"Microsoft MarkItDown via C:\AI\AIKnowledgeBase\.venv`"",
        "converted_on: `"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`"",
        "category: `"$category`"",
        "---",
        "",
        "# $safeName",
        "",
        "Source: $($File.FullName)",
        "",
        "> Conversion note: MarkItDown output is for AI retrieval and study support. If this file is empty or missing tables, inspect the original PDF/PPTX manually or use OCR.",
        ""
    )
    $header = $headerLines -join "`r`n"

    Set-Content -LiteralPath $mdPath -Value ($header + $body) -Encoding UTF8
    Remove-Item -LiteralPath $tempPath -Force

    $length = (Get-Item -LiteralPath $mdPath).Length
    if ($length -lt 800) {
        Write-Warning "Converted Markdown is very small: $mdPath. This source may be scanned/image-based and need OCR."
    } else {
        Write-Host "Converted -> $mdPath"
    }
}

$files = Get-ChildItem -LiteralPath $SourcePath -File |
    Where-Object { $supportedExtensions -contains $_.Extension.ToLowerInvariant() } |
    Sort-Object Name

foreach ($file in $files) {
    Convert-OneFile -File $file
}

Write-Host "Done. Markdown output: $OutputPath"
