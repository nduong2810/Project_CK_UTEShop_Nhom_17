<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Blazer Nữ Công Sở - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Thời trang nữ</a></li>
            <li class="breadcrumb-item active">Blazer Nữ Công Sở</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/blazer_nu.jpg"
                             id="mainProductImage"
                             alt="Blazer Nữ Công Sở"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Blazer Nữ Công Sở Cao Cấp</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.6/5 (189 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,234</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-30%</div>
                        <h2 class="current-price">890.000₫</h2>
                        <span class="original-price">1.290.000₫</span>
                    </div>

                    <!-- Size Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-ruler-horizontal"></i>
                            Kích thước
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="S">S</div>
                            <div class="variant-option active" data-variant="M">M</div>
                            <div class="variant-option" data-variant="L">L</div>
                            <div class="variant-option" data-variant="XL">XL</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>M</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="black">Đen</div>
                            <div class="variant-option" data-variant="navy">Navy</div>
                            <div class="variant-option" data-variant="gray">Xám</div>
                            <div class="variant-option" data-variant="beige">Be</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Đen</strong></div>
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
                                    <strong>Thiết kế sang trọng</strong><br>
                                    <small>Phong cách công sở</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-tshirt mb-2"></i><br>
                                    <strong>Vải cao cấp</strong><br>
                                    <small>Polyester co giãn</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-alt mb-2"></i><br>
                                    <strong>Không nhăn</strong><br>
                                    <small>Giữ form dáng tốt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-star mb-2"></i><br>
                                    <strong>Phù hợp mọi dáng</strong><br>
                                    <small>Tôn dáng hoàn hảo</small>
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
                        <p>Blazer nữ công sở cao cấp với thiết kế hiện đại, sang trọng. Chất liệu vải cao cấp, form dáng chuẩn tôn dáng, phù hợp cho môi trường công sở và các dịp quan trọng.</p>
                        <ul>
                            <li>Chất liệu: Polyester cao cấp co giãn</li>
                            <li>Thiết kế: Form slim fit, tôn dáng</li>
                            <li>Cổ vest chuyên nghiệp, tay dài thanh lịch</li>
                            <li>Có túi ngực và túi hai bên</li>
                            <li>Lót trong mát mẻ, thoáng khí</li>
                            <li>Dễ phối đồ, phù hợp nhiều hoàn cảnh</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số sản phẩm</h5>
                        <table class="table">
                            <tr><td><strong>Chất liệu:</strong></td><td>Polyester 95%, Spandex 5%</td></tr>
                            <tr><td><strong>Xuất xứ:</strong></td><td>Việt Nam</td></tr>
                            <tr><td><strong>Form áo:</strong></td><td>Slim fit</td></tr>
                            <tr><td><strong>Cổ áo:</strong></td><td>Cổ vest</td></tr>
                            <tr><td><strong>Tay áo:</strong></td><td>Tay dài</td></tr>
                            <tr><td><strong>Bảo quản:</strong></td><td>Giặt khô hoặc giặt máy ở 30°C</td></tr>
                            <tr><td><strong>Size:</strong></td><td>S, M, L, XL</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.6/5</strong> dựa trên 189 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Hoàng Thị F</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Blazer đẹp, chất vải tốt, form dáng chuẩn. Mặc đi làm rất sang!</p>
                            <small class="text-muted">4 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Mai Thị G</strong>
                                <div class="text-warning">★★★★☆</div>
                            </div>
                            <p class="mb-1">Chất lượng tốt, giao hàng nhanh. Size vừa vặn như mô tả.</p>
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
        alert('Đã thêm sản phẩm vào giỏ hàng!');
    });

    // Buy now function
    document.getElementById('buyNowBtn').addEventListener('click', function() {
        alert('Chuyển đến trang thanh toán!');
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