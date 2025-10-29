# FIX LỖI WEBSOCKET - UTESHOP CHAT

## ❌ Lỗi gặp phải:
```
Session cannot be resolved to a type
OnOpen cannot be resolved to a type
OnMessage cannot be resolved to a type
OnError cannot be resolved to a type
OnClose cannot be resolved to a type
```

## ✅ Nguyên nhân:
Jakarta WebSocket API có scope="provided" trong pom.xml, nên Eclipse không thể compile được.

## 🔧 Cách fix (ĐÃ THỰC HIỆN):

### 1. Đã cập nhật pom.xml
Loại bỏ scope="provided" và thêm Jakarta WebSocket Client API:

```xml
<!-- Jakarta WebSocket API -->
<dependency>
    <groupId>jakarta.websocket</groupId>
    <artifactId>jakarta.websocket-api</artifactId>
    <version>2.1.1</version>
</dependency>

<!-- Jakarta WebSocket Client API -->
<dependency>
    <groupId>jakarta.websocket</groupId>
    <artifactId>jakarta.websocket-client-api</artifactId>
    <version>2.1.1</version>
</dependency>
```

### 2. Đã cập nhật persistence.xml
Thêm entity mới vào persistence unit:
```xml
<class>com.uteshop.entity.HoiThoai</class>
<class>com.uteshop.entity.TinNhan</class>
```

## 📝 Các bước tiếp theo bạn cần làm:

### Bước 1: Update Maven Project trong Eclipse
```
1. Right-click vào project "Project_CK_UTESHOP_Nhom_17"
2. Chọn "Maven" → "Update Project..."
3. Check "Force Update of Snapshots/Releases"
4. Click "OK"
```

### Bước 2: Clean và Build lại project
```
1. Project → Clean...
2. Chọn project của bạn
3. Click "OK"
```

### Bước 3: Nếu vẫn còn lỗi, Refresh project
```
1. Right-click vào project
2. Chọn "Refresh" (hoặc F5)
```

### Bước 4: Restart Eclipse (nếu cần)
Nếu sau các bước trên vẫn còn lỗi:
```
1. File → Restart
2. Chờ Eclipse khởi động lại
```

## ⚡ Cách fix nhanh bằng Terminal (Alternative):

Mở Terminal trong Eclipse và chạy:
```bash
cd "D:\HK I Year 3(first)\LTWeb\Project_CK_UTEShop_Nhom_17"
mvn clean compile
```

## 🎯 Kiểm tra sau khi fix:

1. **Không còn lỗi đỏ** trong ChatWebSocket.java
2. **Dependencies đã được tải**: 
   - Mở `pom.xml` → tab "Dependency Hierarchy"
   - Tìm `jakarta.websocket-api` - phải thấy version 2.1.1
3. **Entities đã được register**: 
   - Check file `persistence.xml` có HoiThoai và TinNhan

## 🐛 Nếu vẫn còn lỗi:

### Option 1: Xóa .m2 cache và tải lại
```bash
# Xóa thư mục .m2/repository/jakarta/websocket
# Sau đó chạy lại:
mvn clean install -U
```

### Option 2: Kiểm tra Tomcat trong Eclipse
```
1. Window → Preferences
2. Server → Runtime Environments
3. Đảm bảo có "Apache Tomcat v10.1"
4. Nếu chưa có, thêm mới
```

### Option 3: Build Path
```
1. Right-click project → Properties
2. Java Build Path → Libraries
3. Kiểm tra có "Maven Dependencies"
4. Kiểm tra có "Apache Tomcat v10.1" (Server Runtime)
```

## ✨ Sau khi fix xong:

1. **Chạy file SQL**: `create_chat_tables.sql` để tạo bảng
2. **Deploy project** lên Tomcat
3. **Test WebSocket**: Truy cập `/chat` để test

## 📞 Nếu vẫn gặp vấn đề:

Gửi cho tôi:
1. Screenshot của lỗi trong Eclipse
2. Nội dung file `pom.xml` (phần dependencies)
3. Console log khi chạy Maven

---
**Note**: Lỗi này rất phổ biến khi làm việc với WebSocket trong Eclipse. 
Sau khi update Maven project, Eclipse sẽ tự động tải về các dependencies cần thiết.
