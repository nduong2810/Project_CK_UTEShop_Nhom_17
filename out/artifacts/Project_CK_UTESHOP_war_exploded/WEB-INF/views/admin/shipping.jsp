<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
:root {
	--bg: #f5f7fb;
	--border: #e5e7eb;
	--card: #fff;
	--muted: #6b7280;
	--primary: #1a73e8
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
	margin-bottom: 10px;
	flex-wrap: wrap
}

.input, .select {
	height: 38px;
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 0 10px;
	background: #fff
}

.btn {
	height: 38px;
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 0 12px;
	background: #fff;
	cursor: pointer
}

.btn-primary {
	background: #1a73e8;
	color: #fff;
	border-color: transparent
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

.actions {
	display: flex;
	gap: 6px;
	align-items: center
}

.muted {
	color: #6b7280
}

.alert {
	margin-bottom: 12px;
	padding: 10px;
	border-radius: 8px;
	font-size: 14px
}

.alert-ok {
	background: #ecfdf5;
	border: 1px solid #a7f3d0;
	color: #065f46
}

.alert-err {
	background: #fef2f2;
	border: 1px solid #fecaca;
	color: #991b1b
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
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">

			<div class="title">Đơn vị vận chuyển</div>

			<!-- Alerts -->
			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='deleted'}">
				<div class="alert alert-ok">Đã xoá đơn vị vận chuyển.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra. Có thể đơn vị đang
					được dùng trong đơn hàng.</div>
			</c:if>

			<div class="toolbar">
				<div class="muted">Tổng: ${totalShippings} đơn vị</div>
				<div style="display: flex; gap: 8px; align-items: center">
					<form method="get"
						style="display: flex; gap: 8px; align-items: center">
						<input class="input" type="text" name="q"
							placeholder="Tìm theo tên..." value="${param_q}"> <select
							class="select" name="sort" onchange="this.form.submit()">
							<option value="name_asc" ${param_sort=='name_asc'?'selected':''}>Tên
								A→Z</option>
							<option value="name_desc"
								${param_sort=='name_desc'?'selected':''}>Tên Z→A</option>
							<option value="fee_asc" ${param_sort=='fee_asc'?'selected':''}>Phí
								↑</option>
							<option value="fee_desc" ${param_sort=='fee_desc'?'selected':''}>Phí
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

					<button class="btn btn-primary"
						onclick="location.href='${pageContext.request.contextPath}/admin/shipping/edit'">
						+ Thêm đơn vị</button>
				</div>
			</div>

			<div class="panel">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 80px">Mã</th>
							<th>Tên đơn vị</th>
							<th style="width: 180px">Phí vận chuyển</th>
							<th style="width: 180px">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="s" items="${shippings}">
							<tr>
								<td>#${s.maVC}</td>
								<td>${s.tenDonVi}</td>
								<td><fmt:formatNumber value="${s.phiVanChuyen}"
										type="number" /> đ</td>
								<td class="actions">
									<button class="input"
										onclick="location.href='${pageContext.request.contextPath}/admin/shipping/edit?id=${s.maVC}'">Sửa</button>

									<form method="post"
										action='${pageContext.request.contextPath}/admin/shipping/delete'
										style="display: inline"
										onsubmit="return confirm('Xoá đơn vị vận chuyển #${s.maVC}? Hành động này không thể hoàn tác.');">
										<input type="hidden" name="id" value="${s.maVC}">
										<button class="input"
											style="border-color: #fecaca; color: #991b1b">Xoá</button>
									</form>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty shippings}">
							<tr>
								<td colspan="4" class="muted">Chưa có dữ liệu.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="sort" value="${param_sort}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="q" value="${param_q}" /> <input
							type="hidden" name="sort" value="${param_sort}" /> <input
							type="hidden" name="pageSize" value="${pageSize}" />
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="sort" value="${param_sort}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>
