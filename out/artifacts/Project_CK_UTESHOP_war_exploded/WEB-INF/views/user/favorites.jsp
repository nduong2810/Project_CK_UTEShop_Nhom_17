<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>Sản Phẩm Yêu Thích - UTESHOP</title>
    <style>
        /* Styles from home.jsp for consistency */
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

        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .empty-state i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1rem;
        }

        /* Alert Styles */
        .alert {
            border-radius: 12px;
            border: none;
        }

        .alert-danger {
            background: #fff5f5;
            color: #c53030;
        }

        .alert-secondary {
            background: #f7fafc;
            color: #4a5568;
        }

        .alert-warning {
            background-color: #fffbeb;
            color: #b45309;
        }

        /* Notification Animations */
        @keyframes slideInRight { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
        @keyframes slideOutRight { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }
        @keyframes shake { 
            10%, 90% { transform: translateX(-1px); } 
            20%, 80% { transform: translateX(2px); } 
            30%, 50%, 70% { transform: translateX(-4px); } 
            40%, 60% { transform: translateX(4px); } 
        }
        .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both; }
    </style>
</head>

<div class="container-xl my-5">
    <!-- Breadcrumbs -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/guest/home'/>">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Sản Phẩm Yêu Thích</li>
        </ol>
    </nav>

    <div class="section-header mb-5 text-center">
        <h1 class="display-5 fw-bold">Sản Phẩm Yêu Thích</h1>
        <p class="lead text-muted">Danh sách các sản phẩm bạn đã lưu lại tại UTESHOP</p>
    </div>

    <c:choose>
        <c:when test="${not empty favorites}">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4" id="product-list">
                <c:forEach var="favorite" items="${favorites}">
                    <c:set var="product" value="${favorite.sanPham}" scope="request"/>
                    <c:import url="/WEB-INF/views/guest/product-card.jsp"/>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-5">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/user/favorites?page=${currentPage - 1}">Trước</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/user/favorites?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/user/favorites?page=${currentPage + 1}">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>

        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-heart-broken mb-3"></i>
                <h3>Danh sách yêu thích trống</h3>
                <p class="text-muted">Bạn chưa thêm sản phẩm nào vào danh sách yêu thích.</p>
                <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary mt-3">
                    <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script>
    var contextPath = "${pageContext.request.contextPath}";

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

    function toggleFavorite(event, button, productId, requireLogin) {
        event.preventDefault();
        
        if (requireLogin) {
            window.location.href = contextPath + '/auth/login';
            return;
        }
        fetch(contextPath + '/user/favorites/toggle', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'maSP=' + productId
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const heartIcon = button.querySelector('i.fa-heart');
                if (data.action === 'removed') {
                        if (window.location.pathname.includes('/user/favorites')) {
                            // Remove the product card from the DOM
                            const productCard = button.closest('.col');
                            if (productCard) {
                                productCard.remove();
                            }
                        } else {
                            // Update button state
                            button.classList.remove('active');
                            if (heartIcon) {
                                heartIcon.classList.replace('fas', 'far');
                            }
                        }
                    } else { // added
                        // Update button state
                        button.classList.add('active');
                        if (heartIcon) {
                            heartIcon.classList.replace('far', 'fas');
                        }
                    }
                // Hiển thị thông báo thành công
                showNotification(data.message, data.action === 'removed' ? 'info' : 'success');
            } else {
                showNotification(data.message, 'danger');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Đã có lỗi xảy ra. Vui lòng thử lại sau.', 'danger');
        });
    }
</script>
