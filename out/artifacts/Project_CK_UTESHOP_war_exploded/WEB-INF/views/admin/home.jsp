<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- Nếu đã include header tổng ở layout thì không bọc <html> ở đây --%>
<%-- Thêm Google Font để giao diện hiện đại hơn --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
/* ===== CSS hiện đại hóa cho trang Dashboard ===== */
:root {
    --admin-bg: #f5f7fb;
    --admin-border: #e5e7eb;
    --card: #fff;
    --muted: #6b7280;
    --primary: #0b57d0; /* Đồng bộ với màu sidebar */
    --accent: #ff7a00;
    --radius: 16px;
    --shadow: 0 8px 20px rgba(17, 24, 39, .08);
    --text-color: #1f2937; /* Darker text for better readability */
    --heading-color: #111827;
    --button-hover-shadow: 0 6px 20px rgba(11, 87, 208, 0.3);
}
.admin-shell {
     display: flex;
     background: #f5f7fb;
 }

.admin-shell .admin-container {
    padding: 24px;
    font-family: 'Inter', sans-serif;
}

/* Toolbar */
.admin-shell .page-title {
    font-size: 28px;
    font-weight: 700;
    margin: 0 0 20px;
    color: #111827;
}

.admin-shell .toolbar {
    display: flex;
    gap: 15px;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

/* KPI Cards */
.admin-shell .kpi-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-bottom: 24px;
}

.admin-shell .kpi-card {
    background: #fff;
    border-radius: 16px;
    padding: 24px;
    display: flex;
    align-items: center;
    gap: 20px;
    box-shadow: 0 8px 20px rgba(17, 24, 39, .08);
    transition: transform .2s ease, box-shadow .2s ease;
}

.admin-shell .kpi-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 25px rgba(17, 24, 39, .1);
}

.admin-shell .kpi-ico {
    font-size: 36px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: grid;
    place-items: center;
    background: #eef4ff;
}

.admin-shell .kpi-meta .kpi-title {
    color: #6b7280;
    font-size: 14px;
    margin-bottom: 4px;
}

.admin-shell .kpi-meta .kpi-value {
    font-size: 28px;
    font-weight: 700;
    color: #111827;
}

/* Panel */
.admin-shell .panel {
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(17, 24, 39, .08);
    margin-bottom: 24px;
}

