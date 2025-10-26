<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
// Simulate backend data for orders
java.util.List<Object> orders = new java.util.ArrayList<>();
java.util.Map<String, Object> order1 = new java.util.HashMap<>();
order1.put("orderId", "DH001");
order1.put("shopName", "Gumivn Official");
order1.put("status", "waiting");
order1.put("productName", "[KID] Thùng 10 gói khăn ướt Gumi không cồn, không parabens cao cấp cho em bé");
order1.put("productImage", "https://down-vn.img.susercontent.com/file/sg-11134201-22100-6cvx97sfjhiv34");
order1.put("productType", "Thùng 5 KID");
order1.put("quantity", 1);
order1.put("originalPrice", 167000);
order1.put("discountedPrice", 104800);
order1.put("totalPrice", 74800);

java.util.Map<String, Object> order2 = new java.util.HashMap<>();
order2.put("orderId", "DH002");
order2.put("shopName", "Gia Dụng Linh Quyết");
order2.put("status", "done");
order2.put("productName", "Hộp cơm giữ nhiệt văn phòng 3 tầng kèm túi, quay được lò vi sóng");
order2.put("productImage", "https://down-vn.img.susercontent.com/file/sg-11134201-22110-wv1ay2s0p3hv34");
order2.put("productType", "3 TẦNG");
order2.put("quantity", 1);
order2.put("originalPrice", 170000);
order2.put("discountedPrice", 99000);
order2.put("totalPrice", 84000);

java.util.Map<String, Object> order3 = new java.util.HashMap<>();
order3.put("orderId", "DH003");
order3.put("shopName", "Shop Đồ Gia Dụng Việt");
order3.put("status", "confirm");
order3.put("productName", "Bình giữ nhiệt inox cao cấp, nắp gỗ 500ml sang trọng");
order3.put("productImage", "https://down-vn.img.susercontent.com/file/sg-11134201-22100-83vxw1sfe2iv34");
order3.put("productType", "Màu bạc");
order3.put("quantity", 1);
order3.put("originalPrice", 250000);
order3.put("discountedPrice", 189000);
order3.put("totalPrice", 189000);

orders.add(order1);
orders.add(order2);
orders.add(order3);

