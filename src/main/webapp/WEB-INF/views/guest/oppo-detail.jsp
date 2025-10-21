<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>OPPO Find X7 Ultra - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>

<body>
<div class="container my-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">OPPO Find X7 Ultra</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Product Image Gallery -->
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/oppo.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="OPPO Find X7 Ultra"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
            
            <!-- Thumbnail Images -->
            <div class="thumbnail-container d-flex gap-2">
                <img src="${pageContext.request.contextPath}/assets/img/oppo.jpg" 
                     class="thumbnail-image border rounded" 
                     onclick="changeMainImage(this.src)"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" 
                     class="thumbnail-image border rounded" 
                     onclick="changeMainImage(this.src)">
            </div>
        </div>

        <!-- Product Details -->
        <div class="col-lg-6">
            <h1 class="display-6 fw-bold">OPPO Find X7 Ultra</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star-half-alt"></i>
                    <span class="text-muted ms-1">(4.7 | Đã bán: 1,892)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="h2 text-danger fw-bolder" id="currentPrice">26.990.000₫</span>
                    <span class="text-muted text-decoration-line-through">29.990.000₫</span>
                </div>
                <small class="text-success">Tiết kiệm: 3.000.000₫</small>
            </div>

            <!-- Product Description -->
            <div class="product-description mb-4">
                <p class="text-muted">OPPO Find X7 Ultra - Flagship camera phone với hệ thống camera Hasselblad Master và chip Snapdragon 8 Gen 3. Thiết kế cao cấp, hiệu năng mạnh mẽ cho nhiếp ảnh chuyên nghiệp.</p>
            </div>

            <!-- Camera Features -->
            <div class="camera-features mb-4">
                <h5 class="fw-bold mb-3">Hệ thống camera đỉnh cao:</h5>
                <div class="row g-3">
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-camera fa-2x text-primary mb-2"></i>
                            <h6 class="fw-bold">50MP Chính</h6>
                            <small>Sony LYT-900, OIS</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-search-plus fa-2x text-success mb-2"></i>
                            <h6 class="fw-bold">50MP Periscope</h6>
                            <small>Zoom quang học 6x</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-expand fa-2x text-info mb-2"></i>
                            <h6 class="fw-bold">50MP Ultra-wide</h6>
                            <small>114° góc siêu rộng</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-portrait fa-2x text-warning mb-2"></i>
                            <h6 class="fw-bold">50MP Portrait</h6>
                            <small>Zoom quang học 3x</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Color Options -->
            <div class="color-options mb-4">
                <h5 class="fw-bold mb-3">Chọn màu sắc:</h5>
                <div class="d-flex gap-2">
                    <button class="color-option active" data-color="Ocean Blue" data-price="0" 
                            style="background: linear-gradient(45deg, #1e3c72, #2a5298); width: 40px; height: 40px; border-radius: 50%; border: 2px solid #007bff;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Sepia Brown" data-price="0"
                            style="background: linear-gradient(45deg, #8b4513, #a0522d); width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Tailored Black" data-price="0"
                            style="background: #1a1a1a; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                </div>
                <p class="mt-2 mb-0"><strong>Màu đã chọn:</strong> <span id="selectedColor">Ocean Blue</span></p>
            </div>

            <!-- Storage Options -->
            <div class="storage-options mb-4">
                <h5 class="fw-bold mb-3">Chọn dung lượng:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-outline-primary storage-option active" data-storage="256GB" data-price="26990000" onclick="selectStorage(this)">256GB</button>
                    <button class="btn btn-outline-primary storage-option" data-storage="512GB" data-price="31990000" onclick="selectStorage(this)">512GB</button>
                    <button class="btn btn-outline-primary storage-option" data-storage="1TB" data-price="36990000" onclick="selectStorage(this)">1TB</button>
                </div>
                <p class="mt-2 mb-0"><strong>Bộ nhớ:</strong> <span id="selectedStorage">256GB</span></p>
            </div>

            <!-- Specifications -->
            <div class="specifications mb-4">
                <h5 class="fw-bold mb-3">Thông số kỹ thuật:</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fa fa-microchip text-primary me-2"></i><strong>Chip:</strong> Snapdragon 8 Gen 3</li>
                    <li class="mb-2"><i class="fa fa-tv text-primary me-2"></i><strong>Màn hình:</strong> 6.82" LTPO AMOLED 120Hz</li>
                    <li class="mb-2"><i class="fa fa-memory text-primary me-2"></i><strong>RAM:</strong> 16GB LPDDR5X</li>
                    <li class="mb-2"><i class="fa fa-camera text-primary me-2"></i><strong>Camera:</strong> Quad 50MP Hasselblad</li>
                    <li class="mb-2"><i class="fa fa-battery-three-quarters text-primary me-2"></i><strong>Pin:</strong> 5400mAh, sạc nhanh 100W</li>
                    <li class="mb-2"><i class="fa fa-shield-alt text-primary me-2"></i><strong>Kháng nước:</strong> IP68</li>
                </ul>
            </div>

            <hr>

            <!-- Quantity Section -->
            <div class="quantity-section mb-4">
                <span class="quantity-label">Số lượng:</span>
                <div class="quantity-controls">
                    <button class="quantity-btn" id="decreaseQuantityBtn">-</button>
                    <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="5">
                    <button class="quantity-btn" id="increaseQuantityBtn">+</button>
                </div>
                <span class="quantity-label" style="margin-left: 1rem;">5 sản phẩm có sẵn</span>
            </div>

            <div class="d-grid gap-2 d-sm-flex">
                <button class="btn btn-primary btn-lg flex-grow-1" type="button" id="addToCartBtn">
                    <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>
                <button class="btn btn-warning btn-lg flex-grow-1" type="button" id="buyNowBtn">
                    <i class="fa fa-bolt"></i> Mua ngay
                </button>
            </div>

            <!-- OPPO Benefits -->
            <div class="oppo-benefits mt-4 p-3 bg-light rounded">
                <h6 class="fw-bold mb-2">Ưu đãi từ OPPO:</h6>
                <ul class="list-unstyled mb-0 small">
                    <li class="mb-1"><i class="fa fa-camera text-primary me-2"></i>Khóa học nhiếp ảnh Hasselblad miễn phí</li>
                    <li class="mb-1"><i class="fa fa-shield-alt text-success me-2"></i>Bảo hành chính hãng OPPO 18 tháng</li>
                    <li class="mb-1"><i class="fa fa-sync text-info me-2"></i>Đổi trả trong 15 ngày</li>
                    <li class="mb-1"><i class="fa fa-gift text-warning me-2"></i>Tặng ốp lưng và dán cường lực</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Product Details Tabs -->
    <div class="row mt-5">
        <div class="col-12">
            <ul class="nav nav-tabs" id="productTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button">Mô tả chi tiết</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="camera-tab" data-bs-toggle="tab" data-bs-target="#camera" type="button">Camera Hasselblad</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="specifications-tab" data-bs-toggle="tab" data-bs-target="#specifications" type="button">Thông số kỹ thuật</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button">Đánh giá</button>
                </li>
            </ul>
            
            <div class="tab-content" id="productTabContent">
                <div class="tab-pane fade show active" id="description" role="tabpanel">
                    <div class="p-4">
                        <h5>OPPO Find X7 Ultra - Flagship Camera Phone đỉnh cao</h5>
                        <p>OPPO Find X7 Ultra là smartphone flagship mới nhất với hệ thống camera Hasselblad Master độc quyền. Sản phẩm kết hợp hoàn hảo giữa công nghệ nhiếp ảnh chuyên nghiệp và hiệu năng mạnh mẽ từ chip Snapdragon 8 Gen 3.</p>
                        
                        <h6 class="mt-4">Điểm nổi bật:</h6>
                        <ul>
                            <li><strong>Hệ thống camera Hasselblad:</strong> 4 camera 50MP với chất lượng ảnh đỉnh cao</li>
                            <li><strong>Màn hình LTPO:</strong> 6.82" AMOLED với tần số quét thích ứng 120Hz</li>
                            <li><strong>Hiệu năng flagship:</strong> Snapdragon 8 Gen 3 với 16GB RAM</li>
                            <li><strong>Sạc siêu nhanh:</strong> 100W có dây và 50W không dây</li>
                            <li><strong>Thiết kế cao cấp:</strong> Mặt lưng da thuần chay thân thiện môi trường</li>
                            <li><strong>ColorOS 14:</strong> Giao diện mượt mà dựa trên Android 14</li>
                        </ul>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="camera" role="tabpanel">
                    <div class="p-4">
                        <h5>Hệ thống camera Hasselblad Master</h5>
                        <p>OPPO Find X7 Ultra được trang bị hệ thống camera được phát triển cùng với Hasselblad, thương hiệu camera huyền thoại từ Thụy Điển.</p>
                        
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h6>Camera chính 50MP</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><i class="fa fa-dot-circle text-primary me-2"></i>Cảm biến Sony LYT-900 1"</li>
                                    <li class="mb-2"><i class="fa fa-adjust text-primary me-2"></i>Khẩu độ f/1.8</li>
                                    <li class="mb-2"><i class="fa fa-stabilizer text-primary me-2"></i>OIS đa trục</li>
                                    <li class="mb-2"><i class="fa fa-video text-primary me-2"></i>Quay video 8K@30fps</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6>Camera zoom Periscope 50MP</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><i class="fa fa-search-plus text-success me-2"></i>Zoom quang học 6x</li>
                                    <li class="mb-2"><i class="fa fa-expand-arrows-alt text-success me-2"></i>Zoom kỹ thuật số 120x</li>
                                    <li class="mb-2"><i class="fa fa-cog text-success me-2"></i>Cảm biến Sony IMX858</li>
                                    <li class="mb-2"><i class="fa fa-eye text-success me-2"></i>OIS + EIS</li>
                                </ul>
                            </div>
                        </div>
                        
                        <h6 class="mt-4">Tính năng Hasselblad</h6>
                        <ul>
                            <li><strong>Natural Color Calibration:</strong> Màu sắc tự nhiên như mắt thường</li>
                            <li><strong>Master Style:</strong> Các phong cách nhiếp ảnh chuyên nghiệp</li>
                            <li><strong>XPan Mode:</strong> Chế độ chụp ảnh điện ảnh 65:24</li>
                            <li><strong>Portrait Mode:</strong> Chụp chân dung với độ sâu trường ảnh chuyên nghiệp</li>
                        </ul>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="specifications" role="tabpanel">
                    <div class="p-4">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Hiệu năng & Màn hình</h6>
                                <table class="table table-sm">
                                    <tr><td>Chip</td><td>Snapdragon 8 Gen 3</td></tr>
                                    <tr><td>RAM</td><td>16GB LPDDR5X</td></tr>
                                    <tr><td>Màn hình</td><td>6.82" LTPO AMOLED</td></tr>
                                    <tr><td>Độ phân giải</td><td>3168 x 1440 pixels</td></tr>
                                    <tr><td>Tần số quét</td><td>1-120Hz thích ứng</td></tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <h6>Pin & Kết nối</h6>
                                <table class="table table-sm">
                                    <tr><td>Pin</td><td>5400mAh</td></tr>
                                    <tr><td>Sạc có dây</td><td>100W SuperVOOC</td></tr>
                                    <tr><td>Sạc không dây</td><td>50W AirVOOC</td></tr>
                                    <tr><td>5G</td><td>SA/NSA dual mode</td></tr>
                                    <tr><td>Wi-Fi</td><td>Wi-Fi 7</td></tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="reviews" role="tabpanel">
                    <div class="p-4">
                        <div class="review-summary mb-4">
                            <div class="d-flex align-items-center">
                                <div class="me-4">
                                    <h3 class="mb-0">4.7</h3>
                                    <div class="text-warning">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star-half-alt"></i>
                                    </div>
                                    <small class="text-muted">892 đánh giá</small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <h6 class="mb-1">Photography Pro</h6>
                                <small class="text-muted">1 tuần trước</small>
                            </div>
                            <div class="text-warning mb-2">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <p class="mb-0">Camera Hasselblad thật sự xuất sắc! Chất lượng ảnh zoom 6x rất ấn tượng. Màu sắc tự nhiên, chi tiết sắc nét.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .main-image-container {
        border: 1px solid #ddd;
        padding: 1rem;
        border-radius: 0.5rem;
        background: #f8f9fa;
    }
    
    #mainProductImage {
        width: 100%;
        height: auto;
        max-height: 500px;
        object-fit: contain;
    }
    
    .thumbnail-image {
        width: 80px;
        height: 80px;
        object-fit: contain;
        cursor: pointer;
        transition: all 0.3s ease;
        background: #f8f9fa;
        padding: 5px;
    }
    
    .thumbnail-image:hover {
        border-color: #007bff !important;
        transform: scale(1.05);
    }
    
    .price-section {
        border-left: 5px solid var(--bs-danger);
    }
    
    .feature-item {
        transition: all 0.3s ease;
        height: 100%;
    }
    
    .feature-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    
    .color-option {
        border: 2px solid #ddd;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .color-option:hover {
        transform: scale(1.1);
    }
    
    .color-option.active {
        border-color: #007bff !important;
        box-shadow: 0 0 10px rgba(0,123,255,0.3);
    }
    
    .storage-option.active {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
    }
    
    .oppo-benefits {
        border-left: 4px solid #1ba784;
    }
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    let currentPrice = 26990000;
    let selectedColor = 'Ocean Blue';
    let selectedStorage = '256GB';

    window.updatePrice = function() {
        document.getElementById('currentPrice').textContent = currentPrice.toLocaleString('vi-VN') + '₫';
    }

    window.changeMainImage = function(src) {
        document.getElementById('mainProductImage').src = src;
    }

    window.selectColor = function(element) {
        document.querySelectorAll('.color-option').forEach(option => {
            option.classList.remove('active');
            option.style.borderColor = '#ddd';
        });
        
        element.classList.add('active');
        element.style.borderColor = '#007bff';
        
        selectedColor = element.dataset.color;
        document.getElementById('selectedColor').textContent = selectedColor;
    }

    window.selectStorage = function(element) {
        document.querySelectorAll('.storage-option').forEach(option => {
            option.classList.remove('active');
        });
        
        element.classList.add('active');
        
        selectedStorage = element.dataset.storage;
        currentPrice = parseInt(element.dataset.price);
        
        document.getElementById('selectedStorage').textContent = selectedStorage;
        updatePrice();
    }

    document.getElementById('addToCartBtn').addEventListener('click', function() {
        const quantity = document.getElementById('quantity').value;
        const button = this;
        const originalText = button.innerHTML;
        
        button.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Đang thêm...';
        button.disabled = true;
        
        setTimeout(() => {
            button.innerHTML = '<i class="fa fa-check"></i> Đã thêm!';
            button.classList.replace('btn-primary', 'btn-success');
            
            setTimeout(() => {
                button.innerHTML = originalText;
                button.classList.replace('btn-success', 'btn-primary');
                button.disabled = false;
            }, 2000);
        }, 1000);
        
        showNotification(`Đã thêm ${quantity} OPPO Find X7 Ultra ${selectedStorage} màu ${selectedColor} vào giỏ hàng!`);
    });

    document.getElementById('buyNowBtn').addEventListener('click', function() {
        const quantity = document.getElementById('quantity').value;
        const total = (currentPrice * quantity).toLocaleString('vi-VN');
        alert(`Mua ngay ${quantity} OPPO Find X7 Ultra ${selectedStorage} màu ${selectedColor}\nTổng tiền: ${total}₫`);
    });

    window.showNotification = function(message) {
        const notification = document.createElement('div');
        notification.className = 'alert alert-success position-fixed top-0 end-0 m-3';
        notification.style.zIndex = '9999';
        notification.style.minWidth = '300px';
        notification.innerHTML = 
            '<div class="d-flex align-items-center">' +
                '<i class="fa fa-check-circle me-2"></i>' +
                '<span>' + message + '</span>' +
                '<button type="button" class="btn-close ms-auto" onclick="this.parentElement.parentElement.remove()"></button>' +
            '</div>';
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            if (notification.parentElement) {
                notification.remove();
            }
        }, 4000);
    }

    // NEW QUANTITY CONTROLS SCRIPT
    const quantityInput = document.getElementById('quantity');
    const decreaseBtn = document.getElementById('decreaseQuantityBtn');
    const increaseBtn = document.getElementById('increaseQuantityBtn');

    if (quantityInput && decreaseBtn && increaseBtn) {
        function updateQuantityControls() {
            const currentValue = parseInt(quantityInput.value);
            const min = parseInt(quantityInput.min);
            const max = parseInt(quantityInput.max);

            decreaseBtn.disabled = currentValue <= min;
            increaseBtn.disabled = currentValue >= max;
        }

        decreaseBtn.addEventListener('click', function() {
            let currentValue = parseInt(quantityInput.value);
            if (currentValue > parseInt(quantityInput.min)) {
                quantityInput.value = currentValue - 1;
                updateQuantityControls();
            }
        });

        increaseBtn.addEventListener('click', function() {
            let currentValue = parseInt(quantityInput.value);
            if (currentValue < parseInt(quantityInput.max)) {
                quantityInput.value = currentValue + 1;
                updateQuantityControls();
            }
        });

        quantityInput.addEventListener('input', function() {
            let currentValue = parseInt(quantityInput.value);
            const min = parseInt(quantityInput.min);
            const max = parseInt(quantityInput.max);

            if (isNaN(currentValue) || currentValue < min) {
                quantityInput.value = min;
            } else if (currentValue > max) {
                quantityInput.value = max;
            }
            updateQuantityControls();
        });

        // Initial state update
        updateQuantityControls();
    }
});
</script>
</body>