<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>UTESHOP Admin • Cài đặt</title>
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
		</div>
	</header>
	<aside class="side" id="side">
		<ul class="nav flex-column mt-2">
			<li><a class="nav-link active"
				href="${pageContext.request.contextPath}/admin/settings"><i
					class="bi bi-gear me-2"></i><span class="lbl">Cài đặt</span></a></li>
		</ul>
	</aside>
	<div class="rz d-none d-lg-block" id="rz"></div>

	<main class="main container-fluid">
		<!-- set: settings.* nếu có -->
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item"><button class="nav-link active"
					data-bs-toggle="tab" data-bs-target="#g" type="button">Chung</button></li>
			<li class="nav-item"><button class="nav-link"
					data-bs-toggle="tab" data-bs-target="#s" type="button">Bảo
					mật</button></li>
			<li class="nav-item"><button class="nav-link"
					data-bs-toggle="tab" data-bs-target="#e" type="button">Email</button></li>
		</ul>
		<div class="tab-content border border-top-0 bg-white p-3 shadow-sm">
			<div class="tab-pane fade show active" id="g">
				<form method="post"
					action="${pageContext.request.contextPath}/admin/settings/save-general"
					class="row g-3">
					<div class="col-md-6">
						<label class="form-label">Tên cửa hàng</label><input
							class="form-control" name="shopName" value="${settings.shopName}">
					</div>
					<div class="col-md-6">
						<label class="form-label">Tiền tệ</label><select
							class="form-select" name="currency"><option
								${settings.currency=='VND'?'selected':''}>VND</option>
							<option ${settings.currency=='USD'?'selected':''}>USD</option></select>
					</div>
					<div class="col-md-12">
						<label class="form-label">Logo URL</label><input
							class="form-control" name="logoUrl" value="${settings.logoUrl}">
					</div>
					<div class="col-12">
						<button class="btn btn-primary">Lưu</button>
					</div>
				</form>
			</div>
			<div class="tab-pane fade" id="s">
				<form method="post"
					action="${pageContext.request.contextPath}/admin/settings/save-security"
					class="row g-3">
					<div class="col-md-6">
						<label class="form-label">Chính sách mật khẩu</label><select
							class="form-select" name="passwordPolicy"><option
								${settings.passwordPolicy=='LOW'?'selected':''} value="LOW">Thấp</option>
							<option ${settings.passwordPolicy=='MEDIUM'?'selected':''}
								value="MEDIUM">TB</option>
							<option ${settings.passwordPolicy=='HIGH'?'selected':''}
								value="HIGH">Cao</option></select>
					</div>
					<div class="col-md-6 form-check mt-4">
						<input class="form-check-input" type="checkbox" name="twoFA"
							id="twoFA" ${settings.twoFA?'checked':''}><label
							class="form-check-label" for="twoFA">Bật 2FA cho Admin</label>
					</div>
					<div class="col-12">
						<button class="btn btn-primary">Lưu</button>
					</div>
				</form>
			</div>
			<div class="tab-pane fade" id="e">
				<form method="post"
					action="${pageContext.request.contextPath}/admin/settings/save-email"
					class="row g-3">
					<div class="col-md-4">
						<label class="form-label">SMTP Host</label><input
							class="form-control" name="smtpHost" value="${settings.smtpHost}">
					</div>
					<div class="col-md-2">
						<label class="form-label">Port</label><input type="number"
							class="form-control" name="smtpPort" value="${settings.smtpPort}">
					</div>
					<div class="col-md-3">
						<label class="form-label">Username</label><input
							class="form-control" name="smtpUser" value="${settings.smtpUser}">
					</div>
					<div class="col-md-3">
						<label class="form-label">Password</label><input type="password"
							class="form-control" name="smtpPass" value="${settings.smtpPass}">
					</div>
					<div class="col-md-6 form-check mt-2">
						<input class="form-check-input" type="checkbox" name="smtpTls"
							id="smtpTls" ${settings.smtpTls?'checked':''}><label
							class="form-check-label" for="smtpTls">StartTLS</label>
					</div>
					<div class="col-12">
						<button class="btn btn-primary">Lưu</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>/* sidebar/resizer */const r=document.documentElement,sw=w=>r.style.setProperty('--w',w+'px');const s=+localStorage.getItem('w');if(s&&s>=180&&s<=480)sw(s);const sb=document.getElementById('side'),rz=document.getElementById('rz'),btn=document.getElementById('btn');const mq=window.matchMedia('(max-width:991.98px)');const sync=()=>rz.style.display=mq.matches?'none':'block';mq.addEventListener('change',sync);sync();btn?.addEventListener('click',()=>{if(mq.matches)sb.classList.toggle('show');else{document.body.classList.toggle('collapsed');sw(document.body.classList.contains('collapsed')?72:(s||260));}});let d=false,x=0,w0=0;rz?.addEventListener('pointerdown',e=>{if(mq.matches||document.body.classList.contains('collapsed'))return;d=true;x=e.clientX;w0=parseInt(getComputedStyle(r).getPropertyValue('--w'));rz.setPointerCapture(e.pointerId)});rz?.addEventListener('pointermove',e=>{if(!d)return;sw(Math.min(480,Math.max(180,w0+(e.clientX-x))))});function up(){if(!d)return;d=false;localStorage.setItem('w',parseInt(getComputedStyle(r).getPropertyValue('--w')))}rz?.addEventListener('pointerup',up);rz?.addEventListener('pointercancel',up);</script>
</body>
</html>
