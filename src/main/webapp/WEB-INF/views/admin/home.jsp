<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>UTESHOP Admin • Dashboard</title>
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

.search {
	width: 520px;
	position: relative
}

.search input {
	border-radius: 999px
}

.search button {
	position: absolute;
	right: 4px;
	top: 3px;
	bottom: 3px;
	border: 0;
	background: linear-gradient(180deg, #ff8f3c, #ff6a39);
	color: #fff;
	border-radius: 999px;
	width: 44px
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
	cursor: col-resize;
	z-index: 2
}

.rz:after {
	content: "";
	position: absolute;
	inset: 0;
	background: #000;
	opacity: .06;
	border-radius: 3px
}

.main {
	margin-left: var(--w);
	padding: 20px
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

footer {
	padding: 16px;
	color: #6c757d;
	text-align: center
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<aside class="side" id="side">
		<div class="px-3 py-2 text-white-50">UTESHOP Admin</div>
		<ul class="nav flex-column">
			<li><a class="nav-link active"
				href="${pageContext.request.contextPath}/admin/home"><i
					class="bi bi-speedometer2 me-2"></i><span class="lbl">Bảng
						điều khiển</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/products"><i
					class="bi bi-box-seam me-2"></i><span class="lbl">Sản phẩm</span></a></li>
			<li><a class="nav-link"
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
				href="${pageContext.request.contextPath}/admin/categories"><i
					class="bi bi-tags me-2"></i><span class="lbl">Danh mục</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/shipping"><i
					class="bi bi-truck me-2"></i><span class="lbl">Vận chuyển</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/coupons"><i
					class="bi bi-ticket-perforated me-2"></i><span class="lbl">Mã
						giảm giá</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/settings"><i
					class="bi bi-gear me-2"></i><span class="lbl">Cài đặt</span></a></li>
		</ul>
	</aside>
	<div class="rz d-none d-lg-block" id="rz"></div>

	<main class="main container-fluid">
		<!-- set từ servlet: totalUsers,totalOrders,revenueToday,totalProducts -->
		<div class="row g-3">
			<div class="col-sm-6 col-xl-3">
				<div class="card shadow-sm h-100">
					<div class="card-body d-flex align-items-center">
						<i class="bi bi-people fs-1 me-3 text-primary"></i>
						<div>
							<div class="text-muted">Người dùng</div>
							<div class="fs-4 fw-semibold">${totalUsers}</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-xl-3">
				<div class="card shadow-sm h-100">
					<div class="card-body d-flex align-items-center">
						<i class="bi bi-receipt fs-1 me-3 text-success"></i>
						<div>
							<div class="text-muted">Đơn hàng</div>
							<div class="fs-4 fw-semibold">${totalOrders}</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-xl-3">
				<div class="card shadow-sm h-100">
					<div class="card-body d-flex align-items-center">
						<i class="bi bi-currency-dollar fs-1 me-3 text-warning"></i>
						<div>
							<div class="text-muted">Doanh thu hôm nay</div>
							<div class="fs-4 fw-semibold">
								<fmt:formatNumber value="${revenueToday}" type="currency"
									currencySymbol="₫" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-xl-3">
				<div class="card shadow-sm h-100">
					<div class="card-body d-flex align-items-center">
						<i class="bi bi-box-seam fs-1 me-3 text-info"></i>
						<div>
							<div class="text-muted">Sản phẩm đang bán</div>
							<div class="fs-4 fw-semibold">${totalProducts}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<footer>
		©
		<script>document.write(new Date().getFullYear())</script>
		UTESHOP Admin
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>const r=document.documentElement,sw=w=>r.style.setProperty('--w',w+'px');const s=+localStorage.getItem('w');if(s&&s>=180&&s<=480)sw(s);const sb=document.getElementById('side'),rz=document.getElementById('rz'),btn=document.getElementById('btn');const mq=window.matchMedia('(max-width:991.98px)');const sync=()=>rz.style.display=mq.matches?'none':'block';mq.addEventListener('change',sync);sync();btn?.addEventListener('click',()=>{if(mq.matches)sb.classList.toggle('show');else{document.body.classList.toggle('collapsed');sw(document.body.classList.contains('collapsed')?72:(s||260));}});let d=false,x=0,w0=0;rz?.addEventListener('pointerdown',e=>{if(mq.matches||document.body.classList.contains('collapsed'))return;d=true;x=e.clientX;w0=parseInt(getComputedStyle(r).getPropertyValue('--w'));rz.setPointerCapture(e.pointerId)});rz?.addEventListener('pointermove',e=>{if(!d)return;sw(Math.min(480,Math.max(180,w0+(e.clientX-x))))});function up(){if(!d)return;d=false;localStorage.setItem('w',parseInt(getComputedStyle(r).getPropertyValue('--w')))}rz?.addEventListener('pointerup',up);rz?.addEventListener('pointercancel',up);</script>
</body>
</html>