pageContext.setAttribute("orders", orders);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<div class="orders-container">
    <!-- Breadcrumbs -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/guest/home'/>">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Đơn Hàng Của Tôi</li>
        </ol>
    </nav>

    <!-- Tabs -->
    <div class="orders-tabs" id="orderTabs">
        <a class="tab-item active" data-tab="all">Tất cả</a>
        <a class="tab-item" data-tab="confirm">Chờ xác nhận</a>
        <a class="tab-item" data-tab="shipping">Vận chuyển</a>
        <a class="tab-item" data-tab="waiting">Chờ giao hàng</a>
        <a class="tab-item" data-tab="done">Hoàn thành</a>
        <a class="tab-item" data-tab="cancelled">Đã hủy</a>
        <a class="tab-item" data-tab="refund">Trả hàng/Hoàn tiền</a>
    </div>

    <!-- Search Bar -->
    <div class="search-bar">
        <div class="input-group">
            <span class="input-group-text bg-gradient border-end-0"><i class="fas fa-search"></i></span>
            <input type="text" class="form-control border-start-0" placeholder="Tìm kiếm theo tên Shop, ID đơn hàng hoặc sản phẩm...">
        </div>
    </div>

    <!-- Orders List -->
    <c:forEach var="order" items="${orders}">
        <div class="order-card" data-status="${order.status}">
            <div class="order-header">
                <div class="shop-info">
                    <span class="shop-name"><i class="fas fa-store me-2"></i>${order.shopName}</span>
                    <small class="order-id text-muted">ID: ${order.orderId}</small>
                </div>
                <div class="order-status-container">
                    <div class="order-status ${order.status == 'done' ? 'text-success' : 'text-primary'}">
                        <c:choose>
                            <c:when test="${order.status == 'confirm'}">CHỜ XÁC NHẬN</c:when>
                            <c:when test="${order.status == 'shipping'}">VẬN CHUYỂN</c:when>
                            <c:when test="${order.status == 'waiting'}">CHỜ GIAO HÀNG</c:when>
                            <c:when test="${order.status == 'done'}">HOÀN THÀNH</c:when>
                            <c:when test="${order.status == 'cancelled'}">ĐÃ HỦY</c:when>
                            <c:when test="${order.status == 'refund'}">TRẢ HÀNG/HOÀN TIỀN</c:when>
                            <c:otherwise>TẤT CẢ</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="order-body">
                <div class="image-container">
                    <img src="${order.productImage}" alt="${order.productName}" class="product-image">
                </div>
                <div class="order-info">
                    <div class="name">${order.productName}</div>
                    <div class="type text-muted">Phân loại: ${order.productType} | Số lượng: ${order.quantity}</div>
                    <div class="price">
                        <s><fmt:formatNumber value="${order.originalPrice}" type="number" groupingUsed="true"/>₫</s>
                        <b class="text-primary ms-2"><fmt:formatNumber value="${order.discountedPrice}" type="number" groupingUsed="true"/>₫</b>
                    </div>
                </div>
            </div>

            <div class="order-footer">
                <div class="order-total">
                    Thành tiền: <span class="text-primary"><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/>₫</span>
                </div>
                <div class="order-actions">
                    <button class="btn btn-outline" onclick="viewDetails('${order.orderId}')">
                        <i class="fas fa-eye me-2"></i>Chi tiết
                    </button>
                    <c:choose>
                        <c:when test="${order.status == 'confirm'}">
                            <button class="btn btn-danger" onclick="cancelOrder('${order.orderId}', ${empty sessionScope.user})">
                                <i class="fas fa-times me-2"></i>Hủy đơn
                            </button>
                        </c:when>
                        <c:when test="${order.status == 'done'}">
                            <button class="btn btn-primary" onclick="reviewOrder('${order.orderId}', ${empty sessionScope.user})">
                                <i class="fas fa-star me-2"></i>Đánh giá
                            </button>
                        </c:when>
                        <c:when test="${order.status == 'waiting' || order.status == 'shipping'}">
                            <button class="btn btn-primary" onclick="contactSeller('${order.orderId}', ${empty sessionScope.user})">
                                <i class="fas fa-headset me-2"></i>Liên hệ người bán
                            </button>
                        </c:when>
                        <c:when test="${order.status == 'cancelled' || order.status == 'refund'}">
                            <button class="btn btn-primary" onclick="reorder('${order.orderId}', ${empty sessionScope.user})">
                                <i class="fas fa-redo me-2"></i>Mua lại
                            </button>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- Empty State -->
    <c:if test="${empty orders}">
        <div class="text-center py-5">
            <i class="fas fa-box-open fa-5x text-muted mb-4"></i>
            <h3 class="text-muted mb-3">Chưa có đơn hàng</h3>
            <p class="text-muted">Hãy đặt hàng để xem danh sách tại đây.</p>
            <a href="<c:url value='/guest/home'/>" class="btn btn-primary"><i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm</a>
        </div>
    </c:if>
</div>

