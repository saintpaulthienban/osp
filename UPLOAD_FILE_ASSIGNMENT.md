# Hướng Dẫn Upload File Quyết Định Bổ Nhiệm

## Tính năng mới đã thêm

### Backend

1. **Middleware Upload** (`backend/src/middlewares/upload.js`)

   - Thêm `decisionUploader` để xử lý upload file quyết định
   - Thêm `uploadDecision` middleware
   - Hỗ trợ file PDF, Word (doc, docx), và ảnh (jpg, jpeg, png)
   - Giới hạn kích thước file: 10MB
   - File được lưu trong thư mục `backend/src/uploads/decisions/`

2. **Controller** (`backend/src/controllers/communityController.js`)

   - Cập nhật `addMember` để xử lý file upload khi thêm bổ nhiệm mới
   - Cập nhật `updateMemberRole` để xử lý file upload khi chỉnh sửa bổ nhiệm
   - File URL được lưu trong database với format: `/uploads/decisions/{filename}`

3. **Routes** (`backend/src/routes/communityRoutes.js`)

   - Thêm middleware `uploadDecision` vào routes:
     - POST `/:id/members` - Thêm bổ nhiệm
     - PUT `/:id/members/:memberId` - Cập nhật bổ nhiệm

4. **Database**
   - Cột `decision_file_url` trong bảng `community_assignments` đã tồn tại
   - Script migration: `backend/src/scripts/ensure_decision_file_column.js`

### Frontend

1. **Service** (`frontend/src/services/communityService.js`)

   - Cập nhật `addMember` hỗ trợ FormData
   - Cập nhật `updateMemberRole` hỗ trợ FormData
   - Tự động set header `Content-Type: multipart/form-data`

2. **Component** (`frontend/src/features/cong-doan/pages/AssignmentPage.jsx`)
   - Thêm state `decisionFile` để quản lý file
   - Thêm function `handleFileChange` để validate file
   - Cập nhật `handleSubmit` để gửi FormData thay vì JSON
   - Thêm UI upload file trong modal Thêm/Sửa:
     - Input file với accept các loại file được phép
     - Hiển thị tên file đã chọn
     - Nút tải file hiện tại (khi edit)
   - Thêm hiển thị file trong modal Xem Chi Tiết:
     - Hiển thị số quyết định
     - Nút tải file đính kèm

## Cách sử dụng

### Thêm bổ nhiệm mới với file đính kèm

1. Mở trang Quản Lý Bổ Nhiệm
2. Click nút "Thêm"
3. Điền thông tin bổ nhiệm
4. Ở mục "File Đính Kèm", click chọn file
5. File được validate:
   - Loại file: PDF, Word (.doc, .docx), hoặc ảnh (.jpg, .jpeg, .png)
   - Kích thước tối đa: 10MB
6. Click "Lưu Bổ Nhiệm"

### Chỉnh sửa và thêm/thay file

1. Click nút "Chỉnh sửa" trên dòng bổ nhiệm
2. Nếu đã có file, sẽ hiển thị nút "Tải file hiện tại"
3. Có thể chọn file mới để thay thế
4. Click "Lưu Bổ Nhiệm"

### Xem và tải file đính kèm

1. Click nút "Xem chi tiết" trên dòng bổ nhiệm
2. Trong phần "Thông Tin Bổ Nhiệm", sẽ hiển thị:
   - Số quyết định
   - Nút "Tải về" nếu có file đính kèm
3. Click "Tải về" để mở/download file

## Validation

- **Frontend**:

  - Kiểm tra loại file
  - Kiểm tra kích thước file
  - Hiển thị thông báo lỗi nếu không hợp lệ

- **Backend**:
  - Multer middleware kiểm tra MIME type
  - Kiểm tra file size
  - Trả về lỗi 400 nếu file không hợp lệ

## File structure

```
backend/src/uploads/decisions/
  ├── 1703234567890-abc123.pdf
  ├── 1703234567891-def456.docx
  └── ...
```

## API Endpoints

### POST /api/communities/:id/members

Thêm bổ nhiệm mới

- Content-Type: multipart/form-data
- Fields:
  - sister_id (required)
  - role
  - start_date
  - end_date
  - decision_number
  - decision_file (file)
  - notes

### PUT /api/communities/:id/members/:memberId

Cập nhật bổ nhiệm

- Content-Type: multipart/form-data
- Fields:
  - role
  - start_date
  - end_date
  - decision_number
  - decision_file (file, optional)
  - notes

## Notes

- File được serve từ URL: `http://localhost:5000/uploads/decisions/{filename}`
- Production: Cần cấu hình CORS và static file serving phù hợp
- File cũ không tự động xóa khi upload file mới (có thể thêm logic cleanup sau)
