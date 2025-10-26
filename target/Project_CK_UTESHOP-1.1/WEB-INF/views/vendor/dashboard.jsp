<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
</head>
<body>
<div class="container-fluid">
    <h2>Dashboard - ${store.tenCH}</h2>
    <p>Xin chào, ${user.hoTen} (${user.vaiTro})</p>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title">Doanh thu tháng (Đã giao)</h5>
                    <p class="card-text h3">
                        <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencyCode="VND" />
                    </p>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title">Đơn hàng mới (Chờ xác nhận)</h5>
                    <p class="card-text h3">${newOrdersCount}</p>
                    <a href="${pageContext.request.contextPath}/vendor/orders" class="text-white">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title">Tổng số sản phẩm</h5>
                    <p class="card-text h3">${totalProducts}</p>
                    <a href="${pageContext.request.contextPath}/vendor/products" class="text-white">Quản lý</a>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <h3>Đơn hàng chờ xử lý</h3>
            <p>Tổng cộng có ${newOrdersCount} đơn hàng cần xác nhận.</p>
        </div>
    </div>
</div>
</body>
</html>