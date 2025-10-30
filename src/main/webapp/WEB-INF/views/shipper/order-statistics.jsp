<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid py-4">
    
    <%-- Tiêu đề chính --%>
    <h2 class="mb-5 fw-bold text-dark"><i class="fas fa-chart-line me-3 text-primary"></i> ${requestScope.viewTitle}</h2>
    
    <%-- Hiển thị thông báo (Nếu có) --%>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        
        <%-- Card 1: Tổng Đơn Được Phân Công --%>
        <div class="col-md-6 col-xl-3 mb-4">
            <div class="card bg-gradient-primary shadow-lg border-0 rounded-4 h-100 text-white">
                <div class="card-body d-flex flex-column justify-content-between p-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-boxes fa-2x me-3 opacity-8"></i>
                        <h5 class="card-title text-uppercase mb-0 fw-normal">Tổng Đơn Được Phân Công</h5>
                    </div>
                    <p class="card-text display-4 fw-bolder mb-0">${requestScope.totalAssigned}</p>
                    <small class="mt-2 opacity-7">Tất cả đơn đã giao cho bạn.</small>
                </div>
            </div>
        </div>
        
        <%-- Card 2: Đơn Hàng Đang Giao (Cần hành động) --%>
        <div class="col-md-6 col-xl-3 mb-4">
            <div class="card bg-gradient-warning shadow-lg border-0 rounded-4 h-100 text-dark">
                <div class="card-body d-flex flex-column justify-content-between p-4">
                     <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-shipping-fast fa-2x me-3 opacity-8"></i>
                        <h5 class="card-title text-uppercase mb-0 fw-normal">Đơn Hàng Đang Giao</h5>
                    </div>
                    <p class="card-text display-4 fw-bolder mb-0">${requestScope.inProgress}</p>
                    <a href="${pageContext.request.contextPath}/shipper/orders" class="mt-2 text-dark fw-bold text-decoration-none opacity-9">
                        Bắt đầu giao <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <%-- Card 3: Đơn Hàng Đã Hoàn Thành (Thành tích) --%>
        <div class="col-md-6 col-xl-3 mb-4">
            <div class="card bg-gradient-success shadow-lg border-0 rounded-4 h-100 text-white">
                <div class="card-body d-flex flex-column justify-content-between p-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-check-circle fa-2x me-3 opacity-8"></i>
                        <h5 class="card-title text-uppercase mb-0 fw-normal">Đơn Hàng Đã Hoàn Thành</h5>
                    </div>
                    <p class="card-text display-4 fw-bolder mb-0">${requestScope.completed}</p>
                    <a href="${pageContext.request.contextPath}/shipper/history" class="mt-2 text-white fw-bold text-decoration-none opacity-9">
                        Xem lịch sử <i class="fas fa-history ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
        
        <%-- Card 4: Đơn Hàng Bị Trả Lại --%>
        <div class="col-md-6 col-xl-3 mb-4">
            <div class="card bg-gradient-danger shadow-lg border-0 rounded-4 h-100 text-white">
                <div class="card-body d-flex flex-column justify-content-between p-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-undo-alt fa-2x me-3 opacity-8"></i>
                        <h5 class="card-title text-uppercase mb-0 fw-normal">Đơn Hàng Bị Trả Lại</h5>
                    </div>
                    <p class="card-text display-4 fw-bolder mb-0">${requestScope.returned != null ? requestScope.returned : 0}</p>
                    <a href="${pageContext.request.contextPath}/shipper/returned" class="mt-2 text-white fw-bold text-decoration-none opacity-9">
                        Xem chi tiết <i class="fas fa-times-circle ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <hr class="my-5">

    <%-- Phần Action Buttons --%>
    <div class="row mt-4 justify-content-center">
        <div class="col-lg-10">
            <h4 class="mb-4 text-center text-muted"><i class="fas fa-toolbox me-2"></i> Công Cụ Quản Lý Đơn Hàng</h4>
            <div class="d-grid gap-3 d-md-flex justify-content-center flex-wrap">
                
                <a href="${pageContext.request.contextPath}/shipper/orders" class="btn btn-lg btn-primary shadow-sm px-5 py-3 rounded-pill fw-bold">
                    <i class="fas fa-motorcycle me-2"></i> Bắt Đầu Giao Hàng
                </a>
                
                <a href="${pageContext.request.contextPath}/shipper/pickup" class="btn btn-lg btn-outline-dark shadow-sm px-5 py-3 rounded-pill fw-bold">
                    <i class="fas fa-warehouse me-2"></i> Xác Nhận Lấy Hàng
                </a>

                <a href="${pageContext.request.contextPath}/shipper/history" class="btn btn-lg btn-outline-secondary shadow-sm px-5 py-3 rounded-pill fw-bold">
                    <i class="fas fa-history me-2"></i> Xem Lịch Sử Hoàn Thành
                </a>

                <%-- ✨ THÊM NÚT TRUY CẬP ĐƠN HÀNG BỊ TRẢ LẠI --%>
                <a href="${pageContext.request.contextPath}/shipper/returned" class="btn btn-lg btn-outline-danger shadow-sm px-5 py-3 rounded-pill fw-bold">
                    <i class="fas fa-times-circle me-2"></i> Hồ Sơ Trả Hàng
                </a>
            </div>
        </div>
    </div>
</div>

<style>
    /* Custom Gradient Styles for modern look */
    .bg-gradient-primary {
        background: linear-gradient(135deg, #4d94ff, #007bff); /* Xanh dương */
    }
    .bg-gradient-warning {
        background: linear-gradient(135deg, #ffdc81, #ffc107); /* Vàng */
    }
    .bg-gradient-success {
        background: linear-gradient(135deg, #4cd17c, #28a745); /* Xanh lá */
    }
    .bg-gradient-danger {
        background: linear-gradient(135deg, #ff6b6b, #dc3545); /* Đỏ Cảnh Báo */
    }
    .card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }
</style>