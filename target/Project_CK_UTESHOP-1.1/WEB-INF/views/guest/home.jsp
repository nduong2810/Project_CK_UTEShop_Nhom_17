<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - UTESHOP</title>
    
    <style>
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
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            border: 1px solid #e0e0e0;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .product-image-container {
            height: 300px;
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .badge-hot {
            position: absolute;
            top: 15px;
            left: 15px;
            background: linear-gradient(45deg, #ff3f6c, #ff6b81);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            z-index: 2;
        }

        .btn-favorite {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: none;
            background-color: rgba(255, 255, 255, 0.8);
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 3;
            backdrop-filter: blur(5px);
        }

        .btn-favorite:hover {
            background-color: white;
            transform: scale(1.1);
            color: #ff3f6c;
        }

        .btn-favorite.active {
            background-color: #ff3f6c;
            color: white;
        }

        .btn-favorite.active .fa-heart {
            font-weight: 900; /* Solid heart */
        }

        .product-card .card-body {
            padding: 25px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-card .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            line-height: 1.4;
            margin-bottom: 15px;
            color: #333;
            min-height: 50px;
            flex-grow: 1;
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
            font-size: 1.6rem;
            font-weight: 700;
            color: #2874f0;
            margin-bottom: 10px;
            white-space: nowrap;
        }

        .product-card .sold-count {
            color: #878787;
            font-size: 0.9rem;
            white-space: nowrap;
            flex-shrink: 0;
        }

        .price-line {
            flex-wrap: wrap;
            gap: 5px;
        }

        .product-buttons {
            display: flex;
            gap: 10px;
            margin-top: auto;
        }

        .btn-add-to-cart, .btn-buy-now {
            flex: 1;
            padding: 12px 10px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-add-to-cart {
            background: linear-gradient(45deg, #2874f0, #1a5fce);
            color: white;
            border: none;
            box-shadow: 0 4px 15px rgba(40, 116, 240, 0.3);
        }

        .btn-add-to-cart:hover {
            background: linear-gradient(45deg, #1a5fce, #2874f0);
            box-shadow: 0 6px 20px rgba(40, 116, 240, 0.4);
            transform: translateY(-3px);
        }

        .btn-buy-now {
            background: linear-gradient(45deg, #ff9f00, #ff5f00);
            color: white;
            border: none;
            box-shadow: 0 4px 15px rgba(255, 159, 0, 0.3);
        }

        .btn-buy-now:hover {
            background: linear-gradient(45deg, #ff5f00, #ff9f00);
            box-shadow: 0 6px 20px rgba(255, 159, 0, 0.4);
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

        .alert-warning {
            background-color: #fffbeb;
            color: #b45309;
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

        /* Notification Animations */
        @keyframes slideInRight { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
        @keyframes slideOutRight { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }
        @keyframes shake { 
            10%, 90% { transform: translateX(-1px); } 
            20%, 80% { transform: translateX(2px); } 
            30%, 50%, 70% { transform: translateX(-4px); } 
            40%, 60% { transform: translateX(4px); } 
        }
        .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both; }
    </style>
</head>
<body>

<main>
    <!-- Hero Carousel with Multiple Slides -->
    <section class="hero-carousel">
        <!-- Slides -->
        <div class="hero-slide hero-slide-1 active">
            <div class="hero-content">
                <h1>Mua sắm thông minh cùng UTESHOP</h1>
                <p>Khám phá hàng ngàn sản phẩm chất lượng với giá tốt nhất</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-shopping-bag me-2"></i>Khám phá ngay
                </a>
            </div>
        </div>
        <div class="hero-slide hero-slide-2">
            <div class="hero-content">
                <h1>Ưu đãi hấp dẫn mỗi ngày</h1>
                <p>Giảm giá lên đến 50% cho các sản phẩm hot nhất</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-gift me-2"></i>Xem ưu đãi
                </a>
            </div>
        </div>
        <div class="hero-slide hero-slide-3">
            <div class="hero-content">
                <h1>Giao hàng siêu tốc 2 giờ</h1>
                <p>Miễn phí vận chuyển cho đơn hàng từ 500.000₫</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-shipping-fast me-2"></i>Đặt hàng ngay
                </a>
            </div>
        </div>
        <div class="hero-slide hero-slide-4">
            <div class="hero-content">
                <h1>Sản phẩm chính hãng 100%</h1>
                <p>Đảm bảo chất lượng, hoàn tiền nếu không hài lòng</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-certificate me-2"></i>Mua ngay
                </a>
            </div>
        </div>
        <div class="hero-slide hero-slide-5">
            <div class="hero-content">
                <h1>Đổi trả trong 7 ngày</h1>
                <p>Chính sách đổi trả linh hoạt, mua sắm không lo</p>
                <a href="#products" class="btn-hero">
                    <i class="fas fa-sync-alt me-2"></i>Tìm hiểu thêm
                </a>
            </div>
        </div>
        
        <!-- Navigation -->
        <div class="carousel-arrow carousel-arrow-left" onclick="prevSlide()">
            <i class="fas fa-chevron-left"></i>
        </div>
        <div class="carousel-arrow carousel-arrow-right" onclick="nextSlide()">
            <i class="fas fa-chevron-right"></i>
        </div>
        <div class="carousel-dots"></div>
    </section>

    <div class="container-fluid">
        <!-- Filter Section -->
        <section class="filter-section">
            <div class="row align-items-end">
                <div class="col-md-3 mb-3 mb-md-0">
                    <label><i class="fas fa-th me-2"></i>Danh mục sản phẩm</label>
                    <select class="form-select" id="categoryFilter" onchange="applyFilters()">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.maDM}" ${param.category == cat.maDM ? 'selected' : ''}>${cat.tenDM}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <label><i class="fas fa-dollar-sign me-2"></i>Mức giá</label>
                    <select class="form-select" id="priceFilter" onchange="applyFilters()">
                        <option value="">Tất cả</option>
                        <option value="0-100000" ${param.price == '0-100000' ? 'selected' : ''}>Dưới 100,000₫</option>
                        <option value="100000-500000" ${param.price == '100000-500000' ? 'selected' : ''}>100,000₫ - 500,000₫</option>
                        <option value="500000-1000000" ${param.price == '500000-1000000' ? 'selected' : ''}>500,000₫ - 1,000,000₫</option>
                        <option value="1000000-" ${param.price == '1000000-' ? 'selected' : ''}>Trên 1,000,000₫</option>
                    </select>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <label><i class="fas fa-sort me-2"></i>Sắp xếp theo</label>
                    <select class="form-select" id="sortFilter" onchange="applyFilters()">
                        <option value="bestseller" ${empty param.sort || param.sort == 'bestseller' ? 'selected' : ''}>Bán chạy nhất</option>
                        <option value="all" ${param.sort == 'all' ? 'selected' : ''}>Tất cả sản phẩm</option>
                        <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Giá: Thấp đến Cao</option>
                        <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Giá: Cao đến Thấp</option>
                        <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
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
                <h2>Sản phẩm của chúng tôi</h2>
                <p>Khám phá các sản phẩm chất lượng cao từ UTESHOP</p>
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
                        <h4>Chưa có sản phẩm nào</h4>
                        <p>Chúng tôi đang cập nhật sản phẩm mới. Vui lòng quay lại sau.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4" id="productsContainer">
                        <c:forEach var="sp" items="${products}" varStatus="status">
                            <div class="col">
                                <div class="product-card">
                                    <div class="product-image-container">
                                        <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">
                                            <img src="${pageContext.request.contextPath}/assets/img/${sp.hinhAnh}"
                                                 alt="${sp.tenSP}"
                                                 class="product-image"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
                                        </a>
                                        <c:if test="${hotProductIds.contains(sp.maSP)}">
                                            <div class="badge-hot">HOT</div>
                                        </c:if>
                                        <button class="btn-favorite" onclick="toggleFavorite(event, this, ${sp.maSP}, ${empty sessionScope.account})">
                                            <i class="far fa-heart"></i>
                                        </button>
                                    </div>
                                    
                                    <div class="card-body">
                                        <h6 class="card-title">
                                            <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">${sp.tenSP}</a>
                                        </h6>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3 price-line">
                                            <div class="price">
                                                <fmt:formatNumber value="${sp.donGia}" type="number" groupingUsed="true"/>₫
                                            </div>
                                            <small class="sold-count">
                                                <i class="fas fa-shopping-cart me-1"></i>
                                                ${sp.soLuongBan} đã bán
                                            </small>
                                        </div>
                                        
                                        <div class="product-buttons">
                                            <button class="btn btn-add-to-cart" onclick="addToCart(${sp.maSP}, ${empty sessionScope.account})">
                                                <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
                                            </button>
                                            <button class="btn btn-buy-now" onclick="buyNow(${sp.maSP}, ${empty sessionScope.account})">
                                                <i class="fas fa-bolt me-2"></i>Mua Ngay
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- DEBUG INFO FOR PAGINATION -->
                    <p class="text-center mt-3 text-muted">
                        Debug: Current Page: ${currentPage}, Total Pages: ${totalPages}, Total Products: ${totalProducts}, Products on this page: ${fn:length(products)}
                    </p>

                    <%-- Build the query string for filter parameters to be used in pagination links --%>
                    <c:url var="basePaginationUrl" value="/guest/home" />
                    <c:set var="filterParams" value="" />
                    <c:if test="${not empty param.category}"><c:set var="filterParams" value="${filterParams}&category=${param.category}" /></c:if>
                    <c:if test="${not empty param.price}"><c:set var="filterParams" value="${filterParams}&price=${param.price}" /></c:if>
                    <c:if test="${not empty param.sort}"><c:set var="filterParams" value="${filterParams}&sort=${param.sort}" /></c:if>

                    <!-- Pagination Controls -->
                    <nav aria-label="Product Pagination" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${basePaginationUrl}?page=${currentPage - 1}${filterParams}" tabindex="-1" aria-disabled="${currentPage == 1}">Trước</a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="${basePaginationUrl}?page=${i}${filterParams}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${basePaginationUrl}?page=${currentPage + 1}${filterParams}">Sau</a>
                            </li>
                        </ul>
                    </nav>

                </c:otherwise>
            </c:choose>
        </section>
    </div>
</main>

<script>
//<![CDATA[
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
});

// Hero Carousel JavaScript
let currentSlide = 0;
const slides = document.querySelectorAll('.hero-slide');
const dotsContainer = document.querySelector('.carousel-dots');
const totalSlides = slides.length;
let slideInterval;

function createDots() {
    for (let i = 0; i < totalSlides; i++) {
        const dot = document.createElement('div');
        dot.classList.add('carousel-dot');
        dot.addEventListener('click', () => goToSlide(i));
        dotsContainer.appendChild(dot);
    }
}

function updateSlide() {
    slides.forEach((slide, index) => {
        slide.classList.toggle('active', index === currentSlide);
    });
    const dots = document.querySelectorAll('.carousel-dot');
    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentSlide);
    });
}

function nextSlide() {
    currentSlide = (currentSlide + 1) % totalSlides;
    updateSlide();
}

function prevSlide() {
    currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
    updateSlide();
}

function goToSlide(slideIndex) {
    currentSlide = slideIndex;
    updateSlide();
    startAutoSlide(); // Restart interval on manual navigation
}

function startAutoSlide() {
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 5000);
}

document.addEventListener('DOMContentLoaded', function() {
    if (totalSlides > 0) {
        createDots();
        updateSlide();
        startAutoSlide();
        
        const carousel = document.querySelector('.hero-carousel');
        carousel.addEventListener('mouseenter', () => clearInterval(slideInterval));
        carousel.addEventListener('mouseleave', startAutoSlide);
    }
});


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

// Function to require login
function requireLogin() {
    showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning');
}

// Utility functions for product interactions
function addToCart(productId, isGuest) {
    if (isGuest) {
        requireLogin();
        return;
    }
    console.log('DEBUG JS: 🛒 Adding to cart: ' + productId);
    showNotification('Sản phẩm đã được thêm vào giỏ hàng!', 'success');
}

function buyNow(productId, isGuest) {
    if (isGuest) {
        requireLogin();
        return;
    }
    console.log('DEBUG JS: ⚡ Buying now: ' + productId);
    showNotification('Chuyển đến trang thanh toán...', 'info');
    // window.location.href = '${pageContext.request.contextPath}/checkout?productId=' + productId;
}

function toggleFavorite(event, button, productId, isGuest) {
    event.stopPropagation();
    event.preventDefault();

    if (isGuest) {
        requireLogin();
        return;
    }

    console.log('DEBUG JS: ❤️ Toggling favorite for product: ' + productId);
    button.classList.toggle('active');
    
    const icon = button.querySelector('i');
    if (button.classList.contains('active')) {
        icon.classList.remove('far');
        icon.classList.add('fas');
        showNotification('Đã thêm vào danh sách yêu thích!', 'success');
    } else {
        icon.classList.remove('fas');
        icon.classList.add('far');
        showNotification('Đã xóa khỏi danh sách yêu thích.', 'info');
    }
}

function applyFilters() {
    console.log('DEBUG JS: 🔍 Applying filters...');
    
    const category = document.getElementById('categoryFilter').value;
    const price = document.getElementById('priceFilter').value;
    const sort = document.getElementById('sortFilter').value;
    
    const params = new URLSearchParams(window.location.search);
    if (category) params.set('category', category); else params.delete('category');
    if (price) params.set('price', price); else params.delete('price');
    if (sort) params.set('sort', sort); else params.delete('sort');
    params.delete('page');

    const queryString = params.toString();
    window.location.href = window.location.pathname + (queryString ? '?' + queryString : '');
}

function showNotification(message, type) {
    var notificationType = type || 'info';

    console.log('DEBUG: showNotification called with message:', message, 'type:', notificationType);

    var iconMap = {
        success: 'fa-check-circle',
        info: 'fa-info-circle',
        warning: 'fa-exclamation-triangle',
        danger: 'fa-exclamation-circle'
    };
    var iconClass = iconMap[notificationType] || 'fa-info-circle';

    var notification = document.createElement('div');
    notification.className = 'alert alert-' + notificationType + ' position-fixed d-flex align-items-center';
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

    setTimeout(function() {
        if (notification.parentElement) {
            notification.style.animation = 'slideOutRight 0.3s ease-in forwards';
            notification.addEventListener('animationend', function() { 
                if(notification.parentElement) { 
                    notification.remove(); 
                }
            });
        }
    }, 5000); // Changed to 5000 milliseconds (5 seconds)
}

console.log('DEBUG JS: 🎉 UTESHOP Home page JavaScript loaded successfully!');
//]]>
</script>
</body>
</html>