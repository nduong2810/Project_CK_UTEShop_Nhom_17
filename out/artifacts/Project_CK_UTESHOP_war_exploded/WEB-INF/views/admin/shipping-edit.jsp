<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ===== CSS hiện đại hóa cho trang Shipping Edit ===== */
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

    /* ===== Layout tổng ===== */
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
        max-width: 960px;
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

    /* ===== Thẻ card chứa form ===== */
    .admin-shell .card {
        background: var(--card);
        border: 1px solid var(--admin-border);
        border-radius: var(--radius);
        padding: 32px;
        box-shadow: var(--shadow);
        margin-top: 24px;
    }

    /* ===== Trường nhập liệu ===== */
    .admin-shell .field {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-bottom: 20px;
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

    /* ===== Footer của form ===== */
    .admin-shell .form-actions {
        display: flex;
        gap: 12px;
        justify-content: space-between;
        align-items: center;
        margin-top: 32px;
        padding-top: 24px;
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

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">

            <div class="page-title">
                <a class="back-button" href="${pageContext.request.contextPath}/admin/shipping">
                    <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" /></svg>
                    <span>Quay lại</span>
                </a>
                <span>
                    <c:choose>
                        <c:when test="${s.maVC == null}">Thêm đơn vị vận chuyển</c:when>
                        <c:otherwise>Sửa đơn vị: "${s.tenDonVi}"</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <!-- Alerts -->
            <c:if test="${param.msg=='saved'}">
                <div class="alert alert-ok">Đã lưu thay đổi.</div>
            </c:if>
            <c:if test="${param.msg=='error'}">
                <div class="alert alert-err">Có lỗi xảy ra, thử lại.</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin/shipping/edit">
                <c:if test="${s.maVC != null}">
                    <input type="hidden" name="maVC" value="${s.maVC}" />
                </c:if>

                <div class="card">
                    <div class="field">
                        <label>Tên đơn vị</label>
                        <input class="input" name="tenDonVi" value="${s.tenDonVi}" required />
                    </div>
                    <div class="field">
                        <label>Phí vận chuyển (VNĐ)</label>
                        <input class="input" type="number" name="phiVanChuyen" value="${s.phiVanChuyen}" required />
                    </div>

                    <div class="form-actions">
                        <div>
                            <c:if test="${s.maVC != null}">
                                <form method="post" action='${pageContext.request.contextPath}/admin/shipping/delete' onsubmit="return confirm('Xoá đơn vị vận chuyển #${s.maVC}? Hành động này không thể hoàn tác.');" style="display: inline;">
                                    <input type="hidden" name="id" value="${s.maVC}">
                                    <button class="btn btn-danger" type="submit">Xoá</button>
                                </form>
                            </c:if>
                        </div>
                        <div class="right-actions">
                            <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/shipping">Hủy</a>
                            <button class="btn btn-primary" type="submit">Lưu</button>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </main>
</div>