<style>
    body {
        background-color: #e9ecef; /* Slightly darker background for contrast */
        font-family: 'Arial', sans-serif;
    }

    .orders-container {
        max-width: 1200px;
        margin: 40px auto;
        background: linear-gradient(135deg, #e6f0fa 0%, #f8f9fa 100%); /* Soft blue-gray gradient */
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    /* Breadcrumb Styles */
    .breadcrumb {
        background-color: #f0f4f8; /* Light blue tint */
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
    }
    .breadcrumb-item a {
        text-decoration: none;
        color: #2874f0;
        font-weight: 500;
    }
    .breadcrumb-item.active {
        color: #6c757d;
    }

    /* Tabs */
    .orders-tabs {
        display: flex;
        border-bottom: 2px solid #d1e0f0; /* Lighter blue border */
        background: #f0f4f8;
        border-radius: 8px;
        padding: 10px;
        margin-bottom: 20px;
    }
    .tab-item {
        flex: 1;
        text-align: center;
        padding: 12px 18px;
        text-decoration: none;
        color: #333;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        border-radius: 6px;
    }
    .tab-item:hover {
        background: #d9e6f5; /* Light blue hover */
        color: #2874f0;
    }
    .tab-item.active {
        background: linear-gradient(45deg, #2874f0, #1a5fce);
        color: white;
        box-shadow: 0 4px 10px rgba(40, 116, 240, 0.3);
    }

    /* Search Bar */
    .search-bar {
        padding: 15px;
        margin-bottom: 20px;
        background: #f0f4f8;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }
    .search-bar .input-group {
        max-width: 500px;
        margin: 0 auto;
    }
    .search-bar .form-control {
        border: 1px solid #ced4da;
        border-radius: 0 8px 8px 0;
        padding: 10px;
        transition: border-color 0.3s ease;
    }
    .search-bar .form-control:focus {
        border-color: #2874f0;
        box-shadow: 0 0 5px rgba(40, 116, 240, 0.3);
    }
    .search-bar .input-group-text {
        border: 1px solid #ced4da;
        border-right: none;
        border-radius: 8px 0 0 8px;
        background: linear-gradient(45deg, #e6f0fa, #f0f4f8);
        color: #6c757d;
    }

    /* Order Card */
    .order-card {
        border: none;
        border-radius: 10px;
        background: linear-gradient(135deg, #f0f4f8 0%, #e6f0fa 100%); /* Subtle gradient for cards */
        margin-bottom: 20px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }
    .order-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
    }

    /* Order Header */
    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 15px;
        border-bottom: 1px solid #d1e0f0;
    }
    .shop-info {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    .shop-info .shop-name {
        font-weight: 700;
        color: #333;
        font-size: 1.1rem;
    }
    .shop-info .order-id {
        font-size: 0.9rem;
    }
    .order-status-container {
        width: 150px;
        text-align: right;
    }
    .order-status {
        font-weight: 700;
        font-size: 0.9rem;
        padding: 6px 12px;
        border-radius: 6px;
        background: #d9e6f5;
    }
    .order-status.text-primary {
        color: #2874f0 !important;
        background: rgba(40, 116, 240, 0.15);
    }
    .order-status.text-success {
        color: #28a745 !important;
        background: rgba(40, 167, 69, 0.15);
    }

    /* Order Body */
    .order-body {
        display: flex;
        gap: 20px;
        align-items: center;
    }
    .image-container {
        width: 120px;
        flex-shrink: 0;
    }
    .order-body .product-image {
        width: 100%;
        height: 120px;
        border-radius: 8px;
        object-fit: cover;
        border: 1px solid #d1e0f0;
        transition: transform 0.3s ease;
    }
    .order-body .product-image:hover {
        transform: scale(1.05);
    }
    .order-info {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    .order-info .name {
        font-size: 1rem;
        font-weight: 600;
        color: #333;
    }
    .order-info .type {
        font-size: 0.9rem;
        color: #6c757d;
    }
    .order-info .price {
        font-size: 0.9rem;
    }
    .order-info .price s {
        color: #878787;
    }
    .order-info .price b {
        font-size: 1.1rem;
    }

    /* Order Footer */
    .order-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 15px;
        border-top: 1px solid #d1e0f0;
    }
    .order-total {
        font-size: 1.1rem;
        font-weight: 600;
        color: #333;
        width: 200px;
    }
    .order-total span {
        color: #2874f0;
    }
    .order-actions {
        width: 300px;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
    .order-actions button {
        padding: 10px 16px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        flex: 1;
        text-align: center;
    }
    .btn-primary {
        background: linear-gradient(45deg, #2874f0, #1a5fce);
        border: none;
        box-shadow: 0 4px 10px rgba(40, 116, 240, 0.3);
    }
    .btn-primary:hover {
        background: linear-gradient(45deg, #1a5fce, #2874f0);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(40, 116, 240, 0.4);
    }
    .btn-danger {
        background: linear-gradient(45deg, #ff3f6c, #ff6b81);
        border: none;
        box-shadow: 0 4px 10px rgba(255, 63, 108, 0.3);
    }
    .btn-danger:hover {
        background: linear-gradient(45deg, #ff6b81, #ff3f6c);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(255, 63, 108, 0.4);
    }
    .btn-outline {
        border: 1px solid #ced4da;
        background: #f0f4f8;
        color: #333;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .btn-outline:hover {
        border-color: #2874f0;
        color: #2874f0;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(40, 116, 240, 0.2);
    }
</style>

<script>
    // Tab switching
    const tabs = document.querySelectorAll('.tab-item');
    const orders = document.querySelectorAll('.order-card');

    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            tabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            const tabType = tab.dataset.tab;

            orders.forEach(order => {
                if (tabType === 'all' || order.dataset.status === tabType) {
                    order.style.display = 'flex';
                    order.style.animation = 'fadeIn 0.3s ease';
                } else {
                    order.style.display = 'none';
                }
            });
        });
    });

    // Action functions
    function viewDetails(orderId) {
        console.log('DEBUG JS: 👁️ Viewing details for order: ' + orderId);
        showNotification('Chuyển đến trang chi tiết đơn hàng!', 'success');
        window.location.href = '<c:url value="/guest/order-details"/>?orderId=' + orderId;
    }

    function cancelOrder(orderId, isGuest) {
        if (isGuest) {
            showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning', true);
            return;
        }
        console.log('DEBUG JS: ❌ Cancelling order: ' + orderId);
        showNotification('Đơn hàng đã được hủy!', 'info');
        // Backend call to cancel order
    }

    function reviewOrder(orderId, isGuest) {
        if (isGuest) {
            showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning', true);
            return;
        }
        console.log('DEBUG JS: ⭐ Reviewing order: ' + orderId);
        showNotification('Chuyển đến trang đánh giá!', 'success');
        window.location.href = '<c:url value="/guest/review"/>?orderId=' + orderId;
    }

    function contactSeller(orderId, isGuest) {
        if (isGuest) {
            showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning', true);
            return;
        }
        console.log('DEBUG JS: 📞 Contacting seller for order: ' + orderId);
        showNotification('Chuyển đến trang liên hệ!', 'success');
        // Redirect to contact page
    }

    function reorder(orderId, isGuest) {
        if (isGuest) {
            showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning', true);
            return;
        }
        console.log('DEBUG JS: 🔄 Reordering: ' + orderId);
        showNotification('Sản phẩm đã được thêm vào giỏ hàng!', 'success');
        // Redirect to cart or product page
    }

    // Notification function
    function showNotification(message, type, persistent) {
        var notificationType = type || 'info';
        var isPersistent = persistent || false;
        var notificationId = 'notification-' + Date.now();

        if (isPersistent && document.querySelector('.notification-persistent')) {
            var existingNotification = document.querySelector('.notification-persistent');
            existingNotification.classList.remove('shake');
            void existingNotification.offsetWidth;
            existingNotification.classList.add('shake');
            existingNotification.querySelector('span').textContent = message;
            existingNotification.className = 'notification notification-persistent alert alert-' + notificationType + ' position-fixed d-flex align-items-center';
            var iconMap = {
                success: 'fa-check-circle',
                info: 'fa-info-circle',
                warning: 'fa-exclamation-triangle',
                danger: 'fa-exclamation-circle'
            };
            var iconClass = iconMap[notificationType] || 'fa-info-circle';
            existingNotification.querySelector('i').className = 'fas ' + iconClass + ' me-2';
            return;
        }

        var iconMap = {
            success: 'fa-check-circle',
            info: 'fa-info-circle',
            warning: 'fa-exclamation-triangle',
            danger: 'fa-exclamation-circle'
        };
        var iconClass = iconMap[notificationType] || 'fa-info-circle';

        var notification = document.createElement('div');
        notification.className = 'notification alert alert-' + notificationType + ' position-fixed d-flex align-items-center';
        if (isPersistent) {
            notification.classList.add('notification-persistent');
        }
        notification.style.top = '20px';
        notification.style.right = '20px';
        notification.style.zIndex = '9999';
        notification.style.minWidth = '300px';
        notification.style.animation = 'slideInRight 0.3s ease-out';

        var icon = document.createElement('i');
        icon.className = 'fas ' + iconClass + ' me-2';

        var messageSpan = document.createElement('span');
        messageSpan.textContent = message;
        messageSpan.style.color = 'inherit';

        var closeButton = document.createElement('button');
        closeButton.type = 'button';
        closeButton.className = 'btn-close ms-auto';
        closeButton.setAttribute('onclick', 'this.parentElement.remove()');

        notification.appendChild(icon);
        notification.appendChild(messageSpan);
        notification.appendChild(closeButton);

        document.body.appendChild(notification);

        if (!isPersistent) {
            setTimeout(function() {
                if (notification.parentElement) {
                    notification.style.animation = 'slideOutRight 0.3s ease-in forwards';
                    notification.addEventListener('animationend', function() {
                        if (notification.parentElement) {
                            notification.remove();
                        }
                    });
                }
            }, 6000);
        }
    }

    // Animation styles
    const animationStyles = document.createElement('style');
    animationStyles.textContent = `
        @keyframes slideInRight { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
        @keyframes slideOutRight { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes shake {
            10%, 90% { transform: translateX(-1px); }
            20%, 80% { transform: translateX(2px); }
            30%, 50%, 70% { transform: translateX(-4px); }
            40%, 60% { transform: translateX(4px); }
        }
        .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both; }
    `;
    document.head.appendChild(animationStyles);
</script>

</body>
</html>