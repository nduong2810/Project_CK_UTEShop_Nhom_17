<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lò Vi Sóng Sharp - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">Gia dụng</a></li>
            <li class="breadcrumb-item active">Lò Vi Sóng Sharp</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/lo_vi_song.jpg"
                             id="mainProductImage"
                             alt="Lò Vi Sóng Sharp"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Lò Vi Sóng Sharp R-G223VN-S 20L</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.6/5 (245 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,567</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-20%</div>
                        <h2 class="current-price">1.990.000₫</h2>
                        <span class="original-price">2.490.000₫</span>
                    </div>

                    <!-- Capacity Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-expand-arrows-alt"></i>
                            Dung tích
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="20l">20L</div>
                            <div class="variant-option" data-variant="23l">23L</div>
                            <div class="variant-option" data-variant="25l">25L</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>20L</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="silver">Bạc</div>
                            <div class="variant-option" data-variant="black">Đen</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Bạc</strong></div>
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
                                    <i class="fas fa-microwave mb-2"></i><br>
                                    <strong>Công suất 800W</strong><br>
                                    <small>Nấu nóng nhanh</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-clock mb-2"></i><br>
                                    <strong>Hẹn giờ 99 phút</strong><br>
                                    <small>Tự động ngắt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-alt mb-2"></i><br>
                                    <strong>Khóa an toàn trẻ em</strong><br>
                                    <small>Bảo vệ tuyệt đối</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-leaf mb-2"></i><br>
                                    <strong>Tiết kiệm điện</strong><br>
                                    <small>Công nghệ Inverter</small>
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
                        <p>Lò vi sóng Sharp R-G223VN-S với dung tích 20L, công suất 800W và nhiều tính năng tiện ích. Thiết kế hiện đại, vận hành êm ái và tiết kiệm điện năng.</p>
                        <ul>
                            <li>Dung tích 20L phù hợp gia đình 3-4 người</li>
                            <li>Công suất 800W nấu nóng nhanh</li>
                            <li>11 mức công suất điều chỉnh</li>
                            <li>Hẹn giờ lên đến 99 phút</li>
                            <li>Khóa an toàn trẻ em</li>
                            <li>Bảo hành chính hãng 12 tháng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Thương hiệu:</strong></td><td>Sharp (Nhật Bản)</td></tr>
                            <tr><td><strong>Model:</strong></td><td>R-G223VN-S</td></tr>
                            <tr><td><strong>Dung tích:</strong></td><td>20L</td></tr>
                            <tr><td><strong>Công suất:</strong></td><td>800W</td></tr>
                            <tr><td><strong>Điện áp:</strong></td><td>220V - 50Hz</td></tr>
                            <tr><td><strong>Kích thước:</strong></td><td>440 x 325 x 258mm</td></tr>
                            <tr><td><strong>Trọng lượng:</strong></td><td>11.5kg</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>12 tháng chính hãng</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.6/5</strong> dựa trên 245 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Gia đình hạnh phúc</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Lò vi sóng tốt, nấu nóng đều. Sharp luôn đáng tin cậy!</p>
                            <small class="text-muted">4 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Bà nội trợ</strong>
                                <div class="text-warning">★★★★☆</div>
                            </div>
                            <p class="mb-1">Chất lượng ổn, giá hợp lý. Dùng rất tiện lợi.</p>
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