<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Tủ Lạnh Samsung Inverter - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item"><a href="#">Gia dụng</a></li>
            <li class="breadcrumb-item active">Tủ Lạnh Samsung Inverter</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/tu_lanh_samsung.jpg"
                             id="mainProductImage"
                             alt="Tủ Lạnh Samsung Inverter"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">Tủ Lạnh Samsung Inverter 360L</h1>
                    
                    <!-- Rating Section -->
                    <div class="rating-section">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">4.6/5 (234 đánh giá)</span>
                        <span class="sold-count">Đã bán: 1,567</span>
                    </div>

                    <!-- Price Section -->
                    <div class="price-section">
                        <div class="discount-badge">-18%</div>
                        <h2 class="current-price">16.990.000₫</h2>
                        <span class="original-price">20.690.000₫</span>
                    </div>

                    <!-- Capacity Selection -->
                    <div class="variant-section">
                        <div class="variant-title">
                            <i class="fas fa-cube"></i>
                            Dung tích
                        </div>
                        <div class="variant-options">
                            <div class="variant-option" data-variant="280L">280L</div>
                            <div class="variant-option active" data-variant="360L">360L</div>
                            <div class="variant-option" data-variant="458L">458L</div>
                        </div>
                        <div class="selected-variant">Đã chọn: <strong>360L</strong></div>
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
                                    <i class="fas fa-bolt mb-2"></i><br>
                                    <strong>Digital Inverter</strong><br>
                                    <small>Tiết kiệm điện 40%</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-snowflake mb-2"></i><br>
                                    <strong>Twin Cooling Plus</strong><br>
                                    <small>Làm lạnh độc lập</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-shield-virus mb-2"></i><br>
                                    <strong>Kháng khuẩn</strong><br>
                                    <small>Công nghệ Ag Clean</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="variant-option text-center">
                                    <i class="fas fa-mobile-alt mb-2"></i><br>
                                    <strong>SmartThings</strong><br>
                                    <small>Điều khiển thông minh</small>
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
                        <p>Tủ lạnh Samsung Digital Inverter với công nghệ Twin Cooling Plus, thiết kế hiện đại và nhiều tính năng thông minh. Tiết kiệm điện năng và bảo quản thực phẩm tối ưu.</p>
                        <ul>
                            <li>Công nghệ Digital Inverter tiết kiệm điện</li>
                            <li>Twin Cooling Plus làm lạnh độc lập</li>
                            <li>Kháng khuẩn Ag Clean bảo vệ sức khỏe</li>
                            <li>Ngăn rau quả Fresh Zone</li>
                            <li>Kết nối SmartThings IoT</li>
                            <li>Bảo hành 2 năm, máy nén 10 năm</li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số kỹ thuật</h5>
                        <table class="table">
                            <tr><td><strong>Dung tích:</strong></td><td>360L (Ngăn lạnh: 268L, Ngăn đông: 92L)</td></tr>
                            <tr><td><strong>Kích thước:</strong></td><td>60 x 66.8 x 177.4 cm</td></tr>
                            <tr><td><strong>Công nghệ:</strong></td><td>Digital Inverter, Twin Cooling Plus</td></tr>
                            <tr><td><strong>Loại:</strong></td><td>2 cửa ngăn đông trên</td></tr>
                            <tr><td><strong>Tiêu thụ điện:</strong></td><td>291 kWh/năm</td></tr>
                            <tr><td><strong>Cấp năng lượng:</strong></td><td>4 sao</td></tr>
                            <tr><td><strong>Xuất xứ:</strong></td><td>Thái Lan</td></tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <div class="mb-3">
                            <strong>4.6/5</strong> dựa trên 234 đánh giá
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Nguyễn Thị Lan</strong>
                                <div class="text-warning">★★★★★</div>
                            </div>
                            <p class="mb-1">Tủ lạnh Samsung chất lượng tốt, làm lạnh nhanh và tiết kiệm điện.</p>
                            <small class="text-muted">5 ngày trước</small>
                        </div>
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <strong>Trần Văn Nam</strong>
                                <div class="text-warning">★★★★☆</div>
                            </div>
                            <p class="mb-1">Thiết kế đẹp, dung tích lớn phù hợp gia đình 4-5 người.</p>
                            <small class="text-muted">1 tuần trước</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    // ...existing code...
    
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