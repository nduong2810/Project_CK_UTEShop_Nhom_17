<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
// Simulate backend data for favoriteProducts
java.util.List<Object> favoriteProducts = new java.util.ArrayList<>();
java.util.Map<String, Object> product1 = new java.util.HashMap<>();
product1.put("maSP", 1);
product1.put("tenSP", "Laptop Gaming ASUS ROG");
product1.put("hinhAnh", "asus_rog_laptop.jpg");
product1.put("donGia", 25000000);
product1.put("soLuongBan", 120);
product1.put("isFavorite", true); // Simulate favorite status

java.util.Map<String, Object> product2 = new java.util.HashMap<>();
product2.put("maSP", 2);
product2.put("tenSP", "Tai Nghe Bluetooth Sony");
product2.put("hinhAnh", "sony_headphones.jpg");
product2.put("donGia", 3500000);
product2.put("soLuongBan", 85);
product2.put("isFavorite", true);

java.util.Map<String, Object> product3 = new java.util.HashMap<>();
product3.put("maSP", 3);
product3.put("tenSP", "Điện Thoại iPhone 14 Pro");
product3.put("hinhAnh", "iphone_14_pro.jpg");
product3.put("donGia", 29990000);
product3.put("soLuongBan", 200);
product3.put("isFavorite", true);

favoriteProducts.add(product1);
favoriteProducts.add(product2);
favoriteProducts.add(product3);

pageContext.setAttribute("favoriteProducts", favoriteProducts);
pageContext.setAttribute("totalPages", 1);
pageContext.setAttribute("currentPage", 1);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản Phẩm Yêu Thích - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<div class="container my-5">
    <!-- Breadcrumbs -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/guest/home'/>">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Sản Phẩm Yêu Thích</li>
        </ol>
    </nav>

    <div class="section-header mb-5">
        <h1 class="display-5 fw-bold text-primary">Sản Phẩm Yêu Thích</h1>
        <p class="lead text-muted">Danh sách các sản phẩm bạn đã yêu thích tại UTESHOP</p>
        <hr>
    </div>

    <c:choose>
        <c:when test="${not empty favoriteProducts}">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
                <c:forEach var="sp" items="${favoriteProducts}" varStatus="status">
                    <div class="col">
                        <div class="product-card">
                            <div class="product-image-container">
                                <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">
                                    <img src="${pageContext.request.contextPath}/assets/img/${sp.hinhAnh}"
                                         alt="${sp.tenSP}"
                                         class="product-image"
                                         onload="this.classList.add('loaded')"
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'; this.classList.add('loaded');">
                                </a>
                                <button class="btn-favorite ${sp.isFavorite ? 'active' : ''}" 
                                        onclick="toggleFavorite(event, this, ${sp.maSP}, ${empty sessionScope.user})">
                                    <i class="${sp.isFavorite ? 'fas' : 'far'} fa-heart"></i>
                                </button>
                            </div>
                            
                            <div class="card-body">
                                <h5 class="card-title">
                                    <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}">${sp.tenSP}</a>
                                </h5>
                                
                                <div class="d-flex justify-content-between align-items-center mb-3 price-line">
                                    <div class="price">
                                        <fmt:formatNumber value="${sp.donGia}" type="number" groupingUsed="true"/>₫
                                    </div>
                                    <small class="sold-count">
                                        <i class="fas fa-shopping-cart me-1"></i>
                                        ${sp.soLuongBan} đã bán
                                    </small>
                                </div>
                                
                                <div class="d-flex gap-2">
                                    <button class="btn btn-add-to-cart flex-fill" 
                                            onclick="addToCart(${sp.maSP}, ${empty sessionScope.user})">
                                        <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
                                    </button>
                                    <button class="btn btn-buy-now flex-fill" 
                                            onclick="buyNow(${sp.maSP}, ${empty sessionScope.user})">
                                        <i class="fas fa-bolt me-2"></i>Mua ngay
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination Controls -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Favorite Products Pagination" class="mt-5">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <c:url var="prevUrl" value="/guest/favorites">
                                <c:param name="page" value="${currentPage - 1}"/>
                            </c:url>
                            <a class="page-link" href="${prevUrl}" tabindex="-1" aria-disabled="true"><i class="fas fa-chevron-left"></i></a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <c:url var="pageUrl" value="/guest/favorites">
                                    <c:param name="page" value="${i}"/>
                                </c:url>
                                <a class="page-link" href="${pageUrl}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <c:url var="nextUrl" value="/guest/favorites">
                                <c:param name="page" value="${currentPage + 1}"/>
                            </c:url>
                            <a class="page-link" href="${nextUrl}"><i class="fas fa-chevron-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="fa fa-heart fa-5x text-muted mb-4"></i>
                <h3 class="text-muted mb-3">Chưa có sản phẩm yêu thích</h3>
                <p class="text-muted">Hãy thêm sản phẩm vào danh sách yêu thích để xem tại đây.</p>
                <a href="<c:url value='/guest/home'/>" class="btn btn-primary"><i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
