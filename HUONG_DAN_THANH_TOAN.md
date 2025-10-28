# Hướng dẫn sử dụng tính năng Thanh toán cho Cửa hàng

## Tổng quan
Tính năng này cho phép chủ cửa hàng cấu hình thông tin thanh toán MoMo và Ngân hàng, bao gồm upload ảnh QR code.

## Các bước thực hiện

### 1. Cập nhật Database
Chạy script SQL để thêm các cột mới vào bảng CuaHang:

```sql
-- File: add_payment_info.sql
USE [UTEShop];
GO

ALTER TABLE CuaHang ADD MomoEnable BIT DEFAULT 0;
ALTER TABLE CuaHang ADD MomoPhone NVARCHAR(15) NULL;
ALTER TABLE CuaHang ADD MomoName NVARCHAR(255) NULL;
ALTER TABLE CuaHang ADD MomoQR NVARCHAR(500) NULL;

ALTER TABLE CuaHang ADD BankEnable BIT DEFAULT 0;
ALTER TABLE CuaHang ADD BankName NVARCHAR(255) NULL;
ALTER TABLE CuaHang ADD BankAccountNumber NVARCHAR(50) NULL;
ALTER TABLE CuaHang ADD BankAccountName NVARCHAR(255) NULL;
ALTER TABLE CuaHang ADD BankQR NVARCHAR(500) NULL;

UPDATE CuaHang 
SET MomoEnable = 0, BankEnable = 0
WHERE MomoEnable IS NULL OR BankEnable IS NULL;
GO
```

### 2. Các file đã được cập nhật/tạo mới

#### Entity
- **CuaHang.java**: Đã thêm các trường:
  - MoMo: `momoEnable`, `momoPhone`, `momoName`, `momoQR`
  - Bank: `bankEnable`, `bankName`, `bankAccountNumber`, `bankAccountName`, `bankQR`

#### DAO
- **CuaHangDAO.java**: Đã thêm method `updatePaymentInfo()` để cập nhật thông tin thanh toán

#### Controller
- **VendorController.java**: Đã thêm:
  - `@MultipartConfig` để hỗ trợ upload file
  - Method `showPaymentSettings()` - hiển thị trang quản lý thanh toán
  - Method `updatePaymentInfo()` - xử lý cập nhật thông tin thanh toán
  - Method `uploadQRImage()` - xử lý upload ảnh QR code
  - URL pattern mới: `/vendor/settings/payment`

#### View (JSP)
- **payment-settings.jsp**: Trang quản lý thông tin thanh toán (mới)
- **settings.jsp**: Đã cập nhật để hiển thị trạng thái thanh toán và link đến trang quản lý

#### Thư mục
- **assets/img/qr/**: Thư mục lưu ảnh QR code (đã tạo)

### 3. Tính năng

#### Thanh toán MoMo
- Bật/tắt thanh toán MoMo
- Nhập số điện thoại MoMo
- Nhập tên chủ tài khoản
- Upload ảnh QR code MoMo

#### Thanh toán Ngân hàng
- Bật/tắt thanh toán Ngân hàng
- Nhập tên ngân hàng
- Nhập số tài khoản
- Nhập tên chủ tài khoản
- Upload ảnh QR code Ngân hàng

### 4. Cách sử dụng

1. **Đăng nhập với tài khoản Vendor**
2. **Vào menu Vendor Panel**
3. **Chọn "Cài đặt" hoặc "Thanh toán"**
4. **Cấu hình thông tin thanh toán:**
   - Bật/tắt từng phương thức thanh toán
   - Nhập đầy đủ thông tin
   - Upload ảnh QR code (nếu có)
5. **Nhấn "Lưu thông tin thanh toán"**

### 5. Validation

- Nếu bật MoMo: Bắt buộc nhập số điện thoại và tên chủ tài khoản
- Nếu bật Ngân hàng: Bắt buộc nhập tên ngân hàng, số tài khoản và tên chủ tài khoản
- Ảnh QR code: Định dạng JPG/PNG, tối đa 10MB
- Ảnh sẽ được lưu với tên: `{paymentType}_qr_{storeId}_{timestamp}.{ext}`

### 6. Hiển thị thông tin

- Trong trang **Settings**: Hiển thị trạng thái thanh toán (Đã kích hoạt/Chưa kích hoạt)
- Trong trang **Payment Settings**: Form đầy đủ để quản lý

### 7. Lưu ý

- Ảnh QR được lưu tại: `webapp/assets/img/qr/`
- Đường dẫn trong database: `qr/{filename}`
- Nếu upload ảnh mới, ảnh cũ sẽ bị ghi đè
- Có thể bật cả 2 phương thức thanh toán cùng lúc
- Có thể chỉ bật 1 phương thức
- Có thể tắt cả 2 (không có phương thức thanh toán nào)

### 8. API Endpoints

- `GET /vendor/settings/payment` - Hiển thị trang quản lý thanh toán
- `POST /vendor/settings/payment` - Cập nhật thông tin thanh toán (với action=updatePaymentInfo)

### 9. Kiểm tra

Sau khi triển khai, kiểm tra:
1. ✅ Database đã có các cột mới
2. ✅ Thư mục qr đã được tạo
3. ✅ Có thể truy cập /vendor/settings/payment
4. ✅ Upload ảnh thành công
5. ✅ Dữ liệu được lưu vào database
6. ✅ Hiển thị đúng trong trang settings

## Kết quả

Tính năng đã hoàn thiện và sẵn sàng sử dụng!
