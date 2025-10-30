<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

/* Product Card */
.product-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    border: 1px solid #e0e0e0;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.product-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.product-image-container {
    height: 220px; /* Adjusted from 300px to fit admin context */
    position: relative;
    overflow: hidden;
    background: #f8f9fa;
    display: flex;
    align-items: center;
    justify-content: center;
}

.product-image {
    width: 100%;
    height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.product-card:hover .product-image {
    transform: scale(1.05);
}

.badge-hot {
    position: absolute;
    top: 15px;
    left: 15px;
    background: linear-gradient(45deg, #ff3f6c, #ff6b81);
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    z-index: 2;
}

.btn-favorite {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: none;
    background-color: rgba(255, 255, 255, 0.8);
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    z-index: 3;
    backdrop-filter: blur(5px);
}

.btn-favorite:hover {
    background-color: white;
    transform: scale(1.1);
    color: #ff3f6c;
}

.btn-favorite.active {
    background-color: #ff3f6c;
    color: white;
}

.btn-favorite.active .fa-heart {
    font-weight: 900; /* Solid heart */
}

.product-card .card-body {
    padding: 25px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.product-card .card-title {
    font-size: 1.1rem;
    font-weight: 600;
    line-height: 1.4;
    margin-bottom: 15px;
    color: #333;
    min-height: 50px;
    flex-grow: 1;
}

.product-card .card-title a {
    color: inherit;
    text-decoration: none;
    transition: color 0.3s ease;
}

.product-card .card-title a:hover {
    color: #2874f0;
}

.product-card .price {
    font-size: 1.6rem;
    font-weight: 700;
    color: #2874f0;
    margin-bottom: 10px;
    white-space: nowrap;
}

.product-card .sold-count {
    color: #878787;
    font-size: 0.9rem;
    white-space: nowrap;
    flex-shrink: 0;
}

.price-line {
    flex-wrap: wrap;
    gap: 5px;
}

.product-buttons {
    display: flex;
    gap: 10px;
    margin-top: auto;
}

.btn-add-to-cart, .btn-buy-now {
    flex: 1;
    padding: 12px 10px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    justify-content: center;
}

.btn-add-to-cart {
    background: linear-gradient(45deg, #2874f0, #1a5fce);
    color: white;
    border: none;
    box-shadow: 0 4px 15px rgba(40, 116, 240, 0.3);
}

.btn-add-to-cart:hover {
    background: linear-gradient(45deg, #1a5fce, #2874f0);
    box-shadow: 0 6px 20px rgba(40, 116, 240, 0.4);
    transform: translateY(-3px);
}

.btn-buy-now {
    background: linear-gradient(45deg, #ff9f00, #ff5f00);
    color: white;
    border: none;
    box-shadow: 0 4px 15px rgba(255, 159, 0, 0.3);
}

.btn-buy-now:hover {
    background: linear-gradient(45deg, #ff5f00, #ff9f00);
    box-shadow: 0 6px 20px rgba(255, 159, 0, 0.4);
    transform: translateY(-3px);
}

/* Alert Styles */
.alert {
    border-radius: 12px;
    border: none;
}

.alert-danger {
    background: #fff5f5;
    color: #c53030;
}

.alert-secondary {
    background: #f7fafc;
    color: #4a5568;
}

.alert-warning {
    background-color: #fffbeb;
    color: #b45309;
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
						placeholder="Tìm theo tên" value="${param.q}" />
					<select name="cat" class="select" onchange="this.form.submit()">
						<option value="">Tất cả danh mục</option>
						<c:forEach var="category" items="${categories}">
							<option value="${category.maDM}" ${param.cat == category.maDM.toString() ? 'selected' : ''}>
								${category.tenDM}
							</option>
						</c:forEach>
					</select>
					<select name="pageSize" class="select" onchange="this.form.submit()">
						<option value="8" ${pageSize==8  ? 'selected':''}>8 / trang</option>
						<option value="16" ${pageSize==16 ? 'selected':''}>16 / trang</option>
						<option value="24" ${pageSize==24 ? 'selected':''}>24 / trang</option>
					</select>
					<select name="sort" class="select" onchange="this.form.submit()">
						<option value="">Sắp xếp</option>
						<option value="price_asc" ${param.sort=='price_asc'?'selected':''}>Giá tăng dần</option>
						<option value="price_desc" ${param.sort=='price_desc'?'selected':''}>Giá giảm dần</option>
						<option value="sold_desc" ${param.sort=='sold_desc'?'selected':''}>Bán chạy</option>
						<option value="newest" ${param.sort=='newest'?'selected':''}>Mới nhất</option>
					</select>
				</form>
			</div>
			<!-- GRID SẢN PHẨM -->
			<c:choose>
				<c:when test="${empty products}">
					<div class="empty">Chưa có sản phẩm nào.</div>
				</c:when>
				<c:otherwise>
					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
						<c:forEach var="p" items="${products}">
							<div class="col">
								<div class="product-card">
									<div class="product-image-container">
										<span class="badge-hot">HOT</span>

										</button>
										<c:choose>
											<c:when test="${not empty p.hinhAnh}">
												<img src="${pageContext.request.contextPath}/assets/img/${p.hinhAnh}"
													alt="${p.tenSP}" class="product-image"
													onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';" />
											</c:when>
											<c:otherwise>
												<img
													src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png"
													alt="${p.tenSP}" class="product-image" />
											</c:otherwise>
										</c:choose>
									</div>
									<div class="card-body">
										<h5 class="card-title">
											<a href="${pageContext.request.contextPath}/admin/products/view?id=${p.maSP}">${p.tenSP}</a>
										</h5>
										<div class="d-flex justify-content-between align-items-center price-line">
											<span class="price">
												<fmt:formatNumber value="${p.donGia}" type="number" />₫
											</span>
											<span class="sold-count">🛒 ${p.soLuongBan} đã bán</span>
										</div>
										<div class="product-buttons">
											<button class="btn btn-add-to-cart"
												onclick="location.href='${pageContext.request.contextPath}/admin/products/edit?id=${p.maSP}'">
												<i class="fas fa-edit me-2"></i>Quản lý
											</button>
											<button class="btn btn-buy-now"
												onclick="location.href='${pageContext.request.contextPath}/admin/products/view?id=${p.maSP}'">
												<i class="fas fa-eye me-2"></i>Xem chi tiết
											</button>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<!-- PHÂN TRANG -->
					<nav aria-label="Product Pagination" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <c:url var="prevUrl" value="/admin/products">
                                    <c:param name="page" value="${currentPage - 1}"/>
                                    <c:if test="${not empty param.q}"><c:param name="q" value="${param.q}"/></c:if>
                                    <c:if test="${not empty param.cat}"><c:param name="cat" value="${param.cat}"/></c:if>
                                    <c:if test="${not empty param.sort}"><c:param name="sort" value="${param.sort}"/></c:if>
                                    <c:if test="${not empty param.pageSize}"><c:param name="pageSize" value="${param.pageSize}"/></c:if>
                                </c:url>
                                <a class="page-link" href="${prevUrl}" tabindex="-1" aria-disabled="${currentPage == 1}">Trước</a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <c:url var="pageUrl" value="/admin/products">
                                        <c:param name="page" value="${i}"/>
                                        <c:if test="${not empty param.q}"><c:param name="q" value="${param.q}"/></c:if>
                                        <c:if test="${not empty param.cat}"><c:param name="cat" value="${param.cat}"/></c:if>
                                        <c:if test="${not empty param.sort}"><c:param name="sort" value="${param.sort}"/></c:if>
                                        <c:if test="${not empty param.pageSize}"><c:param name="pageSize" value="${param.pageSize}"/></c:if>
                                    </c:url>
                                    <a class="page-link" href="${pageUrl}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <c:url var="nextUrl" value="/admin/products">
                                    <c:param name="page" value="${currentPage + 1}"/>
                                    <c:if test="${not empty param.q}"><c:param name="q" value="${param.q}"/></c:if>
                                    <c:if test="${not empty param.cat}"><c:param name="cat" value="${param.cat}"/></c:if>
                                    <c:if test="${not empty param.sort}"><c:param name="sort" value="${param.sort}"/></c:if>
                                    <c:if test="${not empty param.pageSize}"><c:param name="pageSize" value="${param.pageSize}"/></c:if>
                                </c:url>
                                <a class="page-link" href="${nextUrl}">Sau</a>
                            </li>
                        </ul>
                    </nav>
				</c:otherwise>
			</c:choose>
		</div>
	</main>
</div>
