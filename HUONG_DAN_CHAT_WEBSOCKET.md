# HƯỚNG DẪN TÍNH NĂNG CHAT WEBSOCKET - UTESHOP

## 📋 Tổng quan

Tính năng chat real-time giữa khách hàng và cửa hàng sử dụng WebSocket để giao tiếp tức thời.

## 🏗️ Kiến trúc hệ thống

### 1. Cơ sở dữ liệu

**Bảng HoiThoai (Conversations)**
- Lưu thông tin các cuộc hội thoại giữa khách hàng và cửa hàng
- Mỗi cặp khách hàng-cửa hàng chỉ có 1 hội thoại duy nhất

**Bảng TinNhan (Messages)**
- Lưu nội dung tin nhắn
- Hỗ trợ text, hình ảnh, và file đính kèm
- Theo dõi trạng thái đã đọc/chưa đọc

### 2. Backend Components

**Entity Classes:**
- `HoiThoai.java` - Entity cho hội thoại
- `TinNhan.java` - Entity cho tin nhắn

**DAO Classes:**
- `HoiThoaiDAO.java` - Xử lý CRUD hội thoại
- `TinNhanDAO.java` - Xử lý CRUD tin nhắn

**WebSocket:**
- `ChatWebSocket.java` - WebSocket endpoint xử lý real-time messaging

**Controller:**
- `ChatController.java` - Servlet xử lý HTTP requests

### 3. Frontend Components

**JSP Views:**
- `chat-panel.jsp` - Giao diện chat chính
- `chat-float-button.jsp` - Nút chat floating

## 📦 Cài đặt

### Bước 1: Cập nhật Dependencies

Dependencies đã được thêm vào `pom.xml`:
```xml
<!-- Java-WebSocket -->
<dependency>
    <groupId>org.java-websocket</groupId>
    <artifactId>Java-WebSocket</artifactId>
    <version>1.5.3</version>
</dependency>

<!-- Jakarta WebSocket API -->
<dependency>
    <groupId>jakarta.websocket</groupId>
    <artifactId>jakarta.websocket-api</artifactId>
    <version>2.1.1</version>
    <scope>provided</scope>
</dependency>
```

### Bước 2: Tạo bảng database

Chạy file SQL: `create_chat_tables.sql`

```sql
-- Tạo bảng HoiThoai và TinNhan
-- File này đã được tạo sẵn trong thư mục root
```

### Bước 3: Build project

```bash
mvn clean install
```

### Bước 4: Deploy lên Tomcat

Deploy file WAR lên Tomcat server

## 🎯 Cách sử dụng

### 1. Tích hợp nút chat vào trang sản phẩm/cửa hàng

Thêm vào file JSP:

```jsp
<!-- Trong trang chi tiết sản phẩm hoặc trang cửa hàng -->
<jsp:include page="/WEB-INF/views/components/chat-float-button.jsp">
    <jsp:param name="storeId" value="${product.maCH}" />
</jsp:include>
```

### 2. Thêm menu "Tin nhắn" vào User Profile

Thêm vào dropdown menu của user:

```jsp
<a href="${pageContext.request.contextPath}/chat" class="dropdown-item">
    <i class="fas fa-comments me-2"></i>Tin nhắn
    <span class="badge bg-danger" id="totalUnreadBadge" style="display: none;">0</span>
</a>
```

### 3. Kết nối WebSocket từ Client

```javascript
// WebSocket URL
const wsUrl = 'ws://localhost:8080/yourapp/chat/' + userId;
const ws = new WebSocket(wsUrl);

// Xử lý kết nối
ws.onopen = function() {
    console.log('Connected to chat');
};

// Nhận tin nhắn
ws.onmessage = function(event) {
    const message = JSON.parse(event.data);
    handleMessage(message);
};

// Gửi tin nhắn
function sendMessage(conversationId, content) {
    ws.send(JSON.stringify({
        action: 'sendMessage',
        conversationId: conversationId,
        content: content,
        messageType: 'TEXT'
    }));
}
```

## 🔧 API Endpoints

### HTTP Endpoints

**GET /chat**
- Hiển thị trang chat panel với danh sách hội thoại

**GET /chat?action=getConversations**
- Lấy danh sách hội thoại của user hiện tại
- Response: JSON array của conversations

**GET /chat?action=getMessages&conversationId={id}**
- Lấy tin nhắn của một hội thoại
- Response: JSON array của messages

