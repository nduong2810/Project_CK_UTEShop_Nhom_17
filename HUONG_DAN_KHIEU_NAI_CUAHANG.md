# Hệ thống Khiếu nại Cửa hàng (Shop Complaints)

## Mô tả
Hệ thống cho phép khách hàng gửi khiếu nại về cửa hàng lên admin và có thể thu hồi khiếu nại.

## Cấu trúc

### 1. Database
- Bảng: `KhieuNaiCuaHang`
- File SQL: `create_khieunai_cuahang.sql`

**Chạy script SQL để tạo bảng:**
```sql
-- Chạy file create_khieunai_cuahang.sql trong SQL Server
```

### 2. Entity
- **KhieuNaiCuaHang.java** - Entity chính
  - MaKNCH: ID khiếu nại
  - MaND: ID người dùng (khách hàng)
  - MaCH: ID cửa hàng bị khiếu nại
  - TieuDe: Tiêu đề khiếu nại
  - NoiDung: Nội dung chi tiết
  - NgayGui: Ngày gửi khiếu nại
  - TrangThai: PENDING, APPROVED, REJECTED, WITHDRAWN
  - GhiChu: Phản hồi từ admin
  - NgayXuLy: Ngày admin xử lý

### 3. DAO
- **KhieuNaiCuaHangDAO.java** - Data Access Object
  - `create()` - Tạo khiếu nại mới
  - `findById()` - Tìm khiếu nại theo ID
  - `findPaged()` - Lấy danh sách có phân trang
  - `updateStatus()` - Admin cập nhật trạng thái
  - `withdraw()` - Khách hàng thu hồi khiếu nại
  - `countAll()` - Đếm tổng số khiếu nại

### 4. Controllers

#### User (Khách hàng)
- **UserShopComplaintController.java** (`/user/shop-complaints`)
  - GET: Xem danh sách khiếu nại của mình
  - POST: Gửi khiếu nại mới hoặc thu hồi khiếu nại

- **UserShopComplaintFormController.java** (`/user/shop-complaint-form`)
  - GET: Hiển thị form gửi khiếu nại mới

#### Admin
- **AdminShopComplaintsController.java** (`/admin/shop-complaints`)
  - GET: Xem tất cả khiếu nại từ khách hàng

- **AdminShopComplaintUpdateController.java** (`/admin/shop-complaint-update`)
  - POST: Cập nhật trạng thái khiếu nại (chấp nhận/từ chối)

### 5. Views (JSP)

#### User Views
- **shop-complaints.jsp** - Danh sách khiếu nại của khách hàng
- **shop-complaint-form.jsp** - Form gửi khiếu nại mới

#### Admin Views
- **shop-complaints.jsp** - Quản lý khiếu nại (admin)

## Tính năng

### Khách hàng có thể:
1. ✅ Xem danh sách cửa hàng đang hoạt động
2. ✅ Gửi khiếu nại về cửa hàng (tiêu đề + nội dung chi tiết)
3. ✅ Xem lịch sử khiếu nại của mình
4. ✅ Thu hồi khiếu nại (chỉ khi đang ở trạng thái PENDING)
5. ✅ Xem phản hồi từ admin
6. ✅ Lọc và tìm kiếm khiếu nại

### Admin có thể:
1. ✅ Xem tất cả khiếu nại từ khách hàng
2. ✅ Lọc theo trạng thái, người dùng, cửa hàng
3. ✅ Chấp nhận khiếu nại (APPROVED)
4. ✅ Từ chối khiếu nại (REJECTED)
5. ✅ Thêm ghi chú khi xử lý
6. ✅ Xem thông tin người khiếu nại và cửa hàng bị khiếu nại

## Quy trình hoạt động

```
1. Khách hàng gửi khiếu nại về cửa hàng
   ↓
2. Trạng thái: PENDING (chờ xử lý)
   ↓
3a. Khách hàng có thể thu hồi → WITHDRAWN
   ↓
3b. Admin xử lý:
      - Chấp nhận → APPROVED
      - Từ chối → REJECTED
   ↓
4. Khách hàng xem kết quả và phản hồi từ admin
```

## Trạng thái khiếu nại

- **PENDING**: Chờ xử lý (khách có thể thu hồi)
- **APPROVED**: Admin chấp nhận khiếu nại
- **REJECTED**: Admin từ chối khiếu nại
- **WITHDRAWN**: Khách hàng đã thu hồi

## URLs

### Khách hàng:
- Danh sách: `/user/shop-complaints`
- Form gửi mới: `/user/shop-complaint-form`
- Form từ sản phẩm: `/user/shop-complaint-form?shopId={maCH}`

### Admin:
- Quản lý: `/admin/shop-complaints`
- Cập nhật: `/admin/shop-complaint-update` (POST)

## Cài đặt

1. Chạy file SQL để tạo bảng:
   ```bash
   sqlcmd -S localhost -U sa -P your_password -d UTESHOP -i create_khieunai_cuahang.sql
   ```

2. Rebuild project để compile các class mới

3. Restart server Tomcat

4. Truy cập:
   - Khách hàng: http://localhost:8080/Project_CK_UTESHOP_Nhom_17/user/shop-complaints
   - Admin: http://localhost:8080/Project_CK_UTESHOP_Nhom_17/admin/shop-complaints

## Lưu ý
- Khách hàng chỉ thu hồi được khiếu nại ở trạng thái PENDING
- Admin không thể sửa đổi khiếu nại đã xử lý
- Tất cả khiếu nại đều được lưu lịch sử
- Hỗ trợ tìm kiếm theo tiêu đề, nội dung, tên cửa hàng, tên người dùng
