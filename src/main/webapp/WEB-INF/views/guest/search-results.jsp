<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Kết quả tìm kiếm - UTESHOP</title>
    <style>
        .search-results-page {
            background: #f8f9fa;
            min-height: calc(100vh - 200px);
            padding: 2rem 0;
        }

        .search-header {
            background: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .search-info {
            font-size: 1.5rem;
            color: #333;
            font-weight: 600;
        }

        .filter-section {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .filter-title {
            font-weight: 600;
            color: #667eea;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            cursor: pointer;
        }

        .product-body {
            padding: 1rem;
        }

        .product-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            min-height: 3rem;
        }

        .product-price {
            color: #ff6b6b;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .product-store {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .product-sold {
            color: #999;
            font-size: 0.85rem;
        }

        .favorite-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .favorite-btn:hover {
            transform: scale(1.1);
        }

        .favorite-btn i {
            font-size: 1.2rem;
        }

        .favorite-btn.active i {
            color: #ff6b6b;
        }

        .no-results {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }

        .no-results i {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 1rem;
        }

        .pagination {
            justify-content: center;
            margin-top: 2rem;
        }

        .pagination .page-link {
            color: #667eea;
            border: 1px solid #dee2e6;
            margin: 0 3px;
            border-radius: 8px;
        }

        .pagination .page-link:hover {
            background: #667eea;
            color: white;
        }

        .pagination .active .page-link {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: #667eea;
        }

        .filter-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: #f0f0f0;
            border-radius: 20px;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .filter-badge .remove {
            margin-left: 0.5rem;
            color: #999;
            cursor: pointer;
            text-decoration: none;
        }

        .filter-badge .remove:hover {
            color: #ff6b6b;
        }
    </style>
</head>

<body>
<div class="search-results-page">
    <!-- Search Header -->
    <div class="search-header">
        <div class="container">
            <div class="search-info">
                <i class="fas fa-search me-2"></i>${searchInfo}
            </div>
            
            <!-- Active Filters Display -->
            <div class="mt-3">
                <c:if test="${not empty keyword}">
                    <span class="filter-badge">
                        Từ khóa: ${keyword}
                        <a href="${pageContext.request.contextPath}/guest/search" class="remove">
                            <i class="fas fa-times"></i>
                        </a>
                    </span>
                </c:if>
                <c:if test="${not empty selectedCategory}">
                    <c:forEach var="cat" items="${categories}">
                        <c:if test="${cat.maDM == selectedCategory}">
                            <span class="filter-badge">
                                Danh mục: ${cat.tenDM}
                                <a href="?keyword=${keyword}&price=${selectedPrice}&sort=${selectedSort}" class="remove">
                                    <i class="fas fa-times"></i>
                                </a>
                            </span>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${not empty selectedPrice}">
                    <span class="filter-badge">
                        Giá: 
                        <c:choose>
                            <c:when test="${selectedPrice == '0-100000'}">Dưới 100.000đ</c:when>
                            <c:when test="${selectedPrice == '100000-500000'}">100.000đ - 500.000đ</c:when>
                            <c:when test="${selectedPrice == '500000-1000000'}">500.000đ - 1.000.000đ</c:when>
                            <c:when test="${selectedPrice == '1000000-'}">Trên 1.000.000đ</c:when>
                        </c:choose>
                        <a href="?keyword=${keyword}&category=${selectedCategory}&sort=${selectedSort}" class="remove">
                            <i class="fas fa-times"></i>
                        </a>
                    </span>
                </c:if>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Filter Section -->
        <div class="filter-section">
            <form method="GET" action="${pageContext.request.contextPath}/guest/search" id="filterForm">
                <input type="hidden" name="keyword" value="${keyword}">
                
                <div class="row">
                    <!-- Category Filter -->
                    <div class="col-md-3">
                        <div class="filter-title"><i class="fas fa-tag me-2"></i>Danh mục</div>
                        <select name="category" class="form-select" onchange="document.getElementById('filterForm').submit()">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.maDM}" ${selectedCategory == cat.maDM ? 'selected' : ''}>
                                    ${cat.tenDM}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Price Filter -->
                    <div class="col-md-3">
                        <div class="filter-title"><i class="fas fa-dollar-sign me-2"></i>Khoảng giá</div>
                        <select name="price" class="form-select" onchange="document.getElementById('filterForm').submit()">
                            <option value="">Tất cả giá</option>
                            <option value="0-100000" ${selectedPrice == '0-100000' ? 'selected' : ''}>Dưới 100.000đ</option>
                            <option value="100000-500000" ${selectedPrice == '100000-500000' ? 'selected' : ''}>100.000đ - 500.000đ</option>
                            <option value="500000-1000000" ${selectedPrice == '500000-1000000' ? 'selected' : ''}>500.000đ - 1.000.000đ</option>
                            <option value="1000000-" ${selectedPrice == '1000000-' ? 'selected' : ''}>Trên 1.000.000đ</option>
                        </select>
                    </div>

                    <!-- Sort Filter -->
                    <div class="col-md-3">
                        <div class="filter-title"><i class="fas fa-sort me-2"></i>Sắp xếp</div>
                        <select name="sort" class="form-select" onchange="document.getElementById('filterForm').submit()">
                            <option value="">Mới nhất</option>
                            <option value="bestseller" ${selectedSort == 'bestseller' ? 'selected' : ''}>Bán chạy</option>
                            <option value="price-asc" ${selectedSort == 'price-asc' ? 'selected' : ''}>Giá thấp đến cao</option>
                            <option value="price-desc" ${selectedSort == 'price-desc' ? 'selected' : ''}>Giá cao đến thấp</option>
                            <option value="name-asc" ${selectedSort == 'name-asc' ? 'selected' : ''}>Tên A-Z</option>
                            <option value="name-desc" ${selectedSort == 'name-desc' ? 'selected' : ''}>Tên Z-A</option>
                        </select>
                    </div>

                    <!-- Reset Button -->
                    <div class="col-md-3">
                        <div class="filter-title">&nbsp;</div>
                        <a href="${pageContext.request.contextPath}/guest/search" class="btn btn-outline-secondary w-100">
                            <i class="fas fa-redo me-2"></i>Xóa bộ lọc
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <!-- Products Grid -->
        <c:choose>
            <c:when test="${not empty searchResults}">
                <div class="product-grid">
                    <c:forEach var="product" items="${searchResults}">
                        <div class="product-card">
                            <button class="favorite-btn ${favoriteProductIds.contains(product.maSP) ? 'active' : ''}" 
                                    onclick="toggleFavorite(${product.maSP}, this)">
                                <i class="fas fa-heart"></i>
                            </button>
                            
                            <img src="${pageContext.request.contextPath}/assets/img/${product.hinhAnh}" 
                                 alt="${product.tenSP}"
                                 class="product-image"
                                 onclick="location.href='${pageContext.request.contextPath}/guest/product?id=${product.maSP}'"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo-UTESHOP.png'"/>
                            
                            <div class="product-body">
                                <div class="product-name">
                                    <a href="${pageContext.request.contextPath}/guest/product?id=${product.maSP}" 
                                       class="text-decoration-none text-dark">
                                        ${product.tenSP}
                                    </a>
                                </div>
                                
                                <div class="product-price">
                                    <fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="₫"/>
                                </div>
                                
                                <div class="product-store">
                                    <i class="fas fa-store me-1"></i>
                                    ${product.cuaHang.tenCH}
                                </div>
                                
                                <div class="product-sold">
                                    <i class="fas fa-shopping-cart me-1"></i>
                                    Đã bán: ${product.soLuongBan}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Search results pagination">
                        <ul class="pagination">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?keyword=${keyword}&category=${selectedCategory}&price=${selectedPrice}&sort=${selectedSort}&page=${currentPage - 1}">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:if test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="?keyword=${keyword}&category=${selectedCategory}&price=${selectedPrice}&sort=${selectedSort}&page=${i}">
                                            ${i}
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${i == currentPage - 3 || i == currentPage + 3}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?keyword=${keyword}&category=${selectedCategory}&price=${selectedPrice}&sort=${selectedSort}&page=${currentPage + 1}">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="no-results">
                    <i class="fas fa-search"></i>
                    <h3>Không tìm thấy kết quả nào</h3>
                    <p class="text-muted">Vui lòng thử lại với từ khóa khác hoặc điều chỉnh bộ lọc</p>
                    <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary mt-3">
                        <i class="fas fa-home me-2"></i>Về trang chủ
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleFavorite(productId, button) {
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    fetch('${pageContext.request.contextPath}/user/favorites/toggle', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'productId=' + productId
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            button.classList.toggle('active');
                        } else {
                            alert(data.message || 'Có lỗi xảy ra');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi thêm/xóa yêu thích');
                    });
                </c:when>
                <c:otherwise>
                    alert('Vui lòng đăng nhập để sử dụng tính năng này');
                    window.location.href = '${pageContext.request.contextPath}/auth/login';
                </c:otherwise>
            </c:choose>
        }
    </script>
</div>
</body>
