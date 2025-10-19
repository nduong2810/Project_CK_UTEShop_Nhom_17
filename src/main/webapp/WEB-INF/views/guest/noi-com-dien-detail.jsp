<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>Nồi Cơm Điện Panasonic - UTESHOP</title>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Nồi Cơm Điện Panasonic</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/noi_com_dien.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Nồi Cơm Điện Panasonic"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
        </div>

        <div class="col-lg-6">
            <h1 class="display-6 fw-bold">Nồi Cơm Điện Panasonic 1.8L</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star-half-alt"></i>
                    <span class="text-muted ms-1">(4.6 | Đã bán: 18)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <span class="h2 text-danger fw-bolder">2.890.000₫</span>
            </div>

            <div class="product-description mb-4">
                <p class="text-muted">Nồi cơm điện cao tần Panasonic 1.8L với công nghệ IH cảm ứng từ, nấu cơm ngon và tiết kiệm điện. Phù hợp gia đình 4-6 người.</p>
            </div>

            <div class="specifications mb-4">
                <h5 class="fw-bold mb-3">Tính năng nổi bật:</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fa fa-fire text-primary me-2"></i><strong>Công nghệ IH:</strong> Cảm ứng từ cao tần</li>
                    <li class="mb-2"><i class="fa fa-clock text-primary me-2"></i><strong>Hẹn giờ:</strong> 24 giờ</li>
                    <li class="mb-2"><i class="fa fa-thermometer-half text-primary me-2"></i><strong>Giữ ấm:</strong> Tự động 12 giờ</li>
                    <li class="mb-2"><i class="fa fa-shield-alt text-primary me-2"></i><strong>An toàn:</strong> Chống cháy, quá nhiệt</li>
                </ul>
            </div>

            <hr>

            <div class="d-flex align-items-center mb-4">
                <label for="quantity" class="form-label me-3 mb-0">Số lượng:</label>
                <div class="input-group" style="width: 130px;">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(-1)">-</button>
                    <input type="text" id="quantity" class="form-control text-center" value="1" min="1" max="5">
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
function changeQuantity(delta) {
    const input = document.getElementById('quantity');
    let value = parseInt(input.value) + delta;
    if (value >= 1 && value <= 5) input.value = value;
}

function addToCart() {
    const qty = document.getElementById('quantity').value;
    alert(`Đã thêm ${qty} nồi cơm điện Panasonic vào giỏ hàng!`);
}

function buyNow() {
    const qty = document.getElementById('quantity').value;
    const total = (2890000 * qty).toLocaleString('vi-VN');
    alert(`Mua ngay ${qty} nồi cơm điện Panasonic\nTổng tiền: ${total}₫`);
}
</script>