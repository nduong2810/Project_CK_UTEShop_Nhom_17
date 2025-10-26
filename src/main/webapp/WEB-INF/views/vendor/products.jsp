<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
</head>
<body>
    <div class="container-fluid">
        <h2>${pageTitle} - ${store.tenCH}</h2>
        
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/vendor/product-crud" class="btn btn-success">
                + Thêm Sản phẩm mới
            </a>
        </div>
        
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Mã SP</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.maSP}</td>
                        <td>${product.tenSP}</td>
                        <td><fmt:formatNumber value="${product.gia}" type="currency" currencyCode="VND" /></td>
                        <td>${product.soLuong}</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.trangThai == true}">
                                    <span class="badge bg-success">Đang bán</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Tạm ẩn</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/vendor/product-crud?id=${product.maSP}" class="btn btn-sm btn-info">Sửa</a>
                            <button type="button" class="btn btn-sm btn-danger">Xóa</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${empty products}">
            <p>Cửa hàng chưa có sản phẩm nào. Hãy thêm sản phẩm mới!</p>
        </c:if>
    </div>
</body>
</html>