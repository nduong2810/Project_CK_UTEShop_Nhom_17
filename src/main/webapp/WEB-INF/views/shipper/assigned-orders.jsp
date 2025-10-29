<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<decorator:usePage id="currentPage" />
<c:set var="viewTitle" value="${requestScope.viewTitle}" scope="request" />

<div class="container-fluid">
    <h2 class="mt-4">${viewTitle}</h2>
    
    <c:if test="${not empty param.message}">
        <div class="alert alert-success">${param.message}</div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">${param.error}</div>
    </c:if>

    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Mã PC</th>
                    <th>Mã ĐH</th>
                    <th>Trạng Thái</th>
                    <th>Địa Chỉ Giao Hàng</th>
                    <th>Tổng Thanh Toán</th>
                    <th>Ngày Giao</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pc" items="${requestScope.pendingOrders}">
                    <tr>
                        <td>${pc.maPC}</td>
                        <td>${pc.donHang.maDH}</td>
                        <td><span class="badge badge-info">${pc.trangThai}</span></td>
                        <td>${pc.donHang.diaChiGiaoHang}</td>
                        <td><fmt:formatNumber value="${pc.donHang.tongThanhToan}" type="currency" currencySymbol="VND"/></td>
                        <td><fmt:formatDate value="${pc.ngayGiao}" pattern="HH:mm dd/MM/yyyy"/></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/shipper/orders" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="maPC" value="${pc.maPC}">
                                
                                <select name="newStatus" class="form-control form-control-sm mb-1">
                                    <option value="DANG_GIAO" <c:if test="${pc.trangThai eq 'DANG_GIAO'}">selected</c:if>>Đang giao</option>
                                    <option value="HOAN_THANH" <c:if test="${pc.trangThai eq 'HOAN_THANH'}">selected</c:if>>Đã giao (Hoàn thành)</option>
                                    <option value="TRA_HANG" <c:if test="${pc.trangThai eq 'TRA_HANG'}">selected</c:if>>Trả hàng</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty requestScope.pendingOrders}">
                     <tr><td colspan="7" class="text-center">Không có đơn hàng nào đang chờ giao.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>