<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
:root {
	--bg: #f5f7fb;
	--border: #e5e7eb;
	--card: #fff;
	--muted: #6b7280;
	--primary: #1a73e8;
	--radius: 16px
}

.admin-shell {
	display: flex;
	min-height: 100vh;
	background: var(--bg)
}

.admin-content {
	flex: 1;
	min-width: 0
}

.admin-container {
	padding: 16px
}

.title {
	font-size: 20px;
	font-weight: 800;
	margin: 8px 0 12px;
	color: #111827
}

.toolbar {
	display: flex;
	gap: 10px;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px
}

.input, .select {
	height: 38px;
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 0 10px;
	background: #fff
}

.panel {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 16px;
	overflow: hidden
}

.table {
	width: 100%;
	border-collapse: collapse
}

.table th, .table td {
	border-top: 1px solid var(--border);
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

.badge {
	padding: 4px 8px;
	border-radius: 999px;
	font-size: 12px
}

.badge-ok {
	background: #e6f7ee;
	color: #0f5132
}

.badge-off {
	background: #fdecec;
	color: #7f1d1d
}

.btn {
	height: 32px;
	border-radius: 8px;
	border: 1px solid var(--border);
	background: #fff;
	cursor: pointer;
	padding: 0 10px
}

.btn-primary {
	background: #1a73e8;
	color: #fff;
	border-color: transparent
}

.btn-danger {
	border-color: #fecaca;
	color: #991b1b;
	background: #fff
}

.actions {
	display: flex;
	gap: 6px;
	flex-wrap: wrap
}

.pagination {
	display: flex;
	gap: 8px;
	justify-content: center;
	align-items: center;
	margin: 16px 0
}

.pbtn {
	min-width: 42px;
	height: 38px;
	border: 1px solid var(--border);
	background: #fff;
	border-radius: 8px;
	cursor: pointer
}

.pbtn.active {
	background: #1a73e8;
	color: #fff;
	border-color: transparent
}

.muted {
	color: #6b7280
}

/* ----- Appeal mini form ----- */
.appeal-box {
	display: none;
	margin-top: 8px;
	border: 1px dashed #fca5a5;
	background: #fff7f7;
	padding: 10px;
	border-radius: 10px
}

.appeal-box textarea {
	width: 100%;
	min-height: 70px;
	border: 1px solid var(--border);
	border-radius: 8px;
	padding: 8px;
	resize: vertical
}

.appeal-actions {
	display: flex;
	gap: 8px;
	justify-content: flex-end;
	margin-top: 8px
}

.appeal-link {
	color: #b91c1c;
	font-size: 13px;
	text-decoration: underline;
	cursor: pointer;
	background: transparent;
	border: 0;
	padding: 0
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">

			<div class="title">Khách hàng</div>

			<div class="toolbar">
				<div class="muted">Tổng: ${totalUsers} người dùng</div>
				<form method="get" style="display: flex; gap: 8px">
					<input class="input" type="text" name="q"
						placeholder="Tìm tên/username/email..." value="${param_q}">
					<select class="select" name="role" onchange="this.form.submit()">
						<option value="">Vai trò</option>
						<option value="USER" ${param_role=='USER'?'selected':''}>USER</option>
						<option value="VENDOR" ${param_role=='VENDOR'?'selected':''}>VENDOR</option>
						<option value="ADMIN" ${param_role=='ADMIN'?'selected':''}>ADMIN</option>
						<option value="SHIPPER" ${param_role=='SHIPPER'?'selected':''}>SHIPPER</option>
					</select> <select class="select" name="sort" onchange="this.form.submit()">
						<option value="">Sắp xếp</option>
						<option value="date_desc" ${param_sort=='date_desc'?'selected':''}>Mới
							nhất</option>
						<option value="name_asc" ${param_sort=='name_asc'?'selected':''}>Tên
							A→Z</option>
						<option value="name_desc" ${param_sort=='name_desc'?'selected':''}>Tên
							Z→A</option>
						<option value="id_asc" ${param_sort=='id_asc'?'selected':''}>Mã
							↑</option>
						<option value="id_desc" ${param_sort=='id_desc'?'selected':''}>Mã
							↓</option>
					</select> <select class="select" name="pageSize"
						onchange="this.form.submit()">
						<option value="10" ${pageSize==10?'selected':''}>10 /
							trang</option>
						<option value="20" ${pageSize==20?'selected':''}>20 /
							trang</option>
						<option value="50" ${pageSize==50?'selected':''}>50 /
							trang</option>
					</select>
					<button class="btn">Lọc</button>
				</form>
			</div>

			<div class="panel">
				<table class="table">
					<thead>
						<tr>
							<th>Mã</th>
							<th>Họ tên</th>
							<th>Username</th>
							<th>Email</th>
							<th>Vai trò</th>
							<th>Trạng thái</th>
							<th>Ngày tạo</th>
							<th style="width: 260px">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="u" items="${users}">
							<tr>
								<td>#${u.maND}</td>
								<td>${u.hoTen}</td>
								<td>${u.tenDangNhap}</td>
								<td>${u.email}</td>
								<td>${u.vaiTro}</td>
								<td><c:choose>
										<c:when test="${u.trangThai}">
											<span class="badge badge-ok">Hoạt động</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-off">Khoá</span>
										</c:otherwise>
									</c:choose></td>
								<td><fmt:formatDate value="${u.ngayTao}"
										pattern="dd/MM/yyyy HH:mm" /></td>
								<td>
									<div class="actions">
										<button class="btn"
											onclick="location.href='${pageContext.request.contextPath}/admin/customers/edit?id=${u.maND}'">Sửa</button>

										<!-- Nếu đang bị khoá: hiện nút Khiếu nại + form mini -->
										<c:if test="${!u.trangThai}">
											<button class="btn btn-primary"
												onclick="location.href='${pageContext.request.contextPath}/admin/appeals?status=PENDING&userId=${u.maND}'">
												Duyệt khiếu nại</button>
										</c:if>
									</div> <!-- Appeal mini form (ẩn/hiện) --> <c:if
										test="${!u.trangThai}">
										<div id="appeal-${u.maND}" class="appeal-box">
											<form method="post"
												action="${pageContext.request.contextPath}/admin/customers/appeal">
												<input type="hidden" name="userId" value="${u.maND}">
												<label class="muted"
													style="display: block; margin-bottom: 6px"> Ghi rõ
													lý do bạn cần mở khoá tài khoản: </label>
												<textarea name="message"
													placeholder="Ví dụ: tài khoản bị khoá nhầm, tôi có thể cung cấp thêm thông tin để xác minh..."></textarea>
												<div class="appeal-actions">
													<button type="button" class="btn"
														onclick="toggleAppeal('${u.maND}')">Huỷ</button>
													<button class="btn btn-primary" type="submit">Gửi
														khiếu nại</button>
												</div>
											</form>
										</div>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}"> <input
						type="hidden" name="role" value="${param_role}"> <input
						type="hidden" name="sort" value="${param_sort}"> <input
						type="hidden" name="pageSize" value="${pageSize}">
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="q" value="${param_q}"> <input
							type="hidden" name="role" value="${param_role}"> <input
							type="hidden" name="sort" value="${param_sort}"> <input
							type="hidden" name="pageSize" value="${pageSize}">
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}"> <input
						type="hidden" name="role" value="${param_role}"> <input
						type="hidden" name="sort" value="${param_sort}"> <input
						type="hidden" name="pageSize" value="${pageSize}">
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>

<script>
	function toggleAppeal(id) {
		const box = document.getElementById('appeal-' + id);
		if (!box)
			return;
		box.style.display = (box.style.display === 'block') ? 'none' : 'block';
	}
</script>
