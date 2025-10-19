<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>Máy Lọc Nước RO - UTESHOP</title>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Máy Lọc Nước RO</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/may_loc_nuoc_ro.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Máy Lọc Nước RO"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
        </div>

        <div class="col-lg-6">
            <h1 class="display-6 fw-bold">Máy Lọc Nước RO</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <span class="text-muted ms-1">(4.8 | Đã bán: 76)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <span class="h2 text-danger fw-bolder">5.500.000₫</span>
            </div>

            <!-- Stage Options -->
            <div class="stage-options mb-4">
                <h5 class="fw-bold mb-3">Chọn số lõi lọc:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-outline-primary stage-option" data-stage="5" onclick="selectStage(this)">5 lõi</button>
                    <button class="btn btn-outline-primary stage-option" data-stage="7" onclick="selectStage(this)">7 lõi</button>
                    <button class="btn btn-outline-primary stage-option active" data-stage="9" onclick="selectStage(this)">9 lõi</button>
                </div>
                <p class="mt-2 mb-0"><strong>Số lõi lọc:</strong> <span id="selectedStage">9 lõi</span></p>
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
let selectedStage = '9';

function selectStage(element) {
    document.querySelectorAll('.stage-option').forEach(option => option.classList.remove('active'));
    element.classList.add('active');
    selectedStage = element.dataset.stage;
    document.getElementById('selectedStage').textContent = element.textContent;
}

function changeQuantity(delta) {
    const input = document.getElementById('quantity');
    let value = parseInt(input.value) + delta;
    if (value >= 1 && value <= 2) input.value = value;
}

function addToCart() {
    const qty = document.getElementById('quantity').value;
    const stage = document.getElementById('selectedStage').textContent;
    alert(`Đã thêm ${qty} máy lọc nước ${stage} vào giỏ hàng!`);
}

function buyNow() {
    const qty = document.getElementById('quantity').value;
    const stage = document.getElementById('selectedStage').textContent;
    const total = (5500000 * qty).toLocaleString('vi-VN');
    alert(`Mua ngay ${qty} máy lọc nước ${stage}\nTổng tiền: ${total}₫`);
}
</script>