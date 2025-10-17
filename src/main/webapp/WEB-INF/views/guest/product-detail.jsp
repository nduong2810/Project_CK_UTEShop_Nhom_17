<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${not empty product}">
        <title>${product.tenSP} - UTESHOP</title>
    </c:when>
    <c:otherwise>
        <title>Không tìm thấy sản phẩm - UTESHOP</title>
    </c:otherwise>
</c:choose>

<div class="container my-5">
    <c:choose>
        <c:when test="${not empty product}">
            <div class="row">
                <!-- Product Image Gallery -->
                <div class="col-lg-6 mb-4">
                    <div class="main-image-container mb-3">
                        <img src="${pageContext.request.contextPath}/assets/img/${product.hinhAnh}"
                             id="mainProductImage" class="img-fluid rounded shadow-sm"
                             alt="${product.tenSP}"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/no-image.png'">
                    </div>
                </div>

                <!-- Product Details -->
                <div class="col-lg-6">
                    <h1 class="display-6 fw-bold">${product.tenSP}</h1>
                    
                    <div class="d-flex align-items-center mb-3">
                        <div class="rating text-warning me-3">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star-half-alt"></i>
                            <span class="text-muted ms-1">(4.5 | Đã bán: ${product.soLuongBan})</span>
                        </div>
                    </div>

                    <div class="price-section bg-light p-3 rounded mb-4">
                        <span class="h2 text-danger fw-bolder">
                            <fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                        </span>
                    </div>

                    <p class="text-muted">${product.moTa}</p>

                    <hr>

                    <!-- Quantity and Action Buttons -->
                    <div class="d-flex align-items-center mb-4">
                        <label for="quantity" class="form-label me-3 mb-0">Số lượng:</label>
                        <div class="input-group" style="width: 130px;">
                            <button class="btn btn-outline-secondary" type="button" id="button-minus">-</button>
                            <input type="text" id="quantity" class="form-control text-center" value="1" min="1">
                            <button class="btn btn-outline-secondary" type="button" id="button-plus">+</button>
                        </div>
                    </div>

                    <div class="d-grid gap-2 d-sm-flex">
                        <button class="btn btn-primary btn-lg flex-grow-1" type="button" id="addToCartBtn">
                            <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                        </button>
                        <button class="btn btn-warning btn-lg flex-grow-1" type="button" id="buyNowBtn">
                            <i class="fa fa-bolt"></i> Mua ngay
                        </button>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="fa fa-search fa-5x text-muted mb-4"></i>
                <h2 class="mb-3">Không tìm thấy sản phẩm</h2>
                <p class="text-muted">Sản phẩm bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary">
                    <i class="fa fa-home"></i> Về trang chủ
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
    .main-image-container {
        border: 1px solid #ddd;
        padding: 1rem;
        border-radius: 0.5rem;
    }
    #mainProductImage {
        width: 100%;
        height: auto;
        max-height: 500px;
        object-fit: contain;
    }
    .price-section {
        border-left: 5px solid var(--bs-danger);
    }

    /* Notification Toast Styles */
    .toast-container {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 99999;
    }

    .custom-toast {
        background: white;
        border-radius: 12px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        border: none;
        min-width: 350px;
        max-width: 400px;
        transform: translateX(100%);
        opacity: 0;
        transition: all 0.4s ease;
        overflow: hidden;
    }

    .custom-toast.show {
        transform: translateX(0);
        opacity: 1;
    }

    .toast-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-bottom: none;
        padding: 12px 16px;
        font-weight: 600;
    }

    .toast-header .btn-close {
        background: none;
        border: none;
        color: white;
        opacity: 0.8;
        font-size: 18px;
        width: 24px;
        height: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .toast-header .btn-close:hover {
        opacity: 1;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 50%;
    }

    .toast-body {
        padding: 16px;
        color: #333;
        font-size: 14px;
        line-height: 1.5;
    }

    .toast-icon {
        width: 20px;
        height: 20px;
        margin-right: 8px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .toast-success .toast-header {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    }

    .toast-warning .toast-header {
        background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
        color: #333;
    }

    .toast-product-info {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 12px;
        margin-top: 10px;
        border-left: 4px solid #667eea;
    }

    .toast-product-name {
        font-weight: 600;
        color: #333;
        margin-bottom: 4px;
    }

    .toast-product-price {
        color: #dc3545;
        font-weight: 600;
    }

    .toast-quantity {
        color: #6c757d;
        font-size: 13px;
    }
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const quantityInput = document.getElementById('quantity');
    const minusButton = document.getElementById('button-minus');
    const plusButton = document.getElementById('button-plus');
    const addToCartBtn = document.getElementById('addToCartBtn');
    const buyNowBtn = document.getElementById('buyNowBtn');

    // Quantity controls
    if (minusButton) {
        minusButton.addEventListener('click', function() {
            let currentValue = parseInt(quantityInput.value) || 1;
            if (currentValue > 1) {
                quantityInput.value = currentValue - 1;
            }
        });
    }

    if (plusButton) {
        plusButton.addEventListener('click', function() {
            let currentValue = parseInt(quantityInput.value) || 1;
            quantityInput.value = currentValue + 1;
        });
    }

    // Add to cart button
    if (addToCartBtn) {
        addToCartBtn.addEventListener('click', function() {
            const quantity = parseInt(quantityInput.value) || 1;
            showNotification('success', 'Thêm vào giỏ hàng', 
                `Đã thêm ${quantity} sản phẩm vào giỏ hàng thành công!`, 
                '${product.tenSP}', '${product.donGia}', quantity);
        });
    }

    // Buy now button  
    if (buyNowBtn) {
        buyNowBtn.addEventListener('click', function() {
            const quantity = parseInt(quantityInput.value) || 1;
            showNotification('warning', 'Yêu cầu đăng nhập', 
                `Bạn cần đăng nhập để mua ${quantity} sản phẩm này.`, 
                '${product.tenSP}', '${product.donGia}', quantity);
        });
    }
});

