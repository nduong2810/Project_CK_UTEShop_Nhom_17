<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Nếu bạn đã include header.jsp ở level controller/layout, đừng bọc <html> ở đây --%>

<style>
:root {
	--admin-gap: 16px;
	--admin-border: #e5e7eb;
	--admin-card: #fff;
	--admin-muted: #6b7280;
	--admin-primary: #0b57d0;
	--admin-radius: 12px;
}

.admin-content {
	flex: 1;
	min-width: 0;
	background: #f5f7fb;
}

.admin-container {
	padding: 16px;
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
	min-height: 84px;
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
</style>

<div class="admin-shell">
	<%-- sidebar dùng chung --%>
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">
			<div class="admin-page-title">Bảng điều khiển</div>
			<div class="admin-sub">Tổng quan nhanh hoạt động hệ thống hôm
				nay.</div>

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
						<div class="kpi-value">${revenueToday}</div>
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
								<th>Tổng thanh toán</th>
								<th>Trạng thái</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="muted" colspan="5">Chưa có dữ liệu (gắn sau).</td>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
		</div>
	</main>
</div>
