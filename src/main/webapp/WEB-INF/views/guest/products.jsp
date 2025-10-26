<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid py-4">
        <h2 class="text-primary">${pageTitle}</h2>
        <p class="text-muted">Quản lý sản phẩm của <span class="fw-bold">${store.tenCH}</span></p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <a href="${pageContext.request.contextPath}/vendor/product-crud" class="btn btn-primary mb-3">Thêm Sản phẩm</a>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>MaSP</th>
                    <th>Tên Sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng tồn</th>
                    <th>Danh mục</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.maSP}</td>
                        <td>${product.tenSP}</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.donGia != null}">
                                    <fmt:formatNumber value="${product.donGia}" type="currency" currencyCode="VND" />
                                </c:when>
                                <c:otherwise>Chưa có giá</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            ${product.soLuongTon != null ? product.soLuongTon : 0}
                        </td>
                        <td>
                            ${product.danhMuc != null ? product.danhMuc.tenDM : 'Chưa có danh mục'}
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/vendor/product-crud?id=${product.maSP}" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="${pageContext.request.contextPath}/vendor/products?action=delete&id=${product.maSP}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>