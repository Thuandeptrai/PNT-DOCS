# Web ôn thi Sản phụ khoa

Đây là web tĩnh đơn giản để học theo từng ngày.

## Chạy local

Từ thư mục `C:\Luyenthi\Requirementlab`:

```powershell
powershell -ExecutionPolicy Bypass -File ".\start-study-web.ps1"
```

Sau đó mở:

```text
http://127.0.0.1:8088/web/
```

## Nội dung

- Chọn ngày 1-29.
- Xem mục tiêu, tài liệu, bài tập, checklist.
- Ngày 1 có quiz diagnostic 30 câu trộn.
- Ngày 2-29 có quiz tương tác định hướng học tập theo đúng dữ liệu từng ngày.
- Kết quả quiz lưu trong trình duyệt bằng `localStorage`.

## Dữ liệu quiz

- Ngày 1: `web/data/day-01-diagnostic.json`
- Ngày 2-29: `web/data/day-xx-quiz.json`

Nếu cập nhật `study-days/all-days.json`, chạy:

```powershell
node .\generate-web-quizzes.js
```
