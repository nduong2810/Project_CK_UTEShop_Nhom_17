<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="container-fluid py-4">
    
    <%-- Card Bọc Ngoài: Tạo sự nổi bật và góc bo --%>
    <div class="card shadow-lg border-0 rounded-4">
        
        <%-- Tiêu đề Card: Màu đỏ tượng trưng cho trả hàng/hủy --%>
        <div class="card-header bg-danger text-white p-3 rounded-top-4 d-flex align-items-center justify-content-between">
            <h2 class="h4 mb-0 fw-bold"><i class="fas fa-undo-alt me-2"></i> ${requestScope.viewTitle}</h2>
            <span class="badge bg-light text-danger fs-6 fw-bold">
                <c:if test="${not empty requestScope.returnedOrders}">${fn:length(requestScope.returnedOrders)} Đơn đã trả</c:if>
                <c:if test="${empty requestScope.returnedOrders}">0 Đơn</c:if>
            </span>
        </div>
        
        <div class="card-body p-4">

            <div class="table-responsive">
                <%-- Bảng: table-hover, align-middle, bỏ border thừa --%>
                <table class="table table-hover align-middle caption-top">
                    <caption class="text-muted mb-2">Danh sách các đơn hàng đã bị trả lại hoặc hủy.</caption>
                    
                    <%-- Tiêu đề Bảng: Màu sắc nhẹ nhàng, chữ đậm --%>
                    <thead class="bg-light">
                        <tr class="text-uppercase fw-bold text-secondary">
                            <th class="text-center">Mã PC</th>
                            <th class="text-center">Mã ĐH</th>
                            <th style="min-width: 120px;">Trạng Thái</th>
                            <th>Tên Người Nhận</th>
                            <th>Lý Do Hủy/Trả Hàng</th>
                            <th style="min-width: 150px;">Ngày Xử Lý</th>
                            <th class="text-end">Tổng Tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty requestScope.returnedOrders}">
                                <c:forEach var="pc" items="${requestScope.returnedOrders}">
                                    <tr class="border-bottom">
                                        <td class="text-center text-danger small">#${pc.maPC}</td>
                                        <td class="text-center text-muted small">${pc.donHang.maDH}</td>
                                        
                                        <%-- Trạng Thái: Luôn là Trả hàng với badge màu đỏ --%>
                                        <td>
                                            <span class="badge bg-danger rounded-pill py-2 px-3 fw-bold shadow-sm">
                                                <i class="fas fa-exclamation-triangle me-1"></i> Trả hàng
                                            </span>
                                        </td>
                                        
                                        <td class="fw-bold">${pc.donHang.tenNguoiNhan}</td>
                                        
                                        <%-- Lý Do Hủy/Trả Hàng --%>
                                        <td class="text-wrap small text-dark fst-italic" style="max-width: 250px;">
                                            ${pc.donHang.lyDoHuy}
                                        </td>
                                        
                                        <%-- Ngày Hoàn Thành/Trả Hàng --%>
                                        <td>
                                            <div class="small text-dark fw-normal">
                                                <i class="far fa-calendar-alt me-1 text-muted"></i>
                                                <fmt:formatDate value="${pc.ngayHoanThanhAsDate}" pattern="dd/MM/yyyy"/>
                                            </div>
                                            <div class="small text-muted">
                                                <i class="far fa-clock me-1"></i>
                                                <fmt:formatDate value="${pc.ngayHoanThanhAsDate}" pattern="HH:mm"/>
                                            </div>
                                        </td>
                                        
                                        <%-- Tổng Tiền: Nhấn mạnh bằng màu đỏ và chữ đậm --%>
                                        <td class="text-end fw-bolder text-danger fs-6">
                                            <fmt:formatNumber value="${pc.donHang.tongThanhToan}" type="currency" currencySymbol="₫"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                 <tr>
                                     <td colspan="7" class="text-center py-5 text-muted fs-5">
                                         <i class="fas fa-bell me-2"></i> Không có đơn hàng nào bị trả lại trong lịch sử của bạn.
                                     </td>
                                 </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
        
        <%-- Footer Card --%>
        <div class="card-footer text-center bg-light text-muted small py-3 rounded-bottom-4">
            <i class="fas fa-exclamation-circle me-1"></i> Đây là hồ sơ các đơn hàng không giao thành công.
        </div>
    </div>
</div>