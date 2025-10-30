<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Thêm Google Font để giao diện hiện đại hơn (giống File 2) --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
    /* ===== CSS MASTER (Chuẩn hóa và tối ưu hoá) ===== */
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
    }

    /* ===== Layout chính ===== */
    .admin-shell {
        display: flex;
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
    }

    /* ===== Tiêu đề trang ===== */
    .admin-shell .page-title {
        font-size: 28px;
        font-weight: 700;
        margin: 0 0 20px;
        color: var(--heading-color);
    }

    /* ===== Toolbar ===== */
    .admin-shell .toolbar {
        display: flex;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
    }

    /* ===== KPI Cards ===== */
    .admin-shell .kpi-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
        margin-bottom: 24px;
    }

    .admin-shell .kpi-card {
        background: var(--card);
        border-radius: var(--radius);
        padding: 24px;
        display: flex;
        align-items: center;
        gap: 20px;
        box-shadow: var(--shadow);
    }

    .admin-shell .kpi-ico {
        font-size: 36px;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        display: grid;
        place-items: center;
        background: #eef4ff;
    }

    .admin-shell .kpi-meta .kpi-title {
        color: var(--muted);
        font-size: 14px;
        margin-bottom: 4px;
    }

    .admin-shell .kpi-meta .kpi-value {
        font-size: 28px;
        font-weight: 700;
        color: var(--heading-color);
    }

    /* ===== Panel ===== */
    .admin-shell .panel {
        background: var(--card);
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        margin-bottom: 24px;
    }

    .admin-shell .panel-hd {
        padding: 20px 24px;
        border-bottom: 1px solid var(--admin-border);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .admin-shell .panel-title {
        font-size: 18px;
        font-weight: 600;
        color: var(--heading-color);
    }

    /* ===== Table ===== */
    .admin-shell .table {
        width: 100%;
        border-collapse: collapse;
    }

    .admin-shell .table th,
    .admin-shell .table td {
        padding: 16px 24px;
        text-align: left;
        border-bottom: 1px solid var(--admin-border);
        vertical-align: top;
        font-size: 14px;
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

    .admin-shell .table .right { text-align: right; }
    .admin-shell .table .center { text-align: center; }

    /* ===== Form Elements ===== */
    .admin-shell .input,
    .admin-shell .select {
        height: 40px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 0 12px;
        background: var(--card);
        font-family: 'Inter', sans-serif;
        font-size: 14px;
    }

    .admin-shell .input:focus,
    .admin-shell .select:focus {
        border-color: var(--primary);
        outline: 2px solid var(--primary);
        outline-offset: -1px;
    }

    .admin-shell .textarea {
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        padding: 10px 12px;
        background: var(--card);
        font-family: 'Inter', sans-serif;
        font-size: 14px;
        width: 100%;
    }

    /* ===== Buttons ===== */
    .admin-shell .btn {
        height: 40px;
        padding: 0 20px;
        border-radius: 10px;
        border: 1px solid var(--admin-border);
        background: var(--card);
        font-weight: 600;
        cursor: pointer;
        transition: all .2s ease;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        text-decoration: none;
        color: var(--text-color);
    }

    .admin-shell .btn:hover { background: #f9fafb; }

    .admin-shell .btn-primary {
        background: var(--primary);
        border-color: var(--primary);
        color: #fff;
    }

    .admin-shell .btn-primary:hover {
        background: #0a4fc1;
        border-color: #0a4fc1;
    }

    .admin-shell .btn-success { background: #166534; border-color: #166534; color: #fff; }
    .admin-shell .btn-danger { background: #991b1b; border-color: #991b1b; color: #fff; }
    .admin-shell .btn-secondary { background: var(--muted); border-color: var(--muted); color: #fff; }

    .admin-shell .btn-sm {
        height: 32px;
        padding: 0 14px;
        font-size: 13px;
    }

    /* ===== Badge ===== */
    .admin-shell .badge {
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: .5px;
    }

    .admin-shell .b-pending { background: #ffedd5; color: #9a3412; }
    .admin-shell .b-approved { background: #dcfce7; color: #166534; }
    .admin-shell .b-rejected { background: #fee2e2; color: #991b1b; }
    .admin-shell .b-withdrawn { background: #e5e7eb; color: #4b5563; }

    /* ===== Alert ===== */
    .admin-shell .admin-alert {
        padding: 16px;
        border-radius: 12px;
        margin-bottom: 20px;
        font-weight: 500;
        border: 1px solid transparent;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .admin-shell .alert-success {
        background: #dcfce7;
        color: #166534;
        border-color: #bbf7d0;
    }

    .admin-shell .alert-danger {
        background: #fee2e2;
        color: #991b1b;
        border-color: #fecaca;
    }

    .admin-shell .alert-info {
        background: #e0f2fe;
        color: #0c54a1;
        border-color: #bae6fd;
    }

    .admin-shell .btn-close {
        border: none;
        background: transparent;
        opacity: 0.6;
        cursor: pointer;
        font-size: 20px;
        padding: 0 4px;
    }

    .admin-shell .btn-close:hover { opacity: 1; }

    /* ===== Modal ===== */
    .admin-shell .modal-backdrop {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(17, 24, 39, 0.6);
        z-index: 1040;
        display: none;
        opacity: 0;
        transition: opacity .15s linear;
    }

    .admin-shell .modal-backdrop.show { opacity: 1; display: block; }

    .admin-shell .modal {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        z-index: 1050;
        display: none;
        overflow: auto;
    }

    .admin-shell .modal.show { display: block; }

    .admin-shell .modal-dialog {
        position: relative;
        width: auto;
        max-width: 500px;
        margin: 40px auto;
        transform: translateY(-50px);
        transition: transform .3s ease-out;
    }

    .admin-shell .modal.show .modal-dialog { transform: translateY(0); }

    .admin-shell .modal-content {
        background: var(--card);
        border-radius: var(--radius);
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        border: none;
        overflow: hidden;
    }

    .admin-shell .modal-header {
        padding: 20px 24px;
        border-bottom: 1px solid var(--admin-border);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .admin-shell .modal-title {
        font-size: 18px;
        font-weight: 600;
        color: var(--heading-color);
    }

    .admin-shell .modal-body { padding: 24px; }

    .admin-shell .modal-footer {
        padding: 16px 24px;
        border-top: 1px solid var(--admin-border);
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    /* ===== Pagination ===== */
    .admin-shell .pagination {
        display: flex;
        justify-content: center;
        gap: 8px;
        margin-top: 20px;
        list-style: none;
        padding: 0;
    }

    .admin-shell .page-item { display: inline-block; }

    .admin-shell .page-link {
        padding: 8px 14px;
        border: 1px solid var(--admin-border);
        border-radius: 10px;
        background: var(--card);
        text-decoration: none;
        color: var(--text-color);
        font-weight: 500;
        font-size: 14px;
    }

    .admin-shell .page-item.active .page-link {
        background: var(--primary);
        color: white;
        border-color: var(--primary);
    }

</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>
	
	<main class="admin-content">
		<div class="admin-container">
			
			<c:if test="${not empty sessionScope.success}">
				<div class="admin-alert alert-success">
					<span>${sessionScope.success}</span>
					<button type="button" class="btn-close" onclick="this.parentElement.remove()">×</button>
				</div>
				<c:remove var="success" scope="session"/>
			</c:if>
			<c:if test="${not empty sessionScope.error}">
				<div class="admin-alert alert-danger">
					<span>${sessionScope.error}</span>
					<button type="button" class="btn-close" onclick="this.parentElement.remove()">×</button>
				</div>
				<c:remove var="error" scope="session"/>
			</c:if>

			<div class="page-title">Quản lý khiếu nại cửa hàng</div>

			<section class="kpi-grid" style="grid-template-columns: 1fr;">
				<div class="kpi-card">
					<div class="kpi-ico" style="background: #eef4ff; color: #0b57d0;">
						<i class="bi bi-flag-fill"></i>
					</div>
					<div class="kpi-meta">
						<div class="kpi-title">Tổng khiếu nại</div>
						<div class="kpi-value">${total}</div>
					</div>
				</div>
			</section>

			<%-- MODIFIED: Filter section --%>
			<div class="panel">
				<div class="panel-hd">
					<div class="panel-title">Lọc và tìm kiếm</div>
				</div>
				<form method="get" class="toolbar" style="padding: 20px 24px; justify-content: space-between;">
					<div style="display: flex; flex-wrap: wrap; gap: 15px; flex-grow: 1;">
						<input class="input" type="text" name="q" placeholder="Tìm kiếm tiêu đề, nội dung..." value="${param_q}" style="flex: 1; min-width: 200px;">
						<select class="select" name="status" style="min-width: 150px;">
							<option value="">Tất cả trạng thái</option>
							<option value="PENDING" ${param_status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
							<option value="APPROVED" ${param_status == 'APPROVED' ? 'selected' : ''}>Đã chấp nhận</option>
							<option value="REJECTED" ${param_status == 'REJECTED' ? 'selected' : ''}>Đã từ chối</option>
							<option value="WITHDRAWN" ${param_status == 'WITHDRAWN' ? 'selected' : ''}>Đã thu hồi</option>
						</select>
						<select class="select" name="sort" style="min-width: 120px;">
							<option value="date_desc" ${param_sort == 'date_desc' ? 'selected' : ''}>Mới nhất</option>
							<option value="date_asc" ${param_sort == 'date_asc' ? 'selected' : ''}>Cũ nhất</option>
						</select>
						<input class="input" type="number" name="userId" placeholder="Mã người dùng" value="${param_userId}" style="min-width: 140px;">
						<input class="input" type="number" name="vendorId" placeholder="Mã cửa hàng" value="${param_vendorId}" style="min-width: 140px;">
					</div>
					<button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Lọc</button>
				</form>
			</div>

			<section class="panel">
				<div class="panel-hd">
					<div class="panel-title">Danh sách khiếu nại</div>
				</div>
				<div style="overflow: auto;">
					<table class="table">
						<thead>
							<tr>
								<th>ID</th>
								<th>Người khiếu nại</th>
								<th>Cửa hàng</th>
								<th>Tiêu đề & Nội dung</th>
								<th>Ngày gửi</th>
								<th>Trạng thái</th>
								<th>Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty complaints}">
									<tr>
										<td class="muted" colspan="7" style="text-align: center; padding: 40px;">
											<i class="bi bi-info-circle" style="font-size: 48px; color: var(--muted);"></i>
											<p style="margin: 16px 0 0 0;">Không có khiếu nại nào.</p>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="c" items="${complaints}">
										<tr>
											<td>#${c.maKNCH}</td>
											<td>
												<strong>${c.nguoiDung.hoTen}</strong><br>
												<small class="muted">ID: ${c.nguoiDung.maND}</small>
											</td>
											<td>
												<strong>${c.cuaHang.tenCH}</strong><br>
												<small class="muted">ID: ${c.cuaHang.maCH}</small>
											</td>
											<td style="min-width: 300px;">
												<strong>${c.tieuDe}</strong>
												<p style="margin: 8px 0 0 0; color: #374151;">${c.noiDung}</p>
												
												<%-- MODIFIED: Admin note section --%>
												<c:if test="${not empty c.ghiChu}">
													<div style="margin-top: 12px; background: var(--admin-bg); padding: 12px; border-radius: 10px; border: 1px solid var(--admin-border);">
														<strong style="color: var(--heading-color);">Ghi chú của Admin:</strong>
														<p style="margin: 4px 0 0 0; font-style: italic; color: var(--text-color);">${c.ghiChu}</p>
														<small class="muted" style="display: block; margin-top: 8px;">
															<i class="bi bi-clock"></i> <fmt:formatDate value="${c.ngayXuLy}" pattern="dd/MM/yyyy HH:mm"/>
														</small>
													</div>
												</c:if>
											</td>
											<td>
												<fmt:formatDate value="${c.ngayGui}" pattern="dd/MM/yyyy HH:mm"/>
											</td>
											<td>
												<c:choose>
													<c:when test="${c.trangThai == 'PENDING'}"><span class="badge b-pending">Chờ xử lý</span></c:when>
													<c:when test="${c.trangThai == 'APPROVED'}"><span class="badge b-approved">Chấp nhận</span></c:when>
													<c:when test="${c.trangThai == 'REJECTED'}"><span class="badge b-rejected">Từ chối</span></c:when>
													<c:when test="${c.trangThai == 'WITHDRAWN'}"><span class="badge b-withdrawn">Thu hồi</span></c:when>
												</c:choose>
											</td>
											<td>
												<c:if test="${c.trangThai == 'PENDING'}">
													<div style="display: flex; flex-direction: column; gap: 8px;">
														<%-- MODIFIED: Action buttons --%>
														<button class="btn btn-success btn-sm" onclick="openStatusModal(${c.maKNCH}, 'APPROVED')">
															<i class="bi bi-check-lg"></i> Chấp nhận
														</button>
														<button class="btn btn-danger btn-sm" onclick="openStatusModal(${c.maKNCH}, 'REJECTED')">
															<i class="bi bi-x-lg"></i> Từ chối
														</button>
													</div>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				
				<c:if test="${totalPages > 1}">
					<div style="padding: 20px 24px; border-top: 1px solid var(--admin-border);">
						<ul class="pagination">
							<c:forEach var="i" begin="1" end="${totalPages}">
								<li class="page-item ${i == currentPage ? 'active' : ''}">
									<a class="page-link" href="?page=${i}&pageSize=${pageSize}&q=${param_q}&status=${param_status}&sort=${param_sort}&userId=${param_userId}&vendorId=${param_vendorId}">${i}</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</section>
		</div>
	</main>
</div>

<div class="modal" id="statusModal">
	<div class="modal-backdrop" onclick="closeStatusModal()"></div>
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="statusForm" method="post" action="${pageContext.request.contextPath}/admin/shop-complaint-update">
				<div class="modal-header">
					<h5 class="modal-title">Cập nhật trạng thái khiếu nại</h5>
					<button type="button" class="btn-close" onclick="closeStatusModal()">×</button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="id" id="complaintId">
					<input type="hidden" name="status" id="complaintStatus">
					
					<div>
						<label for="note" style="font-weight: 600; margin-bottom: 8px; display: block;">Ghi chú (tùy chọn)</label>
						<textarea class="textarea" id="note" name="note" rows="4" 
								  placeholder="Nhập lý do hoặc ghi chú..."></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" onclick="closeStatusModal()">Hủy</button>
					<button type="submit" class="btn btn-primary">Xác nhận</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	const statusModalEl = document.getElementById('statusModal');
	const backdropEl = statusModalEl.querySelector('.modal-backdrop');
	
	function openStatusModal(id, status) {
		document.getElementById('complaintId').value = id;
		document.getElementById('complaintStatus').value = status;
		document.getElementById('note').value = '';
		
		statusModalEl.classList.add('show');
		backdropEl.classList.add('show');
	}

	function closeStatusModal() {
		statusModalEl.classList.remove('show');
		backdropEl.classList.remove('show');
	}
</script>
