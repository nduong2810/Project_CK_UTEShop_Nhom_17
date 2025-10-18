<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- DEBUG INFO - XÓA SAU KHI HOÀN THÀNH -->
<% 
    System.out.println("=== JSP DEBUG INFO ===");
    System.out.println("Products attribute: " + request.getAttribute("products"));
    System.out.println("Categories attribute: " + request.getAttribute("categories"));
    System.out.println("TotalProducts attribute: " + request.getAttribute("totalProducts"));
    System.out.println("ErrorMessage attribute: " + request.getAttribute("errorMessage"));
    
    java.util.List products = (java.util.List) request.getAttribute("products");
    if (products != null) {
        System.out.println("Products list size in JSP: " + products.size());
    } else {
        System.out.println("Products list is NULL in JSP!");
    }
    System.out.println("======================");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- DEBUG: Thêm console log để kiểm tra -->
    <script>
        console.log("=== JSP LOADED ===");
        console.log("Products count: ${fn:length(products)}");
        console.log("Total products: ${totalProducts}");
        console.log("ShowAll: ${showAll}");
        console.log("Error message: ${errorMessage}");
    </script>
    
    <style>
        body {
            background: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Modern Multi-Slide Hero Carousel */
        .hero-carousel {
            position: relative;
            width: 100%;
            height: 500px;
            overflow: hidden;
            margin-bottom: 40px;
        }
        
        .hero-slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 1s ease-in-out;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
        }
        
        .hero-slide.active {
            opacity: 1;
            z-index: 1;
        }
        
        /* Slide 1 - Blue Gradient */
        .hero-slide-1 {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        /* Slide 2 - Green Gradient */
        .hero-slide-2 {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }
        
        /* Slide 3 - Orange Gradient */
        .hero-slide-3 {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        
        /* Slide 4 - Teal Gradient */
        .hero-slide-4 {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        
        /* Slide 5 - Purple Gradient */
        .hero-slide-5 {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            padding: 0 20px;
            animation: slideInUp 1s ease-out;
        }
        
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero-slide h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
            animation: fadeInDown 1s ease-out;
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero-slide p {
            font-size: 1.3rem;
            margin-bottom: 35px;
            opacity: 0.95;
            line-height: 1.8;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.2);
            animation: fadeIn 1s ease-out 0.3s both;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .btn-hero {
            background: white;
            color: #667eea;
            padding: 16px 50px;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            display: inline-block;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            overflow: hidden;
            animation: fadeIn 1s ease-out 0.6s both;
        }
        
        .hero-slide-2 .btn-hero {
            color: #11998e;
        }
        
        .hero-slide-3 .btn-hero {
            color: #f5576c;
        }
        
        .hero-slide-4 .btn-hero {
            color: #4facfe;
        }
        
        .hero-slide-5 .btn-hero {
            color: #fa709a;
        }
        
        .btn-hero::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(0, 0, 0, 0.1);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .btn-hero:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-hero:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 8px 30px rgba(0,0,0,0.4);
        }
        
        .btn-hero i {
            transition: transform 0.3s ease;
        }
        
        .btn-hero:hover i {
            transform: translateX(5px);
        }
        
        /* Carousel Navigation Dots */
        .carousel-dots {
            position: absolute;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 12px;
            z-index: 10;
        }
        
        .carousel-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .carousel-dot:hover {
            background: rgba(255, 255, 255, 0.8);
            transform: scale(1.2);
        }
        
        .carousel-dot.active {
            background: white;
            width: 40px;
            border-radius: 10px;
            border-color: white;
        }
        
        /* Carousel Navigation Arrows */
        .carousel-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.3);
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 10;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.5);
        }
        
        .carousel-arrow:hover {
            background: rgba(255, 255, 255, 0.5);
            transform: translateY(-50%) scale(1.1);
        }
        
        .carousel-arrow-left {
            left: 30px;
        }
        
        .carousel-arrow-right {
            right: 30px;
        }
        
        .carousel-arrow i {
            font-size: 1.2rem;
        }
        
        /* Floating decorative elements */
        .hero-slide::before {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            top: -100px;
            left: -100px;
            animation: float 20s ease-in-out infinite;
        }
        
        .hero-slide::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            bottom: -150px;
            right: -150px;
            animation: float 25s ease-in-out infinite;
            animation-delay: -5s;
        }
        
        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            25% {
                transform: translateY(-30px) rotate(90deg);
            }
            50% {
                transform: translateY(0) rotate(180deg);
            }
            75% {
                transform: translateY(30px) rotate(270deg);
            }
        }

        /* Filter Section */
        .filter-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 40px;
        }

        .filter-section .form-select {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 10px 15px;
            font-size: 0.95rem;
        }

        .filter-section .form-select:focus {
            border-color: #2874f0;
            box-shadow: 0 0 0 3px rgba(40, 116, 240, 0.1);
        }

        .filter-section label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
            font-size: 0.9rem;
        }

        .btn-apply-filter {
            background: #2874f0;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
        }

        .btn-apply-filter:hover {
            background: #1557bf;
            transform: translateY(-2px);
        }

        /* Section Header */
        .section-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .section-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }

        .section-header p {
            font-size: 1.1rem;
            color: #666;
        }

        /* Product Card */
        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .product-image-container {
            height: 240px;
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .product-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .badge-hot {
            position: absolute;
            top: 12px;
            left: 12px;
            background: #ff3f6c;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            z-index: 2;
        }

        .product-card .card-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-card .card-title {
            font-size: 1rem;
            font-weight: 600;
            line-height: 1.4;
            margin-bottom: 12px;
            color: #333;
            min-height: 44px;
        }

        .product-card .card-title a {
            color: inherit;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .product-card .card-title a:hover {
            color: #2874f0;
        }

        .product-card .price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2874f0;
            margin-bottom: 8px;
        }

        .product-card .sold-count {
            color: #878787;
            font-size: 0.85rem;
        }

        .btn-add-to-cart {
            background: #ff3f6c;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: auto;
        }

        .btn-add-to-cart:hover {
            background: #e63854;
            transform: translateY(-2px);
        }

        .btn-load-more {
            background: white;
            color: #2874f0;
            border: 2px solid #2874f0;
            padding: 14px 50px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .btn-load-more:hover {
            background: #2874f0;
            color: white;
            transform: translateY(-3px);
        }

        /* Alert Styles */
        .alert {
            border-radius: 12px;
            border: none;
        }

        .alert-danger {
            background: #fff5f5;
            color: #c53030;
        }

        .alert-secondary {
            background: #f7fafc;
            color: #4a5568;
        }

        /* Fade Animation */
        .fade-in-up {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .fade-in-up.is-visible {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2rem;
            }
            .hero-section p {
                font-size: 1rem;
            }
            .section-header h2 {
                font-size: 2rem;
            }
            .filter-section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main>
    <!-- Hero Carousel with Multiple Slides -->
    <section class="hero-carousel">
        <!-- Slide 1 - Blue Purple -->
        <div class="hero-slide hero-slide-1 active">
            <div class="hero-content">
                <h1>Mua sắm thông minh cùng UTESHOP</h1>
                <p>Khám phá hàng ngàn sản phẩm chất lượng với giá tốt nhất</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-shopping-bag me-2"></i>Khám phá ngay
                </a>
            </div>
        </div>
        
        <!-- Slide 2 - Green -->
        <div class="hero-slide hero-slide-2">
            <div class="hero-content">
                <h1>Ưu đãi hấp dẫn mỗi ngày</h1>
                <p>Giảm giá lên đến 50% cho các sản phẩm hot nhất</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-gift me-2"></i>Xem ưu đãi
                </a>
            </div>
        </div>
        
        <!-- Slide 3 - Pink Orange -->
        <div class="hero-slide hero-slide-3">
            <div class="hero-content">
                <h1>Giao hàng siêu tốc 2 giờ</h1>
                <p>Miễn phí vận chuyển cho đơn hàng từ 500.000đ</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-shipping-fast me-2"></i>Đặt hàng ngay
                </a>
            </div>
        </div>
        
        <!-- Slide 4 - Cyan Blue -->
        <div class="hero-slide hero-slide-4">
            <div class="hero-content">
                <h1>Sản phẩm chính hãng 100%</h1>
                <p>Đảm bảo chất lượng, hoàn tiền nếu không hài lòng</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-certificate me-2"></i>Mua ngay
                </a>
            </div>
        </div>
        
        <!-- Slide 5 - Pink Yellow -->
        <div class="hero-slide hero-slide-5">
            <div class="hero-content">
                <h1>Đổi trả trong 7 ngày</h1>
                <p>Chính sách đổi trả linh hoạt, mua sắm không lo</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-sync-alt me-2"></i>Tìm hiểu thêm
                </a>
            </div>
        </div>
        
        <!-- Navigation Arrows -->
        <div class="carousel-arrow carousel-arrow-left" onclick="prevSlide()">
            <i class="fas fa-chevron-left"></i>
        </div>
        <div class="carousel-arrow carousel-arrow-right" onclick="nextSlide()">
            <i class="fas fa-chevron-right"></i>
        </div>
        
        <!-- Navigation Dots -->
        <div class="carousel-dots">
            <div class="carousel-dot active" onclick="goToSlide(0)"></div>
            <div class="carousel-dot" onclick="goToSlide(1)"></div>
            <div class="carousel-dot" onclick="goToSlide(2)"></div>
            <div class="carousel-dot" onclick="goToSlide(3)"></div>
            <div class="carousel-dot" onclick="goToSlide(4)"></div>
        </div>
    </section>

    <div class="container">
        <!-- Filter Section -->
        <section class="filter-section">
            <div class="row align-items-end">
                <div class="col-md-3 mb-3 mb-md-0">
                    <label><i class="fas fa-th me-2"></i>Danh mục sản phẩm</label>
                    <select class="form-select" id="categoryFilter">
                        <option value="">Tất cả danh mục</option>
                        <c:if test="${not empty categories}">
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.maDM}">${cat.tenDM}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <label><i class="fas fa-dollar-sign me-2"></i>Mức giá</label>
                    <select class="form-select" id="priceFilter">
                        <option value="">Tất cả</option>
                        <option value="0-100000">Dưới 100,000₫</option>
                        <option value="100000-500000">100,000₫ - 500,000₫</option>
                        <option value="500000-1000000">500,000₫ - 1,000,000₫</option>
                        <option value="1000000-5000000">Trên 1,000,000₫</option>
                    </select>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <label><i class="fas fa-sort me-2"></i>Sắp xếp theo</label>
                    <select class="form-select" id="sortFilter">
                        <option value="bestseller">Bán chạy nhất</option>
                        <option value="price-asc">Giá: Thấp đến Cao</option>
                        <option value="price-desc">Giá: Cao đến Thấp</option>
                        <option value="newest">Mới nhất</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-apply-filter" onclick="applyFilters()">
                        <i class="fas fa-filter me-2"></i>Áp dụng
                    </button>
                </div>
            </div>
        </section>

        <!-- Products Section -->
        <section id="products" class="mb-5">
            <div class="section-header">
                <c:choose>
                    <c:when test="${showAll}">
                        <h2>Tất cả sản phẩm</h2>
                        <p>Khám phá toàn bộ bộ sưu tập của chúng tôi</p>
                    </c:when>
                    <c:otherwise>
                        <h2>Sản phẩm nổi bật</h2>
                        <p>Những sản phẩm được yêu thích nhất tại UTESHOP</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:choose>
                <c:when test="${not empty errorMessage}">
                    <div class="alert alert-danger text-center py-5">
                        <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                        <h4>Đã xảy ra lỗi</h4>
                        <p>${errorMessage}</p>
                    </div>
                </c:when>
                <c:when test="${empty products}">
                    <div class="alert alert-secondary text-center py-5">
                        <i class="fas fa-box-open fa-3x mb-3"></i>
                        <h4>Chưa có sản phẩm</h4>
                        <p>Chúng tôi đang cập nhật sản phẩm mới. Vui lòng quay lại sau.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row" id="productsContainer">
                        <c:forEach var="sp" items="${products}" varStatus="status">
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="product-card">
                                    <c:if test="${!showAll && status.index < 3}">
                                        <div class="badge-hot">
                                            <i class="fas fa-fire me-1"></i> HOT
                                        </div>
                                    </c:if>
                                    
                                    <div class="product-image-container">
                                        <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">
                                            <img src="${pageContext.request.contextPath}/img/${sp.hinhAnh}"
                                                 alt="${sp.tenSP}"
                                                 class="product-image"
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
                                        </a>
                                    </div>
                                    
                                    <div class="card-body">
                                        <h6 class="card-title">
                                            <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">${sp.tenSP}</a>
                                        </h6>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div class="price">
                                                <fmt:formatNumber value="${sp.donGia}" type="number" groupingUsed="true"/>₫
                                            </div>
                                            <small class="sold-count">
                                                <i class="fas fa-shopping-cart me-1"></i>
                                                ${sp.soLuongBan} đã bán
                                            </small>
                                        </div>
                                        
                                        <button class="btn btn-add-to-cart" onclick="addToCart(${sp.maSP})">
                                            <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <c:if test="${!showAll && fn:length(products) < totalProducts}">
                        <div class="text-center mt-5">
                            <a href="${pageContext.request.contextPath}/guest/home?showAll=true" class="btn-load-more">
                                <i class="fas fa-plus-circle me-2"></i>Xem tất cả sản phẩm
                            </a>
                            <p class="text-muted mt-3">
                                <small>Hiển thị ${fn:length(products)} / ${totalProducts} sản phẩm</small>
                            </p>
                        </div>
                    </c:if>
                    
                    <c:if test="${showAll}">
                        <div class="text-center mt-5">
                            <p class="text-muted">
                                <i class="fas fa-check-circle me-2 text-success"></i>
                                Đã hiển thị tất cả ${totalProducts} sản phẩm
                            </p>
                            <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-link">
                                <i class="fas fa-arrow-left me-2"></i>Quay về trang chủ
                            </a>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Fade in animation
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('is-visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.fade-in-up').forEach(el => {
        observer.observe(el);
    });
    
    // Category filter redirect
    const categoryFilter = document.getElementById('categoryFilter');
    if (categoryFilter) {
        categoryFilter.addEventListener('change', function() {
            if (this.value) {
                window.location.href = `${pageContext.request.contextPath}/guest/category?id=` + this.value;
            }
        });
    }
});

