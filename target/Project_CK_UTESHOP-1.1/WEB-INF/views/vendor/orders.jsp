<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
</head>
<body>
    <div class="container-fluid">
        <h2>${pageTitle} - ${store.tenCH}</h2>

        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link <c:if test="${currentStatus == 'CHUA_XAC_NHAN'}">active</c:if>" 
                   href="?status=CHUA_XAC_NHAN">Chờ xác nhận</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <c:if test="${currentStatus == 'DA_XAC_NHAN'}">active</c:if>" 
                   href="?status=DA_XAC_NHAN">Đã xác nhận</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <c:if test="${currentStatus == 'DA_GIAO'}">active</c:if>" 
                   href="?status=DA_GIAO">Đã giao (Hoàn thành)</a>
            </li>
            </ul>

        <c:if test="${not empty param.msg}"><div class="alert alert-success">${param.msg}</div></c:if>
        <c:if test="${not empty param.error}"><div class="alert alert-danger">${param.error}</div></c:if>

        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Mã DH</th>
                    <th>Ngày đặt</th>
                    <th>Khách hàng</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.maDH}</td>
                        <td><fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${order.nguoiDung.hoTen}</td>
                        <td><fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencyCode="VND" /></td>
                        <td>
                            <span class="badge bg-primary">${order.trangThai}</span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${order.trangThai == 'CHUA_XAC_NHAN'}">
                                    <form method="POST" action="${pageContext.request.contextPath}/vendor/order-action" style="display:inline;">
                                        <input type="hidden" name="action" value="updateOrderStatus">
                                        <input type="hidden" name="maDH" value="${order.maDH}">
                                        <input type="hidden" name="newStatus" value="DA_XAC_NHAN">
                                        <button type="submit" class="btn btn-sm btn-success">Xác nhận đơn</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <a href="#" class="btn btn-sm btn-secondary">Xem chi tiết</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${empty orders}">
            <p>Không có đơn hàng nào với trạng thái ${currentStatus}.</p>
        </c:if>
    </div>
</body>
</html>