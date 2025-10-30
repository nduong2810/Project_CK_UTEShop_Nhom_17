<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Gửi khiếu nại cửa hàng - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(180deg, #f3f6ff 0%, #eef1f7 100%);
            font-family: "Inter", "Segoe UI", sans-serif;
        }
        .form-card {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            padding: 40px;
        }
        .form-label {
            font-weight: 600;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container mt-4 mb-5">
        <div class="form-card">
            <div class="mb-4">
                <h2><i class="bi bi-flag"></i> Gửi khiếu nại cửa hàng</h2>
                <p class="text-muted">Vui lòng mô tả chi tiết vấn đề bạn gặp phải với cửa hàng</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/user/shop-complaints">
                <input type="hidden" name="action" value="create">

                <div class="mb-3">
                    <label for="shopId" class="form-label">Cửa hàng <span class="text-danger">*</span></label>
                    <select class="form-select" id="shopId" name="shopId" required>
                        <option value="">-- Chọn cửa hàng --</option>
                        <c:forEach var="shop" items="${shops}">
                            <option value="${shop.maCH}" ${shop.maCH == shopId ? 'selected' : ''}>
                                ${shop.tenCH}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="title" name="title" 
                           placeholder="Nhập tiêu đề khiếu nại..." 
                           value="${title}" required maxlength="255">
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">Nội dung <span class="text-danger">*</span></label>
                    <textarea class="form-control" id="content" name="content" rows="8" 
                              placeholder="Mô tả chi tiết vấn đề bạn gặp phải..." 
                              required maxlength="2000">${content}</textarea>
                    <div class="form-text">Tối đa 2000 ký tự</div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send"></i> Gửi khiếu nại
                    </button>
                    <a href="${pageContext.request.contextPath}/user/shop-complaints" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
