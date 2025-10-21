<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>UTESHOP Admin • Đơn hàng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
:root {
	--w: 260px
}

body {
	min-height: 100vh;
	background: #f6f7fb
}

.hdr {
	background: linear-gradient(90deg, #5b6cfb, #7a4bff 40%, #a64fff);
	color: #fff;
	position: sticky;
	top: 0;
	z-index: 1040
}

.side {
	width: var(--w);
	position: fixed;
	top: 64px;
	left: 0;
	bottom: 0;
	background: #0d6efd;
	color: #fff;
	overflow: auto
}

.side a {
	color: #dbe9ff;
	border-radius: .5rem;
	margin: 4px 8px
}

.side a.active, .side a:hover {
	background: rgba(255, 255, 255, .15);
	color: #fff
}

.rz {
	position: fixed;
	top: 64px;
	bottom: 0;
	left: calc(var(--w)- 3px);
	width: 6px;
	cursor: col-resize
}

.main {
	margin-left: var(--w);
	padding: 20px
}

@media ( max-width :991.98px) {
	.side {
		transform: translateX(-100%);
		transition: .2s
	}
	.side.show {
		transform: translateX(0)
	}
	.rz {
		display: none
	}
	.main {
		margin-left: 0
	}
}

.collapsed .side {
	width: 72px
}

.collapsed .main {
	margin-left: 72px
}

.collapsed .side .lbl {
	display: none
}
</style>
</head>
<body>

	<aside class="side" id="side">
		<ul class="nav flex-column mt-2">
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/home"><i
					class="bi bi-speedometer2 me-2"></i><span class="lbl">Bảng
						điều khiển</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/products"><i
					class="bi bi-box-seam me-2"></i><span class="lbl">Sản phẩm</span></a></li>
			<li><a class="nav-link active"
				href="${pageContext.request.contextPath}/admin/orders"><i
					class="bi bi-receipt me-2"></i><span class="lbl">Đơn hàng</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/customers"><i
					class="bi bi-people me-2"></i><span class="lbl">Khách hàng</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/suppliers"><i
					class="bi bi-buildings me-2"></i><span class="lbl">Nhà cung
						cấp</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/settings"><i
					class="bi bi-gear me-2"></i><span class="lbl">Cài đặt</span></a></li>
		</ul>
	</aside>
	<div class="rz d-none d-lg-block" id="rz"></div>

	<main class="main container-fluid">
		<!-- set: orders (JOIN DonViVanChuyen), page,totalPages,totalItems -->
		<form class="card shadow-sm mb-3"
			action="${pageContext.request.contextPath}/admin/orders">
			<div class="card-body row g-2 align-items-end">
				<div class="col-md-4">
					<label class="form-label">Từ khóa</label><input
						class="form-control" name="q" value="${param.q}">
				</div>
				<div class="col-md-3">
					<label class="form-label">Trạng thái</label><select
						class="form-select" name="status"><option value="">Tất
							cả</option>
						<c:set var="st" value="${param.status}" />
						<option ${st=='Mới tạo'?'selected':''}>Mới tạo</option>
						<option ${st=='Đã xác nhận'?'selected':''}>Đã xác nhận</option>
						<option ${st=='Đang giao'?'selected':''}>Đang giao</option>
						<option ${st=='Hoàn tất'?'selected':''}>Hoàn tất</option>
						<option ${st=='Đã hủy'?'selected':''}>Đã hủy</option></select>
				</div>
				<div class="col-md-2">
					<label class="form-label">Từ ngày</label><input type="date"
						class="form-control" name="from" value="${param.from}">
				</div>
				<div class="col-md-2">
					<label class="form-label">Đến ngày</label><input type="date"
						class="form-control" name="to" value="${param.to}">
				</div>
				<div class="col-md-1 d-grid">
					<button class="btn btn-primary">
						<i class="bi bi-funnel me-1"></i>Lọc
					</button>
				</div>
			</div>
		</form>

		<div class="card shadow-sm">
			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th>#</th>
							<th>Mã đơn</th>
							<th>Khách hàng</th>
							<th>Ngày đặt</th>
							<th>Tổng</th>
							<th>Thanh toán</th>
							<th>Vận chuyển</th>
							<th>Trạng thái</th>
							<th class="text-end">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="o" items="${orders}" varStatus="i">
							<tr>
								<td>${i.index+1}</td>
								<td><b>DH${o.maDH}</b></td>
								<td>${o.tenNguoiNhan}<div class="small text-muted">${o.soDienThoaiNhanHang}</div></td>
								<td><fmt:formatDate value="${o.ngayDat}"
										pattern="dd/MM/yyyy HH:mm" /></td>
								<td><fmt:formatNumber value="${o.tongThanhToan}"
										type="currency" currencySymbol="₫" /></td>
								<td>${o.hinhThucTT}</td>
								<td>${o.tenDonViVC}</td>
								<td><span
									class="badge ${o.trangThai=='Hoàn tất'?'bg-success':o.trangThai=='Đang giao'?'bg-primary':o.trangThai=='Đã hủy'?'bg-danger':o.trangThai=='Đã xác nhận'?'bg-info text-dark':'bg-secondary'}">${o.trangThai}</span></td>
								<td class="text-end"><a
									class="btn btn-sm btn-outline-secondary"
									href="${pageContext.request.contextPath}/admin/orders/view?id=${o.maDH}"><i
										class="bi bi-eye"></i></a> <c:if test="${o.trangThai=='Mới tạo'}">
										<form class="d-inline" method="post"
											action="${pageContext.request.contextPath}/admin/orders/confirm">
											<input type="hidden" name="id" value="${o.maDH}">
											<button class="btn btn-sm btn-outline-primary">
												<i class="bi bi-check2-circle"></i>
											</button>
										</form>
										<form class="d-inline" method="post"
											action="${pageContext.request.contextPath}/admin/orders/cancel"
											onsubmit="return confirm('Hủy đơn?')">
											<input type="hidden" name="id" value="${o.maDH}">
											<button class="btn btn-sm btn-outline-danger">
												<i class="bi bi-x-circle"></i>
											</button>
										</form>
									</c:if></td>
							</tr>
						</c:forEach>
						<c:if test="${empty orders}">
							<tr>
								<td colspan="9" class="text-center py-4 text-muted">Chưa có
									dữ liệu</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<div
				class="card-body d-flex justify-content-between align-items-center">
				<div class="text-muted">
					Tổng: <b>${totalItems}</b> đơn
				</div>
				<nav>
					<ul class="pagination mb-0">
						<li class="page-item ${page<=1?'disabled':''}"><a
							class="page-link"
							href="?page=${page-1}&q=${param.q}&status=${param.status}&from=${param.from}&to=${param.to}">Trước</a></li>
						<c:forEach var="p" begin="1" end="${totalPages}">
							<li class="page-item ${p==page?'active':''}"><a
								class="page-link"
								href="?page=${p}&q=${param.q}&status=${param.status}&from=${param.from}&to=${param.to}">${p}</a></li>
						</c:forEach>
						<li class="page-item ${page>=totalPages?'disabled':''}"><a
							class="page-link"
							href="?page=${page+1}&q=${param.q}&status=${param.status}&from=${param.from}&to=${param.to}">Sau</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</main>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>const r=document.documentElement,sw=w=>r.style.setProperty('--w',w+'px');const s=+localStorage.getItem('w');if(s&&s>=180&&s<=480)sw(s);const sb=document.getElementById('side'),rz=document.getElementById('rz'),btn=document.getElementById('btn');const mq=window.matchMedia('(max-width:991.98px)');const sync=()=>rz.style.display=mq.matches?'none':'block';mq.addEventListener('change',sync);sync();btn?.addEventListener('click',()=>{if(mq.matches)sb.classList.toggle('show');else{document.body.classList.toggle('collapsed');sw(document.body.classList.contains('collapsed')?72:(s||260));}});let d=false,x=0,w0=0;rz?.addEventListener('pointerdown',e=>{if(mq.matches||document.body.classList.contains('collapsed'))return;d=true;x=e.clientX;w0=parseInt(getComputedStyle(r).getPropertyValue('--w'));rz.setPointerCapture(e.pointerId)});rz?.addEventListener('pointermove',e=>{if(!d)return;sw(Math.min(480,Math.max(180,w0+(e.clientX-x))))});function up(){if(!d)return;d=false;localStorage.setItem('w',parseInt(getComputedStyle(r).getPropertyValue('--w')))}rz?.addEventListener('pointerup',up);rz?.addEventListener('pointercancel',up);</script>
</body>
</html>
