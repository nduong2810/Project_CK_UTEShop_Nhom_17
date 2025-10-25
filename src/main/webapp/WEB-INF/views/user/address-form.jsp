<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>

<%
// Simulate backend data for shipping address
Map<String, Object> shippingAddress = new HashMap<>();
shippingAddress.put("fullName", "Nguyễn Văn A");
shippingAddress.put("phone", "0901234567");
shippingAddress.put("address", "123 Đường ABC, Quận 1, TP.HCM, Việt Nam");
shippingAddress.put("isDefault", true);

pageContext.setAttribute("shippingAddress", shippingAddress);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa Chỉ Giao Hàng - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Giữ nguyên header của bạn -->
    <header class="header">
        <div class="header-container">
            <div class="logo">
                <a href="<c:url value='/guest/home'/>">UTESHOP</a>
            </div>
            <nav class="nav-menu">
                <a href="<c:url value='/guest/home'/>" class="nav-link">Trang chủ</a>
                <a href="<c:url value='/user/orders'/>" class="nav-link">Đơn hàng</a>
                <a href="<c:url value='/user/profile'/>" class="nav-link">Hồ sơ</a>
            </nav>
            <div class="user-menu">
                <span class="user-name">${shippingAddress.fullName}</span>
                <a href="<c:url value='/logout'/>" class="logout-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>
    </header>

    <div class="shipping-container">
        <!-- Breadcrumbs -->
        <nav aria-label="breadcrumb" class="mb-4" style="margin-top: 80px;">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/guest/home'/>">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Địa Chỉ Giao Hàng</li>
            </ol>
        </nav>

        <div class="shipping-card">
            <div class="shipping-header">
                <h2 class="shipping-title">Địa Chỉ Giao Hàng</h2>
                <button class="btn btn-primary btn-add" onclick="addNewAddress()">
                    <i class="fas fa-plus me-2"></i>Thêm Địa Chỉ Mới
                </button>
            </div>

            <div class="address-section">
                <div class="address-card ${shippingAddress.isDefault ? 'default-address' : ''}">
                    <div class="address-info">
                        <h5 class="address-name">${shippingAddress.fullName}</h5>
                        <p class="address-details">
                            <i class="fas fa-phone me-1"></i> ${shippingAddress.phone}<br>
                            <i class="fas fa-map-marker-alt me-1"></i> ${shippingAddress.address}
                        </p>
                        <c:if test="${shippingAddress.isDefault}">
                            <span class="badge bg-success">Mặc định</span>
                        </c:if>
                    </div>
                    <div class="address-actions">
                        <button class="btn btn-outline-primary btn-sm me-2" onclick="editAddress()">
                            <i class="fas fa-edit"></i> Sửa
                        </button>
                        <button class="btn btn-outline-danger btn-sm" onclick="deleteAddress()">
                            <i class="fas fa-trash"></i> Xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* Giữ nguyên header của bạn */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(45deg, #2874f0, #1a5fce);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 20px;
        }
        .logo a {
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            text-decoration: none;
        }
        .nav-menu {
            display: flex;
            gap: 20px;
        }
        .nav-link {
            color: white;
            font-size: 1rem;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #ff3f6c;
        }
        .user-menu {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-name {
            color: white;
            font-size: 0.95rem;
            font-weight: 500;
        }
        .logout-link {
            color: white;
            font-size: 0.95rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: color 0.3s ease;
        }
        .logout-link:hover {
            color: #ff3f6c;
        }

        .shipping-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Breadcrumb Styles */
        .breadcrumb {
            background-color: #f0f4f8;
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

        /* Shipping Card */
        .shipping-card {
            background: linear-gradient(135deg, #e6f0fa 0%, #f8f9fa 100%);
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            transition: all 0.3s ease;
        }
        .shipping-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        /* Shipping Header */
        .shipping-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .shipping-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #222;
            margin: 0;
        }
        .btn-add {
            background: linear-gradient(45deg, #2874f0, #1a5fce);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-add:hover {
            background: linear-gradient(45deg, #1a5fce, #2874f0);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(40, 116, 240, 0.3);
        }

        /* Address Section */
        .address-section {
            margin-top: 20px;
        }
        .address-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            border: 1px solid #d1e0f0;
            transition: all 0.3s ease;
        }
        .address-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .default-address {
            border-color: #2874f0;
            border-left: 4px solid #2874f0;
        }
        .address-info {
            flex: 1;
        }
        .address-name {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .address-details {
            font-size: 0.95rem;
            color: #666;
            margin: 0;
            line-height: 1.5;
        }
        .badge {
            font-size: 0.85rem;
            padding: 4px 10px;
            margin-top: 10px;
        }
        .address-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 0.9rem;
        }
        .btn-outline-primary:hover {
            background: #2874f0;
            color: white;
        }
        .btn-outline-danger:hover {
            background: #ff3f6c;
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .header-container {
                flex-direction: column;
                gap: 10px;
            }
            .nav-menu {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }
            .user-menu {
                flex-direction: column;
                align-items: center;
            }
            .shipping-header {
                flex-direction: column;
                gap: 15px;
            }
            .shipping-title {
                text-align: center;
            }
            .address-actions {
                flex-direction: column;
                gap: 5px;
            }
            .shipping-container {
                padding: 0 15px;
            }
            .shipping-card {
                padding: 20px;
            }
        }
    </style>

    <script>
        // Action functions
        function addNewAddress() {
            console.log('DEBUG JS: ➕ Adding new address');
            showNotification('Chuyển đến trang thêm địa chỉ mới!', 'success');
            window.location.href = '<c:url value="/user/add-address"/>';
        }

        function editAddress() {
            console.log('DEBUG JS: ✏️ Editing address');
            showNotification('Chuyển đến trang chỉnh sửa địa chỉ!', 'success');
            window.location.href = '<c:url value="/user/edit-address"/>';
        }

        function deleteAddress() {
            if (confirm('Bạn có chắc muốn xóa địa chỉ này?')) {
                console.log('DEBUG JS: 🗑️ Deleting address');
                showNotification('Đã xóa địa chỉ thành công!', 'success');
                // Thêm logic xóa ở đây nếu cần
            }
        }

        // Notification function
        function showNotification(message, type, persistent) {
            var notificationType = type || 'info';
            var isPersistent = persistent || false;
            var notificationId = 'notification-' + Date.now();

            if (isPersistent && document.querySelector('.notification-persistent')) {
                var existingNotification = document.querySelector('.notification-persistent');
                existingNotification.classList.remove('shake');
                void existingNotification.offsetWidth;
                existingNotification.classList.add('shake');
                existingNotification.querySelector('span').textContent = message;
                existingNotification.className = 'notification notification-persistent alert alert-' + notificationType + ' position-fixed d-flex align-items-center';
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
            notification.className = 'notification alert alert-' + notificationType + ' position-fixed d-flex align-items-center';
            if (isPersistent) {
                notification.classList.add('notification-persistent');
            }
            notification.style.top = '80px';
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

            if (!isPersistent) {
                setTimeout(function() {
                    if (notification.parentElement) {
                        notification.style.animation = 'slideOutRight 0.3s ease-in forwards';
                        notification.addEventListener('animationend', function() {
                            if (notification.parentElement) {
                                notification.remove();
                            }
                        });
                    }
                }, 6000);
            }
        }

        // Animation styles
        const animationStyles = document.createElement('style');
        animationStyles.textContent = `
            @keyframes slideInRight { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
            @keyframes slideOutRight { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }
            @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
            @keyframes shake {
                10%, 90% { transform: translateX(-1px); }
                20%, 80% { transform: translateX(2px); }
                30%, 50%, 70% { transform: translateX(-4px); }
                40%, 60% { transform: translateX(4px); }
            }
            .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both; }
        `;
        document.head.appendChild(animationStyles);
    </script>
</body>
</html>