<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>Máy Pha Cà Phê Espresso - UTESHOP</title>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Máy Pha Cà Phê Espresso</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/may_pha_cafe.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Máy Pha Cà Phê Espresso"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
        </div>

        <div class="col-lg-6">
            <h1 class="display-6 fw-bold">Máy Pha Cà Phê Espresso</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <span class="text-muted ms-1">(4.9 | Đã bán: 23)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <span class="h2 text-danger fw-bolder">1.850.000₫</span>
            </div>

            <!-- Model Options -->
            <div class="model-options mb-4">
                <h5 class="fw-bold mb-3">Chọn dòng máy:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-outline-primary model-option active" data-model="basic" onclick="selectModel(this)">Cơ bản</button>
                    <button class="btn btn-outline-primary model-option" data-model="premium" onclick="selectModel(this)">Cao cấp</button>
                    <button class="btn btn-outline-primary model-option" data-model="professional" onclick="selectModel(this)">Chuyên nghiệp</button>
                </div>
                <p class="mt-2 mb-0"><strong>Dòng máy:</strong> <span id="selectedModel">Cơ bản</span></p>
            </div>

            <hr>

            <div class="d-flex align-items-center mb-4">
                <label for="quantity" class="form-label me-3 mb-0">Số lượng:</label>
                <div class="input-group" style="width: 130px;">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(-1)">-</button>
                    <input type="text" id="quantity" class="form-control text-center" value="1" min="1" max="2">
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
let selectedModel = 'basic';

function selectModel(element) {
    document.querySelectorAll('.model-option').forEach(option => option.classList.remove('active'));
    element.classList.add('active');
    selectedModel = element.dataset.model;
    document.getElementById('selectedModel').textContent = element.textContent;
}

function changeQuantity(delta) {
    const input = document.getElementById('quantity');
    let value = parseInt(input.value) + delta;
    if (value >= 1 && value <= 2) input.value = value;
}

function addToCart() {
    const qty = document.getElementById('quantity').value;
    const model = document.getElementById('selectedModel').textContent;
    alert(`Đã thêm ${qty} máy pha cà phê ${model} vào giỏ hàng!`);
}

function buyNow() {
    const qty = document.getElementById('quantity').value;
    const model = document.getElementById('selectedModel').textContent;
    const total = (1850000 * qty).toLocaleString('vi-VN');
    alert(`Mua ngay ${qty} máy pha cà phê ${model}\nTổng tiền: ${total}₫`);
}
</script>