<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Sony Headphones WH-1000XM5 - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Âm thanh</a></li>
            <li class="breadcrumb-item active">Sony Headphones WH-1000XM5</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/sony_headphones.jpg"
                             id="mainProductImage"
                             alt="Sony Headphones WH-1000XM5"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Sony WH-1000XM5</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (567 đánh giá)</span>
                        <span class="sold-count">Đã bán: 3,456</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-15%</div>
                        <h2 class="current-price">8.490.000₫</h2>
                        <span class="original-price">9.990.000₫</span>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="black">Đen</div>
                            <div class="variant-option" data-variant="silver">Bạc</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Đen</strong></div>
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
                                    <small>Hàng đầu thế giới</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-music mb-2"></i><br>
                                    <strong>LDAC Hi-Res</strong><br>
                                    <small>Âm thanh chất lượng cao</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-battery-three-quarters mb-2"></i><br>
                                    <strong>Pin 30 giờ</strong><br>
                                    <small>Sạc nhanh 3 phút = 3 giờ</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-hand-paper mb-2"></i><br>
                                    <strong>Touch Control</strong><br>
                                    <small>Điều khiển cảm ứng</small>
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
                        <p>Sony WH-1000XM5 với công nghệ khử tiếng ồn hàng đầu thế giới, âm thanh Hi-Res và thiết kế sang trọng. Tai nghe over-ear cao cấp cho trải nghiệm âm nhạc đỉnh cao.</p>
                        <ul>
                            <li>Khử tiếng ồn chủ động thế hệ mới</li>
                            <li>Driver 30mm với âm thanh LDAC Hi-Res</li>
                            <li>Pin 30 giờ, sạc nhanh USB-C</li>
                            <li>Speak-to-Chat tự động tạm dừng nhạc</li>
                            <li>Multipoint kết nối 2 thiết bị đồng thời</li>
                            <li>Thiết kế nhẹ và thoải mái cho cả ngày</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Driver:</strong></td><td>30mm Dynamic</td></tr>
                            <tr><td><strong>Đáp ứng tần số:</strong></td><td>4Hz - 40kHz</td></tr>
                            <tr><td><strong>Kết nối:</strong></td><td>Bluetooth 5.2, LDAC, SBC, AAC</td></tr>
                            <tr><td><strong>Pin:</strong></td><td>30 giờ (ANC bật), 40 giờ (ANC tắt)</td></tr>
                            <tr><td><strong>Sạc:</strong></td><td>USB-C, sạc nhanh 3 phút = 3 giờ</td></tr>
                            <tr><td><strong>Trọng lượng:</strong></td><td>250g</td></tr>
                            <tr><td><strong>Tính năng:</strong></td><td>ANC, Speak-to-Chat, Multipoint</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 567 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Nguyễn Minh Tú</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Tai nghe tuyệt vời! Khử tiếng ồn rất hiệu quả, âm thanh trong trẻo.</p>
                            <small class="text-muted">2 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Trần Thị Hoa</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Pin trâu, đeo thoải mái cả ngày. Chất lượng Sony không thể chê.</p>
                            <small class="text-muted">5 ngày trước</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    // ...existing code...
    
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