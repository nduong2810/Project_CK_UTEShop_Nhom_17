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
                                        <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">
                                            <img src="${pageContext.request.contextPath}/assets/img/${sp.hinhAnh}" 
                                                 class="card-img-top" alt="${sp.tenSP}" 
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/img/no-image.png'">
                                        </a>
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
/* Re-using product card styles from home for consistency */
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
</style>
