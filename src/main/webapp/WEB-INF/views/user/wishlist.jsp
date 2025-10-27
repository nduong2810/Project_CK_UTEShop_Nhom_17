<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản Phẩm Yêu Thích - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.2s;
            height: 100%;
            position: relative;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .product-image-container {
            position: relative;
            padding-top: 100%;
            overflow: hidden;
        }
        .product-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .product-image.loaded {
            opacity: 1;
        }
        .btn-favorite {
            position: absolute;
            top: 10px;
            right: 10px;
            background: white;
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            transition: all 0.2s;
        }
        .btn-favorite i {
            color: #dc3545;
            font-size: 1.2rem;
            transition: transform 0.2s;
        }
        .btn-favorite:hover i {
            transform: scale(1.2);
        }
        .product-info {
            padding: 1rem;
        }
        .product-title {
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            height: 2.7rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product-price {
            color: #dc3545;
            font-weight: bold;
            font-size: 1.1rem;
        }
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
        }
        .empty-state i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<div class="container my-5">
    <!-- Breadcrumbs -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/guest/home'/>">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Sản Phẩm Yêu Thích</li>
        </ol>
    </nav>

    <div class="section-header mb-5">
        <h1 class="display-5 fw-bold text-primary">Sản Phẩm Yêu Thích</h1>
        <p class="lead text-muted">Danh sách các sản phẩm bạn đã yêu thích tại UTESHOP</p>
        <hr>
    </div>

    <c:choose>
        <c:when test="${not empty favorites}">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
                <c:forEach var="favorite" items="${favorites}" varStatus="status">
                    <div class="col">
                        <div class="product-card">
                            <div class="product-image-container">
                                <a href="${pageContext.request.contextPath}/guest/product?id=${favorite.sanPham.maSP}">
                                    <img src="${pageContext.request.contextPath}/assets/img/${favorite.sanPham.hinhAnh}"
                                         alt="${favorite.sanPham.tenSP}"
                                         class="product-image"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                                </a>
                                <a href="${pageContext.request.contextPath}/user/favorites/remove?maSP=${favorite.sanPham.maSP}" 
                                   class="btn-favorite active"
                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi danh sách yêu thích?')">
                                    <i class="fas fa-heart"></i>
                                </a>
                            </div>
                            <div class="product-info">
                                <h3 class="product-title">
                                    <a href="${pageContext.request.contextPath}/guest/product?id=${favorite.sanPham.maSP}" 
                                       class="text-dark text-decoration-none">
                                        ${favorite.sanPham.tenSP}
                                    </a>
                                </h3>
                                <p class="product-price mb-0">
                                    <fmt:formatNumber value="${favorite.sanPham.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </p>
                                <div class="mt-2">
                                    <a href="${pageContext.request.contextPath}/guest/product?id=${favorite.sanPham.maSP}" 
                                       class="btn btn-sm btn-primary w-100">
                                        <i class="fas fa-eye me-1"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}" tabindex="-1">Trước</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-heart-broken mb-3"></i>
                <h3>Danh sách yêu thích trống</h3>
                <p class="text-muted">Bạn chưa thêm sản phẩm nào vào danh sách yêu thích</p>
                <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary">
                    <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Bootstrap JS and its dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

<!-- Context path for JavaScript -->
<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/wishlist.js"></script>

</body>
</html>