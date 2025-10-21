<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Máy Ép Trái Cây - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Gia dụng</a></li>
            <li class="breadcrumb-item active">Máy Ép Trái Cây</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/may_ep_trai_cay.jpg"
                             id="mainProductImage"
                             alt="Máy Ép Trái Cây"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Máy Ép Trái Cây Slow Juicer</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.8/5 (189 đánh giá)</span>
                        <span class="sold-count">Đã bán: 967</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-30%</div>
                        <h2 class="current-price">2.090.000₫</h2>
                        <span class="original-price">2.990.000₫</span>
                    </div>

                    <!-- Type Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-cogs"></i>
                            Loại máy ép
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="slow">Slow Juicer</div>
                            <div class="variant-option" data-variant="centrifugal">Centrifugal</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Slow Juicer</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="white">Trắng</div>
                            <div class="variant-option" data-variant="black">Đen</div>
                            <div class="variant-option" data-variant="red">Đỏ</div>
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
                                    <i class="fas fa-leaf mb-2"></i><br>
                                    <strong>Công nghệ Cold Press</strong><br>
                                    <small>Giữ nguyên dinh dưỡng</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-volume-mute mb-2"></i><br>
                                    <strong>Hoạt động êm ái</strong><br>
                                    <small>< 60dB</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-alt mb-2"></i><br>
                                    <strong>An toàn tuyệt đối</strong><br>
                                    <small>Khóa bảo vệ</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-tint mb-2"></i><br>
                                    <strong>Tách bã hiệu quả</strong><br>
                                    <small>Nước cốt nguyên chất</small>
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
                        <p>Máy ép trái cây slow juicer với công nghệ cold press hiện đại, giữ nguyên dinh dưỡng và vitamin trong trái cây. Hoạt động êm ái, an toàn và dễ sử dụng.</p>
                        <ul>
                            <li>Công nghệ Cold Press ép chậm 80 RPM</li>
                            <li>Motor mạnh mẽ 200W</li>
                            <li>Ống nạp rộng 75mm</li>
                            <li>Chất liệu Tritan không BPA</li>
                            <li>Dễ dàng tháo rời vệ sinh</li>
                            <li>Bảo hành 24 tháng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Công suất:</strong></td><td>200W</td></tr>
                            <tr><td><strong>Tốc độ:</strong></td><td>80 RPM</td></tr>
                            <tr><td><strong>Chất liệu:</strong></td><td>Tritan không BPA</td></tr>
                            <tr><td><strong>Ống nạp:</strong></td><td>Φ75mm</td></tr>
                            <tr><td><strong>Điện áp:</strong></td><td>220V - 50Hz</td></tr>
                            <tr><td><strong>Kích thước:</strong></td><td>180 x 230 x 430mm</td></tr>
                            <tr><td><strong>Trọng lượng:</strong></td><td>4.5kg</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>24 tháng</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.8/5</strong> dựa trên 189 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Healthy Life</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Máy ép tuyệt vời! Nước ép ngon, không bọt. Rất hài lòng!</p>
                            <small class="text-muted">2 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Fresh Juice</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất lượng tốt, hoạt động êm. Dễ vệ sinh.</p>
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
</script>

</body>