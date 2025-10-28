# KHẮC PHỤC LỖI ĐẶT HÀNG: "Không thể tạo đơn hàng. Vui lòng thử lại!"

## 🐛 Vấn đề

Khi khách hàng đặt hàng tại trang checkout, hệ thống báo lỗi:
```
"Không thể tạo đơn hàng. Vui lòng thử lại!"
```

## 🔍 Nguyên nhân

Lỗi xảy ra do cách persist entity `ChiTietDonHang` không đúng với **Composite Key** (khóa chính phức hợp).

### Chi tiết kỹ thuật:

1. **Entity `ChiTietDonHang` sử dụng Composite Key**:
   ```java
   @EmbeddedId
   private ChiTietDonHangPK id; // Composite key bao gồm MaDH + MaSP
   ```

2. **Vấn đề**: Khi tạo đơn hàng mới, `DonHang` chưa có `maDH` (chưa persist), nên không thể tạo `ChiTietDonHangPK` đúng cách.

3. **Cascade ALL** trong `DonHang.java`:
   ```java
   @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL)
   private List<ChiTietDonHang> chiTietDonHangs;
   ```
   
   JPA sẽ cố gắng persist cả `DonHang` và `ChiTietDonHang` cùng lúc, nhưng composite key chưa được khởi tạo đúng.

## ✅ Giải pháp

### Đã sửa trong `DonHangDAO.java` - method `insert()`:

```java
public boolean insert(DonHang donHang) {
    EntityManager em = getEntityManager();
    EntityTransaction tx = em.getTransaction();
    try {
        tx.begin();
        
        // BƯỚC 1: Lưu đơn hàng trước (không có chi tiết)
        List<ChiTietDonHang> chiTietList = donHang.getChiTietDonHangs();
        donHang.setChiTietDonHangs(null); // Tạm thời set null
        em.persist(donHang);
        em.flush(); // Flush để có maDH ngay lập tức
        
        // BƯỚC 2: Sau khi có maDH, tạo chi tiết đơn hàng
        if (chiTietList != null && !chiTietList.isEmpty()) {
            for (ChiTietDonHang detail : chiTietList) {
                // Khởi tạo lại composite key với maDH đã có
                ChiTietDonHangPK pk = new ChiTietDonHangPK();
                pk.setDonHang(donHang.getMaDH());
                pk.setSanPham(detail.getSanPham().getMaSP());
                detail.setId(pk);
                detail.setDonHang(donHang);
                
                em.persist(detail);
            }
            donHang.setChiTietDonHangs(chiTietList);
        }
        
        tx.commit();
        System.out.println("✅ Đơn hàng #" + donHang.getMaDH() + " được tạo thành công!");
        return true;
    } catch (Exception e) {
        if (tx.isActive()) {
            tx.rollback();
        }
        System.err.println("❌ Lỗi tạo đơn hàng: " + e.getMessage());
        e.printStackTrace();
        return false;
    } finally {
        em.close();
    }
}
```

## 📝 Các thay đổi đã thực hiện:

### 1. File: `DonHangDAO.java`
- ✅ Thêm import: `import com.uteshop.entity.ChiTietDonHangPK;`
- ✅ Sửa method `insert()` để:
  - Persist `DonHang` trước (không có chi tiết)
  - Flush để database generate `maDH`
  - Sau đó khởi tạo `ChiTietDonHangPK` với `maDH` đã có
  - Persist từng `ChiTietDonHang`
- ✅ Thêm logging để debug dễ hơn

### 2. File: `CheckoutController.java`
- ✅ Không cần thay đổi (giữ nguyên logic)
- Controller vẫn tạo `DonHang` với `ChiTietDonHang` như bình thường
- DAO sẽ xử lý việc persist đúng cách

## 🎯 Luồng hoạt động mới:

```
1. User click "Đặt hàng" tại trang checkout
   ↓
2. CheckoutController.placeOrder() được gọi
   ↓
3. Tạo DonHang với List<ChiTietDonHang>
   ↓
4. Gọi donHangDAO.insert(order)
   ↓
5. DAO persist DonHang trước → maDH được generate
   ↓
6. DAO tạo ChiTietDonHangPK với maDH + maSP
   ↓
7. DAO persist từng ChiTietDonHang
   ↓
8. Transaction commit
   ↓
9. Xóa sản phẩm khỏi giỏ hàng
   ↓
10. Redirect đến /user/orders?success=1
```

