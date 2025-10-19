<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MacBook Pro M3 - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Laptop</a></li>
            <li class="breadcrumb-item active">MacBook Pro M3</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/macbook.jpg"
                             id="mainProductImage"
                             alt="MacBook Pro M3"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">MacBook Pro 14" M3 Pro</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (678 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,456</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-6%</div>
                        <h2 class="current-price">56.990.000₫</h2>
                        <span class="original-price">60.490.000₫</span>
                    </div>

                    <!-- Chip Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-microchip"></i>
                            Chip xử lý
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="m3">M3 (8-core CPU)</div>
                            <div class="variant-option active" data-variant="m3-pro">M3 Pro (12-core CPU)</div>
                            <div class="variant-option" data-variant="m3-max">M3 Max (16-core CPU)</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>M3 Pro (12-core CPU)</strong></div>
                    </div>

                    <!-- RAM Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-memory"></i>
                            Bộ nhớ RAM
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="18gb">18GB Unified Memory</div>
                            <div class="variant-option active" data-variant="36gb">36GB Unified Memory</div>
                            <div class="variant-option" data-variant="64gb">64GB Unified Memory</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>36GB Unified Memory</strong></div>
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
                                    <i class="fas fa-tv mb-2"></i><br>
                                    <strong>Liquid Retina XDR</strong><br>
                                    <small>14.2" ProMotion 120Hz</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-battery-three-quarters mb-2"></i><br>
                                    <strong>Pin 18 tiếng</strong><br>
                                    <small>Video playback</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-camera mb-2"></i><br>
                                    <strong>Camera 1080p</strong><br>
                                    <small>FaceTime HD</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-plug mb-2"></i><br>
                                    <strong>Thunderbolt 4</strong><br>
                                    <small>3x USB-C ports</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="2">
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
                        <p>MacBook Pro 14" với chip M3 Pro mạnh mẽ, màn hình Liquid Retina XDR tuyệt đẹp và hiệu năng vượt trội cho công việc chuyên nghiệp. Hoàn hảo cho developer, designer và content creator.</p>
                        <ul>
                            <li>Chip M3 Pro với CPU 12 nhân, GPU 18 nhân</li>
                            <li>Màn hình Liquid Retina XDR 14.2" ProMotion 120Hz</li>
                            <li>36GB Unified Memory siêu nhanh</li>
                            <li>SSD 1TB tốc độ cao</li>
                            <li>3 cổng Thunderbolt 4, HDMI, SDXC, MagSafe 3</li>
                            <li>Camera FaceTime HD 1080p</li>
                            <li>Studio-quality microphones</li>
                            <li>Touch ID và bàn phím Magic Keyboard</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Chip:</strong></td><td>Apple M3 Pro</td></tr>
                            <tr><td><strong>CPU:</strong></td><td>12-core (6P + 6E)</td></tr>
                            <tr><td><strong>GPU:</strong></td><td>18-core</td></tr>
                            <tr><td><strong>RAM:</strong></td><td>36GB Unified Memory</td></tr>
                            <tr><td><strong>SSD:</strong></td><td>1TB</td></tr>
                            <tr><td><strong>Màn hình:</strong></td><td>14.2" Liquid Retina XDR</td></tr>
                            <tr><td><strong>Độ phân giải:</strong></td><td>3024 x 1964 pixels</td></tr>
                            <tr><td><strong>Pin:</strong></td><td>70Wh lithium-polymer</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 678 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Developer Pro</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">MacBook tuyệt vời! Compile code siêu nhanh, màn hình đẹp xuất sắc!</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Video Editor</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Edit 4K ProRes mượt mà, render nhanh không tưởng. Đáng tiền!</p>
                            <small class="text-muted">3 ngày trước</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function increaseQuantity() {
        const input = document.getElementById('quantity');
        const currentValue = parseInt(input.value);
        if (currentValue < 2) {
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
        const config = document.querySelector('.variant-section:nth-child(4) .variant-option.active').dataset.variant;
        const color = document.querySelector('.variant-section:nth-child(5) .variant-option.active').dataset.variant;
        
        alert(`Đã thêm ${quantity} MacBook Pro ${config} màu ${color} vào giỏ hàng!`);
    }

    function buyNow() {
        const quantity = document.getElementById('quantity').value;
        const config = document.querySelector('.variant-section:nth-child(4) .variant-option.active').dataset.variant;
        const color = document.querySelector('.variant-section:nth-child(5) .variant-option.active').dataset.variant;
        
        alert(`Mua ngay ${quantity} MacBook Pro ${config} màu ${color}!`);
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
</html>