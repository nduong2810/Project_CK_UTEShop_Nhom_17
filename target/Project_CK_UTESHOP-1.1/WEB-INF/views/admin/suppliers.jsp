<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
/* ===== CSS hiện đại hóa cho trang Suppliers ===== */
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

.admin-shell .muted {
    color: var(--muted);
}

.admin-shell .actions {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

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

.admin-shell .badge-active { background: #dcfce7; color: #166534; }
.admin-shell .badge-inactive { background: #fee2e2; color: #991b1b; }

</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">

            <div class="title">Nhà cung cấp (Shop)</div>

            <c:if test="${param.msg=='saved'}">
                <div class="alert alert-ok">Đã lưu thay đổi.</div>
            </c:if>
            <c:if test="${param.msg=='deleted'}">
                <div class="alert alert-ok">Đã xoá cửa hàng.</div>
            </c:if>
            <c:if test="${param.msg=='error'}">
                <div class="alert alert-err">Có lỗi xảy ra.</div>
            </c:if>
            <c:if test="${param.msg=='notfound'}">
                <div class="alert alert-err">Không tìm thấy cửa hàng.</div>
            </c:if>

            <div class="toolbar">
                <div class="muted">Tổng: ${total} shop</div>
                <div style="display: flex; gap: 10px; align-items: center; flex-wrap: wrap">
                    <form method="get"
                        style="display: flex; gap: 10px; align-items: center">
                        <input class="input" type="text" name="q" value="${param_q}"
                            placeholder="Tìm theo tên / email..."> <select
                            class="select" name="pageSize" onchange="this.form.submit()">
                            <option value="10" ${pageSize==10?'selected':''}>10 /
                                trang</option>
                            <option value="20" ${pageSize==20?'selected':''}>20 /
                                trang</option>
                            <option value="50" ${pageSize==50?'selected':''}>50 /
                                trang</option>
                        </select>
                        <button class="btn btn-primary">Lọc</button>
                    </form>

                    <button class="btn btn-primary"
                        onclick="location.href='${pageContext.request.contextPath}/admin/suppliers/edit'">+
                        Thêm shop</button>
                </div>
            </div>

            <div class="panel">
                <table class="table">
                    <thead>
                        <tr>
                            <th style="width: 80px">Mã</th>
                            <th>Tên shop</th>
                            <th style="width: 140px">Điện thoại</th>
                            <th style="width: 220px">Email</th>
                            <th style="width: 160px">Chiết khấu (%)</th>
                            <th style="width: 120px">Trạng thái</th>
                            <th style="width: 320px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${shops}">
                            <tr>
                                <td>#${s.maCH}</td>
                                <td>${s.tenCH}</td>
                                <td>${s.soDienThoai}</td>
                                <td>${s.email}</td>
                                <td><c:choose>
                                        <c:when test="${s.tyLeChietKhau != null}">${s.tyLeChietKhau}</c:when>
                                        <c:otherwise>
                                            <span class="muted">Chưa đặt</span>
                                        </c:otherwise>
                                    </c:choose></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.trangThai}">
                                            <span class="badge badge-active">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-inactive">Tạm tắt</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="actions">
                                    <button class="btn"
                                        onclick="location.href='${pageContext.request.contextPath}/admin/suppliers/edit?id=${s.maCH}'">Sửa</button>

                                    <!-- XÓA: dùng chung /admin/suppliers/delete -->
                                    <form method="post"
                                        action="${pageContext.request.contextPath}/admin/suppliers/delete"
                                        onsubmit="return confirm('Xoá cửa hàng #${s.maCH}?');">
                                        <input type="hidden" name="id" value="${s.maCH}" />
                                        <button class="btn btn-danger">Xoá</button>
                                    </form>

                                    <button class="btn btn-primary"
                                        onclick="location.href='${pageContext.request.contextPath}/admin/suppliers/products?shopId=${s.maCH}'">
                                        Sản phẩm</button>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty shops}">
                            <tr>
                                <td colspan="7" class="muted" style="text-align: center; padding: 40px;">Chưa có dữ liệu.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <form method="get" style="display: inline">
                    <input type="hidden" name="q" value="${param_q}" /> <input
                        type="hidden" name="pageSize" value="${pageSize}" />
                    <button class="pbtn" name="page" value="${currentPage-1}"
                        <c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
                </form>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <form method="get" style="display: inline">
                        <input type="hidden" name="q" value="${param_q}" /> <input
                            type="hidden" name="pageSize" value="${pageSize}" />
                        <button class="pbtn ${i==currentPage?'active':''}" name="page"
                            value="${i}">${i}</button>
                    </form>
                </c:forEach>

                <form method="get" style="display: inline">
                    <input type="hidden" name="q" value="${param_q}" /> <input
                        type="hidden" name="pageSize" value="${pageSize}" />
                    <button class="pbtn" name="page" value="${currentPage+1}"
                        <c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
                </form>
            </div>

        </div>
    </main>
</div>