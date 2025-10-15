<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty category}">
    <title>Danh mục: ${category.tenDM} - UTESHOP</title>
</c:if>
<c:if test="${empty category}">
    <title>Lỗi - UTESHOP</title>
</c:if>

<div class="container my-5">
    <c:choose>
        <%-- Case 1: Category and products are found --%>
        <c:when test="${not empty category}">
            <div class="section-header mb-5">
                <h1 class="display-5 fw-bold text-primary">${category.tenDM}</h1>
                <p class="lead text-muted">${category.moTa}</p>
                <hr>
            </div>

            <!-- Filter Section -->
            <div class="filter-section mb-4">
                <div class="row">
                    <div class="col-md-4">
                        <label for="categoryFilter" class="form-label fw-bold">
                            <i class="fa fa-filter me-2"></i>Lọc theo danh mục
                        </label>
                        <select class="form-select" id="categoryFilter" onchange="filterByCategory()">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="cat" items="${allCategories}">
                                <option value="${cat.maDM}" ${cat.maDM == category.maDM ? 'selected' : ''}>
                                    ${cat.tenDM}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="priceFilter" class="form-label fw-bold">
                            <i class="fa fa-dollar-sign me-2"></i>Khoảng giá
                        </label>
                        <select class="form-select" id="priceFilter" onchange="filterByPrice()">
                            <option value="">Tất cả mức giá</option>
                            <option value="0-100000">Dưới 100,000₫</option>
                            <option value="100000-500000">100,000₫ - 500,000₫</option>
                            <option value="500000-1000000">500,000₫ - 1,000,000₫</option>
                            <option value="1000000-5000000">1,000,000₫ - 5,000,000₫</option>
                            <option value="5000000-">Trên 5,000,000₫</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="sortFilter" class="form-label fw-bold">
                            <i class="fa fa-sort me-2"></i>Sắp xếp theo
                        </label>
                        <select class="form-select" id="sortFilter" onchange="sortProducts()">
                            <option value="default">Mặc định</option>
                            <option value="price-asc">Giá thấp đến cao</option>
                            <option value="price-desc">Giá cao đến thấp</option>
                            <option value="name-asc">Tên A-Z</option>
                            <option value="name-desc">Tên Z-A</option>
                            <option value="sales-desc">Bán chạy nhất</option>
                        </select>
                    </div>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty products}">
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4">
                        <c:forEach var="sp" items="${products}" varStatus="status">
                            <div class="col">
                                <div class="product-card h-100 fade-in-up" 
                                     data-product-id="${sp.maSP}" 
                                     data-price="${sp.donGia}"
                                     style="animation-delay: ${status.index * 0.05}s;">
                                    
                                    <div class="product-image-container position-relative">
                                        <!-- Ảnh sản phẩm luôn hiển thị -->
                                        <img src="${pageContext.request.contextPath}/img/${sp.hinhAnh}"
                                             class="product-image" alt="${sp.tenSP}" 
                                             onerror="this.src='${pageContext.request.contextPath}/img/Logo_HCMUTE.png'">
                                        
                                        <!-- Overlay chỉ hiện khi hover -->
                                        <div class="product-overlay">
                                            <div class="overlay-content">
                                                <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}" 
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fa fa-eye"></i> Xem chi tiết
                                                </a>
                                                <button class="btn btn-success btn-sm mt-2" onclick="addToCart(${sp.maSP})">
                                                    <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="card-body p-3 d-flex flex-column">
                                        <h6 class="card-title fw-bold mb-2 flex-grow-1">
                                            <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}" class="text-decoration-none text-dark product-name-link">${sp.tenSP}</a>
                                        </h6>
                                        <div class="price-container mt-2">
                                            <span class="price h5 text-danger fw-bold">
                                                <fmt:formatNumber value="${sp.donGia}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                                            </span>
                                        </div>
                                        <div class="sales-info text-muted small mt-1">
                                            <i class="fa fa-chart-line"></i> Đã bán: ${sp.soLuongBan}
                                        </div>
                                        <div class="mt-3">
                                            <button class="btn btn-primary btn-sm w-100" onclick="addToCart(${sp.maSP})">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fa fa-box-open fa-5x text-muted mb-4"></i>
                        <h3 class="text-muted mb-3">Chưa có sản phẩm</h3>
                        <p class="text-muted">Hiện chưa có sản phẩm nào trong danh mục này.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:when>

        <%-- Case 2: Error message exists --%>
        <c:when test="${not empty errorMessage}">
            <div class="text-center py-5">
                <i class="fa fa-exclamation-triangle fa-5x text-danger mb-4"></i>
                <h2 class="mb-3">Đã xảy ra lỗi</h2>
                <p class="text-muted">${errorMessage}</p>
                <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary">
                    <i class="fa fa-home"></i> Về trang chủ
                </a>
            </div>
        </c:when>

        <%-- Case 3: Default (should not happen with current logic) --%>
        <c:otherwise>
             <div class="text-center py-5">
                <h2 class="mb-3">Không tìm thấy trang</h2>
                <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary">Về trang chủ</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
