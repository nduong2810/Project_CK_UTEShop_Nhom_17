# 🐛 KHẮC PHỤC LỖI: NÚT "XEM MÃ GIẢM GIÁ" KHÔNG HOẠT ĐỘNG

## 📋 Vấn đề

Trên trang `/user/checkout`, nút **"Xem mã giảm giá (X)"** không mở panel chọn mã giảm giá khi click.

---

## ✅ ĐÃ KHẮC PHỤC

Tôi đã thêm **debug logging** vào hàm `toggleDiscountPanel()` để theo dõi hoạt động.

### Các log sẽ hiển thị trong Console (F12):

- 🎁 `toggleDiscountPanel called - storeId: X`
- 📦 `Panel element: <div>` hoặc `null`
- 👀 `Current display: none` hoặc `block`
- ✅ `Panel opened` hoặc `Panel closed`
- ❌ `Panel not found!` (nếu có lỗi)

---

## 🧪 CÁCH TEST

### **BƯỚC 1: Khởi động lại Tomcat server**

### **BƯỚC 2: Vào trang checkout**
```
http://localhost:8080/Project_CK_UTESHOP-1.1/user/checkout
```

### **BƯỚC 3: Mở Console**
- Nhấn **F12** → Tab **Console**

### **BƯỚC 4: Click nút "Xem mã giảm giá"**

Quan sát console log:

#### ✅ **Nếu thấy log:**
```
🎁 toggleDiscountPanel called - storeId: 1
📦 Panel element: [object HTMLDivElement]
👀 Current display: none
✅ Panel opened
```
→ **Hàm hoạt động!** Panel đã mở.

#### ❌ **Nếu KHÔNG thấy log nào:**
→ **Vấn đề:** Event `onclick` không được kích hoạt.

**Nguyên nhân có thể:**
1. JavaScript bị lỗi ở đâu đó trước hàm này
2. Nút bị che bởi element khác (z-index)
3. Event listener bị conflict

#### ❌ **Nếu thấy log "Panel not found":**
→ **Vấn đề:** ID không khớp giữa button và panel.

---

## 🔍 KIỂM TRA THÊM

### 1. **Kiểm tra có mã giảm giá không:**

Nút chỉ hiển thị khi có mã giảm giá. Trong console, gõ:
```javascript
console.log(${storeDiscounts});
```

Nếu `null` hoặc `{}` → **Không có mã giảm giá** → Nút không hiển thị.

### 2. **Kiểm tra element có bị ẩn không:**

Trong Console, gõ:
```javascript
document.getElementById('discountPanel-1')
```

Nếu trả về `null` → **Panel không tồn tại trong DOM**.

### 3. **Kiểm tra CSS:**

```javascript
const panel = document.getElementById('discountPanel-1');
console.log(window.getComputedStyle(panel).display);
```

Nếu `"none"` → Panel bị ẩn (bình thường).
Nếu `"block"` → Panel đã mở nhưng có thể bị CSS khác che.

---

## 🛠️ GIẢI PHÁP DỰ PHÒNG

Nếu vẫn không hoạt động sau khi test, thử các cách sau:

### **Cách 1: Thêm `!important` vào CSS**

```css
.discount-panel {
    display: block !important; /* Test xem panel có hiển thị không */
}
```

### **Cách 2: Dùng jQuery thay vì vanilla JS**

Thay hàm `toggleDiscountPanel()`:
```javascript
function toggleDiscountPanel(storeId) {
    $('#discountPanel-' + storeId).slideToggle(300);
}
```

### **Cách 3: Kiểm tra event bubbling**

Thêm `event.stopPropagation()`:
```html
<button onclick="event.stopPropagation(); toggleDiscountPanel(${storeEntry.key.maCH})">
```

---

## 📝 CHECKLIST

- [ ] Khởi động lại server
- [ ] Mở Console (F12)
- [ ] Vào trang checkout
- [ ] Click "Xem mã giảm giá"
- [ ] Kiểm tra log trong Console
- [ ] Chụp screenshot log và gửi cho tôi nếu vẫn lỗi

---

## 🎯 KẾT QUẢ MONG ĐỢI

Sau khi click nút "Xem mã giảm giá":
1. ✅ Console hiển thị log debug
2. ✅ Panel mã giảm giá **hiện ra** với animation
3. ✅ Hiển thị danh sách mã giảm giá với checkbox
4. ✅ Click lại nút → Panel **đóng lại**

---

## 📸 GỬI CHO TÔI

Nếu vẫn lỗi, hãy gửi cho tôi:
1. **Screenshot Console** (toàn bộ log)
2. **Screenshot trang checkout** (có nút "Xem mã giảm giá")
3. **Mô tả:** Click có phản ứng gì không? (không có gì xảy ra, panel nhấp nháy, lỗi đỏ trong console, v.v.)

---

**🚀 Hãy test ngay và báo kết quả cho tôi!**
