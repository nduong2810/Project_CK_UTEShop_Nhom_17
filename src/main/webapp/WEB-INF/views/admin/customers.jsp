<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>UTESHOP Admin • Khách hàng</title>
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
	<header class="hdr">
		<div class="container-fluid d-flex align-items-center py-2">
			<button id="btn" class="btn btn-light me-2 d-lg-none">
				<i class="bi bi-list"></i>
			</button>
			<a href="${pageContext.request.contextPath}/admin/home"
				class="d-flex align-items-center text-white text-decoration-none me-3">
				<img
				src="${pageContext.request.contextPath}/assets/img/logo-uteshop.png"
				style="height: 34px" class="me-2"><b>UTESHOP</b>
			</a>
			<form class="ms-auto d-none d-lg-flex"
				action="${pageContext.request.contextPath}/admin/customers">
				<div class="input-group">
					<input class="form-control" name="q" value="${param.q}"
						placeholder="Tên / Email / SĐT">
					<button class="btn btn-warning">
						<i class="bi bi-search"></i>
					</button>
				</div>
			</form>
		</div>
	</header>
	<aside class="side" id="side">
		<ul class="nav flex-column mt-2">
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/home"><i
					class="bi bi-speedometer2 me-2"></i><span class="lbl">Bảng
						điều khiển</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/products"><i
					class="bi bi-box-seam me-2"></i><span class="lbl">Sản phẩm</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/orders"><i
					class="bi bi-receipt me-2"></i><span class="lbl">Đơn hàng</span></a></li>
			<li><a class="nav-link active"
				href="${pageContext.request.contextPath}/admin/customers"><i
					class="bi bi-people me-2"></i><span class="lbl">Khách hàng</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/suppliers"><i
					class="bi bi-buildings me-2"></i><span class="lbl">Nhà cung
						cấp</span></a></li>
		</ul>
	</aside>
	<div class="rz d-none d-lg-block" id="rz"></div>

	<main class="main container-fluid">
		<!-- set: customers (NguoiDung vaiTro='USER'), page,totalPages,totalItems -->
		<div class="card shadow-sm">
			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th>#</th>
							<th>Mã</th>
							<th>Tên</th>
							<th>Email</th>
							<th>SĐT</th>
							<th>Địa chỉ</th>
							<th>Trạng thái</th>
							<th class="text-end">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="cst" items="${customers}" varStatus="i">
							<tr>
								<td>${i.index+1}</td>
								<td>${cst.maND}</td>
								<td>${cst.hoTen}</td>
								<td>${cst.email}</td>
								<td>${cst.soDienThoai}</td>
								<td>${cst.diaChi}</td>
								<td><span
									class="badge bg-${cst.trangThai?'success':'secondary'}">${cst.trangThai?'Hoạt động':'Khóa'}</span></td>
								<td class="text-end"><a
									class="btn btn-sm btn-outline-secondary me-1"
									href="${pageContext.request.contextPath}/admin/customers/view?id=${cst.maND}"><i
										class="bi bi-eye"></i></a>
									<form class="d-inline" method="post"
										action="${pageContext.request.contextPath}/admin/customers/toggle">
										<input type="hidden" name="id" value="${cst.maND}">
										<button class="btn btn-sm btn-outline-primary">
											<i class="bi bi-shield-check"></i>
										</button>
									</form></td>
							</tr>
						</c:forEach>
						<c:if test="${empty customers}">
							<tr>
								<td colspan="8" class="text-center py-4 text-muted">Chưa có
									dữ liệu</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</main>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>/* sidebar/resizer giống các file khác */const r=document.documentElement,sw=w=>r.style.setProperty('--w',w+'px');const s=+localStorage.getItem('w');if(s&&s>=180&&s<=480)sw(s);const sb=document.getElementById('side'),rz=document.getElementById('rz'),btn=document.getElementById('btn');const mq=window.matchMedia('(max-width:991.98px)');const sync=()=>rz.style.display=mq.matches?'none':'block';mq.addEventListener('change',sync);sync();btn?.addEventListener('click',()=>{if(mq.matches)sb.classList.toggle('show');else{document.body.classList.toggle('collapsed');sw(document.body.classList.contains('collapsed')?72:(s||260));}});let d=false,x=0,w0=0;rz?.addEventListener('pointerdown',e=>{if(mq.matches||document.body.classList.contains('collapsed'))return;d=true;x=e.clientX;w0=parseInt(getComputedStyle(r).getPropertyValue('--w'));rz.setPointerCapture(e.pointerId)});rz?.addEventListener('pointermove',e=>{if(!d)return;sw(Math.min(480,Math.max(180,w0+(e.clientX-x))))});function up(){if(!d)return;d=false;localStorage.setItem('w',parseInt(getComputedStyle(r).getPropertyValue('--w')))}rz?.addEventListener('pointerup',up);rz?.addEventListener('pointercancel',up);</script>
</body>
</html>
