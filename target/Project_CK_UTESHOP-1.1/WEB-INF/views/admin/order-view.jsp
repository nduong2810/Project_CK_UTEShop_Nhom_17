<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Nếu dùng javax JSTL (Tomcat 9-), đổi dòng fmt dưới thành:
     <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
--%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="o" value="${order}" />

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
	margin-bottom: 12px
}

.grid {
	display: grid;
	gap: 12px
}

@media ( min-width :900px) {
	.grid-2 {
		grid-template-columns: 1fr 1fr
	}
}

.label {
	font-size: 12px;
	color: var(--muted);
	margin-bottom: 4px
}

.value {
	font-weight: 700
}

.table {
	width: 100%;
	border-collapse: collapse
}

.table th, .table td {
	border-top: 1px solid var(--border);
	padding: 10px 12px;
	font-size: 14px
}

.table th {
	background: #fafafa;
	text-align: left
}

.badge {
	display: inline-flex;
	align-items: center;
	padding: 4px 10px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700
}

.badge-gray {
	background: #f3f4f6;
	color: #374151
}

.badge-blue {
	background: #dbeafe;
	color: #1d4ed8
}

.badge-amber {
	background: #fef3c7;
	color: #92400e
}

.badge-green {
	background: #dcfce7;
	color: #166534
}

.badge-red {
	background: #fee2e2;
	color: #991b1b
}

.actions {
	display: flex;
	gap: 8px;
	flex-wrap: wrap
}

.btn {
	height: 38px;
	border: 1px solid var(--border);
	background: #fff;
	border-radius: 10px;
	padding: 0 12px;
	cursor: pointer
}

.btn-primary {
	background: #1a73e8;
	color: #fff;
	border-color: transparent
}

.muted {
	color: var(--muted)
}

