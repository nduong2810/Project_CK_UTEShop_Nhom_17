<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="col">
    <div class="product-card">
        <div class="product-image-container">
            <a href="${pageContext.request.contextPath}/guest/product?id=${product.maSP}">
                <img src="${pageContext.request.contextPath}/assets/img/${product.hinhAnh}"
                     alt="${product.tenSP}"
                     class="product-image"
                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
            </a>
            <c:if test="${hotProductIds.contains(product.maSP) or top3ProductIds.contains(product.maSP)}">
                <div class="badge-hot">HOT</div>
            </c:if>
            <button class="btn-favorite" onclick="toggleFavorite(event, this, ${product.maSP}, ${empty sessionScope.user})">
                <i class="far fa-heart"></i>
            </button>
        </div>
        
        <div class="card-body">
            <h6 class="card-title">
                <a href="${pageContext.request.contextPath}/guest/product?id=${product.maSP}">${product.tenSP}</a>
            </h6>
            
            <div class="d-flex justify-content-between align-items-center mb-3 price-line">
                <div class="price">
                    <fmt:formatNumber value="${product.donGia}" type="number" groupingUsed="true"/>₫
                </div>
                <small class="sold-count">
                    <i class="fas fa-shopping-cart me-1"></i>
                    ${product.soLuongBan} đã bán
                </small>
            </div>
            
            <div class="product-buttons">
                <button class="btn-add-to-cart" onclick="addToCart(${product.maSP}, ${empty sessionScope.user})">
                    <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ hàng
                </button>
                <button class="btn-buy-now" onclick="buyNow(${product.maSP}, ${empty sessionScope.user})">
                    <i class="fas fa-bolt me-2"></i>Mua Ngay
                </button>
            </div>
        </div>
    </div>
</div>
