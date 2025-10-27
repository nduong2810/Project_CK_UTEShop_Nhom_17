<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<%-- Tạo biến now để so sánh thời gian --%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - UTESHOP Vendor</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts for Vietnamese -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        /* Base font styling for Vietnamese */
        * {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        /* Enhanced styling for Vietnamese text display */
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-weight: 600;
            color: #2d3748;
            text-rendering: optimizeLegibility;
        }
        
        /* Specific styling for discount program name */
        .discount-program-name {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
            font-weight: 600 !important;
            font-size: 1.1rem !important;
            color: #2d3748 !important;
            line-height: 1.4 !important;
            word-break: break-word;
            text-rendering: optimizeLegibility;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        .discount-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        
        .discount-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .discount-code {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 8px 15px;
            border-radius: 25px;
            font-weight: bold;
            font-size: 1.1rem;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .discount-type {
            background: #f8f9fa;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.85rem;
            color: #666;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-expired {
            background: #fff3cd;
            color: #856404;
        }
        
        .btn-create {
            background: linear-gradient(45deg, #11998e, #38ef7d);
            border: none;
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.4);
            color: white;
        }
        
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .usage-progress {
            background: rgba(255,255,255,0.2);
            height: 6px;
            border-radius: 3px;
            margin-top: 10px;
        }
        
        .usage-progress-bar {
            background: white;
            height: 100%;
            border-radius: 3px;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="../common/header.jsp" />
    
    <div class="container-fluid py-4">
        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-md-3 col-lg-2">
                <div class="bg-white rounded-3 shadow-sm p-3 mb-4">
                    <h6 class="text-muted mb-3">VENDOR MENU</h6>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/vendor/dashboard" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/products" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-box me-2"></i> Sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/discounts" class="list-group-item list-group-item-action border-0 active">
                            <i class="fas fa-tags me-2"></i> Mã giảm giá
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/orders" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="h3 mb-0">Quản lý Mã giảm giá</h2>
                        <p class="text-muted mb-0">Tạo và quản lý các chương trình khuyến mãi của cửa hàng</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/vendor/discounts/create" class="btn btn-create">
                        <i class="fas fa-plus me-2"></i>Tạo mã giảm giá
                    </a>
                </div>
                
                <!-- Statistics -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="stats-card">
                            <div class="stats-number">${totalDiscounts}</div>
                            <div>Tổng mã giảm giá</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stats-card" style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);">
                            <div class="stats-number">${activeDiscountsCount}</div>
                            <div>Đang hoạt động</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stats-card" style="background: linear-gradient(135deg, #ff9f00 0%, #ff5f00 100%);">
                            <div class="stats-number">${totalDiscounts - activeDiscountsCount}</div>
                            <div>Hết hạn / Tạm dừng</div>
                        </div>
                    </div>
                </div>
                
                <!-- Messages -->
                <c:if test="${param.msg != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <c:choose>
                            <c:when test="${param.msg == 'CREATE_SUCCESS'}">
                                Tạo mã giảm giá thành công.
                            </c:when>
                            <c:when test="${param.msg == 'UPDATE_SUCCESS'}">
                                Cập nhật mã giảm giá thành công.
                            </c:when>
                            <c:when test="${param.msg == 'DELETE_SUCCESS'}">
                                Xóa mã giảm giá thành công.
                            </c:when>
                            <c:otherwise>
                                ${param.msg}
                            </c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <c:choose>
                            <c:when test="${param.error == 'INVALID_ID'}">
                                ID mã giảm giá không hợp lệ.
                            </c:when>
                            <c:when test="${param.error == 'NOT_FOUND'}">
                                Mã giảm giá không tồn tại hoặc không có quyền.
                            </c:when>
                            <c:when test="${param.error == 'DELETE_FAILED'}">
                                Có lỗi xảy ra khi xóa mã giảm giá.
                            </c:when>
                            <c:when test="${param.error == 'DELETE_RESTRICTED'}">
                                <strong>Không thể xóa mã giảm giá!</strong><br>
                                <c:choose>
                                    <c:when test="${not empty param.reason}">
                                        ${param.reason}
                                    </c:when>
                                    <c:otherwise>
                                        Chỉ có thể xóa mã giảm giá khi đã hết hạn hoặc hết lượt sử dụng.
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                ${param.error}
                            </c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Discount List -->
                <div class="bg-white rounded-3 shadow-sm p-4">
                    <c:choose>
                        <c:when test="${empty discounts}">
                            <div class="text-center py-5">
                                <i class="fas fa-tags fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">Chưa có mã giảm giá nào</h5>
                                <p class="text-muted">Tạo mã giảm giá đầu tiên để thu hút khách hàng</p>
                                <a href="${pageContext.request.contextPath}/vendor/discounts/create" class="btn btn-create">
                                    <i class="fas fa-plus me-2"></i>Tạo mã giảm giá
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <c:forEach var="discount" items="${discounts}">
                                    <div class="col-lg-6">
                                        <div class="discount-card">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div class="discount-code">${discount.maSo}</div>
                                                <div class="dropdown">
                                                    <button class="btn btn-link text-muted" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li>
                                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/vendor/discounts/edit?id=${discount.maGG}">
                                                                <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                                            </a>
                                                        </li>
                                                        <li><hr class="dropdown-divider"></li>
                                                        <li>
                                                            <%-- Kiểm tra điều kiện xóa sử dụng scriptlet --%>
                                                            <%
                                                                // Lấy đối tượng discount từ JSTL loop
                                                                com.uteshop.entity.MaGiamGia currentDiscount = (com.uteshop.entity.MaGiamGia) pageContext.findAttribute("discount");
                                                                boolean canDelete = false;
                                                                
                                                                if (currentDiscount != null) {
                                                                    java.time.LocalDateTime currentTime = java.time.LocalDateTime.now();
                                                                    
                                                                    // Kiểm tra hết hạn
                                                                    boolean isExpired = false;
                                                                    if ((currentDiscount.getNgayKetThuc() != null && currentTime.isAfter(currentDiscount.getNgayKetThuc())) ||
                                                                        (currentDiscount.getHanSuDung() != null && currentTime.isAfter(currentDiscount.getHanSuDung()))) {
                                                                        isExpired = true;
                                                                    }
                                                                    
                                                                    // Kiểm tra hết lượt sử dụng
                                                                    boolean isOutOfUses = false;
                                                                    if (currentDiscount.getSoLuongToiDa() != null && 
                                                                        currentDiscount.getSoLuongDaSuDung() >= currentDiscount.getSoLuongToiDa()) {
                                                                        isOutOfUses = true;
                                                                    }
                                                                    
                                                                    // Có thể xóa khi hết hạn HOẶC hết lượt
                                                                    canDelete = isExpired || isOutOfUses;
                                                                }
                                                            %>
                                                            
                                                            <% if (canDelete) { %>
                                                                <button type="button" class="dropdown-item text-danger" onclick="deleteDiscount(${discount.maGG}, '${discount.tenChuongTrinh}')">
                                                                    <i class="fas fa-trash me-2"></i>Xóa
                                                                </button>
                                                            <% } else { %>
                                                                <button type="button" class="dropdown-item text-muted" disabled 
                                                                        title="Chỉ có thể xóa mã giảm giá khi đã hết hạn hoặc hết lượt sử dụng" 
                                                                        onclick="showDeleteRestriction()">
                                                                    <i class="fas fa-trash me-2"></i>Xóa <small>(Không thể xóa)</small>
                                                                </button>
                                                            <% } %>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            
                                            <h6 class="mb-2 discount-program-name">
                                                <c:out value="${discount.tenChuongTrinh}" escapeXml="false"/>
                                            </h6>
                                            
                                            <div class="row mb-3">
                                                <div class="col-6">
                                                    <small class="text-muted">Loại giảm:</small><br>
                                                    <span class="discount-type">
                                                        <c:choose>
                                                            <c:when test="${discount.loaiGiam == 'PERCENT'}">
                                                                <fmt:formatNumber value="${discount.giaTriGiam}" type="number" maxFractionDigits="0"/>%
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${discount.giaTriGiam}" type="currency" currencySymbol="₫"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted">Trạng thái:</small><br>
                                                    <c:choose>
                                                        <c:when test="${discount.trangThai}">
                                                            <span class="status-badge status-active">Hoạt động</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-inactive">Tạm dừng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            
                                            <div class="row mb-3">
                                                <div class="col-6">
                                                    <small class="text-muted">Bắt đầu:</small><br>
                                                    <c:set var="startDate" value="${discount.ngayBatDau}" />
                                                    <c:choose>
                                                        <c:when test="${startDate != null}">
                                                            <c:choose>
                                                                <c:when test="${startDate.dayOfMonth < 10}">0${startDate.dayOfMonth}</c:when>
                                                                <c:otherwise>${startDate.dayOfMonth}</c:otherwise>
                                                            </c:choose>/<c:choose>
                                                                <c:when test="${startDate.monthValue < 10}">0${startDate.monthValue}</c:when>
                                                                <c:otherwise>${startDate.monthValue}</c:otherwise>
                                                            </c:choose>/${startDate.year} 
                                                            <c:choose>
                                                                <c:when test="${startDate.hour < 10}">0${startDate.hour}</c:when>
                                                                <c:otherwise>${startDate.hour}</c:otherwise>
                                                            </c:choose>:<c:choose>
                                                                <c:when test="${startDate.minute < 10}">0${startDate.minute}</c:when>
                                                                <c:otherwise>${startDate.minute}</c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>--</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted">Kết thúc:</small><br>
                                                    <c:set var="endDate" value="${discount.ngayKetThuc}" />
                                                    <c:choose>
                                                        <c:when test="${endDate != null}">
                                                            <c:choose>
                                                                <c:when test="${endDate.dayOfMonth < 10}">0${endDate.dayOfMonth}</c:when>
                                                                <c:otherwise>${endDate.dayOfMonth}</c:otherwise>
                                                            </c:choose>/<c:choose>
                                                                <c:when test="${endDate.monthValue < 10}">0${endDate.monthValue}</c:when>
                                                                <c:otherwise>${endDate.monthValue}</c:otherwise>
                                                            </c:choose>/${endDate.year} 
                                                            <c:choose>
                                                                <c:when test="${endDate.hour < 10}">0${endDate.hour}</c:when>
                                                                <c:otherwise>${endDate.hour}</c:otherwise>
                                                            </c:choose>:<c:choose>
                                                                <c:when test="${endDate.minute < 10}">0${endDate.minute}</c:when>
                                                                <c:otherwise>${endDate.minute}</c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>--</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            
                                            <c:if test="${discount.soLuongToiDa != null}">
                                                <div class="mb-2">
                                                    <small class="text-muted">
                                                        Đã sử dụng: ${discount.soLuongDaSuDung}/${discount.soLuongToiDa}
                                                    </small>
                                                    <div class="usage-progress">
                                                        <div class="usage-progress-bar" 
                                                             style="width: ${(discount.soLuongDaSuDung * 100) / discount.soLuongToiDa}%"></div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty discount.moTa}">
                                                <small class="text-muted">${discount.moTa}</small>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Phân trang mã giảm giá" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage - 1}">Trước</a>
                                            </li>
                                        </c:if>
                                        
                                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                            <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${pageNum}">${pageNum}</a>
                                            </li>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage + 1}">Sau</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="../common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function deleteDiscount(discountId, tenChuongTrinh) {
            // Xác nhận xóa với thông tin chi tiết
            let confirmMessage = 'Bạn có chắc chắn muốn xóa mã giảm giá "' + tenChuongTrinh + '"?\n\n';
            confirmMessage += 'Hành động này không thể hoàn tác.\n';
            confirmMessage += 'Chỉ có thể xóa khi mã giảm giá đã hết hạn hoặc hết lượt sử dụng.';

            if (confirm(confirmMessage)) {
                // Tạo form và submit
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/vendor/discounts';
                
                // Thêm các input hidden
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteDiscount';
                form.appendChild(actionInput);
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = discountId;
                form.appendChild(idInput);
                
                // Thêm form vào body và submit
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function showDeleteRestriction() {
            // Hiển thị thông báo khi không thể xóa
            alert('Không thể xóa mã giảm giá!\n\n' +
                  'Điều kiện để xóa:\n' +
                  '• Mã giảm giá đã hết hạn (qua ngày kết thúc hoặc hạn sử dụng)\n' +
                  '• HOẶC đã hết lượt sử dụng\n\n' +
                  'Vui lòng chờ đến khi đủ điều kiện hoặc tạm dừng mã giảm giá thay vì xóa.');
        }
        
        // Hiển thị tooltip cho các nút bị disable
        document.addEventListener('DOMContentLoaded', function() {
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });
    </script>
</body>
</html>
            
            if (confirm(confirmMessage)) {
                // Tạo và submit form để xóa
                const form = document.createElement('form');
                form.method = 'post';
                form.style.display = 'none';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteDiscount';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = discountId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Hiển thị thông báo thành công/lỗi tự động ẩn sau 5 giây
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    if (alert && alert.parentNode) {
                        alert.style.transition = 'opacity 0.5s ease-out';
                        alert.style.opacity = '0';
                        setTimeout(function() {
                            if (alert.parentNode) {
                                alert.parentNode.removeChild(alert);
                            }
                        }, 500);
                    }
                }, 5000);
            });
        });
    </script>
</body>
</html>
