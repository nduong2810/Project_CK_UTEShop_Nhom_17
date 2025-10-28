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

.grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 14px
}

@media ( max-width :1280px) {
	.grid {
		grid-template-columns: repeat(3, 1fr)
	}
}

@media ( max-width :920px) {
	.grid {
		grid-template-columns: repeat(2, 1fr)
	}
}

@media ( max-width :640px) {
	.grid {
		grid-template-columns: 1fr
	}
}

.card {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 16px;
	overflow: hidden;
	display: flex;
	flex-direction: column
}

.thumb {
	height: 180px;
	background: #f7f7fb;
	display: flex;
	align-items: center;
	justify-content: center
}

.thumb img {
	max-width: 95%;
	max-height: 95%;
	object-fit: contain
}

.body {
	padding: 12px;
	display: flex;
	flex-direction: column;
	gap: 6px;
	flex: 1
}

.name {
	font-weight: 800;
	color: #111827
}

.price {
	font-weight: 900;
	font-size: 18px
}

.meta {
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
	color: var(--muted);
	font-size: 12px
}

.badge {
	padding: 2px 8px;
	border-radius: 999px;
	font-size: 12px
}

.badge-ok {
	background: #e6f7ee;
	color: #0f5132
}

.badge-off {
	background: #fdecec;
	color: #7f1d1d
}

.actions {
	display: flex;
	gap: 8px;
	justify-content: flex-end;
	padding: 10px
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
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">
			<div class="title">Sản phẩm của shop #${shopId}</div>

			<div class="toolbar">
				<div class="muted">Tổng: ${totalProducts} sản phẩm</div>
				<form method="get"
					style="display: flex; gap: 8px; align-items: center">
					<input type="hidden" name="shopId" value="${shopId}" /> <input
						class="input" type="text" name="q"
						placeholder="Tìm theo tên/mô tả..." value="${param_q}"> <select
						class="select" name="category">
						<option value="">Danh mục</option>
						<c:forEach var="c" items="${categories}">
							<option value="${c.maDM}" ${param_category==c.maDM?'selected':''}>${c.tenDM}</option>
						</c:forEach>
					</select> <select class="select" name="status">
						<option value="">Trạng thái</option>
						<option value="active" ${param_status=='active'?'selected':''}>Đang
							bán</option>
						<option value="inactive" ${param_status=='inactive'?'selected':''}>Ngừng
							bán</option>
					</select> <select class="select" name="sort">
						<option value="date_desc" ${param_sort=='date_desc'?'selected':''}>Mới
							nhất</option>
						<option value="price_asc" ${param_sort=='price_asc'?'selected':''}>Giá
							↑</option>
						<option value="price_desc"
							${param_sort=='price_desc'?'selected':''}>Giá ↓</option>
						<option value="name_asc" ${param_sort=='name_asc'?'selected':''}>Tên
							A→Z</option>
						<option value="name_desc" ${param_sort=='name_desc'?'selected':''}>Tên
							Z→A</option>
					</select> <select class="select" name="pageSize">
						<option value="8" ${pageSize==8?'selected':''}>8 / trang</option>
						<option value="10" ${pageSize==10?'selected':''}>10 /
							trang</option>
						<option value="20" ${pageSize==20?'selected':''}>20 /
							trang</option>
					</select>
					<button class="btn">Lọc</button>
				</form>
			</div>

			<c:choose>
				<c:when test="${empty products}">
					<div class="muted">Chưa có sản phẩm nào cho shop này.</div>
				</c:when>
				<c:otherwise>
					<div class="grid">
						<c:forEach var="p" items="${products}">
							<div class="card">
								<div class="thumb">
									<c:choose>
										<c:when test="${not empty p.hinhAnh}">
											<img src="${pageContext.request.contextPath}/${p.hinhAnh}"
												alt="${p.tenSP}">
										</c:when>
										<c:otherwise>
											<img
												src="${pageContext.request.contextPath}/assets/img/placeholder-product.png"
												alt="${p.tenSP}">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="body">
									<div class="name">${p.tenSP}</div>
									<div class="price">
										<fmt:formatNumber value="${p.donGia}" type="number" />
										đ
									</div>
									<div class="meta">
										<span>Kho: <b>${p.soLuongTon}</b></span> <span>|</span>
										<c:choose>
											<c:when test="${p.trangThai}">
												<span class="badge badge-ok">Đang bán</span>
											</c:when>
											<c:otherwise>
												<span class="badge badge-off">Ngừng bán</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<div class="actions">
									<button class="btn"
										onclick="location.href='${pageContext.request.contextPath}/admin/products/view?id=${p.maSP}'">Xem</button>
									<button class="btn btn-primary"
										onclick="location.href='${pageContext.request.contextPath}/admin/suppliers/products/edit?id=${p.maSP}&shopId=${shopId}'">Sửa</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>

			<div class="pagination">
				<form method="get" style="display: inline">
					<input type="hidden" name="shopId" value="${shopId}" /> <input
						type="hidden" name="q" value="${param_q}" /> <input type="hidden"
						name="category" value="${param_category}" /> <input type="hidden"
						name="status" value="${param_status}" /> <input type="hidden"
						name="sort" value="${param_sort}" /> <input type="hidden"
						name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage-1}"
						<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
				</form>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<form method="get" style="display: inline">
						<input type="hidden" name="shopId" value="${shopId}" /> <input
							type="hidden" name="q" value="${param_q}" /> <input type="hidden"
							name="category" value="${param_category}" /> <input type="hidden"
							name="status" value="${param_status}" /> <input type="hidden"
							name="sort" value="${param_sort}" /> <input type="hidden"
							name="pageSize" value="${pageSize}" />
						<button class="pbtn ${i==currentPage?'active':''}" name="page"
							value="${i}">${i}</button>
					</form>
				</c:forEach>

				<form method="get" style="display: inline">
					<input type="hidden" name="shopId" value="${shopId}" /> <input
						type="hidden" name="q" value="${param_q}" /> <input type="hidden"
						name="category" value="${param_category}" /> <input type="hidden"
						name="status" value="${param_status}" /> <input type="hidden"
						name="sort" value="${param_sort}" /> <input type="hidden"
						name="pageSize" value="${pageSize}" />
					<button class="pbtn" name="page" value="${currentPage+1}"
						<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
				</form>
			</div>

		</div>
	</main>
</div>
