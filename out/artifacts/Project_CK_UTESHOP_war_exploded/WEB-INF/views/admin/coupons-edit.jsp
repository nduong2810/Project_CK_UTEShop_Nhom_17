<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.form-grid {
	display: grid;
	grid-template-columns: repeat(12, 1fr);
	gap: 16px
}

.card {
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 12px;
	padding: 16px
}

.form-row {
	display: flex;
	flex-direction: column;
	gap: 6px
}

label {
	font-size: 13px;
	color: #374151;
	font-weight: 600
}

input[type=text], input[type=number], input[type=date], select, textarea
	{
	border: 1px solid #e5e7eb;
	border-radius: 8px;
	padding: 10px 12px;
	font-size: 14px
}

.btn {
	height: 36px;
	padding: 0 14px;
	border: 1px solid #e5e7eb;
	border-radius: 8px;
	background: #fff;
	cursor: pointer
}

.btn-primary {
	background: #0b57d0;
	color: #fff;
	border-color: transparent
}

.btn-danger {
	border-color: #fecaca;
	color: #991b1b
}

.row-actions {
	display: flex;
	gap: 8px;
	justify-content: flex-end
}

.help {
	color: #6b7280;
	font-size: 12px
}

.badge {
	display: inline-block;
	border-radius: 9999px;
	padding: 3px 8px;
	font-size: 12px
}

.badge-gray {
	background: #f3f4f6;
	color: #374151;
	border: 1px solid #e5e7eb
}
</style>

<div class="admin-container">
	<h2 style="margin: 8px 0 16px">Mã giảm giá</h2>

	<c:set var="isNew" value="${empty c.maGG}" />

	<form method="post"
		action="${pageContext.request.contextPath}/admin/coupons/edit">
		<input type="hidden" name="maGG" value="${c.maGG}" />

		<div class="form-grid">
			<!-- Cột trái -->
			<div class="card" style="grid-column: span 8">
				<div class="form-grid">
					<div class="form-row" style="grid-column: span 6">
						<label>Mã code (unique)</label>
						<!-- Controller map name=maCode -> entity.setMaSo(...) -->
						<input type="text" name="maCode" value="${c.maSo}" maxlength="50"
							required />
					</div>

					<div class="form-row" style="grid-column: span 6">
						<label>Tên chương trình</label> <input type="text"
							name="tenChuongTrinh" value="${c.tenChuongTrinh}" maxlength="255"
							required />
					</div>

					<div class="form-row" style="grid-column: span 4">
						<label>Loại giảm</label> <select name="loaiGiam">
							<option value="percent"
								<c:if test="${c.loaiGiam == 'PERCENT'}">selected</c:if>>Giảm
								%</option>
							<option value="amount"
								<c:if test="${c.loaiGiam == 'FIXED_AMOUNT'}">selected</c:if>>Giảm
								tiền cố định</option>
						</select>
					</div>

					<div class="form-row" style="grid-column: span 4">
						<label>Giá trị giảm</label> <input type="number" step="0.01"
							name="giaTriGiam" value="${c.giaTriGiam}" required />
						<div class="help">Nếu là % → nhập 5, 10… | Nếu là tiền →
							nhập số tiền</div>
					</div>

					<div class="form-row" style="grid-column: span 4">
						<label>Giảm tối đa (khi giảm %)</label> <input type="number"
							step="0.01" name="giaTriGiamToiDa" value="${c.giaTriGiamToiDa}" />
					</div>

					<div class="form-row" style="grid-column: span 6">
						<label>Giá trị đơn tối thiểu</label> <input type="number"
							step="0.01" name="giaTriDonHangToiThieu"
							value="${c.giaTriDonHangToiThieu}" />
					</div>

					<div class="form-row" style="grid-column: span 6">
						<label>Số lượt dùng tối đa</label> <input type="number"
							name="soLuongToiDa" value="${c.soLuongToiDa}" />
						<div class="help">Để trống/0 = không giới hạn</div>
					</div>

					<!-- NGÀY: entity là LocalDateTime => dùng toLocalDate() -->
					<div class="form-row" style="grid-column: span 4">
						<label>Ngày bắt đầu</label> <input type="date" name="ngayBatDau"
							value="${c.ngayBatDau != null ? c.ngayBatDau.toLocalDate() : ''}" />
					</div>

					<div class="form-row" style="grid-column: span 4">
						<label>Ngày kết thúc</label> <input type="date" name="ngayKetThuc"
							value="${c.ngayKetThuc != null ? c.ngayKetThuc.toLocalDate() : ''}" />
					</div>

					<div class="form-row" style="grid-column: span 4">
						<label>Hạn sử dụng</label> <input type="date" name="hanSuDung"
							value="${c.hanSuDung != null ? c.hanSuDung.toLocalDate() : ''}" />
					</div>

					<div class="form-row" style="grid-column: span 12">
						<label>Mô tả</label>
						<textarea name="moTa" rows="4"><c:out value="${c.moTa}" /></textarea>
					</div>
				</div>
			</div>

			<!-- Cột phải -->
			<div class="card" style="grid-column: span 4">
				<div class="form-row">
					<label>Trạng thái kích hoạt</label> <label
						style="display: flex; gap: 8px; align-items: center"> <input
						type="checkbox" name="trangThai"
						<c:if test="${c.trangThai}">checked</c:if> /> <span>${c.trangThai ? 'Đang bật' : 'Đang tắt'}</span>
					</label>
				</div>

				<div class="form-row">
					<label>Lượt đã dùng</label>
					<div class="badge badge-gray">${c.soLuongDaSuDung}</div>
				</div>

				<div class="row-actions" style="margin-top: 16px">
					<button class="btn" type="button" onclick="history.back()">Huỷ</button>
					<button class="btn btn-primary" type="submit">Lưu</button>
				</div>

				<c:if test="${not isNew}">
					<hr
						style="margin: 16px 0; border: none; border-top: 1px solid #e5e7eb" />
					<form method="post"
						action="${pageContext.request.contextPath}/admin/coupons/delete"
						style="display: inline"
						onsubmit="return confirm('Xoá mã #${c.maGG} (${c.maSo})?');">
						<input type="hidden" name="id" value="${c.maGG}">
						<button class="btn btn-danger" type="submit">Xoá</button>
					</form>
				</c:if>
			</div>
		</div>
	</form>
</div>
