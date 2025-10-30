<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ===== CSS hiện đại hóa cho trang Product Edit ===== */
    :root {
        --admin-bg: #f5f7fb;
        --admin-border: #e5e7eb;
        --card: #fff;
        --muted: #6b7280;
        --primary: #0b57d0;
        --accent: #ff7a00;
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

    .admin-shell .admin-content {
        flex: 1;
        min-width: 0;
    }

    .admin-shell .admin-container {
        padding: 24px;
        font-family: 'Inter', sans-serif;
    }

    .admin-shell .page-title {
        font-size: 28px;
        font-weight: 700;
        margin: 0 0 20px;
        color: var(--heading-color);
        display: flex;
        align-items: center;
    }

    .admin-shell .form-card {
        background: var(--card);
        border: 1px solid var(--admin-border);
        border-radius: var(--radius);
        display: grid;
        grid-template-columns: 420px 1fr;
        gap: 32px;
        padding: 32px;
        box-shadow: var(--shadow);
    }

    @media (max-width: 1080px) {
        .admin-shell .form-card {
            grid-template-columns: 1fr;
            gap: 24px;
            padding: 24px;
        }
    }

    .admin-shell .section {
        border: 1px solid var(--admin-border);
        border-radius: 14px;
        padding: 24px;
    }

    .admin-shell .sec-title {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 20px;
        color: var(--heading-color);
    }

    .admin-shell .field {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-bottom: 20px;
    }

    .admin-shell label {
        font-weight: 600;
        color: var(--text-color);
    }

    .admin-shell .input,
    .admin-shell textarea,
    .admin-shell select {
        height: 42px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 0 14px;
        background: #fff;
        color: var(--text-color);
        font-family: 'Inter', sans-serif;
        font-size: 14px;
    }

    .admin-shell .input:focus,
    .admin-shell textarea:focus,
    .admin-shell select:focus {
        outline: 2px solid var(--primary);
        border-color: transparent;
    }

    .admin-shell textarea {
        height: auto;
        min-height: 140px;
        resize: vertical;
        padding: 14px;
    }

    .admin-shell .row {
        display: flex;
        gap: 16px;
    }

    .admin-shell .row .field {
        flex: 1;
    }

    /* ===== Preview ảnh ===== */
    .admin-shell .preview {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 280px;
        background: #f9fafb;
        border: 2px dashed var(--admin-border);
        border-radius: 12px;
        margin-bottom: 20px;
    }

    .admin-shell .preview img {
        max-width: 90%;
        max-height: 90%;
        object-fit: contain;
    }

    /* ===== Nút hành động ===== */
    .admin-shell .actions {
        display: flex;
        gap: 12px;
        justify-content: flex-end;
        margin-top: 24px;
    }

    .admin-shell .btn {
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

    .admin-shell .btn:hover {
        transform: translateY(-2px);
        box-shadow: var(--button-hover-shadow);
    }

    .admin-shell .btn-primary {
        background: var(--primary);
        color: #fff;
        border-color: var(--primary);
    }

    .admin-shell .btn-ghost {
        background: transparent;
        border-color: transparent;
        box-shadow: none;
        color: var(--muted);
    }

    .admin-shell .btn-ghost:hover {
        background: #f9fafb;
        color: var(--text-color);
    }

    /* ===== Badge thông tin nhỏ ===== */
    .admin-shell .badge {
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
    .admin-shell .alert {
        margin-bottom: 20px;
        padding: 12px 16px;
        border-radius: 8px;
        font-size: 14px;
    }

    .admin-shell .alert-ok {
        background: #ecfdf5;
        color: #065f46;
        border: 1px solid #a7f3d0;
    }

    .admin-shell .alert-err {
        background: #fef2f2;
        color: #991b1b;
        border: 1px solid #fecaca;
    }

    .admin-shell .muted {
        color: var(--muted);
        font-size: 13px;
    }

    /* ===== Custom File Input ===== */
    .admin-shell .file-input-wrapper {
        position: relative;
        height: 42px;
        display: flex;
    }

    .admin-shell .file-input-hidden {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        opacity: 0;
        cursor: pointer;
    }

    .admin-shell .file-input-ui {
        height: 100%;
        width: 100%;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        display: flex;
        align-items: center;
        padding: 0 6px 0 14px;
        overflow: hidden;
    }

    .admin-shell .file-input-btn {
        height: 32px;
        padding: 0 16px;
        border-radius: 8px;
        background: #f3f4f6;
        border: 1px solid var(--admin-border);
        font-weight: 600;
        white-space: nowrap;
    }

    .admin-shell .file-input-name {
        margin-left: 12px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    /* ===== Checkbox tuỳ chỉnh ===== */
    .admin-shell .checkbox-field {
        display: flex;
        align-items: center;
        gap: 12px;
        height: 42px;
        cursor: pointer;
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
                Sửa sản phẩm <span class="badge">#${p.maSP}</span>
            </div>

            <c:if test="${param.msg=='saved'}">
                <div class="alert alert-ok">Đã lưu thay đổi.</div>
            </c:if>
            <c:if test="${param.msg=='error'}">
                <div class="alert alert-err">Có lỗi khi lưu. Thử lại.</div>
            </c:if>
            <c:if test="${param.msg=='notfound'}">
                <div class="alert alert-err">Không tìm thấy sản phẩm.</div>
            </c:if>

            <form method="post"
                action="${pageContext.request.contextPath}/admin/products/edit"
                enctype="multipart/form-data">
                <input type="hidden" name="maSP" value="${p.maSP}" />

                <div class="form-card">

                    <!-- Cột trái: Ảnh & mô tả -->
                    <div class="section">
                        <div class="sec-title">Hình ảnh & Mô tả</div>

                        <div class="preview">
                            <c:choose>
                                <c:when test="${not empty p.hinhAnh}">
                                    <img id="imgPreview"
                                        src="${pageContext.request.contextPath}/assets/img/${p.hinhAnh}"
                                        alt="${p.tenSP}">
                                </c:when>
                                <c:otherwise>
                                    <img id="imgPreview"
                                        src="${pageContext.request.contextPath}/assets/img/placeholder-product.png"
                                        alt="preview">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="field">
                            <label>Chọn ảnh từ máy</label>
                            <div class="file-input-wrapper">
                                <div class="file-input-ui">
                                    <span class="file-input-btn">Chọn file</span>
                                    <span class="file-input-name muted">Chưa có file nào được chọn</span>
                                </div>
                                <input class="file-input-hidden" type="file" name="fileImage" accept="image/*" 
                                       onchange="previewFile(this); updateFileName(this);" />
                            </div>
                            <small class="muted">Nếu không chọn, hệ thống sẽ giữ ảnh hiện tại.</small>
                        </div>

                        <div class="field">
                            <label>Hoặc nhập URL ảnh</label> 
                            <input class="input" type="text" name="hinhAnh" value="${p.hinhAnh}" oninput="previewByText(this.value)" /> 
                            <small class="muted">Chỉ cần lưu <code>tên file</code> (vd: <code>abc.jpg</code>). Ảnh sẽ hiển thị từ <code>/assets/img/</code>.</small>
                        </div>

                        <div class="field">
                            <label>Mô tả</label>
                            <textarea name="moTa" class="input" placeholder="Mô tả ngắn...">${p.moTa}</textarea>
                        </div>
                    </div>

                    <!-- Cột phải: Thông tin sản phẩm -->
                    <div class="section">
                        <div class="sec-title">Thông tin sản phẩm</div>

                        <div class="field">
                            <label>Tên sản phẩm</label> 
                            <input class="input" type="text" name="tenSP" value="${p.tenSP}" required />
                        </div>

                        <div class="row">
                            <div class="field">
                                <label>Giá bán (VNĐ)</label> 
                                <input class="input" type="number" name="donGia" min="0" step="100" value="${p.donGia}" />
                            </div>
                            <div class="field">
                                <label>Kho còn</label> 
                                <input class="input" type="number" name="soLuongTon" min="0" step="1" value="${p.soLuongTon}" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="field">
                                <label>Danh mục</label> 
                                <select name="maDM" class="input" required>
                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.maDM}" ${c.maDM==p.maDM ? 'selected' : ''}>${c.tenDM}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="field">
                                <label>Trạng thái</label> 
                                <label class="checkbox-field">
                                    <input type="checkbox" name="trangThai" ${p.trangThai ? 'checked' : ''} />
                                    <span class="checkbox-custom"></span>
                                    <span class="muted">Đang bán</span>
                                </label>
                            </div>
                        </div>

                        <div class="actions">
                            <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/products">Hủy</a>
                            <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
                        </div>
                    </div>

                </div>
            </form>
        </div>
    </main>
</div>

<script>
    function previewFile(input) {
        const img = document.getElementById('imgPreview');
        if (input.files && input.files[0]) {
            img.src = URL.createObjectURL(input.files[0]);
        }
    }

    function updateFileName(input) {
        const fileNameSpan = input.previousElementSibling.querySelector('.file-input-name');
        if (input.files && input.files.length > 0) {
            fileNameSpan.textContent = input.files[0].name;
            fileNameSpan.classList.remove('muted');
        } else {
            fileNameSpan.textContent = 'Chưa có file nào được chọn';
            fileNameSpan.classList.add('muted');
        }
    }

    function previewByText(val) {
        const img = document.getElementById('imgPreview');
        if (!val) {
            img.src = '${pageContext.request.contextPath}/assets/img/placeholder-product.png';
            return;
        }
        const base = '${pageContext.request.contextPath}/assets/img/';
        const name = val.split(/[\\/]/).pop(); // chỉ lấy tên file
        img.src = base + name;
    }
</script>