## 🧪 Test lại chức năng:

### Bước 1: Build project
```bash
cd "D:\HK I Year 3(first)\LTWeb\Project_CK_UTEShop_Nhom_17"
mvn clean package
```

### Bước 2: Deploy lên Tomcat
- Copy file `.war` từ `target/` sang thư mục deploy của Tomcat
- Hoặc deploy trực tiếp từ Eclipse/STS

### Bước 3: Test đặt hàng
1. Đăng nhập với tài khoản USER
2. Thêm sản phẩm vào giỏ hàng
3. Vào giỏ hàng → Click "Thanh toán"
4. Chọn địa chỉ giao hàng
5. Chọn phương thức thanh toán (COD/BANK_TRANSFER/MOMO)
6. Click "Đặt hàng"

### Kết quả mong đợi:
✅ Đơn hàng được tạo thành công
✅ Redirect về trang danh sách đơn hàng với thông báo thành công
✅ Sản phẩm bị xóa khỏi giỏ hàng
✅ Console log hiển thị: "✅ Đơn hàng #[số] được tạo thành công!"

## 🔧 Debug nếu vẫn lỗi:

### Kiểm tra Console Log:
Tìm các dòng log:
```
✅ Đơn hàng #123 được tạo thành công!
```
Hoặc
```
❌ Lỗi tạo đơn hàng: [chi tiết lỗi]
```

### Kiểm tra Database:
```sql
-- Kiểm tra đơn hàng mới nhất
SELECT TOP 5 * FROM DonHang ORDER BY MaDH DESC;

-- Kiểm tra chi tiết đơn hàng
SELECT * FROM ChiTietDonHang WHERE MaDH = [mã_đơn_hàng];
```

### Các lỗi có thể gặp:

1. **Lỗi Foreign Key**:
   - Kiểm tra `MaND` có tồn tại trong bảng `NguoiDung`
   - Kiểm tra `MaSP` có tồn tại trong bảng `SanPham`

2. **Lỗi Null Pointer**:
   - Đảm bảo `user` đã login
   - Đảm bảo giỏ hàng không rỗng
   - Đảm bảo đã chọn địa chỉ giao hàng

3. **Lỗi Constraint**:
   - Kiểm tra các trường NOT NULL
   - Kiểm tra độ dài VARCHAR
   - Kiểm tra định dạng DECIMAL

## 📊 Kiến trúc Composite Key trong JPA

### Composite Key Pattern:
```java
// Primary Key Class
@Embeddable
public class ChiTietDonHangPK {
    private Integer donHang;  // MaDH
    private Integer sanPham;  // MaSP
}

// Entity Class
@Entity
public class ChiTietDonHang {
    @EmbeddedId
    private ChiTietDonHangPK id;
    
    @MapsId("donHang")
    @ManyToOne
    private DonHang donHang;
    
    @MapsId("sanPham")
    @ManyToOne
    private SanPham sanPham;
}
```

### Lưu ý quan trọng:
1. **@EmbeddedId**: Sử dụng class riêng cho composite key
2. **@MapsId**: Map các field trong composite key với entity relationship
3. **Khởi tạo**: Phải khởi tạo composite key trước khi persist
4. **Foreign Key**: Cả 2 ID trong composite key phải đã tồn tại

## ✅ Checklist hoàn thành:

- [x] Phân tích nguyên nhân lỗi
- [x] Sửa method `insert()` trong `DonHangDAO.java`
- [x] Thêm import `ChiTietDonHangPK`
- [x] Thêm logging để debug
- [x] Kiểm tra không có lỗi compile
- [x] Viết tài liệu hướng dẫn

## 🎉 Kết luận

Lỗi đã được khắc phục! Chức năng đặt hàng bây giờ sẽ hoạt động bình thường.

Nguyên nhân chính: **JPA không thể tự động persist entity có composite key khi parent entity chưa có ID**. 

Giải pháp: **Persist theo 2 bước: DonHang trước, ChiTietDonHang sau**.