// Hero Carousel JavaScript
let currentSlide = 0;
const totalSlides = 5;
let slideInterval;

// Initialize carousel when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log('🎠 Initializing Hero Carousel...');
    startAutoSlide();
    
    // Pause auto-slide when hovering over carousel
    const carousel = document.querySelector('.hero-carousel');
    if (carousel) {
        carousel.addEventListener('mouseenter', stopAutoSlide);
        carousel.addEventListener('mouseleave', startAutoSlide);
    }
});

/**
 * Start automatic slide transition
 */
function startAutoSlide() {
    console.log('▶️ Starting auto-slide');
    stopAutoSlide(); // Clear any existing interval
    slideInterval = setInterval(() => {
        nextSlide();
    }, 4000); // Change slide every 4 seconds
}

/**
 * Stop automatic slide transition
 */
function stopAutoSlide() {
    if (slideInterval) {
        console.log('⏹️ Stopping auto-slide');
        clearInterval(slideInterval);
        slideInterval = null;
    }
}

/**
 * Go to next slide
 */
function nextSlide() {
    currentSlide = (currentSlide + 1) % totalSlides;
    updateSlide();
    console.log('➡️ Next slide:', currentSlide);
}

/**
 * Go to previous slide
 */
function prevSlide() {
    currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
    updateSlide();
    console.log('⬅️ Previous slide:', currentSlide);
}

