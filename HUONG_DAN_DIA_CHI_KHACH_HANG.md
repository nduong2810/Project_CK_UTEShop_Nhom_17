# HƯỚNG DẪN SỬ DỤNG TÍNH NĂNG QUẢN LÝ ĐỊA CHỈ KHÁCH HÀNG

## 📋 Tổng quan
Tính năng này cho phép khách hàng (USER) quản lý nhiều địa chỉ giao hàng khác nhau, bao gồm:
- Xem danh sách địa chỉ
- Thêm địa chỉ mới
- Chỉnh sửa địa chỉ
- Xóa địa chỉ
- Đặt địa chỉ mặc định

## 🗄️ Cấu trúc Database

### Bảng: DiaChiGiaoHang
```sql
- maDC (INT, PRIMARY KEY, IDENTITY): ID địa chỉ
- maND (INT, FOREIGN KEY): ID người dùng
- tenNguoiNhan (NVARCHAR(100)): Tên người nhận hàng
- soDienThoai (NVARCHAR(15)): Số điện thoại
- diaChiCuThe (NVARCHAR(255)): Số nhà, tên đường
- phuong (NVARCHAR(100)): Phường/Xã
- quan (NVARCHAR(100)): Quận/Huyện
- thanhPho (NVARCHAR(100)): Tỉnh/Thành phố
- laMacDinh (BIT): Địa chỉ mặc định (0/1)
- ngayTao (DATETIME2): Ngày tạo
- ngayCapNhat (DATETIME2): Ngày cập nhật
```

## 🚀 Cài đặt

### Bước 1: Chạy SQL Script
Chạy file `create_address_table.sql` để tạo bảng DiaChiGiaoHang:
```bash
sqlcmd -S localhost -d UTEShop -U sa -P 1 -i create_address_table.sql
```

Hoặc mở SQL Server Management Studio và chạy script trong file.

### Bước 2: Kiểm tra các file đã có
✅ **Entity**: `src/main/java/com/uteshop/entity/DiaChiGiaoHang.java`
✅ **DAO**: `src/main/java/com/uteshop/dao/DiaChiGiaoHangDAO.java`
✅ **Controller**: `src/main/java/com/uteshop/controller/user/AddressController.java`
✅ **View - Danh sách**: `src/main/webapp/WEB-INF/views/user/address-list.jsp`
✅ **View - Form**: `src/main/webapp/WEB-INF/views/user/address-form.jsp`

### Bước 3: Kiểm tra URL Mapping
Controller đã được map tại: `/user/address`

URL patterns:
- `GET /user/address` hoặc `/user/address?action=list` - Xem danh sách địa chỉ
- `GET /user/address?action=add` - Form thêm địa chỉ mới
- `GET /user/address?action=edit&id={maDC}` - Form chỉnh sửa địa chỉ
- `GET /user/address?action=delete&id={maDC}` - Xóa địa chỉ
- `GET /user/address?action=setDefault&id={maDC}` - Đặt làm mặc định
- `POST /user/address?action=save` - Lưu địa chỉ (thêm/sửa)

## 📱 Hướng dẫn sử dụng

### Cho khách hàng (USER):

1. **Truy cập quản lý địa chỉ**
   - Đăng nhập vào hệ thống
   - Vào "Hồ sơ cá nhân" (Profile)
   - Click nút "Quản lý địa chỉ" (màu xanh lá)

2. **Thêm địa chỉ mới**
   - Click "Thêm Địa Chỉ Mới"
   - Điền đầy đủ thông tin:
     * Tên người nhận
     * Số điện thoại (10-11 số)
     * Địa chỉ cụ thể (số nhà, tên đường)
     * Phường/Xã
     * Quận/Huyện
     * Tỉnh/Thành phố
   - Tích chọn "Đặt làm địa chỉ mặc định" nếu muốn
   - Click "Lưu Địa Chỉ"

3. **Chỉnh sửa địa chỉ**
   - Tại danh sách địa chỉ, click nút "Chỉnh sửa"
   - Cập nhật thông tin cần thay đổi
   - Click "Cập Nhật"

4. **Xóa địa chỉ**
   - Click nút "Xóa" trên địa chỉ muốn xóa
   - Xác nhận xóa
   - Lưu ý: Nếu xóa địa chỉ mặc định, địa chỉ tiếp theo sẽ tự động trở thành mặc định

5. **Đặt địa chỉ mặc định**
   - Click nút "Đặt mặc định" trên địa chỉ muốn đặt
   - Địa chỉ này sẽ được dùng khi đặt hàng

## 🎨 Giao diện

### Trang danh sách địa chỉ (address-list.jsp)
- Thiết kế hiện đại với gradient tím
- Hiển thị địa chỉ dạng card
- Địa chỉ mặc định có viền xanh lá và badge "Mặc định"
- Có animation hover effect
- Hiển thị số lượng địa chỉ đã lưu
- Empty state khi chưa có địa chỉ

### Trang form địa chỉ (address-form.jsp)
- Form đẹp với validation
- Hỗ trợ cả thêm mới và chỉnh sửa
- Các trường bắt buộc có dấu (*)
- Checkbox để đặt làm mặc định
- Responsive trên mobile

