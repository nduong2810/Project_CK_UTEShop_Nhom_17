<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<head>
    <title>Tin nhắn - UTESHOP</title>
    <style>
        
        .chat-container {
            height: 600px;
            max-width: 100%;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            display: flex;
        }
        
        /* Sidebar danh sách hội thoại */
        .chat-sidebar {
            width: 350px;
            border-right: 1px solid #e0e0e0;
            display: flex;
            flex-direction: column;
        }
        
        .chat-sidebar-header {
            padding: 20px;
            border-bottom: 1px solid #e0e0e0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .chat-sidebar-header h4 {
            margin: 0;
            font-size: 20px;
        }
        
        .chat-search {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .chat-search input {
            border-radius: 20px;
            padding: 8px 15px;
        }
        
        .conversation-list {
            flex: 1;
            overflow-y: auto;
        }
        
        .conversation-item {
            padding: 15px 20px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background 0.2s;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .conversation-item:hover {
            background: #f8f9fa;
        }
        
        .conversation-item.active {
            background: #e3f2fd;
            border-left: 4px solid #667eea;
        }
        
        .conversation-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 20px;
            flex-shrink: 0;
            position: relative;
        }
        
        .online-indicator {
            width: 12px;
            height: 12px;
            background: #4caf50;
            border: 2px solid white;
            border-radius: 50%;
            position: absolute;
            bottom: 2px;
            right: 2px;
        }
        
        .conversation-info {
            flex: 1;
            min-width: 0;
        }
        
        .conversation-name {
            font-weight: 600;
            margin-bottom: 4px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .conversation-last-message {
            font-size: 13px;
            color: #666;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .conversation-meta {
            text-align: right;
            flex-shrink: 0;
        }
        
        .conversation-time {
            font-size: 12px;
            color: #999;
            margin-bottom: 4px;
        }
        
        .unread-badge {
            background: #667eea;
            color: white;
            border-radius: 10px;
            padding: 2px 8px;
            font-size: 11px;
            font-weight: bold;
        }
        
        /* Khu vực chat */
        .chat-main {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .chat-header {
            padding: 20px;
            border-bottom: 1px solid #e0e0e0;
            background: white;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .chat-header-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
        }
        
        .chat-header-info {
            flex: 1;
        }
        
        .chat-header-name {
            font-weight: 600;
            margin-bottom: 2px;
        }
        
        .chat-header-status {
            font-size: 13px;
            color: #4caf50;
        }
        
        .chat-header-status.offline {
            color: #999;
        }
        
        .chat-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background: #f8f9fa;
        }
        
        .message-group {
            margin-bottom: 20px;
        }
        
        .message-date {
            text-align: center;
            margin: 20px 0;
        }
        
        .message-date span {
            background: white;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 12px;
            color: #666;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        
        .message {
            display: flex;
            margin-bottom: 12px;
            align-items: flex-end;
            gap: 8px;
        }
        
        .message.sent {
            flex-direction: row-reverse;
        }
        
        .message-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
            font-weight: bold;
            flex-shrink: 0;
        }
        
        .message-content {
            max-width: 60%;
        }
        
        .message-bubble {
            padding: 10px 15px;
            border-radius: 18px;
            word-wrap: break-word;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        
        .message.received .message-bubble {
            background: white;
            border-bottom-left-radius: 4px;
        }
        
        .message.sent .message-bubble {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-bottom-right-radius: 4px;
        }
        
        .message-time {
            font-size: 11px;
            color: #999;
            margin-top: 4px;
            padding: 0 5px;
        }
        
        .message.sent .message-time {
            text-align: right;
        }
        
        .typing-indicator {
            display: none;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            background: white;
            border-radius: 18px;
            width: fit-content;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        
        .typing-indicator.show {
            display: flex;
        }
        
        .typing-dot {
            width: 8px;
            height: 8px;
            background: #999;
            border-radius: 50%;
            animation: typing 1.4s infinite;
        }
        
        .typing-dot:nth-child(2) {
            animation-delay: 0.2s;
        }
        
        .typing-dot:nth-child(3) {
            animation-delay: 0.4s;
        }
        
        @keyframes typing {
            0%, 60%, 100% {
                transform: translateY(0);
            }
            30% {
                transform: translateY(-10px);
            }
        }
        
        .chat-input {
            padding: 20px;
            border-top: 1px solid #e0e0e0;
            background: white;
        }
        
        .chat-input-form {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .chat-input-field {
            flex: 1;
            border: 1px solid #e0e0e0;
            border-radius: 25px;
            padding: 12px 20px;
            resize: none;
            max-height: 100px;
        }
        
        .chat-input-actions {
            display: flex;
            gap: 5px;
        }
        
        .chat-input-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .chat-input-btn.attach {
            background: #f0f0f0;
            color: #666;
        }
        
        .chat-input-btn.attach:hover {
            background: #e0e0e0;
        }
        
        .chat-input-btn.send {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .chat-input-btn.send:hover {
            transform: scale(1.05);
        }
        
        .chat-input-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .empty-chat {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: #999;
        }
        
        .empty-chat i {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        /* Scrollbar */
        .conversation-list::-webkit-scrollbar,
        .chat-messages::-webkit-scrollbar {
            width: 6px;
        }
        
        .conversation-list::-webkit-scrollbar-track,
        .chat-messages::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        
        .conversation-list::-webkit-scrollbar-thumb,
        .chat-messages::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 3px;
        }
        
        .conversation-list::-webkit-scrollbar-thumb:hover,
        .chat-messages::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .chat-sidebar {
                width: 100%;
                display: none;
            }
            
            .chat-sidebar.show {
                display: flex;
            }
            
            .chat-main {
                display: none;
            }
            
            .chat-main.show {
                display: flex;
            }
        }
    </style>
</head>

<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4"><i class="fas fa-comments me-2"></i>Tin nhắn</h2>
        </div>
    </div>
    
    <div class="row">
        <div class="col-12">
            <div class="chat-container">
    <!-- Sidebar danh sách hội thoại -->
    <div class="chat-sidebar" id="chatSidebar">
        <div class="chat-sidebar-header">
            <h4><i class="fas fa-comments me-2"></i>Tin nhắn</h4>
        </div>
        
        <div class="chat-search">
            <input type="text" class="form-control" id="searchConversation" 
                   placeholder="Tìm kiếm hội thoại...">
        </div>
        
        <div class="conversation-list" id="conversationList">
            <c:choose>
                <c:when test="${empty conversations}">
                    <div class="text-center text-muted p-4">
                        <i class="fas fa-inbox fa-3x mb-3"></i>
                        <p>Chưa có hội thoại nào</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${conversations}" var="conv">
                        <div class="conversation-item" data-conversation-id="${conv.maHoiThoai}"
                             data-store-id="${conv.maCuaHang}" data-customer-id="${conv.maKhachHang}">
                            <div class="conversation-avatar">
                                <c:choose>
                                    <c:when test="${conv.maKhachHang == currentUser.maND}">
                                        ${conv.cuaHang.tenCH.substring(0,1).toUpperCase()}
                                    </c:when>
                                    <c:otherwise>
                                        ${conv.khachHang.hoTen.substring(0,1).toUpperCase()}
                                    </c:otherwise>
                                </c:choose>
                                <span class="online-indicator" style="display: none;"></span>
                            </div>
                            <div class="conversation-info">
                                <div class="conversation-name">
                                    <c:choose>
                                        <c:when test="${conv.maKhachHang == currentUser.maND}">
                                            ${conv.cuaHang.tenCH}
                                        </c:when>
                                        <c:otherwise>
                                            ${conv.khachHang.hoTen}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="conversation-last-message">
                                    ${conv.tinNhanCuoi != null ? conv.tinNhanCuoi : 'Chưa có tin nhắn'}
                                </div>
                            </div>
                            <div class="conversation-meta">
                                <div class="conversation-time">
                                    <fmt:formatDate value="${conv.ngayCapNhat}" pattern="HH:mm"/>
                                </div>
                                <c:if test="${conv.soTinNhanChuaDoc > 0}">
                                    <span class="unread-badge">${conv.soTinNhanChuaDoc}</span>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Khu vực chat chính -->
    <div class="chat-main" id="chatMain">
        <div id="chatHeader" class="chat-header" style="display: none;">
            <button class="btn btn-link d-md-none" id="backToList">
                <i class="fas fa-arrow-left"></i>
            </button>
            <div class="chat-header-avatar" id="chatHeaderAvatar"></div>
            <div class="chat-header-info">
                <div class="chat-header-name" id="chatHeaderName"></div>
            </div>
        </div>
        
        <div id="chatMessages" class="chat-messages">
            <div class="empty-chat">
                <i class="fas fa-comments"></i>
                <h5>Chọn một hội thoại để bắt đầu chat</h5>
                <p class="text-muted">Tin nhắn của bạn sẽ xuất hiện ở đây</p>
            </div>
        </div>
        
        <div id="chatInput" class="chat-input" style="display: none;">
            <form id="messageForm" class="chat-input-form">
                <textarea class="form-control chat-input-field" id="messageInput" 
                          placeholder="Nhập tin nhắn..." rows="1"></textarea>
                <div class="chat-input-actions">
                    <button type="button" class="chat-input-btn attach" title="Đính kèm file">
                        <i class="fas fa-paperclip"></i>
                    </button>
                    <button type="submit" class="chat-input-btn send" id="sendBtn">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
            </form>
        </div>
            </div>
        </div>
    </div>
</div>

<script>
    const currentUserId = ${not empty currentUser ? currentUser.maND : 0};
    const contextPath = '${pageContext.request.contextPath}';
    let ws = null;
    let currentConversationId = null;
    let currentChatPartner = null;
    let typingTimeout = null;
    
    // Kết nối WebSocket
    function connectWebSocket() {
        if (!currentUserId || currentUserId === 0) {
            console.log('User not logged in, skipping WebSocket connection');
            return;
        }
        
        const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const wsUrl = protocol + '//' + window.location.host + contextPath + '/chat/' + currentUserId;
        
        ws = new WebSocket(wsUrl);
        
        ws.onopen = function() {
            console.log('WebSocket connected');
        };
        
        ws.onmessage = function(event) {
            const response = JSON.parse(event.data);
            handleWebSocketMessage(response);
        };
        
        ws.onerror = function(error) {
            console.error('WebSocket error:', error);
        };
        
        ws.onclose = function() {
            console.log('WebSocket disconnected');
            // Thử kết nối lại sau 5 giây
            setTimeout(connectWebSocket, 5000);
        };
    }
    
    // Xử lý tin nhắn WebSocket
    function handleWebSocketMessage(response) {
        console.log('WebSocket message:', response);
        
        switch(response.type) {
            case 'connected':
                console.log('Connected to chat server');
                break;
            case 'newMessage':
                handleNewMessage(response.data);
                break;
            case 'messageSent':
                handleMessageSent(response.data);
                break;
            case 'typing':
                handleTyping(response.data);
                break;
            case 'markedAsRead':
                handleMarkedAsRead(response.data);
                break;
        }
    }
    
    // Xử lý tin nhắn mới
    function handleNewMessage(data) {
        // Cập nhật danh sách hội thoại với thông tin đầy đủ
        updateConversationList({
            conversationId: data.conversationId,
            content: data.content,
            senderId: data.senderId,
            timestamp: data.timestamp
        });
        
        // Nếu đang xem hội thoại này, hiển thị tin nhắn
        if (currentConversationId === data.conversationId) {
            appendMessage(data, false);
            scrollToBottom();
            
            // Đánh dấu đã đọc
            markAsRead(data.conversationId);
        } else {
            // Nếu không đang xem, phát âm thanh thông báo (optional)
            // playNotificationSound();
        }
    }
    
    // Xử lý tin nhắn đã gửi
    function handleMessageSent(data) {
        appendMessage(data, true);
        scrollToBottom();
        updateConversationList(data);
    }
    
    // Xử lý thông báo đang gõ
    function handleTyping(data) {
        if (currentConversationId === data.conversationId && data.isTyping) {
            showTypingIndicator();
            setTimeout(hideTypingIndicator, 3000);
        }
    }
    
    // Xử lý đã đọc
    function handleMarkedAsRead(data) {
        // Cập nhật UI nếu cần
    }
    
    // Gửi tin nhắn
    function sendMessage(content) {
        if (!ws || ws.readyState !== WebSocket.OPEN) {
            alert('Kết nối đã bị ngắt. Vui lòng tải lại trang.');
            return;
        }
        
        const message = {
            action: 'sendMessage',
            conversationId: currentConversationId,
            content: content,
            messageType: 'TEXT'
        };
        
        ws.send(JSON.stringify(message));
    }
    
    // Đánh dấu đã đọc
    function markAsRead(conversationId) {
        if (!ws || ws.readyState !== WebSocket.OPEN) return;
        
        const message = {
            action: 'markAsRead',
            conversationId: conversationId
        };
        
        ws.send(JSON.stringify(message));
    }
    
    // Gửi thông báo đang gõ
    function sendTypingIndicator(isTyping) {
        if (!ws || ws.readyState !== WebSocket.OPEN || !currentConversationId) return;
        
        const message = {
            action: 'typing',
            conversationId: currentConversationId,
            isTyping: isTyping
        };
        
        ws.send(JSON.stringify(message));
    }
    
    // Hiển thị tin nhắn
    function appendMessage(data, isSent) {
        const messagesContainer = document.getElementById('chatMessages');
        const messageDiv = document.createElement('div');
        messageDiv.className = 'message ' + (isSent ? 'sent' : 'received');
        
        const avatar = document.createElement('div');
        avatar.className = 'message-avatar';
        avatar.textContent = isSent ? '${currentUser.hoTen.substring(0,1).toUpperCase()}' : 
                             (currentChatPartner ? currentChatPartner.charAt(0).toUpperCase() : 'U');
        
        const contentDiv = document.createElement('div');
        contentDiv.className = 'message-content';
        
        const bubble = document.createElement('div');
        bubble.className = 'message-bubble';
        bubble.textContent = data.content;
        
        const time = document.createElement('div');
        time.className = 'message-time';
        time.textContent = new Date(data.timestamp).toLocaleTimeString('vi-VN', {hour: '2-digit', minute: '2-digit'});
        
        contentDiv.appendChild(bubble);
        contentDiv.appendChild(time);
        messageDiv.appendChild(avatar);
        messageDiv.appendChild(contentDiv);
        
        // Xóa empty state nếu có
        const emptyChat = messagesContainer.querySelector('.empty-chat');
        if (emptyChat) {
            emptyChat.remove();
        }
        
        messagesContainer.appendChild(messageDiv);
    }
    
    // Load tin nhắn của hội thoại
    function loadConversation(conversationId, partnerName) {
        currentConversationId = conversationId;
        currentChatPartner = partnerName;
        
        // Cập nhật header
        document.getElementById('chatHeader').style.display = 'flex';
        document.getElementById('chatHeaderAvatar').textContent = partnerName.charAt(0).toUpperCase();
        document.getElementById('chatHeaderName').textContent = partnerName;
        document.getElementById('chatInput').style.display = 'block';
        
        // Xóa badge số tin nhắn chưa đọc của hội thoại này
        const conversationItem = document.querySelector(`.conversation-item[data-conversation-id="${conversationId}"]`);
        if (conversationItem) {
            const badge = conversationItem.querySelector('.unread-badge');
            if (badge) {
                badge.remove();
            }
        }
        
        // Load tin nhắn
        fetch(contextPath + '/chat?action=getMessages&conversationId=' + conversationId)
            .then(response => response.json())
            .then(messages => {
                const messagesContainer = document.getElementById('chatMessages');
                messagesContainer.innerHTML = '';
                
                messages.forEach(msg => {
                    const isSent = msg.maNguoiGui === currentUserId;
                    appendMessage({
                        content: msg.noiDung,
                        timestamp: new Date(msg.ngayGui).getTime()
                    }, isSent);
                });
                
                scrollToBottom();
                
                // Đánh dấu đã đọc
                markAsRead(conversationId);
            })
            .catch(error => console.error('Error loading messages:', error));
    }
    
    // Cập nhật danh sách hội thoại
    function updateConversationList(data) {
        if (!data || !data.conversationId) return;
        
        // Tìm conversation item trong sidebar
        const conversationItem = document.querySelector(`.conversation-item[data-conversation-id="${data.conversationId}"]`);
        if (!conversationItem) return;
        
        // Cập nhật tin nhắn cuối cùng
        const lastMessageEl = conversationItem.querySelector('.conversation-last-message');
        if (lastMessageEl && data.content) {
            lastMessageEl.textContent = data.content.length > 50 ? data.content.substring(0, 50) + '...' : data.content;
        }
        
        // Cập nhật thời gian
        const timeEl = conversationItem.querySelector('.conversation-time');
        if (timeEl) {
            const now = new Date();
            timeEl.textContent = now.getHours().toString().padStart(2, '0') + ':' + now.getMinutes().toString().padStart(2, '0');
        }
        
        // Cập nhật badge số tin nhắn chưa đọc
        // Chỉ tăng badge nếu không đang xem hội thoại này
        if (currentConversationId !== data.conversationId && data.senderId !== currentUserId) {
            const metaEl = conversationItem.querySelector('.conversation-meta');
            if (metaEl) {
                let badge = metaEl.querySelector('.unread-badge');
                if (!badge) {
                    // Tạo badge mới nếu chưa có
                    badge = document.createElement('span');
                    badge.className = 'unread-badge';
                    badge.textContent = '1';
                    metaEl.appendChild(badge);
                } else {
                    // Tăng số lượng
                    const currentCount = parseInt(badge.textContent) || 0;
                    badge.textContent = currentCount + 1;
                }
            }
        } else if (currentConversationId === data.conversationId) {
            // Nếu đang xem hội thoại này, xóa badge
            const badge = conversationItem.querySelector('.unread-badge');
            if (badge) {
                badge.remove();
            }
        }
        
        // Di chuyển conversation lên đầu danh sách
        const conversationList = document.getElementById('conversationList');
        if (conversationList && conversationItem.parentNode === conversationList) {
            conversationList.prepend(conversationItem);
        }
    }
    
    // Scroll xuống cuối
    function scrollToBottom() {
        const messagesContainer = document.getElementById('chatMessages');
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
    
    // Hiển thị typing indicator
    function showTypingIndicator() {
        // TODO: Implement typing indicator
    }
    
    // Ẩn typing indicator
    function hideTypingIndicator() {
        // TODO: Implement hide typing indicator
    }
    
    // Event listeners
    document.addEventListener('DOMContentLoaded', function() {
        // Kết nối WebSocket
        connectWebSocket();
        
        // Click vào conversation
        document.querySelectorAll('.conversation-item').forEach(item => {
            item.addEventListener('click', function() {
                const conversationId = this.getAttribute('data-conversation-id');
                const partnerName = this.querySelector('.conversation-name').textContent.trim();
                
                // Remove active class from all items
                document.querySelectorAll('.conversation-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
                
                // Load conversation
                loadConversation(conversationId, partnerName);
                
                // Show chat main on mobile
                document.getElementById('chatSidebar').classList.remove('show');
                document.getElementById('chatMain').classList.add('show');
            });
        });
        
        // Submit message form
        document.getElementById('messageForm')?.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const input = document.getElementById('messageInput');
            const content = input.value.trim();
            
            if (content && currentConversationId) {
                sendMessage(content);
                input.value = '';
                input.style.height = 'auto';
            }
        });
        
        // Auto-resize textarea
        document.getElementById('messageInput')?.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
            
            // Send typing indicator
            clearTimeout(typingTimeout);
            sendTypingIndicator(true);
            typingTimeout = setTimeout(() => sendTypingIndicator(false), 1000);
        });
        
        // Back to list on mobile
        document.getElementById('backToList')?.addEventListener('click', function() {
            document.getElementById('chatMain').classList.remove('show');
            document.getElementById('chatSidebar').classList.add('show');
        });
        
        // Search conversation
        document.getElementById('searchConversation')?.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            document.querySelectorAll('.conversation-item').forEach(item => {
                const name = item.querySelector('.conversation-name').textContent.toLowerCase();
                item.style.display = name.includes(searchTerm) ? 'flex' : 'none';
            });
        });
    });
</script>