/**
 * Go to specific slide
 * @param {number} slideIndex - Index of slide to go to (0-based)
 */
function goToSlide(slideIndex) {
    if (slideIndex >= 0 && slideIndex < totalSlides) {
        currentSlide = slideIndex;
        updateSlide();
        console.log('🎯 Go to slide:', currentSlide);
        
        // Restart auto-slide timer
        startAutoSlide();
    }
}

/**
 * Update active slide and dots
 */
function updateSlide() {
    // Remove active class from all slides
    const slides = document.querySelectorAll('.hero-slide');
    slides.forEach((slide, index) => {
        if (index === currentSlide) {
            slide.classList.add('active');
        } else {
            slide.classList.remove('active');
        }
    });
    
    // Update navigation dots
    const dots = document.querySelectorAll('.carousel-dot');
    dots.forEach((dot, index) => {
        if (index === currentSlide) {
            dot.classList.add('active');
        } else {
            dot.classList.remove('active');
        }
    });
}

/**
 * Add smooth scroll to product section when clicking hero buttons
 */
document.addEventListener('DOMContentLoaded', function() {
    const heroButtons = document.querySelectorAll('.btn-hero[href="#products"]');
    heroButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const productsSection = document.querySelector('#products');
            if (productsSection) {
                productsSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// Utility functions for product interactions
function addToCart(productId) {
    console.log('🛒 Adding to cart:', productId);
    
    // TODO: Implement add to cart functionality
    // This is a placeholder - you can implement actual cart logic here
    
    // Show temporary notification
    showNotification('Sản phẩm đã được thêm vào giỏ hàng!', 'success');
}

function applyFilters() {
    console.log('🔍 Applying filters...');
    
    const category = document.getElementById('categoryFilter').value;
    const price = document.getElementById('priceFilter').value;
    const sort = document.getElementById('sortFilter').value;
    
    // Build query string
    const params = new URLSearchParams();
    if (category) params.append('category', category);
    if (price) params.append('price', price);
    if (sort) params.append('sort', sort);
    
    // Redirect with filters
    const queryString = params.toString();
    const url = queryString ? 
        `${window.location.pathname}?${queryString}` : 
        window.location.pathname;
    
    window.location.href = url;
}

function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = 'alert alert-' + (type === 'success' ? 'success' : 'info') + ' position-fixed';
    notification.style.cssText = `
        top: 20px; 
        right: 20px; 
        z-index: 9999; 
        min-width: 300px;
        animation: slideInRight 0.3s ease-out;
    `;
    notification.innerHTML = 
        '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'info-circle') + ' me-2"></i>' +
        message +
        '<button type="button" class="btn-close ms-2" onclick="this.parentElement.remove()"></button>';
    
    document.body.appendChild(notification);
    
    // Auto remove after 3 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.style.animation = 'slideOutRight 0.3s ease-in';
            setTimeout(() => notification.remove(), 300);
        }
    }, 3000);
}

// Add CSS for notification animations
const notificationStyles = document.createElement('style');
notificationStyles.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
`;
document.head.appendChild(notificationStyles);

console.log('🎉 UTESHOP Home page JavaScript loaded successfully!');
</script>
</body>
</html>