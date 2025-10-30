<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ===== CSS hiện đại hóa cho trang Coupon Edit ===== */
    :root {
        --admin-bg: #f5f7fb;
        --admin-border: #e5e7eb;
        --card: #fff;
        --muted: #6b7280;
        --primary: #0b57d0;
        --danger: #ef4444;
        --radius: 16px;
        --shadow: 0 8px 20px rgba(17, 24, 39, .08);
        --button-hover-shadow: 0 6px 20px rgba(11, 87, 208, 0.3);
        --text-color: #1f2937;
        --heading-color: #111827;
    }

    /* ===== Bố cục tổng ===== */
    .admin-shell {
        display: flex;
        min-height: 100vh;
        background: var(--admin-bg);
        font-family: 'Inter', sans-serif;
        color: var(--text-color);
    }

    .admin-shell .admin-content {
        flex: 1;
        min-width: 0;
    }

    .admin-shell .admin-container {
        padding: 24px;
        max-width: 1280px;
        margin: 0 auto;
    }

    /* ===== Tiêu đề trang ===== */
    .admin-shell .page-title {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 28px;
        font-weight: 700;
        margin: 0 0 24px;
        color: var(--heading-color);
        padding-bottom: 16px;
        border-bottom: 1px solid var(--admin-border);
    }

    .admin-shell .page-title .back-button {
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        height: 42px;
        border-radius: 12px;
        border: 1px solid transparent;
        background: transparent;
        cursor: pointer;
        padding: 0 16px;
        font-weight: 500;
        transition: all .2s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        color: var(--muted);
    }

    .admin-shell .page-title .back-button:hover {
        background: #f3f4f6;
        color: var(--text-color);
    }

    .admin-shell .page-title .btn-icon {
        width: 18px;
        height: 18px;
        margin-right: 8px;
        stroke-width: 2.5;
    }

    /* ===== Lưới form chính ===== */
    .admin-shell .form-grid {
        display: grid;
        grid-template-columns: 3fr 1fr;
        gap: 32px;
    }

    @media (max-width: 1024px) {
        .admin-shell .form-grid {
            grid-template-columns: 1fr;
        }
    }

    .admin-shell .form-section,
    .admin-shell .form-sidebar {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    /* ===== Card ===== */
    .admin-shell .card {
        background: var(--card);
        border: 1px solid var(--admin-border);
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        overflow: hidden;
    }

    .admin-shell .card-section {
        padding: 24px 32px;
        border-bottom: 1px solid var(--admin-border);
    }

    .admin-shell .card-section:last-child {
        border-bottom: none;
    }

    /* ===== Section ===== */
    .admin-shell .section-header {
        margin-bottom: 20px;
    }

    .admin-shell .section-title {
        font-size: 18px;
        font-weight: 600;
        color: var(--heading-color);
    }

    .admin-shell .section-desc {
        font-size: 14px;
        color: var(--muted);
        margin-top: 4px;
    }

    /* ===== Field ===== */
    .admin-shell .field {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .admin-shell .field-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }

    .admin-shell label {
        font-weight: 600;
        color: var(--heading-color);
        font-size: 15px;
    }

    .admin-shell .input,
    .admin-shell select,
    .admin-shell textarea {
        height: 42px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 0 14px;
        background: #fff;
        color: var(--text-color);
        font-family: 'Inter', sans-serif;
        font-size: 15px;
        transition: border-color .2s ease, box-shadow .2s ease;
    }

    .admin-shell .input:focus,
    .admin-shell select:focus,
    .admin-shell textarea:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(11, 87, 208, 0.2);
    }

    .admin-shell textarea {
        height: auto;
        min-height: 120px;
        padding: 14px;
        resize: vertical;
    }

    /* ===== Khu vực hành động ===== */
    .admin-shell .form-actions {
        display: flex;
        gap: 12px;
        justify-content: space-between;
        align-items: center;
        padding: 24px 32px;
        background: #f9fafb;
        border-top: 1px solid var(--admin-border);
    }

    .admin-shell .form-actions .right-actions {
        display: flex;
        gap: 12px;
    }

    /* ===== Nút ===== */
    .admin-shell .btn {
        height: 42px;
        border-radius: 12px;
        border: 1px solid var(--admin-border);
        background: #fff;
        cursor: pointer;
        padding: 0 24px;
        font-weight: 600;
        transition: all .2s ease;
        box-shadow: var(--shadow);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        color: var(--text-color);
    }

    .admin-shell .btn:hover {
        transform: translateY(-2px);
        box-shadow: var(--button-hover-shadow);
    }

    .admin-shell .btn-primary {
        background: var(--primary);
        color: #fff;
        border-color: var(--primary);
    }

    .admin-shell .btn-primary:hover {
        background: #0a4dbd;
        border-color: #0a4dbd;
    }

    .admin-shell .btn-danger {
        background: var(--danger);
        color: #fff;
        border-color: transparent;
    }

    .admin-shell .btn-danger:hover {
        background: #dc2626;
    }

    .admin-shell .btn-ghost {
        background: transparent;
        border-color: transparent;
        box-shadow: none;
        color: var(--muted);
    }

    .admin-shell .btn-ghost:hover {
        background: #f3f4f6;
        color: var(--text-color);
        transform: none;
    }

    /* ===== Thông báo ===== */
    .admin-shell .alert {
        margin-bottom: 20px;
        padding: 12px 16px;
        border-radius: 8px;
        font-size: 14px;
    }

    .admin-shell .alert-ok {
        background: #ecfdf5;
        border: 1px solid #a7f3d0;
        color: #065f46;
    }

    .admin-shell .alert-err {
        background: #fef2f2;
        border: 1px solid #fecaca;
        color: #991b1b;
    }

    /* ===== Checkbox ===== */
    .admin-shell .checkbox-field {
        display: flex;
        align-items: center;
        gap: 12px;
        height: 42px;
        cursor: pointer;
        user-select: none;
    }

    .admin-shell .checkbox-field input[type="checkbox"] {
        display: none;
    }

    .admin-shell .checkbox-custom {
        width: 22px;
        height: 22px;
        border: 2px solid var(--admin-border);
        border-radius: 6px;
        display: inline-block;
        position: relative;
        transition: background-color 0.2s, border-color 0.2s;
        flex-shrink: 0;
    }

    .admin-shell .checkbox-field input[type="checkbox"]:checked + .checkbox-custom {
        background-color: var(--primary);
        border-color: var(--primary);
    }

    .admin-shell .checkbox-custom::after {
        content: '';
        position: absolute;
        display: none;
        left: 6px;
        top: 2px;
        width: 6px;
        height: 12px;
        border: solid white;
        border-width: 0 3px 3px 0;
        transform: rotate(45deg);
    }

    .admin-shell .checkbox-field input[type="checkbox"]:checked + .checkbox-custom::after {
        display: block;
    }

    /* ===== Badge trạng thái nhỏ ===== */
    .admin-shell .stat-badge {
        font-size: 14px;
        font-weight: 500;
        padding: 6px 12px;
        border-radius: 8px;
        background: #f3f4f6;
        border: 1px solid var(--admin-border);
    }

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">
            <c:set var="isNew" value="${empty c.maGG}" />

            <div class="page-title">
                <a class="back-button" href="${pageContext.request.contextPath}/admin/coupons">
                    <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" /></svg>
                    <span>Quay lại</span>
                </a>
                <span>
                    <c:choose>
                        <c:when test="${isNew}">Thêm mã giảm giá</c:when>
                        <c:otherwise>Sửa mã giảm giá: "${c.maSo}"</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/coupons/edit">
                <input type="hidden" name="maGG" value="${c.maGG}" />

                <div class="form-grid">
                    <!-- Main Content -->
                    <div class="form-section">
                        <div class="card">
                            <div class="card-section">
                                <div class="section-header">
                                    <div class="section-title">Thông tin chung</div>
                                    <div class="section-desc">Cài đặt mã và tên chương trình.</div>
                                </div>
                                <div class="field-grid">
                                    <div class="field">
                                        <label>Mã code (unique)</label>
                                        <input class="input" type="text" name="maCode" value="${c.maSo}" maxlength="50" required />
                                    </div>
                                    <div class="field">
                                        <label>Tên chương trình</label>
                                        <input class="input" type="text" name="tenChuongTrinh" value="${c.tenChuongTrinh}" maxlength="255" required />
                                    </div>
                                </div>
                                <div class="field" style="margin-top: 16px;">
                                    <label>Mô tả</label>
                                    <textarea class="input" name="moTa" rows="4"><c:out value="${c.moTa}" /></textarea>
                                </div>
                            </div>
                            <div class="card-section">
                                <div class="section-header">
                                    <div class="section-title">Giá trị</div>
                                    <div class="section-desc">Cài đặt mức độ và điều kiện giảm giá.</div>
                                </div>
                                <div class="field-grid">
                                    <div class="field">
                                        <label>Loại giảm</label>
                                        <select name="loaiGiam" class="input">
                                            <option value="percent" <c:if test="${c.loaiGiam == 'PERCENT'}">selected</c:if>>Giảm theo phần trăm (%)</option>
                                            <option value="amount" <c:if test="${c.loaiGiam == 'FIXED_AMOUNT'}">selected</c:if>>Giảm số tiền cố định</option>
                                        </select>
                                    </div>
                                    <div class="field">
                                        <label>Giá trị giảm</label>
                                        <input class="input" type="number" step="0.01" name="giaTriGiam" value="${c.giaTriGiam}" required />
                                        <div class="muted">Nhập 10 cho 10% hoặc 10000 cho 10.000đ.</div>
                                    </div>
                                    <div class="field">
                                        <label>Giảm tối đa (cho loại %)</label>
                                        <input class="input" type="number" step="0.01" name="giaTriGiamToiDa" value="${c.giaTriGiamToiDa}" />
                                    </div>
                                    <div class="field">
                                        <label>Giá trị đơn hàng tối thiểu</label>
                                        <input class="input" type="number" step="0.01" name="giaTriDonHangToiThieu" value="${c.giaTriDonHangToiThieu}" />
                                    </div>
                                </div>
                            </div>
                             <div class="card-section">
                                <div class="section-header">
                                    <div class="section-title">Giới hạn</div>
                                    <div class="section-desc">Cài đặt giới hạn về thời gian và số lượng.</div>
                                </div>
                                <div class="field-grid">
                                    <div class="field">
                                        <label>Số lượt dùng tối đa</label>
                                        <input class="input" type="number" name="soLuongToiDa" value="${c.soLuongToiDa}" />
                                        <div class="muted">Để trống hoặc 0 = không giới hạn.</div>
                                    </div>
                                    <div class="field">
                                        <label>Ngày bắt đầu</label>
                                        <input class="input" type="date" name="ngayBatDau" value="${c.ngayBatDau != null ? c.ngayBatDau.toLocalDate() : ''}" />
                                    </div>
                                    <div class="field">
                                        <label>Ngày kết thúc</label>
                                        <input class="input" type="date" name="ngayKetThuc" value="${c.ngayKetThuc != null ? c.ngayKetThuc.toLocalDate() : ''}" />
                                    </div>
                                     <div class="field">
                                        <label>Hạn sử dụng</label>
                                        <input class="input" type="date" name="hanSuDung" value="${c.hanSuDung != null ? c.hanSuDung.toLocalDate() : ''}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Sidebar -->
                    <div class="form-sidebar">
                        <div class="card">
                             <div class="card-section">
                                <div class="section-header">
                                    <div class="section-title">Trạng thái</div>
                                </div>
                                <div class="field">
                                    <label class="checkbox-field">
                                        <input type="checkbox" name="trangThai" <c:if test="${c.trangThai}">checked</c:if> />
                                        <span class="checkbox-custom"></span>
                                        <span>Kích hoạt mã giảm giá</span>
                                    </label>
                                </div>
                                <c:if test="${not isNew}">
                                    <div class="field" style="margin-top: 16px;">
                                        <label>Lượt đã dùng</label>
                                        <div class="stat-badge">${c.soLuongDaSuDung}</div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="form-actions">
                                <div class="right-actions">
                                    <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/coupons">Hủy</a>
                                    <button class="btn btn-primary" type="submit">Lưu</button>
                                </div>
                            </div>
                             <c:if test="${not isNew}">
                                <div class="card-section">
                                     <div class="section-header">
                                        <div class="section-title">Hành động nguy hiểm</div>
                                    </div>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/coupons/delete" onsubmit="return confirm('Xoá mã #${c.maGG} (${c.maSo})?');">
                                        <input type="hidden" name="id" value="${c.maGG}">
                                        <button class="btn btn-danger" type="submit" style="width: 100%;">Xoá mã giảm giá</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>
