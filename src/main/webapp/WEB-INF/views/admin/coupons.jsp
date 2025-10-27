<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

.status {
	padding: 3px 8px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700
}

.st-ongoing {
	background: #ecfdf5;
	color: #065f46
}

.st-upcoming {
	background: #eff6ff;
	color: #1e40af
}

.st-expired {
	background: #fef2f2;
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

			<div class="title">Mã giảm giá</div>

			<!-- Alerts -->
			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='deleted'}">
				<div class="alert alert-ok">Đã xoá mã giảm giá.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra.</div>
			</c:if>
			<c:if test="${param.msg=='code_exists'}">
				<div class="alert alert-err">Mã code đã tồn tại.</div>
			</c:if>

			<div class="toolbar">
				<div class="muted">Tổng: ${totalCoupons} mã</div>
				<div style="display: flex; gap: 8px; align-items: center">
					<form method="get"
						style="display: flex; gap: 8px; align-items: center">
						<input class="input" type="text" name="q"
							placeholder="Tìm theo tên / mã code..." value="${param_q}">
						<select class="select" name="type" onchange="this.form.submit()">
							<option value="">Loại giảm</option>
							<option value="amount" ${param_type=='amount'?'selected':''}>Giảm
								tiền</option>
							<option value="percent" ${param_type=='percent'?'selected':''}>Giảm
								%</option>
						</select> <select class="select" name="status"
							onchange="this.form.submit()">
							<option value="">Trạng thái</option>
							<option value="ongoing" ${param_status=='ongoing'?'selected':''}>Đang
								áp dụng</option>
							<option value="upcoming"
								${param_status=='upcoming'?'selected':''}>Sắp diễn ra</option>
							<option value="expired" ${param_status=='expired'?'selected':''}>Hết
								hạn</option>
						</select> <select class="select" name="sort" onchange="this.form.submit()">
							<option value="start_desc"
								${param_sort=='start_desc'?'selected':''}>Mới nhất</option>
							<option value="start_asc"
								${param_sort=='start_asc'?'selected':''}>Cũ nhất</option>
							<option value="name_asc" ${param_sort=='name_asc'?'selected':''}>Tên
								A→Z</option>
							<option value="name_desc"
								${param_sort=='name_desc'?'selected':''}>Tên Z→A</option>
							<option value="end_asc" ${param_sort=='end_asc'?'selected':''}>Hết
								hạn ↑</option>
							<option value="end_desc" ${param_sort=='end_desc'?'selected':''}>Hết
								hạn ↓</option>
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
						onclick="location.href='${pageContext.request.contextPath}/admin/coupons/edit'">
						+ Thêm mã</button>
				</div>
			</div>

			<div class="panel">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 70px">Mã</th>
							<th style="width: 140px">Code</th>
							<th>Tên chương trình</th>
							<th style="width: 120px">Loại</th>
							<th style="width: 140px">Giá trị</th>
							<th style="width: 130px">Bắt đầu</th>
							<th style="width: 130px">Kết thúc</th>
							<th style="width: 130px">Trạng thái</th>
							<th style="width: 180px">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="c" items="${coupons}">
							<tr>
								<td>#${c.maGG}</td>
								<td>${c.maCode}</td>
								<td>${c.tenChuongTrinh}</td>
								<td><c:choose>
										<c:when test="${fn:toLowerCase(c.loaiGiam) == 'percent'}">Giảm %</c:when>
										<c:otherwise>Giảm tiền</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${fn:toLowerCase(c.loaiGiam) == 'percent'}">
                    ${c.phanTramGiam}% (Min: <fmt:formatNumber
												value="${c.giaTriToiThieu}" type="number" /> đ)
                  </c:when>
										<c:otherwise>
											<fmt:formatNumber value="${c.giaTriGiam}" type="number" /> đ
                  </c:otherwise>
									</c:choose></td>
								<td><fmt:formatDate value="${c.ngayBatDau}"
										pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatDate value="${c.ngayKetThuc}"
										pattern="dd/MM/yyyy" /></td>
								<td><c:set var="ongoing"
										value="${now.time >= c.ngayBatDau.time && now.time <= c.ngayKetThuc.time}" />
									<c:set var="upcoming" value="${now.time <  c.ngayBatDau.time}" />
									<c:choose>
										<c:when test="${ongoing}">
											<span class="status st-ongoing">Đang áp dụng</span>
										</c:when>
										<c:when test="${upcoming}">
											<span class="status st-upcoming">Sắp diễn ra</span>
										</c:when>
										<c:otherwise>
											<span class="status st-expired">Hết hạn</span>
										</c:otherwise>
									</c:choose></td>
								<td class="actions">
									<button class="input"
										onclick="location.href='${pageContext.request.contextPath}/admin/coupons/edit?id=${c.maGG}'">Sửa</button>
									<form method="post"
										action="${pageContext.request.contextPath}/admin/coupons/delete"
										style="display: inline"
										onsubmit="return confirm('Xoá mã #${c.maGG} (${c.maCode})?');">
										<input type="hidden" name="id" value="${c.maGG}">
										<button class="input"
											style="border-color: #fecaca; color: #991b1b">Xoá</button>
									</form>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty coupons}">
							<tr>
								<td colspan="9" class="muted">Chưa có dữ liệu.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="type" value="${param_type}" /> <input
						type="hidden" name="status" value="${param_status}" /> <input
						type="hidden" name="sort" value="${param_sort}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="q" value="${param_q}" /> <input
							type="hidden" name="type" value="${param_type}" /> <input
							type="hidden" name="status" value="${param_status}" /> <input
							type="hidden" name="sort" value="${param_sort}" /> <input
							type="hidden" name="pageSize" value="${pageSize}" />
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="type" value="${param_type}" /> <input
						type="hidden" name="status" value="${param_status}" /> <input
						type="hidden" name="sort" value="${param_sort}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>
