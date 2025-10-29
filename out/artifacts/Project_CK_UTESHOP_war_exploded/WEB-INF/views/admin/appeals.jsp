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

.badge-p {
	background: #fff7ed;
	color: #9a3412
}

.badge-a {
	background: #e6f7ee;
	color: #0f5132
}

.badge-r {
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

.btn-approve {
	background: #16a34a;
	color: #fff;
	border-color: transparent
}

.btn-reject {
	background: #ef4444;
	color: #fff;
	border-color: transparent
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

.note {
	width: 220px;
	height: 34px;
	border: 1px solid var(--border);
	border-radius: 8px;
	padding: 0 8px
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>
	<main class="admin-content">
		<div class="admin-container">

			<div class="title">Khiếu nại người dùng</div>

			<div class="toolbar">
				<div class="muted">Tổng: ${total} khiếu nại</div>
				<form method="get" style="display: flex; gap: 8px">
					<input class="input" type="text" name="q"
						placeholder="Tìm tên/email/Mã ND..." value="${param_q}"> <select
						class="select" name="status" onchange="this.form.submit()">
						<option value="">Trạng thái</option>
						<option value="PENDING" ${param_status=='PENDING'?'selected':''}>Chờ
							duyệt</option>
						<option value="APPROVED" ${param_status=='APPROVED'?'selected':''}>Đã
							duyệt</option>
						<option value="REJECTED" ${param_status=='REJECTED'?'selected':''}>Từ
							chối</option>
					</select> <select class="select" name="sort" onchange="this.form.submit()">
						<option value="">Sắp xếp</option>
						<option value="date_desc" ${param_sort=='date_desc'?'selected':''}>Mới
							nhất</option>
						<option value="date_asc" ${param_sort=='date_asc'?'selected':''}>Cũ
							nhất</option>
						<option value="id_asc" ${param_sort=='id_asc'?'selected':''}>Mã
							KN ↑</option>
						<option value="id_desc" ${param_sort=='id_desc'?'selected':''}>Mã
							KN ↓</option>
					</select> <input class="input" type="number" name="userId" min="1"
						placeholder="Lọc theo MaND"
						value="${param_userId!=null?param_userId:''}"> <select
						class="select" name="pageSize" onchange="this.form.submit()">
						<option value="10" ${pageSize==10?'selected':''}>10/trang</option>
						<option value="20" ${pageSize==20?'selected':''}>20/trang</option>
						<option value="50" ${pageSize==50?'selected':''}>50/trang</option>
					</select>
					<button class="btn">Lọc</button>
				</form>
			</div>

			<div class="panel">
				<table class="table">
					<thead>
						<tr>
							<th>Mã KN</th>
							<th>Người dùng</th>
							<th>Nội dung</th>
							<th>Ngày gửi</th>
							<th>Trạng thái</th>
							<th>Ghi chú</th>
							<th style="width: 220px">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="k" items="${appeals}">
							<tr>
								<td>#${k.maKN}</td>
								<td>
									<div>${k.nguoiDung.hoTen}(#${k.nguoiDung.maND})</div>
									<div class="muted" style="font-size: 12px">${k.nguoiDung.email}</div>
								</td>
								<td>${k.noiDung}</td>
								<td><fmt:formatDate value="${k.ngayGui}"
										pattern="dd/MM/yyyy HH:mm" /></td>
								<td><c:choose>
										<c:when test="${k.trangThai=='PENDING'}">
											<span class="badge badge-p">Chờ duyệt</span>
										</c:when>
										<c:when test="${k.trangThai=='APPROVED'}">
											<span class="badge badge-a">Đã duyệt</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-r">Từ chối</span>
										</c:otherwise>
									</c:choose></td>
								<td>${k.ghiChu}</td>
								<td><c:if test="${k.trangThai=='PENDING'}">
										<form method="post"
											action="${pageContext.request.contextPath}/admin/appeals/update"
											style="display: flex; gap: 6px; align-items: center; flex-wrap: wrap">
											<input type="hidden" name="id" value="${k.maKN}"> <input
												type="hidden" name="back"
												value="q=${param_q}&status=${param_status}&sort=${param_sort}&page=${currentPage}&pageSize=${pageSize}&userId=${param_userId}">
											<input class="note" type="text" name="note"
												placeholder="Ghi chú xử lý (tuỳ chọn)">
											<button class="btn btn-approve" name="action" value="approve">Duyệt</button>
											<button class="btn btn-reject" name="action" value="reject">Từ
												chối</button>
										</form>
									</c:if> <c:if test="${k.trangThai!='PENDING'}">
										<div class="muted" style="font-size: 12px">Đã xử lý</div>
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}"> <input
						type="hidden" name="status" value="${param_status}"> <input
						type="hidden" name="sort" value="${param_sort}"> <input
						type="hidden" name="pageSize" value="${pageSize}"> <input
						type="hidden" name="userId" value="${param_userId}">
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="q" value="${param_q}"> <input
							type="hidden" name="status" value="${param_status}"> <input
							type="hidden" name="sort" value="${param_sort}"> <input
							type="hidden" name="pageSize" value="${pageSize}"> <input
							type="hidden" name="userId" value="${param_userId}">
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}"> <input
						type="hidden" name="status" value="${param_status}"> <input
						type="hidden" name="sort" value="${param_sort}"> <input
						type="hidden" name="pageSize" value="${pageSize}"> <input
						type="hidden" name="userId" value="${param_userId}">
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>
