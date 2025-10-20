<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="container my-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
            <li class="breadcrumb-item active">Sản phẩm</li>
        </ol>
    </nav>

    <h1>Danh sách sản phẩm</h1>

    <div class="row">
        <c:if test="${empty productList}">
            <p>Không có sản phẩm nào để hiển thị.</p>
        </c:if>
        <c:forEach var="product" items="${productList}">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <a href="${pageContext.request.contextPath}/guest/product?id=${product.maSP}">
                        <img src="${pageContext.request.contextPath}/assets/img/${product.hinhAnh}" class="card-img-top" alt="${product.tenSP}" onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png'">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><a href="${pageContext.request.contextPath}/guest/product?id=${product.maSP}">${product.tenSP}</a></h5>
                        <p class="card-text"><fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></p>
                        <a href="${pageContext.request.contextPath}/guest/product?id=${product.maSP}" class="btn btn-primary">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
