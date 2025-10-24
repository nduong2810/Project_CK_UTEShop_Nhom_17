<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:if test="${not empty category}">
        <title>Danh mục: ${category.tenDM} - UTESHOP</title>
    </c:if>
    <c:if test="${empty category}">
        <title>Tất cả sản phẩm - UTESHOP</title>
    </c:if>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Breadcrumb Styles */
        .breadcrumb {
            background-color: #f8f9fa;
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

        /* Custom Pagination Styles */
        .pagination .page-item .page-link {
            color: #6c757d;
            border-radius: 50%;
            margin: 0 5px;
            border: none;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .pagination .page-item.active .page-link {
            background-color: #2874f0;
            color: white;
            box-shadow: 0 4px 10px rgba(40, 116, 240, 0.4);
            transform: translateY(-2px);
        }

        .pagination .page-item.disabled .page-link {
            color: #ced4da;
            background-color: transparent;
        }

        .pagination .page-item .page-link:hover {
            background-color: #e9ecef;
            color: #2874f0;
        }

        .pagination .page-item.active .page-link:hover {
            background-color: #1557bf;
        }

        /* Product Card Styles */
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
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-image {
            width: 100%;
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

        /* Filter Section Styles */
        .filter-section {
            background: #fff;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        /* Alert Styles */
        .alert {
            border-radius: 12px;
            border: none;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        .alert-warning {
            background-color: #fffbeb;
            color: #b45309;
        }
        .alert-danger {
            background: #fff5f5;
            color: #c53030;
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

<div class="container my-5">
    <!-- Breadcrumbs -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/guest/home'/>">Trang chủ</a></li>
            <c:choose>
                <c:when test="${not empty category}">
                    <li class="breadcrumb-item active" aria-current="page">${category.tenDM}</li>
                </c:when>
                <c:otherwise>
                    <li class="breadcrumb-item active" aria-current="page">Tất cả sản phẩm</li>
                </c:otherwise>
            </c:choose>
        </ol>
    </nav>

    <div class="section-header mb-5">
        <c:choose>
            <c:when test="${not empty category}">
                <h1 class="display-5 fw-bold text-primary">${category.tenDM}</h1>
                <p class="lead text-muted">${category.moTa}</p>
            </c:when>
            <c:otherwise>
                <h1 class="display-5 fw-bold text-primary">Tất cả sản phẩm</h1>
                <p class="lead text-muted">Khám phá toàn bộ sản phẩm có tại UTESHOP</p>
            </c:otherwise>
        </c:choose>
        <hr>
    </div>

    <!-- Filter Section -->
    <div class="filter-section mb-4">
        <div class="row align-items-end">
            <div class="col-md-3 mb-3 mb-md-0">
                <label for="categoryFilter" class="form-label fw-bold"><i class="fa fa-filter me-2"></i>Danh mục</label>
                <select class="form-select" id="categoryFilter">
                    <option value="all">Tất cả danh mục</option>
                    <c:forEach var="cat" items="${allCategories}">
                        <option value="${cat.maDM}" ${cat.maDM == param.category ? 'selected' : ''}>
                            ${cat.tenDM}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 mb-3 mb-md-0">
                <label for="priceFilter" class="form-label fw-bold"><i class="fa fa-dollar-sign me-2"></i>Khoảng giá</label>
                <select class="form-select" id="priceFilter">
                    <option value="">Tất cả</option>
                    <option value="0-100000" ${param.price == '0-100000' ? 'selected' : ''}>Dưới 100,000₫</option>
                    <option value="100000-500000" ${param.price == '100000-500000' ? 'selected' : ''}>100,000₫ - 500,000₫</option>
                    <option value="500000-1000000" ${param.price == '500000-1000000' ? 'selected' : ''}>500,000₫ - 1,000,000₫</option>
                    <option value="1000000-" ${param.price == '1000000-' ? 'selected' : ''}>Trên 1,000,000₫</option>
                </select>
            </div>
            <div class="col-md-3 mb-3 mb-md-0">
                <label for="sortFilter" class="form-label fw-bold"><i class="fa fa-sort me-2"></i>Sắp xếp</label>
                <select class="form-select" id="sortFilter">
                    <option value="bestseller" ${param.sort == 'bestseller' ? 'selected' : ''}>Bán chạy nhất</option>
                    <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Giá: Thấp đến Cao</option>
                    <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Giá: Cao đến Thấp</option>
                    <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                </select>
            </div>
            <div class="col-md-3">
                <div class="d-grid">
                    <button class="btn btn-primary btn-apply-filter" onclick="applyFilters()"><i class="fas fa-filter me-2"></i>Áp dụng</button>
                </div>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty products}">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                <c:forEach var="sp" items="${products}" varStatus="status">
                    <c:set var="product" value="${sp}" scope="request"/>
                    <c:import url="/WEB-INF/views/guest/product-card.jsp"/>
                </c:forEach>
            </div>

            <!-- Pagination Controls -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Product Pagination" class="mt-5">
                    <ul class="pagination justify-content-center">
                        <!-- Previous Page -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <c:url var="prevUrl" value="${pageContext.request.requestURI}">
                                <c:if test="${not empty param.category}"><c:param name="category" value="${param.category}"/></c:if>
                                <c:if test="${not empty param.price}"><c:param name="price" value="${param.price}"/></c:if>
                                <c:if test="${not empty param.sort}"><c:param name="sort" value="${param.sort}"/></c:if>
                                <c:param name="page" value="${currentPage - 1}"/>
                            </c:url>
                            <a class="page-link" href="${prevUrl}" tabindex="-1" aria-disabled="true"><i class="fas fa-chevron-left"></i></a>
                        </li>

                        <!-- Page Numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                 <c:url var="pageUrl" value="${pageContext.request.requestURI}">
                                    <c:if test="${not empty param.category}"><c:param name="category" value="${param.category}"/></c:if>
                                    <c:if test="${not empty param.price}"><c:param name="price" value="${param.price}"/></c:if>
                                    <c:if test="${not empty param.sort}"><c:param name="sort" value="${param.sort}"/></c:if>
                                    <c:param name="page" value="${i}"/>
                                </c:url>
                                <a class="page-link" href="${pageUrl}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Next Page -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <c:url var="nextUrl" value="${pageContext.request.requestURI}">
                                <c:if test="${not empty param.category}"><c:param name="category" value="${param.category}"/></c:if>
                                <c:if test="${not empty param.price}"><c:param name="price" value="${param.price}"/></c:if>
                                <c:if test="${not empty param.sort}"><c:param name="sort" value="${param.sort}"/></c:if>
                                <c:param name="page" value="${currentPage + 1}"/>
                            </c:url>
                            <a class="page-link" href="${nextUrl}"><i class="fas fa-chevron-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </c:if>

        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="fa fa-box-open fa-5x text-muted mb-4"></i>
                <h3 class="text-muted mb-3">Chưa có sản phẩm</h3>
                <p class="text-muted">Không tìm thấy sản phẩm nào phù hợp với tiêu chí của bạn.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // Define base URL for filtering
    const filterUrl = '<c:url value="/guest/category" />';

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
        }, 5000);
    }

    // Filter and Sort Logic
    function applyFilters() {
        const category = document.getElementById('categoryFilter').value;
        const price = document.getElementById('priceFilter').value;
        const sort = document.getElementById('sortFilter').value;

        const params = new URLSearchParams();

        if (category && category !== 'all') {
            params.set('category', category);
        }
        if (price) {
            params.set('price', price);
        }
        if (sort) {
            params.set('sort', sort);
        }
        
        // Always reset to page 1 when applying new filters
        params.set('page', '1');

        window.location.href = filterUrl + '?' + params.toString();
    }

</script>

</body>
</html>
