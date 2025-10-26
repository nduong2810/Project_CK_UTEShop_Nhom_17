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
	--radius: 16px
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

.form-card {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 16px;
	display: grid;
	grid-template-columns: 420px 1fr;
	gap: 20px;
	padding: 16px
}

@media ( max-width :1080px) {
	.form-card {
		grid-template-columns: 1fr
	}
}

.section {
	border: 1px dashed var(--border);
	border-radius: 14px;
	padding: 14px
}

.sec-title {
	font-weight: 800;
	margin-bottom: 10px
}

.field {
	display: flex;
	flex-direction: column;
	gap: 6px;
	margin-bottom: 12px
}

label {
	font-weight: 700
}

.input, textarea, select {
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 10px;
	background: #fff
}

textarea {
	min-height: 140px;
	resize: vertical
}

.row {
	display: flex;
	gap: 10px
}

.row .input {
	flex: 1
}

.preview {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 280px;
	background: #f7f7fb;
	border: 1px dashed var(--border);
	border-radius: 12px
}

.preview img {
	max-width: 90%;
	max-height: 90%;
	object-fit: contain
}

.actions {
	display: flex;
	gap: 10px;
	justify-content: flex-end;
	margin-top: 14px
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

.btn-ghost {
	background: #fff
}

.badge {
	padding: 4px 8px;
	border-radius: 999px;
	background: #e6f0ff;
	color: #1a73e8;
	margin-left: 6px
}

.alert {
	margin: 8px 0;
	padding: 10px;
	border-radius: 8px
}

.alert-ok {
	background: #ecfdf5;
	color: #065f46;
	border: 1px solid #a7f3d0
}

.alert-err {
	background: #fef2f2;
	color: #991b1b;
	border: 1px solid #fecaca
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">
			<div class="page-title">
				Sửa sản phẩm <span class="badge">#${p.maSP}</span>
			</div>

			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi khi lưu. Thử lại.</div>
			</c:if>

			<form method="post"
				action="${pageContext.request.contextPath}/admin/products/edit">
				<input type="hidden" name="maSP" value="${p.maSP}" />

				<div class="form-card">

					<!-- Cột trái: Hình & mô tả -->
					<div class="section">
						<div class="sec-title">Hình ảnh & Mô tả</div>

						<div class="preview">
							<c:choose>
								<c:when test="${not empty p.hinhAnh}">
									<img id="imgPreview"
										src="${pageContext.request.contextPath}/${p.hinhAnh}"
										alt="${p.tenSP}">
								</c:when>
								<c:otherwise>
									<img id="imgPreview"
										src="${pageContext.request.contextPath}/assets/img/placeholder-product.png"
										alt="preview">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="field">
							<label>Đường dẫn hình ảnh</label> <input class="input"
								type="text" name="hinhAnh" value="${p.hinhAnh}"
								oninput="previewChange(this.value)" /> <small class="muted">Ví
								dụ: <code>uploads/products/x1.png</code>
							</small>
						</div>

						<div class="field">
							<label>Mô tả</label>
							<textarea name="moTa" class="input" placeholder="Mô tả ngắn...">${p.moTa}</textarea>
						</div>
					</div>

					<!-- Cột phải: Thông tin cơ bản -->
					<div class="section">
						<div class="sec-title">Thông tin sản phẩm</div>

						<div class="field">
							<label>Tên sản phẩm</label> <input class="input" type="text"
								name="tenSP" value="${p.tenSP}" required />
						</div>

						<div class="row">
							<div class="field" style="flex: 1">
								<label>Giá bán (VNĐ)</label> <input class="input" type="number"
									name="donGia" min="0" step="100" value="${p.donGia}" />
							</div>
							<div class="field" style="flex: 1">
								<label>Kho còn</label> <input class="input" type="number"
									name="soLuongTon" min="0" step="1" value="${p.soLuongTon}" />
							</div>
						</div>

						<div class="row">
							<div class="field" style="flex: 1">
								<label>Danh mục</label> <select name="maDM" class="input"
									required>
									<c:forEach var="c" items="${categories}">
										<option value="${c.maDM}" ${c.maDM==p.maDM ? 'selected' : ''}>${c.tenDM}</option>
									</c:forEach>
								</select>
							</div>
							<div class="field" style="flex: 1">
								<label>Đang bán</label> <label
									style="display: flex; align-items: center; gap: 8px"> <input
									type="checkbox" name="trangThai"
									${p.trangThai ? 'checked' : ''} /> <span class="muted">Hiển
										thị sản phẩm trên cửa hàng</span>
								</label>
							</div>
						</div>

						<div class="actions">
							<a class="btn btn-ghost"
								href="${pageContext.request.contextPath}/admin/products">Hủy</a>
							<button class="btn btn-primary" type="submit">Lưu thay
								đổi</button>
						</div>
					</div>

				</div>
			</form>
		</div>
	</main>
</div>

<script>
	function previewChange(val) {
		const img = document.getElementById('imgPreview');
		if (!img)
			return;
		if (!val) {
			img.src = '${pageContext.request.contextPath}/assets/img/placeholder-product.png';
			return;
		}
		img.src = (val.startsWith('/') ? ''
				: '${pageContext.request.contextPath}/')
				+ val;
	}
</script>
