<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

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
    <!-- Success Message -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <!-- Error Message -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Breadcrumbs -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Đơn Hàng Của Tôi</li>
        </ol>
    </nav>

    <h2 class="mb-4">
        <i class="fas fa-shopping-bag me-2"></i>Đơn Hàng Của Tôi
        <c:if test="${not empty orderCount}">
            <span class="badge bg-primary">${orderCount}</span>
        </c:if>
    </h2>

    <!-- Orders List -->
    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div class="order-header">
                        <div class="shop-info">
                            <span class="order-id">Đơn hàng #${order.maDH}</span>
                            <small class="text-muted">
                                <i class="far fa-calendar me-1"></i>
                                <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                            </small>
                        </div>
                        <div class="order-status-container">
                            <span class="order-status status-${order.trangThai}">
                                <c:choose>
                                    <c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">CHỜ XÁC NHẬN</c:when>
                                    <c:when test="${order.trangThai == 'DA_XAC_NHAN'}">ĐÃ XÁC NHẬN</c:when>
                                    <c:when test="${order.trangThai == 'DANG_CHUAN_BI'}">ĐANG CHUẨN BỊ</c:when>
                                    <c:when test="${order.trangThai == 'DANG_GIAO'}">ĐANG GIAO HÀNG</c:when>
                                    <c:when test="${order.trangThai == 'DA_GIAO'}">ĐÃ GIAO</c:when>
                                    <c:when test="${order.trangThai == 'HOAN_THANH'}">HOÀN THÀNH</c:when>
                                    <c:when test="${order.trangThai == 'DA_HUY'}">ĐÃ HỦY</c:when>
                                    <c:when test="${order.trangThai == 'TRA_HANG'}">TRẢ HÀNG</c:when>
                                    <c:when test="${order.trangThai == 'HOAN_TIEN'}">HOÀN TIỀN</c:when>
                                    <c:otherwise>${order.trangThai}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>

                    <div class="order-body">
                        <c:forEach var="item" items="${order.chiTietDonHangs}" varStatus="status">
                            <c:if test="${status.index < 3}">
                                <div class="product-row">
                                    <div class="image-container">
                                        <c:choose>
                                            <c:when test="${not empty item.sanPham.hinhAnh}">
                                                <img src="${pageContext.request.contextPath}/assets/img/products/${item.sanPham.hinhAnh}" 
                                                     alt="${item.sanPham.tenSP}" class="product-image">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                                    <i class="fas fa-image text-muted"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="order-info">
                                        <div class="name">${item.sanPham.tenSP}</div>
                                        <div class="type text-muted">Số lượng: ${item.soLuong}</div>
                                        <div class="price">
                                            <b class="text-primary">
                                                <fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="₫"/>
                                            </b>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${order.chiTietDonHangs.size() > 3}">
                            <div class="text-muted small mt-2">
                                <i class="fas fa-ellipsis-h me-1"></i>
                                Và ${order.chiTietDonHangs.size() - 3} sản phẩm khác
                            </div>
                        </c:if>
                    </div>

                    <div class="order-footer">
                        <div class="order-total">
                            <span class="text-muted">Tổng thanh toán:</span>
                            <span class="text-primary fw-bold">
                                <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                        <div class="order-actions">
                            <a href="${pageContext.request.contextPath}/user/order-detail?id=${order.maDH}" 
                               class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-eye me-2"></i>Chi tiết
                            </a>
                            
                            <c:if test="${order.trangThai == 'CHO_XAC_NHAN'}">
                                <button class="btn btn-outline-danger btn-sm" 
                                        onclick="if(confirm('Bạn có chắc muốn hủy đơn hàng này?')) { window.location.href='${pageContext.request.contextPath}/user/orders/cancel?id=${order.maDH}'; }">
                                    <i class="fas fa-times me-2"></i>Hủy đơn
                                </button>
                            </c:if>
                            
                            <c:if test="${order.trangThai == 'DA_GIAO' || order.trangThai == 'HOAN_THANH'}">
                                <a href="${pageContext.request.contextPath}/user/review?orderId=${order.maDH}" 
                                   class="btn btn-primary btn-sm">
                                    <i class="fas fa-star me-2"></i>Đánh giá
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- Empty State -->
            <div class="text-center py-5">
                <i class="fas fa-box-open fa-5x text-muted mb-4"></i>
                <h3 class="text-muted mb-3">Chưa có đơn hàng</h3>
                <p class="text-muted">Hãy đặt hàng để xem danh sách tại đây.</p>
                <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary">
                    <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto dismiss alerts after 5 seconds
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

