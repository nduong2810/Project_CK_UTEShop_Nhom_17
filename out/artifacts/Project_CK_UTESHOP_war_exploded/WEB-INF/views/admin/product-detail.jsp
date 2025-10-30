<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ===== CSS hiện đại hóa cho trang Product Detail ===== */
    :root {
        --admin-bg: #f5f7fb;
        --admin-border: #e5e7eb;
        --card: #fff;
        --muted: #6b7280;
        --primary: #0b57d0;
        --danger: #ef4444;
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

    /* ===== Bố cục chi tiết sản phẩm ===== */
    .admin-shell .grid {
        display: grid;
        gap: 24px;
        grid-template-columns: 420px 1fr;
    }

    @media (max-width: 1080px) {
        .admin-shell .grid {
            grid-template-columns: 1fr;
        }
    }

    .admin-shell .card {
        background: var(--card);
        border: 1px solid var(--admin-border);
        border-radius: var(--radius);
        padding: 24px;
        box-shadow: var(--shadow);
    }

    /* ===== Ảnh sản phẩm ===== */
    .admin-shell .preview {
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f9fafb;
        border: 2px dashed var(--admin-border);
        border-radius: 12px;
        height: 380px;
        margin-bottom: 20px;
    }

    .admin-shell .preview img {
        max-width: 92%;
        max-height: 92%;
        object-fit: contain;
    }

    /* ===== Thông tin sản phẩm ===== */
    .admin-shell .fields {
        display: grid;
        gap: 16px;
    }

    .admin-shell .field {
        display: flex;
        justify-content: space-between;
        gap: 16px;
        padding: 8px 0;
        border-bottom: 1px solid var(--admin-border);
    }

    .admin-shell .field:last-child {
        border-bottom: none;
    }

    .admin-shell .label {
        color: var(--muted);
        font-weight: 500;
    }

    .admin-shell .value {
        color: var(--text-color);
        font-weight: 600;
        text-align: right;
    }

    /* ===== Chỉ số KPI ===== */
    .admin-shell .kpi {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
        gap: 16px;
        margin-top: 24px;
    }

    .admin-shell .kpi .item {
        background: #f9fafb;
        border: 1px solid var(--admin-border);
        border-radius: 12px;
        padding: 16px;
        text-align: center;
    }

    .admin-shell .kpi .cap {
        color: var(--muted);
        font-size: 13px;
        font-weight: 500;
        margin-bottom: 4px;
    }

    .admin-shell .kpi .val {
        font-weight: 700;
        font-size: 24px;
        color: var(--heading-color);
    }

    /* ===== Các nút hành động ===== */
    .admin-shell .actions {
        display: flex;
        gap: 12px;
        margin-top: 24px;
        flex-wrap: wrap;
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

    .admin-shell .btn-danger {
        background: var(--danger);
        color: #fff;
        border-color: transparent;
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

    /* ===== Tiêu đề & phân cách ===== */
    .admin-shell .section-title {
        font-size: 18px;
        font-weight: 600;
        margin: 24px 0 12px;
        color: var(--heading-color);
    }

    .admin-shell .muted {
        color: var(--muted);
    }

    .admin-shell .hr {
        height: 1px;
        background: var(--admin-border);
        margin: 24px 0;
        border: 0;
    }

    /* ===== Trạng thái sản phẩm ===== */
    .admin-shell .status-badge {
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: .5px;
    }

    .admin-shell .status-on {
        background: #dcfce7;
        color: #166534;
    }

    .admin-shell .status-off {
        background: #fee2e2;
        color: #991b1b;
    }

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">

            <div class="page-title">
                Chi tiết sản phẩm <span class="badge">#${p.maSP}</span>
            </div>

            <div class="grid">
                <!-- Cột trái: hình ảnh -->
                <div class="card">
                    <div class="preview">
                        <c:choose>
                            <c:when test="${not empty p.hinhAnh}">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/${p.hinhAnh}"
                                    alt="${p.tenSP}">
                            </c:when>
                            <c:otherwise>
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/placeholder-product.png"
                                    alt="preview">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="actions">
                        <button class="btn btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/admin/products/edit?id=${p.maSP}'">
                            Sửa sản phẩm</button>
                        <button class="btn btn-ghost"
                            onclick="location.href='${pageContext.request.contextPath}/admin/products'">
                            Quay lại</button>
                        <!-- (tuỳ chọn) nút xoá nếu bạn có controller xử lý -->
                        <%-- 
                        <form method="post" action="${pageContext.request.contextPath}/admin/products/delete" onsubmit="return confirm('Bạn chắc chắn muốn xoá?')">
                          <input type="hidden" name="id" value="${p.maSP}"/>
                          <button type="submit" class="btn btn-danger">Xoá</button>
                        </form>
                        --%>
                    </div>
                </div>

                <!-- Cột phải: thông tin -->
                <div class="card">
                    <div class="fields">
                        <div class="field">
                            <div class="label">Tên sản phẩm</div>
                            <div class="value">
                                <strong>${p.tenSP}</strong>
                            </div>
                        </div>
                        <div class="field">
                            <div class="label">Giá bán</div>
                            <div class="value">
                                <fmt:formatNumber value="${p.donGia}" type="number" />
                                đ
                            </div>
                        </div>
                        <div class="field">
                            <div class="label">Danh mục</div>
                            <div class="value">
                                <c:out value="${tenDanhMuc != null ? tenDanhMuc : '—'}" />
                                <span class="muted" style="margin-left: 6px;">(Mã: ${p.maDM})</span>
                            </div>
                        </div>
                        <div class="field">
                            <div class="label">Trạng thái</div>
                            <div class="value">
                                <c:choose>
                                    <c:when test="${p.trangThai}">
                                        <span class="status-badge status-on">Đang bán</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-off">Ngừng bán</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="field">
                            <div class="label">Ngày tạo</div>
                            <div class="value">
                                <fmt:formatDate value="${p.ngayTao}" pattern="dd/MM/yyyy HH:mm" />
                            </div>
                        </div>
                        <c:if test="${not empty p.ngayCapNhat}">
                            <div class="field">
                                <div class="label">Cập nhật</div>
                                <div class="value">
                                    <fmt:formatDate value="${p.ngayCapNhat}"
                                        pattern="dd/MM/yyyy HH:mm" />
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <div class="kpi">
                        <div class="item">
                            <div class="cap">Kho còn</div>
                            <div class="val">${p.soLuongTon}</div>
                        </div>
                        <div class="item">
                            <div class="cap">Đã bán</div>
                            <div class="val">${p.soLuongBan}</div>
                        </div>
                        <div class="item">
                            <div class="cap">Yêu thích</div>
                            <div class="val">${p.luotYeuThich}</div>
                        </div>
                    </div>

                    <div class="hr"></div>

                    <div class="section-title">Mô tả</div>
                    <div class="muted" style="white-space: pre-wrap; line-height: 1.6;">${p.moTa}</div>
                </div>
            </div>

        </div>
    </main>
</div>
