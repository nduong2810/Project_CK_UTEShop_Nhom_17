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

.card {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 16px;
	padding: 16px;
	max-width: 720px
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
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">

			<div class="title">
				<c:choose>
					<c:when test="${s.maVC == null}">Thêm đơn vị vận chuyển</c:when>
					<c:otherwise>Sửa đơn vị vận chuyển #${s.maVC}</c:otherwise>
				</c:choose>
			</div>

			<!-- Alerts -->
			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra, thử lại.</div>
			</c:if>

			<div class="actions"
				style="justify-content: flex-start; margin-top: 0">
				<button class="btn"
					onclick="location.href='${pageContext.request.contextPath}/admin/shipping'">←
					Danh sách</button>

				<c:if test="${s.maVC != null}">
					<form method="post"
						action='${pageContext.request.contextPath}/admin/shipping/delete'
						style="display: inline"
						onsubmit="return confirm('Xoá đơn vị vận chuyển #${s.maVC}? Hành động này không thể hoàn tác.');">
						<input type="hidden" name="id" value="${s.maVC}">
						<button class="btn" style="border-color: #fecaca; color: #991b1b">Xoá</button>
					</form>
				</c:if>
			</div>

			<form method="post"
				action="${pageContext.request.contextPath}/admin/shipping/edit">
				<c:if test="${s.maVC != null}">
					<input type="hidden" name="maVC" value="${s.maVC}" />
				</c:if>

				<div class="card">
					<div class="grid">
						<div class="field" style="grid-column: 1/-1">
							<label>Tên đơn vị</label> <input class="input" name="tenDonVi"
								value="${s.tenDonVi}" required />
						</div>
						<div class="field">
							<label>Phí vận chuyển (VNĐ)</label> <input class="input"
								name="phiVanChuyen" value="${s.phiVanChuyen}" required />
						</div>
					</div>

					<div class="actions">
						<a class="btn"
							href="${pageContext.request.contextPath}/admin/shipping">Hủy</a>
						<button class="btn btn-primary" type="submit">Lưu</button>
					</div>
				</div>
			</form>

		</div>
	</main>
</div>
