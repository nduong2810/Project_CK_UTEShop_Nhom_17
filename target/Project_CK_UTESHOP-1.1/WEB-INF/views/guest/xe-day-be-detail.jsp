<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Xe Đẩy Em Bé Combi - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>

<body>
<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Xe Đẩy Em Bé Combi</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/xe_day_be.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Xe Đẩy Em Bé Combi"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
        </div>

        <div class="col-lg-6">
            <h1 class="display-6 fw-bold">Xe Đẩy Em Bé Combi</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <span class="text-muted ms-1">(4.9 | Đã bán: 12)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <span class="h2 text-danger fw-bolder">5.890.000₫</span>
            </div>

            <div class="product-description mb-4">
                <p class="text-muted">Xe đẩy em bé cao cấp Combi từ Nhật Bản với thiết kế nhẹ, gấp gọn dễ dàng và hệ thống an toàn 5 điểm. Phù hợp từ 0-36 tháng tuổi.</p>
            </div>

            <div class="specifications mb-4">
                <h5 class="fw-bold mb-3">Tính năng an toàn:</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fa fa-shield-alt text-primary me-2"></i><strong>An toàn 5 điểm:</strong> Dây đai bảo vệ toàn diện</li>
                    <li class="mb-2"><i class="fa fa-hand-paper text-primary me-2"></i><strong>Phanh bánh xe:</strong> Khóa an toàn kép</li>
                    <li class="mb-2"><i class="fa fa-umbrella text-primary me-2"></i><strong>Che nắng UV:</strong> Vải chống tia UV 99%</li>
                    <li class="mb-2"><i class="fa fa-compress text-primary me-2"></i><strong>Gấp gọn:</strong> 1 tay, đứng được khi gấp</li>
                    <li class="mb-2"><i class="fa fa-weight text-primary me-2"></i><strong>Trọng lượng:</strong> Chỉ 4.8kg</li>
                </ul>
            </div>

            <hr>

            <!-- Quantity Section -->
            <div class="quantity-section mb-4">
                <span class="quantity-label">Số lượng:</span>
                <div class="quantity-controls">
                    <button class="quantity-btn" id="decreaseQuantityBtn">-</button>
                    <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="3">
                    <button class="quantity-btn" id="increaseQuantityBtn">+</button>
                </div>
                <span class="quantity-label" style="margin-left: 1rem;">3 sản phẩm có sẵn</span>
            </div>

            <div class="d-grid gap-2 d-sm-flex">
                <button class="btn btn-primary btn-lg flex-grow-1" id="addToCartBtn">
                    <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>
                <button class="btn btn-warning btn-lg flex-grow-1" id="buyNowBtn">
                    <i class="fa fa-bolt"></i> Mua ngay
                </button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('addToCartBtn').addEventListener('click', function() {
        const qty = document.getElementById('quantity').value;
        alert(`Đã thêm ${qty} xe đẩy em bé Combi vào giỏ hàng!`);
    });

    document.getElementById('buyNowBtn').addEventListener('click', function() {
        const qty = document.getElementById('quantity').value;
        const total = (5890000 * qty).toLocaleString('vi-VN');
        alert(`Mua ngay ${qty} xe đẩy em bé Combi\nTổng tiền: ${total}₫`);
    });

    // NEW QUANTITY CONTROLS SCRIPT
    const quantityInput = document.getElementById('quantity');
    const decreaseBtn = document.getElementById('decreaseQuantityBtn');
    const increaseBtn = document.getElementById('increaseQuantityBtn');

    if (quantityInput && decreaseBtn && increaseBtn) {
        function updateQuantityControls() {
            const currentValue = parseInt(quantityInput.value);
            const min = parseInt(quantityInput.min);
            const max = parseInt(quantityInput.max);

            decreaseBtn.disabled = currentValue <= min;
            increaseBtn.disabled = currentValue >= max;
        }

        decreaseBtn.addEventListener('click', function() {
            let currentValue = parseInt(quantityInput.value);
            if (currentValue > parseInt(quantityInput.min)) {
                quantityInput.value = currentValue - 1;
                updateQuantityControls();
            }
        });

        increaseBtn.addEventListener('click', function() {
            let currentValue = parseInt(quantityInput.value);
            if (currentValue < parseInt(quantityInput.max)) {
                quantityInput.value = currentValue + 1;
                updateQuantityControls();
            }
        });

        quantityInput.addEventListener('input', function() {
            let currentValue = parseInt(quantityInput.value);
            const min = parseInt(quantityInput.min);
            const max = parseInt(quantityInput.max);

            if (isNaN(currentValue) || currentValue < min) {
                quantityInput.value = min;
            } else if (currentValue > max) {
                quantityInput.value = max;
            }
            updateQuantityControls();
        });

        // Initial state update
        updateQuantityControls();
    }
});
</script>
</body>