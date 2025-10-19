<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Máy Xay Sinh Tố Vitamix - UTESHOP</title>
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
            <li class="breadcrumb-item active">Máy Xay Sinh Tố Vitamix</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/may_xay_sinh_to.jpg"
                             id="mainProductImage"
                             alt="Máy Xay Sinh Tố Vitamix"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                    
                    <!-- Thumbnail Gallery -->
                    <div class="thumbnail-gallery mt-3">
                        <div class="row g-2">
                            <div class="col-3">
                                <img src="${pageContext.request.contextPath}/assets/img/may_xay_sinh_to.jpg" 
                                     class="img-fluid rounded border thumbnail-img active"
                                     onclick="changeMainImage(this.src)" alt="Ảnh 1">
                            </div>
                            <div class="col-3">
                                <img src="${pageContext.request.contextPath}/assets/img/may_xay_sinh_to_2.jpg" 
                                     class="img-fluid rounded border thumbnail-img"
                                     onclick="changeMainImage(this.src)" alt="Ảnh 2"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                            </div>
                            <div class="col-3">
                                <img src="${pageContext.request.contextPath}/assets/img/may_xay_sinh_to_3.jpg" 
                                     class="img-fluid rounded border thumbnail-img"
                                     onclick="changeMainImage(this.src)" alt="Ảnh 3"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                            </div>
                            <div class="col-3">
                                <img src="${pageContext.request.contextPath}/assets/img/may_xay_sinh_to_4.jpg" 
                                     class="img-fluid rounded border thumbnail-img"
                                     onclick="changeMainImage(this.src)" alt="Ảnh 4"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">
                        <i class="fas fa-blender me-2 text-primary"></i>
                        Máy Xay Sinh Tố Vitamix Pro 750
                    </h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <span class="rating-text ms-2">(5.0)</span>
                        </div>
                        <div class="sold-count">
                            <i class="fas fa-shopping-cart me-1"></i>
                            Đã bán 128
                        </div>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-15%</div>
                        <h2 class="current-price">8.500.000₫</h2>
                        <span class="original-price">10.000.000₫</span>
                    </div>

                    <!-- Product Features -->
                    <div class="features-section mb-4">
                        <h5 class="mb-3"><i class="fas fa-award me-2 text-success"></i>Tính năng nổi bật</h5>
                        <div class="row g-2">
                            <div class="col-6">
                                <div class="feature-item">
                                    <i class="fas fa-cog text-primary me-2"></i>
                                    <span>Motor 2HP</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="feature-item">
                                    <i class="fas fa-leaf text-success me-2"></i>
                                    <span>BPA Free</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="feature-item">
                                    <i class="fas fa-shield-alt text-warning me-2"></i>
                                    <span>Bảo hành 7 năm</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="feature-item">
                                    <i class="fas fa-thermometer-half text-info me-2"></i>
                                    <span>Tự làm nóng</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Capacity Options -->
                    <div class="variant-section">
                        <h5 class="variant-title">
                            <i class="fas fa-glass-whiskey"></i>
                            Chọn dung tích:
                        </h5>
                        <div class="variant-options">
                            <button class="variant-option capacity-option" data-capacity="1.4" onclick="selectCapacity(this)">
                                1.4L<br><small>Cho 1-2 người</small>
                            </button>
                            <button class="variant-option capacity-option active" data-capacity="2.0" onclick="selectCapacity(this)">
                                2.0L<br><small>Cho 3-4 người</small>
                            </button>
                            <button class="variant-option capacity-option" data-capacity="2.5" onclick="selectCapacity(this)">
                                2.5L<br><small>Cho 5-6 người</small>
                            </button>
                        </div>
                        <div class="selected-variant">
                            <strong>Dung tích đã chọn:</strong> <span id="selectedCapacity">2.0L - Cho 3-4 người</span>
                        </div>
                    </div>

                    <!-- Quantity Section -->
                    <div class="quantity-section">
                        <label class="quantity-label">Số lượng:</label>
                        <div class="quantity-controls">
                            <button class="quantity-btn" type="button" onclick="changeQuantity(-1)">
                                <i class="fas fa-minus"></i>
                            </button>
                            <input type="text" id="quantity" class="quantity-input" value="1" min="1" max="3" readonly>
                            <button class="quantity-btn" type="button" onclick="changeQuantity(1)">
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                        <small class="text-muted ms-3">Còn lại: 15 sản phẩm</small>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button class="btn-add-cart" onclick="addToCart()">
                            <i class="fas fa-cart-plus me-2"></i>
                            Thêm vào giỏ hàng
                        </button>
                        <button class="btn-buy-now" onclick="buyNow()">
                            <i class="fas fa-bolt me-2"></i>
                            Mua ngay
                        </button>
                    </div>

                    <!-- Delivery Info -->
                    <div class="delivery-info mt-4">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="info-item">
                                    <i class="fas fa-truck text-primary me-2"></i>
                                    <div>
                                        <strong>Giao hàng nhanh</strong>
                                        <br><small>2-3 ngày làm việc</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <i class="fas fa-undo text-success me-2"></i>
                                    <div>
                                        <strong>Đổi trả 30 ngày</strong>
                                        <br><small>Miễn phí đổi trả</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Description Tabs -->
    <div class="product-tabs mt-4">
        <div class="card">
            <div class="card-header">
                <ul class="nav nav-tabs card-header-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-bs-toggle="tab" href="#description">Mô tả sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#specifications">Thông số kỹ thuật</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#reviews">Đánh giá (15)</a>
                    </li>
                </ul>
            </div>
            <div class="card-body">
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="description">
                        <h5>Máy Xay Sinh Tố Vitamix Pro 750 - Đỉnh cao của công nghệ xay</h5>
                        <p>Vitamix Pro 750 là dòng máy xay sinh tố cao cấp nhất với công nghệ motor 2HP mạnh mẽ, có thể xay nhuyễn mọi loại thực phẩm từ trái cây mềm đến các loại hạt cứng. Thiết kế hiện đại, vận hành êm ái và bảo hành lên đến 7 năm.</p>
                        
                        <h6>Ưu điểm nổi bật:</h6>
                        <ul>
                            <li>Motor 2HP siêu mạnh, vận hành êm ái</li>
                            <li>Cối xay Tritan BPA-free an toàn cho sức khỏe</li>
                            <li>10 chế độ tốc độ + chế độ tự động</li>
                            <li>Có thể tự làm nóng thức ăn nhờ ma sát</li>
                            <li>Bảo hành chính hãng 7 năm tại Việt Nam</li>
                        </ul>
                    </div>
                    <div class="tab-pane fade" id="specifications">
                        <table class="table table-striped">
                            <tr><td><strong>Thương hiệu</strong></td><td>Vitamix</td></tr>
                            <tr><td><strong>Model</strong></td><td>Pro 750</td></tr>
                            <tr><td><strong>Công suất motor</strong></td><td>2HP (1491W)</td></tr>
                            <tr><td><strong>Dung tích</strong></td><td>1.4L / 2.0L / 2.5L</td></tr>
                            <tr><td><strong>Chất liệu cối</strong></td><td>Tritan BPA-free</td></tr>
                            <tr><td><strong>Tốc độ</strong></td><td>10 chế độ + Pulse</td></tr>
                            <tr><td><strong>Kích thước</strong></td><td>28 x 22 x 51 cm</td></tr>
                            <tr><td><strong>Trọng lượng</strong></td><td>5.6 kg</td></tr>
                            <tr><td><strong>Xuất xứ</strong></td><td>Mỹ</td></tr>
                            <tr><td><strong>Bảo hành</strong></td><td>7 năm</td></tr>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="reviews">
                        <div class="reviews-summary mb-4">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="text-center">
                                        <h2 class="text-warning">5.0</h2>
                                        <div class="rating-stars mb-2">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                        </div>
                                        <p class="text-muted">15 đánh giá</p>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="rating-breakdown">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2">5★</span>
                                            <div class="progress flex-grow-1 me-2">
                                                <div class="progress-bar bg-warning" style="width: 100%"></div>
                                            </div>
                                            <span class="text-muted">15</span>
                                        </div>
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2">4★</span>
                                            <div class="progress flex-grow-1 me-2">
                                                <div class="progress-bar bg-warning" style="width: 0%"></div>
                                            </div>
                                            <span class="text-muted">0</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex align-items-start">
                                <div class="me-3">
                                    <div class="avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                        N
                                    </div>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex align-items-center mb-1">
                                        <strong class="me-2">Nguyễn Văn A</strong>
                                        <div class="rating-stars">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                        </div>
                                    </div>
                                    <p class="text-muted small mb-2">2 ngày trước</p>
                                    <p>Máy rất tốt, xay mịn, vận hành êm. Đáng đồng tiền bát gạo. Sẽ giới thiệu cho bạn bè.</p>
                                </div>
                            </div>
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
let selectedCapacity = '2.0';

