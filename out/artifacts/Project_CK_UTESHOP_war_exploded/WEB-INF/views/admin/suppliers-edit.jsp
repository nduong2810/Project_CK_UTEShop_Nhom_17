<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ===== CSS hiện đại hóa cho trang Supplier Edit ===== */
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

    /* ===== Bố cục chung ===== */
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
    }

    /* ===== Tiêu đề trang ===== */
    .admin-shell .page-title {
        font-size: 28px;
        font-weight: 700;
        margin: 0 0 24px;
        color: var(--heading-color);
        display: flex;
        align-items: center;
        justify-content: center;
        padding-bottom: 16px;
        border-bottom: 1px solid var(--admin-border);
    }

    /* ===== Thẻ chứa form ===== */
    .admin-shell .card {
        background: var(--card);
        border: 1px solid var(--admin-border);
        border-radius: var(--radius);
        padding: 32px;
        max-width: 960px;
        box-shadow: var(--shadow);
        margin: 40px auto;
    }

    /* ===== Lưới form ===== */
    .admin-shell .grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
    }

    @media (max-width: 768px) {
        .admin-shell .grid {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .admin-shell .card {
            padding: 24px;
            margin: 24px auto;
        }

        .admin-shell .page-title {
            font-size: 24px;
        }
    }

    /* ===== Field nhập liệu ===== */
    .admin-shell .field {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .admin-shell .field.full-width {
        grid-column: 1 / -1;
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
        font-size: 15px;
        font-family: 'Inter', sans-serif;
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
        min-height: 100px;
        padding: 14px;
        resize: vertical;
    }

    /* ===== Nút hành động phía trên ===== */
    .admin-shell .top-actions {
        display: flex;
        gap: 12px;
        margin-bottom: 24px;
        align-items: center;
        justify-content: center;
    }

    /* ===== Nút hành động form ===== */
    .admin-shell .form-actions {
        display: flex;
        gap: 12px;
        justify-content: flex-end;
        margin-top: 32px;
        padding-top: 24px;
        border-top: 1px solid var(--admin-border);
    }

    /* ===== Nút cơ bản ===== */
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

    .admin-shell .btn .btn-icon {
        width: 18px;
        height: 18px;
        margin-right: 8px;
        stroke-width: 2;
    }

    /* ===== Biến thể nút ===== */
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

    /* ===== Cảnh báo lỗi ===== */
    .admin-shell .alert-err {
        margin-bottom: 20px;
        padding: 12px 16px;
        border-radius: 8px;
        font-size: 14px;
        background: #fef2f2;
        border: 1px solid #fecaca;
        color: #991b1b;
    }

    /* ===== Text phụ ===== */
    .admin-shell .muted {
        font-size: 13px;
        color: var(--muted);
    }

    /* ===== Checkbox tùy chỉnh ===== */
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

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">
            <div class="page-title">
                <c:choose>
                    <c:when test="${shop.maCH == null}">Thêm cửa hàng</c:when>
                    <c:otherwise>Sửa cửa hàng #${shop.maCH}</c:otherwise>
                </c:choose>
            </div>

            <c:if test="${not empty error}">
                <div class="alert-err">${error}</div>
            </c:if>

            <div class="top-actions">
                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/suppliers">
                    <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" /></svg>
                    Quay lại danh sách
                </a>
                <c:if test="${shop.maCH != null}">
                    <form method="post"
                        action="${pageContext.request.contextPath}/admin/suppliers/delete"
                        onsubmit="return confirm('Xoá cửa hàng #${shop.maCH}?');">
                        <input type="hidden" name="id" value="${shop.maCH}" />
                        <button class="btn btn-danger" type="submit">
                            <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" /></svg>
                            Xoá
                        </button>
                    </form>
                </c:if>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/suppliers/edit">
                <c:if test="${shop.maCH != null}">
                    <input type="hidden" name="maCH" value="${shop.maCH}" />
                </c:if>

                <div class="card">
                    <div class="grid">
                        <div class="field full-width">
                            <label>Tên cửa hàng</label> 
                            <input class="input" name="tenCH" value="${shop.tenCH}" required />
                        </div>

                        <div class="field full-width">
                            <label>Địa chỉ</label>
                            <textarea name="diaChi" class="input">${shop.diaChi}</textarea>
                        </div>

                        <div class="field">
                            <label>Số điện thoại</label> 
                            <input class="input" name="soDienThoai" value="${shop.soDienThoai}" />
                        </div>

                        <div class="field">
                            <label>Email</label> 
                            <input class="input" type="email" name="email" value="${shop.email}" />
                        </div>

                        <div class="field">
                            <label>Tỷ lệ chiết khấu (%)</label> 
                            <input class="input" type="number" step="0.01" min="0" max="100" name="tyLeChietKhau" value="${shop.tyLeChietKhau}" placeholder="VD: 5.00" />
                            <div class="muted">Áp dụng trên doanh thu hàng hóa, không gồm phí vận chuyển.</div>
                        </div>

                        <div class="field">
                            <label>Trạng thái</label> 
                            <label class="checkbox-field">
                                <input type="checkbox" name="trangThai" ${shop.trangThai ? 'checked' : ''} />
                                <span class="checkbox-custom"></span>
                                <span class="muted">Hoạt động</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-actions">
                        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/suppliers">Hủy</a>
                        <button class="btn btn-primary" type="submit">Lưu</button>
                    </div>
                </div>
            </form>

        </div>
    </main>
</div>