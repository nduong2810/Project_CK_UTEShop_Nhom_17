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
    <div id="ajax-alert-container"></div>
    <%-- ... (Các thông báo success/error cũ) ... --%>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <nav aria-label="breadcrumb" class="mb-4">
        <%-- ... (Breadcrumb) ... --%>
    </nav>
    <h2 class="mb-4">
        <%-- ... (Tiêu đề) ... --%>
    </h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <%-- ===== THAY ĐỔI 1: Thêm ID cho thẻ card chính ===== --%>
                <div class="order-card" id="order-card-${order.maDH}">
                    <div class="order-header">
                        <%-- ... (Thông tin header đơn hàng) ... --%>
                        <div class="shop-info">
                            <span class="order-id">Đơn hàng #${order.maDH}</span>
                            <small class="text-muted">
                                <i class="far fa-calendar me-1"></i>
                                <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                            </small>
                        </div>
                        <div class="order-status-container">
                            <span class="order-status status-${order.trangThai}" id="status-for-${order.maDH}">
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
                        <%-- ... (Chi tiết sản phẩm) ... --%>
                        <c:forEach var="item" items="${order.chiTietDonHangs}" varStatus="status">
                            <c:if test="${status.index < 3}">
                                <div class="product-row">
                                    <div class="image-container">
                                        <c:choose>
                                            <c:when test="${not empty item.sanPham.hinhAnh}">
                                                <img src="${pageContext.request.contextPath}/assets/img/${item.sanPham.hinhAnh}" 
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
                    </div>

                    <div class="order-footer">
                        <%-- ... (Tổng thanh toán) ... --%>
                        <div class="order-total">
                            <span class="text-muted">Tổng thanh toán:</span>
                            <span class="text-primary fw-bold">
                                <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                        
                        <div class="order-actions" id="actions-for-${order.maDH}">
                            <a href="${pageContext.request.contextPath}/user/order-detail?id=${order.maDH}" 
                               class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-eye me-2"></i>Chi tiết
                            </a>
                            
                            <%-- ===== THAY ĐỔI 2: Logic hiển thị nút Hủy/Xóa ===== --%>
                            
                            <%-- Nếu CHỜ XÁC NHẬN -> Hiển thị nút Hủy --%>
                            <c:if test="${order.trangThai == 'CHO_XAC_NHAN'}">
                                <button class="btn btn-outline-danger btn-sm" 
                                        onclick="cancelOrder(${order.maDH}, this)">
                                    <i class="fas fa-times me-2"></i>Hủy đơn
                                </button>
                            </c:if>
                            
                            <%-- Nếu ĐÃ HỦY -> Hiển thị nút Xóa --%>
                            <c:if test="${order.trangThai == 'DA_HUY'}">
                                <button class="btn btn-dark btn-sm" 
                                        onclick="deleteOrder(${order.maDH}, this)">
                                    <i class="fas fa-trash me-2"></i>Xóa
                                </button>
                            </c:if>
                            
                            <%-- Nút Đánh giá (không đổi) --%>
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
            <%-- ... (Trạng thái rỗng) ... --%>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ... (Hàm auto dismiss và showAjaxAlert không đổi) ...
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            if (alert.parentNode) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }
        });
    }, 5000);

    function showAjaxAlert(message, type) {
        const container = document.getElementById('ajax-alert-container');
        if (!container) return;
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
        alertDiv.role = 'alert';
        let icon = 'fa-info-circle';
        if (type === 'success') icon = 'fa-check-circle';
        if (type === 'danger') icon = 'fa-exclamation-circle';
        alertDiv.innerHTML = `
            <i class="fas ${icon} me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        container.prepend(alertDiv);
        setTimeout(() => {
            if (alertDiv.parentNode) {
                const bsAlert = new bootstrap.Alert(alertDiv);
                bsAlert.close();
            }
        }, 5000);
    }

    // ===== THAY ĐỔI 3: Sửa hàm cancelOrder =====
    function cancelOrder(orderId, buttonElement) {
        if (confirm('Bạn có chắc muốn hủy đơn hàng này?')) {
            buttonElement.disabled = true;
            buttonElement.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang hủy...';
            const url = '${pageContext.request.contextPath}/user/orders/cancel?id=' + orderId;

            fetch(url)
                .then(response => {
                    if (response.ok) return response.json();
                    throw new Error('Server không phản hồi JSON.');
                })
                .then(data => {
                    if (data.success) {
                        showAjaxAlert('Hủy đơn hàng #' + orderId + ' thành công!', 'success');
                        
                        // Cập nhật trạng thái
                        const statusSpan = document.getElementById('status-for-' + orderId);
                        if (statusSpan) {
                            statusSpan.textContent = 'ĐÃ HỦY';
                            statusSpan.className = 'order-status status-DA_HUY';
                        }
                        
                        // THAY THẾ nút "Hủy" bằng nút "Xóa"
                        const actionDiv = document.getElementById('actions-for-' + orderId);
                        if (actionDiv) {
                            actionDiv.innerHTML = `
                                <a href="${pageContext.request.contextPath}/user/order-detail?id=${orderId}" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-eye me-2"></i>Chi tiết
                                </a>
                                <button class="btn btn-dark btn-sm" 
                                        onclick="deleteOrder(${orderId}, this)">
                                    <i class="fas fa-trash me-2"></i>Xóa
                                </button>
                            `;
                        }
                    } else {
                        showAjaxAlert('Hủy thất bại: ' + (data.message || 'Lỗi không xác định.'), 'danger');
                        buttonElement.disabled = false;
                        buttonElement.innerHTML = '<i class="fas fa-times me-2"></i>Hủy đơn';
                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gọi AJAX:', error);
                    showAjaxAlert('Đã xảy ra lỗi. Vui lòng thử lại.', 'danger');
                    buttonElement.disabled = false;
                    buttonElement.innerHTML = '<i class="fas fa-times me-2"></i>Hủy đơn';
                });
        }
    }

    // ===== THAY ĐỔI 4: Thêm hàm deleteOrder =====
    function deleteOrder(orderId, buttonElement) {
        // Hỏi 2 lần cho chắc
        if (confirm('Bạn có chắc muốn XÓA VĨNH VIỄN đơn hàng này không? Hành động này không thể hoàn tác.')) {
            
            buttonElement.disabled = true;
            buttonElement.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xóa...';

            // Đường dẫn URL mới
            const url = '${pageContext.request.contextPath}/user/orders/delete?id=' + orderId;

            fetch(url)
                .then(response => {
                    if (response.ok) return response.json();
                    throw new Error('Server không phản hồi JSON.');
                })
                .then(data => {
                    if (data.success) {
                        showAjaxAlert('Đã xóa đơn hàng #' + orderId, 'success');
                        
                        // Xóa toàn bộ card đơn hàng
                        const orderCard = document.getElementById('order-card-' + orderId);
                        if (orderCard) {
                            // Thêm hiệu ứng mờ dần trước khi xóa
                            orderCard.style.transition = 'opacity 0.5s ease';
                            orderCard.style.opacity = '0';
                            setTimeout(() => {
                                orderCard.remove();
                            }, 500); // Xóa khỏi DOM sau 0.5s
                        }
                    } else {
                        showAjaxAlert('Xóa thất bại: ' + (data.message || 'Lỗi không xác định.'), 'danger');
                        buttonElement.disabled = false;
                        buttonElement.innerHTML = '<i class="fas fa-trash me-2"></i>Xóa';
                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gọi AJAX:', error);
                    showAjaxAlert('Đã xảy ra lỗi. Vui lòng thử lại.', 'danger');
                    buttonElement.disabled = false;
                    buttonElement.innerHTML = '<i class="fas fa-trash me-2"></i>Xóa';
                });
        }
    }
</script>

<style>
    /* ... (Toàn bộ CSS của bạn ở đây) ... */
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
    #ajax-alert-container {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        width: 350px;
    }
    #ajax-alert-container .alert {
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
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
    .alert {
        border-radius: 10px;
        border: none;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
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