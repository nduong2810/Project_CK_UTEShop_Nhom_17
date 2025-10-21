<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>UTESHOP Admin • Sản phẩm</title>
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
			<form class="search ms-auto me-3 d-none d-lg-flex"
				action="${pageContext.request.contextPath}/admin/products">
				<input class="form-control" name="q" value="${param.q}"
					placeholder="Tìm kiếm...">
				<button class="btn">
					<i class="bi bi-search"></i>
				</button>
			</form>
			<div class="dropdown">
				<button class="btn btn-outline-light rounded-pill px-3"
					data-bs-toggle="dropdown">
					<i class="bi bi-person-circle me-1"></i>
					<c:out
						value="${sessionScope.account!=null?sessionScope.account.tenDangNhap:'admin'}" />
				</button>
				<ul class="dropdown-menu dropdown-menu-end">
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
				</ul>
			</div>
		</div>
	</header>
	<aside class="side" id="side">
		<ul class="nav flex-column mt-2">
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/home"><i
					class="bi bi-speedometer2 me-2"></i><span class="lbl">Bảng
						điều khiển</span></a></li>
			<li><a class="nav-link active"
				href="${pageContext.request.contextPath}/admin/products"><i
					class="bi bi-box-seam me-2"></i><span class="lbl">Sản phẩm</span></a></li>
			<li><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/categories"><i
					class="bi bi-tags me-2"></i><span class="lbl">Danh mục</span></a></li>
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
				href="${pageContext.request.contextPath}/admin/settings"><i
					class="bi bi-gear me-2"></i><span class="lbl">Cài đặt</span></a></li>
		</ul>
	</aside>
	<div class="rz d-none d-lg-block" id="rz"></div>

	<main class="main container-fluid">
		<!-- set: categories (List<DanhMuc>), products (JOIN TenDM), page,totalPages,totalItems -->
		<div class="d-flex align-items-center justify-content-between mb-3">
			<h5 class="mb-0">Sản phẩm</h5>
			<div class="d-flex gap-2">
				<form class="d-flex" method="get"
					action="${pageContext.request.contextPath}/admin/products">
					<select class="form-select" name="cat" style="max-width: 220px"><option
							value="">Tất cả danh mục</option>
						<c:forEach var="dm" items="${categories}">
							<option value="${dm.maDM}" ${param.cat==dm.maDM?'selected':''}>${dm.tenDM}</option>
						</c:forEach>
					</select> <input class="form-control ms-2" name="q" value="${param.q}"
						placeholder="Tên/Mã sản phẩm">
					<button class="btn btn-outline-secondary ms-2">
						<i class="bi bi-search"></i>
					</button>
				</form>
				<button class="btn btn-primary" data-bs-toggle="modal"
					data-bs-target="#modal">
					<i class="bi bi-plus-lg me-1"></i>Thêm
				</button>
			</div>
		</div>
		<div class="card shadow-sm">
			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th>#</th>
							<th>Mã</th>
							<th>Tên</th>
							<th>Danh mục</th>
							<th>Tồn</th>
							<th>Giá</th>
							<th>Trạng thái</th>
							<th class="text-end">Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${products}" varStatus="st">
							<tr>
								<td>${st.index+1}</td>
								<td>SP${p.maSP}</td>
								<td>${p.tenSP}</td>
								<td>${p.tenDM}</td>
								<td>${p.soLuongTon}</td>
								<td><fmt:formatNumber value="${p.donGia}" type="currency"
										currencySymbol="₫" /></td>
								<td><span
									class="badge bg-${p.trangThai?'success':'secondary'}">${p.trangThai?'Đang bán':'Ngừng bán'}</span></td>
								<td class="text-end">
									<button class="btn btn-sm btn-outline-primary me-1 e"
										data-id="${p.maSP}" data-name="${p.tenSP}"
										data-price="${p.donGia}" data-stock="${p.soLuongTon}"
										data-cat="${p.maDM}" data-active="${p.trangThai}">
										<i class="bi bi-pencil"></i>
									</button>
									<form class="d-inline" method="post"
										action="${pageContext.request.contextPath}/admin/products/delete">
										<input type="hidden" name="id" value="${p.maSP}">
										<button class="btn btn-sm btn-outline-danger"
											onclick="return confirm('Xóa sản phẩm?')">
											<i class="bi bi-trash"></i>
										</button>
									</form>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty products}">
							<tr>
								<td colspan="8" class="text-center py-4 text-muted">Chưa có
									dữ liệu</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<div class="card-body d-flex justify-content-between">
				<div class="text-muted">
					Tổng: <b>${totalItems}</b> SP
				</div>
				<nav>
					<ul class="pagination mb-0">
						<li class="page-item ${page<=1?'disabled':''}"><a
							class="page-link"
							href="?page=${page-1}&q=${param.q}&cat=${param.cat}">Trước</a></li>
						<c:forEach var="i" begin="1" end="${totalPages}">
							<li class="page-item ${i==page?'active':''}"><a
								class="page-link"
								href="?page=${i}&q=${param.q}&cat=${param.cat}">${i}</a></li>
						</c:forEach>
						<li class="page-item ${page>=totalPages?'disabled':''}"><a
							class="page-link"
							href="?page=${page+1}&q=${param.q}&cat=${param.cat}">Sau</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</main>

	<!-- modal -->
	<div class="modal fade" id="modal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<form class="modal-content" method="post"
				action="${pageContext.request.contextPath}/admin/products/save">
				<div class="modal-header">
					<h5 class="modal-title">Sản phẩm</h5>
					<button class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="maSP" id="id">
					<div class="row g-3">
						<div class="col-md-8">
							<label class="form-label">Tên</label><input class="form-control"
								name="tenSP" id="name" required>
						</div>
						<div class="col-md-4">
							<label class="form-label">Giá</label><input type="number" min="0"
								class="form-control" name="donGia" id="price" required>
						</div>
						<div class="col-md-4">
							<label class="form-label">Danh mục</label><select
								class="form-select" name="maDM" id="cat"><c:forEach
									var="dm" items="${categories}">
									<option value="${dm.maDM}">${dm.tenDM}</option>
								</c:forEach></select>
						</div>
						<div class="col-md-4">
							<label class="form-label">Tồn kho</label><input type="number"
								min="0" class="form-control" name="soLuongTon" id="stock">
						</div>
						<div class="col-md-4 d-flex align-items-end">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="trangThai"
									id="active" checked><label
									class="form-check-label ms-1">Đang bán</label>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">Mô tả</label>
							<textarea class="form-control" name="moTa" rows="3"></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
					<button class="btn btn-primary">
						<i class="bi bi-save me-1"></i>Lưu
					</button>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>const r=document.documentElement,sw=w=>r.style.setProperty('--w',w+'px');const s=+localStorage.getItem('w');if(s&&s>=180&&s<=480)sw(s);const sb=document.getElementById('side'),rz=document.getElementById('rz'),btn=document.getElementById('btn');const mq=window.matchMedia('(max-width:991.98px)');const sync=()=>rz.style.display=mq.matches?'none':'block';mq.addEventListener('change',sync);sync();btn?.addEventListener('click',()=>{if(mq.matches)sb.classList.toggle('show');else{document.body.classList.toggle('collapsed');sw(document.body.classList.contains('collapsed')?72:(s||260));}});let d=false,x=0,w0=0;rz?.addEventListener('pointerdown',e=>{if(mq.matches||document.body.classList.contains('collapsed'))return;d=true;x=e.clientX;w0=parseInt(getComputedStyle(r).getPropertyValue('--w'));rz.setPointerCapture(e.pointerId)});rz?.addEventListener('pointermove',e=>{if(!d)return;sw(Math.min(480,Math.max(180,w0+(e.clientX-x))))});function up(){if(!d)return;d=false;localStorage.setItem('w',parseInt(getComputedStyle(r).getPropertyValue('--w')))}rz?.addEventListener('pointerup',up);rz?.addEventListener('pointercancel',up);
// edit
document.querySelectorAll('.e').forEach(b=>b.addEventListener('click',()=>{id.value=b.dataset.id;name.value=b.dataset.name;price.value=b.dataset.price;stock.value=b.dataset.stock;cat.value=b.dataset.cat;active.checked=(b.dataset.active==='true'||b.dataset.active==='1');new bootstrap.Modal('#modal').show()}));</script>
</body>
</html>
