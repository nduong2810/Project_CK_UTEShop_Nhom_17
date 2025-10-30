<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
/* ===== CSS hiện đại hóa cho trang Customers ===== */
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

.admin-shell .badge-ok { background: #dcfce7; color: #166534; }
.admin-shell .badge-off { background: #fee2e2; color: #991b1b; }

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

.admin-shell .actions {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
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

/* Appeal mini form */
.admin-shell .appeal-box {
    display: none;
    margin-top: 12px;
    border: 1px dashed #fca5a5;
    background: #fff7f7;
    padding: 12px;
    border-radius: 10px;
}

.admin-shell .appeal-box textarea {
    width: 100%;
    min-height: 80px;
    border: 1px solid var(--admin-border);
    border-radius: 8px;
    padding: 10px;
    resize: vertical;
    color: var(--text-color);
}

.admin-shell .appeal-actions {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
    margin-top: 10px;
}

.admin-shell .appeal-link {
    color: #b91c1c;
    font-size: 13px;
    text-decoration: underline;
    cursor: pointer;
    background: transparent;
    border: 0;
    padding: 0;
}
</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">

            <div class="title">Khách hàng</div>

            <div class="toolbar">
                <div class="muted">Tổng: ${totalUsers} người dùng</div>
                <form method="get" style="display: flex; gap: 10px; align-items: center; flex-wrap: wrap">
                    <input class="input" type="text" name="q"
                        placeholder="Tìm tên/username/email..." value="${param_q}">
                    <select class="select" name="role" onchange="this.form.submit()">
                        <option value="">Vai trò</option>
                        <option value="USER" ${param_role=='USER'?'selected':''}>USER</option>
                        <option value="VENDOR" ${param_role=='VENDOR'?'selected':''}>VENDOR</option>
                        <option value="ADMIN" ${param_role=='ADMIN'?'selected':''}>ADMIN</option>
                        <option value="SHIPPER" ${param_role=='SHIPPER'?'selected':''}>SHIPPER</option>
                    </select> <select class="select" name="sort" onchange="this.form.submit()">
                        <option value="">Sắp xếp</option>
                        <option value="date_desc" ${param_sort=='date_desc'?'selected':''}>Mới
                            nhất</option>
                        <option value="name_asc" ${param_sort=='name_asc'?'selected':''}>Tên
                            A→Z</option>
                        <option value="name_desc" ${param_sort=='name_desc'?'selected':''}>Tên
                            Z→A</option>
                        <option value="id_asc" ${param_sort=='id_asc'?'selected':''}>Mã
                            ↑</option>
                        <option value="id_desc" ${param_sort=='id_desc'?'selected':''}>Mã
                            ↓</option>
                    </select> <select class="select" name="pageSize"
                        onchange="this.form.submit()">
                        <option value="10" ${pageSize==10?'selected':''}>10 /
                            trang</option>
                        <option value="20" ${pageSize==20?'selected':''}>20 /
                            trang</option>
                        <option value="50" ${pageSize==50?'selected':''}>50 /
                            trang</option>
                    </select>
                    <button class="btn btn-primary">Lọc</button>
                </form>
            </div>

            <div class="panel">
                <table class="table">
                    <thead>
                        <tr>
                            <th style="width: 80px">Mã</th>
                            <th style="width: 150px">Họ tên</th>
                            <th style="width: 120px">Username</th>
                            <th style="width: 200px">Email</th>
                            <th style="width: 100px">Vai trò</th>
                            <th style="width: 100px">Trạng thái</th>
                            <th style="width: 150px">Ngày tạo</th>
                            <th style="width: 250px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>#${u.maND}</td>
                                <td>${u.hoTen}</td>
                                <td>${u.tenDangNhap}</td>
                                <td>${u.email}</td>
                                <td>${u.vaiTro}</td>
                                <td><c:choose>
                                        <c:when test="${u.trangThai}">
                                            <span class="badge badge-ok">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-off">Khoá</span>
                                        </c:otherwise>
                                    </c:choose></td>
                                <td><fmt:formatDate value="${u.ngayTao}"
                                        pattern="dd/MM/yyyy HH:mm" /></td>
                                <td>
                                    <div class="actions">
                                        <button class="btn"
                                            onclick="location.href='${pageContext.request.contextPath}/admin/customers/edit?id=${u.maND}'">Sửa</button>

                                        <!-- Nếu đang bị khoá: hiện nút Khiếu nại + form mini -->
                                        <c:if test="${!u.trangThai}">
                                            <button class="btn btn-primary"
                                                onclick="location.href='${pageContext.request.contextPath}/admin/appeals?status=PENDING&userId=${u.maND}'">
                                                Duyệt khiếu nại</button>
                                        </c:if>
                                    </div> <!-- Appeal mini form (ẩn/hiện) --> <c:if
                                        test="${!u.trangThai}">
                                        <div id="appeal-${u.maND}" class="appeal-box">
                                            <form method="post"
                                                action="${pageContext.request.contextPath}/admin/customers/appeal">
                                                <input type="hidden" name="userId" value="${u.maND}">
                                                <label class="muted"
                                                    style="display: block; margin-bottom: 8px"> Ghi rõ
                                                    lý do bạn cần mở khoá tài khoản: </label>
                                                <textarea name="message"
                                                    placeholder="Ví dụ: tài khoản bị khoá nhầm, tôi có thể cung cấp thêm thông tin để xác minh..."></textarea>
                                                <div class="appeal-actions">
                                                    <button type="button" class="btn"
                                                        onclick="toggleAppeal('${u.maND}')">Huỷ</button>
                                                    <button class="btn btn-primary" type="submit">Gửi
                                                        khiếu nại</button>
                                                </div>
                                            </form>
                                        </div>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="8" class="muted" style="text-align: center; padding: 40px;">Chưa có dữ liệu.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <form method="get" style="display: inline">
                    <input type="hidden" name="q" value="${param_q}"> <input
                        type="hidden" name="role" value="${param_role}"> <input
                        type="hidden" name="sort" value="${param_sort}"> <input
                        type="hidden" name="pageSize" value="${pageSize}">
                    <button class="pbtn" name="page" value="${currentPage-1}"
                        <c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
                </form>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <form method="get" style="display: inline">
                        <input type="hidden" name="q" value="${param_q}"> <input
                            type="hidden" name="role" value="${param_role}"> <input
                            type="hidden" name="sort" value="${param_sort}"> <input
                            type="hidden" name="pageSize" value="${pageSize}">
                        <button class="pbtn ${i==currentPage?'active':''}" name="page"
                            value="${i}">${i}</button>
                    </form>
                </c:forEach>

                <form method="get" style="display: inline">
                    <input type="hidden" name="q" value="${param_q}"> <input
                        type="hidden" name="role" value="${param_role}"> <input
                        type="hidden" name="sort" value="${param_sort}"> <input
                        type="hidden" name="pageSize" value="${pageSize}">
                    <button class="pbtn" name="page" value="${currentPage+1}"
                        <c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
                </form>
            </div>

        </div>
    </main>
</div>

<script>
    function toggleAppeal(id) {
        const box = document.getElementById('appeal-' + id);
        if (!box)
            return;
        box.style.display = (box.style.display === 'block') ? 'none' : 'block';
    }
</script>
