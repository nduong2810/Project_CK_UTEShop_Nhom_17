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

.actions {
	display: flex;
	gap: 6px
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
							<th style="width: 160px">Thao tác</th>
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
								<td class="actions">
									<button class="btn"
										onclick="location.href='${pageContext.request.contextPath}/admin/customers/edit?id=${u.maND}'">Sửa</button>
									<!-- Có thể thêm nút Khoá/Mở -> gọi /admin/customers/toggle?id=... -->
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="role" value="${param_role}" /> <input
						type="hidden" name="sort" value="${param_sort}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="q" value="${param_q}" /> <input
							type="hidden" name="role" value="${param_role}" /> <input
							type="hidden" name="sort" value="${param_sort}" /> <input
							type="hidden" name="pageSize" value="${pageSize}" />
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="role" value="${param_role}" /> <input
						type="hidden" name="sort" value="${param_sort}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>
