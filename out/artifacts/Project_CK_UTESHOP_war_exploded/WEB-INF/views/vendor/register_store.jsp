<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký Cửa hàng</title>
    </head>
<body>
    <div class="container">
        <h1>Đăng ký Cửa hàng (Vendor)</h1>
        <p>Vui lòng điền thông tin chi tiết về cửa hàng của bạn để bắt đầu bán hàng.</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form method="POST" action="${pageContext.request.contextPath}/vendor/register-store">
            
            <div class="mb-3">
                <label for="tenCH" class="form-label">Tên Cửa hàng (*)</label>
                <input type="text" class="form-control" id="tenCH" name="tenCH" required>
            </div>
            
            <div class="mb-3">
                <label for="moTa" class="form-label">Mô tả Cửa hàng</label>
                <textarea class="form-control" id="moTa" name="moTa" rows="3"></textarea>
            </div>
            
            <div class="mb-3">
                <label for="diaChi" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="diaChi" name="diaChi">
            </div>
            
            <div class="mb-3">
                <label for="soDienThoai" class="form-label">Số điện thoại liên hệ (*)</label>
                <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Hoàn tất Đăng ký</button>
        </form>
        
    </div>
</body>
</html>