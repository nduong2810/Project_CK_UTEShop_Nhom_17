<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bàn Làm Việc Hiện Đại - UTESHOP</title>
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
            <li class="breadcrumb-item active">Bàn Làm Việc Hiện Đại</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/ban_lam_viec.jpg"
                             id="mainProductImage"
                             alt="Bàn Làm Việc Hiện Đại"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Bàn Làm Việc Hiện Đại</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.7/5 (234 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,456</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-15%</div>
                        <h2 class="current-price">2.990.000₫</h2>
                        <span class="original-price">3.490.000₫</span>
                    </div>

                    <!-- Size Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-ruler-combined"></i>
                            Kích thước
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="120x60">120x60cm</div>
                            <div class="variant-option active" data-variant="140x70">140x70cm</div>
                            <div class="variant-option" data-variant="160x80">160x80cm</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>140x70cm</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="walnut">Walnut</div>
                            <div class="variant-option" data-variant="oak">Oak</div>
                            <div class="variant-option" data-variant="white">Trắng</div>
                            <div class="variant-option" data-variant="black">Đen</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Walnut</strong></div>
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
                                    <i class="fas fa-tree mb-2"></i><br>
                                    <strong>Gỗ tự nhiên</strong><br>
                                    <small>MDF phủ Melamine</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-cogs mb-2"></i><br>
                                    <strong>Điều chỉnh độ cao</strong><br>
                                    <small>72-76cm</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-alt mb-2"></i><br>
                                    <strong>Chống trầy xước</strong><br>
                                    <small>Bề mặt bền bỉ</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-tools mb-2"></i><br>
                                    <strong>Lắp ráp dễ dàng</strong><br>
                                    <small>Hướng dẫn chi tiết</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="10">
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
                        <p>Bàn làm việc hiện đại với thiết kế tối giản, phù hợp cho văn phòng và phòng học tại nhà. Bề mặt rộng rãi, chắc chắn và có thể điều chỉnh độ cao theo nhu cầu sử dụng.</p>
                        <ul>
                            <li>Chất liệu: MDF phủ Melamine cao cấp</li>
                            <li>Khung chân thép sơn tĩnh điện chống gỉ</li>
                            <li>Bề mặt chống trầy xước, chống thấm nước</li>
                            <li>Thiết kế hiện đại, phù hợp mọi không gian</li>
                            <li>Có thể điều chỉnh độ cao từ 72-76cm</li>
                            <li>Lắp ráp dễ dàng với hướng dẫn chi tiết</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Chất liệu mặt bàn:</strong></td><td>MDF phủ Melamine</td></tr>
                            <tr><td><strong>Khung chân:</strong></td><td>Thép sơn tĩnh điện</td></tr>
                            <tr><td><strong>Độ cao:</strong></td><td>72-76cm (điều chỉnh được)</td></tr>
                            <tr><td><strong>Tải trọng:</strong></td><td>Tối đa 80kg</td></tr>
                            <tr><td><strong>Xuất xứ:</strong></td><td>Việt Nam</td></tr>
                            <tr><td><strong>Bảo hành:</strong></td><td>24 tháng</td></tr>
                            <tr><td><strong>Lắp đặt:</strong></td><td>Miễn phí tại TP.HCM</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.7/5</strong> dựa trên 234 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Trần Văn B</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Bàn chắc chắn, thiết kế đẹp, phù hợp làm việc tại nhà!</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Lê Thị C</strong>
                                <div class="text-warning">★★★★☆</div>
                            </div>
                            <p class="mb-1">Chất lượng tốt, lắp ráp dễ dàng. Giao hàng nhanh.</p>
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