<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
</head>
<body>
    <div class="container-fluid">
        <h2>Cài đặt Cửa hàng - ${store.tenCH}</h2>

        <c:if test="${not empty param.msg}"><div class="alert alert-success">${param.msg}</div></c:if>
        <c:if test="${not empty param.error}"><div class="alert alert-danger">${param.error}</div></c:if>

        <form method="POST" action="${pageContext.request.contextPath}/vendor/store">
            <input type="hidden" name="action" value="updateStoreInfo">
            
            <div class="mb-3">
                <label for="tenCH" class="form-label">Tên Cửa hàng</label>
                <input type="text" class="form-control" id="tenCH" name="tenCH" value="${store.tenCH}" required>
            </div>
            
            <div class="mb-3">
                <label for="moTa" class="form-label">Mô tả</label>
                <textarea class="form-control" id="moTa" name="moTa" rows="3">${store.moTa}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="diaChi" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="diaChi" name="diaChi" value="${store.diaChi}">
            </div>
            
            <div class="mb-3">
                <label for="soDienThoai" class="form-label">Số điện thoại</label>
                <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" value="${store.soDienThoai}">
            </div>
            
            <button type="submit" class="btn btn-primary">Cập nhật thông tin</button>
        </form>
    </div>
</body>
</html>