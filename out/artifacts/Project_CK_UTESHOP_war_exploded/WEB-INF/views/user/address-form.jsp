<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Chỉnh Sửa' : 'Thêm'} Địa Chỉ - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        /* Breadcrumb */
        .breadcrumb {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .breadcrumb-item a {
            text-decoration: none;
            color: #667eea;
            font-weight: 500;
        }

        /* Form Card */
        .form-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            padding: 40px;
            animation: fadeInUp 0.6s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Form Header */
        .form-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: #2d3748;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .form-title i {
            color: #667eea;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            display: block;
        }

        .form-label .required {
            color: #e53e3e;
            margin-left: 3px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control.is-invalid {
            border-color: #e53e3e;
        }

        .invalid-feedback {
            color: #e53e3e;
            font-size: 0.875rem;
            margin-top: 5px;
        }

        /* Checkbox */
        .form-check {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px;
            background: #f7fafc;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .form-check-input {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .form-check-label {
            font-weight: 500;
            color: #2d3748;
            cursor: pointer;
        }

        /* Buttons */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 14px 25px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background-color: #edf2f7;
            color: #4a5568;
        }

        .btn-secondary:hover {
            background-color: #e2e8f0;
            color: #2d3748;
        }

        /* Alert */
        .alert {
            border-radius: 10px;
            border: none;
            margin-bottom: 20px;
            padding: 15px 20px;
        }

        .alert-danger {
            background-color: #fff5f5;
            color: #e53e3e;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-card {
                padding: 25px;
            }

            .form-title {
                font-size: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user me-1"></i>Hồ sơ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/address">Địa chỉ giao hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">${isEdit ? 'Chỉnh sửa' : 'Thêm mới'}</li>
            </ol>
        </nav>

        <!-- Form Card -->
        <div class="form-card">
            <!-- Header -->
            <div class="form-header">
                <h1 class="form-title">
                    <i class="fas fa-map-marker-alt"></i>
                    ${isEdit ? 'Chỉnh Sửa Địa Chỉ' : 'Thêm Địa Chỉ Mới'}
                </h1>
            </div>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/user/address" method="post">
                <input type="hidden" name="action" value="save">
                <c:if test="${isEdit}">
                    <input type="hidden" name="id" value="${address.maDC}">
                </c:if>

                <!-- Tên người nhận -->
                <div class="form-group">
                    <label class="form-label">
                        Tên người nhận<span class="required">*</span>
                    </label>
                    <input type="text" 
                           name="tenNguoiNhan" 
                           class="form-control ${not empty error and empty tenNguoiNhan ? 'is-invalid' : ''}"
                           value="${isEdit ? address.tenNguoiNhan : tenNguoiNhan}"
                           placeholder="Nhập họ tên người nhận"
                           required>
                </div>

                <!-- Số điện thoại -->
                <div class="form-group">
                    <label class="form-label">
                        Số điện thoại<span class="required">*</span>
                    </label>
                    <input type="tel" 
                           name="soDienThoai" 
                           class="form-control ${not empty error and empty soDienThoai ? 'is-invalid' : ''}"
                           value="${isEdit ? address.soDienThoai : soDienThoai}"
                           placeholder="Nhập số điện thoại"
                           pattern="[0-9]{10,11}"
                           required>
                </div>

                <!-- Địa chỉ cụ thể -->
                <div class="form-group">
                    <label class="form-label">
                        Địa chỉ cụ thể<span class="required">*</span>
                    </label>
                    <input type="text" 
                           name="diaChiCuThe" 
                           class="form-control ${not empty error and empty diaChiCuThe ? 'is-invalid' : ''}"
                           value="${isEdit ? address.diaChiCuThe : diaChiCuThe}"
                           placeholder="Số nhà, tên đường"
                           required>
                </div>

                <!-- Phường/Xã -->
                <div class="form-group">
                    <label class="form-label">
                        Phường/Xã<span class="required">*</span>
                    </label>
                    <input type="text" 
                           name="phuong" 
                           class="form-control ${not empty error and empty phuong ? 'is-invalid' : ''}"
                           value="${isEdit ? address.phuong : phuong}"
                           placeholder="Nhập phường/xã"
                           required>
                </div>

                <!-- Quận/Huyện -->
                <div class="form-group">
                    <label class="form-label">
                        Quận/Huyện<span class="required">*</span>
                    </label>
                    <input type="text" 
                           name="quan" 
                           class="form-control ${not empty error and empty quan ? 'is-invalid' : ''}"
                           value="${isEdit ? address.quan : quan}"
                           placeholder="Nhập quận/huyện"
                           required>
                </div>

                <!-- Thành phố -->
                <div class="form-group">
                    <label class="form-label">
                        Tỉnh/Thành phố<span class="required">*</span>
                    </label>
                    <input type="text" 
                           name="thanhPho" 
                           class="form-control ${not empty error and empty thanhPho ? 'is-invalid' : ''}"
                           value="${isEdit ? address.thanhPho : thanhPho}"
                           placeholder="Nhập tỉnh/thành phố"
                           required>
                </div>

                <!-- Đặt làm mặc định -->
                <div class="form-check">
                    <input type="checkbox" 
                           name="laMacDinh" 
                           id="laMacDinh" 
                           class="form-check-input"
                           ${(isEdit and address.laMacDinh) or laMacDinh ? 'checked' : ''}>
                    <label class="form-check-label" for="laMacDinh">
                        <i class="fas fa-star me-1"></i>Đặt làm địa chỉ mặc định
                    </label>
                </div>

                <!-- Action Buttons -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/user/address" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Hủy
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        ${isEdit ? 'Cập Nhật' : 'Lưu Địa Chỉ'}
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
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