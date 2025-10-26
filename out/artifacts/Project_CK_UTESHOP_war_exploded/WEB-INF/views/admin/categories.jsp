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
			<div class="title">Danh mục</div>
			<div class="sub">Tạo/sửa/xóa danh mục và danh mục cha.</div>

			<div class="grid">
				<div class="panel">
					<div class="panel-hd">Thêm / Sửa danh mục</div>
					<div class="panel-bd">
						<div style="display: flex; flex-direction: column; gap: 10px">
							<input class="input" placeholder="Tên danh mục"> <select
								class="select">
								<option value="">-- Không có danh mục cha --</option>
							</select>
							<div style="display: flex; gap: 8px">
								<button class="btn">Làm mới</button>
								<button class="btn btn-primary">Lưu</button>
							</div>
						</div>
					</div>
				</div>

				<div class="panel">
					<div class="panel-hd">Danh mục hiện có</div>
					<div class="panel-bd" style="padding: 0">
						<table>
							<thead>
								<tr>
									<th>#</th>
									<th>Tên</th>
									<th>Danh mục cha</th>
									<th style="width: 140px">Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="4" style="color: #6b7280">Chưa có dữ liệu.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
	</main>
</div>
