<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>iPad Pro 12.9 inch M2 - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Tablet</a></li>
            <li class="breadcrumb-item active">iPad Pro 12.9 inch M2</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/ipad_pro.jpg"
                             id="mainProductImage"
                             alt="iPad Pro 12.9 inch M2"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">iPad Pro 12.9 inch M2 (2022)</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (523 đánh giá)</span>
                        <span class="sold-count">Đã bán: 2,890</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-5%</div>
                        <h2 class="current-price">28.990.000₫</h2>
                        <span class="original-price">30.490.000₫</span>
                    </div>

                    <!-- Storage Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-hdd"></i>
                            Dung lượng
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="128gb">128GB</div>
                            <div class="variant-option active" data-variant="256gb">256GB</div>
                            <div class="variant-option" data-variant="512gb">512GB</div>
                            <div class="variant-option" data-variant="1tb">1TB</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>256GB</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="space-gray">Space Gray</div>
                            <div class="variant-option" data-variant="silver">Silver</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Space Gray</strong></div>
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
                                    <i class="fas fa-microchip mb-2"></i><br>
                                    <strong>Chip M2</strong><br>
                                    <small>Hiệu năng vượt trội</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-tv mb-2"></i><br>
                                    <strong>Liquid Retina XDR</strong><br>
                                    <small>12.9 inch mini-LED</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-pencil-alt mb-2"></i><br>
                                    <strong>Apple Pencil</strong><br>
                                    <small>Hỗ trợ thế hệ 2</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-camera mb-2"></i><br>
                                    <strong>Camera 12MP</strong><br>
                                    <small>Video 4K ProRes</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" id="decreaseQuantityBtn">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="3">
                            <button class="quantity-btn" id="increaseQuantityBtn">+</button>
                        </div>
                        <span class="quantity-label" style="margin-left: 1rem;">3 sản phẩm có sẵn</span>
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
                        <p>iPad Pro 12.9 inch với chip M2 mạnh mẽ, màn hình Liquid Retina XDR tuyệt đẹp và hỗ trợ Apple Pencil thế hệ 2. Thiết bị hoàn hảo cho công việc chuyên nghiệp và sáng tạo.</p>
                        <ul>
                            <li>Chip M2 với CPU 8 nhân, GPU 10 nhân</li>
                            <li>Màn hình Liquid Retina XDR 12.9 inch</li>
                            <li>Độ phân giải 2732 x 2048 pixels</li>
                            <li>Hỗ trợ Apple Pencil (thế hệ 2)</li>
                            <li>Camera TrueDepth với Face ID</li>
                            <li>Quay video 4K ProRes và Cinematic mode</li>
                            <li>USB-C với Thunderbolt / USB 4</li>
                            <li>Wi-Fi 6E và 5G tùy chọn</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Chip:</strong></td><td>Apple M2</td></tr>
                            <tr><td><strong>Màn hình:</strong></td><td>12.9" Liquid Retina XDR</td></tr>
                            <tr><td><strong>Độ phân giải:</strong></td><td>2732 x 2048 pixels</td></tr>
                            <tr><td><strong>Dung lượng:</strong></td><td>128GB, 256GB, 512GB, 1TB</td></tr>
                            <tr><td><strong>Camera sau:</strong></td><td>12MP Wide + 10MP Ultra Wide</td></tr>
                            <tr><td><strong>Camera trước:</strong></td><td>12MP TrueDepth</td></tr>
                            <tr><td><strong>Kết nối:</strong></td><td>USB-C, Wi-Fi 6E, 5G</td></tr>
                            <tr><td><strong>Pin:</strong></td><td>Lên đến 10 giờ</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 523 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Designer Pro</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">iPad tuyệt vời cho thiết kế! Màn hình đẹp, Apple Pencil mượt mà!</p>
                            <small class="text-muted">3 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Content Creator</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Hiệu năng M2 mạnh mẽ, edit video 4K mượt mà. Rất hài lòng!</p>
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
            const section = this.closest('.variant-section');
            section.querySelectorAll('.variant-option[data-variant]').forEach(opt => opt.classList.remove('active'));
            this.classList.add('active');
            
            const selectedVariant = this.textContent;
            section.querySelector('.selected-variant strong').textContent = selectedVariant;
        });
    });

    // Add to Cart
    document.getElementById('addToCartBtn').addEventListener('click', function() {
        const quantity = document.getElementById('quantity').value;
        const storage = document.querySelector('.variant-section:nth-of-type(1) .variant-option.active').textContent;
        const color = document.querySelector('.variant-section:nth-of-type(2) .variant-option.active').textContent;
        alert(`Đã thêm ${quantity} iPad Pro ${storage} màu ${color} vào giỏ hàng!`);
    });

    // Buy Now
    document.getElementById('buyNowBtn').addEventListener('click', function() {
        const quantity = document.getElementById('quantity').value;
        const storage = document.querySelector('.variant-section:nth-of-type(1) .variant-option.active').textContent;
        const color = document.querySelector('.variant-section:nth-of-type(2) .variant-option.active').textContent;
        alert(`Mua ngay ${quantity} iPad Pro ${storage} màu ${color}!`);
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