<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Danh sách sản phẩm - UTESHOP</title>
</head>
<body>
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
</body>
