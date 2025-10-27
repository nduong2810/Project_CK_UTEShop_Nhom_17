<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa hồ sơ cá nhân - UTESHOP</title>
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

        .edit-card {
            max-width: 850px;
            margin: 40px auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .edit-header {
            background: linear-gradient(135deg, #0d6efd, #6610f2);
            color: white;
            padding: 18px 40px;
            font-weight: 600;
            font-size: 18px;
            border-top-left-radius: 18px;
            border-top-right-radius: 18px;
        }

        /* Avatar chỉnh giữa */
        .avatar-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 35px;
            margin-bottom: 10px;
        }

        .avatar-preview {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            border: 5px solid #fff;
            box-shadow: 0 0 0 4px #0d6efd;
            object-fit: cover;
            background: #fff;
        }

        .avatar-input {
            width: 60%;
            margin-top: 15px;
        }

        .form-section {
            padding: 40px 50px 50px;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
        }

        .btn-save {
            background: linear-gradient(135deg, #0d6efd, #4c8bfd);
            color: white;
            padding: 10px 28px;
            border-radius: 10px;
            border: none;
            font-weight: 500;
            font-size: 15px;
        }

        .btn-save:hover {
            background: linear-gradient(135deg, #0b5ed7, #377cfb);
        }

        .btn-cancel {
            background: #6c757d;
            color: white;
            padding: 10px 28px;
            border-radius: 10px;
            border: none;
            font-weight: 500;
            font-size: 15px;
        }

        .btn-cancel:hover {
            background: #5c636a;
        }
    </style>
</head>

<body>
<div class="container mt-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/profile">Hồ sơ cá nhân</a></li>
            <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa hồ sơ</li>
        </ol>
    </nav>

    <!-- Edit Card -->
    <div class="edit-card">
        <div class="edit-header">
            <i class="bi bi-person-lines-fill me-2"></i>Chỉnh sửa hồ sơ cá nhân
        </div>

        <form method="post" enctype="multipart/form-data">
            <div class="avatar-wrapper">
                <img id="avatarPreview" class="avatar-preview"
                     src="${pageContext.request.contextPath}/assets/avatar/${user.avatar}" alt="Avatar">
                <div class="avatar-input">
                    <input type="file" name="avatar" id="avatarInput" class="form-control" accept="image/*"
                           onchange="previewImage(event)">
                </div>
            </div>

            <div class="form-section">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" name="hoTen" value="${user.hoTen}" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" value="${user.email}" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" name="soDienThoai" value="${user.soDienThoai}">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Giới tính</label>
                        <select class="form-select" name="gioiTinh" required>
                            <option value="Nam" <c:if test="${user.gioiTinh == 'Nam'}">selected</c:if>>Nam</option>
                            <option value="Nữ" <c:if test="${user.gioiTinh == 'Nữ'}">selected</c:if>>Nữ</option>
                            <option value="Khác" <c:if test="${user.gioiTinh == 'Khác'}">selected</c:if>>Khác</option>
                        </select>
                    </div>

                    <div class="col-12">
                        <label class="form-label">Địa chỉ</label>
                        <textarea class="form-control" name="diaChi" rows="2">${user.diaChi}</textarea>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn-save me-2">
                        <i class="bi bi-check-circle"></i> Lưu thay đổi
                    </button>
                    <a href="${pageContext.request.contextPath}/user/profile" class="btn-cancel">
                        <i class="bi bi-x-circle"></i> Hủy
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function(){
            document.getElementById('avatarPreview').src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>

</body>
</html>
