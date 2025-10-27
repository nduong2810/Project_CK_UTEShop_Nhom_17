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
					<c:when test="${c.maGG == null}">Thêm mã giảm giá</c:when>
					<c:otherwise>Sửa mã giảm giá #${c.maGG}</c:otherwise>
				</c:choose>
			</div>

			<c:if test="${param.msg=='saved'}">
				<div class="alert alert-ok">Đã lưu thay đổi.</div>
			</c:if>
			<c:if test="${param.msg=='code_exists'}">
				<div class="alert alert-err">Mã code đã tồn tại.</div>
			</c:if>
			<c:if test="${param.msg=='error'}">
				<div class="alert alert-err">Có lỗi xảy ra, vui lòng thử lại.</div>
			</c:if>

			<div class="actions"
				style="justify-content: flex-start; margin-top: 0">
				<button class="btn"
					onclick="location.href='${pageContext.request.contextPath}/admin/coupons'">←
					Danh sách</button>

				<c:if test="${c.maGG != null}">
					<form method="post"
						action="${pageContext.request.contextPath}/admin/coupons/delete"
						style="display: inline"
						onsubmit="return confirm('Xoá mã #${c.maGG} (${c.maCode})?');">
						<input type="hidden" name="id" value="${c.maGG}">
						<button class="btn" style="border-color: #fecaca; color: #991b1b">Xoá</button>
					</form>
				</c:if>
			</div>

			<form method="post"
				action="${pageContext.request.contextPath}/admin/coupons/edit">
				<c:if test="${c.maGG != null}">
					<input type="hidden" name="maGG" value="${c.maGG}" />
				</c:if>

				<div class="card">
					<div class="grid">
						<div class="field">
							<label>Mã code</label> <input class="input" name="maCode"
								value="${c.maCode}" required />
						</div>

						<div class="field">
							<label>Mã số (tuỳ chọn)</label> <input class="input" name="maSo"
								value="${c.maSo}" />
						</div>

						<div class="field" style="grid-column: 1/-1">
							<label>Tên chương trình</label> <input class="input"
								name="tenChuongTrinh" value="${c.tenChuongTrinh}" required />
						</div>

						<div class="field">
							<label>Loại giảm</label> <select class="input" name="loaiGiam"
								id="loaiGiam" onchange="toggleType()" required>
								<option value="amount" ${c.loaiGiam=='amount'?'selected':''}>Giảm
									tiền</option>
								<option value="percent" ${c.loaiGiam=='percent'?'selected':''}>Giảm
									%</option>
							</select>
						</div>

						<div class="field" id="boxAmount">
							<label>Số tiền giảm (VNĐ)</label> <input class="input"
								name="giaTriGiam" value="${c.giaTriGiam}" />
						</div>

						<div class="field" id="boxPercent">
							<label>Phần trăm giảm (%)</label> <input class="input"
								name="phanTramGiam" value="${c.phanTramGiam}" />
						</div>

						<div class="field">
							<label>Đơn hàng tối thiểu (VNĐ)</label> <input class="input"
								name="giaTriToiThieu" value="${c.giaTriToiThieu}" />
							<div class="helper">Áp dụng khi loại giảm là %, để giới hạn
								mức tối thiểu.</div>
						</div>

						<div class="field">
							<label>Ngày bắt đầu</label> <input class="input" type="date"
								name="ngayBatDau"
								value="<fmt:formatDate value='${c.ngayBatDau}' pattern='yyyy-MM-dd'/>"
								required />
						</div>

						<div class="field">
							<label>Ngày kết thúc</label> <input class="input" type="date"
								name="ngayKetThuc"
								value="<fmt:formatDate value='${c.ngayKetThuc}' pattern='yyyy-MM-dd'/>"
								required />
						</div>
					</div>

					<div class="actions">
						<a class="btn"
							href="${pageContext.request.contextPath}/admin/coupons">Hủy</a>
						<button class="btn btn-primary" type="submit">Lưu</button>
					</div>
				</div>
			</form>
		</div>
	</main>
</div>

<script>
	function toggleType() {
		var t = document.getElementById('loaiGiam').value;
		document.getElementById('boxAmount').style.display = (t === 'amount') ? 'block'
				: 'none';
		document.getElementById('boxPercent').style.display = (t === 'percent') ? 'block'
				: 'none';
	}
	toggleType();
</script>
