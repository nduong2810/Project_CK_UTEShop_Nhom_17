<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Máy Hút Bụi Dyson V15 - UTESHOP</title>
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
            <li class="breadcrumb-item active">Máy Hút Bụi Dyson V15</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/may_hut_bui_dyson.jpg"
                             id="mainProductImage"
                             alt="Máy Hút Bụi Dyson V15"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Máy Hút Bụi Dyson V15 Detect Absolute</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (289 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,123</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-12%</div>
                        <h2 class="current-price">19.990.000₫</h2>
                        <span class="original-price">22.690.000₫</span>
                    </div>

                    <!-- Model Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-cogs"></i>
                            Model
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="v12">V12 Detect Slim</div>
                            <div class="variant-option active" data-variant="v15">V15 Detect Absolute</div>
                            <div class="variant-option" data-variant="gen5">Gen5 Outsize</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>V15 Detect Absolute</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="yellow">Vàng</div>
                            <div class="variant-option" data-variant="purple">Tím</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Vàng</strong></div>
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
                                    <strong>Laser Detect</strong><br>
                                    <small>Phát hiện bụi siêu nhỏ</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-battery-three-quarters mb-2"></i><br>
                                    <strong>Pin 60 phút</strong><br>
                                    <small>Hút liên tục</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-brain mb-2"></i><br>
                                    <strong>Intelligent Suction</strong><br>
                                    <small>Tự động điều chỉnh</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-filter mb-2"></i><br>
                                    <strong>HEPA Filter</strong><br>
                                    <small>Lọc 99.97% bụi</small>
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
                        <p>Máy hút bụi Dyson V15 Detect Absolute với công nghệ Laser Detect phát hiện bụi siêu nhỏ, motor Hyperdymium mạnh mẽ và pin lithium kéo dài. Công nghệ hút bụi không dây tiên tiến nhất.</p>
                        <ul>
                            <li>Công nghệ Laser Detect phát hiện bụi vi mô</li>
                            <li>Motor Hyperdymium 230AW siêu mạnh</li>
                            <li>Pin lithium 60 phút sử dụng</li>
                            <li>14 cyclone song song loại bỏ bụi bẩn</li>
                            <li>Màn hình LCD hiển thị thông tin chi tiết</li>
                            <li>8 đầu hút chuyên dụng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Thương hiệu:</strong></td><td>Dyson (Anh)</td></tr>
                            <tr><td><strong>Model:</strong></td><td>V15 Detect Absolute</td></tr>
                            <tr><td><strong>Công suất hút:</strong></td><td>230AW</td></tr>
                            <tr><td><strong>Pin:</strong></td><td>Lithium-ion 60 phút</td></tr>
                            <tr><td><strong>Dung tích:</strong></td><td>0.77L</td></tr>
                            <tr><td><strong>Trọng lượng:</strong></td><td>3.1kg</td></tr>
                            <tr><td><strong>Đầu hút:</strong></td><td>8 đầu hút chuyên dụng</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>24 tháng chính hãng</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 289 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Clean Master</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Máy hút bụi tuyệt vời! Laser thấy được bụi nhỏ, hút rất mạnh!</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Home Perfect</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất lượng Dyson đỉnh cao. Pin bền, hút sạch hoàn toàn.</p>
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
    let selectedColor = 'gold';

function selectColor(element) {
    document.querySelectorAll('.color-option').forEach(option => option.classList.remove('active'));
    element.classList.add('active');
    selectedColor = element.dataset.color;
    document.getElementById('selectedColor').textContent = element.textContent;
}

function changeQuantity(delta) {
    const input = document.getElementById('quantity');
    let value = parseInt(input.value) + delta;
    if (value >= 1 && value <= 3) input.value = value;
}

function addToCart() {
    const qty = document.getElementById('quantity').value;
    const color = document.getElementById('selectedColor').textContent;
    alert(`Đã thêm ${qty} máy hút bụi Dyson màu ${color} vào giỏ hàng!`);
}

function buyNow() {
    const qty = document.getElementById('quantity').value;
    const color = document.getElementById('selectedColor').textContent;
    const total = (16500000 * qty).toLocaleString('vi-VN');
    alert(`Mua ngay ${qty} máy hút bụi Dyson màu ${color}\nTổng tiền: ${total}₫`);
}
</script>

</body>
</html>