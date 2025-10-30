<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Khiếu nại cửa hàng - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(180deg, #f3f6ff 0%, #eef1f7 100%);
            font-family: "Inter", "Segoe UI", sans-serif;
        }
        .page-header {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
        }
        .complaint-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #0d6efd;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .complaint-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .status-PENDING { background: #fff3cd; color: #856404; }
        .status-APPROVED { background: #d1e7dd; color: #0f5132; }
        .status-REJECTED { background: #f8d7da; color: #842029; }
        .status-WITHDRAWN { background: #e2e3e5; color: #41464b; }
    </style>
</head>
<body>
    <div class="container mt-4 mb-5">
        <!-- Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2><i class="bi bi-flag"></i> Khiếu nại cửa hàng của tôi</h2>
                    <p class="text-muted mb-0">Quản lý các khiếu nại bạn đã gửi về cửa hàng</p>
                </div>
                <a href="${pageContext.request.contextPath}/user/shop-complaint-form" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> Gửi khiếu nại mới
                </a>
            </div>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show">
                ${sessionScope.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <!-- Filter & Search -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/user/shop-complaints" class="row g-3">
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="q" placeholder="Tìm kiếm..." value="${param_q}">
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="status">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="PENDING" ${param_status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="APPROVED" ${param_status == 'APPROVED' ? 'selected' : ''}>Đã chấp nhận</option>
                            <option value="REJECTED" ${param_status == 'REJECTED' ? 'selected' : ''}>Đã từ chối</option>
                            <option value="WITHDRAWN" ${param_status == 'WITHDRAWN' ? 'selected' : ''}>Đã thu hồi</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="sort">
                            <option value="date_desc" ${param_sort == 'date_desc' ? 'selected' : ''}>Mới nhất</option>
                            <option value="date_asc" ${param_sort == 'date_asc' ? 'selected' : ''}>Cũ nhất</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i> Lọc</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Complaints List -->
        <c:choose>
            <c:when test="${empty complaints}">
                <div class="alert alert-info text-center">
                    <i class="bi bi-info-circle fs-3"></i>
                    <p class="mb-0 mt-2">Bạn chưa có khiếu nại nào.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="c" items="${complaints}">
                    <div class="complaint-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div>
                                <h5 class="mb-1">${c.tieuDe}</h5>
                                <small class="text-muted">
                                    <i class="bi bi-shop"></i> ${c.cuaHang.tenCH}
                                </small>
                            </div>
                            <span class="status-badge status-${c.trangThai}">${c.trangThai}</span>
                        </div>
                        <p class="text-muted">${c.noiDung}</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="text-muted">
                                <i class="bi bi-calendar"></i> 
                                <fmt:formatDate value="${c.ngayGui}" pattern="dd/MM/yyyy HH:mm"/>
                            </small>
                            <c:if test="${c.trangThai == 'PENDING'}">
                                <button class="btn btn-sm btn-outline-danger" onclick="withdrawComplaint(${c.maKNCH})">
                                    <i class="bi bi-x-circle"></i> Thu hồi
                                </button>
                            </c:if>
                        </div>
                        <c:if test="${not empty c.ghiChu}">
                            <div class="alert alert-light mt-3 mb-0">
                                <strong>Phản hồi của Admin:</strong> ${c.ghiChu}
                                <c:if test="${not empty c.ngayXuLy}">
                                    <br><small class="text-muted">
                                        <fmt:formatDate value="${c.ngayXuLy}" pattern="dd/MM/yyyy HH:mm"/>
                                    </small>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&pageSize=${pageSize}&q=${param_q}&status=${param_status}&sort=${param_sort}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function withdrawComplaint(id) {
            if (confirm('Bạn có chắc muốn thu hồi khiếu nại này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/user/shop-complaints';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'withdraw';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
