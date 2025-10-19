<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Áo Thun Nam Cao Cấp - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">Thời trang nam</a></li>
            <li class="breadcrumb-item active">Áo Thun Nam Cao Cấp</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/aothun.jpg"
                             id="mainProductImage"
                             alt="Áo Thun Nam Cao Cấp"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Áo Thun Nam Cao Cấp</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.8/5 (156 đánh giá)</span>
                        <span class="sold-count">Đã bán: 2,341</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-20%</div>
                        <h2 class="current-price">199.000₫</h2>
                        <span class="original-price">249.000₫</span>
                    </div>

                    <!-- Size Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-ruler-horizontal"></i>
                            Kích thước
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="S">S</div>
                            <div class="variant-option active" data-variant="M">M</div>
                            <div class="variant-option" data-variant="L">L</div>
                            <div class="variant-option" data-variant="XL">XL</div>
                            <div class="variant-option" data-variant="XXL">XXL</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>M</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="black">Đen</div>
                            <div class="variant-option" data-variant="white">Trắng</div>
                            <div class="variant-option" data-variant="gray">Xám</div>
                            <div class="variant-option" data-variant="navy">Navy</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Đen</strong></div>
                    </div>

                    <!-- Key Features -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-star"></i>
                            Đặc điểm nổi bật
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-tshirt mb-2"></i><br>
                                    <strong>Cotton 100%</strong><br>
                                    <small>Chất liệu cao cấp</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-wind mb-2"></i><br>
                                    <strong>Thoáng khí</strong><br>
                                    <small>Thấm hút mồ hôi tốt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-alt mb-2"></i><br>
                                    <strong>Bền màu</strong><br>
                                    <small>Không phai sau giặt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-cut mb-2"></i><br>
                                    <strong>Form Regular</strong><br>
                                    <small>Phù hợp mọi dáng người</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="50">
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
                        <p>Áo thun nam cao cấp được làm từ chất liệu cotton 100% cao cấp, mang đến sự thoải mái tối đa cho người mặc. Thiết kế basic, dễ phối đồ và phù hợp với mọi hoàn cảnh.</p>
                        <ul>
                            <li>Chất liệu: Cotton 100% cao cấp</li>
                            <li>Form regular fit, vừa vặn với mọi dáng người</li>
                            <li>Thấm hút mồ hôi tốt, thoáng khí</li>
                            <li>Đường may chắc chắn, tỉ mỉ</li>
                            <li>Màu sắc bền đẹp, không phai sau giặt</li>
                            <li>Thiết kế basic, dễ phối đồ</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số sản phẩm</h5>
                        <table class="table">
                            <tr><td><strong>Chất liệu:</strong></td><td>Cotton 100%</td></tr>
                            <tr><td><strong>Xuất xứ:</strong></td><td>Việt Nam</td></tr>
                            <tr><td><strong>Form áo:</strong></td><td>Regular fit</td></tr>
                            <tr><td><strong>Cổ áo:</strong></td><td>Cổ tròn</td></tr>
                            <tr><td><strong>Tay áo:</strong></td><td>Tay ngắn</td></tr>
                            <tr><td><strong>Bảo quản:</strong></td><td>Giặt máy ở 30°C</td></tr>
                            <tr><td><strong>Size:</strong></td><td>S, M, L, XL, XXL</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.8/5</strong> dựa trên 156 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Nguyễn Minh Tuấn</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất áo rất đẹp, mặc thoải mái. Form vừa vặn như mô tả.</p>
                            <small class="text-muted">3 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Lê Văn Nam</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Giá cả hợp lý, chất lượng tốt. Sẽ mua thêm!</p>
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
    function changeMainImage(src) {
        document.getElementById('mainProductImage').src = src;
    }

    function increaseQuantity() {
        const input = document.getElementById('quantity');
        const currentValue = parseInt(input.value);
        if (currentValue < 50) {
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
        const size = document.querySelector('.variant-option.active[data-variant]').dataset.variant;
        
        alert(`Đã thêm ${quantity} áo thun size ${size} vào giỏ hàng!`);
    }

    function buyNow() {
        const quantity = document.getElementById('quantity').value;
        const size = document.querySelector('.variant-option.active[data-variant]').dataset.variant;
        
        alert(`Mua ngay ${quantity} áo thun size ${size}!`);
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