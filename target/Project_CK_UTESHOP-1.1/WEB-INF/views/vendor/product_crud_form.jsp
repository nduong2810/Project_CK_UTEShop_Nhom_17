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
        <h2 class="text-primary">${pageTitle}</h2>
        <p class="text-muted">Quản lý sản phẩm của <span class="fw-bold">${store.tenCH}</span></p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success">${param.msg}</div>
        </c:if>


        <form method="POST" action="${pageContext.request.contextPath}/vendor/product-crud" enctype="multipart/form-data">
            
            <input type="hidden" name="maSP" value="${product.maSP}">
            
            <div class="mb-3">
                <label for="tenSP" class="form-label">Tên Sản phẩm (*)</label>
                <input type="text" class="form-control" id="tenSP" name="tenSP" value="${product.tenSP}" required>
            </div>
            
            <!-- THÊM LOGIC LỰA CHỌN DANH MỤC -->
            <div class="mb-3">
                <label for="maDM" class="form-label">Danh mục (*)</label>
                <select class="form-select" id="maDM" name="maDM" required>
                    <option value="" disabled <c:if test="${empty product.danhMuc}">selected</c:if>>-- Chọn Danh mục --</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.maDM}" 
                                <c:if test="${not empty product.danhMuc && product.danhMuc.maDM == category.maDM}">selected</c:if>
                        >
                            ${category.tenDM}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="gia" class="form-label">Giá (VND) (*)</label>
                    <input type="number" class="form-control" id="gia" name="gia" value="${product.donGia}" min="1000" step="1000" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="soLuong" class="form-label">Số lượng tồn kho (*)</label>
                    <input type="number" class="form-control" id="soLuong" name="soLuong" value="${product.soLuongTon}" min="0" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="moTa" class="form-label">Mô tả sản phẩm</label>
                <textarea class="form-control" id="moTa" name="moTa" rows="5">${product.moTa}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="anhMinhHoa" class="form-label">Ảnh minh họa</label>
                <input type="file" class="form-control" id="anhMinhHoa" name="anhMinhHoa" accept="image/*" 
                       <c:if test="${empty product.maSP}">required</c:if>>
                
                <c:if test="${not empty product.hinhAnh}">
                    <p class="mt-2 text-muted">Ảnh hiện tại:</p>
                    <img src="${pageContext.request.contextPath}/${product.hinhAnh}" alt="Ảnh sản phẩm" class="img-thumbnail" style="max-width: 150px; height: auto;">
                    <input type="hidden" name="currentImage" value="${product.hinhAnh}">
                </c:if>
            </div>

            <button type="submit" class="btn btn-primary me-2">
                <c:choose>
                    <c:when test="${not empty product.maSP}">Cập nhật Sản phẩm</c:when>
                    <c:otherwise>Thêm Sản phẩm</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
