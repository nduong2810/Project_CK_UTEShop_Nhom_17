<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>${product.tenSP} - UTESHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
    <style>
        .rating-stars .fa-star { color: #ffc107; }
        .btn-favorite {
            background-color: #f0f2f5;
            color: #050505;
            border: 1px solid #ced4da;
        }
        .btn-favorite.active {
            background-color: #ff3f6c;
            color: white;
        }
        .review-form .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }
        .review-form .rating > input { display:none; }
        .review-form .rating > label {
            position: relative;
            width: 1em;
            font-size: 2rem;
            color: #FFD600;
            cursor: pointer;
        }
        .review-form .rating > label::before{ 
            content: "\2605";
            position: absolute;
            opacity: 0;
        }
        .review-form .rating > label:hover:before,
        .review-form .rating > label:hover ~ label:before {
            opacity: 1 !important;
        }
        .review-form .rating > input:checked ~ label:before {
            opacity:1;
        }
        .review-form .rating:hover > input:checked ~ label:before { opacity: 0.4; }

        #mainProductImage {
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        #mainProductImage.loaded {
            opacity: 1;
        }

        /* Styles for Related Products */
        .related-products-section h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            border: 1px solid #e0e0e0;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .product-image-container {
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-image {
            width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .product-card .card-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-card .card-title {
            font-size: 1rem;
            font-weight: 600;
            line-height: 1.4;
            margin-bottom: 15px;
            color: #333;
            flex-grow: 1;
        }

        .product-card .card-title a {
            color: inherit;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .product-card .card-title a:hover {
            color: #2874f0;
        }

        .product-card .price {
            font-size: 1.4rem;
            font-weight: 700;
            color: #2874f0;
        }
    </style>
</head>
<body>

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item active">${product.tenSP}</li>
        </ol>
    </nav>

    <div class="product-container">
        <div class="row g-0">
            <!-- Product Image Section -->
            <div class="col-lg-6">
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/assets/img/${product.hinhAnh}"
                             id="mainProductImage"
                             alt="${product.tenSP}"
                             onload="this.classList.add('loaded')"
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'; this.classList.add('loaded');">
                    </div>
                </div>
            </div>

            <!-- Product Info Section -->
            <div class="col-lg-6">
                <div class="product-info-section">
                    <h1 class="product-title">${product.tenSP}</h1>
                    
                    <div class="rating-section">
                        <div class="rating-stars">
                            <c:forEach begin="1" end="5" varStatus="loop">
                                <i class="${loop.index <= product.diemDanhGiaTrungBinh ? 'fas' : 'far'} fa-star"></i>
                            </c:forEach>
                        </div>
                        <span class="rating-text"><fmt:formatNumber value="${product.diemDanhGiaTrungBinh}" maxFractionDigits="1"/>/5 (${product.soLuongDanhGia} đánh giá)</span>
                        <span class="sold-count">Đã bán: ${product.soLuongBan}</span>
                    </div>

                    <div class="price-section">
                        <h2 class="current-price"><fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></h2>
                    </div>

                    <div class="quantity-section">
                        <span class="quantity-label">Số lượng:</span>
                        <div class="quantity-controls">
                            <button class="quantity-btn" id="decreaseQuantityBtn">-</button>
                            <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="${product.soLuongTon}">
                            <button class="quantity-btn" id="increaseQuantityBtn">+</button>
                        </div>
                         <span class="quantity-label">${product.soLuongTon} sản phẩm có sẵn</span>
                    </div>

                    <div class="action-buttons">
                        <button class="btn-add-cart" onclick="handleAddToCart(${product.maSP}, ${empty sessionScope.user})">
                            <i class="fas fa-shopping-cart me-2"></i>
                            Thêm vào giỏ hàng
                        </button>
                        <button class="btn-buy-now" onclick="handleBuyNow(${product.maSP}, ${empty sessionScope.user})">
                            <i class="fas fa-bolt me-2"></i>
                            Mua ngay
                        </button>
                        <button class="btn btn-favorite" onclick="handleAddToFavorites(event, this, ${product.maSP}, ${empty sessionScope.user})">
                            <i class="far fa-heart me-2"></i>
                            Yêu thích
                        </button>
                    </div>
                </div>
            </div>
        </div>

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
                        <p>${product.moTa}</p>
                    </div>
                </div>
                <div class="tab-pane fade" id="specifications">
                    <div class="p-4">
                        <h5>Thông số sản phẩm</h5>
                        <table class="table">
                            <tr><td><strong>Giá:</strong></td><td><fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></td></tr>
                            <tr>
                                <td><strong>Tình trạng:</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.soLuongTon > 0}">
                                            <span class="text-success">Còn hàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><td><strong>Đã bán:</strong></td><td>${product.soLuongBan}</td></tr>
                            <tr>
                                <td><strong>Danh mục:</strong></td>
                                <td>
                                    ${product.danhMuc.tenDM}
                                    <c:if test="${not empty product.danhMuc.moTa}">
                                        <br/><small>Mô tả: ${product.danhMuc.moTa}</small>
                                    </c:if>
                                    <c:if test="${not empty product.danhMuc.ngayTao}">
                                        <br/><small>Ngày tạo: <fmt:formatDate value="${product.danhMuc.ngayTao}" pattern="dd/MM/yyyy" /></small>
                                    </c:if>
                                    <c:if test="${not empty product.danhMuc.ngayCapNhat}">
                                        <br/><small>Cập nhật: <fmt:formatDate value="${product.danhMuc.ngayCapNhat}" pattern="dd/MM/yyyy" /></small>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>Cửa hàng:</strong></td>
                                <td>
                                    ${product.cuaHang.tenCH}
                                    <c:if test="${not empty product.cuaHang.diaChi}">
                                        <br/><small>Địa chỉ: ${product.cuaHang.diaChi}</small>
                                    </c:if>
                                    <c:if test="${not empty product.cuaHang.soDienThoai}">
                                        <br/><small>SĐT: ${product.cuaHang.soDienThoai}</small>
                                    </c:if>
                                    <c:if test="${not empty product.cuaHang.email}">
                                        <br/><small>Email: ${product.cuaHang.email}</small>
                                    </c:if>
                                    <c:if test="${empty product.cuaHang.diaChi && empty product.cuaHang.soDienThoai && empty product.cuaHang.email && not empty product.cuaHang.moTa}">
                                        <br/><small>Mô tả: ${product.cuaHang.moTa}</small>
                                    </c:if>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="reviews">
                    <div class="p-4">
                        <h5>Đánh giá của khách hàng</h5>
                        <c:if test="${empty reviews}">
                            <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                        </c:if>
                        <c:forEach var="review" items="${reviews}">
                            <div class="review-item border-bottom pb-3 mb-3">
                                <div class="d-flex justify-content-between">
                                    <strong>${review.nguoiDung.hoTen}</strong>
                                    <div class="text-warning">
                                        <c:forEach begin="1" end="5" varStatus="loop">
                                            <i class="${loop.index <= review.diemDanhGia ? 'fas' : 'far'} fa-star"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                                <p class="mb-1">${review.noiDung}</p>
                                <small class="text-muted"><fmt:formatDate value="${review.ngayDanhGia}" pattern="dd/MM/yyyy" /></small>
                            </div>
                        </c:forEach>

                        <hr/>

                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <h5>Viết đánh giá của bạn</h5>
                                <c:set var="rawOrderId" value="${param.orderId}"/>
                                <c:if test="${empty rawOrderId && not empty order}">
                                    <c:set var="rawOrderId" value="${order.id}"/>
                                </c:if>
                                <c:if test="${empty rawOrderId}">
                                    <c:set var="rawOrderId" value="${sessionScope.orderId}"/>
                                </c:if>

                                <c:set var="orderIdForReview" value=""/>
                                <c:if test="${not empty rawOrderId}">
                                    <c:catch var="numberFormatException">
                                        <fmt:parseNumber var="parsedOrderId" value="${rawOrderId}" integerOnly="true"/>
                                        <c:if test="${parsedOrderId > 0}">
                                            <c:set var="orderIdForReview" value="${parsedOrderId}"/>
                                        </c:if>
                                    </c:catch>
                                </c:if>

                                <c:if test="${not empty orderIdForReview}">
                                    <form class="review-form" action="${pageContext.request.contextPath}/guest/submit-review" method="post" enctype="multipart/form-data" onsubmit="return validateReviewForm(this);">
                                        <input type="hidden" name="productId" value="${product.maSP}"/>
                                        <input type="hidden" name="orderId" value="${orderIdForReview}"/>
                                        <div class="mb-3">
                                            <label class="form-label">Đánh giá của bạn</label>
                                            <div class="rating">
                                                <input type="radio" name="rating" value="5" id="5"><label for="5">☆</label>
                                                <input type="radio" name="rating" value="4" id="4"><label for="4">☆</label>
                                                <input type="radio" name="rating" value="3" id="3"><label for="3">☆</label>
                                                <input type="radio" name="rating" value="2" id="2"><label for="2">☆</label>
                                                <input type="radio" name="rating" value="1" id="1"><label for="1">☆</label>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="reviewText" class="form-label">Nội dung đánh giá</label>
                                            <textarea class="form-control" id="reviewText" name="reviewText" rows="3"></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="reviewImages" class="form-label">Thêm ảnh</label>
                                            <input class="form-control" type="file" id="reviewImages" name="reviewImages" accept="image/*" multiple>
                                        </div>
                                        <div class="mb-3">
                                            <label for="reviewVideo" class="form-label">Thêm video</label>
                                            <input class="form-control" type="file" id="reviewVideo" name="reviewVideo" accept="video/*">
                                        </div>
                                        <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                                    </form>
                                </c:if>
                                <c:if test="${empty orderIdForReview}">
                                    <p class="text-danger">Để gửi đánh giá, bạn cần truy cập trang này từ lịch sử đơn hàng của mình để liên kết đánh giá với một đơn hàng cụ thể.</p>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <p><a href="${pageContext.request.contextPath}/login">Đăng nhập</a> để viết đánh giá.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Related Products Section -->
    <c:if test="${not empty product.cuaHang}">
        <div class="related-products-section mt-5">
            <h2 class="mb-4">Sản phẩm khác từ ${product.cuaHang.tenCH}</h2>
            <c:choose>
                <c:when test="${not empty productsOfStore}">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
                        <c:forEach var="p" items="${productsOfStore}">
                            <div class="col">
                                <div class="product-card">
                                    <div class="product-image-container" style="height: 250px;">
                                        <a href="${pageContext.request.contextPath}/guest/product?id=${p.maSP}">
                                            <img src="${pageContext.request.contextPath}/assets/img/${p.hinhAnh}"
                                                 alt="${p.tenSP}"
                                                 class="product-image"
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
                                        </a>
                                    </div>
                                    <div class="card-body">
                                        <h6 class="card-title" style="min-height: 40px;">
                                            <a href="${pageContext.request.contextPath}/guest/product?id=${p.maSP}">${p.tenSP}</a>
                                        </h6>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="price">
                                                <fmt:formatNumber value="${p.donGia}" type="number" groupingUsed="true"/>₫
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-center text-muted mt-4">Cửa hàng này chưa có sản phẩm nào khác.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const quantityInput = document.getElementById('quantity');
        const decreaseBtn = document.getElementById('decreaseQuantityBtn');
        const increaseBtn = document.getElementById('increaseQuantityBtn');

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

        updateQuantityControls();
    });

    function showNotification(message, type) {
	    var notificationType = type || 'info';
	
	    var iconMap = {
	        success: 'fa-check-circle',
	        info: 'fa-info-circle',
	        warning: 'fa-exclamation-triangle',
	        danger: 'fa-exclamation-circle'
	    };
	    var iconClass = iconMap[notificationType] || 'fa-info-circle';
	
	    var notification = document.createElement('div');
	    notification.className = 'alert alert-' + notificationType + ' position-fixed d-flex align-items-center';
	    notification.style.top = '20px';
	    notification.style.right = '20px';
	    notification.style.zIndex = '9999';
	    notification.style.minWidth = '300px';
	    notification.style.animation = 'slideInRight 0.3s ease-out';
	    
	    var icon = document.createElement('i');
	    icon.className = 'fas ' + iconClass + ' me-2';
	
	    var messageSpan = document.createElement('span');
	    messageSpan.textContent = message;
	    messageSpan.style.color = 'inherit';
	
	    var closeButton = document.createElement('button');
	    closeButton.type = 'button';
	    closeButton.className = 'btn-close ms-auto';
	    closeButton.setAttribute('onclick', 'this.parentElement.remove()');
	
	    notification.appendChild(icon);
	    notification.appendChild(messageSpan);
	    notification.appendChild(closeButton);
	    
	    document.body.appendChild(notification);
	
	    setTimeout(function() {
	        if (notification.parentElement) {
	            notification.style.animation = 'slideOutRight 0.3s ease-in forwards';
	            notification.addEventListener('animationend', function() { 
	                if(notification.parentElement) { 
	                    notification.remove(); 
	                }
	            });
	        }
	    }, 5000);
	}

    function requireLogin() {
        showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning');
    }

    function handleAddToCart(productId, isGuest) {
        if (isGuest) {
            requireLogin();
            return;
        }
        const quantity = document.getElementById('quantity').value;

        var xhr = new XMLHttpRequest();
        xhr.open('POST', '${pageContext.request.contextPath}/user/cart?action=add', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        showNotification(response.message || 'Đã thêm vào giỏ hàng thành công!', 'success');
                        if (response.cartCount !== undefined) {
                            var cartCountElements = document.querySelectorAll('.cart-count, #cart-count');
                            cartCountElements.forEach(function(el) {
                                el.textContent = response.cartCount;
                            });
                        }
                    } else {
                        showNotification(response.message || 'Không thể thêm vào giỏ hàng!', 'danger');
                    }
                } catch (e) {
                    showNotification('Đã thêm vào giỏ hàng thành công!', 'success');
                }
            } else {
                showNotification('Có lỗi xảy ra. Vui lòng thử lại!', 'danger');
            }
        };
        
        xhr.onerror = function() {
            showNotification('Có lỗi kết nối. Vui lòng thử lại!', 'danger');
        };
        
        var data = 'productId=' + encodeURIComponent(productId) + '&quantity=' + encodeURIComponent(quantity);
        xhr.send(data);
    }

    function handleBuyNow(productId, isGuest) {
        if (isGuest) {
            requireLogin();
            return;
        }
        const quantity = document.getElementById('quantity').value;
        
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/user/cart?action=add&buyNow=true';

        var inputProduct = document.createElement('input');
        inputProduct.type = 'hidden';
        inputProduct.name = 'productId';
        inputProduct.value = productId;
        form.appendChild(inputProduct);

        var inputQuantity = document.createElement('input');
        inputQuantity.type = 'hidden';
        inputQuantity.name = 'quantity';
        inputQuantity.value = quantity;
        form.appendChild(inputQuantity);

        document.body.appendChild(form);
        form.submit();
    }

    function handleAddToFavorites(event, button, productId, isGuest) {
	    event.stopPropagation();
	    event.preventDefault();
	
	    if (isGuest) {
	        requireLogin();
	        return;
	    }
	
	    button.classList.toggle('active');
	    
	    const icon = button.querySelector('i');
	    if (button.classList.contains('active')) {
	        icon.classList.remove('far');
	        icon.classList.add('fas');
	        showNotification('Đã thêm vào danh sách yêu thích!', 'success');
	    } else {
	        icon.classList.remove('fas');
	        icon.classList.add('far');
	        showNotification('Đã xóa khỏi danh sách yêu thích.', 'info');
	    }
	}

    function validateReviewForm(form) {
        const orderIdInput = form.querySelector('input[name="orderId"]');
        if (!orderIdInput || !orderIdInput.value || parseInt(orderIdInput.value) <= 0) {
            alert('Lỗi: Mã đơn hàng (Order ID) không hợp lệ. Vui lòng tải lại trang hoặc truy cập từ lịch sử đơn hàng.');
            return false;
        }
        return true;
    }
</script>

</body>