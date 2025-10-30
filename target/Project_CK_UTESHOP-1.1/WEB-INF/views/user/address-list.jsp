<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa Chỉ Giao Hàng - UTESHOP</title>
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
            max-width: 1000px;
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

        /* Main Card */
        .address-main-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            padding: 30px;
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

        /* Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #667eea;
        }

        .btn-add-address {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-add-address:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            color: white;
        }

        /* Alerts */
        .alert {
            border-radius: 10px;
            border: none;
            margin-bottom: 20px;
        }

        /* Address Cards */
        .address-grid {
            display: grid;
            gap: 20px;
        }

        .address-card {
            background: linear-gradient(135deg, #f6f8fb 0%, #ffffff 100%);
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            padding: 25px;
            position: relative;
            transition: all 0.3s ease;
        }

        .address-card:hover {
            border-color: #667eea;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.2);
        }

        .address-card.default {
            border-color: #48bb78;
            background: linear-gradient(135deg, #f0fff4 0%, #ffffff 100%);
        }

        .default-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .address-content {
            padding-right: 120px;
        }

        .address-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .address-phone {
            color: #4a5568;
            font-size: 0.95rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .address-phone i {
            color: #667eea;
        }

        .address-detail {
            color: #718096;
            font-size: 0.9rem;
            line-height: 1.6;
            margin-top: 10px;
            padding-left: 24px;
        }

        /* Action Buttons */
        .address-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }

        .btn-action {
            flex: 1;
            padding: 10px 15px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            text-decoration: none;
        }

        .btn-edit {
            background-color: #edf2f7;
            color: #4a5568;
        }

        .btn-edit:hover {
            background-color: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .btn-delete {
            background-color: #fff5f5;
            color: #e53e3e;
        }

        .btn-delete:hover {
            background-color: #e53e3e;
            color: white;
            transform: translateY(-2px);
        }

        .btn-set-default {
            background-color: #f0fff4;
            color: #38a169;
        }

        .btn-set-default:hover {
            background-color: #38a169;
            color: white;
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state i {
            font-size: 5rem;
            color: #cbd5e0;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            color: #4a5568;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #718096;
            margin-bottom: 30px;
        }

        /* Address Count */
        .address-count {
            color: #718096;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .page-title {
                font-size: 1.5rem;
            }

            .address-content {
                padding-right: 0;
            }

            .default-badge {
                position: static;
                display: inline-flex;
                margin-bottom: 15px;
            }

            .address-actions {
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
                <li class="breadcrumb-item active" aria-current="page">Địa chỉ giao hàng</li>
            </ol>
        </nav>

        <!-- Main Card -->
        <div class="address-main-card">
            <!-- Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-map-marker-alt"></i>
                    Địa Chỉ Giao Hàng
                </h1>
                <a href="${pageContext.request.contextPath}/user/address?action=add" class="btn-add-address">
                    <i class="fas fa-plus-circle"></i>
                    Thêm Địa Chỉ Mới
                </a>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Address Count -->
            <c:if test="${addressCount > 0}">
                <p class="address-count">
                    <i class="fas fa-info-circle me-1"></i>
                    Bạn có <strong>${addressCount}</strong> địa chỉ đã lưu
                </p>
            </c:if>

            <!-- Address List -->
            <c:choose>
                <c:when test="${not empty addresses}">
                    <div class="address-grid">
                        <c:forEach var="address" items="${addresses}">
                            <div class="address-card ${address.laMacDinh ? 'default' : ''}">
                                <!-- Default Badge -->
                                <c:if test="${address.laMacDinh}">
                                    <span class="default-badge">
                                        <i class="fas fa-star"></i>
                                        Mặc định
                                    </span>
                                </c:if>

                                <!-- Address Content -->
                                <div class="address-content">
                                    <h3 class="address-name">${address.tenNguoiNhan}</h3>
                                    <div class="address-phone">
                                        <i class="fas fa-phone"></i>
                                        <span>${address.soDienThoai}</span>
                                    </div>
                                    <div class="address-detail">
                                        <i class="fas fa-map-marker-alt me-2"></i>
                                        ${address.diaChiCuThe}, ${address.phuong}, ${address.quan}, ${address.thanhPho}
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div class="address-actions">
                                    <a href="${pageContext.request.contextPath}/user/address?action=edit&id=${address.maDC}" 
                                       class="btn-action btn-edit">
                                        <i class="fas fa-edit"></i>
                                        Chỉnh sửa
                                    </a>

                                    <c:if test="${!address.laMacDinh}">
                                        <a href="${pageContext.request.contextPath}/user/address?action=setDefault&id=${address.maDC}" 
                                           class="btn-action btn-set-default"
                                           onclick="return confirm('Đặt địa chỉ này làm mặc định?')">
                                            <i class="fas fa-star"></i>
                                            Đặt mặc định
                                        </a>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/user/address?action=delete&id=${address.maDC}" 
                                       class="btn-action btn-delete"
                                       onclick="return confirm('Bạn có chắc muốn xóa địa chỉ này?')">
                                        <i class="fas fa-trash-alt"></i>
                                        Xóa
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="empty-state">
                        <i class="fas fa-map-marked-alt"></i>
                        <h3>Chưa có địa chỉ giao hàng</h3>
                        <p>Thêm địa chỉ giao hàng để thuận tiện cho việc đặt hàng</p>
                        <a href="${pageContext.request.contextPath}/user/address?action=add" class="btn-add-address">
                            <i class="fas fa-plus-circle"></i>
                            Thêm Địa Chỉ Đầu Tiên
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>
