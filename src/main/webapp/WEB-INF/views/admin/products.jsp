<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
/* ===== Layout admin chung (tương thích sidebar hiện có) ===== */
:root {
	--admin-bg: #f5f7fb;
	--admin-border: #e5e7eb;
	--card: #fff;
	--muted: #6b7280;
	--primary: #1a73e8;
	--accent: #ff7a00;
	--radius: 16px;
	--shadow: 0 8px 20px rgba(17, 24, 39, .08);
}

.admin-shell {
	display: flex;
	min-height: calc(100vh - 0px);
	background: var(--admin-bg)
}

.admin-content {
	flex: 1;
	min-width: 0
}

.admin-container {
	padding: 16px
}

/* ===== Toolbar trên cùng ===== */
.page-title {
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
	margin-bottom: 10px
}

.toolbar .right {
	display: flex;
	gap: 10px
}

.input, .select {
	height: 38px;
	border: 1px solid var(--admin-border);
	border-radius: 10px;
	padding: 0 10px;
	background: #fff
}

/* ===== Grid cards ===== */
.grid {
	display: grid;
	gap: 24px;
	grid-template-columns: repeat(12, 1fr)
}

.card {
	grid-column: span 4;
	background: var(--card);
	border-radius: 20px;
	overflow: hidden;
	box-shadow: var(--shadow);
	border: 1px solid #eef2ff
}

@media ( max-width :1280px) {
	.card {
		grid-column: span 6
	}
}

@media ( max-width :768px) {
	.card {
		grid-column: span 12
	}
}

.card-hd {
	position: relative;
	background: #f7f7fb;
	height: 220px;
	display: flex;
	align-items: center;
	justify-content: center
}

.card-hd img {
	max-width: 80%;
	max-height: 80%;
	object-fit: contain
}

.badge {
	position: absolute;
	top: 14px;
	left: 14px;
	background: #ff5a5f;
	color: #fff;
	padding: 6px 10px;
	border-radius: 999px;
	font-weight: 800;
	font-size: 12px
}

.wish {
	position: absolute;
	top: 10px;
	right: 14px;
	width: 36px;
	height: 36px;
	border-radius: 999px;
	background: #fff;
	display: grid;
	place-items: center;
	border: 1px solid #e5e7eb;
	cursor: pointer
}

.card-bd {
	padding: 18px
}

.title {
	font-size: 18px;
	font-weight: 700;
	line-height: 1.4;
	height: 48px;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden
}

.row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 10px
}

.price {
	font-size: 24px;
	font-weight: 900;
	color: #1a56db
}

.sold {
	color: var(--muted)
}

.actions {
	display: flex;
	gap: 10px;
	margin-top: 14px
}

.btn {
	flex: 1;
	height: 44px;
	border-radius: 12px;
	border: 1px solid var(--admin-border);
	background: #fff;
	font-weight: 800;
	cursor: pointer
}

.btn-cart {
	background: var(--primary);
	color: #fff;
	border-color: transparent
}

.btn-buy {
	background: var(--accent);
	color: #fff;
	border-color: transparent
}

/* ===== Pagination ===== */
.pagination {
	display: flex;
	gap: 8px;
	justify-content: center;
	align-items: center;
	margin: 22px 0
}

.p-btn {
	min-width: 42px;
	height: 40px;
	border: 1px solid var(--admin-border);
	background: #fff;
	border-radius: 8px;
	cursor: pointer
}

.p-btn.active {
	background: var(--primary);
	color: #fff;
	border-color: transparent
}

.muted {
	color: var(--muted)
}

.empty {
	padding: 28px;
	text-align: center;
	color: var(--muted);
	border: 1px dashed var(--admin-border);
	border-radius: 12px;
	background: #fff
}
</style>

