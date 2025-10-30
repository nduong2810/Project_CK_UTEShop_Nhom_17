<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="o" value="${order}" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
/* ===== CSS hiện đại hóa cho trang Order View ===== */
:root {
    --admin-bg: #f5f7fb;
    --admin-border: #e5e7eb;
    --card: #fff;
    --muted: #6b7280;
    --primary: #0b57d0;
    --radius: 16px;
    --shadow: 0 8px 20px rgba(17, 24, 39, .08);
    --text-color: #1f2937;
    --heading-color: #111827;
    --button-hover-shadow: 0 6px 20px rgba(11, 87, 208, 0.3);
}

.admin-shell {
    display: flex;
    background: var(--admin-bg);
}

.admin-content {
    flex: 1;
    min-width: 0;
}

.admin-container {
    padding: 24px;
    font-family: 'Inter', sans-serif;
}

.page-title {
    font-size: 28px;
    font-weight: 700;
    margin: 0 0 20px;
    color: var(--heading-color);
    display: flex;
    align-items: center;
    gap: 12px;
}

.card {
    background: var(--card);
    border: 1px solid var(--admin-border);
    border-radius: var(--radius);
    padding: 24px;
    margin-bottom: 24px;
    box-shadow: var(--shadow);
}

.grid {
    display: grid;
    gap: 24px;
}

@media (min-width: 900px) {
    .grid-2 {
        grid-template-columns: 1fr 1fr;
    }
}

.info-grid {
    display: grid;
    gap: 16px;
}

.info-item .label {
    font-size: 13px;
    color: var(--muted);
    margin-bottom: 4px;
    font-weight: 500;
}

.info-item .value {
    font-weight: 600;
    color: var(--text-color);
}

.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 16px;
}

.table th, .table td {
    padding: 12px 16px;
    font-size: 14px;
    text-align: left;
    border-bottom: 1px solid var(--admin-border);
}

.table th {
    background: #fafafa;
    font-weight: 600;
    color: var(--muted);
    font-size: 13px;
    text-transform: uppercase;
    letter-spacing: .5px;
}

.table .text-right { text-align: right; }

.badge {
    display: inline-flex;
    align-items: center;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: .5px;
}

