<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ===== CSS hiện đại hóa cho trang Customer Edit ===== */
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

    body {
        margin: 0;
        background: var(--admin-bg);
        font-family: 'Inter', sans-serif;
        color: var(--text-color);
    }

    .admin-shell {
        display: flex;
        min-height: 100vh; /* Ensure it takes full viewport height */
    }

    .admin-content {
        flex: 1;
        min-width: 0;
    }

    .admin-container {
        padding: 24px;
    }

    /* ===== Tiêu đề trang ===== */
    .page-title {
        font-size: 28px;
        font-weight: 700;
        margin: 0 0 24px; /* Increased bottom margin */
        color: var(--heading-color);
        display: flex;
        align-items: center;
        padding-bottom: 16px; /* Added padding for the border */
        border-bottom: 1px solid var(--admin-border); /* Subtle separator */
    }

    /* ===== Thẻ chính ===== */
    .card {
        background: var(--card);
        border: 1px solid var(--admin-border);
        border-radius: var(--radius);
        padding: 32px;
        max-width: 920px;
        box-shadow: var(--shadow);
        margin: 40px auto; /* Increased top/bottom margin for better centering */
    }

    /* ===== Lưới biểu mẫu ===== */
    .grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
    }

    @media (max-width: 768px) {
        .grid {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .card {
            padding: 24px;
            margin: 24px auto;
        }

        .page-title {
            font-size: 24px;
        }
    }

    /* ===== Field nhập liệu ===== */
    .field {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    label {
        font-weight: 500;
        color: var(--heading-color); /* Slightly darker for better contrast */
        font-size: 15px;
    }

    .input,
    select,
    textarea {
        height: 42px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 0 14px;
        background: #fff;
        color: var(--text-color);
        font-family: 'Inter', sans-serif;
        font-size: 15px;
        transition: border-color .2s ease, box-shadow .2s ease; /* Smooth transition */
    }

    .input:focus,
    select:focus,
    textarea:focus {
        outline: none; /* Remove default outline */
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(11, 87, 208, 0.2); /* Custom focus ring */
    }

    /* ===== Nút hành động ===== */
    .form-actions {
        display: flex;
        gap: 12px;
        justify-content: flex-end;
        margin-top: 32px;
        padding-top: 24px; /* Added padding for the border */
        border-top: 1px solid var(--admin-border); /* Subtle separator */
    }

    .btn {
        height: 42px;
        border-radius: 12px; /* Increased border-radius for consistency */
        border: 1px solid var(--admin-border);
        background: #fff;
        cursor: pointer;
        padding: 0 24px;
        font-weight: 500; /* Adjusted font-weight for consistency */
        transition: all .2s ease;
        box-shadow: var(--shadow);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none; /* For anchor tags acting as buttons */
        color: var(--text-color); /* Default color for ghost/secondary buttons */
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

    .btn-primary:hover {
        background: #0a4dbd; /* Slightly darker primary on hover */
        border-color: #0a4dbd;
    }

    .btn-ghost {
        background: transparent;
        border-color: transparent;
        box-shadow: none;
        color: var(--muted);
    }

    .btn-ghost:hover {
        background: #f3f4f6; /* Light background on hover */
        color: var(--text-color);
        box-shadow: none;
        transform: none;
    }

    /* ===== Badge nhỏ ===== */
    .badge {
        display: inline-flex;
        align-items: center;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 600;
        background: #e0f2fe;
        color: #0c54a1;
        margin-left: 12px;
    }

    /* ===== Thông báo ===== */
    .alert {
        margin-bottom: 20px;
        padding: 12px 16px;
        border-radius: 8px;
        font-size: 14px;
    }

    .alert-ok {
        background: #ecfdf5;
        color: #065f46;
        border: 1px solid #a7f3d0;
    }

    .alert-err {
        background: #fef2f2;
        color: #991b1b;
        border: 1px solid #fecaca;
    }

    /* ===== Ghi chú nhỏ ===== */
    .muted {
        color: var(--muted);
        font-size: 13px;
    }

    /* ===== Checkbox tùy chỉnh ===== */
    .checkbox-field {
        display: flex;
        align-items: center;
        gap: 12px;
        height: 42px;
        cursor: pointer;
        user-select: none; /* Prevent text selection */
    }

    .checkbox-field input[type="checkbox"] {
        display: none;
    }

    .checkbox-custom {
        width: 22px;
        height: 22px;
        border: 2px solid var(--admin-border);
        border-radius: 6px;
        display: inline-block;
        position: relative;
        transition: background-color 0.2s, border-color 0.2s;
        flex-shrink: 0;
    }

    .checkbox-field input[type="checkbox"]:checked + .checkbox-custom {
        background-color: var(--primary);
        border-color: var(--primary);
    }

    .checkbox-custom::after {
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

    .checkbox-field input[type="checkbox"]:checked + .checkbox-custom::after {
        display: block;
    }


</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">
            <div class="page-title">
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
                            <label>Trạng thái</label> 
                            <label class="checkbox-field">
                                <input type="checkbox" name="trangThai" ${u.trangThai?'checked':''} />
                                <span class="checkbox-custom"></span>
                                <span class="muted">Hoạt động</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-actions">
                        <a class="btn btn-ghost"
                            href="${pageContext.request.contextPath}/admin/customers">Hủy</a>
                        <button class="btn btn-primary" type="submit">Lưu</button>
                    </div>
                </div>
            </form>

        </div>
    </main>
</div>
