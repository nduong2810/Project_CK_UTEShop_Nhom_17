<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
:root {
	--bg: #f5f7fb;
	--border: #e5e7eb;
	--card: #fff;
	--muted: #6b7280;
	--primary: #1a73e8;
	--danger: #ef4444;
	--radius: 16px;
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

.page-title {
	font-size: 20px;
	font-weight: 800;
	margin: 8px 0 12px;
	color: #111827
}

.badge {
	padding: 4px 8px;
	border-radius: 999px;
	background: #e6f0ff;
	color: #1a73e8;
	margin-left: 6px
}

.grid {
	display: grid;
	gap: 18px;
	grid-template-columns: 420px 1fr
}

@media ( max-width :1080px) {
	.grid {
		grid-template-columns: 1fr
	}
}

.card {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 16px;
	padding: 16px
}

.preview {
	display: flex;
	align-items: center;
	justify-content: center;
	background: #f7f7fb;
	border: 1px dashed var(--border);
	border-radius: 12px;
	height: 380px
}

.preview img {
	max-width: 92%;
	max-height: 92%;
	object-fit: contain
}

.fields {
	display: grid;
	gap: 12px
}

.field {
	display: flex;
	gap: 10px
}

.label {
	min-width: 160px;
	color: #374151;
	font-weight: 700
}

.value {
	color: #111827
}

.kpi {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 12px;
	margin-top: 8px
}

.kpi .item {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 12px;
	padding: 12px
}

.kpi .cap {
	color: #6b7280;
	font-size: 12px
}

.kpi .val {
	font-weight: 900;
	font-size: 22px
}

.actions {
	display: flex;
	gap: 10px;
	margin-top: 14px;
	flex-wrap: wrap
}

.btn {
	height: 40px;
	border-radius: 10px;
	border: 1px solid var(--border);
	background: #fff;
	cursor: pointer;
	padding: 0 14px;
	font-weight: 800
}

.btn-primary {
	background: var(--primary);
	color: #fff;
	border-color: transparent
}

.btn-danger {
	background: var(--danger);
	color: #fff;
	border-color: transparent
}

.btn-ghost {
	background: #fff
}

.section-title {
	font-weight: 800;
	margin: 12px 0 8px
}

.muted {
	color: #6b7280
}

.hr {
	height: 1px;
	background: var(--border);
	margin: 12px 0;
	border: 0
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">

			<div class="page-title">
				Chi tiết sản phẩm <span class="badge">#${p.maSP}</span>
			</div>

			<div class="grid">
				<!-- Cột trái: hình ảnh -->
				<div class="card">
					<div class="preview">
						<c:choose>
							<c:when test="${not empty p.hinhAnh}">
								<img src="${pageContext.request.contextPath}/${p.hinhAnh}"
									alt="${p.tenSP}">
							</c:when>
							<c:otherwise>
								<img
									src="${pageContext.request.contextPath}/assets/img/placeholder-product.png"
									alt="preview">
							</c:otherwise>
						</c:choose>
					</div>

					<div class="actions">
						<button class="btn btn-primary"
							onclick="location.href='${pageContext.request.contextPath}/admin/products/edit?id=${p.maSP}'">
							Sửa sản phẩm</button>
						<button class="btn btn-ghost"
							onclick="location.href='${pageContext.request.contextPath}/admin/products'">
							Quay lại danh sách</button>
						<!-- (tuỳ chọn) nút xoá nếu bạn có controller xử lý -->
						<!--
            <form method="post" action="${pageContext.request.contextPath}/admin/products/delete" onsubmit="return confirm('Bạn chắc chắn muốn xoá?')">
              <input type="hidden" name="id" value="${p.maSP}"/>
              <button type="submit" class="btn btn-danger">Xoá</button>
            </form>
            -->
					</div>
				</div>

				<!-- Cột phải: thông tin -->
				<div class="card">
					<div class="fields">
						<div class="field">
							<div class="label">Tên sản phẩm</div>
							<div class="value">
								<strong>${p.tenSP}</strong>
							</div>
						</div>
						<div class="field">
							<div class="label">Giá bán</div>
							<div class="value">
								<fmt:formatNumber value="${p.donGia}" type="number" />
								đ
							</div>
						</div>
						<div class="field">
							<div class="label">Danh mục</div>
							<div class="value">
								<c:out value="${tenDanhMuc != null ? tenDanhMuc : '—'}" />
								<span class="muted">(Mã: ${p.maDM})</span>
							</div>
						</div>
						<div class="field">
							<div class="label">Trạng thái</div>
							<div class="value">
								<c:choose>
									<c:when test="${p.trangThai}">Đang bán</c:when>
									<c:otherwise>Ngừng bán</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="field">
							<div class="label">Ngày tạo</div>
							<div class="value">
								<fmt:formatDate value="${p.ngayTao}" pattern="dd/MM/yyyy HH:mm" />
							</div>
						</div>
						<c:if test="${not empty p.ngayCapNhat}">
							<div class="field">
								<div class="label">Cập nhật</div>
								<div class="value">
									<fmt:formatDate value="${p.ngayCapNhat}"
										pattern="dd/MM/yyyy HH:mm" />
								</div>
							</div>
						</c:if>
					</div>

					<div class="kpi">
						<div class="item">
							<div class="cap">Kho còn</div>
							<div class="val">${p.soLuongTon}</div>
						</div>
						<div class="item">
							<div class="cap">Đã bán</div>
							<div class="val">${p.soLuongBan}</div>
						</div>
						<div class="item">
							<div class="cap">Lượt xem</div>
							<div class="val">${p.luotXem}</div>
						</div>
						<div class="item">
							<div class="cap">Yêu thích</div>
							<div class="val">${p.luotYeuThich}</div>
						</div>
					</div>

					<div class="hr"></div>

					<div class="section-title">Mô tả</div>
					<div class="muted" style="white-space: pre-wrap">${p.moTa}</div>
				</div>
			</div>

		</div>
	</main>
</div>
