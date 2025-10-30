<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%-- File: /WEB-INF/views/shipper/history.jsp --%>

<div class="container-fluid">
    <h2 class="mt-4"><i class="fas fa-history me-2"></i>${requestScope.viewTitle}</h2>
    
    <div class="table-responsive mt-4">
        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark bg-dark text-white">
                <tr>
                    <th>Mã PC</th>
                    <th>Mã ĐH</th>
                    <th>Trạng Thái</th>
                    <th>Tên Người Nhận</th>
                    <th>Địa Chỉ Giao Hàng</th>
                    <th>Ngày Hoàn Thành/Trả Hàng</th>
                    <th>Tổng Thanh Toán</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pc" items="${requestScope.historyOrders}">
                    <tr>
                        <td>${pc.maPC}</td>
                        <td>${pc.donHang.maDH}</td>
                        <td>
                            <%-- Hiển thị badge màu xanh cho thành công, màu đỏ cho trả hàng --%>
                            <c:choose>
                                <c:when test="${pc.trangThai eq 'HOAN_THANH'}">
                                    <span class="badge bg-success">Hoàn thành</span>
                                </c:when>
                                <c:when test="${pc.trangThai eq 'TRA_HANG'}">
                                    <span class="badge bg-danger">Trả hàng</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${pc.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${pc.donHang.tenNguoiNhan}</td>
                        <td>${pc.donHang.diaChiGiaoHang}</td>
                        <td>
                            <%-- Định dạng ngày giờ hoàn thành --%>
                            <%-- SỬA LẠI: Gọi phương thức getNgayHoanThanhAsDate() --%>
                            <fmt:formatDate value="${pc.ngayHoanThanhAsDate}" pattern="HH:mm 'ngày' dd/MM/yyyy"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${pc.donHang.tongThanhToan}" type="currency" currencySymbol="₫"/>
                        </td>
                    </tr>
                </c:forEach>
                
                <%-- Hiển thị nếu không có đơn hàng nào trong lịch sử --%>
                <c:if test="${empty requestScope.historyOrders}">
                     <tr>
                         <td colspan="7" class="text-center">
                             <p class="my-3">Bạn chưa có lịch sử giao hàng nào.</p>
                         </td>
                     </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>