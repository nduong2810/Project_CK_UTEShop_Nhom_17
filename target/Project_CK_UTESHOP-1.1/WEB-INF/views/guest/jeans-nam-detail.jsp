<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Quần Jeans Nam Cao Cấp - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Thời trang nam</a></li>
            <li class="breadcrumb-item active">Quần Jeans Nam Cao Cấp</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/jeans_nam.jpg"
                             id="mainProductImage"
                             alt="Quần Jeans Nam Cao Cấp"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Quần Jeans Nam Cao Cấp Slim Fit</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.7/5 (389 đánh giá)</span>
                        <span class="sold-count">Đã bán: 3,456</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-35%</div>
                        <h2 class="current-price">390.000₫</h2>
                        <span class="original-price">599.000₫</span>
                    </div>

                    <!-- Size Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-ruler-horizontal"></i>
                            Kích thước
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="29">29</div>
                            <div class="variant-option" data-variant="30">30</div>
                            <div class="variant-option active" data-variant="32">32</div>
                            <div class="variant-option" data-variant="34">34</div>
                            <div class="variant-option" data-variant="36">36</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>32</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="dark-blue">Xanh đậm</div>
                            <div class="variant-option" data-variant="light-blue">Xanh nhạt</div>
                            <div class="variant-option" data-variant="black">Đen</div>
                            <div class="variant-option" data-variant="gray">Xám</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Xanh đậm</strong></div>
                    </div>

                    <!-- Key Features -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-star"></i>
                            Đặc điểm nổi bật
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-cut mb-2"></i><br>
                                    <strong>Slim Fit</strong><br>
                                    <small>Ôm vừa vặn</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-tshirt mb-2"></i><br>
                                    <strong>Denim cao cấp</strong><br>
                                    <small>Cotton 98% + Spandex 2%</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-alt mb-2"></i><br>
                                    <strong>Bền màu</strong><br>
                                    <small>Không phai sau giặt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-star mb-2"></i><br>
                                    <strong>Phong cách</strong><br>
                                    <small>Trẻ trung, hiện đại</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" id="decreaseQuantityBtn">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="20">
                            <button class="quantity-btn" id="increaseQuantityBtn">+</button>
                        </div>
                        <span class="quantity-label" style="margin-left: 1rem;">20 sản phẩm có sẵn</span>
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
                        <p>Quần jeans nam cao cấp với form slim fit hiện đại, chất liệu denim cotton co giãn thoải mái. Thiết kế trẻ trung, phù hợp cho nhiều hoàn cảnh từ đi làm đến dạo phố.</p>
                        <ul>
                            <li>Chất liệu: Cotton 98% + Spandex 2%</li>
                            <li>Form: Slim fit ôm vừa vặn</li>
                            <li>Màu sắc bền đẹp, không phai</li>
                            <li>Đường may chắc chắn, tỉ mỉ</li>
                            <li>Thiết kế 5 túi cổ điển</li>
                            <li>Phù hợp mọi dáng người</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số sản phẩm</h5>
                        <table class="table">
                            <tr><td><strong>Chất liệu:</strong></td><td>Cotton 98%, Spandex 2%</td></tr>
                            <tr><td><strong>Xuất xứ:</strong></td><td>Việt Nam</td></tr>
                            <tr><td><strong>Form quần:</strong></td><td>Slim fit</td></tr>
                            <tr><td><strong>Độ dài:</strong></td><td>Full length</td></tr>
                            <tr><td><strong>Kiểu dáng:</strong></td><td>5 túi cổ điển</td></tr>
                            <tr><td><strong>Bảo quản:</strong></td><td>Giặt máy ở 30°C</td></tr>
                            <tr><td><strong>Size:</strong></td><td>29, 30, 32, 34, 36</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.7/5</strong> dựa trên 389 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Fashion Boy</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Quần đẹp, form chuẩn, chất vải mềm mại. Mặc rất thoải mái!</p>
                            <small class="text-muted">3 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Trendy Guy</strong>
                                <div class="text-warning">★★★★☆</div>
                            </div>
                            <p class="mb-1">Chất lượng tốt với giá tiền. Size vừa vặn như mô tả.</p>
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
    document.querySelectorAll('.variant-option').forEach(option => {
        option.addEventListener('click', function() {
            const section = this.closest('.variant-section');
            if (section) {
                section.querySelectorAll('.variant-option').forEach(opt => opt.classList.remove('active'));
                this.classList.add('active');
                
                const selectedVariantDisplay = section.querySelector('.selected-variant strong');
                if (selectedVariantDisplay) {
                    selectedVariantDisplay.textContent = this.textContent;
                }
            }
        });
    });

    // Add to cart function
    document.getElementById('addToCartBtn').addEventListener('click', function() {
        const quantity = document.getElementById('quantity').value;
        const size = document.querySelector('.variant-section:nth-of-type(1) .variant-option.active').textContent;
        const color = document.querySelector('.variant-section:nth-of-type(2) .variant-option.active').textContent;
        alert(`Đã thêm ${quantity} Quần Jeans Nam size ${size} màu ${color} vào giỏ hàng!`);
    });

    // Buy now function
    document.getElementById('buyNowBtn').addEventListener('click', function() {
        const quantity = document.getElementById('quantity').value;
        const size = document.querySelector('.variant-section:nth-of-type(1) .variant-option.active').textContent;
        const color = document.querySelector('.variant-section:nth-of-type(2) .variant-option.active').textContent;
        alert(`Mua ngay ${quantity} Quần Jeans Nam size ${size} màu ${color}!`);
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