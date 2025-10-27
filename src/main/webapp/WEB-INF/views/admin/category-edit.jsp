<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- CSS riêng cho trang -->
<style>
:root {
	--bg: #f5f7fb;
	--border: #e5e7eb;
	--card: #fff;
	--muted: #6b7280;
	--primary: #1a73e8
}

.admin-content {
	flex: 1;
	min-width: 0;
	background: var(--bg)
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

.card {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 16px;
	padding: 16px;
	max-width: 920px
}

.grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 14px
}

@media ( max-width :900px) {
	.grid {
		grid-template-columns: 1fr
	}
}

.field {
	display: flex;
	flex-direction: column;
	gap: 6px
}

label {
	font-weight: 700
}

.input, textarea {
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 10px;
	background: #fff
}

textarea {
	min-height: 110px;
	resize: vertical
}

.actions {
	display: flex;
	gap: 10px;
	justify-content: space-between;
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
	background: #1a73e8;
	color: #fff;
	border-color: transparent
}

.badge {
	padding: 4px 8px;
	border-radius: 999px;
	background: #e6f0ff;
	color: #1a73e8;
	margin-left: 6px
}

.alert {
	margin-bottom: 12px;
	padding: 10px;
	border-radius: 8px;
	font-size: 14px
}

.alert-ok {
	background: #ecfdf5;
	border: 1px solid #a7f3d0;
	color: #065f46
}

.alert-err {
	background: #fef2f2;
	border: 1px solid #fecaca;
	color: #991b1b
}

.img-preview {
	width: 240px;
	height: 180px;
	border: 1px solid var(--border);
	border-radius: 12px;
	object-fit: cover;
	background: #f3f4f6
}

.helper {
	font-size: 12px;
	color: var(--muted)
}

.muted {
	color: var(--muted)
}
</style>

<div class="admin-shell">
	<!-- ĐỪNG include footer trong khối này -->
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">

			<div class="title">
				<c:choose>
					<c:when test="${c.maDM == null}">Thêm danh mục</c:when>
					<c:otherwise>Sửa danh mục <span class="badge">#${c.maDM}</span>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- Alerts -->
			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra, vui lòng thử lại.</div>
			</c:if>

			<div class="actions"
				style="justify-content: flex-start; margin-top: 0">
				<button class="btn"
					onclick="location.href='${pageContext.request.contextPath}/admin/categories'">←
					Danh sách</button>
			</div>

			<!-- LƯU Ý: multipart cho upload ảnh -->
			<form method="post"
				action="${pageContext.request.contextPath}/admin/categories/edit"
				enctype="multipart/form-data">
				<c:if test="${c.maDM != null}">
					<input type="hidden" name="maDM" value="${c.maDM}" />
				</c:if>

				<div class="card">
					<div class="grid">

						<div class="field" style="grid-column: 1/-1">
							<label>Tên danh mục</label> <input class="input" name="tenDM"
								value="${c.tenDM}" required />
						</div>

						<div class="field" style="grid-column: 1/-1">
							<label>Mô tả</label>
							<textarea class="input" name="moTa" placeholder="Mô tả ngắn...">${c.moTa}</textarea>
						</div>

						<!-- Ảnh hiện tại + Upload -->
						<div class="field">
							<label>Ảnh hiện tại</label>
							<c:choose>
								<c:when test="${not empty c.hinhAnh}">
									<img id="imgPreview" class="img-preview"
										src="${pageContext.request.contextPath}/${c.hinhAnh}"
										alt="preview">
								</c:when>
								<c:otherwise>
									<img id="imgPreview" class="img-preview"
										src="${pageContext.request.contextPath}/assets/img/no-image.png"
										alt="preview">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="field">
							<label>Chọn ảnh mới (tải từ máy)</label> <input class="input"
								type="file" name="imageFile" accept="image/*"
								onchange="previewFile(this)">
							<div class="helper">
								Tệp sẽ lưu vào
								<code>assets/img/</code>
								. Dung lượng ≤ 10MB.
							</div>
						</div>

						<div class="field" style="grid-column: 1/-1">
							<label>Hoặc nhập đường dẫn ảnh (tuỳ chọn)</label> <input
								class="input" name="hinhAnhInput" value="${c.hinhAnh}">
							<div class="helper">Nếu nhập ô này, hệ thống sẽ dùng đường
								dẫn này thay cho ảnh upload.</div>
						</div>

						<div class="field">
							<label>Trạng thái</label> <label
								style="display: flex; align-items: center; gap: 8px"> <input
								type="checkbox" name="trangThai" ${c.trangThai==1?'checked':''} />
								<span class="muted">Hiển thị</span>
							</label>
						</div>

					</div>

					<div class="actions">
						<a class="btn"
							href="${pageContext.request.contextPath}/admin/categories">Hủy</a>
						<button class="btn btn-primary" type="submit">Lưu</button>
					</div>
				</div>
			</form>
		</div>
	</main>
</div>

<!-- JS xem trước ảnh upload -->
<script>
function previewFile(input){
  const file = input.files && input.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = e => document.getElementById('imgPreview').src = e.target.result;
  reader.readAsDataURL(file);
}
</script>
