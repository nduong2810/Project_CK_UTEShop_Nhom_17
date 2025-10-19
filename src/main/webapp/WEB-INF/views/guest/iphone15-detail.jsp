<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>iPhone 15 Pro Max - UTESHOP</title>
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
            <li class="breadcrumb-item active">iPhone 15 Pro Max</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/iphone15.jpg"
                             id="mainProductImage"
                             alt="iPhone 15 Pro Max"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">iPhone 15 Pro Max 256GB</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (1,234 đánh giá)</span>
                        <span class="sold-count">Đã bán: 5,678</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-3%</div>
                        <h2 class="current-price">33.990.000₫</h2>
                        <span class="original-price">34.990.000₫</span>
                    </div>

                    <!-- Storage Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-hdd"></i>
                            Dung lượng
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="128gb">128GB</div>
                            <div class="variant-option active" data-variant="256gb">256GB</div>
                            <div class="variant-option" data-variant="512gb">512GB</div>
                            <div class="variant-option" data-variant="1tb">1TB</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>256GB</strong></div>
                    </div>

                    <!-- Color Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-palette"></i>
                            Màu sắc
                        </div>
                        <div class="variant-options">
                            <div class="variant-option active" data-variant="natural-titanium">Natural Titanium</div>
                            <div class="variant-option" data-variant="blue-titanium">Blue Titanium</div>
                            <div class="variant-option" data-variant="white-titanium">White Titanium</div>
                            <div class="variant-option" data-variant="black-titanium">Black Titanium</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Natural Titanium</strong></div>
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
                                    <i class="fas fa-microchip mb-2"></i><br>
                                    <strong>A17 Pro</strong><br>
                                    <small>Chip 3nm mạnh nhất</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-camera mb-2"></i><br>
                                    <strong>Camera 48MP</strong><br>
                                    <small>Pro camera system</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-mobile-alt mb-2"></i><br>
                                    <strong>Màn hình 6.7"</strong><br>
                                    <small>Super Retina XDR</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-plug mb-2"></i><br>
                                    <strong>USB-C</strong><br>
                                    <small>Kết nối đa năng</small>
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
                        <p>iPhone 15 Pro Max với chip A17 Pro đột phá, khung viền Titanium cao cấp và hệ thống camera Pro tiên tiến. Thiết kế mỏng nhẹ hơn với hiệu năng vượt trội.</p>
                        <ul>
                            <li>Chip A17 Pro 3nm với GPU 6 nhân</li>
                            <li>Màn hình Super Retina XDR 6.7 inch</li>
                            <li>Dynamic Island và Always-On display</li>
                            <li>Hệ thống camera Pro 48MP với zoom 5x</li>
                            <li>Khung viền Titanium grade 5</li>
                            <li>Kết nối USB-C với USB 3</li>
                            <li>Face ID và Touch ID</li>
                            <li>5G và Wi-Fi 6E</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Chip:</strong></td><td>A17 Pro 3nm</td></tr>
                            <tr><td><strong>Màn hình:</strong></td><td>6.7" Super Retina XDR</td></tr>
                            <tr><td><strong>Độ phân giải:</strong></td><td>2796 x 1290 pixels</td></tr>
                            <tr><td><strong>Camera chính:</strong></td><td>48MP f/1.78</td></tr>
                            <tr><td><strong>Camera telephoto:</strong></td><td>12MP f/2.8 (5x zoom)</td></tr>
                            <tr><td><strong>Camera trước:</strong></td><td>12MP TrueDepth</td></tr>
                            <tr><td><strong>Pin:</strong></td><td>Lên đến 29 giờ video</td></tr>
                            <tr><td><strong>Khung viền:</strong></td><td>Titanium grade 5</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 1,234 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Apple Fan</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">iPhone tuyệt vời nhất từ trước đến nay! Camera Pro xuất sắc, pin bền!</p>
                            <small class="text-muted">2 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Tech Reviewer</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">A17 Pro mạnh mẽ, Titanium sang trọng. Đáng đồng tiền bát gạo!</p>
                            <small class="text-muted">4 ngày trước</small>
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
        if (currentValue < 3) {
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
        const storage = document.querySelector('.variant-section:nth-child(4) .variant-option.active').dataset.variant;
        const color = document.querySelector('.variant-section:nth-child(5) .variant-option.active').dataset.variant;
        
        alert(`Đã thêm ${quantity} iPhone 15 Pro Max ${storage} màu ${color} vào giỏ hàng!`);
    }

    function buyNow() {
        const quantity = document.getElementById('quantity').value;
        const storage = document.querySelector('.variant-section:nth-child(4) .variant-option.active').dataset.variant;
        const color = document.querySelector('.variant-section:nth-child(5) .variant-option.active').dataset.variant;
        
        alert(`Mua ngay ${quantity} iPhone 15 Pro Max ${storage} màu ${color}!`);
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