function changeMainImage(src) {
    document.getElementById('mainProductImage').src = src;
    // Update thumbnail active state
    document.querySelectorAll('.thumbnail-img').forEach(img => img.classList.remove('active'));
    event.target.classList.add('active');
}

function selectCapacity(element) {
    document.querySelectorAll('.capacity-option').forEach(option => option.classList.remove('active'));
    element.classList.add('active');
    selectedCapacity = element.dataset.capacity;
    
    const capacityText = element.innerHTML.replace('<br>', ' - ').replace('<small>', '').replace('</small>', '');
    document.getElementById('selectedCapacity').innerHTML = capacityText;
}

function changeQuantity(delta) {
    const input = document.getElementById('quantity');
    let value = parseInt(input.value) + delta;
    if (value >= 1 && value <= 3) {
        input.value = value;
    }
}

function addToCart() {
    const qty = document.getElementById('quantity').value;
    const capacity = document.getElementById('selectedCapacity').textContent;
    
    // Add loading effect
    const btn = event.target;
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang thêm...';
    btn.disabled = true;
    
    setTimeout(() => {
        btn.innerHTML = originalText;
        btn.disabled = false;
        showNotification(`Đã thêm ${qty} máy xay sinh tố ${capacity} vào giỏ hàng!`, 'success');
    }, 1000);
}

