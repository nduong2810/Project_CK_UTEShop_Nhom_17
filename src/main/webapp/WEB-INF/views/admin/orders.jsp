<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
:root {
	--gap: 16px;
	--bd: #e5e7eb;
	--bg: #f5f7fb;
	--card: #fff;
	--muted: #6b7280;
	--primary: #0b57d0;
	--r: 12px
}

.admin-content {
	flex: 1;
	min-width: 0;
	background: var(--bg)
}

.wrap {
	padding: 16px
}

.title {
	font-weight: 700;
	font-size: 20px;
	margin: 8px 0 4px
}

.sub {
	color: var(--muted);
	font-size: 13px;
	margin-bottom: 16px
}

.toolbar {
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
	margin-bottom: 12px
}

.input, .select {
	height: 36px;
	padding: 0 10px;
	border: 1px solid var(--bd);
	border-radius: 8px;
	background: #fff
}

.btn {
	height: 36px;
	padding: 0 12px;
	border: 1px solid var(--bd);
	border-radius: 8px;
	background: #fff;
	cursor: pointer
}

.btn-primary {
	background: var(--primary);
	color: #fff;
	border-color: transparent
}

.panel {
	background: var(--card);
	border: 1px solid var(--bd);
	border-radius: var(--r);
	overflow: hidden
}

table {
	width: 100%;
	border-collapse: collapse
}

th, td {
	padding: 10px 12px;
	border-top: 1px solid var(--bd);
	font-size: 14px
}

th {
	background: #fafafa;
	text-align: left
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>
	<main class="admin-content">
		<div class="wrap">
			<div class="title">Đơn hàng</div>
			<div class="sub">Theo dõi trạng thái và doanh thu.</div>

			<div class="toolbar">
				<input class="input" style="min-width: 220px"
					placeholder="Mã đơn / tên / sđt"> <select class="select">
					<option value="">Tất cả trạng thái</option>
					<option>Mới tạo</option>
					<option>Đã xác nhận</option>
					<option>Đang giao</option>
					<option>Hoàn tất</option>
					<option>Đã hủy</option>
				</select> <input class="input" type="date"> <input class="input"
					type="date">
				<button class="btn">Lọc</button>
				<div style="flex: 1"></div>
				<button class="btn">Xuất Excel</button>
			</div>

			<div class="panel">
				<table>
					<thead>
						<tr>
							<th>Mã đơn</th>
							<th>Khách hàng</th>
							<th>Ngày đặt</th>
							<th>Thanh toán</th>
							<th>Trạng thái</th>
							<th style="width: 140px">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6" style="color: #6b7280">Chưa có dữ liệu.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</main>
</div>
