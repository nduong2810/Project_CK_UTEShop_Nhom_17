<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- 
    *** PHIÊN BẢN CUỐI CÙNG: Bỏ tỉ lệ % cố định, tăng kích thước nút và cập nhật tên. ***
--%>
<% response.setContentType("text/html; charset=UTF-8"); %>

<div class="container-fluid py-4">
    
    <%-- Card Bọc Ngoài: Tạo sự nổi bật và góc bo --%>
    <div class="card shadow-lg border-0 rounded-4">
        
        <%-- Tiêu đề Card --%>
        <div class="card-header bg-primary text-white p-3 rounded-top-4 d-flex align-items-center justify-content-between">
            <h2 class="h4 mb-0 fw-bold"><i class="fas fa-truck-loading me-2"></i> ${requestScope.viewTitle}</h2>
            <span class="badge bg-light text-primary fs-6 fw-bold">${fn:length(requestScope.pendingOrders)} Đơn</span>
        </div>
        
        <div class="card-body p-4">
            
            <%-- Hiển thị thông báo --%>
            <c:if test="${not empty param.message}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${param.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-hover align-middle caption-top">
                    <caption class="text-muted mb-2">Danh sách đơn hàng cần xử lý.</caption>
                    
                    <thead class="bg-light">
                        <tr class="text-uppercase fw-bold text-secondary">
                            <th class="text-center">Mã PC</th>
                            <th class="text-center">Mã ĐH</th>
                            <th style="min-width: 120px;">Trạng Thái</th>
                            <th>Địa Chỉ Giao Hàng</th>
                            <th>Tên Người Nhận</th>
                            <th style="min-width: 100px;">SĐT Nhận Hàng</th>
                            <th style="min-width: 120px;">Tổng Thanh Toán</th>
                            <th>Ghi Chú</th>
                            <th style="min-width: 260px;">Hành Động</th> <%-- Đảm bảo đủ không gian cho nút to --%>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pc" items="${requestScope.pendingOrders}">
                            <tr class="border-bottom">
                                <td class="text-center text-primary fw-bold">#${pc.maPC}</td>
                                <td class="text-center text-muted small">${pc.donHang.maDH}</td>
                                
                                <%-- Trạng Thái: Dùng badge màu sắc có điều kiện --%>
                                <td>
                                    <c:choose>
                                        <c:when test="${pc.trangThai eq 'DANG_GIAO'}"><span class="badge bg-warning text-dark rounded-pill py-2 px-3 fw-bold shadow-sm">Đang giao</span></c:when>
                                        <c:when test="${pc.trangThai eq 'HOAN_THANH'}"><span class="badge bg-success rounded-pill py-2 px-3 fw-bold shadow-sm">Hoàn thành</span></c:when>
                                        <c:when test="${pc.trangThai eq 'TRA_HANG'}"><span class="badge bg-danger rounded-pill py-2 px-3 fw-bold shadow-sm">Trả hàng</span></c:when>
                                        <c:otherwise><span class="badge bg-info text-dark rounded-pill py-2 px-3 fw-bold shadow-sm">${pc.trangThai}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                
                                <td class="text-wrap small text-muted">${pc.donHang.diaChiGiaoHang}</td>
                                <td class="fw-bold">${pc.donHang.tenNguoiNhan}</td>
                                <td class="text-info">${pc.donHang.soDienThoaiNhanHang}</td>
                                
                                <%-- Tổng Thanh Toán: CĂN CHỈNH TRÁI và làm nổi bật --%>
                                <td class="fw-bolder text-danger small text-start">
                                    <fmt:formatNumber value="${pc.donHang.tongThanhToan}" type="currency" currencySymbol="₫"/>
                                </td>
                                
                                <td class="text-muted small text-truncate" style="max-width: 80px;">
                                    ${pc.donHang.ghiChu}
                                </td>
                                
                                <%-- Hành Động: Đã tăng kích thước nút --%>
                                <td>
                                    <form action="${pageContext.request.contextPath}/shipper/orders" method="post" class="d-flex gap-2 align-items-center">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="maPC" value="${pc.maPC}">
                                        
                                        <select name="newStatus" class="form-select form-select-sm status-select w-auto" style="max-width: 110px;" onchange="updateButtonText(this)">
                                            <option value="DANG_GIAO" ${pc.trangThai eq 'DANG_GIAO' ? 'selected' : ''} data-icon="fas fa-motorcycle" data-color="btn-warning text-dark">Đang giao</option>
                                            <option value="HOAN_THANH" ${pc.trangThai eq 'HOAN_THANH' ? 'selected' : ''} data-icon="fas fa-check-circle" data-color="btn-success">Hoàn thành</option>
                                            <option value="TRA_HANG" ${pc.trangThai eq 'TRA_HANG' ? 'selected' : ''} data-icon="fas fa-undo-alt" data-color="btn-danger">Trả hàng</option>
                                        </select>
                                        
                                        <button type="submit" class="btn btn-sm submit-btn flex-shrink-0" style="min-width: 140px;">
                                            <i class="fas fa-sync-alt me-1"></i> Cập nhật <%-- Tên dự phòng --%>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <%-- Thông báo không có đơn hàng --%>
                        <c:if test="${empty requestScope.pendingOrders}">
                             <tr><td colspan="9" class="text-center py-5 text-muted fs-5">🎉 **Tuyệt vời!** Không có đơn hàng nào đang chờ giao.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        
        <%-- Footer Card --%>
        <div class="card-footer text-center bg-light text-muted small py-3 rounded-bottom-4">
            <i class="fas fa-info-circle me-1"></i> Quản lý đơn hàng vận chuyển.
        </div>
    </div>
</div>

<script>
    // Hàm cập nhật văn bản, ICON và màu sắc của nút dựa trên lựa chọn trong dropdown
    function updateButtonText(selectElement) {
        const button = selectElement.form.querySelector('.submit-btn');
        const selectedOption = selectElement.options[selectElement.selectedIndex];
        
        // Lấy dữ liệu từ thuộc tính data-*
        const selectedText = selectedOption.text;
        const iconClass = selectedOption.getAttribute('data-icon');
        const colorClass = selectedOption.getAttribute('data-color');
        
        if (button) {
            // Xóa các class màu cũ
            button.className = button.className.replace(/\bbtn-\w+\s*(text-\w+)?/g, '').trim();
            button.classList.add('btn', 'btn-sm', 'submit-btn', 'flex-shrink-0');
            
            // Thêm class màu mới và icon
            button.classList.add(colorClass || 'btn-primary');
            
            // ✨ THAY ĐỔI: Đặt tên nút là "Cập nhật [Trạng thái]"
            button.innerHTML = `<i class="${iconClass || 'fas fa-sync-alt'} me-1"></i> Cập nhật ${selectedText}`; 
        }
    }
    
    // Chạy hàm này cho tất cả các dòng khi trang được tải xong
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.status-select').forEach(function(selectElement) {
            updateButtonText(selectElement);
        });
    });
</script>