## 🔒 Bảo mật
- Chỉ USER đã đăng nhập mới truy cập được
- Mỗi user chỉ xem/sửa/xóa địa chỉ của mình
- Kiểm tra ownership trước khi thao tác
- Redirect về login nếu chưa đăng nhập

## 📊 Chức năng DAO

### DiaChiGiaoHangDAO Methods:
```java
// Lưu hoặc cập nhật địa chỉ
boolean save(DiaChiGiaoHang diaChi)

// Lấy tất cả địa chỉ của user (sort theo mặc định và ngày tạo)
List<DiaChiGiaoHang> getAddressesByUser(int userId)

// Lấy địa chỉ mặc định của user
DiaChiGiaoHang getDefaultAddress(int userId)

// Tìm địa chỉ theo ID
DiaChiGiaoHang findById(int id)

// Xóa địa chỉ (tự động set địa chỉ khác làm mặc định nếu cần)
boolean delete(int id, int userId)

// Đặt địa chỉ làm mặc định
boolean setAsDefault(int addressId, int userId)

// Đếm số lượng địa chỉ của user
long countAddressesByUser(int userId)

// Cập nhật địa chỉ
boolean update(DiaChiGiaoHang diaChi)
```

## 🔄 Tích hợp với Checkout

Khi khách hàng đặt hàng, có thể:
1. Sử dụng địa chỉ mặc định
2. Chọn địa chỉ khác từ danh sách
3. Thêm địa chỉ mới ngay trong trang checkout

```java
// Trong CheckoutController
DiaChiGiaoHangDAO addressDAO = new DiaChiGiaoHangDAO();
DiaChiGiaoHang defaultAddress = addressDAO.getDefaultAddress(userId);
List<DiaChiGiaoHang> allAddresses = addressDAO.getAddressesByUser(userId);
```

## 🐛 Xử lý lỗi

Controller đã xử lý các trường hợp:
- User chưa đăng nhập → Redirect về login
- ID địa chỉ không hợp lệ → Hiển thị lỗi
- Không có quyền truy cập địa chỉ → Hiển thị lỗi
- Thiếu thông tin bắt buộc → Hiển thị lỗi validation
- Lỗi database → Hiển thị thông báo lỗi

## 📝 Notes

1. **Địa chỉ mặc định**:
   - Mỗi user chỉ có 1 địa chỉ mặc định
   - Khi đặt địa chỉ A làm mặc định, các địa chỉ khác tự động bỏ mặc định
   - Nếu xóa địa chỉ mặc định, địa chỉ cũ nhất sẽ tự động trở thành mặc định

2. **Validation**:
   - Tất cả các trường đều bắt buộc
   - Số điện thoại phải 10-11 số

3. **Character Encoding**:
   - Đã set UTF-8 trong persistence.xml
   - Đã có CharacterEncodingFilter trong web.xml
   - Tiếng Việt hiển thị bình thường

## 🎯 Test Cases

### Test 1: Thêm địa chỉ đầu tiên
1. Login với user test
2. Vào Profile > Quản lý địa chỉ
3. Click "Thêm Địa Chỉ Mới"
4. Điền thông tin và save
5. ✅ Địa chỉ xuất hiện trong danh sách

### Test 2: Thêm địa chỉ thứ 2 và set mặc định
1. Thêm địa chỉ mới
2. Tích "Đặt làm địa chỉ mặc định"
3. Save
4. ✅ Địa chỉ mới có badge "Mặc định", địa chỉ cũ mất badge

### Test 3: Chỉnh sửa địa chỉ
1. Click "Chỉnh sửa" trên 1 địa chỉ
2. Thay đổi thông tin
3. Save
4. ✅ Thông tin cập nhật thành công

### Test 4: Xóa địa chỉ không phải mặc định
1. Click "Xóa" trên địa chỉ thường
2. Confirm
3. ✅ Địa chỉ bị xóa, địa chỉ mặc định không thay đổi

### Test 5: Xóa địa chỉ mặc định
1. Click "Xóa" trên địa chỉ mặc định
2. Confirm
3. ✅ Địa chỉ bị xóa, địa chỉ tiếp theo tự động trở thành mặc định

### Test 6: Security - Truy cập địa chỉ của user khác
1. Thử truy cập `/user/address?action=edit&id={id_cua_user_khac}`
2. ✅ Hiển thị lỗi "Không có quyền truy cập"

## ✅ Checklist

- [x] Tạo bảng DiaChiGiaoHang trong database
- [x] Entity DiaChiGiaoHang
- [x] DAO với các methods CRUD
- [x] Controller xử lý request
- [x] View danh sách địa chỉ
- [x] View form thêm/sửa địa chỉ
- [x] Thêm link vào trang Profile
- [x] Security check
- [x] Xử lý địa chỉ mặc định
- [x] Responsive design
- [x] UTF-8 encoding

## 🎉 Hoàn thành!

Tính năng quản lý địa chỉ khách hàng đã sẵn sàng sử dụng!
