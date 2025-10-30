<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- 
    Cải tiến giao diện Lịch sử Giao hàng:
    1. Bọc trong Card hiện đại (shadow, rounded) với tiêu đề màu xanh lá (success) tượng trưng cho hoàn thành.
    2. Sử dụng JSTL để hiển thị trạng thái và ngày giờ chi tiết.
    3. Cải thiện định dạng tiền tệ.
--%>

<div class="container-fluid py-4">
    
    <%-- Card Bọc Ngoài: Tạo sự nổi bật và góc bo --%>
    <div class="card shadow-lg border-0 rounded-4">
        
        <%-- Tiêu đề Card: Màu xanh lá tượng trưng cho thành công --%>
        <div class="card-header bg-success text-white p-3 rounded-top-4 d-flex align-items-center justify-content-between">
            <h2 class="h4 mb-0 fw-bold"><i class="fas fa-history me-2"></i> ${requestScope.viewTitle}</h2>
            <span class="badge bg-light text-success fs-6 fw-bold">
                <c:if test="${not empty requestScope.historyOrders}">${fn:length(requestScope.historyOrders)} Đơn đã xử lý</c:if>
                <c:if test="${empty requestScope.historyOrders}">0 Đơn</c:if>
            </span>
        </div>
        
        <div class="card-body p-4">

            <div class="table-responsive">
                <%-- Bảng: table-hover, align-middle, bỏ border thừa --%>
                <table class="table table-hover align-middle caption-top">
                    <caption class="text-muted mb-2">Danh sách các đơn hàng đã hoàn thành hoặc bị trả lại.</caption>
                    
                    <%-- Tiêu đề Bảng: Màu sắc nhẹ nhàng, chữ đậm --%>
                    <thead class="bg-light">
                        <tr class="text-uppercase fw-bold text-secondary">
                            <th class="text-center">Mã PC</th>
                            <th class="text-center">Mã ĐH</th>
                            <th style="min-width: 120px;">Trạng Thái</th>
                            <th>Tên Người Nhận</th>
                            <th class="d-none d-lg-table-cell">Địa Chỉ Giao Hàng</th>
                            <th style="min-width: 160px;">Ngày Xử Lý</th>
                            <th class="text-end">Tổng Thanh Toán</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty requestScope.historyOrders}">
                                <c:forEach var="pc" items="${requestScope.historyOrders}">
                                    <tr class="border-bottom">
                                        <td class="text-center text-secondary small">#${pc.maPC}</td>
                                        <td class="text-center text-muted small">${pc.donHang.maDH}</td>
                                        
                                        <%-- Trạng Thái: Dùng badge màu sắc có điều kiện và icon --%>
                                        <td>
                                            <c:choose>
                                                <c:when test="${pc.trangThai eq 'HOAN_THANH'}">
                                                    <span class="badge bg-success rounded-pill py-2 px-3 fw-bold shadow-sm">
                                                        <i class="fas fa-check me-1"></i> Hoàn thành
                                                    </span>
                                                </c:when>
                                                <c:when test="${pc.trangThai eq 'TRA_HANG'}">
                                                    <span class="badge bg-danger rounded-pill py-2 px-3 fw-bold shadow-sm">
                                                        <i class="fas fa-undo me-1"></i> Trả hàng
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary rounded-pill py-2 px-3 fw-bold">${pc.trangThai}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <td class="fw-bold">${pc.donHang.tenNguoiNhan}</td>
                                        <td class="d-none d-lg-table-cell text-wrap small text-muted" style="max-width: 200px;">
                                            ${pc.donHang.diaChiGiaoHang}
                                        </td>
                                        
                                        <%-- Ngày Hoàn Thành/Trả Hàng (Hiển thị chi tiết ngày và giờ) --%>
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
                                        
                                        <%-- Tổng Thanh Toán: Nhấn mạnh bằng màu xanh lá và chữ đậm --%>
                                        <td class="text-end fw-bolder text-success fs-6">
                                            <fmt:formatNumber value="${pc.donHang.tongThanhToan}" type="currency" currencySymbol="₫"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                 <tr>
                                     <td colspan="7" class="text-center py-5 text-muted fs-5">
                                         <i class="far fa-grin-stars me-2"></i> Không có lịch sử giao hàng nào được ghi nhận.
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
            <i class="fas fa-archive me-1"></i> Hồ sơ công việc hoàn thành của bạn.
        </div>
    </div>
</div>