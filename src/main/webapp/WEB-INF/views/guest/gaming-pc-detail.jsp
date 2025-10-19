<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gaming PC RTX 4070 - UTESHOP</title>
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
            <li class="breadcrumb-item"><a href="#">Gaming PC</a></li>
            <li class="breadcrumb-item active">Gaming PC RTX 4070</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/gaming_pc.jpg"
                             id="mainProductImage"
                             alt="Gaming PC RTX 4070"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Gaming PC RTX 4070 - Core i7 13700KF</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.9/5 (156 đánh giá)</span>
                        <span class="sold-count">Đã bán: 567</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-10%</div>
                        <h2 class="current-price">45.990.000₫</h2>
                        <span class="original-price">50.990.000₫</span>
                    </div>

                    <!-- CPU Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-microchip"></i>
                            Bộ xử lý
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="i5-13600k">Core i5-13600K</div>
                            <div class="variant-option active" data-variant="i7-13700kf">Core i7-13700KF</div>
                            <div class="variant-option" data-variant="i9-13900k">Core i9-13900K</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>Core i7-13700KF</strong></div>
                    </div>

                    <!-- GPU Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-display"></i>
                            Card đồ họa
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="rtx4060ti">RTX 4060 Ti</div>
                            <div class="variant-option active" data-variant="rtx4070">RTX 4070</div>
                            <div class="variant-option" data-variant="rtx4070ti">RTX 4070 Ti</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>RTX 4070</strong></div>
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
                                    <i class="fas fa-rocket mb-2"></i><br>
                                    <strong>Hiệu năng cao</strong><br>
                                    <small>4K Gaming 60FPS</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-memory mb-2"></i><br>
                                    <strong>32GB RAM DDR5</strong><br>
                                    <small>6000MHz tốc độ cao</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-hdd mb-2"></i><br>
                                    <strong>SSD 1TB NVMe</strong><br>
                                    <small>Gen4 siêu nhanh</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-fan mb-2"></i><br>
                                    <strong>Tản nhiệt AIO</strong><br>
                                    <small>RGB đồng bộ</small>
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
                        <p>Gaming PC cao cấp với cấu hình mạnh mẽ, chạy mượt mà mọi tựa game AAA ở độ phân giải 4K. Thiết kế RGB đẹp mắt và hệ thống tản nhiệt hiệu quả.</p>
                        <ul>
                            <li>CPU: Intel Core i7-13700KF (16 nhân, 24 luồng)</li>
                            <li>GPU: NVIDIA GeForce RTX 4070 12GB GDDR6X</li>
                            <li>RAM: 32GB DDR5-6000MHz</li>
                            <li>SSD: 1TB NVMe Gen4 PCIe 4.0</li>
                            <li>Mainboard: Z790 chipset cao cấp</li>
                            <li>PSU: 850W 80+ Gold Modular</li>
                            <li>Case: Mid Tower với RGB đồng bộ</li>
                            <li>Bảo hành: 36 tháng chính hãng</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>CPU:</strong></td><td>Intel Core i7-13700KF</td></tr>
                            <tr><td><strong>GPU:</strong></td><td>NVIDIA RTX 4070 12GB</td></tr>
                            <tr><td><strong>RAM:</strong></td><td>32GB DDR5-6000MHz</td></tr>
                            <tr><td><strong>SSD:</strong></td><td>1TB NVMe Gen4</td></tr>
                            <tr><td><strong>Mainboard:</strong></td><td>Z790 Chipset</td></tr>
                            <tr><td><strong>PSU:</strong></td><td>850W 80+ Gold</td></tr>
                            <tr><td><strong>Case:</strong></td><td>RGB Mid Tower</td></tr>
                            <tr><td><strong>Hệ điều hành:</strong></td><td>Windows 11 Pro</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.9/5</strong> dựa trên 156 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Gamer Pro</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">PC chạy cực mượt! Cyberpunk 2077 4K Ultra 70FPS!</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Streamer Việt</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Cấu hình tuyệt vời cho streaming và gaming. Nhiệt độ ổn định.</p>
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