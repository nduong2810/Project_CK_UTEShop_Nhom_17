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

@media ( max-width :980px) {
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

.input, select, textarea {
	border: 1px solid var(--border);
	border-radius: 10px;
	padding: 10px;
	background: #fff
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
	margin-bottom: 10px;
	padding: 10px;
	border-radius: 8px
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
				Sửa khách hàng <span class="badge">#${u.maND}</span>
			</div>

			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra, thử lại.</div>
			</c:if>

			<form method="post"
				action="${pageContext.request.contextPath}/admin/customers/edit">
				<input type="hidden" name="maND" value="${u.maND}" />

				<div class="card">
					<div class="grid">
						<div class="field">
							<label>Họ tên</label> <input class="input" name="hoTen"
								value="${u.hoTen}" required />
						</div>
						<div class="field">
							<label>Email</label> <input class="input" type="email"
								name="email" value="${u.email}" required />
						</div>
						<div class="field">
							<label>Số điện thoại</label> <input class="input"
								name="soDienThoai" value="${u.soDienThoai}" />
						</div>
						<div class="field">
							<label>Địa chỉ</label> <input class="input" name="diaChi"
								value="${u.diaChi}" />
						</div>
						<div class="field">
							<label>Vai trò</label> <select name="vaiTro" class="input">
								<option value="USER" ${u.vaiTro=='USER'?'selected':''}>USER</option>
								<option value="VENDOR" ${u.vaiTro=='VENDOR'?'selected':''}>VENDOR</option>
								<option value="ADMIN" ${u.vaiTro=='ADMIN'?'selected':''}>ADMIN</option>
								<option value="SHIPPER" ${u.vaiTro=='SHIPPER'?'selected':''}>SHIPPER</option>
							</select>
						</div>
						<div class="field">
							<label>Trạng thái</label> <label
								style="display: flex; align-items: center; gap: 8px"> <input
								type="checkbox" name="trangThai" ${u.trangThai?'checked':''} />
								<span class="muted">Hoạt động</span>
							</label>
						</div>
					</div>

					<div class="actions">
						<a class="btn"
							href="${pageContext.request.contextPath}/admin/customers">Hủy</a>
						<button class="btn btn-primary" type="submit">Lưu</button>
					</div>
				</div>
			</form>

		</div>
	</main>
</div>
