<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(180deg, #f3f6ff 0%, #eef1f7 100%);
            font-family: "Inter", "Segoe UI", sans-serif;
        }

        .breadcrumb {
            background: none;
            font-size: 15px;
            margin-top: 25px;
        }

        .profile-card {
            max-width: 850px;
            margin: 40px auto;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 6px 25px rgba(0,0,0,0.08);
            padding: 50px 60px;
            text-align: center;
        }

        .avatar-wrapper {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .avatar {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 5px solid #fff;
            box-shadow: 0 0 0 4px #0d6efd;
            object-fit: cover;
            background: #fff;
        }

        .profile-name {
            font-size: 24px;
            font-weight: 700;
            margin-top: 15px;
            color: #212529;
        }

        .divider {
            width: 50px;
            height: 3px;
            background: #0d6efd;
            margin: 10px auto;
            border-radius: 2px;
        }

        .role-badge {
            background: #e7f1ff;
            color: #0d6efd;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 14px;
        }

        .info-section {
            margin-top: 35px;
            text-align: left;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px dashed #dee2e6;
            padding: 10px 0;
            flex-wrap: wrap;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            width: 45%;
        }

        .info-value {
            width: 55%;
            color: #212529;
            word-break: break-word;
        }

        .status-active {
            color: #20c997;
            font-weight: 600;
        }

        .btn-action {
            padding: 10px 28px;
            border-radius: 10px;
            font-weight: 500;
            font-size: 15px;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: linear-gradient(135deg, #0d6efd, #4c8bfd);
            color: white;
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, #0b5ed7, #377cfb);
        }

        .btn-change {
            background: linear-gradient(135deg, #dc3545, #f65a6d);
            color: white;
        }

        .btn-change:hover {
            background: linear-gradient(135deg, #bb2d3b, #e6475d);
        }

        .action-buttons {
            text-align: center;
            margin-top: 40px;
        }
    </style>
</head>

<body>
<div class="container mt-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
        </ol>
    </nav>

    <div class="profile-card">
        <div class="avatar-wrapper">
            <img src="${pageContext.request.contextPath}/assets/avatar/${user.avatar}" class="avatar" alt="Avatar">
        </div>

        <div class="profile-name">${user.hoTen}</div>
        <div class="divider"></div>
        <div><span class="role-badge">Vai trò: ${user.vaiTro}</span></div>

        <div class="info-section mt-4">
            <div class="info-row">
                <div class="info-label">Tên đăng nhập:</div>
                <div class="info-value">${user.tenDangNhap}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Email:</div>
                <div class="info-value">${user.email}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Số điện thoại:</div>
                <div class="info-value">${user.soDienThoai}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Giới tính:</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${user.gioiTinh == 'Nam'}">Nam</c:when>
                        <c:when test="${user.gioiTinh == 'Nữ'}">Nữ</c:when>
                        <c:when test="${user.gioiTinh == 'Khác'}">Khác</c:when>
                        <c:otherwise>Chưa xác định</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">Địa chỉ:</div>
                <div class="info-value">${user.diaChi}</div>
            </div>

            <div class="info-row">
                <div class="info-label">Ngày tạo:</div>
                <div class="info-value"><fmt:formatDate value="${user.ngayTao}" pattern="dd/MM/yyyy HH:mm:ss "/></div>
            </div>
            <div class="info-row">
                <div class="info-label">Ngày cập nhật:</div>
                <div class="info-value"><fmt:formatDate value="${user.ngayCapNhat}" pattern="dd/MM/yyyy HH:mm:ss "/></div>
            </div>
            <div class="info-row">
                <div class="info-label">Trạng thái:</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${user.trangThai}">
                            <span class="status-active">Đang hoạt động</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger">Bị khóa</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/user/edit-profile" class="btn-action btn-edit me-2">
                <i class="bi bi-pencil-square"></i> Chỉnh sửa hồ sơ
            </a>
            <a href="${pageContext.request.contextPath}/user/change-password" class="btn-action btn-change">
                <i class="bi bi-key-fill"></i> Đổi mật khẩu
            </a>
        </div>
    </div>
</div>
</body>
</html>
