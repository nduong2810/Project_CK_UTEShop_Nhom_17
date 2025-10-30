<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Nếu dùng javax JSTL (Tomcat 9-): đổi dòng dưới thành:
     <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
--%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

    /* Badge colors */
    .admin-shell .badge-new { background: #e0f2fe; color: #0c54a1; }
    .admin-shell .badge-confirm { background: #dcfce7; color: #166534; }
    .admin-shell .badge-ship { background: #ffedd5; color: #9a3412; }
    .admin-shell .badge-done { background: #d1fae5; color: #065f46; }
    .admin-shell .badge-cancel { background: #fee2e2; color: #991b1b; }
    .admin-shell .badge-return { background: #fef9c3; color: #854d0e; }
    .admin-shell .badge-refund { background: #f3e8ff; color: #6b21a8; }
    .admin-shell .badge-gray { background: #f3f4f6; color: #374151; }

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

    .admin-shell .actions {
        display: flex;
        gap: 10px;
        align-items: center;
        flex-wrap: wrap;
    }
</style>

<div class="admin-shell">
    <%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>

    <main class="admin-content">
        <div class="admin-container">

            <div class="title">Đơn hàng</div>

            <c:if test="${param.msg=='updated'}">
                <div class="alert alert-ok">Đã cập nhật trạng thái đơn.</div>
            </c:if>
            <c:if test="${param.msg=='error'}">
                <div class="alert alert-err">Có lỗi xảy ra.</div>
            </c:if>

            <!-- Bộ lọc -->
            <div class="toolbar">
                <form method="get"
                    style="display: flex; gap: 10px; align-items: center; flex-wrap: wrap">
                    <input class="input" name="q" value="${param_q}"
                        placeholder="Mã đơn / tên / email..."> <select
                        class="select" name="status">
                        <option value="">-- Trạng thái --</option>
                        <option value="Mới tạo" ${param_status=='Mới tạo'?'selected':''}>Mới
                            tạo</option>
                        <option value="Đã xác nhận"
                            ${param_status=='Đã xác nhận'?'selected':''}>Đã xác nhận</option>
                        <option value="Đang giao"
                            ${param_status=='Đang giao'?'selected':''}>Đang giao</option>
                        <option value="Đã giao" ${param_status=='Đã giao'?'selected':''}>Đã
                            giao</option>
                        <option value="Đã huỷ" ${param_status=='Đã huỷ'?'selected':''}>Đã
                            huỷ</option>
                        <option value="Trả hàng" ${param_status=='Trả hàng'?'selected':''}>Trả
                            hàng</option>
                        <option value="Hoàn tiền"
                            ${param_status=='Hoàn tiền'?'selected':''}>Hoàn tiền</option>
                    </select> <input class="input" type="date" name="from" value="${param_from}" />
                    <input class="input" type="date" name="to" value="${param_to}" />
                    <select class="select" name="pageSize">
                        <option value="10" ${pageSize==10?'selected':''}>10 /
                            trang</option>
                        <option value="20" ${pageSize==20?'selected':''}>20 /
                            trang</option>
                        <option value="50" ${pageSize==50?'selected':''}>50 /
                            trang</option>
                    </select>
                    <button class="btn btn-primary">Lọc</button>
                </form>

                <div class="badge badge-gray">Tổng: ${total} đơn</div>
            </div>

            <!-- Bảng -->
            <div class="panel">
                <table class="table">
                    <thead>
                        <tr>
                            <th style="width: 100px">Mã đơn</th>
                            <th>Khách hàng</th>
                            <th style="width: 160px">Ngày đặt</th>
                            <th style="width: 140px">Hình thức TT</th>
                            <th style="width: 160px">Tổng thanh toán</th>
                            <th style="width: 170px">Trạng thái</th>
                            <th style="width: 220px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td>#${o.maDH}</td>
                                <td>
                                    <div>${o.nguoiDung.hoTen}</div>
                                    <div class="muted" style="font-size: 12px">${o.nguoiDung.email}</div>
                                </td>
                                <td><fmt:formatDate value="${o.ngayDat}"
                                        pattern="dd/MM/yyyy HH:mm" /></td>
                                <td>${empty o.phuongThucThanhToan ? '—' : o.phuongThucThanhToan}</td>
                                <td><fmt:formatNumber value="${o.tongThanhToan}"
                                        type="number" maxFractionDigits="0" />đ</td>

                                <!-- Hiển thị trạng thái Enum → nhãn + màu -->
                                <td><c:choose>
                                        <c:when test="${o.trangThai == 'CHO_XAC_NHAN'}">
                                            <span class="badge badge-new">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'DA_XAC_NHAN'}">
                                            <span class="badge badge-confirm">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'DANG_CHUAN_BI'}">
                                            <span class="badge badge-ship">Đang chuẩn bị</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'DANG_GIAO'}">
                                            <span class="badge badge-ship">Đang giao</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'DA_GIAO'}">
                                            <span class="badge badge-done">Đã giao</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'HOAN_THANH'}">
                                            <span class="badge badge-done">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'DA_HUY'}">
                                            <span class="badge badge-cancel">Đã huỷ</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'TRA_HANG'}">
                                            <span class="badge badge-return">Trả hàng</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'HOAN_TIEN'}">
                                            <span class="badge badge-refund">Hoàn tiền</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'DANG_XU_LY'}">
                                            <span class="badge badge-ship">Đang Xử Lý</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-gray">—</span>
                                        </c:otherwise>
                                    </c:choose></td>

                                <td class="actions">
                                    <!-- cập nhật trạng thái nhanh -->
                                    <form method="post"
                                        action="${pageContext.request.contextPath}/admin/orders"
                                        style="display: flex; gap: 8px; align-items: center">
                                        <input type="hidden" name="op" value="updateStatus" /> <input
                                            type="hidden" name="id" value="${o.maDH}" /> <select
                                            name="newStatus" class="select" style="height: 38px">
                                            <option ${o.trangThai=='CHO_XAC_NHAN'?'selected':''}>Chờ xác nhận</option>
                                            <option ${o.trangThai=='DA_XAC_NHAN'?'selected':''}>Đã xác nhận</option>
                                            <option ${o.trangThai=='DANG_CHUAN_BI'?'selected':''}>Đang chuẩn bị</option>
                                            <option ${o.trangThai=='DANG_GIAO'?'selected':''}>Đang giao</option>
                                            <option ${o.trangThai=='DA_GIAO'?'selected':''}>Đã giao</option>
                                            <option ${o.trangThai=='HOAN_THANH'?'selected':''}>Hoàn thành</option>
                                            <option ${o.trangThai=='DA_HUY'?'selected':''}>Đã hủy</option>
                                            <option ${o.trangThai=='TRA_HANG'?'selected':''}>Trả hàng</option>
                                            <option ${o.trangThai=='HOAN_TIEN'?'selected':''}>Hoàn tiền</option>
                                        </select>
                                        <button class="btn btn-primary">Lưu</button>
                                    </form>

                                    <button class="btn"
                                        onclick="location.href='${pageContext.request.contextPath}/admin/orders/view?id=${o.maDH}'">Xem</button>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="7" class="muted" style="text-align: center; padding: 40px;">Chưa có dữ liệu.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
            <div class="pagination">
                <form method="get" style="display: inline">
                    <input type="hidden" name="q" value="${param_q}" /> <input
                        type="hidden" name="status" value="${param_status}" /> <input
                        type="hidden" name="from" value="${param_from}" /> <input
                        type="hidden" name="to" value="${param_to}" /> <input
                        type="hidden" name="pageSize" value="${pageSize}" />
                    <button class="pbtn" name="page" value="${currentPage-1}"
                        <c:if test="${currentPage<=1}">disabled</c:if>>Trước</button>
                </form>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <form method="get" style="display: inline">
                        <input type="hidden" name="q" value="${param_q}" /> <input
                            type="hidden" name="status" value="${param_status}" /> <input
                            type="hidden" name="from" value="${param_from}" /> <input
                            type="hidden" name="to" value="${param_to}" /> <input
                            type="hidden" name="pageSize" value="${pageSize}" />
                        <button class="pbtn ${i==currentPage?'active':''}" name="page"
                            value="${i}">${i}</button>
                    </form>
                </c:forEach>

                <form method="get" style="display: inline">
                    <input type="hidden" name="q" value="${param_q}" /> <input
                        type="hidden" name="status" value="${param_status}" /> <input
                        type="hidden" name="from" value="${param_from}" /> <input
                        type="hidden" name="to" value="${param_to}" /> <input
                        type="hidden" name="pageSize" value="${pageSize}" />
                    <button class="pbtn" name="page" value="${currentPage+1}"
                        <c:if test="${currentPage>=totalPages}">disabled</c:if>>Sau</button>
                </form>
            </div>

        </div>
    </main>
</div>