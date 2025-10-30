<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container-fluid">
    <h2 class="mt-4"><i class="fas fa-warehouse me-2"></i>${requestScope.viewTitle}</h2>
    <p>Danh sách các đơn hàng đang chờ để được lấy tại kho.</p>

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

    <div class="table-responsive mt-4">
        <table class="table table-bordered table-hover">
            <thead class="bg-light">
                <tr>
                    <th>Mã ĐH</th>
                    <th>Ngày Đặt</th>
                    <th>Tên Người Nhận</th>
                    <th>Địa Chỉ Giao</th>
                    <th>Tổng Tiền</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${requestScope.readyOrders}">
                    <tr>
                        <td><strong>#${order.maDH}</strong></td>
                        <td><fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${order.tenNguoiNhan}</td>
                        <td>${order.diaChiGiaoHang}</td>
                        <td><fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫"/></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/shipper/pickup" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn nhận giao đơn hàng #${order.maDH} không?')">
                                <input type="hidden" name="action" value="confirmPickup">
                                <input type="hidden" name="maDH" value="${order.maDH}">
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-check-circle me-1"></i> Xác nhận lấy hàng
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty requestScope.readyOrders}">
                     <tr>
                         <td colspan="6" class="text-center">
                             <p class="my-3">Hiện tại không có đơn hàng nào đang chờ lấy tại kho.</p>
                         </td>
                     </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>