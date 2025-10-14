<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>Trang chủ - UTESHOP</title>

<!-- Hero Section -->
<section class="hero-section">
    <div id="carouselExample" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/assets/img/banner1.jpg" class="d-block w-100" alt="Banner 1">
                <div class="carousel-caption d-none d-md-block fade-in-up">
                    <h1 class="display-4 fw-bold">Chào mừng đến UTESHOP</h1>
                    <p class="lead">Nền tảng thương mại điện tử cho mọi người</p>
                    <a href="#products" class="btn btn-warning btn-lg pulse-animation">
                        <i class="fa fa-shopping-bag"></i> Khám phá ngay
                    </a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/assets/img/banner2.jpg" class="d-block w-100" alt="Banner 2">
                <div class="carousel-caption d-none d-md-block fade-in-up">
                    <h1 class="display-4 fw-bold">Sản phẩm chất lượng</h1>
                    <p class="lead">Hàng ngàn sản phẩm với giá tốt nhất</p>
                    <a href="#products" class="btn btn-warning btn-lg">
                        <i class="fa fa-star"></i> Xem sản phẩm nổi bật
                    </a>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</section>

<!-- Products Section -->
<section id="products" class="products-section py-5 bg-light">
    <div class="container">
        <div class="section-header text-center mb-5 fade-in-up">
            <h2 class="display-5 fw-bold text-primary mb-3">
                <i class="fa fa-star text-warning"></i>
                Sản phẩm nổi bật
            </h2>
            <p class="lead text-muted">Khám phá các sản phẩm được ưa chuộng nhất</p>
            <div class="underline mx-auto"></div>
        </div>

        <c:choose>
            <c:when test="${not empty errorMessage}">
                 <div class="alert alert-danger text-center">${errorMessage}</div>
            </c:when>
            <c:when test="${empty top10}">
                <div class="text-center py-5 fade-in-up">
                    <div class="empty-state">
                        <i class="fa fa-box-open fa-5x text-muted mb-4"></i>
                        <h3 class="text-muted mb-3">Chưa có sản phẩm</h3>
                        <p class="text-muted">Vui lòng quay lại sau.</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4">
                    <c:forEach var="sp" items="${top10}" varStatus="status">
                        <div class="col">
                            <div class="product-card h-100 fade-in-up" 
                                 data-product-id="${sp.maSP}" 
                                 data-price="${sp.donGia}"
                                 style="animation-delay: ${status.index * 0.05}s;">
                                
                                <div class="product-image-container position-relative">
                                    <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">
                                        <img src="${pageContext.request.contextPath}/assets/img/${sp.hinhAnh}" 
                                             class="card-img-top" alt="${sp.tenSP}" 
                                             onerror="this.src='${pageContext.request.contextPath}/assets/img/no-image.png'">
                                    </a>
                                    <div class="product-badge">
                                        <span class="badge bg-danger">Hot</span>
                                    </div>
                                    <div class="product-overlay">
                                        <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}" class="btn btn-warning btn-sm">
                                            <i class="fa fa-eye"></i> Xem nhanh
                                        </a>
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
                                        <button class="btn btn-primary btn-sm w-100">
                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Call to Action Section -->
<section class="cta-section py-5" style="background: var(--gradient-primary);">
    <div class="container text-center">
        <div class="fade-in-up">
            <h2 class="text-white fw-bold mb-3">Trải nghiệm mua sắm tốt nhất</h2>
            <p class="text-white-50 mb-4">Tham gia cùng hàng ngàn khách hàng và bắt đầu mua sắm ngay hôm nay!</p>
            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-warning btn-lg">
                <i class="fa fa-user-plus"></i> Đăng ký miễn phí
            </a>
        </div>
    </div>
</section>

<style>
.hero-section .carousel-item {
    height: 450px;
}
.hero-section .carousel-item img {
    object-fit: cover;
    filter: brightness(0.6);
}
.hero-section .carousel-caption {
    background: rgba(0, 0, 0, 0.3);
    backdrop-filter: blur(5px);
    border-radius: 1rem;
    padding: 2rem;
    bottom: 15%;
}
.section-header .underline {
    width: 100px;
    height: 4px;
    background: var(--gradient-primary);
    border-radius: 2px;
}
.product-card {
    border: 1px solid #eee;
    border-radius: 0.75rem;
    overflow: hidden;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    background: white;
}
.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.1);
}
.product-image-container {
    height: 180px;
    padding: 0.5rem;
}
.product-image-container img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
}
.product-card:hover .product-image-container img {
    transform: scale(1.05);
}
.product-badge {
    position: absolute;
    top: 10px;
    left: 10px;
    z-index: 2;
}
.product-overlay {
    position: absolute;
    inset: 0;
    background: rgba(0, 0, 0, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.3s ease;
}
.product-card:hover .product-overlay {
    opacity: 1;
}
.product-name-link {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    min-height: 40px; /* Reserve space for 2 lines */
}
.empty-state {
    padding: 3rem;
    border-radius: 15px;
    background: white;
}
.cta-section {
    position: relative;
}
</style>
