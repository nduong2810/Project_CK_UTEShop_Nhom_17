<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f4f7fc;
        }
        .supplier-card {
            background: white;
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.07);
            transition: all 0.3s ease-in-out;
            position: relative;
            overflow: hidden;
        }
        .supplier-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
        }
        .rank-badge {
            position: absolute;
            top: -10px;
            left: 20px;
            background: linear-gradient(135deg, #ff5722, #ff9800);
            color: white;
            width: 50px;
            height: 70px;
            clip-path: polygon(0 0, 100% 0, 100% 100%, 50% 80%, 0 100%);
            display: flex;
            align-items: center;
            justify-content: flex-start;
            flex-direction: column;
            padding-top: 10px;
            font-weight: bold;
            font-size: 1.2rem;
        }
        .supplier-card-body {
            padding: 2rem;
            padding-top: 3rem;
        }
        .supplier-name {
            font-weight: 700;
            color: #333;
            margin-bottom: 0.5rem;
        }
        .supplier-description {
            color: #666;
            font-size: 0.95rem;
            min-height: 70px;
        }
        .btn-view-products {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            color: white;
            border-radius: 50px;
            padding: 0.7rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-view-products:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
    </style>
</head>
<body>

<div class="container my-5">
    <div class="text-center mb-5">
        <h1 class="display-4 fw-bold">Nhà Cung Cấp Nổi Bật</h1>
        <p class="lead text-muted">Vinh danh những đối tác hàng đầu có tổng số sản phẩm bán ra nhiều nhất trên UTESHOP.</p>
    </div>

    <c:choose>
        <c:when test="${not empty suppliers}">
            <div class="row g-4">
                <c:forEach var="supplier" items="${suppliers}" varStatus="status">
                    <div class="col-lg-4 col-md-6">
                        <div class="supplier-card">
                            <div class="rank-badge">#${status.count}</div>
                            <div class="supplier-card-body">
                                <h4 class="supplier-name">${supplier.tenCH}</h4>
                                <p class="supplier-description">
                                    <c:choose>
                                        <c:when test="${not empty supplier.moTa}">${supplier.moTa}</c:when>
                                        <c:otherwise>Nhà cung cấp uy tín với nhiều sản phẩm chất lượng.</c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="d-flex align-items-center text-muted mb-3">
                                    <i class="fas fa-map-marker-alt me-2"></i>
                                    <span>${not empty supplier.diaChi ? supplier.diaChi : 'Việt Nam'}</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/guest/supplier/detail?id=${supplier.maCH}" class="btn btn-view-products">
                                    <i class="fas fa-store me-2"></i>Xem cửa hàng
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="fas fa-store-slash fa-4x text-muted mb-4"></i>
                <h3 class="text-muted">Chưa có dữ liệu</h3>
                <p class="text-muted">Hiện tại chưa có nhà cung cấp nổi bật nào. Vui lòng quay lại sau.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>