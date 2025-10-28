# SỬA LẠI HỆ THỐNG ĐỔN HÀNG - HOÀN THÀNH

## 📋 Tổng quan

Đã sửa lại toàn bộ hệ thống trạng thái đơn hàng để đồng nhất và rõ ràng hơn.

## 🔄 Các thay đổi chính

### 1. **Enum TrangThaiDonHang trong `DonHang.java`**

#### ❌ Trước đây (có vấn đề):
```java
public enum TrangThaiDonHang {
    DON_HANG_MOI, DA_XAC_NHAN, DANG_GIAO, DA_GIAO, 
    DA_HUY, TRA_HANG, HOAN_TIEN, DANG_XU_LY, CHO_XAC_NHAN
}
```
**Vấn đề**: 
- Có cả `DON_HANG_MOI` và `CHO_XAC_NHAN` (trùng lặp ý nghĩa)
- Có `DANG_XU_LY` nhưng không được sử dụng
- Thiếu trạng thái `DANG_CHUAN_BI` và `HOAN_THANH`

#### ✅ Sau khi sửa:
```java
public enum TrangThaiDonHang {
    CHO_XAC_NHAN,    // Chờ xác nhận (mới đặt)
    DA_XAC_NHAN,     // Đã xác nhận
    DANG_CHUAN_BI,   // Đang chuẩn bị hàng
    DANG_GIAO,       // Đang giao hàng
    DA_GIAO,         // Đã giao hàng
    HOAN_THANH,      // Hoàn thành
    DA_HUY,          // Đã hủy
    TRA_HANG,        // Trả hàng
    HOAN_TIEN        // Hoàn tiền
}
```

**Luồng trạng thái chuẩn**:
```
CHO_XAC_NHAN → DA_XAC_NHAN → DANG_CHUAN_BI → DANG_GIAO → DA_GIAO → HOAN_THANH
                    ↓
                 DA_HUY
                    
DA_GIAO → TRA_HANG → HOAN_TIEN
```

### 2. **File đã cập nhật**

#### Java Files:
- ✅ `DonHang.java` - Sửa enum và constructor
- ✅ `DonHangDAO.java` - Sửa method `countNewOrders()` và `mapStatus()`
- ✅ `VendorController.java` - Sửa method `getStatusDisplayName()`
- ✅ `CheckoutController.java` - Đã đúng (sử dụng `CHO_XAC_NHAN`)

#### JSP Files:
- ✅ `vendor/order-detail.jsp` - Cập nhật CSS, hiển thị trạng thái, và nút cập nhật
- ✅ `admin/orders.jsp` - Cập nhật hiển thị trạng thái và dropdown
- ✅ `admin/order-view.jsp` - Cập nhật hiển thị badge trạng thái

### 3. **Chi tiết thay đổi theo file**

#### `DonHang.java`:
```java
// Constructor mặc định
public DonHang() {
    this.ngayDat = new Date();
    this.ngayCapNhat = new Date();
    this.trangThai = TrangThaiDonHang.CHO_XAC_NHAN; // ✅ Sửa từ DON_HANG_MOI
}
```

#### `DonHangDAO.java`:
```java
// Method đếm đơn hàng mới
public long countNewOrders(Integer maCH) {
    // ✅ Sửa: Đơn hàng mới có trạng thái CHO_XAC_NHAN
    String jpql = "... AND dh.trangThai = :status";
    // Sử dụng parameter thay vì hardcode string
    .setParameter("status", TrangThaiDonHang.CHO_XAC_NHAN)
}

// Method map string to enum
public TrangThaiDonHang mapStatus(String s) {
    switch (x.toLowerCase()) {
        case "chờ xác nhận":
        case "mới tạo":
            return TrangThaiDonHang.CHO_XAC_NHAN; // ✅ Mới
        case "đã xác nhận":
            return TrangThaiDonHang.DA_XAC_NHAN;
        case "đang chuẩn bị":
            return TrangThaiDonHang.DANG_CHUAN_BI; // ✅ Mới
        case "đang giao":
            return TrangThaiDonHang.DANG_GIAO;
        case "đã giao":
            return TrangThaiDonHang.DA_GIAO;
        case "hoàn thành":
            return TrangThaiDonHang.HOAN_THANH; // ✅ Mới
        // ... các trạng thái khác
    }
}
```

