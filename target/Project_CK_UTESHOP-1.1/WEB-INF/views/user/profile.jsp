<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>

<%
// Simulate backend data for user profile based on NguoiDung table
Map<String, Object> userProfile = new HashMap<>();
userProfile.put("fullName", "Nguyễn Văn A");
userProfile.put("username", "nguyenvana");
userProfile.put("email", "nguyenvana@example.com");
userProfile.put("address", "123 Đường ABC, Quận 1, TP.HCM, Việt Nam");
userProfile.put("phone", "0901234567");
userProfile.put("createdDate", new java.util.Date(2025 - 1900, 9, 1)); // 2025-10-01
userProfile.put("updatedDate", new java.util.Date(2025 - 1900, 9, 23)); // 2025-10-23
userProfile.put("status", true); // 1 = active
userProfile.put("role", "Người dùng");
userProfile.put("avatarUrl", "https://via.placeholder.com/120");

pageContext.setAttribute("userProfile", userProfile);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    

    <div class="profile-container">
        <!-- Breadcrumbs với khoảng cách từ header -->
        <nav aria-label="breadcrumb" class="mb-4" style="margin-top: 80px;">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/guest/home'/>">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Hồ Sơ Cá Nhân</li>
            </ol>
        </nav>

        <div class="profile-card">
            <div class="profile-header">
                <img src="${empty userProfile.avatarUrl ? 'https://via.placeholder.com/120' : userProfile.avatarUrl}" alt="Avatar" class="profile-avatar">
                <div class="profile-name">${userProfile.fullName}</div>
                <div class="profile-role">Vai trò: ${userProfile.role}</div>
            </div>

            <div class="info-section">
                <div class="info-title">Thông tin cá nhân</div>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Tên đăng nhập:</span>
                        <span class="info-value">${userProfile.username}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Họ và tên:</span>
                        <span class="info-value">${userProfile.fullName}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value">${userProfile.email}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Địa chỉ:</span>
                        <span class="info-value">${userProfile.address}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Số điện thoại:</span>
                        <span class="info-value">${userProfile.phone}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Ngày tạo:</span>
                        <span class="info-value"><fmt:formatDate value="${userProfile.createdDate}" pattern="dd/MM/yyyy"/></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Ngày cập nhật:</span>
                        <span class="info-value"><fmt:formatDate value="${userProfile.updatedDate}" pattern="dd/MM/yyyy"/></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Trạng thái:</span>
                        <span class="info-value ${userProfile.status ? 'status-active' : 'status-inactive'}">
                            ${userProfile.status ? 'Đang hoạt động' : 'Không hoạt động'}
                        </span>
                    </div>
                </div>
            </div>

            <div class="profile-actions">
                <button class="btn btn-primary btn-edit" onclick="editProfile()">
                    <i class="fas fa-pen me-2"></i>Chỉnh sửa hồ sơ
                </button>
                <button class="btn btn-danger btn-change-password" onclick="changePassword()">
                    <i class="fas fa-key me-2"></i>Đổi mật khẩu
                </button>
            </div>
        </div>
    </div>

    <style>
        body {
            background-color: #e9ecef; /* Matches orders.jsp */
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0; /* Loại bỏ padding-top khỏi body, xử lý bằng margin-top cho breadcrumb */
            color: #333;
        }

        /* Giữ nguyên header của bạn */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(45deg, #2874f0, #1a5fce); /* UTESHOP blue gradient */
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
            color: #ff3f6c; /* Pink hover effect */
        }
        .nav-link.active {
            color: #ff3f6c;
            font-weight: 600;
            border-bottom: 2px solid #ff3f6c;
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

        .profile-container {
            max-width: 900px; /* Wider container */
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

        /* Profile Card */
        .profile-card {
            background: linear-gradient(135deg, #e6f0fa 0%, #f8f9fa 100%); /* Matches orders.jsp */
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            transition: all 0.3s ease;
        }
        .profile-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        /* Profile Header */
        .profile-header {
            text-align: center;
            margin-bottom: 35px;
        }
        .profile-avatar {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 4px solid #2874f0; /* UTESHOP blue */
            object-fit: cover;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(40, 116, 240, 0.3);
            transition: transform 0.3s ease;
        }
        .profile-avatar:hover {
            transform: scale(1.05);
        }
        .profile-name {
            font-size: 1.9rem;
            font-weight: 700;
            color: #222;
            margin-bottom: 6px;
        }
        .profile-role {
            font-size: 1rem;
            color: #2874f0;
            font-weight: 500;
        }

        /* Info Section */
        .info-section {
            border-top: 1px solid #d1e0f0;
            padding-top: 25px;
        }
        .info-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #444;
            margin-bottom: 15px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 280px 1fr; /* Wider label column */
            gap: 12px 30px; /* More horizontal space */
            font-size: 0.95rem;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #d1e0f0;
        }
        .info-label {
            color: #666;
            font-weight: 500;
            text-align: left;
        }
        .info-value {
            color: #333;
            font-weight: 500;
            text-align: right;
            flex: 1;
            word-break: break-word; /* Handle long values */
        }
        .status-active {
            color: #28a745;
            font-weight: 600;
        }
        .status-inactive {
            color: #ff3f6c;
            font-weight: 600;
        }

        /* Profile Actions */
        .profile-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }
        .profile-actions .btn {
            padding: 12px 28px;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            transition: all 0.3s ease;
            flex: 1;
            max-width: 200px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-primary {
            background: linear-gradient(45deg, #2874f0, #1a5fce);
            border: none;
            box-shadow: 0 4px 10px rgba(40, 116, 240, 0.3);
        }
        .btn-primary:hover {
            background: linear-gradient(45deg, #1a5fce, #2874f0);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(40, 116, 240, 0.4);
        }
        .btn-danger {
            background: linear-gradient(45deg, #ff3f6c, #ff6b81);
            border: none;
            box-shadow: 0 4px 10px rgba(255, 63, 108, 0.3);
        }
        .btn-danger:hover {
            background: linear-gradient(45deg, #ff6b81, #ff3f6c);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(255, 63, 108, 0.4);
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
            .profile-container {
                padding: 0 15px;
            }
            .profile-card {
                padding: 25px 20px;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
            .info-item {
                flex-direction: column;
                align-items: flex-start;
            }
            .info-value {
                text-align: left;
            }
            .profile-actions {
                flex-direction: column;
                gap: 10px;
            }
            .profile-actions .btn {
                max-width: none;
            }
        }
    </style>

    <script>
        // Action functions
        function editProfile() {
            console.log('DEBUG JS: ✏️ Editing profile');
            showNotification('Chuyển đến trang chỉnh sửa hồ sơ!', 'success');
            window.location.href = '<c:url value="/user/edit-profile"/>';
        }

        function changePassword() {
            console.log('DEBUG JS: 🔑 Changing password');
            showNotification('Chuyển đến trang đổi mật khẩu!', 'success');
            window.location.href = '<c:url value="/user/change-password"/>';
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
            notification.style.top = '80px'; /* Điều chỉnh cho header cố định */
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