<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>Xe Đạp Thể Thao Giant - UTESHOP</title>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Xe Đạp Thể Thao Giant</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/xe_dap_giant.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Xe Đạp Thể Thao Giant"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
        </div>

        <div class="col-lg-6">
            <h1 class="display-6 fw-bold">Xe Đạp Thể Thao Giant</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <span class="text-muted ms-1">(4.8 | Đã bán: 8)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <span class="h2 text-danger fw-bolder">15.900.000₫</span>
            </div>

            <div class="product-description mb-4">
                <p class="text-muted">Xe đạp đường trường cao cấp Giant với khung sợi carbon, hệ thống truyền động Shimano 105. Lý tưởng cho đua xe và tập luyện chuyên nghiệp.</p>
            </div>

            <!-- Size Options -->
            <div class="size-options mb-4">
                <h5 class="fw-bold mb-3">Chọn size khung:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-outline-primary size-option" data-size="S" onclick="selectSize(this)">S (49cm)</button>
                    <button class="btn btn-outline-primary size-option active" data-size="M" onclick="selectSize(this)">M (52cm)</button>
                    <button class="btn btn-outline-primary size-option" data-size="L" onclick="selectSize(this)">L (55cm)</button>
                </div>
                <p class="mt-2 mb-0"><strong>Size:</strong> <span id="selectedSize">M (52cm)</span></p>
            </div>

            <div class="specifications mb-4">
                <h5 class="fw-bold mb-3">Thông số kỹ thuật:</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fa fa-cog text-primary me-2"></i><strong>Khung:</strong> Carbon Advanced-Grade Composite</li>
                    <li class="mb-2"><i class="fa fa-bicycle text-primary me-2"></i><strong>Phuộc:</strong> Carbon Advanced-Grade</li>
                    <li class="mb-2"><i class="fa fa-settings text-primary me-2"></i><strong>Bộ đề:</strong> Shimano 105 R7000 22-speed</li>
                    <li class="mb-2"><i class="fa fa-circle text-primary me-2"></i><strong>Bánh xe:</strong> Giant PR-2 700C</li>
                    <li class="mb-2"><i class="fa fa-weight text-primary me-2"></i><strong>Trọng lượng:</strong> ~8.5kg</li>
                </ul>
            </div>

            <hr>

            <div class="d-flex align-items-center mb-4">
                <label for="quantity" class="form-label me-3 mb-0">Số lượng:</label>
                <div class="input-group" style="width: 130px;">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(-1)">-</button>
                    <input type="text" id="quantity" class="form-control text-center" value="1" min="1" max="3">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(1)">+</button>
                </div>
            </div>

            <div class="d-grid gap-2 d-sm-flex">
                <button class="btn btn-primary btn-lg flex-grow-1" onclick="addToCart()">
                    <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>
                <button class="btn btn-warning btn-lg flex-grow-1" onclick="buyNow()">
                    <i class="fa fa-bolt"></i> Mua ngay
                </button>
            </div>
        </div>
    </div>
</div>

<script>
let selectedSize = 'M';

function selectSize(element) {
    document.querySelectorAll('.size-option').forEach(option => option.classList.remove('active'));
    element.classList.add('active');
    selectedSize = element.dataset.size;
    document.getElementById('selectedSize').textContent = element.textContent;
}

function changeQuantity(delta) {
    const input = document.getElementById('quantity');
    let value = parseInt(input.value) + delta;
    if (value >= 1 && value <= 3) input.value = value;
}

function addToCart() {
    const qty = document.getElementById('quantity').value;
    alert(`Đã thêm ${qty} xe đạp Giant size ${selectedSize} vào giỏ hàng!`);
}

function buyNow() {
    const qty = document.getElementById('quantity').value;
    const total = (15900000 * qty).toLocaleString('vi-VN');
    alert(`Mua ngay ${qty} xe đạp Giant size ${selectedSize}\nTổng tiền: ${total}₫`);
}
</script>