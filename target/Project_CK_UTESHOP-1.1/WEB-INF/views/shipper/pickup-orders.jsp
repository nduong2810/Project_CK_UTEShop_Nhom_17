<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- 
    Cải tiến giao diện Xác nhận Lấy Hàng:
    1. Bọc trong Card hiện đại (shadow, rounded).
    2. Sử dụng màu sắc và icon phù hợp (focus vào màu cam/cảnh báo vì đây là hành động cần xác nhận).
    3. Thiết kế lại nút hành động nổi bật.
--%>

<div class="container-fluid py-4">
    
    <%-- Card Bọc Ngoài: Tạo sự nổi bật và góc bo --%>
    <div class="card shadow-lg border-0 rounded-4">
        
        <%-- Tiêu đề Card --%>
        <div class="card-header bg-warning text-dark p-3 rounded-top-4 d-flex align-items-center justify-content-between">
            <h2 class="h4 mb-0 fw-bold"><i class="fas fa-warehouse me-2"></i> ${requestScope.viewTitle}</h2>
            <span class="badge bg-dark text-warning fs-6 fw-bold">${fn:length(requestScope.readyOrders)} Đơn chờ</span>
        </div>
        
        <div class="card-body p-4">
            
            <%-- Hiển thị thông báo (thêm icon cho đẹp) --%>
            <c:if test="${not empty param.message}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="fas fa-box-open me-2"></i> ${param.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <p class="text-muted small mb-4"><i class="fas fa-info-circle me-1"></i> Vui lòng xác nhận chỉ khi bạn đã nhận được gói hàng từ kho.</p>

            <div class="table-responsive">
                <%-- Bảng: table-hover, align-middle --%>
                <table class="table table-hover align-middle caption-top">
                    <caption class="text-muted mb-2">Danh sách đơn hàng sẵn sàng để vận chuyển.</caption>
                    
                    <%-- Tiêu đề Bảng: Màu sắc nhẹ nhàng, chữ đậm --%>
                    <thead class="bg-light">
                        <tr class="text-uppercase fw-bold text-secondary">
                            <th class="text-center">Mã ĐH</th>
                            <th>Ngày Đặt</th>
                            <th>Tên Người Nhận</th>
                            <th class="d-none d-lg-table-cell">Địa Chỉ Giao</th>
                            <th class="text-end">Tổng Tiền</th>
                            <th style="width: 150px;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${requestScope.readyOrders}">
                            <tr class="border-bottom">
                                <td class="text-center text-dark fw-bold">#${order.maDH}</td>
                                <td>
                                    <i class="far fa-calendar-alt me-1 text-muted small"></i>
                                    <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td class="fw-bold">${order.tenNguoiNhan}</td>
                                <td class="d-none d-lg-table-cell text-muted small text-wrap" style="max-width: 200px;">
                                    ${order.diaChiGiaoHang}
                                </td>
                                <td class="text-end fw-bolder text-danger fs-6">
                                    <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫"/>
                                </td>
                                
                                <%-- Hành Động: Nút nổi bật --%>
                                <td>
                                    <form action="${pageContext.request.contextPath}/shipper/pickup" method="post" 
                                          onsubmit="return confirm('XÁC NHẬN: Bạn có chắc chắn muốn nhận giao đơn hàng #${order.maDH} này không? Hành động này không thể hoàn tác.')">
                                        <input type="hidden" name="action" value="confirmPickup">
                                        <input type="hidden" name="maDH" value="${order.maDH}">
                                        <button type="submit" class="btn btn-sm btn-primary shadow-sm w-100 fw-bold">
                                            <i class="fas fa-boxes me-1"></i> Nhận Đơn
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <%-- Thông báo không có đơn hàng nào --%>
                        <c:if test="${empty requestScope.readyOrders}">
                             <tr>
                                 <td colspan="6" class="text-center py-5 text-muted fs-5">
                                     <i class="fas fa-thumbs-up me-2"></i> Không có đơn hàng nào đang chờ lấy tại kho.
                                 </td>
                             </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        
        <%-- Footer Card --%>
        <div class="card-footer text-center bg-light text-muted small py-3 rounded-bottom-4">
            <i class="fas fa-shield-alt me-1"></i> Đảm bảo kiểm tra hàng hóa trước khi xác nhận nhận đơn.
        </div>
    </div>
</div>