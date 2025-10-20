<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bếp Từ Nhật Bản - UTESHOP</title>
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
            <li class="breadcrumb-item active">Bếp Từ Nhật Bản</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/bep_tu.jpg"
                             id="mainProductImage"
                             alt="Bếp Từ Nhật Bản"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Bếp Từ Nhật Bản Panasonic KY-A22</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.8/5 (367 đánh giá)</span>
                        <span class="sold-count">Đã bán: 2,567</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-25%</div>
                        <h2 class="current-price">3.490.000₫</h2>
                        <span class="original-price">4.650.000₫</span>
                    </div>

                    <!-- Power Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-bolt"></i>
                            Công suất
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="1800w">1800W</div>
                            <div class="variant-option active" data-variant="2200w">2200W</div>
                            <div class="variant-option" data-variant="2800w">2800W</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>2200W</strong></div>
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
                                    <i class="fas fa-fire mb-2"></i><br>
                                    <strong>8 mức công suất</strong><br>
                                    <small>Điều chỉnh linh hoạt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-clock mb-2"></i><br>
                                    <strong>Hẹn giờ 3 tiếng</strong><br>
                                    <small>Tự động tắt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-alt mb-2"></i><br>
                                    <strong>An toàn tuyệt đối</strong><br>
                                    <small>Chống quá nhiệt</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-leaf mb-2"></i><br>
                                    <strong>Tiết kiệm điện</strong><br>
                                    <small>Hiệu suất 90%</small>
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
                        <p>Bếp từ Nhật Bản Panasonic KY-A22 với công nghệ nấu từ tiên tiến, thiết kế sang trọng và tính năng an toàn vượt trội. Sản phẩm được nhập khẩu trực tiếp từ Nhật Bản.</p>
                        <ul>
                            <li>Công nghệ từ trường inverter tiết kiệm điện</li>
                            <li>8 mức công suất điều chỉnh linh hoạt</li>
                            <li>Hẹn giờ nấu tự động lên đến 3 tiếng</li>
                            <li>Chức năng khóa trẻ em an toàn</li>
                            <li>Mặt kính chịu nhiệt Schott Ceran</li>
                            <li>Bảo hành chính hãng 24 tháng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Thương hiệu:</strong></td><td>Panasonic (Nhật Bản)</td></tr>
                            <tr><td><strong>Model:</strong></td><td>KY-A22</td></tr>
                            <tr><td><strong>Công suất:</strong></td><td>2200W</td></tr>
                            <tr><td><strong>Điện áp:</strong></td><td>220V - 50Hz</td></tr>
                            <tr><td><strong>Mặt bếp:</strong></td><td>Kính chịu nhiệt Schott Ceran</td></tr>
                            <tr><td><strong>Kích thước:</strong></td><td>350 x 430 x 65mm</td></tr>
                            <tr><td><strong>Trọng lượng:</strong></td><td>3.2kg</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>24 tháng chính hãng</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.8/5</strong> dựa trên 367 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Phạm Thị D</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Bếp rất tốt, nấu nóng nhanh và tiết kiệm điện!</p>
                            <small class="text-muted">5 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Nguyễn Văn E</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Chất lượng Nhật Bản, thiết kế đẹp, dễ sử dụng.</p>
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