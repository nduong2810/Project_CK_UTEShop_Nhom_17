<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Apple Watch Series 9 - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Đồng hồ thông minh</a></li>
            <li class="breadcrumb-item active">Apple Watch Series 9</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/apple_watch.jpg"
                             id="mainProductImage"
                             alt="Apple Watch Series 9"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Apple Watch Series 9</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (724 đánh giá)</span>
                        <span class="sold-count">Đã bán: 3,892</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-12%</div>
                        <h2 class="current-price">10.990.000₫</h2>
                        <span class="original-price">12.490.000₫</span>
                    </div>

                    <!-- Size Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-expand-arrows-alt"></i>
                            Kích thước màn hình
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="41mm">41mm</div>
                            <div class="variant-option" data-variant="45mm">45mm</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>41mm</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="midnight">Midnight</div>
                            <div class="variant-option" data-variant="starlight">Starlight</div>
                            <div class="variant-option" data-variant="silver">Silver</div>
                            <div class="variant-option" data-variant="product-red">Product RED</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Midnight</strong></div>
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
                                    <i class="fas fa-heartbeat mb-2"></i><br>
                                    <strong>Theo dõi sức khỏe</strong><br>
                                    <small>ECG, SpO2, nhịp tim</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-running mb-2"></i><br>
                                    <strong>Theo dõi thể thao</strong><br>
                                    <small>Hơn 100 bài tập</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-water mb-2"></i><br>
                                    <strong>Chống nước</strong><br>
                                    <small>50m (WR50)</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-battery-three-quarters mb-2"></i><br>
                                    <strong>Pin 18 giờ</strong><br>
                                    <small>Sử dụng thông thường</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="5">
                            <button class="quantity-btn" onclick="increaseQuantity()">+</button>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button class="btn-add-cart" onclick="addToCart()">
                            <i class="fas fa-shopping-cart me-2"></i>
                            Thêm vào giỏ hàng
                        </button>
                        <button class="btn-buy-now" onclick="buyNow()">
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
                        <p>Apple Watch Series 9 với chip S9 mạnh mẽ, màn hình Retina Always-On sáng hơn và tính năng Double Tap mới. Theo dõi sức khỏe toàn diện và hỗ trợ hơn 100 bài tập thể thao.</p>
                        <ul>
                            <li>Chip S9 SiP mới với hiệu năng vượt trội</li>
                            <li>Màn hình Retina Always-On sáng hơn 2000 nits</li>
                            <li>Tính năng Double Tap điều khiển bằng cử chỉ</li>
                            <li>Theo dõi ECG, SpO2, nhịp tim 24/7</li>
                            <li>Chống nước đến 50m</li>
                            <li>Hỗ trợ Apple Pay và Siri</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Chip:</strong></td><td>Apple S9 SiP</td></tr>
                            <tr><td><strong>Màn hình:</strong></td><td>LTPO OLED Retina Always-On</td></tr>
                            <tr><td><strong>Độ phân giải:</strong></td><td>352x430 pixels (41mm)</td></tr>
                            <tr><td><strong>Chống nước:</strong></td><td>50m (WR50)</td></tr>
                            <tr><td><strong>Pin:</strong></td><td>Lên đến 18 giờ</td></tr>
                            <tr><td><strong>Kết nối:</strong></td><td>Wi-Fi, Bluetooth 5.3</td></tr>
                            <tr><td><strong>Cảm biến:</strong></td><td>ECG, SpO2, Gyroscope, Accelerometer</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 724 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Phạm Thanh Long</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Đồng hồ rất đẹp, tính năng theo dõi sức khỏe chính xác. Đáng đồng tiền!</p>
                            <small class="text-muted">1 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Nguyễn Thị Hoa</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Pin bền, màn hình đẹp. Theo dõi giấc ngủ và vận động rất tốt.</p>
                            <small class="text-muted">3 ngày trước</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    function changeMainImage(src) {
        document.getElementById('mainProductImage').src = src;
    }

    function increaseQuantity() {
        const input = document.getElementById('quantity');
        const currentValue = parseInt(input.value);
        if (currentValue < 5) {
            input.value = currentValue + 1;
        }
    }

    function decreaseQuantity() {
        const input = document.getElementById('quantity');
        const currentValue = parseInt(input.value);
        if (currentValue > 1) {
            input.value = currentValue - 1;
        }
    }

    function addToCart() {
        const quantity = document.getElementById('quantity').value;
        const size = document.querySelector('.variant-section:nth-child(4) .variant-option.active').dataset.variant;
        const color = document.querySelector('.variant-section:nth-child(5) .variant-option.active').dataset.variant;
        
        alert(`Đã thêm ${quantity} Apple Watch ${size} màu ${color} vào giỏ hàng!`);
    }

    function buyNow() {
        const quantity = document.getElementById('quantity').value;
        const size = document.querySelector('.variant-section:nth-child(4) .variant-option.active').dataset.variant;
        const color = document.querySelector('.variant-section:nth-child(5) .variant-option.active').dataset.variant;
        
        alert(`Mua ngay ${quantity} Apple Watch ${size} màu ${color}!`);
    }

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
</script>

</body>