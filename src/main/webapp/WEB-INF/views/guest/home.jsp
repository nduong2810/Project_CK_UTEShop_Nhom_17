<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<decorator:title>Trang chủ - UTESHOP</decorator:title>

<!-- Banner -->
<div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="${pageContext.request.contextPath}/assets/img/banner1.jpg" class="d-block w-100">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/assets/img/banner2.jpg" class="d-block w-100">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/assets/img/banner3.jpg" class="d-block w-100">
        </div>
    </div>
</div>

<div class="container py-5">
    <h3 class="text-center fw-bold text-primary mb-4">
        <i class="fa-solid fa-fire"></i> Top 10 sản phẩm Hot nhất
    </h3>

    <div class="row g-4">
        <c:if test="${empty top10}">
            <div class="text-center">
                <img src="${pageContext.request.contextPath}/assets/img/out-of-stock.png" width="300">
                <p class="mt-3 text-danger fw-bold">Không có dữ liệu</p>
            </div>
        </c:if>

        <c:forEach var="sp" items="${top10}">
            <div class="col-md-3 col-sm-6">
                <div class="card shadow-sm border-0">
                    <img src="${pageContext.request.contextPath}/assets/img/${sp.hinhAnh}" class="card-img-top" style="height:200px;object-fit:contain;">
                    <div class="card-body text-center">
                        <h6 class="fw-bold">${sp.tenSP}</h6>
                        <p class="text-muted">${sp.moTa}</p>
                        <p class="text-danger fw-bold">${sp.donGia} ₫</p>
                        <small>Đã bán: ${sp.soLuongBan}</small>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
