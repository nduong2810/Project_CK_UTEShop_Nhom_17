<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>Túi Xách Nữ Cao Cấp - UTESHOP</title>

<div class="container my-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
            <li class="breadcrumb-item active">Túi Xách Nữ Cao Cấp</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Product Image Gallery -->
        <div class="col-lg-6 mb-4">
            <div class="main-image-container mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/tui.jpg"
                     id="mainProductImage" class="img-fluid rounded shadow-sm"
                     alt="Túi Xách Nữ Cao Cấp"
                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
            </div>
            
            <!-- Thumbnail Images -->
            <div class="thumbnail-container d-flex gap-2">
                <img src="${pageContext.request.contextPath}/assets/img/tui.jpg" 
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
            <h1 class="display-6 fw-bold">Túi Xách Nữ Cao Cấp Premium</h1>
            
            <div class="d-flex align-items-center mb-3">
                <div class="rating text-warning me-3">
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star"></i>
                    <i class="fa fa-star-half-alt"></i>
                    <span class="text-muted ms-1">(4.6 | Đã bán: 3,567)</span>
                </div>
            </div>

            <div class="price-section bg-light p-3 rounded mb-4">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="h2 text-danger fw-bolder" id="currentPrice">1.290.000₫</span>
                    <span class="text-muted text-decoration-line-through">1.690.000₫</span>
                </div>
                <small class="text-success">Tiết kiệm: 400.000₫ (24%)</small>
            </div>

            <!-- Product Description -->
            <div class="product-description mb-4">
                <p class="text-muted">Túi xách nữ cao cấp làm từ da PU chất lượng cao, thiết kế thanh lịch và sang trọng. Phù hợp cho công sở, dạo phố hay các buổi hẹn quan trọng.</p>
            </div>

            <!-- Material Features -->
            <div class="material-features mb-4">
                <h5 class="fw-bold mb-3">Đặc điểm nổi bật:</h5>
                <div class="row g-3">
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-gem fa-2x text-primary mb-2"></i>
                            <h6 class="fw-bold">Da PU cao cấp</h6>
                            <small>Mềm mại, bền đẹp</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-water fa-2x text-info mb-2"></i>
                            <h6 class="fw-bold">Chống nước</h6>
                            <small>Bảo vệ đồ dùng</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-archive fa-2x text-success mb-2"></i>
                            <h6 class="fw-bold">Đa ngăn</h6>
                            <small>Tổ chức gọn gàng</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="feature-item p-3 bg-light rounded text-center">
                            <i class="fa fa-hand-holding fa-2x text-warning mb-2"></i>
                            <h6 class="fw-bold">2 cách mang</h6>
                            <small>Xách tay + đeo vai</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Color Options -->
            <div class="color-options mb-4">
                <h5 class="fw-bold mb-3">Chọn màu sắc:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="color-option active" data-color="Đen" data-price="0" 
                            style="background: #2c3e50; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #007bff;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Nâu" data-price="0"
                            style="background: #8b4513; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Kem" data-price="0"
                            style="background: #f5f5dc; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Hồng" data-price="0"
                            style="background: #ffc0cb; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                    <button class="color-option" data-color="Xanh Navy" data-price="0"
                            style="background: #000080; width: 40px; height: 40px; border-radius: 50%; border: 2px solid #ddd;"
                            onclick="selectColor(this)"></button>
                </div>
                <p class="mt-2 mb-0"><strong>Màu đã chọn:</strong> <span id="selectedColor">Đen</span></p>
            </div>

            <!-- Size Options -->
            <div class="size-options mb-4">
                <h5 class="fw-bold mb-3">Chọn kích cỡ:</h5>
                <div class="d-flex gap-2 flex-wrap">
                    <button class="btn btn-outline-primary size-option" data-size="Small" data-price="1190000" onclick="selectSize(this)">Small (25cm)</button>
                    <button class="btn btn-outline-primary size-option active" data-size="Medium" data-price="1290000" onclick="selectSize(this)">Medium (30cm)</button>
                    <button class="btn btn-outline-primary size-option" data-size="Large" data-price="1490000" onclick="selectSize(this)">Large (35cm)</button>
                </div>
                <p class="mt-2 mb-0"><strong>Kích cỡ:</strong> <span id="selectedSize">Medium (30cm)</span></p>
            </div>

            <!-- Specifications -->
            <div class="specifications mb-4">
                <h5 class="fw-bold mb-3">Thông tin chi tiết:</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fa fa-tag text-primary me-2"></i><strong>Thương hiệu:</strong> UTESHOP Fashion</li>
                    <li class="mb-2"><i class="fa fa-cube text-primary me-2"></i><strong>Chất liệu:</strong> Da PU cao cấp + Canvas lót trong</li>
                    <li class="mb-2"><i class="fa fa-ruler text-primary me-2"></i><strong>Kích thước:</strong> 30 x 25 x 12 cm (D x R x S)</li>
                    <li class="mb-2"><i class="fa fa-weight text-primary me-2"></i><strong>Trọng lượng:</strong> 650g</li>
                    <li class="mb-2"><i class="fa fa-archive text-primary me-2"></i><strong>Ngăn chứa:</strong> 1 ngăn chính + 2 ngăn phụ + 1 ngăn khóa kéo</li>
                    <li class="mb-2"><i class="fa fa-hand-paper text-primary me-2"></i><strong>Quai xách:</strong> Quai da + dây đeo vai có thể tháo rời</li>
                </ul>
            </div>

            <!-- What's Included -->
            <div class="included-items mb-4">
                <h5 class="fw-bold mb-3">Phụ kiện đi kèm:</h5>
                <div class="row">
                    <div class="col-12">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex align-items-center">
                                <i class="fa fa-check-circle text-success me-3"></i>
                                <div>
                                    <strong>Túi xách chính</strong>
                                    <br><small class="text-muted">Thiết kế cao cấp với logo thương hiệu</small>
                                </div>
                            </li>
                            <li class="list-group-item d-flex align-items-center">
                                <i class="fa fa-check-circle text-success me-3"></i>
                                <div>
                                    <strong>Dây đeo vai</strong>
                                    <br><small class="text-muted">Có thể điều chỉnh độ dài 75-130cm</small>
                                </div>
                            </li>
                            <li class="list-group-item d-flex align-items-center">
                                <i class="fa fa-check-circle text-success me-3"></i>
                                <div>
                                    <strong>Túi vải bảo quản</strong>
                                    <br><small class="text-muted">Chống bụi khi không sử dụng</small>
                                </div>
                            </li>
                            <li class="list-group-item d-flex align-items-center">
                                <i class="fa fa-check-circle text-success me-3"></i>
                                <div>
                                    <strong>Thẻ bảo hành</strong>
                                    <br><small class="text-muted">Bảo hành 12 tháng lỗi sản xuất</small>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <hr>

            <!-- Quantity and Action Buttons -->
            <div class="d-flex align-items-center mb-4">
                <label for="quantity" class="form-label me-3 mb-0">Số lượng:</label>
                <div class="input-group" style="width: 130px;">
                    <button class="btn btn-outline-secondary" type="button" id="button-minus">-</button>
                    <input type="text" id="quantity" class="form-control text-center" value="1" min="1" max="10">
                    <button class="btn btn-outline-secondary" type="button" id="button-plus">+</button>
                </div>
            </div>

            <div class="d-grid gap-2 d-sm-flex">
                <button class="btn btn-primary btn-lg flex-grow-1" type="button" id="addToCartBtn">
                    <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>
                <button class="btn btn-warning btn-lg flex-grow-1" type="button" id="buyNowBtn">
                    <i class="fa fa-bolt"></i> Mua ngay
                </button>
            </div>

            <!-- Fashion Benefits -->
            <div class="fashion-benefits mt-4 p-3 bg-light rounded">
                <h6 class="fw-bold mb-2">Ưu đãi thời trang:</h6>
                <ul class="list-unstyled mb-0 small">
                    <li class="mb-1"><i class="fa fa-gift text-warning me-2"></i>Tặng charm trang trí túi cao cấp</li>
                    <li class="mb-1"><i class="fa fa-shield-alt text-success me-2"></i>Bảo hành 12 tháng lỗi sản xuất</li>
                    <li class="mb-1"><i class="fa fa-sync text-info me-2"></i>Đổi trả trong 30 ngày</li>
                    <li class="mb-1"><i class="fa fa-truck text-primary me-2"></i>Miễn phí vận chuyển toàn quốc</li>
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
                    <button class="nav-link" id="care-tab" data-bs-toggle="tab" data-bs-target="#care" type="button">Hướng dẫn bảo quản</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="size-tab" data-bs-toggle="tab" data-bs-target="#size" type="button">Bảng kích thước</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button">Đánh giá</button>
                </li>
            </ul>
            
            <div class="tab-content" id="productTabContent">
                <div class="tab-pane fade show active" id="description" role="tabpanel">
                    <div class="p-4">
                        <h5>Túi Xách Nữ Cao Cấp - Phong cách và đẳng cấp</h5>
                        <p>Túi xách nữ cao cấp được thiết kế dành riêng cho phụ nữ hiện đại, năng động. Sản phẩm kết hợp hoàn hảo giữa tính thẩm mỹ và tính tiện dụng, phù hợp với mọi phong cách từ công sở đến dạo phố.</p>
                        
                        <h6 class="mt-4">Điểm nổi bật:</h6>
                        <ul>
                            <li><strong>Chất liệu cao cấp:</strong> Da PU mềm mại, bền đẹp theo thời gian</li>
                            <li><strong>Thiết kế thông minh:</strong> Đa ngăn, tổ chức đồ dùng gọn gàng</li>
                            <li><strong>Đa năng:</strong> 2 cách mang linh hoạt (xách tay và đeo vai)</li>
                            <li><strong>Chống nước:</strong> Bảo vệ đồ dùng khỏi thời tiết xấu</li>
                            <li><strong>Màu sắc đa dạng:</strong> 5 màu phù hợp mọi phong cách</li>
                            <li><strong>Kích thước đa dạng:</strong> 3 size để lựa chọn</li>
                        </ul>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="care" role="tabpanel">
                    <div class="p-4">
                        <h5>Hướng dẫn bảo quản túi xách</h5>
                        <p>Để giữ túi xách luôn đẹp và bền, vui lòng tuân thủ các hướng dẫn sau:</p>
                        
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h6>Vệ sinh hàng ngày</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><i class="fa fa-hand-sparkles text-primary me-2"></i>Lau bằng khăn mềm, khô</li>
                                    <li class="mb-2"><i class="fa fa-tint text-info me-2"></i>Dùng khăn ẩm nhẹ nếu cần</li>
                                    <li class="mb-2"><i class="fa fa-ban text-danger me-2"></i>Tránh dung dịch tẩy rửa mạnh</li>
                                    <li class="mb-2"><i class="fa fa-sun text-warning me-2"></i>Không phơi trực tiếp dưới nắng</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6>Bảo quản lâu dài</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><i class="fa fa-archive text-success me-2"></i>Bảo quản trong túi vải đi kèm</li>
                                    <li class="mb-2"><i class="fa fa-newspaper text-info me-2"></i>Nhồi giấy để giữ form dáng</li>
                                    <li class="mb-2"><i class="fa fa-thermometer-half text-warning me-2"></i>Tránh nơi ẩm ướt, nhiệt độ cao</li>
                                    <li class="mb-2"><i class="fa fa-eye text-primary me-2"></i>Kiểm tra định kỳ 1 tháng/lần</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="size" role="tabpanel">
                    <div class="p-4">
                        <h5>Bảng kích thước chi tiết</h5>
                        <div class="table-responsive">
                            <table class="table table-bordered text-center">
                                <thead class="table-light">
                                    <tr>
                                        <th>Size</th>
                                        <th>Dài (cm)</th>
                                        <th>Rộng (cm)</th>
                                        <th>Sâu (cm)</th>
                                        <th>Dây đeo vai (cm)</th>
                                        <th>Phù hợp</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="fw-bold">Small</td>
                                        <td>25</td>
                                        <td>20</td>
                                        <td>10</td>
                                        <td>75-125</td>
                                        <td>Dạo phố, hẹn hò</td>
                                    </tr>
                                    <tr>
                                        <td class="fw-bold">Medium</td>
                                        <td>30</td>
                                        <td>25</td>
                                        <td>12</td>
                                        <td>75-130</td>
                                        <td>Công sở, đi học</td>
                                    </tr>
                                    <tr>
                                        <td class="fw-bold">Large</td>
                                        <td>35</td>
                                        <td>28</td>
                                        <td>15</td>
                                        <td>80-135</td>
                                        <td>Du lịch, mua sắm</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p class="text-muted mt-3">
                            <i class="fa fa-info-circle me-1"></i>
                            Các số đo có thể chênh lệch ±1cm. Size Medium là lựa chọn phổ biến nhất.
                        </p>
                    </div>
                </div>
                
                <div class="tab-pane fade" id="reviews" role="tabpanel">
                    <div class="p-4">
                        <div class="review-summary mb-4">
                            <div class="d-flex align-items-center">
                                <div class="me-4">
                                    <h3 class="mb-0">4.6</h3>
                                    <div class="text-warning">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star-half-alt"></i>
                                    </div>
                                    <small class="text-muted">2,134 đánh giá</small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="review-item border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between">
                                <h6 class="mb-1">Fashion Girl</h6>
                                <small class="text-muted">1 tuần trước</small>
                            </div>
                            <div class="text-warning mb-2">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <p class="mb-1">Túi đẹp, chất liệu da mềm mại. Size Medium vừa đủ đựng đồ đi làm. Dây đeo vai rất tiện.</p>
                            <small class="text-muted">Size: Medium | Màu: Đen</small>
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
    
    .size-option.active {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
    }
    
    .fashion-benefits {
        border-left: 4px solid #e83e8c;
    }
    
    .list-group-item {
        border: none;
        padding: 0.75rem 0;
    }