**GET /chat?action=startChat&storeId={id}**
- Tạo hoặc lấy hội thoại với cửa hàng
- Response: `{"success": true, "conversationId": 123}`

### WebSocket Messages

**Gửi tin nhắn:**
```json
{
    "action": "sendMessage",
    "conversationId": 1,
    "content": "Xin chào!",
    "messageType": "TEXT"
}
```

**Đánh dấu đã đọc:**
```json
{
    "action": "markAsRead",
    "conversationId": 1
}
```

**Thông báo đang gõ:**
```json
{
    "action": "typing",
    "conversationId": 1,
    "isTyping": true
}
```

## 🎨 Giao diện

### Chat Panel
- **Sidebar bên trái**: Danh sách hội thoại
  - Hiển thị avatar
  - Tên người chat
  - Tin nhắn cuối cùng
  - Thời gian
  - Badge số tin nhắn chưa đọc
  
- **Khu vực chat chính**: 
  - Header với thông tin người chat
  - Khu vực hiển thị tin nhắn
  - Input box để nhập tin nhắn
  - Nút gửi và đính kèm file

### Features
- ✅ Real-time messaging
- ✅ Đánh dấu đã đọc/chưa đọc
- ✅ Hiển thị online/offline status
- ✅ Typing indicator
- ✅ Search conversations
- ✅ Responsive design (Mobile-friendly)
- ✅ Badge hiển thị số tin nhắn chưa đọc

## 🚀 Tính năng nâng cao (Có thể mở rộng)

### 1. Upload file/hình ảnh
- Thêm servlet xử lý upload file
- Cập nhật `LoaiTinNhan` và `DuongDanFile`

### 2. Notification
- Tích hợp Web Push Notification
- Email notification cho tin nhắn mới

### 3. Chat history pagination
- Load lazy tin nhắn cũ khi scroll lên

### 4. Emoji picker
- Thêm emoji selector vào input box

### 5. Message status
- Đã gửi / Đã nhận / Đã đọc (với timestamp)

## 🐛 Troubleshooting

### Lỗi WebSocket không kết nối được

**Nguyên nhân**: Tomcat chưa bật WebSocket support

**Giải pháp**: 
- Đảm bảo sử dụng Tomcat 10.1+
- Kiểm tra file `web.xml` có đầy đủ configuration

### Lỗi "Session cannot be resolved"

**Nguyên nhân**: Thiếu Jakarta WebSocket API dependency

**Giải pháp**:
```bash
mvn clean install -U
```

### Tin nhắn không real-time

**Nguyên nhân**: WebSocket connection bị disconnect

**Giải pháp**: 
- Kiểm tra browser console
- Implement reconnection logic
- Kiểm tra firewall/proxy settings

## 📱 Mobile Responsive

Chat panel tự động responsive:
- Desktop: Sidebar + Chat side by side
- Mobile: Toggle giữa sidebar và chat view

## 🔒 Bảo mật

1. **Authentication**: Chỉ user đã login mới chat được
2. **Authorization**: Kiểm tra quyền truy cập hội thoại
3. **XSS Prevention**: Escape HTML trong tin nhắn
4. **Rate Limiting**: Giới hạn số tin nhắn/phút (có thể thêm)

## 📊 Database Indexes

Đã tạo indexes để tăng performance:
- `IDX_HoiThoai_MaKhachHang`
- `IDX_HoiThoai_MaCuaHang`
- `IDX_HoiThoai_NgayCapNhat`
- `IDX_TinNhan_MaHoiThoai`
- `IDX_TinNhan_NgayGui`
- `IDX_TinNhan_DaDoc`

## 📝 TODO / Improvements

- [ ] Thêm upload hình ảnh
- [ ] Message reactions (like, love, etc.)
- [ ] Delete message
- [ ] Edit message
- [ ] Forward message
- [ ] Group chat
- [ ] Video call integration
- [ ] Voice message
- [ ] Message search
- [ ] Export chat history

## 💡 Tips

1. **Performance**: Sử dụng pagination khi load tin nhắn
2. **UX**: Tự động scroll xuống cuối khi có tin nhắn mới
3. **Notification**: Phát âm thanh khi có tin nhắn mới
4. **Cache**: Cache danh sách hội thoại ở client

## 📞 Support

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra console log (browser + server)
2. Xem file log của Tomcat
3. Kiểm tra database có data đúng không

---

**Developed by**: UTEShop Team
**Version**: 1.0
**Last Updated**: October 2025
