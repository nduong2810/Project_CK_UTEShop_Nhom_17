<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Nếu dùng javax JSTL (Tomcat 9-): đổi dòng dưới thành:
     <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
--%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
	margin-bottom: 12px;
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

.badge {
	display: inline-flex;
	align-items: center;
	padding: 4px 10px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700
}

.badge-gray {
	background: #f3f4f6;
	color: #374151
}

.badge-blue {
	background: #dbeafe;
	color: #1d4ed8
}

.badge-amber {
	background: #fef3c7;
	color: #92400e
}

.badge-green {
	background: #dcfce7;
	color: #166534
}

.badge-red {
	background: #fee2e2;
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

.actions {
	display: flex;
	gap: 8px;
	align-items: center;
	flex-wrap: wrap
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">

			<div class="title">Đơn hàng</div>

			<c:if test="${param.msg=='updated'}">
				<div class="alert alert-ok">Đã cập nhật trạng thái đơn.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra.</div>
			</c:if>

			<!-- Bộ lọc -->
			<div class="toolbar">
				<form method="get"
					style="display: flex; gap: 8px; align-items: center; flex-wrap: wrap">
					<input class="input" name="q" value="${param_q}"
						placeholder="Mã đơn / tên / email..."> <select
						class="select" name="status">
						<option value="">-- Trạng thái --</option>
						<option value="Mới tạo" ${param_status=='Mới tạo'?'selected':''}>Mới
							tạo</option>
						<option value="Đã xác nhận"
							${param_status=='Đã xác nhận'?'selected':''}>Đã xác nhận</option>
						<option value="Đang giao"
							${param_status=='Đang giao'?'selected':''}>Đang giao</option>
						<option value="Đã giao" ${param_status=='Đã giao'?'selected':''}>Đã
							giao</option>
						<option value="Đã huỷ" ${param_status=='Đã huỷ'?'selected':''}>Đã
							huỷ</option>
						<option value="Trả hàng" ${param_status=='Trả hàng'?'selected':''}>Trả
							hàng</option>
						<option value="Hoàn tiền"
							${param_status=='Hoàn tiền'?'selected':''}>Hoàn tiền</option>
					</select> <input class="input" type="date" name="from" value="${param_from}" />
					<input class="input" type="date" name="to" value="${param_to}" />
					<select class="select" name="pageSize">
						<option value="10" ${pageSize==10?'selected':''}>10 /
							trang</option>
						<option value="20" ${pageSize==20?'selected':''}>20 /
							trang</option>
						<option value="50" ${pageSize==50?'selected':''}>50 /
							trang</option>
					</select>
					<button class="btn">Lọc</button>
				</form>

				<div class="badge badge-gray">Tổng: ${total} đơn</div>
			</div>

			<!-- Bảng -->
			<div class="panel">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 100px">Mã đơn</th>
							<th>Khách hàng</th>
							<th style="width: 160px">Ngày đặt</th>
							<th style="width: 140px">Hình thức TT</th>
							<th style="width: 160px">Tổng thanh toán</th>
							<th style="width: 170px">Trạng thái</th>
							<th style="width: 220px">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="o" items="${orders}">
							<tr>
								<td>#${o.maDH}</td>
								<td>
									<div>${o.nguoiDung.hoTen}</div>
									<div class="muted" style="font-size: 12px">${o.nguoiDung.email}</div>
								</td>
								<td><fmt:formatDate value="${o.ngayDat}"
										pattern="dd/MM/yyyy HH:mm" /></td>
								<td>${empty o.phuongThucThanhToan ? '—' : o.phuongThucThanhToan}</td>
								<td><fmt:formatNumber value="${o.tongThanhToan}"
										type="number" maxFractionDigits="0" />đ</td>

								<!-- Hiển thị trạng thái Enum → nhãn + màu -->
								<td><c:choose>
										<c:when test="${o.trangThai == 'CHO_XAC_NHAN'}">
											<span class="badge bg-info">Chờ xác nhận</span>
										</c:when>
										<c:when test="${o.trangThai == 'DA_XAC_NHAN'}">
											<span class="badge bg-warning">Đã xác nhận</span>
										</c:when>
										<c:when test="${o.trangThai == 'DANG_CHUAN_BI'}">
											<span class="badge bg-primary">Đang chuẩn bị</span>
										</c:when>
										<c:when test="${o.trangThai == 'DANG_GIAO'}">
											<span class="badge bg-primary">Đang giao</span>
										</c:when>
										<c:when test="${o.trangThai == 'DA_GIAO'}">
											<span class="badge bg-success">Đã giao</span>
										</c:when>
										<c:when test="${o.trangThai == 'HOAN_THANH'}">
											<span class="badge bg-success">Hoàn thành</span>
										</c:when>
										<c:when test="${o.trangThai == 'DA_HUY'}">
											<span class="badge badge-red">Đã huỷ</span>
										</c:when>
										<c:when test="${o.trangThai == 'TRA_HANG'}">
											<span class="badge badge-red">Trả hàng</span>
										</c:when>
										<c:when test="${o.trangThai == 'HOAN_TIEN'}">
											<span class="badge badge-blue">Hoàn tiền</span>
										</c:when>
										<c:when test="${o.trangThai == 'CHO_XAC_NHAN'}">
											<span class="badge badge-blue">Chờ xác nhận</span>
										</c:when>
										<c:when test="${o.trangThai == 'DANG_XU_LY'}">
											<span class="badge badge-blue">Đang Xử Lý</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-gray">—</span>
										</c:otherwise>
									</c:choose></td>

								<td class="actions">
									<!-- cập nhật trạng thái nhanh -->
									<form method="post"
										action="${pageContext.request.contextPath}/admin/orders"
										style="display: flex; gap: 6px; align-items: center">
										<input type="hidden" name="op" value="updateStatus" /> <input
											type="hidden" name="id" value="${o.maDH}" /> <select
											name="newStatus" class="select" style="height: 34px">
											<option ${o.trangThai=='CHO_XAC_NHAN'?'selected':''}>Chờ xác nhận</option>
											<option ${o.trangThai=='DA_XAC_NHAN'?'selected':''}>Đã xác nhận</option>
											<option ${o.trangThai=='DANG_CHUAN_BI'?'selected':''}>Đang chuẩn bị</option>
											<option ${o.trangThai=='DANG_GIAO'?'selected':''}>Đang giao</option>
											<option ${o.trangThai=='DA_GIAO'?'selected':''}>Đã giao</option>
											<option ${o.trangThai=='HOAN_THANH'?'selected':''}>Hoàn thành</option>
											<option ${o.trangThai=='DA_HUY'?'selected':''}>Đã hủy</option>
											<option ${o.trangThai=='TRA_HANG'?'selected':''}>Trả hàng</option>
											<option ${o.trangThai=='HOAN_TIEN'?'selected':''}>Hoàn tiền</option>
										</select>
										<button class="btn">Lưu</button>
									</form>

									<button class="btn"
										onclick="location.href='${pageContext.request.contextPath}/admin/orders/view?id=${o.maDH}'">Xem</button>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty orders}">
							<tr>
								<td colspan="7" class="muted">Chưa có dữ liệu.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<!-- Phân trang -->
			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="status" value="${param_status}" /> <input
						type="hidden" name="from" value="${param_from}" /> <input
						type="hidden" name="to" value="${param_to}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="q" value="${param_q}" /> <input
							type="hidden" name="status" value="${param_status}" /> <input
							type="hidden" name="from" value="${param_from}" /> <input
							type="hidden" name="to" value="${param_to}" /> <input
							type="hidden" name="pageSize" value="${pageSize}" />
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="q" value="${param_q}" /> <input
						type="hidden" name="status" value="${param_status}" /> <input
						type="hidden" name="from" value="${param_from}" /> <input
						type="hidden" name="to" value="${param_to}" /> <input
						type="hidden" name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>
