<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TV Sony OLED 4K - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">TV & Audio</a></li>
            <li class="breadcrumb-item active">TV Sony OLED 4K</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/tv_sony_oled.jpg"
                             id="mainProductImage"
                             alt="TV Sony OLED 4K"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">TV Sony OLED 4K X90L Series</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (234 đánh giá)</span>
                        <span class="sold-count">Đã bán: 789</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-20%</div>
                        <h2 class="current-price">29.990.000₫</h2>
                        <span class="original-price">37.490.000₫</span>
                    </div>

                    <!-- Size Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-tv"></i>
                            Kích thước màn hình
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="55inch">55 inch</div>
                            <div class="variant-option active" data-variant="65inch">65 inch</div>
                            <div class="variant-option" data-variant="75inch">75 inch</div>
                            <div class="variant-option" data-variant="85inch">85 inch</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>65 inch</strong></div>
                    </div>

                    <!-- Model Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-cogs"></i>
                            Series
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="x85l">X85L LED</div>
                            <div class="variant-option active" data-variant="x90l">X90L OLED</div>
                            <div class="variant-option" data-variant="a95l">A95L QD-OLED</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>X90L OLED</strong></div>
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
                                    <i class="fas fa-eye mb-2"></i><br>
                                    <strong>OLED 4K HDR</strong><br>
                                    <small>Màu sắc hoàn hảo</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-brain mb-2"></i><br>
                                    <strong>Google TV</strong><br>
                                    <small>AI thông minh</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-gamepad mb-2"></i><br>
                                    <strong>Gaming Mode</strong><br>
                                    <small>HDMI 2.1 120Hz</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-volume-up mb-2"></i><br>
                                    <strong>Acoustic Surface</strong><br>
                                    <small>Âm thanh từ màn hình</small>
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
                        <p>TV Sony OLED 4K X90L Series với công nghệ OLED tự phát sáng, chip Cognitive Processor XR và Google TV thông minh. Trải nghiệm hình ảnh và âm thanh hoàn hảo cho mọi nội dung giải trí.</p>
                        <ul>
                            <li>Màn hình OLED 4K HDR với độ tương phản vô cực</li>
                            <li>Chip Cognitive Processor XR thông minh</li>
                            <li>Google TV với hàng nghìn ứng dụng</li>
                            <li>HDMI 2.1 hỗ trợ gaming 4K 120fps</li>
                            <li>Acoustic Surface Audio+ từ màn hình</li>
                            <li>Dolby Vision & Dolby Atmos</li>
                            <li>Thiết kế siêu mỏng, chân đế tối giản</li>
                            <li>Bảo hành chính hãng 24 tháng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Thương hiệu:</strong></td><td>Sony (Nhật Bản)</td></tr>
                            <tr><td><strong>Kích thước:</strong></td><td>65 inch</td></tr>
                            <tr><td><strong>Độ phân giải:</strong></td><td>4K Ultra HD (3840x2160)</td></tr>
                            <tr><td><strong>Công nghệ màn hình:</strong></td><td>OLED</td></tr>
                            <tr><td><strong>HDR:</strong></td><td>HDR10, Dolby Vision, HLG</td></tr>
                            <tr><td><strong>Refresh Rate:</strong></td><td>120Hz</td></tr>
                            <tr><td><strong>Hệ điều hành:</strong></td><td>Google TV</td></tr>
                            <tr><td><strong>Kết nối:</strong></td><td>4x HDMI 2.1, 2x USB, WiFi 6</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 234 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Cinema Lover</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">TV OLED tuyệt vời! Hình ảnh sắc nét, màu sắc sống động như rạp chiếu phim!</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Gaming Pro</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất lượng Sony đỉnh cao. Gaming 4K 120fps mượt mà, âm thanh xuất sắc.</p>
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
    // ...existing code...
</script>

</body>
</html>