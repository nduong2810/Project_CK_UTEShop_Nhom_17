<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
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

    .admin-shell .title {
        font-size: 28px;
        font-weight: 700;
        margin: 0 0 20px;
        color: var(--heading-color);
    }

    .admin-shell .toolbar {
        display: flex;
        gap: 15px;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
        padding: 16px 24px;
        background: var(--card);
        border-radius: var(--radius);
        border: 1px solid var(--admin-border);
        box-shadow: var(--shadow);
    }

    .admin-shell .input,
    .admin-shell .select {
        height: 40px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 0 12px;
        background: #fff;
        color: var(--text-color);
    }

    .admin-shell .btn {
        height: 40px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 0 20px;
        background: #fff;
        font-weight: 600;
        cursor: pointer;
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
        border-color: #fecaca;
        color: #991b1b;
        background: #fff;
    }

    .admin-shell .panel {
        background: var(--card);
        border: 1px solid var(--admin-border);
        border-radius: var(--radius);
        overflow: hidden;
        box-shadow: var(--shadow);
        margin-bottom: 24px;
    }

    .admin-shell .table {
        width: 100%;
        border-collapse: collapse;
    }

    .admin-shell .table th,
    .admin-shell .table td {
        padding: 16px 24px;
        text-align: left;
        border-bottom: 1px solid var(--admin-border);
        vertical-align: middle;
    }

    .admin-shell .table thead th {
        font-weight: 600;
        color: var(--muted);
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: .5px;
    }

    .admin-shell .table tbody tr:hover {
        background-color: #f9fafb;
    }

    .admin-shell .badge {
        display: inline-flex;
        align-items: center;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: .5px;
    }

    .admin-shell .badge-green {
        background: #dcfce7;
        color: #166534;
    }

    .admin-shell .badge-gray {
        background: #f3f4f6;
        color: #374151;
    }

    .admin-shell .actions {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
        align-items: center;
    }

    .admin-shell .pagination {
        display: flex;
        gap: 8px;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
    }

    .admin-shell .pbtn {
        min-width: 42px;
        height: 40px;
        border: 1px solid var(--admin-border);
        background: #fff;
        border-radius: 8px;
        cursor: pointer;
        box-shadow: var(--shadow);
        transition: all 0.2s ease;
        color: var(--text-color);
    }

    .admin-shell .pbtn:hover {
        transform: translateY(-2px);
        box-shadow: var(--button-hover-shadow);
    }

    .admin-shell .pbtn.active {
        background: var(--primary);
        color: #fff;
        border-color: transparent;
    }

    .admin-shell .muted {
        color: var(--muted);
    }

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">
            <div class="title">Mã giảm giá</div>

            <div class="toolbar">
                <form method="get" class="toolbar" style="width:100%; justify-content: flex-start;">
                    <input class="input" type="text" name="q" value="${param_q}"
                        placeholder="Tìm theo mã/ chương trình" /> <select class="select"
                        name="type">
                        <option value="">-- Loại --</option>
                        <option value="percent" ${param_type=='percent' ? 'selected' : ''}>Giảm
                            %</option>
                        <option value="amount" ${param_type=='amount'  ? 'selected' : ''}>Giảm
                            tiền</option>
                    </select> <select class="select" name="status">
                        <option value="">-- Trạng thái --</option>
                        <option value="ongoing"
                            ${param_status=='ongoing'  ? 'selected' : ''}>Đang diễn
                            ra</option>
                        <option value="upcoming"
                            ${param_status=='upcoming' ? 'selected' : ''}>Sắp diễn
                            ra</option>
                        <option value="expired"
                            ${param_status=='expired'  ? 'selected' : ''}>Đã hết hạn</option>
                    </select> <select class="select" name="sort">
                        <option value="">Mới nhất</option>
                        <option value="name_asc"
                            ${param_sort=='name_asc'  ? 'selected' : ''}>Tên A→Z</option>
                        <option value="name_desc"
                            ${param_sort=='name_desc' ? 'selected' : ''}>Tên Z→A</option>
                        <option value="start_asc"
                            ${param_sort=='start_asc' ? 'selected' : ''}>Bắt đầu ↑</option>
                        <option value="start_desc"
                            ${param_sort=='start_desc'? 'selected' : ''}>Bắt đầu ↓</option>
                        <option value="end_asc"
                            ${param_sort=='end_asc'   ? 'selected' : ''}>Kết thúc ↑</option>
                        <option value="end_desc"
                            ${param_sort=='end_desc'  ? 'selected' : ''}>Kết thúc ↓</option>
                    </select> <select class="select" name="pageSize">
                        <option ${pageSize==10 ? 'selected' : ''} value="10">10</option>
                        <option ${pageSize==20 ? 'selected' : ''} value="20">20</option>
                        <option ${pageSize==50 ? 'selected' : ''} value="50">50</option>
                    </select>
                    <button class="btn btn-primary">Lọc</button>
                </form>
                <button class="btn btn-primary"
                        onclick="location.href='${ctx}/admin/coupons/edit'">
                        + Thêm mã</button>
            </div>

            <div class="panel">
                <div style="overflow: auto">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 80px">Mã</th>
                                <th>Mã số</th>
                                <th>Chương trình</th>
                                <th style="width: 120px">Loại</th>
                                <th style="width: 120px">Giá trị</th>
                                <th style="width: 150px">Bắt đầu</th>
                                <th style="width: 150px">Kết thúc</th>
                                <th style="width: 120px">Trạng thái</th>
                                <th style="width: 200px">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${coupons}">
                                <tr>
                                    <td>#${c.maGG}</td>
                                    <td>${c.maSo}</td>
                                    <td>${c.tenChuongTrinh}</td>
                                    <td><c:choose>
                                            <c:when
                                                test="${c.loaiGiam == 'PERCENT' || c.loaiGiam == 'percent'}">Giảm %</c:when>
                                            <c:otherwise>Giảm tiền</c:otherwise>
                                        </c:choose></td>
                                    <td><fmt:formatNumber value="${c.giaTriGiam}" type="number" /></td>
                                    <td><c:out value="${c.ngayBatDau}" /></td>
                                    <td><c:out value="${c.ngayKetThuc}" /></td>
                                    <td><c:choose>
                                            <c:when test="${c.trangThai}">
                                                <span class="badge badge-green">Bật</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-gray">Tắt</span>
                                            </c:otherwise>
                                        </c:choose></td>
                                    <td class="actions">
                                        <button class="btn" type="button"
                                            onclick="location.href='${ctx}/admin/coupons/edit?id=${c.maGG}'">Sửa</button>

                                        <form method="post" action="${ctx}/admin/coupons/delete"
                                            onsubmit="return confirm('Xoá mã #${c.maGG}?');">
                                            <input type="hidden" name="id" value="${c.maGG}" />
                                            <button class="btn btn-danger" type="submit">Xoá</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty coupons}">
                                <tr>
                                    <td class="muted" colspan="9" style="text-align: center; padding: 40px;">Không có dữ liệu.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="pagination">
                    <form method="get" style="display: inline">
                        <input type="hidden" name="q" value="${param_q}" />
                        <input type="hidden" name="type" value="${param_type}" />
                        <input type="hidden" name="status" value="${param_status}" />
                        <input type="hidden" name="sort" value="${param_sort}" />
                        <input type="hidden" name="pageSize" value="${pageSize}" />
                        <button class="pbtn" name="page" value="${currentPage-1}"
                            <c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
                    </form>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <form method="get" style="display: inline">
                            <input type="hidden" name="q" value="${param_q}" />
                            <input type="hidden" name="type" value="${param_type}" />
                            <input type="hidden" name="status" value="${param_status}" />
                            <input type="hidden" name="sort" value="${param_sort}" />
                            <input type="hidden" name="pageSize" value="${pageSize}" />
                            <button class="pbtn ${i==currentPage?'active':''}" name="page"
                                value="${i}">${i}</button>
                        </form>
                    </c:forEach>

                    <form method="get" style="display: inline">
                        <input type="hidden" name="q" value="${param_q}" />
                        <input type="hidden" name="type" value="${param_type}" />
                        <input type="hidden" name="status" value="${param_status}" />
                        <input type="hidden" name="sort" value="${param_sort}" />
                        <input type="hidden" name="pageSize" value="${pageSize}" />
                        <button class="pbtn" name="page" value="${currentPage+1}"
                            <c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
                    </form>
                </div>

            </div>
        </div>
    </main>
</div>
