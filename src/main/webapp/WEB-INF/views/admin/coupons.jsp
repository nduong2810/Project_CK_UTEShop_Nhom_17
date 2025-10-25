<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
:root {
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

.grid {
	display: grid;
	grid-template-columns: 1fr 2fr;
	gap: 16px
}

.panel {
	background: var(--card);
	border: 1px solid var(--bd);
	border-radius: var(--r)
}

.panel-hd {
	padding: 12px 16px;
	border-bottom: 1px solid var(--bd);
	font-weight: 700
}

.panel-bd {
	padding: 12px 16px
}

.input, .select {
	height: 36px;
	padding: 0 10px;
	border: 1px solid var(--bd);
	border-radius: 8px;
	background: #fff;
	width: 100%
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
			<div class="title">Mã giảm giá</div>
			<div class="sub">Chương trình khuyến mãi: giảm sản phẩm / phí
				vận chuyển.</div>

			<div class="grid">
				<div class="panel">
					<div class="panel-hd">Tạo / Sửa</div>
					<div class="panel-bd"
						style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px">
						<input class="input" placeholder="Mã code"> <input
							class="input" placeholder="Mã số CT"> <input
							class="input" style="grid-column: span 2"
							placeholder="Tên chương trình"> <select class="select"><option
								value="GIAM_TIEN">Giảm tiền</option>
							<option value="GIAM_PHI_SHIP">Giảm phí VC</option>
							<option value="PHAN_TRAM">Giảm %</option></select> <input class="input"
							type="number" step="1000" placeholder="Giá trị giảm"> <input
							class="input" type="date"><input class="input"
							type="date"> <input class="input" type="number"
							placeholder="% tối đa"> <input class="input"
							type="number" step="1000" placeholder="Giá trị tối thiểu">
						<input class="input" type="datetime-local"
							style="grid-column: span 2" placeholder="Hạn sử dụng">
						<div style="grid-column: span 2; display: flex; gap: 8px">
							<button class="btn">Làm mới</button>
							<button class="btn btn-primary">Lưu</button>
						</div>
					</div>
				</div>

				<div class="panel">
					<div class="panel-hd">Danh sách mã</div>
					<div class="panel-bd" style="padding: 0">
						<table>
							<thead>
								<tr>
									<th>#</th>
									<th>Code</th>
									<th>Tên CT</th>
									<th>Loại</th>
									<th>Giá trị</th>
									<th>Thời gian</th>
									<th style="width: 140px">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="7" style="color: #6b7280">Chưa có dữ liệu.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
	</main>
</div>
