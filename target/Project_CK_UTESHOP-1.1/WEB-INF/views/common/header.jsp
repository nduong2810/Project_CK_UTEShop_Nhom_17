<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #002b5b;">
    <div class="container py-2">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/guest/home">
            <img src="${pageContext.request.contextPath}/assets/img/logo-hcmute.png" width="50" class="me-2">
            <span class="fw-bold text-white">UTESHOP</span>
        </a>

        <form class="d-flex mx-auto w-50" role="search">
            <input class="form-control me-2" type="search" placeholder="Nhập sản phẩm cần tìm..." aria-label="Search">
            <button class="btn btn-outline-light" type="submit"><i class="fa fa-search"></i></button>
        </form>

        <div class="d-flex">
            <a href="${pageContext.request.contextPath}/WEB-INF/views/guest/login.jsp" class="btn btn-outline-light btn-sm me-2">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/WEB-INF/views/guest/register.jsp" class="btn btn-warning btn-sm">Đăng ký</a>
        </div>
    </div>
</nav>
