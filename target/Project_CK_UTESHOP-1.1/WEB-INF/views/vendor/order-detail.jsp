<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<head>
    <title>${pageTitle} - UTESHOP Vendor</title>
    <style>
        
        .order-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-CHO_XAC_NHAN { background: #e3f2fd; color: #1976d2; }
        .status-DA_XAC_NHAN { background: #fff3e0; color: #f57c00; }
        .status-DANG_CHUAN_BI { background: #fce4ec; color: #c2185b; }
        .status-DANG_GIAO { background: #e1f5fe; color: #0277bd; }
        .status-DA_GIAO { background: #e8f5e9; color: #2e7d32; }
        .status-HOAN_THANH { background: #c8e6c9; color: #1b5e20; }
        .status-DA_HUY { background: #ffebee; color: #c62828; }
        .status-TRA_HANG { background: #fff9c4; color: #f57f17; }
        .status-HOAN_TIEN { background: #f3e5f5; color: #6a1b9a; }
        
        .info-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        
        .product-item {
            border-bottom: 1px solid #e9ecef;
            padding: 20px 0;
        }
        
        .product-item:last-child {
            border-bottom: none;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
        }
        
        .btn-status {
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            margin: 5px;
            transition: all 0.3s ease;
        }
        
        .btn-status:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        
        .timeline::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #dee2e6;
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 20px;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -23px;
            top: 5px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #28a745;
            border: 2px solid white;
            box-shadow: 0 0 0 2px #28a745;
        }
        
        .total-summary {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
        }
    </style>
</head>

<div class="container-fluid py-4">
    <!-- Back Button -->
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/vendor/orders" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
        </a>
    </div>
                
                <!-- Order Header -->
                <div class="order-header">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h2 class="h3 mb-2">Đơn hàng #${order.maDH}</h2>
                            <p class="mb-0 opacity-75">
                                <i class="fas fa-calendar me-2"></i>
                                Đặt hàng lúc: <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm" />
                            </p>
                        </div>
                        <div class="col-md-6 text-end">
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
                
                <div class="row">
                    <!-- Order Details -->
                    <div class="col-lg-8">
                        <!-- Customer Information -->
                        <div class="info-card">
                            <h5 class="mb-3">
                                <i class="fas fa-user me-2 text-primary"></i>Thông tin khách hàng
                            </h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Tên khách hàng:</strong><br>
                                    <c:choose>
                                        <c:when test="${not empty order.tenNguoiNhan}">
                                            ${order.tenNguoiNhan}
                                        </c:when>
                                        <c:otherwise>
                                            ${order.nguoiDung.hoTen}
                                        </c:otherwise>
                                    </c:choose>
                                    </p>
                                    <p><strong>Email:</strong><br>${order.nguoiDung.email}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Số điện thoại:</strong><br>
                                    <c:choose>
                                        <c:when test="${not empty order.soDienThoaiNhanHang}">
                                            ${order.soDienThoaiNhanHang}
                                        </c:when>
                                        <c:otherwise>
                                            ${order.nguoiDung.soDienThoai}
                                        </c:otherwise>
                                    </c:choose>
                                    </p>
                                    <p><strong>Địa chỉ giao hàng:</strong><br>${order.diaChiGiaoHang}</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Items -->
                        <div class="info-card">
                            <h5 class="mb-3">
                                <i class="fas fa-boxes me-2 text-primary"></i>Sản phẩm đã đặt
                            </h5>
                            <c:forEach var="item" items="${order.chiTietDonHangs}">
                                <div class="product-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-2">
                                            <c:choose>
                                                <c:when test="${not empty item.sanPham.hinhAnh}">
                                                    <img src="${pageContext.request.contextPath}/assets/img/${item.sanPham.hinhAnh}" 
                                                         alt="${item.sanPham.tenSP}" class="product-image">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                                        <i class="fas fa-image text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col-md-5">
                                            <h6 class="mb-1">${item.sanPham.tenSP}</h6>
                                            <p class="text-muted mb-0 small">${item.sanPham.moTa}</p>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <span class="fw-bold">x${item.soLuong}</span>
                                        </div>
                                        <div class="col-md-3 text-end">
                                            <div class="fw-bold">
                                                <fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="₫"/>
                                            </div>
                                            <div class="text-muted small">
                                                Thành tiền: <fmt:formatNumber value="${item.donGia * item.soLuong}" type="currency" currencySymbol="₫"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Status Update -->
                        <c:if test="${order.trangThai != 'HOAN_THANH' and order.trangThai != 'DA_HUY' and order.trangThai != 'HOAN_TIEN'}">
                            <div class="info-card">
                                <h5 class="mb-3">
                                    <i class="fas fa-edit me-2 text-primary"></i>Cập nhật trạng thái đơn hàng
                                </h5>
                                <form action="${pageContext.request.contextPath}/vendor/orders" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="updateOrderStatus">
                                    <input type="hidden" name="orderId" value="${order.maDH}">
                                    
                                    <div class="row">
                                        <c:choose>
                                            <c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">
                                                <div class="col-auto">
                                                    <button type="submit" name="newStatus" value="DA_XAC_NHAN" 
                                                            class="btn btn-status btn-info">
                                                        <i class="fas fa-check me-2"></i>Xác nhận đơn hàng
                                                    </button>
                                                </div>
                                                <div class="col-auto">
                                                    <button type="submit" name="newStatus" value="DA_HUY" 
                                                            class="btn btn-status btn-danger"
                                                            onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                                        <i class="fas fa-times me-2"></i>Hủy đơn hàng
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:when test="${order.trangThai == 'DA_XAC_NHAN'}">
                                                <div class="col-auto">
                                                    <button type="submit" name="newStatus" value="DANG_CHUAN_BI" 
                                                            class="btn btn-status btn-warning">
                                                        <i class="fas fa-box me-2"></i>Đang chuẩn bị
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:when test="${order.trangThai == 'DANG_CHUAN_BI'}">
                                                <div class="col-auto">
                                                    <button type="submit" name="newStatus" value="DANG_GIAO" 
                                                            class="btn btn-status btn-primary">
                                                        <i class="fas fa-shipping-fast me-2"></i>Đang giao hàng
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:when test="${order.trangThai == 'DANG_GIAO'}">
                                                <div class="col-auto">
                                                    <button type="submit" name="newStatus" value="DA_GIAO" 
                                                            class="btn btn-status btn-success">
                                                        <i class="fas fa-check-circle me-2"></i>Đã giao hàng
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:when test="${order.trangThai == 'DA_GIAO'}">
                                                <div class="col-auto">
                                                    <button type="submit" name="newStatus" value="HOAN_THANH" 
                                                            class="btn btn-status btn-success">
                                                        <i class="fas fa-check-double me-2"></i>Hoàn thành
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:when test="${order.trangThai == 'TRA_HANG'}">
                                                <div class="col-auto">
                                                    <button type="submit" name="newStatus" value="HOAN_TIEN" 
                                                            class="btn btn-status btn-primary">
                                                        <i class="fas fa-money-bill-wave me-2"></i>Hoàn tiền
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="col-12">
                                                    <p class="text-muted mb-0">Không thể cập nhật trạng thái đơn hàng này</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </form>
                            </div>
                        </c:if>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="total-summary">
                            <h5 class="mb-3">
                                <i class="fas fa-calculator me-2"></i>Tổng kết đơn hàng
                            </h5>
                            
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tạm tính:</span>
                                <span><fmt:formatNumber value="${order.tongTien}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                            </div>
                            
                            <!-- ✅ FIX: Show discount with proper formatting -->
                            <c:if test="${not empty order.tienGiam and order.tienGiam > 0}">
                                <div class="d-flex justify-content-between mb-2 text-warning">
                                    <span><i class="fas fa-tag me-1"></i>Giảm giá:</span>
                                    <span class="fw-bold">-<fmt:formatNumber value="${order.tienGiam}" type="number" groupingUsed="true"/>₫</span>
                                </div>
                            </c:if>
                            
                            <!-- ✅ FIX: Show shipping fee with proper formatting -->
                            <c:if test="${not empty order.phiVanChuyen}">
                                <div class="d-flex justify-content-between mb-2">
                                    <span><i class="fas fa-shipping-fast me-1"></i>Phí vận chuyển:</span>
                                    <span><fmt:formatNumber value="${order.phiVanChuyen}" type="number" groupingUsed="true"/>₫</span>
                                </div>
                            </c:if>
                            
                            <!-- DEBUG: Show all values for troubleshooting -->
                            <c:if test="${param.debug == 'true'}">
                                <div class="alert alert-info small mt-2">
                                    <strong>DEBUG INFO:</strong><br>
                                    TongTien: ${order.tongTien}<br>
                                    TienGiam: ${order.tienGiam}<br>
                                    PhiVanChuyen: ${order.phiVanChuyen}<br>
                                    TongThanhToan: ${order.tongThanhToan}
                                </div>
                            </c:if>
                            
                            <hr class="my-3" style="border-color: rgba(255,255,255,0.3);">
                            
                            <div class="d-flex justify-content-between mb-3">
                                <strong>Tổng thanh toán:</strong>
                                <strong><fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫"/></strong>
                            </div>
                            
                            <div class="text-center">
                                <small class="opacity-75">
                                    Phương thức thanh toán:<br>
                                    <strong>
                                        <c:choose>
                                            <c:when test="${order.phuongThucThanhToan == 'COD'}">Thanh toán khi nhận hàng</c:when>
                                            <c:when test="${order.phuongThucThanhToan == 'BANK_TRANSFER'}">Chuyển khoản ngân hàng</c:when>
                                            <c:when test="${order.phuongThucThanhToan == 'MOMO'}">MoMo</c:when>
                                            <c:otherwise>${order.phuongThucThanhToan}</c:otherwise>
                                        </c:choose>
                                    </strong>
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>