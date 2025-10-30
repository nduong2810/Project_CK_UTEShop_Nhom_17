<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="container-fluid">
    <h2 class="mt-4">${requestScope.viewTitle}</h2>
    
    <%-- Hiển thị thông báo (nếu có) --%>
    <c:if test="${not empty param.message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${param.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark bg-dark text-white">
                <tr>
                    <th>Mã PC</th>
                    <th>Mã ĐH</th>
                    <th>Trạng Thái</th>
                    <th>Địa Chỉ Giao Hàng</th>
                    <%-- ======================================================= --%>
                    <%-- THAY ĐỔI: Thêm 2 cột header mới --%>
                    <%-- ======================================================= --%>
                    <th>Tên Người Nhận</th>
                    <th>SĐT Nhận Hàng</th>
                    <%-- ======================================================= --%>
                    <th>Tổng Thanh Toán</th>
                    <th>Ghi Chú</th>
                    <th style="width: 20%;">Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pc" items="${requestScope.pendingOrders}">
                    <tr>
                        <td>${pc.maPC}</td>
                        <td>${pc.donHang.maDH}</td>
                        <td><span class="badge bg-info text-dark">${pc.trangThai}</span></td>
                        <td>${pc.donHang.diaChiGiaoHang}</td>
                        <%-- ======================================================= --%>
                        <%-- THAY ĐỔI: Thêm 2 ô dữ liệu mới --%>
                        <%-- ======================================================= --%>
                        <td>${pc.donHang.tenNguoiNhan}</td>
                        <td>${pc.donHang.soDienThoaiNhanHang}</td>
                        <%-- ======================================================= --%>
                        <td><fmt:formatNumber value="${pc.donHang.tongThanhToan}" type="currency" currencySymbol="₫"/></td>
                        <td>${pc.donHang.ghiChu}</td>
                        <td>
                            <%-- Form cập nhật trạng thái --%>
                            <form action="${pageContext.request.contextPath}/shipper/orders" method="post">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="maPC" value="${pc.maPC}">
                                
                                <div class="input-group">
                                    <select name="newStatus" class="form-select form-select-sm status-select" onchange="updateButtonText(this)">
                                        <option value="DANG_GIAO" ${pc.trangThai eq 'DANG_GIAO' ? 'selected' : ''}>Đang giao</option>
                                        <option value="HOAN_THANH" ${pc.trangThai eq 'HOAN_THANH' ? 'selected' : ''}>Hoàn thành</option>
                                        <option value="TRA_HANG" ${pc.trangThai eq 'TRA_HANG' ? 'selected' : ''}>Trả hàng</option>
                                    </select>
                                    <button type="submit" class="btn btn-sm btn-primary submit-btn">
                                        <%-- Văn bản sẽ được cập nhật bằng JavaScript --%>
                                    </button>
                                </div>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                
                <%-- Hiển thị nếu không có đơn hàng nào --%>
                <c:if test="${empty requestScope.pendingOrders}">
                     <%-- THAY ĐỔI: Cập nhật colspan từ 7 lên 9 --%>
                     <tr><td colspan="9" class="text-center">Không có đơn hàng nào đang chờ giao.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<script>
    // Hàm cập nhật văn bản của nút dựa trên lựa chọn trong dropdown
    function updateButtonText(selectElement) {
        const button = selectElement.form.querySelector('.submit-btn');
        const selectedText = selectElement.options[selectElement.selectedIndex].text;
        if (button) {
            button.innerHTML = '<i class="fas fa-check me-1"></i>' + selectedText;
        }
    }
    
    // Chạy hàm này cho tất cả các dòng khi trang được tải xong
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.status-select').forEach(function(selectElement) {
            updateButtonText(selectElement);
        });
    });
</script>