<style>
    body {
        background-color: #f0f2f5;
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .orders-container {
        max-width: 1200px;
        margin: 40px auto;
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        padding: 30px;
    }

    .breadcrumb {
        background-color: #f8f9fa;
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
    }
    
    .breadcrumb-item a {
        text-decoration: none;
        color: #667eea;
        font-weight: 500;
    }
    
    .breadcrumb-item.active {
        color: #6c757d;
    }

    .order-card {
        border: 2px solid #e9ecef;
        border-radius: 12px;
        background: #fff;
        margin-bottom: 20px;
        padding: 0;
        transition: all 0.3s ease;
        overflow: hidden;
    }
    
    .order-card:hover {
        border-color: #667eea;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.15);
        transform: translateY(-2px);
    }

    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border-bottom: 1px solid #e9ecef;
    }
    
    .shop-info {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    
    .order-id {
        font-weight: 700;
        color: #333;
        font-size: 1.1rem;
    }

    .order-status-container {
        text-align: right;
    }
    
    .order-status {
        padding: 6px 16px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
    }
    
    .status-CHO_XAC_NHAN {
        background: #fff3cd;
        color: #856404;
    }
    
    .status-DA_XAC_NHAN {
        background: #cfe2ff;
        color: #084298;
    }
    
    .status-DANG_CHUAN_BI {
        background: #e7d6f9;
        color: #6f42c1;
    }
    
    .status-DANG_GIAO {
        background: #cff4fc;
        color: #055160;
    }
    
    .status-DA_GIAO {
        background: #d1e7dd;
        color: #0f5132;
    }
    
    .status-HOAN_THANH {
        background: #d1e7dd;
        color: #0a3622;
    }
    
    .status-DA_HUY {
        background: #f8d7da;
        color: #842029;
    }
    
    .status-TRA_HANG {
        background: #fff3cd;
        color: #664d03;
    }
    
    .status-HOAN_TIEN {
        background: #e2e3e5;
        color: #41464b;
    }

    .order-body {
        padding: 20px;
    }
    
    .product-row {
        display: flex;
        gap: 15px;
        padding: 15px 0;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .product-row:last-child {
        border-bottom: none;
    }

    .image-container {
        flex-shrink: 0;
    }
    
    .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #e9ecef;
    }

    .order-info {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: 5px;
    }
    
    .order-info .name {
        font-weight: 600;
        color: #333;
        font-size: 0.95rem;
        line-height: 1.4;
    }
    
    .order-info .type {
        font-size: 0.85rem;
        color: #6c757d;
    }
    
    .order-info .price {
        font-size: 1rem;
        font-weight: 700;
        color: #667eea;
    }

    .order-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        background: #f8f9fa;
        border-top: 1px solid #e9ecef;
    }
    
    .order-total {
        font-size: 1rem;
        display: flex;
        gap: 10px;
        align-items: center;
    }
    
    .order-total .text-primary {
        font-size: 1.25rem;
        font-weight: 700;
    }

    .order-actions {
        display: flex;
        gap: 10px;
    }
    
    .order-actions .btn {
        padding: 8px 20px;
        border-radius: 6px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .order-actions .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    }

    /* Alert styling */
    .alert {
        border-radius: 10px;
        border: none;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    /* Responsive */
    @media (max-width: 768px) {
        .orders-container {
            padding: 15px;
            margin: 20px 10px;
        }
        
        .order-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }
        
        .order-status-container {
            text-align: left;
        }
        
        .order-footer {
            flex-direction: column;
            gap: 15px;
            align-items: flex-start;
        }
        
        .order-actions {
            width: 100%;
            flex-direction: column;
        }
        
        .order-actions .btn {
            width: 100%;
        }
        
        .product-row {
            flex-direction: column;
        }
    }
</style>
</body>
</html>

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