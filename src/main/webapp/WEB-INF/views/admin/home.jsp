<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- Nếu đã include header tổng ở layout thì không bọc <html> ở đây --%>

<style>
:root {
	--admin-gap: 16px;
	--admin-border: #e5e7eb;
	--admin-card: #fff;
	--admin-muted: #6b7280;
	--admin-primary: #0b57d0;
	--admin-radius: 12px
}

.admin-content {
	flex: 1;
	min-width: 0;
	background: #f5f7fb
}

.admin-container {
	padding: 16px
}

.admin-page-title {
	font-size: 20px;
	font-weight: 700;
	margin: 8px 0 4px;
	color: #111827
}

.admin-sub {
	color: var(--admin-muted);
	font-size: 13px;
	margin-bottom: 16px
}

.kpi-grid {
	display: grid;
	grid-template-columns: repeat(12, 1fr);
	gap: var(--admin-gap);
	margin-bottom: 16px
}

.kpi-card {
	grid-column: span 3;
	background: var(--admin-card);
	border: 1px solid var(--admin-border);
	border-radius: var(--admin-radius);
	padding: 16px;
	display: flex;
	gap: 12px;
	align-items: center;
	min-height: 84px
}

.kpi-ico {
	width: 44px;
	height: 44px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #eef2ff;
	color: var(--admin-primary);
	font-size: 20px;
	font-weight: 700
}

.kpi-meta {
	display: flex;
	flex-direction: column;
	gap: 4px
}

.kpi-title {
	color: #374151;
	font-size: 12px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: .3px
}

.kpi-value {
	font-size: 28px;
	font-weight: 800;
	color: #111827;
	line-height: 1
}

@media ( max-width :1280px) {
	.kpi-card {
		grid-column: span 6
	}
}

@media ( max-width :640px) {
	.kpi-card {
		grid-column: span 12
	}
}

.panel {
	background: #fff;
	border: 1px solid var(--admin-border);
	border-radius: var(--admin-radius);
	overflow: hidden
}

.panel-hd {
	padding: 12px 16px;
	border-bottom: 1px solid var(--admin-border);
	display: flex;
	align-items: center;
	gap: 10px;
	justify-content: space-between
}

.panel-title {
	font-weight: 700
}

.panel-actions {
	display: flex;
	gap: 8px
}

.btn {
	height: 34px;
	padding: 0 12px;
	border: 1px solid var(--admin-border);
	background: #fff;
	border-radius: 8px;
	font-size: 14px;
	cursor: pointer
}

.btn-primary {
	border-color: transparent;
	background: var(--admin-primary);
	color: #fff
}

.table {
	width: 100%;
	border-collapse: collapse
}

.table th, .table td {
	border-top: 1px solid var(--admin-border);
	padding: 10px 12px;
	font-size: 14px;
	color: #111827
}

.table th {
	background: #fafafa;
	text-align: left;
	color: #374151;
	font-weight: 700
}

.muted {
	color: var(--admin-muted)
}

.mt-16 {
	margin-top: 16px
}

/* Trạng thái */
.badge {
	display: inline-block;
	padding: 3px 8px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700
}

.b-new {
	background: #eef2ff;
	color: #0b57d0
}

.b-confirm {
	background: #ecfeff;
	color: #0284c7
}

.b-ship {
	background: #fff7ed;
	color: #ea580c
}

.b-done {
	background: #ecfdf5;
	color: #059669
}

.b-cancel {
	background: #fef2f2;
	color: #dc2626
}

.b-return {
	background: #f5f3ff;
	color: #6d28d9
}

.b-refund {
	background: #fdf2f8;
	color: #be185d
}

.right {
	text-align: right
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">
			<div class="admin-page-title">Bảng điều khiển</div>

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
			<section class="panel mt-16">
				<div class="panel-hd">
					<div class="panel-title">Đơn hàng gần đây</div>
					<div class="panel-actions">
						<button class="btn"
							onclick="location.href='<%=request.getContextPath()%>/admin/orders'">Xem
							tất cả</button>
						<button class="btn btn-primary"
							onclick="location.href='<%=request.getContextPath()%>/admin/orders'">Quản
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
										<td class="muted" colspan="5">Chưa có dữ liệu (gắn sau).</td>
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
