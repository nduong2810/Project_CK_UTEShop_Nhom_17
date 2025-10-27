<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid p-4">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-box"></i> ${pageTitle} - ${store.tenCH}</h2>
            <a href="${pageContext.request.contextPath}/vendor/product-crud" class="btn btn-success">
                <i class="fas fa-plus"></i> Thêm Sản phẩm mới
            </a>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Tổng sản phẩm</h6>
                                <h4>${totalProducts}</h4>
                            </div>
                            <i class="fas fa-boxes fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Đang bán</h6>
                                <h4>${activeProductsCount}</h4>
                            </div>
                            <i class="fas fa-check-circle fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Tạm ẩn</h6>
                                <h4>${inactiveProductsCount}</h4>
                            </div>
                            <i class="fas fa-eye-slash fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="card-title">Trang hiện tại</h6>
                                <h4>${currentPage}/${totalPages}</h4>
                            </div>
                            <i class="fas fa-file-alt fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search and Filter Form -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-search"></i> Tìm kiếm và Lọc</h5>
            </div>
            <div class="card-body">
                <form method="GET" action="${pageContext.request.contextPath}/vendor/products">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="search" class="form-label">Từ khóa:</label>
                            <input type="text" class="form-control" id="search" name="search" 
                                   value="${searchKeyword}" placeholder="Tìm theo tên hoặc mô tả...">
                        </div>
                        <div class="col-md-3">
                            <label for="status" class="form-label">Trạng thái:</label>
                            <select class="form-select" id="status" name="status">
                                <option value="">Tất cả</option>
                                <option value="true" ${statusFilter == 'true' ? 'selected' : ''}>Đang bán</option>
                                <option value="false" ${statusFilter == 'false' ? 'selected' : ''}>Tạm ẩn</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="sort" class="form-label">Sắp xếp:</label>
                            <select class="form-select" id="sort" name="sort">
                                <option value="">Mới nhất</option>
                                <option value="name-asc" ${sortBy == 'name-asc' ? 'selected' : ''}>Tên A-Z</option>
                                <option value="name-desc" ${sortBy == 'name-desc' ? 'selected' : ''}>Tên Z-A</option>
                                <option value="price-asc" ${sortBy == 'price-asc' ? 'selected' : ''}>Giá thấp đến cao</option>
                                <option value="price-desc" ${sortBy == 'price-desc' ? 'selected' : ''}>Giá cao đến thấp</option>
                                <option value="stock-asc" ${sortBy == 'stock-asc' ? 'selected' : ''}>Tồn kho ít nhất</option>
                                <option value="stock-desc" ${sortBy == 'stock-desc' ? 'selected' : ''}>Tồn kho nhiều nhất</option>
                            </select>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary me-2">
                                <i class="fas fa-search"></i> Tìm
                            </button>
                            <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Xóa
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Error/Success Messages -->
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${param.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Products Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5><i class="fas fa-table"></i> Danh sách Sản phẩm</h5>
                <small class="text-muted">Hiển thị ${(currentPage-1)*pageSize + 1} - ${currentPage*pageSize > totalProducts ? totalProducts : currentPage*pageSize} trong tổng số ${totalProducts} sản phẩm</small>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th width="8%">Mã SP</th>
                                        <th width="25%">Tên sản phẩm</th>
                                        <th width="15%">Danh mục</th>
                                        <th width="12%">Giá</th>
                                        <th width="10%">Tồn kho</th>
                                        <th width="10%">Trạng thái</th>
                                        <th width="10%">Ngày tạo</th>
                                        <th width="10%">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}" varStatus="status">
                                        <tr>
                                            <td><strong>#${product.maSP}</strong></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:if test="${not empty product.hinhAnh}">
                                                        <img src="${pageContext.request.contextPath}/assets/img/${product.hinhAnh}" 
                                                             alt="Product Image" class="me-2" style="width: 40px; height: 40px; object-fit: cover;">
                                                    </c:if>
                                                    <div>
                                                        <div class="fw-bold">${product.tenSP}</div>
                                                        <c:if test="${not empty product.moTa}">
                                                            <small class="text-muted">${product.moTa.length() > 50 ? product.moTa.substring(0,50).concat('...') : product.moTa}</small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty product.danhMuc}">
                                                        <span class="badge bg-secondary">${product.danhMuc.tenDM}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Chưa phân loại</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${product.donGia}" type="currency" currencyCode="VND" />
                                            </td>
                                            <td>
                                                <span class="badge ${product.soLuongTon > 10 ? 'bg-success' : product.soLuongTon > 0 ? 'bg-warning' : 'bg-danger'}">
                                                    ${product.soLuongTon}
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.trangThai == true}">
                                                        <span class="badge bg-success"><i class="fas fa-check"></i> Đang bán</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary"><i class="fas fa-eye-slash"></i> Tạm ẩn</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${product.ngayTao}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/vendor/product-crud?id=${product.maSP}" 
                                                       class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="confirmDelete(${product.maSP}, '${product.tenSP}')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Product pagination">
                                <ul class="pagination justify-content-center">
                                    <!-- Previous button -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage - 1}&search=${searchKeyword}&sort=${sortBy}&status=${statusFilter}">
                                            <i class="fas fa-chevron-left"></i> Trước
                                        </a>
                                    </li>
                                    
                                    <!-- Page numbers -->
                                    <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}" />
                                    <c:set var="endPage" value="${startPage + 4 > totalPages ? totalPages : startPage + 4}" />
                                    
                                    <c:if test="${startPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=1&search=${searchKeyword}&sort=${sortBy}&status=${statusFilter}">1</a>
                                        </li>
                                        <c:if test="${startPage > 2}">
                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                        </c:if>
                                    </c:if>
                                    
                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&search=${searchKeyword}&sort=${sortBy}&status=${statusFilter}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${endPage < totalPages}">
                                        <c:if test="${endPage < totalPages - 1}">
                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                        </c:if>
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${totalPages}&search=${searchKeyword}&sort=${sortBy}&status=${statusFilter}">${totalPages}</a>
                                        </li>
                                    </c:if>
                                    
                                    <!-- Next button -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage + 1}&search=${searchKeyword}&sort=${sortBy}&status=${statusFilter}">
                                            Sau <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">Không có sản phẩm nào</h5>
                            <p class="text-muted">
                                <c:choose>
                                    <c:when test="${not empty searchKeyword or not empty statusFilter}">
                                        Không tìm thấy sản phẩm phù hợp với tiêu chí tìm kiếm.
                                    </c:when>
                                    <c:otherwise>
                                        Cửa hàng chưa có sản phẩm nào. Hãy thêm sản phẩm mới!
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="${pageContext.request.contextPath}/vendor/product-crud" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Thêm sản phẩm đầu tiên
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">
                        <i class="fas fa-exclamation-triangle text-warning"></i> Xác nhận xóa
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa sản phẩm <strong id="productName"></strong>?</p>
                    <p class="text-danger"><i class="fas fa-exclamation-circle"></i> Hành động này không thể hoàn tác!</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <form id="deleteForm" method="POST" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="productId">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Xóa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(productId, productName) {
            document.getElementById('productId').value = productId;
            document.getElementById('productName').textContent = productName;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
        
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>