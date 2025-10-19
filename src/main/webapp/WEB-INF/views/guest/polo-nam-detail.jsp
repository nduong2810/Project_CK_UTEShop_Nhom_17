<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>Áo Polo Nam Premium - UTESHOP</title>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Áo Polo Nam Premium</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/polo_nam.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Áo Polo Nam Premium"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
        </div>

        <div class="col-lg-6">
            <h1 class="display-6 fw-bold">Áo Polo Nam Premium</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star-half-alt"></i>
                    <span class="text-muted ms-1">(4.5 | Đã bán: 35)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <span class="h2 text-danger fw-bolder">450.000₫</span>
            </div>

            <div class="product-description mb-4">
                <p class="text-muted">Áo polo nam chất liệu cao cấp, thiết kế lịch lãm phù hợp cho công sở và đi chơi. Form dáng slim fit hiện đại.</p>
            </div>

            <!-- Size Options -->
            <div class="size-options mb-4">
                <h5 class="fw-bold mb-3">Chọn size:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-outline-primary size-option" data-size="S" onclick="selectSize(this)">S</button>
                    <button class="btn btn-outline-primary size-option active" data-size="M" onclick="selectSize(this)">M</button>
                    <button class="btn btn-outline-primary size-option" data-size="L" onclick="selectSize(this)">L</button>
                    <button class="btn btn-outline-primary size-option" data-size="XL" onclick="selectSize(this)">XL</button>
                </div>
                <p class="mt-2 mb-0"><strong>Size:</strong> <span id="selectedSize">M</span></p>
            </div>

            <!-- Color Options -->
            <div class="color-options mb-4">
                <h5 class="fw-bold mb-3">Chọn màu sắc:</h5>
                <div class="d-flex gap-2">
                    <button class="color-option active" data-color="Navy Blue" 
                            style="background: #1e3a8a; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #007bff;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="White"
                            style="background: #ffffff; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Black"
                            style="background: #1a1a1a; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                </div>
                <p class="mt-2 mb-0"><strong>Màu đã chọn:</strong> <span id="selectedColor">Navy Blue</span></p>
            </div>

            <hr>

            <div class="d-flex align-items-center mb-4">
                <label for="quantity" class="form-label me-3 mb-0">Số lượng:</label>
                <div class="input-group" style="width: 130px;">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(-1)">-</button>
                    <input type="text" id="quantity" class="form-control text-center" value="1" min="1" max="10">
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
let selectedColor = 'Navy Blue';

function selectSize(element) {
    document.querySelectorAll('.size-option').forEach(option => option.classList.remove('active'));
    element.classList.add('active');
    selectedSize = element.dataset.size;
    document.getElementById('selectedSize').textContent = selectedSize;
}

function selectColor(element) {
    document.querySelectorAll('.color-option').forEach(option => {
        option.classList.remove('active');
        option.style.borderColor = '#ddd';
    });
    element.classList.add('active');
    element.style.borderColor = '#007bff';
    selectedColor = element.dataset.color;
    document.getElementById('selectedColor').textContent = selectedColor;
}

function changeQuantity(delta) {
    const input = document.getElementById('quantity');
    let value = parseInt(input.value) + delta;
    if (value >= 1 && value <= 10) input.value = value;
}

function addToCart() {
    const qty = document.getElementById('quantity').value;
    alert(`Đã thêm ${qty} áo polo size ${selectedSize} màu ${selectedColor} vào giỏ hàng!`);
}

function buyNow() {
    const qty = document.getElementById('quantity').value;
    const total = (450000 * qty).toLocaleString('vi-VN');
    alert(`Mua ngay ${qty} áo polo size ${selectedSize} màu ${selectedColor}\nTổng tiền: ${total}₫`);
}
</script>