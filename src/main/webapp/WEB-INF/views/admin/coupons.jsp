<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- Nếu bạn có dùng JSTL fmt ở nơi khác, thêm khi cần:
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
--%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
:root{--bg:#f5f7fb;--border:#e5e7eb;--card:#fff;--muted:#6b7280;--primary:#1a73e8}
.admin-shell{display:flex;min-height:100vh;background:var(--bg)}
.admin-content{flex:1;min-width:0}
.admin-container{padding:16px}
.title{font-size:20px;font-weight:800;margin:8px 0 12px;color:#111827}
.card{background:#fff;border:1px solid var(--border);border-radius:16px;padding:16px;margin-bottom:12px}
.table{width:100%;border-collapse:collapse}
.table th,.table td{border-top:1px solid var(--border);padding:10px 12px;font-size:14px}
.table th{background:#fafafa;text-align:left}
.toolbar{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:12px}
.input{height:36px;border:1px solid var(--border);border-radius:10px;padding:0 10px}
.btn{height:36px;border:1px solid var(--border);background:#fff;border-radius:10px;padding:0 12px;cursor:pointer}
.btn-primary{background:#1a73e8;color:#fff;border-color:transparent}
.badge{display:inline-flex;align-items:center;padding:4px 10px;border-radius:999px;font-size:12px;font-weight:700}
.badge-green{background:#dcfce7;color:#166534}
.badge-gray{background:#f3f4f6;color:#374151}
.pager{display:flex;gap:6px;align-items:center;justify-content:flex-end;margin-top:10px}
.page-btn{min-width:36px;height:36px;border:1px solid var(--border);border-radius:8px;background:#fff;cursor:pointer}
.page-btn.active{background:#1a73e8;color:#fff;border-color:transparent}
.muted{color:#6b7280}
</style>

<div class="admin-shell">
  <%@ include file="/WEB-INF/views/admin/sidebar.jsp" %>

  <main class="admin-content">
    <div class="admin-container">
      <div class="title">Mã giảm giá</div>

      <div class="card">
        <form method="get" class="toolbar">
          <input class="input" type="text" name="q" value="${param_q}" placeholder="Tìm theo mã/ chương trình"/>
          <select class="input" name="type">
            <option value="">-- Loại --</option>
            <option value="percent" ${param_type=='percent' ? 'selected' : ''}>Giảm %</option>
            <option value="amount"  ${param_type=='amount'  ? 'selected' : ''}>Giảm tiền</option>
          </select>
          <select class="input" name="status">
            <option value="">-- Trạng thái --</option>
            <option value="ongoing"  ${param_status=='ongoing'  ? 'selected' : ''}>Đang diễn ra</option>
            <option value="upcoming" ${param_status=='upcoming' ? 'selected' : ''}>Sắp diễn ra</option>
            <option value="expired"  ${param_status=='expired'  ? 'selected' : ''}>Đã hết hạn</option>
          </select>
          <select class="input" name="sort">
            <option value="">Mới nhất</option>
            <option value="name_asc"  ${param_sort=='name_asc'  ? 'selected' : ''}>Tên A→Z</option>
            <option value="name_desc" ${param_sort=='name_desc' ? 'selected' : ''}>Tên Z→A</option>
            <option value="start_asc" ${param_sort=='start_asc' ? 'selected' : ''}>Bắt đầu ↑</option>
            <option value="start_desc"${param_sort=='start_desc'? 'selected' : ''}>Bắt đầu ↓</option>
            <option value="end_asc"   ${param_sort=='end_asc'   ? 'selected' : ''}>Kết thúc ↑</option>
            <option value="end_desc"  ${param_sort=='end_desc'  ? 'selected' : ''}>Kết thúc ↓</option>
          </select>
          <select class="input" name="pageSize">
            <option ${pageSize==10 ? 'selected' : ''} value="10">10</option>
            <option ${pageSize==20 ? 'selected' : ''} value="20">20</option>
            <option ${pageSize==50 ? 'selected' : ''} value="50">50</option>
          </select>
          <button class="btn">Lọc</button>
          <button class="btn btn-primary" type="button" onclick="location.href='${ctx}/admin/coupons/edit'">+ Tạo mã giảm giá</button>
        </form>

        <div style="overflow:auto">
          <table class="table">
            <thead>
              <tr>
                <th>#</th>
                <th>Mã</th>
                <th>Chương trình</th>
                <th>Loại</th>
                <th>Giá trị</th>
                <th>Bắt đầu</th>
                <th>Kết thúc</th>
                <th>Trạng thái</th>
                <th style="width:160px">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="c" items="${coupons}">
                <tr>
                  <td>#${c.maGG}</td>
                  <td>${c.maSo}</td>
                  <td>${c.tenChuongTrinh}</td>
                  <td>
                    <c:choose>
                      <c:when test="${c.loaiGiam == 'PERCENT' || c.loaiGiam == 'percent'}">Giảm %</c:when>
                      <c:otherwise>Giảm tiền</c:otherwise>
                    </c:choose>
                  </td>
                  <td>${c.giaTriGiam}</td>
                  <td><c:out value="${c.ngayBatDau}"/></td>
                  <td><c:out value="${c.ngayKetThuc}"/></td>
                  <td>
                    <c:choose>
                      <c:when test="${c.trangThai}"><span class="badge badge-green">Bật</span></c:when>
                      <c:otherwise><span class="badge badge-gray">Tắt</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <button class="btn" type="button"
                            onclick="location.href='${ctx}/admin/coupons/edit?id=${c.maGG}'">Sửa</button>
                    <button class="btn" type="button"
                            onclick="if(confirm('Xoá mã #${c.maGG}?')) location.href='${ctx}/admin/coupons/delete?id=${c.maGG}'">Xoá</button>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty coupons}">
                <tr><td class="muted" colspan="9">Không có dữ liệu.</td></tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <div class="pager">
          <c:forEach var="p" begin="1" end="${totalPages}">
            <c:url var="pageUrl" value="${ctx}/admin/coupons">
              <c:param name="page" value="${p}"/>
              <c:param name="pageSize" value="${pageSize}"/>
              <c:if test="${not empty param_q}"><c:param name="q" value="${param_q}"/></c:if>
              <c:if test="${not empty param_type}"><c:param name="type" value="${param_type}"/></c:if>
              <c:if test="${not empty param_status}"><c:param name="status" value="${param_status}"/></c:if>
              <c:if test="${not empty param_sort}"><c:param name="sort" value="${param_sort}"/></c:if>
            </c:url>
            <a class="page-btn ${p==currentPage?'active':''}" href="${pageUrl}">${p}</a>
          </c:forEach>
        </div>

      </div>
    </div>
  </main>
</div>
