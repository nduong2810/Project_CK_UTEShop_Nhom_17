<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

.card {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 16px;
	padding: 16px;
	max-width: 960px
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

.input {
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 10px;
	background: #fff;
	height: 40px
}

textarea {
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 10px;
	background: #fff;
	min-height: 100px
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

.alert-err {
	margin-bottom: 12px;
	padding: 10px;
	border-radius: 8px;
	font-size: 14px;
	background: #fef2f2;
	border: 1px solid #fecaca;
	color: #991b1b
}

.helper {
	font-size: 12px;
	color: #6b7280
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">
			<div class="title">
				<c:choose>
					<c:when test="${shop.maCH == null}">Thêm cửa hàng</c:when>
					<c:otherwise>Sửa cửa hàng #${shop.maCH}</c:otherwise>
				</c:choose>
			</div>

			<c:if test="${not empty error}">
				<div class="alert-err">${error}</div>
			</c:if>

			<div class="actions"
				style="justify-content: flex-start; margin-top: 0">
				<button class="btn"
					onclick="location.href='${pageContext.request.contextPath}/admin/suppliers'">←
					Danh sách</button>
				<c:if test="${shop.maCH != null}">
					<form method="post"
						action="${pageContext.request.contextPath}/admin/suppliers"
						onsubmit="return confirm('Xoá cửa hàng #${shop.maCH}?');"
						style="display: inline">
						<input type="hidden" name="op" value="delete" /> <input
							type="hidden" name="id" value="${shop.maCH}" />
						<button class="btn" style="border-color: #fecaca; color: #991b1b">Xoá</button>
					</form>
				</c:if>
			</div>

			<!-- Lưu: POST về /admin/suppliers/edit -->
			<form method="post"
				action="${pageContext.request.contextPath}/admin/suppliers/edit">
				<c:if test="${shop.maCH != null}">
					<input type="hidden" name="maCH" value="${shop.maCH}" />
				</c:if>

				<div class="card">
					<div class="grid">
						<div class="field" style="grid-column: 1/-1">
							<label>Tên cửa hàng</label> <input class="input" name="tenCH"
								value="${shop.tenCH}" required />
						</div>

						<div class="field" style="grid-column: 1/-1">
							<label>Địa chỉ</label>
							<textarea name="diaChi">${shop.diaChi}</textarea>
						</div>

						<div class="field">
							<label>Số điện thoại</label> <input class="input"
								name="soDienThoai" value="${shop.soDienThoai}" />
						</div>

						<div class="field">
							<label>Email</label> <input class="input" name="email"
								value="${shop.email}" />
						</div>

						<div class="field">
							<label>Tỷ lệ chiết khấu (%)</label> <input class="input"
								type="number" step="0.01" min="0" max="100" name="tyLeChietKhau"
								value="${shop.tyLeChietKhau}" placeholder="VD: 5.00" />
							<div class="helper">Áp dụng trên doanh thu hàng hóa, không
								gồm phí vận chuyển.</div>
						</div>

						<div class="field">
							<label>Trạng thái</label> <label
								style="display: flex; align-items: center; gap: 8px"> <input
								type="checkbox" name="trangThai"
								${shop.trangThai ? 'checked' : ''} /> <span class="helper">Hoạt
									động</span>
							</label>
						</div>
					</div>

					<div class="actions">
						<a class="btn"
							href="${pageContext.request.contextPath}/admin/suppliers">Hủy</a>
						<button class="btn btn-primary" type="submit">Lưu</button>
					</div>
				</div>
			</form>

		</div>
	</main>
</div>