#### `VendorController.java`:
```java
private String getStatusDisplayName(DonHang.TrangThaiDonHang status) {
    switch (status) {
        case CHO_XAC_NHAN: return "Chờ xác nhận";      // ✅ Mới
        case DA_XAC_NHAN: return "Đã xác nhận";
        case DANG_CHUAN_BI: return "Đang chuẩn bị";    // ✅ Mới
        case DANG_GIAO: return "Đang giao";
        case DA_GIAO: return "Đã giao";
        case HOAN_THANH: return "Hoàn thành";          // ✅ Mới
        case DA_HUY: return "Đã hủy";
        case TRA_HANG: return "Trả hàng";
        case HOAN_TIEN: return "Hoàn tiền";
        default: return status.toString();
    }
}
```

#### `vendor/order-detail.jsp`:
```jsp
<!-- CSS cho các trạng thái -->
.status-CHO_XAC_NHAN { background: #e3f2fd; color: #1976d2; }
.status-DA_XAC_NHAN { background: #fff3e0; color: #f57c00; }
.status-DANG_CHUAN_BI { background: #fce4ec; color: #c2185b; }
.status-DANG_GIAO { background: #e1f5fe; color: #0277bd; }
.status-DA_GIAO { background: #e8f5e9; color: #2e7d32; }
.status-HOAN_THANH { background: #c8e6c9; color: #1b5e20; }
.status-DA_HUY { background: #ffebee; color: #c62828; }
.status-TRA_HANG { background: #fff9c4; color: #f57f17; }
.status-HOAN_TIEN { background: #f3e5f5; color: #6a1b9a; }

<!-- Hiển thị trạng thái -->
<c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">Chờ xác nhận</c:when>
<c:when test="${order.trangThai == 'DA_XAC_NHAN'}">Đã xác nhận</c:when>
<c:when test="${order.trangThai == 'DANG_CHUAN_BI'}">Đang chuẩn bị</c:when>
<!-- ... -->

<!-- Nút cập nhật trạng thái -->
<c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">
    <button name="newStatus" value="DA_XAC_NHAN">Xác nhận đơn hàng</button>
    <button name="newStatus" value="DA_HUY">Hủy đơn hàng</button>
</c:when>
<c:when test="${order.trangThai == 'DA_XAC_NHAN'}">
    <button name="newStatus" value="DANG_CHUAN_BI">Đang chuẩn bị</button>
</c:when>
<c:when test="${order.trangThai == 'DANG_CHUAN_BI'}">
    <button name="newStatus" value="DANG_GIAO">Đang giao hàng</button>
</c:when>
<c:when test="${order.trangThai == 'DANG_GIAO'}">
    <button name="newStatus" value="DA_GIAO">Đã giao hàng</button>
</c:when>
<c:when test="${order.trangThai == 'DA_GIAO'}">
    <button name="newStatus" value="HOAN_THANH">Hoàn thành</button>
</c:when>
```

#### `admin/orders.jsp`:
```jsp
<!-- Badge hiển thị trạng thái -->
<c:when test="${o.trangThai == 'CHO_XAC_NHAN'}">
    <span class="badge bg-info">Chờ xác nhận</span>
</c:when>
<c:when test="${o.trangThai == 'DA_XAC_NHAN'}">
    <span class="badge bg-warning">Đã xác nhận</span>
</c:when>
<c:when test="${o.trangThai == 'DANG_CHUAN_BI'}">
    <span class="badge bg-primary">Đang chuẩn bị</span>
</c:when>
<!-- ... -->

<!-- Dropdown cập nhật nhanh -->
<select name="newStatus">
    <option ${o.trangThai=='CHO_XAC_NHAN'?'selected':''}>Chờ xác nhận</option>
    <option ${o.trangThai=='DA_XAC_NHAN'?'selected':''}>Đã xác nhận</option>
    <option ${o.trangThai=='DANG_CHUAN_BI'?'selected':''}>Đang chuẩn bị</option>
    <!-- ... -->
</select>
```

