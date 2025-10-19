<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Máy Giặt LG Inverter - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">Điện máy</a></li>
            <li class="breadcrumb-item active">Máy Giặt LG Inverter</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/may_giat_lg.jpg"
                             id="mainProductImage"
                             alt="Máy Giặt LG Inverter"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Máy Giặt LG Inverter 9kg</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.7/5 (456 đánh giá)</span>
                        <span class="sold-count">Đã bán: 2,345</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-15%</div>
                        <h2 class="current-price">7.990.000₫</h2>
                        <span class="original-price">9.390.000₫</span>
                    </div>

                    <!-- Capacity Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-weight"></i>
                            Khối lượng giặt
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="7kg">7kg</div>
                            <div class="variant-option active" data-variant="9kg">9kg</div>
                            <div class="variant-option" data-variant="10kg">10kg</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>9kg</strong></div>
                    </div>

                    <!-- Type Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-cogs"></i>
                            Loại máy giặt
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="inverter">Inverter</div>
                            <div class="variant-option" data-variant="ai-dd">AI DD Motor</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Inverter</strong></div>
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
                                    <strong>Tiết kiệm điện</strong><br>
                                    <small>Inverter 5 sao</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-brain mb-2"></i><br>
                                    <strong>AI Washing</strong><br>
                                    <small>Giặt thông minh</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-volume-mute mb-2"></i><br>
                                    <strong>Vận hành êm ái</strong><br>
                                    <small>Công nghệ DD Motor</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-virus mb-2"></i><br>
                                    <strong>Diệt khuẩn</strong><br>
                                    <small>TurboShot™</small>
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
                        <p>Máy giặt LG Inverter 9kg với công nghệ AI Washing thông minh, tiết kiệm điện và nước. Motor DD trực tiếp vận hành êm ái, bền bỉ với bảo hành 10 năm.</p>
                        <ul>
                            <li>Công nghệ Inverter tiết kiệm điện 5 sao</li>
                            <li>AI Washing tự động điều chỉnh chu trình giặt</li>
                            <li>Motor DD trực tiếp, bảo hành 10 năm</li>
                            <li>TurboShot™ loại bỏ bụi bẩn cứng đầu</li>
                            <li>14 chương trình giặt đa dạng</li>
                            <li>Cửa kính cường lực, an toàn</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Thương hiệu:</strong></td><td>LG (Hàn Quốc)</td></tr>
                            <tr><td><strong>Khối lượng giặt:</strong></td><td>9kg</td></tr>
                            <tr><td><strong>Loại máy:</strong></td><td>Cửa trước</td></tr>
                            <tr><td><strong>Motor:</strong></td><td>DD Inverter</td></tr>
                            <tr><td><strong>Tốc độ vắt:</strong></td><td>1400 vòng/phút</td></tr>
                            <tr><td><strong>Kích thước:</strong></td><td>600 x 560 x 850mm</td></tr>
                            <tr><td><strong>Trọng lượng:</strong></td><td>62kg</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>24 tháng (Motor 10 năm)</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.7/5</strong> dựa trên 456 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Gia đình viên mãn</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Máy giặt tuyệt vời! Giặt sạch, vắt khô, rất tiết kiệm điện!</p>
                            <small class="text-muted">3 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Smart Home</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất lượng LG đáng tin cậy. Hoạt động êm, AI thông minh.</p>
                            <small class="text-muted">1 tuần trước</small>
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