function showNotification(type, title, message, productName, productPrice, quantity) {
    // Remove existing notifications
    const existingToasts = document.querySelectorAll('.custom-toast');
    existingToasts.forEach(toast => {
        toast.remove();
    });

    // Create toast container if not exists
    let toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container';
        document.body.appendChild(toastContainer);
    }

    // Create new toast
    const toast = document.createElement('div');
    toast.className = `custom-toast toast-${type}`;
    
    const iconHtml = type === 'success' 
        ? '<i class="fa fa-check-circle"></i>' 
        : '<i class="fa fa-exclamation-triangle"></i>';

    const formattedPrice = new Intl.NumberFormat('vi-VN').format(productPrice);

    toast.innerHTML = `
        <div class="toast-header">
            <div class="toast-icon">${iconHtml}</div>
            <strong class="me-auto">${title}</strong>
            <button type="button" class="btn-close" onclick="closeToast(this)">×</button>
        </div>
        <div class="toast-body">
            <div>${message}</div>
            <div class="toast-product-info">
                <div class="toast-product-name">${productName}</div>
                <div class="d-flex justify-content-between">
                    <span class="toast-product-price">${formattedPrice}₫</span>
                    <span class="toast-quantity">Số lượng: ${quantity}</span>
                </div>
            </div>
        </div>
    `;

    toastContainer.appendChild(toast);

    // Show toast with animation
    setTimeout(() => {
        toast.classList.add('show');
    }, 100);

    // Auto hide after 4 seconds
    setTimeout(() => {
        hideToast(toast);
    }, 4000);
}

function closeToast(button) {
    const toast = button.closest('.custom-toast');
    hideToast(toast);
}

function hideToast(toast) {
    if (toast && toast.parentElement) {
        toast.classList.remove('show');
        setTimeout(() => {
            if (toast.parentElement) {
                toast.remove();
            }
        }, 400);
    }
}
</script>