## 🎯 Lợi ích của việc sửa đổi

### 1. **Rõ ràng hơn**
- Loại bỏ trùng lặp giữa `DON_HANG_MOI` và `CHO_XAC_NHAN`
- Tên trạng thái đồng nhất, dễ hiểu

### 2. **Luồng xử lý đầy đủ hơn**
- Thêm `DANG_CHUAN_BI` - vendor chuẩn bị hàng trước khi giao
- Thêm `HOAN_THANH` - đánh dấu đơn hàng hoàn tất

### 3. **Dễ bảo trì**
- Code nhất quán giữa Java và JSP
- Không còn hardcode string trong JPQL

### 4. **Tương thích ngược**
- Method `mapStatus()` vẫn chấp nhận "mới tạo" → `CHO_XAC_NHAN`
- Không ảnh hưởng đến dữ liệu cũ trong database

## 🚀 Cách test

### 1. Build project
```bash
cd "D:\HK I Year 3(first)\LTWeb\Project_CK_UTEShop_Nhom_17"
mvn clean package
```

### 2. Deploy và kiểm tra

#### Test với Vendor:
1. Đăng nhập với tài khoản Vendor
2. Vào "Quản lý đơn hàng"
3. Kiểm tra:
   - ✅ Đơn hàng mới có trạng thái "Chờ xác nhận"
   - ✅ Có thể cập nhật trạng thái theo luồng: Chờ XN → Đã XN → Đang chuẩn bị → Đang giao → Đã giao → Hoàn thành
   - ✅ Màu sắc badge hiển thị đúng

#### Test với User:
1. Đặt hàng mới
2. Kiểm tra:
   - ✅ Đơn hàng được tạo với trạng thái "Chờ xác nhận"
   - ✅ Hiển thị đúng trong danh sách đơn hàng

#### Test với Admin:
1. Đăng nhập Admin
2. Vào "Quản lý đơn hàng"
3. Kiểm tra:
   - ✅ Hiển thị đúng trạng thái
   - ✅ Dropdown cập nhật trạng thái hoạt động

## 📊 Mapping Database

Nếu database đã có dữ liệu cũ với trạng thái `DON_HANG_MOI` hoặc `CHUA_XAC_NHAN`, cần chạy script SQL:

```sql
USE UTEShop;
GO

-- Cập nhật các trạng thái cũ sang trạng thái mới
UPDATE DonHang 
SET TrangThai = 'CHO_XAC_NHAN' 
WHERE TrangThai IN ('DON_HANG_MOI', 'CHUA_XAC_NHAN');

UPDATE DonHang 
SET TrangThai = 'HOAN_THANH' 
WHERE TrangThai = 'DA_GIAO' 
AND DATEDIFF(day, NgayGiaoHang, GETDATE()) > 7; -- Đơn giao xong > 7 ngày

GO
```

## ✅ Checklist

- [x] Sửa enum `TrangThaiDonHang` trong `DonHang.java`
- [x] Cập nhật constructor mặc định
- [x] Sửa `DonHangDAO.countNewOrders()`
- [x] Sửa `DonHangDAO.mapStatus()`
- [x] Sửa `VendorController.getStatusDisplayName()`
- [x] Cập nhật `vendor/order-detail.jsp`
- [x] Cập nhật `admin/orders.jsp`
- [x] Cập nhật `admin/order-view.jsp`
- [x] Kiểm tra không có lỗi compile
- [x] Tạo tài liệu hướng dẫn

## 🎉 Kết luận

Đã hoàn thành sửa lại hệ thống đơn hàng với:
- ✅ 9 trạng thái rõ ràng, không trùng lặp
- ✅ Luồng xử lý đơn hàng đầy đủ từ đặt hàng đến hoàn thành
- ✅ Code đồng nhất giữa Java và JSP
- ✅ Dễ bảo trì và mở rộng

**Ngày hoàn thành**: 28/10/2025
