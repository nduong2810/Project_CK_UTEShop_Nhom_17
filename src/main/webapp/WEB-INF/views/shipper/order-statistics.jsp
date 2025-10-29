<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid">
    <h2 class="mt-4">${requestScope.viewTitle}</h2>
    
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title">Tổng Đơn Được Giao</h5>
                    <p class="card-text display-4">${requestScope.totalAssigned}</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-4 mb-4">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title">Đơn Hàng Đang Giao</h5>
                    <p class="card-text display-4">${requestScope.inProgress}</p>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title">Đơn Hàng Đã Hoàn Thành</h5>
                    <p class="card-text display-4">${requestScope.completed}</p>
                </div>
            </div>
        </div>
    </div>

    <p class="mt-4">Chi tiết đơn hàng đang giao:</p>
    <a href="${pageContext.request.contextPath}/shipper/orders" class="btn btn-info">Xem Danh Sách Đơn Hàng</a>
</div>