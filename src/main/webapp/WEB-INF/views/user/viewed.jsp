<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* Product Card */
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
        height: 300px;
        position: relative;
        overflow: hidden;
        background: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .product-image {
        width: 100%;
        height: 100%;
        object-fit: contain;
        transition: transform 0.3s ease;
    }

    .product-card:hover .product-image {
        transform: scale(1.05);
    }

    .badge-hot {
        position: absolute;
        top: 15px;
        left: 15px;
        background: linear-gradient(45deg, #ff3f6c, #ff6b81);
        color: white;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
        z-index: 2;
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
        font-weight: 900; /* Solid heart */
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

    .product-buttons {
        display: flex;
        gap: 10px;
        margin-top: auto;
    }

    .btn-add-to-cart, .btn-buy-now {
        flex: 1;
        padding: 12px 10px;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .btn-add-to-cart {
        background: linear-gradient(45deg, #2874f0, #1a5fce);
        color: white;
        border: none;
        box-shadow: 0 4px 15px rgba(40, 116, 240, 0.3);
    }

    .btn-add-to-cart:hover {
        background: linear-gradient(45deg, #1a5fce, #2874f0);
        box-shadow: 0 6px 20px rgba(40, 116, 240, 0.4);
        transform: translateY(-3px);
    }

    .btn-buy-now {
        background: linear-gradient(45deg, #ff9f00, #ff5f00);
        color: white;
        border: none;
        box-shadow: 0 4px 15px rgba(255, 159, 0, 0.3);
    }

    .btn-buy-now:hover {
        background: linear-gradient(45deg, #ff5f00, #ff9f00);
        box-shadow: 0 6px 20px rgba(255, 159, 0, 0.4);
        transform: translateY(-3px);
    }
</style>

<div class="container-xl py-4">
    <h3 class="mb-4 text-center">Sản phẩm bạn đã xem gần đây</h3>

    <c:choose>
        <c:when test="${empty viewedProducts}">
            <div class="alert alert-info text-center">
                Bạn chưa xem sản phẩm nào.
            </div>
        </c:when>
        <c:otherwise>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                <c:forEach var="p" items="${viewedProducts}">
                    <c:set var="product" value="${p}" scope="request"/>
                    <jsp:include page="/WEB-INF/views/guest/product-card.jsp"/>
                </c:forEach>
            </div>

            <!-- Pagination Controls -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-5">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}">Trước</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

<script>
//<![CDATA[
// Function to require login
function requireLogin() {
    showNotification('Bạn phải đăng nhập để thực hiện chức năng này!', 'warning');
}

// Utility functions for product interactions
function addToCart(productId, isGuest, quantity) {
    if (isGuest) {
        requireLogin();
        return;
    }
    quantity = typeof quantity !== 'undefined' ? quantity : 1;

    // Use AJAX to add to cart without page reload
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '${pageContext.request.contextPath}/user/cart?action=add', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest'); // Mark as AJAX request
    
    xhr.onload = function() {
        if (xhr.status === 200) {
            try {
                var response = JSON.parse(xhr.responseText);
                if (response.success) {
                    showNotification(response.message || 'Đã thêm vào giỏ hàng thành công!', 'success');
                    // Update cart count in header if exists
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

function buyNow(productId, isGuest) {
    if (isGuest) {
        requireLogin();
        return;
    }
    // Add to cart then redirect to checkout. Create form to submit and then change action to checkout on success.
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = window.location.origin + '${pageContext.request.contextPath}/user/cart?action=add';

    var inputProduct = document.createElement('input');
    inputProduct.type = 'hidden';
    inputProduct.name = 'productId';
    inputProduct.value = productId;
    form.appendChild(inputProduct);

    var inputQuantity = document.createElement('input');
    inputQuantity.type = 'hidden';
    inputQuantity.name = 'quantity';
    inputQuantity.value = 1;
    form.appendChild(inputQuantity);

    // After adding to cart the servlet will redirect to /user/cart; to implement buyNow behavior we can instead submit to an intermediate endpoint or to the checkout directly.
    // For simplicity, submit to add-to-cart and rely on user to proceed to checkout from cart page.
    document.body.appendChild(form);
    form.submit();
}

function toggleFavorite(event, button, productId, isGuest) {
    event.stopPropagation();
    event.preventDefault();

    if (isGuest) {
        requireLogin();
        return;
    }

    console.log('DEBUG JS: ❤️ Toggling favorite for product: ' + productId);
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

function showNotification(message, type) {
    var notificationType = type || 'info';

    console.log('DEBUG: showNotification called with message:', message, 'type:', notificationType);

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
    }, 5000); // Changed to 5000 milliseconds (5 seconds)
}
//]]>
</script>
