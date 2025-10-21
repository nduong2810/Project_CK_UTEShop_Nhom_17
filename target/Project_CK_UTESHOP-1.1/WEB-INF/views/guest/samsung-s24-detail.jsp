<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Samsung Galaxy S24 Ultra - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">Điện thoại</a></li>
            <li class="breadcrumb-item active">Samsung Galaxy S24 Ultra</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/samsung_s24.jpg"
                             id="mainProductImage"
                             alt="Samsung Galaxy S24 Ultra"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Samsung Galaxy S24 Ultra 5G</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.8/5 (1,567 đánh giá)</span>
                        <span class="sold-count">Đã bán: 4,890</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-8%</div>
                        <h2 class="current-price">29.990.000₫</h2>
                        <span class="original-price">32.590.000₫</span>
                    </div>

                    <!-- Storage Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-hdd"></i>
                            Dung lượng
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="256gb">256GB</div>
                            <div class="variant-option active" data-variant="512gb">512GB</div>
                            <div class="variant-option" data-variant="1tb">1TB</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>512GB</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="titanium-black">Titanium Black</div>
                            <div class="variant-option" data-variant="titanium-gray">Titanium Gray</div>
                            <div class="variant-option" data-variant="titanium-violet">Titanium Violet</div>
                            <div class="variant-option" data-variant="titanium-yellow">Titanium Yellow</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Titanium Black</strong></div>
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
                                    <i class="fas fa-brain mb-2"></i><br>
                                    <strong>Galaxy AI</strong><br>
                                    <small>Trí tuệ nhân tạo</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-camera mb-2"></i><br>
                                    <strong>Camera 200MP</strong><br>
                                    <small>Zoom 100x Space</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-pen mb-2"></i><br>
                                    <strong>S Pen tích hợp</strong><br>
                                    <small>Viết, vẽ, điều khiển</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-mobile-alt mb-2"></i><br>
                                    <strong>Dynamic AMOLED</strong><br>
                                    <small>6.8" 120Hz</small>
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
                        <p>Samsung Galaxy S24 Ultra với Galaxy AI thông minh, camera 200MP zoom 100x và S Pen tích hợp. Khung viền Titanium cao cấp, màn hình Dynamic AMOLED 2X 6.8 inch.</p>
                        <ul>
                            <li>Chip Snapdragon 8 Gen 3 for Galaxy</li>
                            <li>Camera chính 200MP với zoom quang học 5x</li>
                            <li>S Pen tích hợp với nhiều tính năng AI</li>
                            <li>Màn hình Dynamic AMOLED 2X 6.8" 120Hz</li>
                            <li>Pin 5000mAh sạc nhanh 45W</li>
                            <li>Khung viền Titanium Grade 2</li>
                            <li>Kháng nước IP68</li>
                            <li>Hỗ trợ 5G và Wi-Fi 7</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Chip:</strong></td><td>Snapdragon 8 Gen 3 for Galaxy</td></tr>
                            <tr><td><strong>Màn hình:</strong></td><td>6.8" Dynamic AMOLED 2X</td></tr>
                            <tr><td><strong>Độ phân giải:</strong></td><td>3120 x 1440 pixels</td></tr>
                            <tr><td><strong>RAM:</strong></td><td>12GB</td></tr>
                            <tr><td><strong>Camera chính:</strong></td><td>200MP f/1.7</td></tr>
                            <tr><td><strong>Camera telephoto:</strong></td><td>50MP f/3.4 (5x zoom)</td></tr>
                            <tr><td><strong>Pin:</strong></td><td>5000mAh, sạc nhanh 45W</td></tr>
                            <tr><td><strong>Hệ điều hành:</strong></td><td>Android 14, One UI 6.1</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.8/5</strong> dựa trên 1,567 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Galaxy Fan</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">S24 Ultra tuyệt vời! Galaxy AI thông minh, camera zoom 100x ấn tượng!</p>
                            <small class="text-muted">2 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Tech Enthusiast</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Hiệu năng mạnh mẽ, S Pen tiện lợi. Xứng đáng flagship 2024!</p>
                            <small class="text-muted">5 ngày trước</small>
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