function buyNow() {
    const qty = document.getElementById('quantity').value;
    const capacity = document.getElementById('selectedCapacity').textContent;
    const total = (8500000 * qty).toLocaleString('vi-VN');
    
    if (confirm(`Xác nhận mua ${qty} máy xay sinh tố ${capacity}\nTổng tiền: ${total}₫`)) {
        showNotification('Đang chuyển đến trang thanh toán...', 'info');
        // Redirect to checkout page
        setTimeout(() => {
            window.location.href = '/checkout';
        }, 1500);
    }
}

function showNotification(message, type = 'success') {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type} position-fixed`;
    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    notification.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'} me-2"></i>
        ${message}
        <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
    `;
    document.body.appendChild(notification);
    
    setTimeout(() => {
        if (notification.parentElement) {
            notification.remove();
        }
    }, 3000);
}

// Add smooth scrolling and animations
document.addEventListener('DOMContentLoaded', function() {
    // Animate price on load
    const priceElement = document.querySelector('.current-price');
    if (priceElement) {
        priceElement.style.transform = 'scale(0.8)';
        priceElement.style.transition = 'transform 0.5s ease';
        setTimeout(() => {
            priceElement.style.transform = 'scale(1)';
        }, 300);
    }
    
    // Add hover effects to feature items
    document.querySelectorAll('.feature-item').forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.style.transform = 'translateX(5px)';
            this.style.transition = 'transform 0.3s ease';
        });
        
        item.addEventListener('mouseleave', function() {
            this.style.transform = 'translateX(0)';
        });
    });
});
</script>

<style>
.thumbnail-img {
    height: 60px;
    object-fit: cover;
    cursor: pointer;
    transition: all 0.3s ease;
    opacity: 0.7;
}

.thumbnail-img:hover,
.thumbnail-img.active {
    opacity: 1;
    transform: scale(1.05);
    border-color: #0066cc !important;
}

.features-section .feature-item {
    padding: 0.5rem;
    border-radius: 8px;
    transition: all 0.3s ease;
    cursor: pointer;
}

.features-section .feature-item:hover {
    background: rgba(0, 102, 204, 0.1);
}

.delivery-info .info-item {
    display: flex;
    align-items: center;
    padding: 1rem;
    background: #f8f9fa;
    border-radius: 8px;
    border-left: 4px solid #0066cc;
}

.product-tabs .nav-link {
    color: #6c757d;
    border: none;
    border-bottom: 2px solid transparent;
    transition: all 0.3s ease;
}

.product-tabs .nav-link.active {
    color: #0066cc;
    border-bottom-color: #0066cc;
    background: transparent;
}

.review-item .avatar {
    font-weight: bold;
    font-size: 1.2rem;
}

.rating-breakdown .progress {
    height: 8px;
}
</style>

</body>
</html>