<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style>
    /* ===== CSS hiện đại hóa cho trang admin/products.jsp ===== */
    :root {
        --admin-bg: #f5f7fb;
        --admin-border: #e5e7eb;
        --card: #fff;
        --muted: #6b7280;
        --primary: #1a73e8;
        --accent: #ff7a00;
        --radius: 16px;
        --shadow: 0 8px 20px rgba(17, 24, 39, .08);
    }

    /* ===== Bố cục chính ===== */
    .admin-shell {
        display: flex;
        min-height: 100vh;
        background: var(--admin-bg);
        font-family: 'Inter', sans-serif;
    }

    .admin-shell .admin-content {
        flex: 1;
        min-width: 0;
    }

    .admin-shell .admin-container {
        padding: 24px;
    }

    /* ===== Tiêu đề trang có nút quay lại ===== */
    .admin-shell .page-title {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 28px;
        font-weight: 700;
        margin: 0 0 24px;
        color: #111827;
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
        display: inline-flex;
        align-items: center;
        justify-content: center;
        color: var(--muted);
        transition: all .2s ease;
        text-decoration: none;
    }

    .admin-shell .page-title .back-button:hover {
        background: #f3f4f6;
        color: var(--primary);
    }

    .admin-shell .page-title .back-button .btn-icon {
        width: 18px;
        height: 18px;
        margin-right: 8px;
        stroke-width: 2.5;
    }

    /* ===== Thanh công cụ bộ lọc ===== */
    .admin-shell .toolbar {
        display: flex;
        gap: 16px;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
        flex-wrap: wrap;
        padding: 16px;
        background: var(--card);
        border-radius: var(--radius);
        border: 1px solid var(--admin-border);
        box-shadow: var(--shadow);
    }

    .admin-shell .filters-form {
        display: flex;
        gap: 10px;
        align-items: center;
        flex-wrap: wrap;
    }

    .admin-shell .input,
    .admin-shell .select {
        height: 42px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 0 14px;
        background: #fff;
        font-size: 15px;
    }

    /* ===== Thẻ sản phẩm ===== */
    .admin-shell .product-card {
        background: #fff;
        border-radius: 12px;
        overflow: hidden;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        border: 1px solid #e0e0e0;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .admin-shell .product-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    }

    .admin-shell .product-image-container {
        height: 220px;
        position: relative;
        overflow: hidden;
        background: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .admin-shell .product-image {
        width: 100%;
        height: 100%;
        object-fit: contain;
        transition: transform 0.3s ease;
    }

    .admin-shell .product-card:hover .product-image {
        transform: scale(1.05);
    }

    .admin-shell .product-card .card-body {
        padding: 25px;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }

    .admin-shell .card-title {
        font-size: 1.1rem;
        font-weight: 600;
        line-height: 1.4;
        margin-bottom: 15px;
        color: #333;
        min-height: 50px;
        flex-grow: 1;
    }

    .admin-shell .card-title a {
        color: inherit;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .admin-shell .card-title a:hover {
        color: var(--primary);
    }

    .admin-shell .price-line {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 5px;
    }

    .admin-shell .price {
        font-size: 1.6rem;
        font-weight: 700;
        color: var(--primary);
        margin-bottom: 10px;
        white-space: nowrap;
    }

    .admin-shell .sold-count {
        color: #878787;
        font-size: 0.9rem;
        white-space: nowrap;
        flex-shrink: 0;
    }

    /* ===== Nút hành động trong card ===== */
    .admin-shell .product-buttons {
        display: flex;
        gap: 10px;
        margin-top: auto;
    }

    .admin-shell .btn-add-to-cart,
    .admin-shell .btn-buy-now {
        flex: 1;
        padding: 12px 10px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        transition: all 0.3s ease;
        border: none;
    }

    .admin-shell .btn-add-to-cart {
        background: linear-gradient(45deg, #2874f0, #1a5fce);
        color: white;
        box-shadow: 0 4px 15px rgba(40, 116, 240, 0.3);
    }

    .admin-shell .btn-add-to-cart:hover {
        background: linear-gradient(45deg, #1a5fce, #2874f0);
        box-shadow: 0 6px 20px rgba(40, 116, 240, 0.4);
        transform: translateY(-3px);
    }

    .admin-shell .btn-buy-now {
        background: linear-gradient(45deg, #ff9f00, #ff5f00);
        color: white;
        box-shadow: 0 4px 15px rgba(255, 159, 0, 0.3);
    }

    .admin-shell .btn-buy-now:hover {
        background: linear-gradient(45deg, #ff5f00, #ff9f00);
        box-shadow: 0 6px 20px rgba(255, 159, 0, 0.4);
        transform: translateY(-3px);
    }

    /* ===== Trạng thái rỗng ===== */
    .admin-shell .empty-state {
        padding: 60px;
        text-align: center;
        color: var(--muted);
        border: 1px dashed var(--admin-border);
        border-radius: 12px;
        background: #fff;
    }

    /* ===== Phân trang Bootstrap tuỳ chỉnh ===== */
    .admin-shell .pagination {
        display: flex;
        padding-left: 0;
        list-style: none;
        border-radius: .25rem;
        justify-content: center;
    }

    .admin-shell .page-link {
        position: relative;
        display: block;
        padding: .5rem .75rem;
        margin-left: -1px;
        line-height: 1.25;
        color: #0d6efd;
        background-color: #fff;
        border: 1px solid #dee2e6;
        text-decoration: none;
    }

    .admin-shell .page-item.disabled .page-link {
        color: #6c757d;
        pointer-events: none;
        background-color: #fff;
        border-color: #dee2e6;
    }

    .admin-shell .page-item.active .page-link {
        color: #fff;
        background-color: #0d6efd;
        border-color: #0d6efd;
    }

    .admin-shell .mt-5 {
        margin-top: 3rem !important;
    }

    .admin-shell .muted {
        color: var(--muted);
    }

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">
            <div class="page-title">
                 <a class="back-button" href="${pageContext.request.contextPath}/admin/suppliers">
                    <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" /></svg>
                    <span>Quay lại</span>
                </a>
                <span>Sản phẩm của Shop "${shop.tenCH}"</span>
            </div>

            <div class="toolbar">
                <div class="muted">Tổng: ${totalProducts} sản phẩm</div>
                <form method="get" class="filters-form">
                    <input type="hidden" name="shopId" value="${shop.maCH}" />
                    <input class="input" type="text" name="q" placeholder="Tìm theo tên/mô tả..." value="${param_q}">
                    <select class="select" name="category" onchange="this.form.submit()">
                        <option value="">Danh mục</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.maDM}" ${param_category==c.maDM?'selected':''}>${c.tenDM}</option>
                        </c:forEach>
                    </select>
                    <select class="select" name="status" onchange="this.form.submit()">
                        <option value="">Trạng thái</option>
                        <option value="active" ${param_status=='active'?'selected':''}>Đang bán</option>
                        <option value="inactive" ${param_status=='inactive'?'selected':''}>Ngừng bán</option>
                    </select>
                    <select class="select" name="sort" onchange="this.form.submit()">
                        <option value="date_desc" ${param_sort=='date_desc'?'selected':''}>Mới nhất</option>
                        <option value="price_asc" ${param_sort=='price_asc'?'selected':''}>Giá ↑</option>
                        <option value="price_desc" ${param_sort=='price_desc'?'selected':''}>Giá ↓</option>
                        <option value="name_asc" ${param_sort=='name_asc'?'selected':''}>Tên A→Z</option>
                        <option value="name_desc" ${param_sort=='name_desc'?'selected':''}>Tên Z→A</option>
                    </select>
                    <select class="select" name="pageSize" onchange="this.form.submit()">
                        <option value="8" ${pageSize==8?'selected':''}>8 / trang</option>
                        <option value="12" ${pageSize==12?'selected':''}>12 / trang</option>
                        <option value="24" ${pageSize==24?'selected':''}>24 / trang</option>
                    </select>
                </form>
            </div>

            <c:choose>
                <c:when test="${empty products}">
                    <div class="empty-state">
                        <p class="muted">Chưa có sản phẩm nào cho shop này.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${products}">
                            <div class="col">
                                <div class="product-card">
                                    <div class="product-image-container">
                                        <c:choose>
                                            <c:when test="${not empty p.hinhAnh}">
                                                <img src="${pageContext.request.contextPath}/assets/img/${p.hinhAnh}" alt="${p.tenSP}" class="product-image">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/img/placeholder-product.png" alt="${p.tenSP}" class="product-image">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <a href="${pageContext.request.contextPath}/admin/products/view?id=${p.maSP}">${p.tenSP}</a>
                                        </h5>
                                        <div class="price-line">
                                            <span class="price"><fmt:formatNumber value="${p.donGia}" type="number" />₫</span>
                                            <span class="sold-count">Kho: ${p.soLuongTon}</span>
                                        </div>
                                        <div class="product-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/suppliers/products/edit?id=${p.maSP}&shopId=${shop.maCH}" class="btn btn-add-to-cart">
                                                <i class="fas fa-edit me-2"></i>Quản lý
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/products/view?id=${p.maSP}" class="btn btn-buy-now">
                                                <i class="fas fa-eye me-2"></i>Xem chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <nav aria-label="Product Pagination" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <c:url var="prevUrl" value="/admin/suppliers/products">
                                    <c:param name="page" value="${currentPage - 1}"/>
                                    <c:param name="shopId" value="${shop.maCH}"/>
                                    <c:if test="${not empty param_q}"><c:param name="q" value="${param_q}"/></c:if>
                                    <c:if test="${not empty param_category}"><c:param name="category" value="${param_category}"/></c:if>
                                    <c:if test="${not empty param_status}"><c:param name="status" value="${param_status}"/></c:if>
                                    <c:if test="${not empty param_sort}"><c:param name="sort" value="${param_sort}"/></c:if>
                                    <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                                </c:url>
                                <a class="page-link" href="${prevUrl}">Trước</a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <c:url var="pageUrl" value="/admin/suppliers/products">
                                        <c:param name="page" value="${i}"/>
                                        <c:param name="shopId" value="${shop.maCH}"/>
                                        <c:if test="${not empty param_q}"><c:param name="q" value="${param_q}"/></c:if>
                                        <c:if test="${not empty param_category}"><c:param name="category" value="${param_category}"/></c:if>
                                        <c:if test="${not empty param_status}"><c:param name="status" value="${param_status}"/></c:if>
                                        <c:if test="${not empty param_sort}"><c:param name="sort" value="${param_sort}"/></c:if>
                                        <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                                    </c:url>
                                    <a class="page-link" href="${pageUrl}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <c:url var="nextUrl" value="/admin/suppliers/products">
                                    <c:param name="page" value="${currentPage + 1}"/>
                                    <c:param name="shopId" value="${shop.maCH}"/>
                                    <c:if test="${not empty param_q}"><c:param name="q" value="${param_q}"/></c:if>
                                    <c:if test="${not empty param_category}"><c:param name="category" value="${param_category}"/></c:if>
                                    <c:if test="${not empty param_status}"><c:param name="status" value="${param_status}"/></c:if>
                                    <c:if test="${not empty param_sort}"><c:param name="sort" value="${param_sort}"/></c:if>
                                    <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                                </c:url>
                                <a class="page-link" href="${nextUrl}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:otherwise>
            </c:choose>

        </div>
    </main>
</div>
