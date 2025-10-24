<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String ctx = request.getContextPath();
String uri = request.getRequestURI();

boolean aHome = uri.endsWith("/admin") || uri.endsWith("/admin/") || uri.contains("/admin/home");
boolean aProducts = uri.contains("/admin/products");
boolean aOrders = uri.contains("/admin/orders");
boolean aCustomers = uri.contains("/admin/customers");
boolean aSuppliers = uri.contains("/admin/suppliers");
boolean aCats = uri.contains("/admin/categories");
boolean aShip = uri.contains("/admin/shipping");
boolean aCoupons = uri.contains("/admin/coupons");
boolean aSettings = uri.contains("/admin/settings");
%>

<!-- ======= CSS chỉ cho khu vực admin (scoped bằng prefix .admin-) ======= -->
<style>
:root {
	--admin-sidebar-w: 240px;
	--admin-sidebar-w-collapsed: 64px;
	--admin-radius: 12px;
	--admin-bg: #f5f7fb;
	--admin-border: #e5e7eb;
	--admin-primary: #0b57d0; /* xanh header của bạn */
}

.admin-shell {
	display: flex;
	min-height: calc(100vh - 0px);
	/* nếu header của bạn fixed, trừ chiều cao ở đây */
	background: var(--admin-bg);
}

/* ==== Sidebar ==== */
.admin-sidebar {
	position: sticky;
	top: 0;
	width: var(--admin-sidebar-w);
	background: var(--admin-primary);
	color: #fff;
	height: 100vh;
	overflow-y: auto;
	transition: width .2s ease;
	box-shadow: 0 0 0 1px rgba(0, 0, 0, .04) inset;
}

.admin-sidebar.collapsed {
	width: var(--admin-sidebar-w-collapsed);
}

.admin-brand {
	height: 56px;
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 0 12px;
	border-bottom: 1px solid rgba(255, 255, 255, .14);
}

.admin-brand .admin-badge {
	width: 36px;
	height: 36px;
	border-radius: 10px;
	background: rgba(255, 255, 255, .18);
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 700;
}

.admin-brand .admin-title {
	font-weight: 700;
	letter-spacing: .3px;
}

.admin-hamburger {
	width: 36px;
	height: 36px;
	border-radius: 10px;
	border: 0;
	cursor: pointer;
	background: rgba(255, 255, 255, .18);
	color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
}

.admin-menu {
	list-style: none;
	margin: 10px 0;
	padding: 0;
}

.admin-menu a {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 10px 12px;
	margin: 6px 8px;
	color: #e7eefc;
	text-decoration: none;
	border-radius: 12px;
	font-size: 14px;
}

.admin-menu a:hover {
	background: rgba(255, 255, 255, .18);
	color: #fff;
}

.admin-menu a.active {
	background: #fff;
	color: var(--admin-primary);
	font-weight: 700;
}

.admin-ico {
	inline-size: 20px;
	text-align: center;
}

.admin-lbl {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* Ẩn chữ khi thu gọn */
.admin-sidebar.collapsed .admin-lbl {
	display: none;
}

.admin-sidebar.collapsed .admin-title {
	display: none;
}

.admin-sidebar.collapsed .admin-brand {
	justify-content: center;
}

.admin-sidebar.collapsed .admin-hamburger {
	width: 40px;
}

/* ==== Content ==== */
.admin-content {
	flex: 1;
	min-width: 0;
}

.admin-container {
	padding: 16px;
}

.admin-cards {
	display: grid;
	grid-template-columns: repeat(12, 1fr);
	gap: 16px;
}

.admin-card {
	grid-column: span 4;
	background: #fff;
	border: 1px solid var(--admin-border);
	border-radius: var(--admin-radius);
	padding: 16px;
}

@media ( max-width : 1024px) {
	.admin-card {
		grid-column: span 6;
	}
}

@media ( max-width : 640px) {
	.admin-card {
		grid-column: span 12;
	}
}
</style>

<!-- ======= Sidebar Markup ======= -->
<aside class="admin-sidebar" id="adminSidebar">
	<div class="admin-brand">
		<button class="admin-hamburger" type="button"
			onclick="adminToggleSidebar()" title="Thu gọn/mở rộng">☰</button>
		<div class="admin-badge">U</div>
		<div class="admin-title">UTEShop</div>
	</div>

	<ul class="admin-menu">
		<li><a class="<%=aHome ? "active" : ""%>" href="<%=ctx%>/admin/home"><span
				class="admin-ico">🏠</span><span class="admin-lbl">Bảng điều
					khiển</span></a></li>
		<li><a class="<%=aProducts ? "active" : ""%>"
			href="<%=ctx%>/admin/products"><span class="admin-ico">📦</span><span
				class="admin-lbl">Sản phẩm</span></a></li>
		<li><a class="<%=aOrders ? "active" : ""%>"
			href="<%=ctx%>/admin/orders"><span class="admin-ico">🧾</span><span
				class="admin-lbl">Đơn hàng</span></a></li>
		<li><a class="<%=aCustomers ? "active" : ""%>"
			href="<%=ctx%>/admin/customers"><span class="admin-ico">👥</span><span
				class="admin-lbl">Khách hàng</span></a></li>
		<li><a class="<%=aSuppliers ? "active" : ""%>"
			href="<%=ctx%>/admin/suppliers"><span class="admin-ico">🏪</span><span
				class="admin-lbl">Nhà cung cấp</span></a></li>
		<li><a class="<%=aCats ? "active" : ""%>"
			href="<%=ctx%>/admin/categories"><span class="admin-ico">🗂</span><span
				class="admin-lbl">Danh mục</span></a></li>
		<li><a class="<%=aShip ? "active" : ""%>"
			href="<%=ctx%>/admin/shipping"><span class="admin-ico">🚚</span><span
				class="admin-lbl">Vận chuyển</span></a></li>
		<li><a class="<%=aCoupons ? "active" : ""%>"
			href="<%=ctx%>/admin/coupons"><span class="admin-ico">🏷</span><span
				class="admin-lbl">Mã giảm giá</span></a></li>
		<li><a class="<%=aSettings ? "active" : ""%>"
			href="<%=ctx%>/admin/settings"><span class="admin-ico">⚙️</span><span
				class="admin-lbl">Cài đặt</span></a></li>
	</ul>
</aside>

<!-- ======= JS toggle + nhớ trạng thái ======= -->
<script>
	(function() {
		const KEY = 'admin.sidebar.collapsed';
		window.adminApplySidebar = function() {
			const sb = document.getElementById('adminSidebar');
			if (!sb)
				return;
			const collapsed = localStorage.getItem(KEY) === '1';
			sb.classList.toggle('collapsed', collapsed);
		};
		window.adminToggleSidebar = function() {
			const collapsed = localStorage.getItem(KEY) === '1';
			localStorage.setItem(KEY, collapsed ? '0' : '1');
			adminApplySidebar();
		};
		document.addEventListener('DOMContentLoaded', adminApplySidebar);
	})();
</script>