.hr {
	border: none;
	border-top: 1px solid var(--border);
	margin: 10px 0
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

	<main class="admin-content">
		<div class="admin-container">

			<!-- Tiêu đề + trạng thái -->
			<div class="title">
				Đơn hàng #${o.maDH}
				<c:choose>
					<c:when test="${o.trangThai=='DON_HANG_MOI'}">
						<span class="badge badge-gray">Mới tạo</span>
					</c:when>
					<c:when test="${o.trangThai=='DA_XAC_NHAN'}">
						<span class="badge badge-blue">Đã xác nhận</span>
					</c:when>
					<c:when test="${o.trangThai=='DANG_GIAO'}">
						<span class="badge badge-amber">Đang giao</span>
					</c:when>
					<c:when test="${o.trangThai=='DA_GIAO'}">
						<span class="badge badge-green">Đã giao</span>
					</c:when>
					<c:when test="${o.trangThai=='DA_HUY'}">
						<span class="badge badge-red">Đã huỷ</span>
					</c:when>
					<c:when test="${o.trangThai=='TRA_HANG'}">
						<span class="badge badge-red">Trả hàng</span>
					</c:when>
					<c:when test="${o.trangThai=='HOAN_TIEN'}">
						<span class="badge badge-blue">Hoàn tiền</span>
					</c:when>
					<c:otherwise>
						<span class="badge badge-gray">—</span>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- Thông tin KH & đơn -->
			<div class="grid grid-2">
				<div class="card">
					<div class="label">Khách hàng</div>
					<div class="value">${o.nguoiDung.hoTen}</div>

					<div class="label" style="margin-top: 8px">Email</div>
					<div>${o.nguoiDung.email}</div>

					<div class="label" style="margin-top: 8px">Số điện thoại</div>
					<div>
						<c:choose>
							<c:when test="${not empty o.soDienThoaiNhanHang}">${o.soDienThoaiNhanHang}</c:when>
							<c:when test="${not empty o.nguoiDung.soDienThoai}">${o.nguoiDung.soDienThoai}</c:when>
							<c:otherwise>—</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="card">
					<div class="label">Ngày đặt</div>
					<div>
						<fmt:formatDate value="${o.ngayDat}" pattern="dd/MM/yyyy HH:mm" />
					</div>

					<div class="label" style="margin-top: 8px">Phương thức thanh
						toán</div>
					<div>${empty o.phuongThucThanhToan ? '—' : o.phuongThucThanhToan}</div>

					<div class="label" style="margin-top: 8px">Địa chỉ giao hàng</div>
					<div>${o.diaChiGiaoHang}</div>
				</div>
			</div>

			<!-- Bảng dòng hàng -->
			<div class="card">
				<div class="label">Sản phẩm trong đơn</div>
				<table class="table">
					<thead>
						<tr>
							<th style="width: 70px">#</th>
							<th>Sản phẩm</th>
							<th style="width: 140px">Đơn giá</th>
							<th style="width: 90px">SL</th>
							<th style="width: 160px">Thành tiền</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="idx" value="0" />
						<c:forEach var="d" items="${o.chiTietDonHangs}">
							<c:set var="idx" value="${idx + 1}" />
							<tr>
								<td>${idx}</td>
								<td>
									<div>${d.sanPham.tenSP}</div>
									<div class="muted" style="font-size: 12px">Mã SP:
										${d.sanPham.maSP}</div>
								</td>
								<td><fmt:formatNumber value="${d.donGia}" type="number"
										maxFractionDigits="0" />đ</td>
								<td>${d.soLuong}</td>
								<td><c:choose>
										<c:when test="${d.thanhTien ne null}">
											<fmt:formatNumber value="${d.thanhTien}" type="number"
												maxFractionDigits="0" />đ
                    </c:when>
										<c:otherwise>
											<fmt:formatNumber value="${d.donGia * d.soLuong}"
												type="number" maxFractionDigits="0" />đ
                    </c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>

						<c:if test="${empty o.chiTietDonHangs}">
							<tr>
								<td colspan="5" class="muted">Chưa có dòng hàng.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<!-- Tổng tiền -->
			<div class="grid grid-2">
				<div></div>
				<div class="card">
					<div class="label">Tạm tính</div>
					<div class="value">
						<fmt:formatNumber value="${o.tongTien}" type="number"
							maxFractionDigits="0" />
						đ
					</div>

					<div class="label" style="margin-top: 8px">Phí vận chuyển</div>
					<div>
						<fmt:formatNumber value="${o.phiVanChuyen}" type="number"
							maxFractionDigits="0" />
						đ
					</div>

					<div class="label" style="margin-top: 8px">Giảm giá</div>
					<div>
						-
						<fmt:formatNumber value="${o.tienGiam}" type="number"
							maxFractionDigits="0" />
						đ
					</div>

					<div class="hr"></div>

					<div class="label">Tổng thanh toán</div>
					<div class="value" style="font-size: 18px">
						<fmt:formatNumber value="${o.tongThanhToan}" type="number"
							maxFractionDigits="0" />
						đ
					</div>
				</div>
			</div>

			<!-- Ghi chú & mốc thời gian -->
			<div class="grid grid-2">
				<div class="card">
					<div class="label">Ghi chú</div>
					<div>${empty o.ghiChu ? '—' : o.ghiChu}</div>
				</div>
				<div class="card">
					<div class="label">Mốc thời gian</div>
					<div>
						Ngày xác nhận: <b><fmt:formatDate value="${o.ngayXacNhan}"
								pattern="dd/MM/yyyy HH:mm" /></b>
					</div>
					<div>
						Ngày giao hàng: <b><fmt:formatDate value="${o.ngayGiaoHang}"
								pattern="dd/MM/yyyy HH:mm" /></b>
					</div>
					<div>
						Ngày nhận hàng: <b><fmt:formatDate value="${o.ngayNhanHang}"
								pattern="dd/MM/yyyy HH:mm" /></b>
					</div>
					<div>
						Ngày huỷ: <b><fmt:formatDate value="${o.ngayHuy}"
								pattern="dd/MM/yyyy HH:mm" /></b>
					</div>
				</div>
			</div>

			<!-- Actions -->
			<div class="actions">
				<button class="btn" onclick="history.back()">Quay lại</button>
				<button class="btn" onclick="location.href='${ctx}/admin/orders'">Danh
					sách đơn</button>
			</div>

		</div>
	</main>
</div>