/* Breadcrumb Styles */
.breadcrumb {
    background-color: #f8f9fa;
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
}

.breadcrumb-item a {
    text-decoration: none;
    color: #2874f0;
    font-weight: 500;
}

.breadcrumb-item.active {
    color: #6c757d;
}

/* Custom Pagination Styles */
.pagination .page-item .page-link {
    color: #6c757d;
    border-radius: 50%;
    margin: 0 5px;
    border: none;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}

.pagination .page-item.active .page-link {
    background-color: #2874f0;
    color: white;
    box-shadow: 0 4px 10px rgba(40, 116, 240, 0.4);
    transform: translateY(-2px);
}

.pagination .page-item.disabled .page-link {
    color: #ced4da;
    background-color: transparent;
}

.pagination .page-item .page-link:hover {
    background-color: #e9ecef;
    color: #2874f0;
}

.pagination .page-item.active .page-link:hover {
    background-color: #1557bf;
}

/* Product Card Styles */
.product-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    border: 1px solid #e0e0e0;
    height: 100%;
    display: flex;
    flex-direction: column;
    min-height: 450px;
}

.product-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.product-image-container {
    height: 280px;
    position: relative;
    overflow: hidden;
    background: #f8f9fa;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 25px;
}

.product-image {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.product-card:hover .product-image {
    transform: scale(1.05);
}

.btn-favorite {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: none;
    background-color: rgba(255, 255, 255, 0.8);
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    z-index: 3;
    backdrop-filter: blur(5px);
}

.btn-favorite:hover {
    background-color: white;
    transform: scale(1.1);
    color: #ff3f6c;
}

.btn-favorite.active {
    background-color: #ff3f6c;
    color: white;
}

.btn-favorite.active .fa-heart {
    font-weight: 900;
}

.product-card .card-body {
    padding: 25px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.product-card .card-title {
    font-size: 1.1rem;
    font-weight: 600;
    line-height: 1.4;
    margin-bottom: 15px;
    color: #333;
    min-height: 50px;
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
    font-size: 1.6rem;
    font-weight: 700;
    color: #2874f0;
    margin-bottom: 10px;
    white-space: nowrap;
}

.product-card .sold-count {
    color: #878787;
    font-size: 0.9rem;
    white-space: nowrap;
    flex-shrink: 0;
}

.price-line {
    flex-wrap: wrap;
    gap: 5px;
}

.btn-add-to-cart {
    background: linear-gradient(45deg, #2874f0, #1a5fce);
    color: white;
    border: none;
    padding: 12px 10px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(40, 116, 240, 0.3);
}

.btn-add-to-cart:hover {
    background: linear-gradient(45deg, #1a5fce, #2874f0);
    box-shadow: 0 6px 20px rgba(40, 116, 240, 0.4);
    transform: translateY(-3px);
}

.btn-buy-now {
    background: linear-gradient(45deg, #ff3f6c, #ff6b81);
    color: white;
    border: none;
    padding: 12px 10px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(255, 63, 108, 0.3);
}

.btn-buy-now:hover {
    background: linear-gradient(45deg, #ff6b81, #ff3f6c);
    box-shadow: 0 6px 20px rgba(255, 63, 108, 0.4);
    transform: translateY(-3px);
}
</style>

<script>
    // Define base URLs using c:url to be safe
    const homeUrl = '<c:url value="/guest/home" />';
    const favoritesUrl = '<c:url value="/guest/favorites" />';

    // Function to require login
    function requireLogin() {
        showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning', true);
    }

    // Utility functions for product interactions
    function addToCart(productId, isGuest) {
        if (isGuest) {
            requireLogin();
            return;
        }
        console.log('DEBUG JS: 🛒 Adding to cart: ' + productId);
        showNotification('Sản phẩm đã được thêm vào giỏ hàng!', 'success');
    }

    function buyNow(productId, isGuest) {
        if (isGuest) {
            requireLogin();
            return;
        }
        console.log('DEBUG JS: ⚡ Buying now: ' + productId);
        showNotification('Chuyển đến trang thanh toán!', 'success');
        // Redirect to checkout page (example)
        window.location.href = '<c:url value="/guest/checkout"/>?productId=' + productId;
    }

    function toggleFavorite(event, button, productId, isGuest) {
        event.stopPropagation();
        event.preventDefault();
        if (isGuest) {
            requireLogin();
            return;
        }
        const isActive = button.classList.contains('active');
        console.log('DEBUG JS: ❤️ Toggling favorite for product: ' + productId + ', isActive: ' + isActive);
        button.classList.toggle('active');
        const icon = button.querySelector('i');
        if (isActive) {
            icon.classList.remove('fas');
            icon.classList.add('far');
            showNotification('Đã xóa khỏi danh sách yêu thích.', 'info');
            window.location.href = favoritesUrl + '?removeProductId=' + productId;
        } else {
            icon.classList.remove('far');
            icon.classList.add('fas');
            showNotification('Đã thêm vào danh sách yêu thích!', 'success');
            window.location.href = favoritesUrl + '?addProductId=' + productId;
        }
    }

    function showNotification(message, type, persistent) {
        var notificationType = type || 'info';
        var isPersistent = persistent || false;
        var notificationId = 'login-required-notification';

        if (isPersistent && document.getElementById(notificationId)) {
            var existingNotification = document.getElementById(notificationId);
            existingNotification.classList.remove('shake');
            void existingNotification.offsetWidth;
            existingNotification.classList.add('shake');
            
            existingNotification.querySelector('span').textContent = message;
            existingNotification.className = 'alert alert-' + notificationType + ' position-fixed d-flex align-items-center';
            var iconMap = {
                success: 'fa-check-circle',
                info: 'fa-info-circle',
                warning: 'fa-exclamation-triangle',
                danger: 'fa-exclamation-circle'
            };
            var iconClass = iconMap[notificationType] || 'fa-info-circle';
            existingNotification.querySelector('i').className = 'fas ' + iconClass + ' me-2';
            return;
        }

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
        
        if (isPersistent) {
            notification.id = notificationId;
        }

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

        if (!isPersistent) {
            setTimeout(function() {
                if (notification.parentElement) {
                    notification.style.animation = 'slideOutRight 0.3s ease-in forwards';
                    notification.addEventListener('animationend', function() { 
                        if(notification.parentElement) { 
                            notification.remove(); 
                        }
                    });
                }
            }, 6000);
        }
    }

    const notificationStyles = document.createElement('style');
    notificationStyles.textContent = `
        @keyframes slideInRight { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
        @keyframes slideOutRight { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }
        @keyframes shake { 
            10%, 90% { transform: translateX(-1px); } 
            20%, 80% { transform: translateX(2px); } 
            30%, 50%, 70% { transform: translateX(-4px); } 
            40%, 60% { transform: translateX(4px); } 
        }
        .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both; }
    `;
    document.head.appendChild(notificationStyles);
</script>

</body>
</html>