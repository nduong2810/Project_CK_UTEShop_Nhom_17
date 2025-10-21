<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Apple AirPods Pro (2nd Gen) - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Âm thanh</a></li>
            <li class="breadcrumb-item active">Apple AirPods Pro (2nd Gen)</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/airpods.jpg"
                             id="mainProductImage"
                             alt="Apple AirPods Pro (2nd Gen)"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Apple AirPods Pro (2nd Gen)</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (892 đánh giá)</span>
                        <span class="sold-count">Đã bán: 5,672</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-7%</div>
                        <h2 class="current-price">6.490.000₫</h2>
                        <span class="original-price">6.990.000₫</span>
                    </div>

                    <!-- Variant Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="white">Trắng</div>
                            <div class="variant-option" data-variant="black">Đen</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Trắng</strong></div>
                    </div>

                    <!-- Key Features -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-star"></i>
                            Tính năng nổi bật
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-volume-mute mb-2"></i><br>
                                    <strong>Khử tiếng ồn</strong><br>
                                    <small>Nâng cấp gấp 2 lần</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-microchip mb-2"></i><br>
                                    <strong>Chip H2</strong><br>
                                    <small>Âm thanh thông minh</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-battery-three-quarters mb-2"></i><br>
                                    <strong>Pin 30 giờ</strong><br>
                                    <small>Với case sạc</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-hand-paper mb-2"></i><br>
                                    <strong>Touch Control</strong><br>
                                    <small>Điều khiển cử chỉ</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" id="decreaseQuantityBtn">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="10">
                            <button class="quantity-btn" id="increaseQuantityBtn">+</button>
                        </div>
                        <span class="quantity-label" style="margin-left: 1rem;">10 sản phẩm có sẵn</span>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button class="btn-add-cart" id="addToCartBtn">
                            <i class="fas fa-shopping-cart me-2"></i>
                            Thêm vào giỏ hàng
                        </button>
                        <button class="btn-buy-now" id="buyNowBtn">
                            <i class="fas fa-bolt me-2"></i>
                            Mua ngay
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Details Tabs -->
        <div class="container mt-5">
            <ul class="nav nav-tabs" id="productTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description">Mô tả</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="specifications-tab" data-bs-toggle="tab" data-bs-target="#specifications">Thông số</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews">Đánh giá</button>
                </li>
            </ul>
            
            <div class="tab-content" id="productTabContent">
                <div class="tab-pane fade show active" id="description">
                    <div class="p-4">
                        <h5>Mô tả sản phẩm</h5>
                        <p>AirPods Pro thế hệ 2 với chip H2 mạnh mẽ, khử tiếng ồn chủ động nâng cấp và chất lượng âm thanh vượt trội. Thiết kế thoải mái với nhiều size đầu tai nghe.</p>
                        <ul>
                            <li>Chip H2 thế hệ mới cho âm thanh tốt hơn</li>
                            <li>Khử tiếng ồn chủ động nâng cấp gấp 2 lần</li>
                            <li>Chế độ Transparency cải tiến</li>
                            <li>Âm thanh không gian cá nhân hóa</li>
                            <li>Kháng nước IPX4</li>
                            <li>Pin lên đến 6 giờ nghe nhạc (30 giờ với case)</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Chip xử lý:</strong></td><td>Apple H2</td></tr>
                            <tr><td><strong>Driver:</strong></td><td>Dynamic driver tùy chỉnh</td></tr>
                            <tr><td><strong>Kháng nước:</strong></td><td>IPX4</td></tr>
                            <tr><td><strong>Pin tai nghe:</strong></td><td>Lên đến 6 giờ</td></tr>
                            <tr><td><strong>Pin với case:</strong></td><td>Lên đến 30 giờ</td></tr>
                            <tr><td><strong>Sạc:</strong></td><td>Lightning, MagSafe, Qi wireless</td></tr>
                            <tr><td><strong>Kết nối:</strong></td><td>Bluetooth 5.3</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 892 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Nguyễn Văn A</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất lượng âm thanh tuyệt vời, khử tiếng ồn rất hiệu quả!</p>
                            <small class="text-muted">2 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Trần Thị B</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Thiết kế đẹp, pin trâu, đáng đồng tiền bát gạo.</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Variant selection
    document.querySelectorAll('.variant-option[data-variant]').forEach(option => {
        option.addEventListener('click', function() {
            document.querySelectorAll('.variant-option[data-variant]').forEach(opt => opt.classList.remove('active'));
            this.classList.add('active');
            
            const selectedVariant = this.textContent;
            document.querySelector('.selected-variant strong').textContent = selectedVariant;
        });
    });

    window.addToCart = function() {
        const quantity = document.getElementById('quantity').value;
        const variant = document.querySelector('.variant-option.active').dataset.variant;
        alert(`Đã thêm ${quantity} sản phẩm màu ${variant} vào giỏ hàng!`);
    }

    window.buyNow = function() {
        const quantity = document.getElementById('quantity').value;
        const variant = document.querySelector('.variant-option.active').dataset.variant;
        alert(`Mua ngay ${quantity} sản phẩm màu ${variant}!`);
    }

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

function changeMainImage(src) {
    document.getElementById('mainProductImage').src = src;
}
</script>

</body>