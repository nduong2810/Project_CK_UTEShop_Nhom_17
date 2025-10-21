<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Sạc Dự Phòng 20000mAh - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>

<body>
<div class="container my-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Sạc Dự Phòng 20000mAh</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Product Image Gallery -->
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/sac.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Sạc Dự Phòng 20000mAh"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
            
            <!-- Thumbnail Images -->
            <div class="thumbnail-container d-flex gap-2">
                <img src="${pageContext.request.contextPath}/assets/img/sac.jpg" 
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
            <h1 class="display-6 fw-bold">Sạc Dự Phòng 20000mAh Fast Charge</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <span class="text-muted ms-1">(4.8 | Đã bán: 12,456)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="h2 text-danger fw-bolder" id="currentPrice">599.000₫</span>
                    <span class="text-muted text-decoration-line-through">799.000₫</span>
                </div>
                <small class="text-success">Tiết kiệm: 200.000₫ (25%)</small>
            </div>

            <!-- Product Description -->
            <div class="product-description mb-4">
                <p class="text-muted">Sạc dự phòng 20000mAh với công nghệ sạc nhanh 22.5W, hỗ trợ đa cổng sạc đồng thời. Thiết kế nhỏ gọn, màn hình LED hiển thị dung lượng pin chính xác.</p>
            </div>

            <!-- Power Features -->
            <div class="power-features mb-4">
                <h5 class="fw-bold mb-3">Tính năng sạc nhanh:</h5>
                <div class="row g-3">
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-bolt fa-2x text-warning mb-2"></i>
                            <h6 class="fw-bold">22.5W</h6>
                            <small>Sạc nhanh siêu tốc</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-battery-full fa-2x text-success mb-2"></i>
                            <h6 class="fw-bold">20000mAh</h6>
                            <small>Dung lượng lớn</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-mobile-alt fa-2x text-info mb-2"></i>
                            <h6 class="fw-bold">4 Thiết bị</h6>
                            <small>Sạc đồng thời</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-tv fa-2x text-primary mb-2"></i>
                            <h6 class="fw-bold">LED Display</h6>
                            <small>Hiển thị % pin</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Color Options -->
            <div class="color-options mb-4">
                <h5 class="fw-bold mb-3">Chọn màu sắc:</h5>
                <div class="d-flex gap-2">
                    <button class="color-option active" data-color="Đen" data-price="0" 
                            style="background: #2c3e50; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #007bff;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Trắng" data-price="0"
                            style="background: #ecf0f1; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Xanh Navy" data-price="0"
                            style="background: #34495e; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                </div>
                <p class="mt-2 mb-0"><strong>Màu đã chọn:</strong> <span id="selectedColor">Đen</span></p>
            </div>

            <!-- Capacity Options -->
            <div class="capacity-options mb-4">
                <h5 class="fw-bold mb-3">Chọn dung lượng:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-outline-primary capacity-option" data-capacity="10000mAh" data-price="399000" onclick="selectCapacity(this)">10000mAh</button>
                    <button class="btn btn-outline-primary capacity-option active" data-capacity="20000mAh" data-price="599000" onclick="selectCapacity(this)">20000mAh</button>
                    <button class="btn btn-outline-primary capacity-option" data-capacity="30000mAh" data-price="899000" onclick="selectCapacity(this)">30000mAh</button>
                </div>
                <p class="mt-2 mb-0"><strong>Dung lượng:</strong> <span id="selectedCapacity">20000mAh</span></p>
            </div>

            <!-- Specifications -->
            <div class="specifications mb-4">
                <h5 class="fw-bold mb-3">Thông số kỹ thuật:</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fa fa-battery-three-quarters text-primary me-2"></i><strong>Dung lượng:</strong> 20000mAh / 74Wh</li>
                    <li class="mb-2"><i class="fa fa-bolt text-primary me-2"></i><strong>Công suất:</strong> 22.5W Max</li>
                    <li class="mb-2"><i class="fa fa-plug text-primary me-2"></i><strong>Cổng sạc:</strong> 2x USB-A, 1x USB-C, 1x Micro USB</li>
                    <li class="mb-2"><i class="fa fa-sync text-primary me-2"></i><strong>Sạc lại:</strong> USB-C 18W hoặc Micro USB 12W</li>
                    <li class="mb-2"><i class="fa fa-shield-alt text-primary me-2"></i><strong>Bảo vệ:</strong> 9 lớp an toàn</li>
                    <li class="mb-2"><i class="fa fa-weight text-primary me-2"></i><strong>Trọng lượng:</strong> 450g</li>
                </ul>
            </div>

            <!-- Compatibility -->
            <div class="compatibility mb-4">
                <h5 class="fw-bold mb-3">Tương thích với:</h5>
                <div class="row">
                    <div class="col-6">
                        <ul class="list-unstyled">
                            <li><i class="fa fa-mobile text-primary me-2"></i>iPhone tất cả dòng</li>
                            <li><i class="fa fa-android text-success me-2"></i>Android smartphones</li>
                            <li><i class="fa fa-tablet text-info me-2"></i>iPad & Android tablets</li>
                        </ul>
                    </div>
                    <div class="col-6">
                        <ul class="list-unstyled">
                            <li><i class="fa fa-headphones text-warning me-2"></i>AirPods & earbuds</li>
                            <li><i class="fa fa-camera text-primary me-2"></i>Camera hành trình</li>
                            <li><i class="fa fa-gamepad text-danger me-2"></i>Nintendo Switch</li>
                        </ul>
                    </div>
                </div>
            </div>

            <hr>

            <!-- Quantity Section -->
            <div class="quantity-section mb-4">
                <span class="quantity-label">Số lượng:</span>
                <div class="quantity-controls">
                    <button class="quantity-btn" id="decreaseQuantityBtn">-</button>
                    <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="10">
                    <button class="quantity-btn" id="increaseQuantityBtn">+</button>
                </div>
                <span class="quantity-label" style="margin-left: 1rem;">10 sản phẩm có sẵn</span>
            </div>

            <div class="d-grid gap-2 d-sm-flex">
                <button class="btn btn-primary btn-lg flex-grow-1" type="button" id="addToCartBtn">
                    <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>
                <button class="btn btn-warning btn-lg flex-grow-1" type="button" id="buyNowBtn">
                    <i class="fa fa-bolt"></i> Mua ngay
                </button>
            </div>

            <!-- Power Bank Benefits -->
            <div class="powerbank-benefits mt-4 p-3 bg-light rounded">
                <h6 class="fw-bold mb-2">Ưu đãi sạc dự phòng:</h6>
                <ul class="list-unstyled mb-0 small">
                    <li class="mb-1"><i class="fa fa-gift text-warning me-2"></i>Tặng cáp sạc 3 in 1 cao cấp</li>
                    <li class="mb-1"><i class="fa fa-shield-alt text-success me-2"></i>Bảo hành 18 tháng</li>
                    <li class="mb-1"><i class="fa fa-sync text-info me-2"></i>Đổi mới trong 7 ngày</li>
                    <li class="mb-1"><i class="fa fa-truck text-primary me-2"></i>Miễn phí vận chuyển</li>
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
                    <button class="nav-link" id="safety-tab" data-bs-toggle="tab" data-bs-target="#safety" type="button">An toàn & Bảo vệ</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="usage-tab" data-bs-toggle="tab" data-bs-target="#usage" type="button">Hướng dẫn sử dụng</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button">Đánh giá</button>
                </li>
            </ul>
            
            <div class="tab-content" id="productTabContent">
                <div class="tab-pane fade show active" id="description" role="tabpanel">
                    <div class="p-4">
                        <h5>Sạc Dự Phòng 20000mAh - Giải pháp di động hoàn hảo</h5>
                        <p>Sạc dự phòng 20000mAh với công nghệ sạc nhanh 22.5W giúp bạn luôn kết nối mọi lúc mọi nơi. Thiết kế thông minh với màn hình LED hiển thị chính xác phần trăm pin còn lại.</p>
                        
                        <h6 class="mt-4">Ưu điểm vượt trội:</h6>
                        <ul>
                            <li><strong>Dung lượng lớn:</strong> 20000mAh sạc được iPhone 13 đến 4-5 lần</li>
                            <li><strong>Sạc nhanh 22.5W:</strong> Sạc iPhone từ 0-50% chỉ trong 30 phút</li>
                            <li><strong>4 cổng sạc:</strong> Sạc đồng thời 4 thiết bị cùng lúc</li>
                            <li><strong>Màn hình LED:</strong> Hiển thị chính xác % pin còn lại</li>
                            <li><strong>9 lớp bảo vệ:</strong> An toàn tuyệt đối cho thiết bị</li>
                            <li><strong>Thiết kế nhỏ gọn:</strong> Dễ dàng mang theo hàng ngày</li>
                        </ul>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="safety" role="tabpanel">
                    <div class="p-4">
                        <h5>Hệ thống bảo vệ 9 lớp an toàn</h5>
                        <p>Sạc dự phòng được trang bị hệ thống bảo vệ tiên tiến với 9 lớp an toàn để đảm bảo thiết bị của bạn luôn được bảo vệ tối đa.</p>
                        
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h6>Bảo vệ điện áp</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><i class="fa fa-shield-alt text-success me-2"></i>Bảo vệ quá áp</li>
                                    <li class="mb-2"><i class="fa fa-shield-alt text-info me-2"></i>Bảo vệ thiếu áp</li>
                                    <li class="mb-2"><i class="fa fa-shield-alt text-warning me-2"></i>Bảo vệ quá dòng</li>
                                    <li class="mb-2"><i class="fa fa-shield-alt text-primary me-2"></i>Bảo vệ ngắn mạch</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6>Bảo vệ nhiệt độ</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><i class="fa fa-thermometer-half text-danger me-2"></i>Bảo vệ quá nhiệt</li>
                                    <li class="mb-2"><i class="fa fa-thermometer-quarter text-info me-2"></i>Bảo vệ nhiệt độ thấp</li>
                                    <li class="mb-2"><i class="fa fa-battery-quarter text-warning me-2"></i>Bảo vệ quá xả</li>
                                    <li class="mb-2"><i class="fa fa-battery-full text-success me-2"></i>Bảo vệ quá sạc</li>
                                </ul>
                            </div>
                        </div>
                        
                        <div class="mt-4 p-3 bg-light rounded">
                            <h6>Chứng nhận an toàn</h6>
                            <p class="mb-0">
                                <span class="badge bg-primary me-2">CE</span>
                                <span class="badge bg-success me-2">FCC</span>
                                <span class="badge bg-warning me-2">RoHS</span>
                                <span class="badge bg-info me-2">UN38.3</span>
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="usage" role="tabpanel">
                    <div class="p-4">
                        <h5>Hướng dẫn sử dụng</h5>
                        
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h6>Cách sạc thiết bị</h6>
                                <ol>
                                    <li>Kết nối cáp sạc với thiết bị cần sạc</li>
                                    <li>Cắm đầu kia vào cổng USB-A hoặc USB-C</li>
                                    <li>Nhấn nút nguồn để bắt đầu sạc</li>
                                    <li>Màn hình LED sẽ hiển thị % pin</li>
                                </ol>
                            </div>
                            <div class="col-md-6">
                                <h6>Cách sạc lại pin dự phòng</h6>
                                <ol>
                                    <li>Sử dụng cáp USB-C hoặc Micro USB</li>
                                    <li>Kết nối với adapter 5V/2A trở lên</li>
                                    <li>LED sẽ nhấp nháy khi đang sạc</li>
                                    <li>Tất cả LED sáng khi sạc đầy</li>
                                </ol>
                            </div>
                        </div>
                        
                        <div class="mt-4 p-3 bg-warning bg-opacity-10 rounded">
                            <h6 class="text-warning"><i class="fa fa-exclamation-triangle me-2"></i>Lưu ý quan trọng</h6>
                            <ul class="mb-0">
                                <li>Tránh để pin dự phòng ở nơi có nhiệt độ quá cao</li>
                                <li>Không để pin hết hoàn toàn, sạc lại khi còn 20%</li>
                                <li>Sử dụng cáp chính hãng để đảm bảo an toàn</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="reviews" role="tabpanel">
                    <div class="p-4">
                        <div class="review-summary mb-4">
                            <div class="d-flex align-items-center">
                                <div class="me-4">
                                    <h3 class="mb-0">4.8</h3>
                                    <div class="text-warning">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <small class="text-muted">5,234 đánh giá</small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <h6 class="mb-1">Tech User</h6>
                                <small class="text-muted">3 ngày trước</small>
                            </div>
                            <div class="text-warning mb-2">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <p class="mb-0">Pin dung lượng lớn, sạc nhanh thật sự. Màn hình LED rất tiện để biết còn bao nhiêu pin. Chất lượng tốt!</p>
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
    
    .capacity-option.active {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
    }
    
    .powerbank-benefits {
        border-left: 4px solid #fd7e14;
    }
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    let currentPrice = 599000;
    let selectedColor = 'Đen';
    let selectedCapacity = '20000mAh';

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

    window.selectCapacity = function(element) {
        document.querySelectorAll('.capacity-option').forEach(option => {
            option.classList.remove('active');
        });
        
        element.classList.add('active');
        
        selectedCapacity = element.dataset.capacity;
        currentPrice = parseInt(element.dataset.price);
        
        document.getElementById('selectedCapacity').textContent = selectedCapacity;
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
        
        showNotification(`Đã thêm ${quantity} sạc dự phòng ${selectedCapacity} màu ${selectedColor} vào giỏ hàng!`);
    });

    document.getElementById('buyNowBtn').addEventListener('click', function() {
        const quantity = document.getElementById('quantity').value;
        const total = (currentPrice * quantity).toLocaleString('vi-VN');
        alert(`Mua ngay ${quantity} sạc dự phòng ${selectedCapacity} màu ${selectedColor}\nTổng tiền: ${total}₫`);
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