/* Product card styles */
.product-card {
    border: 1px solid #eee;
    border-radius: 0.75rem;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    background: white;
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.15);
}

/* Product image container */
.product-image-container {
    height: 180px;
    padding: 0.5rem;
    position: relative;
    overflow: hidden;
    background: #f8f9fa;
}

/* Product image - luôn hiển thị */
.product-image {
    width: 100%;
    height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
    display: block; /* Đảm bảo ảnh luôn hiển thị */
}

.product-card:hover .product-image {
    transform: scale(1.05);
}

/* Overlay - chỉ hiện khi hover */
.product-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 2;
}

.product-card:hover .product-overlay {
    opacity: 1;
    visibility: visible;
}

.overlay-content {
    text-align: center;
}

.overlay-content .btn {
    display: block;
    width: 120px;
    margin: 0 auto;
}

/* Product name styling */
.product-name-link {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    min-height: 40px;
    line-height: 1.3;
}

.product-name-link:hover {
    color: #0d6efd !important;
}

/* Price styling */
.price {
    font-size: 1.1rem !important;
}

/* Sales info */
.sales-info {
    color: #6c757d;
    font-size: 0.85rem;
}

/* Animation */
.fade-in-up {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeInUp 0.6s ease forwards;
}

@keyframes fadeInUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Button hover effects */
.btn:hover {
    transform: translateY(-1px);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .product-image-container {
        height: 150px;
    }
    
    .overlay-content .btn {
        width: 100px;
        font-size: 0.8rem;
        padding: 0.375rem 0.5rem;
    }
}
</style>

<script>
// Add to cart function
function addToCart(productId) {
    const button = event.target;
    const originalText = button.innerHTML;
    
    // Loading state
    button.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Đang thêm...';
    button.disabled = true;
    
    setTimeout(() => {
        button.innerHTML = '<i class="fa fa-check"></i> Đã thêm!';
        button.classList.replace('btn-primary', 'btn-success');
        button.classList.replace('btn-success', 'btn-success');
        
        setTimeout(() => {
            button.innerHTML = originalText;
            button.classList.replace('btn-success', 'btn-primary');
            button.disabled = false;
        }, 2000);
    }, 1000);
    
    // Show notification
    showNotification('Sản phẩm đã được thêm vào giỏ hàng!', 'success');
}

// Simple notification function
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = 'alert alert-' + type + ' position-fixed top-0 end-0 m-3';
    notification.style.zIndex = '9999';
    notification.style.minWidth = '300px';
    notification.innerHTML = 
        '<div class="d-flex align-items-center">' +
            '<i class="fa fa-check-circle me-2"></i>' +
            '<span>' + message + '</span>' +
            '<button type="button" class="btn-close ms-auto" onclick="this.parentElement.parentElement.remove()"></button>' +
        '</div>';
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        if (notification.parentElement) {
            notification.remove();
        }
    }, 4000);
}

// Initialize animations on page load
document.addEventListener('DOMContentLoaded', function() {
    const cards = document.querySelectorAll('.product-card');
    cards.forEach((card, index) => {
        card.style.animationDelay = (index * 0.1) + 's';
    });
});

// Filter products by category
function filterByCategory() {
    const categoryId = document.getElementById('categoryFilter').value;
    const url = new URL(window.location);
    url.searchParams.set('categoryId', categoryId);
    window.location = url;
}

// Filter products by price range
function filterByPrice() {
    const priceRange = document.getElementById('priceFilter').value;
    const url = new URL(window.location);
    url.searchParams.set('priceRange', priceRange);
    window.location = url;
}

// Sort products
function sortProducts() {
    const sortBy = document.getElementById('sortFilter').value;
    const url = new URL(window.location);
    url.searchParams.set('sortBy', sortBy);
    window.location = url;
}
</script>