<div class="admin-shell">
	<!-- SIDEBAR BÊN TRÁI: dùng lại file đã có -->
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<!-- NỘI DUNG BÊN PHẢI -->
	<main class="admin-content">
		<div class="admin-container">
			<div class="page-title">Sản phẩm</div>

			<!-- Thanh công cụ nhỏ (lọc nhanh/ page size) -->
			<div class="toolbar">
				<div class="muted">Tổng: ${totalProducts} sản phẩm</div>
				<form method="get" class="right">
					<input type="text" name="q" class="input"
						placeholder="Tìm theo tên/mã..." value="${param.q}" /> <select
						name="pageSize" class="select" onchange="this.form.submit()">
						<option value="8" ${pageSize==8  ? 'selected':''}>8 /
							trang</option>
						<option value="10" ${pageSize==10 ? 'selected':''}>10 /
							trang</option>
						<option value="12" ${pageSize==12 ? 'selected':''}>12 /
							trang</option>
					</select> <select name="sort" class="select" onchange="this.form.submit()">
						<option value="">Sắp xếp</option>
						<option value="price_asc" ${param.sort=='price_asc'?'selected':''}>Giá
							tăng dần</option>
						<option value="price_desc"
							${param.sort=='price_desc'?'selected':''}>Giá giảm dần</option>
						<option value="sold_desc" ${param.sort=='sold_desc'?'selected':''}>Bán
							chạy</option>
						<option value="newest" ${param.sort=='newest'?'selected':''}>Mới
							nhất</option>
					</select>
				</form>
			</div>

			<!-- GRID SẢN PHẨM -->
			<c:choose>
				<c:when test="${empty products}">
					<div class="empty">Chưa có sản phẩm nào.</div>
				</c:when>
				<c:otherwise>
					<div class="grid">
						<c:forEach var="p" items="${products}">
							<div class="card">
								<div class="card-hd">
									<span class="badge">HOT</span>
									<button class="wish" title="Yêu thích">♡</button>
									<c:choose>
										<c:when test="${not empty p.hinhAnh}">
											<img src="${pageContext.request.contextPath}/${p.hinhAnh}"
												alt="${p.tenSP}" />
										</c:when>
										<c:otherwise>
											<img
												src="${pageContext.request.contextPath}/assets/img/placeholder-product.png"
												alt="${p.tenSP}" />
										</c:otherwise>
									</c:choose>
								</div>

								<div class="card-bd">
									<div class="title">${p.tenSP}</div>
									<div class="row">
										<div class="price">
											<fmt:formatNumber value="${p.donGia}" type="number" />
											đ
										</div>
										<div class="sold">🛒 ${p.soLuongBan} đã bán</div>
									</div>
									<div class="actions">
										<button class="btn btn-cart"
											onclick="location.href='${pageContext.request.contextPath}/admin/products/edit?id=${p.maSP}'">
											Quản lý</button>
										<button class="btn btn-buy"
											onclick="location.href='${pageContext.request.contextPath}/admin/products/view?id=${p.maSP}'">
											Xem chi tiết</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

					<!-- PHÂN TRANG -->
					<div class="pagination">
						<form method="get" style="display: inline">
							<input type="hidden" name="q" value="${param.q}" /> <input
								type="hidden" name="sort" value="${param.sort}" /> <input
								type="hidden" name="pageSize" value="${pageSize}" />
							<button type="submit" class="p-btn" name="page"
								value="${currentPage-1}"
								<c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
						</form>

						<c:forEach var="i" begin="1" end="${totalPages}">
							<form method="get" style="display: inline">
								<input type="hidden" name="q" value="${param.q}" /> <input
									type="hidden" name="sort" value="${param.sort}" /> <input
									type="hidden" name="pageSize" value="${pageSize}" />
								<button type="submit"
									class="p-btn <c:if test='${i==currentPage}'>active</c:if>"
									name="page" value="${i}">${i}</button>
							</form>
						</c:forEach>

						<form method="get" style="display: inline">
							<input type="hidden" name="q" value="${param.q}" /> <input
								type="hidden" name="sort" value="${param.sort}" /> <input
								type="hidden" name="pageSize" value="${pageSize}" />
							<button type="submit" class="p-btn" name="page"
								value="${currentPage+1}"
								<c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
						</form>
					</div>
				</c:otherwise>
			</c:choose>

		</div>
	</main>
</div>
