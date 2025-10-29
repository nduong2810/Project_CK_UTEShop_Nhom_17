<!-- Chat Floating Button Component -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .chat-float-button {
        position: fixed;
        bottom: 100px;
        right: 30px;
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 24px;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        z-index: 1000;
        transition: all 0.3s ease;
        text-decoration: none;
    }
    
    .chat-float-button:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
    }
    
    .chat-float-button .badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background: #ff4444;
        color: white;
        border-radius: 10px;
        padding: 3px 7px;
        font-size: 11px;
        font-weight: bold;
        min-width: 20px;
        text-align: center;
    }
    
    .chat-float-tooltip {
        position: absolute;
        right: 70px;
        top: 50%;
        transform: translateY(-50%);
        background: #333;
        color: white;
        padding: 8px 12px;
        border-radius: 5px;
        white-space: nowrap;
        font-size: 14px;
        opacity: 0;
        pointer-events: none;
        transition: opacity 0.3s;
    }
    
    .chat-float-button:hover .chat-float-tooltip {
        opacity: 1;
    }
    
    .chat-float-tooltip::after {
        content: '';
        position: absolute;
        right: -5px;
        top: 50%;
        transform: translateY(-50%);
        border-left: 5px solid #333;
        border-top: 5px solid transparent;
        border-bottom: 5px solid transparent;
    }
</style>

<c:if test="${not empty sessionScope.user}">
    <c:choose>
        <c:when test="${not empty param.storeId}">
            <a href="javascript:void(0);" class="chat-float-button" id="chatFloatButton" onclick="openChatWithStore(${param.storeId})">
                <i class="fas fa-comments"></i>
                <span class="chat-float-tooltip">Chat với cửa hàng</span>
                <span class="badge" id="unreadCount" style="display: none;">0</span>
            </a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/chat" class="chat-float-button">
                <i class="fas fa-comments"></i>
                <span class="chat-float-tooltip">Tin nhắn</span>
                <span class="badge" id="unreadCount" style="display: none;">0</span>
            </a>
        </c:otherwise>
    </c:choose>
</c:if>

<script>
    function openChatWithStore(storeId) {
        // Bắt đầu chat với cửa hàng cụ thể
        fetch('${pageContext.request.contextPath}/chat?action=startChat&storeId=' + storeId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    window.location.href = '${pageContext.request.contextPath}/chat';
                } else {
                    alert('Không thể mở chat. Vui lòng thử lại!');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                // Nếu có lỗi, vẫn chuyển đến trang chat
                window.location.href = '${pageContext.request.contextPath}/chat';
            });
    }
    
    // Cập nhật số tin nhắn chưa đọc (sẽ được gọi qua WebSocket)
    function updateUnreadCount(count) {
        const badge = document.getElementById('unreadCount');
        if (badge) {
            if (count > 0) {
                badge.textContent = count > 99 ? '99+' : count;
                badge.style.display = 'block';
            } else {
                badge.style.display = 'none';
            }
        }
    }
</script>
