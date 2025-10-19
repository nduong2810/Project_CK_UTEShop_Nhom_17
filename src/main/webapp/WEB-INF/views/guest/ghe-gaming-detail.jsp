<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ghế Gaming Pro - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">Nội thất</a></li>
            <li class="breadcrumb-item active">Ghế Gaming Pro</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/ghe_gaming.jpg"
                             id="mainProductImage"
                             alt="Ghế Gaming Pro"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Ghế Gaming Pro RGB - Ergonomic</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.8/5 (278 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,890</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-22%</div>
                        <h2 class="current-price">3.890.000₫</h2>
                        <span class="original-price">4.990.000₫</span>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="black-red">Đen-Đỏ</div>
                            <div class="variant-option" data-variant="black-blue">Đen-Xanh</div>
                            <div class="variant-option" data-variant="white-pink">Trắng-Hồng</div>
                            <div class="variant-option" data-variant="all-black">Đen toàn bộ</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Đen-Đỏ</strong></div>
                    </div>

                    <!-- Material Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-couch"></i>
                            Chất liệu
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="pu-leather">Da PU cao cấp</div>
                            <div class="variant-option" data-variant="fabric">Vải lưới thoáng khí</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Da PU cao cấp</strong></div>
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
                                    <i class="fas fa-adjust mb-2"></i><br>
                                    <strong>Ngả 180 độ</strong><br>
                                    <small>Nghỉ ngơi thoải mái</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-magic mb-2"></i><br>
                                    <strong>LED RGB</strong><br>
                                    <small>16 triệu màu</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-weight mb-2"></i><br>
                                    <strong>Chịu tải 150kg</strong><br>
                                    <small>Khung thép chắc chắn</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-spa mb-2"></i><br>
                                    <strong>Massage rung</strong><br>
                                    <small>Thư giãn cột sống</small>
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
                        <p>Ghế Gaming Pro RGB với thiết kế ergonomic, tích hợp LED RGB và chức năng massage. Được thiết kế đặc biệt cho game thủ và dân văn phòng cần ngồi lâu.</p>
                        <ul>
                            <li>Thiết kế ergonomic hỗ trợ cột sống</li>
                            <li>Chất liệu da PU cao cấp chống thấm</li>
                            <li>LED RGB 16 triệu màu điều khiển qua app</li>
                            <li>Chức năng massage rung thư giãn</li>
                            <li>Ngả 90-180 độ với khóa góc nghỉ</li>
                            <li>Tay đỡ 4D điều chỉnh đa hướng</li>
                            <li>Bánh xe cao su êm ái</li>
                            <li>Bảo hành 36 tháng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Kích thước:</strong></td><td>70 x 70 x 125-135cm</td></tr>
                            <tr><td><strong>Chất liệu:</strong></td><td>Da PU + Khung thép</td></tr>
                            <tr><td><strong>Trọng lượng:</strong></td><td>25kg</td></tr>
                            <tr><td><strong>Tải trọng:</strong></td><td>Tối đa 150kg</td></tr>
                            <tr><td><strong>Góc ngả:</strong></td><td>90-180 độ</td></tr>
                            <tr><td><strong>Tay đỡ:</strong></td><td>4D điều chỉnh</td></tr>
                            <tr><td><strong>RGB:</strong></td><td>16 triệu màu</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>36 tháng</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.8/5</strong> dựa trên 278 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Gaming Master</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Ghế tuyệt vời! RGB đẹp, massage rất sướng. Ngồi 8 tiếng không mỏi!</p>
                            <small class="text-muted">5 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Office Worker</strong>
                                <div class="text-warning">★★★★☆</div>
                            </div>
                            <p class="mb-1">Chất lượng tốt, lắp ráp dễ dàng. Phù hợp cả gaming và làm việc.</p>
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
    function increaseQuantity() {
        const input = document.getElementById('quantity');
        const currentValue = parseInt(input.value);
        if (currentValue < 5) {
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
        const color = document.querySelector('.variant-option.active[data-variant]').dataset.variant;
        const material = document.querySelector('.variant-option.active[data-variant]').dataset.variant;
        
        alert(`Đã thêm ${quantity} ghế gaming màu ${color} (${material}) vào giỏ hàng!`);
    }

    function buyNow() {
        const quantity = document.getElementById('quantity').value;
        const color = document.querySelector('.variant-option.active[data-variant]').dataset.variant;
        const material = document.querySelector('.variant-option.active[data-variant]').dataset.variant;
        
        alert(`Mua ngay ${quantity} ghế gaming màu ${color} (${material})!`);
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