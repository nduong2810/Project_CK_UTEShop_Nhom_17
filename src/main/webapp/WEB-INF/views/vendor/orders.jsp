<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<style>
        /* Base font styling for Vietnamese */
        * {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            background-color: #f8f9fa;
        }
        
        .order-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border-left: 4px solid #e9ecef;
        }
        
        .order-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .order-card.status-CHO_XAC_NHAN { border-left-color: #007bff; }
        .order-card.status-DA_XAC_NHAN { border-left-color: #17a2b8; }
        .order-card.status-DANG_CHUAN_BI { border-left-color: #6f42c1; }
        .order-card.status-DANG_GIAO { border-left-color: #ffc107; }
        .order-card.status-DA_GIAO { border-left-color: #28a745; }
        .order-card.status-HOAN_THANH { border-left-color: #20c997; }
        .order-card.status-DA_HUY { border-left-color: #dc3545; }
        .order-card.status-TRA_HANG { border-left-color: #fd7e14; }
        .order-card.status-HOAN_TIEN { border-left-color: #6610f2; }
        
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-CHO_XAC_NHAN { background: #e3f2fd; color: #1976d2; }
        .status-DA_XAC_NHAN { background: #e0f7fa; color: #0277bd; }
        .status-DANG_CHUAN_BI { background: #f3e5f5; color: #6f42c1; }
        .status-DANG_GIAO { background: #fff3e0; color: #f57c00; }
        .status-DA_GIAO { background: #e8f5e8; color: #2e7d32; }
        .status-HOAN_THANH { background: #d1f2eb; color: #0f5132; }
        .status-DA_HUY { background: #ffebee; color: #c62828; }
        .status-TRA_HANG { background: #fff3e0; color: #ef6c00; }
        .status-HOAN_TIEN { background: #f3e5f5; color: #7b1fa2; }
        
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        
        .stats-card.filter-active {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            transform: scale(1.05);
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .order-id {
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d3748;
        }
        
        .customer-info {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .order-total {
            font-size: 1.2rem;
            font-weight: 700;
            color: #28a745;
        }
        
        .btn-detail {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-detail:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
</style>

<div class="container-fluid py-4">
        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-md-3 col-lg-2">
                <div class="bg-white rounded-3 shadow-sm p-3 mb-4">
                    <h6 class="text-muted mb-3">MENU</h6>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/vendor/dashboard" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/products" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-box me-2"></i> Sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/discounts" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-tags me-2"></i> Mã giảm giá
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/orders" class="list-group-item list-group-item-action border-0 active">
                            <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/statistics" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-chart-pie me-2"></i> Thống kê
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/settings" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-cog me-2"></i> Cài đặt
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="h3 mb-0">Quản lý Đơn hàng</h2>
                        <p class="text-muted mb-0">Theo dõi và xử lý đơn hàng của cửa hàng</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-primary" onclick="location.reload()">
                            <i class="fas fa-sync-alt me-2"></i>Làm mới
                        </button>
                    </div>
                </div>
                
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <c:set var="choXacNhan" value="${orderStats['CHO_XAC_NHAN'] != null ? orderStats['CHO_XAC_NHAN'] : 0}" />
                    <c:set var="daXacNhan" value="${orderStats['DA_XAC_NHAN'] != null ? orderStats['DA_XAC_NHAN'] : 0}" />
                    <c:set var="dangChuanBi" value="${orderStats['DANG_CHUAN_BI'] != null ? orderStats['DANG_CHUAN_BI'] : 0}" />
                    <c:set var="dangGiao" value="${orderStats['DANG_GIAO'] != null ? orderStats['DANG_GIAO'] : 0}" />
                    <c:set var="daGiao" value="${orderStats['DA_GIAO'] != null ? orderStats['DA_GIAO'] : 0}" />
                    <c:set var="hoanThanh" value="${orderStats['HOAN_THANH'] != null ? orderStats['HOAN_THANH'] : 0}" />
                    <c:set var="daHuy" value="${orderStats['DA_HUY'] != null ? orderStats['DA_HUY'] : 0}" />
                    <c:set var="traHang" value="${orderStats['TRA_HANG'] != null ? orderStats['TRA_HANG'] : 0}" />
                    <c:set var="hoanTien" value="${orderStats['HOAN_TIEN'] != null ? orderStats['HOAN_TIEN'] : 0}" />
                    <c:set var="totalAllOrders" value="${choXacNhan + daXacNhan + dangChuanBi + dangGiao + daGiao + hoanThanh + daHuy + traHang + hoanTien}" />
                    
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == null ? 'filter-active' : ''}" onclick="filterByStatus('')">
                            <div class="stats-number">${totalAllOrders}</div>
                            <div>Tất cả</div>
                            <small class="text-white-50">${totalAllOrders} đơn hàng</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'CHO_XAC_NHAN' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);" onclick="filterByStatus('CHO_XAC_NHAN')">
                            <div class="stats-number">${choXacNhan}</div>
                            <div>Chờ xác nhận</div>
                            <small class="text-white-50">${choXacNhan} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'DA_XAC_NHAN' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);" onclick="filterByStatus('DA_XAC_NHAN')">
                            <div class="stats-number">${daXacNhan}</div>
                            <div>Đã xác nhận</div>
                            <small class="text-white-50">${daXacNhan} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'DANG_CHUAN_BI' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #6f42c1 0%, #5a32a3 100%);" onclick="filterByStatus('DANG_CHUAN_BI')">
                            <div class="stats-number">${dangChuanBi}</div>
                            <div>Đang chuẩn bị</div>
                            <small class="text-white-50">${dangChuanBi} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'DANG_GIAO' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);" onclick="filterByStatus('DANG_GIAO')">
                            <div class="stats-number">${dangGiao}</div>
                            <div>Đang giao</div>
                            <small class="text-white-50">${dangGiao} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'DA_GIAO' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);" onclick="filterByStatus('DA_GIAO')">
                            <div class="stats-number">${daGiao}</div>
                            <div>Đã giao</div>
                            <small class="text-white-50">${daGiao} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'HOAN_THANH' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #20c997 0%, #17a2b8 100%);" onclick="filterByStatus('HOAN_THANH')">
                            <div class="stats-number">${hoanThanh}</div>
                            <div>Hoàn thành</div>
                            <small class="text-white-50">${hoanThanh} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'DA_HUY' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);" onclick="filterByStatus('DA_HUY')">
                            <div class="stats-number">${daHuy}</div>
                            <div>Đã hủy</div>
                            <small class="text-white-50">${daHuy} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'TRA_HANG' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #fd7e14 0%, #e8590c 100%);" onclick="filterByStatus('TRA_HANG')">
                            <div class="stats-number">${traHang}</div>
                            <div>Trả hàng</div>
                            <small class="text-white-50">${traHang} đơn</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card ${statusFilter == 'HOAN_TIEN' ? 'filter-active' : ''}" style="background: linear-gradient(135deg, #6610f2 0%, #510bc4 100%);" onclick="filterByStatus('HOAN_TIEN')">
                            <div class="stats-number">${hoanTien}</div>
                            <div>Hoàn tiền</div>
                            <small class="text-white-50">${hoanTien} đơn</small>
                        </div>
                    </div>
                </div>
                
                <!-- Messages -->
                <c:if test="${param.msg != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${param.msg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${param.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Order List -->
                <div class="bg-white rounded-3 shadow-sm p-4">
                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="text-center py-5">
                                <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">Chưa có đơn hàng nào</h5>
                                <p class="text-muted">
                                    <c:choose>
                                        <c:when test="${statusFilter != null}">
                                            Không có đơn hàng nào với trạng thái này.
                                        </c:when>
                                        <c:otherwise>
                                            Đơn hàng sẽ xuất hiện ở đây khi khách hàng đặt mua sản phẩm của bạn.
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <c:if test="${statusFilter != null}">
                                    <a href="${pageContext.request.contextPath}/vendor/orders" class="btn btn-primary">
                                        <i class="fas fa-list me-2"></i>Xem tất cả đơn hàng
                                    </a>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0">
                                    Tìm thấy ${totalOrders} đơn hàng
                                    <c:if test="${statusFilter != null}">
                                        với trạng thái: 
                                        <span class="status-badge status-${statusFilter}">
                                            <c:choose>
                                                <c:when test="${statusFilter == 'CHO_XAC_NHAN'}">Chờ xác nhận</c:when>
                                                <c:when test="${statusFilter == 'DA_XAC_NHAN'}">Đã xác nhận</c:when>
                                                <c:when test="${statusFilter == 'DANG_CHUAN_BI'}">Đang chuẩn bị</c:when>
                                                <c:when test="${statusFilter == 'DANG_GIAO'}">Đang giao</c:when>
                                                <c:when test="${statusFilter == 'DA_GIAO'}">Đã giao</c:when>
                                                <c:when test="${statusFilter == 'HOAN_THANH'}">Hoàn thành</c:when>
                                                <c:when test="${statusFilter == 'DA_HUY'}">Đã hủy</c:when>
                                                <c:when test="${statusFilter == 'TRA_HANG'}">Trả hàng</c:when>
                                                <c:when test="${statusFilter == 'HOAN_TIEN'}">Hoàn tiền</c:when>
                                                <c:otherwise>${statusFilter}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </c:if>
                                </h6>
                            </div>
                            
                            <div class="row">
                                <c:forEach var="order" items="${orders}">
                                    <div class="col-12">
                                        <div class="order-card status-${order.trangThai}">
                                            <div class="row align-items-center">
                                                <div class="col-md-3">
                                                    <div class="order-id">#${order.maDH}</div>
                                                    <div class="customer-info">
                                                        <i class="fas fa-user me-1"></i>
                                                        <c:choose>
                                                            <c:when test="${not empty order.tenNguoiNhan}">
                                                                ${order.tenNguoiNhan}
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${order.nguoiDung.hoTen}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="customer-info">
                                                        <i class="fas fa-calendar me-1"></i>
                                                        <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm" />
                                                    </div>
                                                </div>
                                                
                                                <div class="col-md-3">
                                                    <div class="mb-2">
                                                        <span class="status-badge status-${order.trangThai}">
                                                            <c:choose>
                                                                <c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">Chờ xác nhận</c:when>
                                                                <c:when test="${order.trangThai == 'DA_XAC_NHAN'}">Đã xác nhận</c:when>
                                                                <c:when test="${order.trangThai == 'DANG_CHUAN_BI'}">Đang chuẩn bị</c:when>
                                                                <c:when test="${order.trangThai == 'DANG_GIAO'}">Đang giao hàng</c:when>
                                                                <c:when test="${order.trangThai == 'DA_GIAO'}">Đã giao hàng</c:when>
                                                                <c:when test="${order.trangThai == 'HOAN_THANH'}">Hoàn thành</c:when>
                                                                <c:when test="${order.trangThai == 'DA_HUY'}">Đã hủy</c:when>
                                                                <c:when test="${order.trangThai == 'TRA_HANG'}">Trả hàng</c:when>
                                                                <c:when test="${order.trangThai == 'HOAN_TIEN'}">Hoàn tiền</c:when>
                                                                <c:otherwise>${order.trangThai}</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                    <div class="text-muted small">
                                                        <i class="fas fa-boxes me-1"></i>
                                                        ${order.chiTietDonHangs.size()} sản phẩm
                                                    </div>
                                                </div>
                                                
                                                <div class="col-md-3">
                                                    <div class="order-total">
                                                        <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫"/>
                                                    </div>
                                                    <c:if test="${order.phuongThucThanhToan != null}">
                                                        <div class="text-muted small">
                                                            <i class="fas fa-credit-card me-1"></i>
                                                            <c:choose>
                                                                <c:when test="${order.phuongThucThanhToan == 'COD'}">Thanh toán khi nhận hàng</c:when>
                                                                <c:when test="${order.phuongThucThanhToan == 'BANK_TRANSFER'}">Chuyển khoản ngân hàng</c:when>
                                                                <c:when test="${order.phuongThucThanhToan == 'MOMO'}">MoMo</c:when>
                                                                <c:otherwise>${order.phuongThucThanhToan}</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                
                                                <div class="col-md-3 text-end">
                                                    <a href="${pageContext.request.contextPath}/vendor/orders/detail?id=${order.maDH}" class="btn btn-detail">
                                                        <i class="fas fa-eye me-2"></i>Chi tiết
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Phân trang đơn hàng" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage - 1}<c:if test='${statusFilter != null}'>&status=${statusFilter}</c:if>">Trước</a>
                                            </li>
                                        </c:if>
                                        
                                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                            <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${pageNum}<c:if test='${statusFilter != null}'>&status=${statusFilter}</c:if>">${pageNum}</a>
                                            </li>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage + 1}<c:if test='${statusFilter != null}'>&status=${statusFilter}</c:if>">Sau</a>
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

<script>
    function filterByStatus(status) {
        let url = '${pageContext.request.contextPath}/vendor/orders';
        if (status && status.trim() !== '') {
            url += '?status=' + status;
        }
        window.location.href = url;
    }
</script> 