</style>

<script>
let currentPrice = 1290000;
let selectedColor = 'Đen';
let selectedSize = 'Medium';

function updatePrice() {
    document.getElementById('currentPrice').textContent = currentPrice.toLocaleString('vi-VN') + '₫';
}

function changeMainImage(src) {
    document.getElementById('mainProductImage').src = src;
}

function selectColor(element) {
    document.querySelectorAll('.color-option').forEach(option => {
        option.classList.remove('active');
        option.style.borderColor = '#ddd';
    });
    
    element.classList.add('active');
    element.style.borderColor = '#007bff';
    
    selectedColor = element.dataset.color;
    document.getElementById('selectedColor').textContent = selectedColor;
}

function selectSize(element) {
    document.querySelectorAll('.size-option').forEach(option => {
        option.classList.remove('active');
    });
    
    element.classList.add('active');
    
    selectedSize = element.dataset.size;
    currentPrice = parseInt(element.dataset.price);
    
    document.getElementById('selectedSize').textContent = selectedSize;
    updatePrice();
}

// Quantity controls
document.getElementById('button-minus').addEventListener('click', function() {
    const quantityInput = document.getElementById('quantity');
    let currentValue = parseInt(quantityInput.value);
    if (currentValue > 1) {
        quantityInput.value = currentValue - 1;
    }
});

document.getElementById('button-plus').addEventListener('click', function() {
    const quantityInput = document.getElementById('quantity');
    let currentValue = parseInt(quantityInput.value);
    if (currentValue < 10) {
        quantityInput.value = currentValue + 1;
    }
});

// Add to cart functionality
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
    
    showNotification(`Đã thêm ${quantity} túi xách ${selectedSize} màu ${selectedColor} vào giỏ hàng!`);
});

// Buy now functionality
document.getElementById('buyNowBtn').addEventListener('click', function() {
    const quantity = document.getElementById('quantity').value;
    const total = (currentPrice * quantity).toLocaleString('vi-VN');
    alert(`Mua ngay ${quantity} túi xách ${selectedSize} màu ${selectedColor}\nTổng tiền: ${total}₫`);
});

function showNotification(message) {
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
</script>