.badge-new { background: #e0f2fe; color: #0c54a1; }
.badge-confirm { background: #dcfce7; color: #166534; }
.badge-ship { background: #ffedd5; color: #9a3412; }
.badge-done { background: #d1fae5; color: #065f46; }
.badge-cancel { background: #fee2e2; color: #991b1b; }
.badge-return { background: #fef9c3; color: #854d0e; }
.badge-refund { background: #f3e8ff; color: #6b21a8; }
.badge-gray { background: #f3f4f6; color: #374151; }

.actions {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    margin-top: 24px;
}

.btn {
    height: 42px;
    border-radius: 10px;
    border: 1px solid var(--admin-border);
    background: #fff;
    cursor: pointer;
    padding: 0 24px;
    font-weight: 600;
    transition: all .2s ease;
    box-shadow: var(--shadow);
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: var(--button-hover-shadow);
}

.btn-primary {
    background: var(--primary);
    color: #fff;
    border-color: var(--primary);
}

.muted {
    color: var(--muted);
}

.hr {
    border: none;
    border-top: 1px solid var(--admin-border);
    margin: 16px 0;
}

.totals {
    display: grid;
    gap: 8px;
    max-width: 350px;
    margin-left: auto;
}

.totals .total-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.totals .total-label { color: var(--muted); }
.totals .total-value { font-weight: 600; }
.totals .grand-total .total-label { font-weight: 600; color: var(--text-color); }
.totals .grand-total .total-value { font-weight: 700; font-size: 1.2em; color: var(--primary); }

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">

            <div class="page-title">
                Đơn hàng #${o.maDH}
                <c:choose>
                    <c:when test="${o.trangThai=='CHO_XAC_NHAN'}"><span class="badge badge-new">Chờ xác nhận</span></c:when>
                    <c:when test="${o.trangThai=='DA_XAC_NHAN'}"><span class="badge badge-confirm">Đã xác nhận</span></c:when>
                    <c:when test="${o.trangThai=='DANG_CHUAN_BI'}"><span class="badge badge-ship">Đang chuẩn bị</span></c:when>
                    <c:when test="${o.trangThai=='DANG_GIAO'}"><span class="badge badge-ship">Đang giao</span></c:when>
                    <c:when test="${o.trangThai=='DA_GIAO'}"><span class="badge badge-done">Đã giao</span></c:when>
                    <c:when test="${o.trangThai=='HOAN_THANH'}"><span class="badge badge-done">Hoàn thành</span></c:when>
                    <c:when test="${o.trangThai=='DA_HUY'}"><span class="badge badge-cancel">Đã huỷ</span></c:when>
                    <c:when test="${o.trangThai=='TRA_HANG'}"><span class="badge badge-return">Trả hàng</span></c:when>
                    <c:when test="${o.trangThai=='HOAN_TIEN'}"><span class="badge badge-refund">Hoàn tiền</span></c:when>
                    <c:otherwise><span class="badge badge-gray">—</span></c:otherwise>
                </c:choose>
            </div>

            <div class="grid grid-2">
                <div class="card">
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="label">Khách hàng</div>
                            <div class="value">${o.nguoiDung.hoTen}</div>
                        </div>
                        <div class="info-item">
                            <div class="label">Email</div>
                            <div class="value">${o.nguoiDung.email}</div>
                        </div>
                        <div class="info-item">
                            <div class="label">Số điện thoại</div>
                            <div class="value">
                                <c:choose>
                                    <c:when test="${not empty o.soDienThoaiNhanHang}">${o.soDienThoaiNhanHang}</c:when>
                                    <c:when test="${not empty o.nguoiDung.soDienThoai}">${o.nguoiDung.soDienThoai}</c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="label">Ngày đặt</div>
                            <div class="value"><fmt:formatDate value="${o.ngayDat}" pattern="dd/MM/yyyy HH:mm" /></div>
                        </div>
                        <div class="info-item">
                            <div class="label">Phương thức thanh toán</div>
                            <div class="value">${empty o.phuongThucThanhToan ? '—' : o.phuongThucThanhToan}</div>
                        </div>
                        <div class="info-item">
                            <div class="label">Địa chỉ giao hàng</div>
                            <div class="value">${o.diaChiGiaoHang}</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3 class="sec-title">Sản phẩm trong đơn</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th style="width: 70px">#</th>
                            <th>Sản phẩm</th>
                            <th class="text-right" style="width: 140px">Đơn giá</th>
                            <th class="text-right" style="width: 90px">SL</th>
                            <th class="text-right" style="width: 160px">Thành tiền</th>
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
                                    <div class="muted" style="font-size: 12px">Mã SP: ${d.sanPham.maSP}</div>
                                </td>
                                <td class="text-right"><fmt:formatNumber value="${d.donGia}" type="number" maxFractionDigits="0" />đ</td>
                                <td class="text-right">${d.soLuong}</td>
                                <td class="text-right">
                                    <c:choose>
                                        <c:when test="${d.thanhTien ne null}">
                                            <fmt:formatNumber value="${d.thanhTien}" type="number" maxFractionDigits="0" />đ
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${d.donGia * d.soLuong}" type="number" maxFractionDigits="0" />đ
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty o.chiTietDonHangs}">
                            <tr>
                                <td colspan="5" class="muted" style="text-align: center; padding: 40px;">Chưa có dòng hàng.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                
                <div class="hr"></div>

                <div class="totals">
                    <div class="total-row">
                        <span class="total-label">Tạm tính</span>
                        <span class="total-value"><fmt:formatNumber value="${o.tongTien}" type="number" maxFractionDigits="0" />đ</span>
                    </div>
                    <div class="total-row">
                        <span class="total-label">Phí vận chuyển</span>
                        <span class="total-value"><fmt:formatNumber value="${o.phiVanChuyen}" type="number" maxFractionDigits="0" />đ</span>
                    </div>
                    <div class="total-row">
                        <span class="total-label">Giảm giá</span>
                        <span class="total-value">- <fmt:formatNumber value="${o.tienGiam}" type="number" maxFractionDigits="0" />đ</span>
                    </div>
                    <div class="hr"></div>
                    <div class="total-row grand-total">
                        <span class="total-label">Tổng thanh toán</span>
                        <span class="total-value"><fmt:formatNumber value="${o.tongThanhToan}" type="number" maxFractionDigits="0" />đ</span>
                    </div>
                </div>
            </div>

            <div class="grid grid-2">
                <div class="card">
                    <div class="info-item">
                        <div class="label">Ghi chú</div>
                        <div class="value">${empty o.ghiChu ? '—' : o.ghiChu}</div>
                    </div>
                </div>
                <div class="card">
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="label">Ngày xác nhận</div>
                            <div class="value"><b><fmt:formatDate value="${o.ngayXacNhan}" pattern="dd/MM/yyyy HH:mm" /></b></div>
                        </div>
                        <div class="info-item">
                            <div class="label">Ngày giao hàng</div>
                            <div class="value"><b><fmt:formatDate value="${o.ngayGiaoHang}" pattern="dd/MM/yyyy HH:mm" /></b></div>
                        </div>
                        <div class="info-item">
                            <div class="label">Ngày nhận hàng</div>
                            <div class="value"><b><fmt:formatDate value="${o.ngayNhanHang}" pattern="dd/MM/yyyy HH:mm" /></b></div>
                        </div>
                        <div class="info-item">
                            <div class="label">Ngày huỷ</div>
                            <div class="value"><b><fmt:formatDate value="${o.ngayHuy}" pattern="dd/MM/yyyy HH:mm" /></b></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="actions">
                <button class="btn btn-ghost" onclick="history.back()">Quay lại</button>
                <button class="btn btn-primary" onclick="location.href='${ctx}/admin/orders'">Danh sách đơn</button>
            </div>

        </div>
    </main>
</div>
