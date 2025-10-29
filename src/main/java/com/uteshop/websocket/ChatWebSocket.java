package com.uteshop.websocket;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.uteshop.dao.HoiThoaiDAO;
import com.uteshop.dao.TinNhanDAO;
import com.uteshop.entity.HoiThoai;
import com.uteshop.entity.TinNhan;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * WebSocket endpoint cho tính năng chat
 */
@ServerEndpoint("/chat/{userId}")
public class ChatWebSocket {
    
    // Lưu trữ các session đang hoạt động
    private static Map<Integer, Session> userSessions = new ConcurrentHashMap<>();
    
    private static Gson gson = new Gson();
    private static HoiThoaiDAO hoiThoaiDAO = new HoiThoaiDAO();
    private static TinNhanDAO tinNhanDAO = new TinNhanDAO();
    
    /**
     * Được gọi khi có kết nối mới
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("userId") Integer userId) {
        userSessions.put(userId, session);
        System.out.println("User " + userId + " connected to chat");
        
        // Gửi thông báo kết nối thành công
        sendMessage(session, createResponse("connected", "Connected successfully", null));
    }
    
    /**
     * Được gọi khi nhận tin nhắn
     */
    @OnMessage
    public void onMessage(String message, Session session, @PathParam("userId") Integer userId) {
        try {
            JsonObject jsonMessage = gson.fromJson(message, JsonObject.class);
            String action = jsonMessage.get("action").getAsString();
            
            switch (action) {
                case "sendMessage":
                    handleSendMessage(jsonMessage, userId);
                    break;
                case "markAsRead":
                    handleMarkAsRead(jsonMessage, userId);
                    break;
                case "typing":
                    handleTyping(jsonMessage, userId);
                    break;
                default:
                    System.out.println("Unknown action: " + action);
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendMessage(session, createResponse("error", "Error processing message", null));
        }
    }
    
    /**
     * Xử lý gửi tin nhắn
     */
    private void handleSendMessage(JsonObject jsonMessage, Integer senderId) {
        try {
            Integer conversationId = jsonMessage.get("conversationId").getAsInt();
            String content = jsonMessage.get("content").getAsString();
            String messageType = jsonMessage.has("messageType") ? 
                jsonMessage.get("messageType").getAsString() : "TEXT";
            
            // Lưu tin nhắn vào database
            TinNhan tinNhan = new TinNhan();
            tinNhan.setMaHoiThoai(conversationId);
            tinNhan.setMaNguoiGui(senderId);
            tinNhan.setNoiDung(content);
            tinNhan.setNgayGui(new Date());
            tinNhan.setLoaiTinNhan(messageType);
            tinNhan.setDaDoc(false);
            
            tinNhan = tinNhanDAO.saveMessage(tinNhan);
            
            if (tinNhan != null) {
                // Cập nhật tin nhắn cuối trong hội thoại
                hoiThoaiDAO.updateLastMessage(conversationId, content, senderId);
                
                // Lấy thông tin hội thoại để tìm người nhận
                HoiThoai hoiThoai = hoiThoaiDAO.getConversationById(conversationId);
                if (hoiThoai != null) {
                    Integer receiverId = hoiThoai.getMaKhachHang().equals(senderId) ? 
                        hoiThoai.getCuaHang().getMaND() : hoiThoai.getMaKhachHang();
                    
                    // Tăng số tin nhắn chưa đọc
                    hoiThoaiDAO.incrementUnreadCount(conversationId);
                    
                    // Tạo JSON response
                    JsonObject messageData = new JsonObject();
                    messageData.addProperty("messageId", tinNhan.getMaTinNhan());
                    messageData.addProperty("conversationId", conversationId);
                    messageData.addProperty("senderId", senderId);
                    messageData.addProperty("content", content);
                    messageData.addProperty("messageType", messageType);
                    messageData.addProperty("timestamp", tinNhan.getNgayGui().getTime());
                    
                    // Gửi cho người gửi
                    Session senderSession = userSessions.get(senderId);
                    if (senderSession != null && senderSession.isOpen()) {
                        sendMessage(senderSession, createResponse("messageSent", "Message sent", messageData));
                    }
                    
                    // Gửi cho người nhận
                    Session receiverSession = userSessions.get(receiverId);
                    if (receiverSession != null && receiverSession.isOpen()) {
                        sendMessage(receiverSession, createResponse("newMessage", "New message received", messageData));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Xử lý đánh dấu đã đọc
     */
    private void handleMarkAsRead(JsonObject jsonMessage, Integer userId) {
        try {
            Integer conversationId = jsonMessage.get("conversationId").getAsInt();
            
            // Đánh dấu tất cả tin nhắn của hội thoại đã đọc
            tinNhanDAO.markAllAsRead(conversationId, userId);
            
            // Reset số tin nhắn chưa đọc
            hoiThoaiDAO.resetUnreadCount(conversationId);
            
            // Gửi xác nhận
            Session session = userSessions.get(userId);
            if (session != null && session.isOpen()) {
                JsonObject data = new JsonObject();
                data.addProperty("conversationId", conversationId);
                sendMessage(session, createResponse("markedAsRead", "Messages marked as read", data));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Xử lý thông báo đang gõ
     */
    private void handleTyping(JsonObject jsonMessage, Integer userId) {
        try {
            Integer conversationId = jsonMessage.get("conversationId").getAsInt();
            boolean isTyping = jsonMessage.get("isTyping").getAsBoolean();
            
            // Lấy thông tin hội thoại để tìm người nhận
            HoiThoai hoiThoai = hoiThoaiDAO.getConversationById(conversationId);
            if (hoiThoai != null) {
                Integer receiverId = hoiThoai.getMaKhachHang().equals(userId) ? 
                    hoiThoai.getCuaHang().getMaND() : hoiThoai.getMaKhachHang();
                
                // Gửi thông báo cho người nhận
                Session receiverSession = userSessions.get(receiverId);
                if (receiverSession != null && receiverSession.isOpen()) {
                    JsonObject data = new JsonObject();
                    data.addProperty("conversationId", conversationId);
                    data.addProperty("userId", userId);
                    data.addProperty("isTyping", isTyping);
                    sendMessage(receiverSession, createResponse("typing", "User is typing", data));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Được gọi khi có lỗi
     */
    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket error: " + throwable.getMessage());
        throwable.printStackTrace();
    }
    
    /**
     * Được gọi khi đóng kết nối
     */
    @OnClose
    public void onClose(Session session, @PathParam("userId") Integer userId) {
        userSessions.remove(userId);
        System.out.println("User " + userId + " disconnected from chat");
    }
    
    /**
     * Gửi tin nhắn đến session
     */
    private void sendMessage(Session session, String message) {
        try {
            if (session != null && session.isOpen()) {
                session.getBasicRemote().sendText(message);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Tạo JSON response
     */
    private String createResponse(String type, String message, JsonObject data) {
        JsonObject response = new JsonObject();
        response.addProperty("type", type);
        response.addProperty("message", message);
        response.addProperty("timestamp", System.currentTimeMillis());
        if (data != null) {
            response.add("data", data);
        }
        return gson.toJson(response);
    }
    
    /**
     * Kiểm tra user có đang online không
     */
    public static boolean isUserOnline(Integer userId) {
        Session session = userSessions.get(userId);
        return session != null && session.isOpen();
    }
}
