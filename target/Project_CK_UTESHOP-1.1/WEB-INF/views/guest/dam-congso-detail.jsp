<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đầm Công Sở Cao Cấp - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">Thời trang nữ</a></li>
            <li class="breadcrumb-item active">Đầm Công Sở Cao Cấp</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/dam_congso.jpg"
                             id="mainProductImage"
                             alt="Đầm Công Sở Cao Cấp"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Đầm Công Sở Cao Cấp</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.8/5 (267 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,876</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-25%</div>
                        <h2 class="current-price">690.000₫</h2>
                        <span class="original-price">920.000₫</span>
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
                            <div class="variant-option active" data-variant="navy">Navy</div>
                            <div class="variant-option" data-variant="black">Đen</div>
                            <div class="variant-option" data-variant="wine">Đỏ đô</div>
                            <div class="variant-option" data-variant="beige">Be</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Navy</strong></div>
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
                                    <i class="fas fa-female mb-2"></i><br>
                                    <strong>Tôn dáng</strong><br>
                                    <small>Ôm vừa vặn</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-star mb-2"></i><br>
                                    <strong>Chất liệu cao cấp</strong><br>
                                    <small>Vải không nhăn</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-cut mb-2"></i><br>
                                    <strong>Thiết kế sang trọng</strong><br>
                                    <small>Phong cách Hàn Quốc</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-briefcase mb-2"></i><br>
                                    <strong>Đa dụng</strong><br>
                                    <small>Công sở & tiệc tùng</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="20">
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
                        <p>Đầm công sở cao cấp phong cách Hàn Quốc với thiết kế thanh lịch, sang trọng. Chất liệu vải cao cấp, form dáng ôm vừa vặn tôn dáng, phù hợp cho môi trường công sở và các dịp quan trọng.</p>
                        <ul>
                            <li>Chất liệu: Polyester cao cấp co giãn 4 chiều</li>
                            <li>Thiết kế: Form A line tôn dáng</li>
                            <li>Tay dài thanh lịch, cổ tròn nữ tính</li>
                            <li>Độ dài: Ngang gối, phù hợp đi làm</li>
                            <li>Có lót trong mềm mại, thoáng mát</li>
                            <li>Dễ phối phụ kiện, giày cao gót</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số sản phẩm</h5>
                        <table class="table">
                            <tr><td><strong>Chất liệu:</strong></td><td>Polyester 95%, Spandex 5%</td></tr>
                            <tr><td><strong>Xuất xứ:</strong></td><td>Việt Nam</td></tr>
                            <tr><td><strong>Form đầm:</strong></td><td>A-line fit</td></tr>
                            <tr><td><strong>Cổ đầm:</strong></td><td>Cổ tròn</td></tr>
                            <tr><td><strong>Tay áo:</strong></td><td>Tay dài</td></tr>
                            <tr><td><strong>Độ dài:</strong></td><td>Ngang gối</td></tr>
                            <tr><td><strong>Bảo quản:</strong></td><td>Giặt máy ở 30°C</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.8/5</strong> dựa trên 267 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Linh Thị H</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Đầm đẹp lắm, chất vải mềm mại, form dáng chuẩn. Mặc đi làm rất sang!</p>
                            <small class="text-muted">2 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Thu Thị I</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất lượng tuyệt vời, màu sắc đẹp như hình. Sẽ mua thêm!</p>
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
    // Variant selection
    document.querySelectorAll('.variant-option').forEach(option => {
        option.addEventListener('click', function() {
            // Remove active class from siblings
            this.parentNode.querySelectorAll('.variant-option').forEach(sibling => {
                sibling.classList.remove('active');
            });
            // Add active class to clicked option
            this.classList.add('active');
            
            // Update selected variant display
            const selectedVariant = this.parentNode.parentNode.querySelector('.selected-variant strong');
            if (selectedVariant) {
                selectedVariant.textContent = this.textContent;
            }
        });
    });

    // Quantity controls
    function increaseQuantity() {
        const quantityInput = document.getElementById('quantity');
        const currentValue = parseInt(quantityInput.value);
        const maxValue = parseInt(quantityInput.getAttribute('max'));
        
        if (currentValue < maxValue) {
            quantityInput.value = currentValue + 1;
        }
    }

    function decreaseQuantity() {
        const quantityInput = document.getElementById('quantity');
        const currentValue = parseInt(quantityInput.value);
        const minValue = parseInt(quantityInput.getAttribute('min'));
        
        if (currentValue > minValue) {
            quantityInput.value = currentValue - 1;
        }
    }

    // Add to cart function
    function addToCart() {
        alert('Đã thêm sản phẩm vào giỏ hàng!');
    }

    // Buy now function
    function buyNow() {
        alert('Chuyển đến trang thanh toán!');
    }
</script>

</body>
</html>