.admin-shell .panel-hd {
    padding: 20px 24px;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.admin-shell .panel-title {
    font-size: 18px;
    font-weight: 600;
    color: #111827;
}

.admin-shell .panel-actions {
    display: flex;
    gap: 10px;
}

/* Table */
.admin-shell .table {
    width: 100%;
    border-collapse: collapse;
}

.admin-shell .table th,
.admin-shell .table td {
    padding: 16px 24px;
    text-align: left;
    border-bottom: 1px solid #e5e7eb;
    vertical-align: middle;
}

.admin-shell .table thead th {
    font-weight: 600;
    color: #6b7280;
    font-size: 13px;
    text-transform: uppercase;
    letter-spacing: .5px;
}

.admin-shell .table .right {
    text-align: right;
}

/* Button */
.admin-shell .btn {
    height: 40px;
    padding: 0 20px;
    border-radius: 10px;
    border: 1px solid #e5e7eb;
    background: #fff;
    font-weight: 600;
    cursor: pointer;
    transition: all .2s ease;
}

.admin-shell .btn-primary {
    background: #0b57d0;
    border-color: #0b57d0;
    color: #fff;
}

/* Badge */
.admin-shell .badge {
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: .5px;
}

.admin-shell .b-new { background: #e0f2fe; color: #0c54a1; }
.admin-shell .b-confirm { background: #dcfce7; color: #166534; }
.admin-shell .b-ship { background: #ffedd5; color: #9a3412; }
.admin-shell .b-done { background: #d1fae5; color: #065f46; }
.admin-shell .b-cancel { background: #fee2e2; color: #991b1b; }
.admin-shell .b-return { background: #fef9c3; color: #854d0e; }
.admin-shell .b-refund { background: #f3e8ff; color: #6b21a8; }

/* ===== Utilities ===== */
.muted {
    color: var(--muted);
}

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">
            <div class="page-title">Bảng điều khiển</div>
            <div class="toolbar">
                <div class="muted">Tổng quan hệ thống</div>
                <form method="get" class="right">
                    <!-- Phần tử này rỗng để đảm bảo cấu trúc flexbox đồng nhất với admin/products.jsp -->
                </form> 
            </div>

            <!-- KPI -->
            <section class="kpi-grid">
                <div class="kpi-card">
                    <div class="kpi-ico">👥</div>
                    <div class="kpi-meta">
                        <div class="kpi-title">Người dùng</div>
                        <div class="kpi-value">${totalUsers}</div>
                    </div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-ico">🧾</div>
                    <div class="kpi-meta">
                        <div class="kpi-title">Đơn hàng</div>
                        <div class="kpi-value">${totalOrders}</div>
                    </div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-ico">💰</div>
                    <div class="kpi-meta">
                        <div class="kpi-title">Doanh thu hôm nay</div>
                        <div class="kpi-value">
                            <fmt:formatNumber value="${revenueToday}" type="number" />
                        </div>
                    </div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-ico">📦</div>
                    <div class="kpi-meta">
                        <div class="kpi-title">Sản phẩm đang bán</div>
                        <div class="kpi-value">${totalProducts}</div>
                    </div>
                </div>
            </section>

            <!-- Đơn hàng gần đây -->
            <section class="panel">
                <div class="panel-hd">
                    <div class="panel-title">Đơn hàng gần đây</div>
                    <div class="panel-actions">
                        <button class="btn"
                                onclick="location.href='${pageContext.request.contextPath}/admin/orders'">Xem
                            tất cả</button>
                        <button class="btn btn-primary"
                                onclick="location.href='${pageContext.request.contextPath}/admin/orders'">Quản
                            lý</button>
                    </div>
                </div>
                <div style="overflow: auto">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th class="right">Tổng thanh toán</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty recentOrders}">
                                    <tr>
                                        <td class="muted" colspan="5" style="text-align: center; padding: 40px;">Chưa có đơn hàng nào gần đây.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="o" items="${recentOrders}">
                                        <tr>
                                            <td>#${o.maDH}</td>
                                            <td>${o.tenNguoiNhan}</td>
                                            <td><fmt:formatDate value="${o.ngayDat}"
                                                                pattern="dd/MM/yyyy HH:mm" /></td>
                                            <td class="right"><fmt:formatNumber
                                                    value="${o.tongThanhToan}" type="number" /></td>
                                            <td><c:choose>
                                                    <c:when test="${o.trangThai == 'DON_HANG_MOI'}">
                                                        <span class="badge b-new">Mới tạo</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'DA_XAC_NHAN'}">
                                                        <span class="badge b-confirm">Đã xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'DANG_GIAO'}">
                                                        <span class="badge b-ship">Đang giao</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'DA_GIAO'}">
                                                        <span class="badge b-done">Đã giao</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'DA_HUY'}">
                                                        <span class="badge b-cancel">Đã hủy</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'TRA_HANG'}">
                                                        <span class="badge b-return">Trả hàng</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'HOAN_TIEN'}">
                                                        <span class="badge b-refund">Hoàn tiền</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'CHO_XAC_NHAN'}">
                                                        <span class="badge b-ship">Chờ xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${o.trangThai == 'DANG_XU_LY'}">
                                                        <span class="badge b-ship">Đang xử lý</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge">${o.trangThai}</span>
                                                    </c:otherwise>
                                                </c:choose></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>

                    </table>
                </div>
            </section>
        </div>
    </main>
</div>