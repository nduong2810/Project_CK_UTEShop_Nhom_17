<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ===== CSS hiện đại hóa cho trang Category Edit ===== */
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
        color: var(--muted);
        transition: all .2s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
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
        grid-template-columns: 1fr 3fr;
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

    .admin-shell .section-header {
        margin-bottom: 16px;
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

    /* ===== Field nhập liệu ===== */
    .admin-shell .field {
        display: flex;
        flex-direction: column;
        gap: 8px;
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

    /* ===== Hành động cuối form ===== */
    .admin-shell .form-actions {
        display: flex;
        gap: 12px;
        justify-content: flex-end;
        padding: 24px 32px;
        background: #f9fafb;
        border-top: 1px solid var(--admin-border);
    }

    /* ===== Buttons ===== */
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

    .admin-shell .muted {
        font-size: 13px;
        color: var(--muted);
    }

    /* ===== Ảnh xem trước ===== */
    .admin-shell .img-preview {
        width: 100%;
        aspect-ratio: 4 / 3;
        border: 1px solid var(--admin-border);
        border-radius: 12px;
        object-fit: cover;
        background: #f9fafb;
        margin-bottom: 12px;
    }

    /* ===== Checkbox tuỳ chỉnh ===== */
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
                <a class="back-button" href="${pageContext.request.contextPath}/admin/categories">
                    <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" /></svg>
                    <span>Quay lại</span>
                </a>
                <span>
                    <c:choose>
                        <c:when test="${c.maDM == null}">Thêm danh mục</c:when>
                        <c:otherwise>Sửa danh mục "${c.tenDM}"</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <!-- Alerts -->
            <c:if test="${param.msg=='saved'}">
                <div class="alert alert-ok">Đã lưu thay đổi.</div>
            </c:if>
            <c:if test="${param.msg=='error'}">
                <div class="alert alert-err">Có lỗi xảy ra, vui lòng thử lại.</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin/categories/edit" enctype="multipart/form-data">
                <c:if test="${c.maDM != null}">
                    <input type="hidden" name="maDM" value="${c.maDM}" />
                </c:if>

                <div class="form-grid">
                    <!-- Left Sidebar -->
                    <div class="form-sidebar">
                        <div class="card">
                            <div class="card-section">
                                <div class="section-header">
                                    <div class="section-title">Ảnh đại diện</div>
                                    <div class="section-desc">Chọn ảnh cho danh mục của bạn.</div>
                                </div>
                                <c:choose>
                                    <c:when test="${not empty c.hinhAnh}">
                                        <img id="imgPreview" class="img-preview" src="${pageContext.request.contextPath}/${c.hinhAnh}" alt="preview">
                                    </c:when>
                                    <c:otherwise>
                                        <img id="imgPreview" class="img-preview" src="${pageContext.request.contextPath}/assets/img/no-image.png" alt="preview">
                                    </c:otherwise>
                                </c:choose>
                                <div class="field">
                                    <label>Chọn ảnh mới</label>
                                    <input class="input" type="file" name="imageFile" accept="image/*" onchange="previewFile(this)">
                                    <div class="muted">Tệp sẽ lưu vào <code>assets/img/</code>.</div>
                                </div>
                                <div class="field">
                                    <label>Hoặc nhập đường dẫn</label>
                                    <input class="input" name="hinhAnhInput" value="${c.hinhAnh}">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="form-section">
                        <div class="card">
                            <div class="card-section">
                                <div class="section-header">
                                    <div class="section-title">Thông tin chi tiết</div>
                                    <div class="section-desc">Điền các thông tin cơ bản của danh mục.</div>
                                </div>
                                <div class="field">
                                    <label>Tên danh mục</label>
                                    <input class="input" name="tenDM" value="${c.tenDM}" required />
                                </div>
                                <div class="field" style="margin-top: 16px;">
                                    <label>Mô tả</label>
                                    <textarea class="input" name="moTa" placeholder="Mô tả ngắn...">${c.moTa}</textarea>
                                </div>
                            </div>
                            <div class="card-section">
                                <div class="section-header">
                                    <div class="section-title">Trạng thái</div>
                                    <div class="section-desc">Quản lý hiển thị của danh mục.</div>
                                </div>
                                <div class="field">
                                    <label class="checkbox-field">
                                        <input type="checkbox" name="trangThai" ${c.trangThai==1?'checked':''} />
                                        <span class="checkbox-custom"></span>
                                        <span>Hiển thị danh mục này</span>
                                    </label>
                                </div>
                            </div>
                            <div class="form-actions">
                                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/categories">Hủy</a>
                                <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>

<!-- JS xem trước ảnh upload -->
<script>
function previewFile(input){
  const file = input.files && input.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = e => document.getElementById('imgPreview').src = e.target.result;
  reader.readAsDataURL(file);
}
</script>
