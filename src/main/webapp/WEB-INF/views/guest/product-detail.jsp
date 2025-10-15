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
                        <img src="${pageContext.request.contextPath}/img/${product.hinhAnh}"
                             id="mainProductImage" class="img-fluid rounded shadow-sm"
                             alt="${product.tenSP}"
                             onerror="this.src='${pageContext.request.contextPath}/img/no-image.png'">
                    </div>
                    <!-- Thumbnails (nếu có nhiều ảnh) -->
                    <%-- <div class="thumbnail-container d-flex">
                        <img src="..." class="thumbnail active" alt="Thumb 1">
                        <img src="..." class="thumbnail" alt="Thumb 2">
                    </div> --%>
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
                        <%-- <span class="text-muted text-decoration-line-through ms-2">15.000.000₫</span> --%>
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
                        <button class="btn btn-primary btn-lg flex-grow-1" type="button">
                            <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                        </button>
                        <button class="btn btn-warning btn-lg flex-grow-1" type="button">
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
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const quantityInput = document.getElementById('quantity');
        const minusButton = document.getElementById('button-minus');
        const plusButton = document.getElementById('button-plus');

        if(minusButton) {
            minusButton.addEventListener('click', function() {
                let currentValue = parseInt(quantityInput.value);
                if (currentValue > 1) {
                    quantityInput.value = currentValue - 1;
                }
            });
        }

        if(plusButton) {
            plusButton.addEventListener('click', function() {
                let currentValue = parseInt(quantityInput.value);
                quantityInput.value = currentValue + 1;
            });
        }
    });
</script>