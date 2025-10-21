<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Điều Hòa Panasonic Inverter - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Điện máy</a></li>
            <li class="breadcrumb-item active">Điều Hòa Panasonic Inverter</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/dieu_hoa_panasonic.jpg"
                             id="mainProductImage"
                             alt="Điều Hòa Panasonic Inverter"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Điều Hòa Panasonic Inverter 1.5HP</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.7/5 (312 đánh giá)</span>
                        <span class="sold-count">Đã bán: 2,567</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-18%</div>
                        <h2 class="current-price">12.490.000₫</h2>
                        <span class="original-price">15.290.000₫</span>
                    </div>

                    <!-- Capacity Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-thermometer-half"></i>
                            Công suất
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="1hp">1HP (9.000 BTU)</div>
                            <div class="variant-option active" data-variant="1.5hp">1.5HP (12.000 BTU)</div>
                            <div class="variant-option" data-variant="2hp">2HP (18.000 BTU)</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>1.5HP (12.000 BTU)</strong></div>
                    </div>

                    <!-- Model Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-cog"></i>
                            Model
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="standard">Standard - Tiết kiệm</div>
                            <div class="variant-option" data-variant="premium">Premium - Cao cấp</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Standard - Tiết kiệm</strong></div>
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
                                    <i class="fas fa-leaf mb-2"></i><br>
                                    <strong>Inverter tiết kiệm</strong><br>
                                    <small>Tiết kiệm 60% điện</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-wind mb-2"></i><br>
                                    <strong>Lọc không khí</strong><br>
                                    <small>Nanoe-G kháng khuẩn</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-volume-mute mb-2"></i><br>
                                    <strong>Siêu êm ái</strong><br>
                                    <small>Dưới 19dB</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-snowflake mb-2"></i><br>
                                    <strong>Làm lạnh nhanh</strong><br>
                                    <small>Công nghệ J-Tech</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="3">
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
                        <p>Điều hòa Panasonic Inverter 1.5HP với công nghệ Inverter tiết kiệm điện, làm lạnh nhanh và vận hành siêu êm ái. Tích hợp công nghệ Nanoe-G kháng khuẩn cho không khí trong lành.</p>
                        <ul>
                            <li>Công nghệ Inverter tiết kiệm 60% điện năng</li>
                            <li>Công suất 1.5HP phù hợp phòng 15-20m²</li>
                            <li>Lọc không khí Nanoe-G kháng khuẩn 99%</li>
                            <li>Làm lạnh nhanh với công nghệ J-Tech</li>
                            <li>Vận hành siêu êm dưới 19dB</li>
                            <li>Bảo hành chính hãng 24 tháng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Thương hiệu:</strong></td><td>Panasonic (Nhật Bản)</td></tr>
                            <tr><td><strong>Công suất:</strong></td><td>1.5HP (12.000 BTU/h)</td></tr>
                            <tr><td><strong>Diện tích phù hợp:</strong></td><td>15-20m²</td></tr>
                            <tr><td><strong>Điện áp:</strong></td><td>220V - 50Hz</td></tr>
                            <tr><td><strong>Loại gas:</strong></td><td>R32 thân thiện môi trường</td></tr>
                            <tr><td><strong>Mức tiêu thụ điện:</strong></td><td>0.9kW/h</td></tr>
                            <tr><td><strong>Độ ồn:</strong></td><td>Dưới 19dB</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>24 tháng chính hãng</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.7/5</strong> dựa trên 312 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Anh Tùng M</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Điều hòa chạy êm, làm lạnh nhanh, tiết kiệm điện thật sự!</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Chị Lan N</strong>
                                <div class="text-warning">★★★★☆</div>
                            </div>
                            <p class="mb-1">Chất lượng Panasonic luôn đáng tin cậy. Lắp đặt chuyên nghiệp.</p>
                            <small class="text-muted">2 tuần trước</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    // Variant selection
    document.querySelectorAll('.variant-option').forEach(option => {
        option.addEventListener('click', function() {
            // Remove active class from siblings
            this.parentNode.querySelectorAll('.variant-option').forEach(sibling => {
                sibling.classList.remove('active');
            });
            // Add active class to clicked option
            this.classList.add('active');
            
            // Update selected variant display
            const selectedVariant = this.parentNode.parentNode.querySelector('.selected-variant strong');
            if (selectedVariant) {
                selectedVariant.textContent = this.textContent;
            }
        });
    });

    // Quantity controls
    function increaseQuantity() {
        const quantityInput = document.getElementById('quantity');
        const currentValue = parseInt(quantityInput.value);
        const maxValue = parseInt(quantityInput.getAttribute('max'));
        
        if (currentValue < maxValue) {
            quantityInput.value = currentValue + 1;
        }
    }

    function decreaseQuantity() {
        const quantityInput = document.getElementById('quantity');
        const currentValue = parseInt(quantityInput.value);
        const minValue = parseInt(quantityInput.getAttribute('min'));
        
        if (currentValue > minValue) {
            quantityInput.value = currentValue - 1;
        }
    }

    // Add to cart function
    function addToCart() {
        alert('Đã thêm sản phẩm vào giỏ hàng!');
    }

    // Buy now function
    function buyNow() {
        alert('Chuyển đến trang thanh toán!');
    }
</script>

</body>