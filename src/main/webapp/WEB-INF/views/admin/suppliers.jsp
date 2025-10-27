<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

.muted {
	color: #6b7280
}

.actions {
	display: flex;
	gap: 6px;
	flex-wrap: wrap
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

			<div class="title">Nhà cung cấp (Shop)</div>

			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='deleted'}">
				<div class="alert alert-ok">Đã xoá cửa hàng.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra.</div>
			</c:if>
			<c:if test="${param.msg=='notfound'}">
				<div class="alert alert-err">Không tìm thấy cửa hàng.</div>
			</c:if>

			<div class="toolbar">
				<div class="muted">Tổng: ${total} shop</div>
				<div style="display: flex; gap: 8px; align-items: center">
					<form method="get"
						style="display: flex; gap: 8px; align-items: center">
						<input class="input" type="text" name="q" value="${param_q}"
							placeholder="Tìm theo tên / email..."> <select
							class="select" name="pageSize" onchange="this.form.submit()">
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
						onclick="location.href='${pageContext.request.contextPath}/admin/suppliers/edit'">+
						Thêm shop</button>
				</div>
			</div>

			<div class="panel">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 80px">Mã</th>
							<th>Tên shop</th>
							<th style="width: 140px">Điện thoại</th>
							<th style="width: 220px">Email</th>
							<th style="width: 160px">Chiết khấu (%)</th>
							<th style="width: 120px">Trạng thái</th>
							<th style="width: 260px">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="s" items="${shops}">
							<tr>
								<td>#${s.maCH}</td>
								<td>${s.tenCH}</td>
								<td>${s.soDienThoai}</td>
								<td>${s.email}</td>
								<td><c:choose>
										<c:when test="${s.tyLeChietKhau != null}">${s.tyLeChietKhau}</c:when>
										<c:otherwise>
											<span class="muted">Chưa đặt</span>
										</c:otherwise>
									</c:choose></td>
								<td>${s.trangThai ? 'Hoạt động' : 'Tạm tắt'}</td>
								<td class="actions">
									<button class="input"
										onclick="location.href='${pageContext.request.contextPath}/admin/suppliers/edit?id=${s.maCH}'">Sửa</button>

									<!-- XÓA: dùng chung /admin/suppliers (op=delete) -->
									<form method="post"
										action="${pageContext.request.contextPath}/admin/suppliers"
										onsubmit="return confirm('Xoá cửa hàng #${s.maCH}?');"
										style="display: inline">
										<input type="hidden" name="op" value="delete" /> <input
											type="hidden" name="id" value="${s.maCH}" />
										<button class="input"
											style="border-color: #fecaca; color: #991b1b">Xoá</button>
									</form>

									<button class="input"
										onclick="location.href='${pageContext.request.contextPath}/admin/suppliers/products?shopId=${s.maCH}'">
										Sản phẩm</button>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty shops}">
							<tr>
								<td colspan="7" class="muted">Chưa có dữ liệu.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="q" value="${param_q}" /> <input
							type="hidden" name="pageSize" value="${pageSize}" />
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>
