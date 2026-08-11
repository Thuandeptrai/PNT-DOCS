[CmdletBinding()]
param(
    [int]$Port = 8088,
    [string]$PythonPath = "C:\AI\AIKnowledgeBase\.venv\Scripts\python.exe"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = "C:\Luyenthi\Requirementlab"

if (-not (Test-Path -LiteralPath $PythonPath)) {
    $PythonPath = "python"
}

Set-Location -LiteralPath $root
Write-Host "Starting study web at http://127.0.0.1:$Port/web/"
& $PythonPath -m http.server $Port --bind 127.0.0.1
