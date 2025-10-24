<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
:root {
	--bd: #e5e7eb;
	--bg: #f5f7fb;
	--card: #fff;
	--muted: #6b7280;
	--primary: #0b57d0;
	--r: 12px
}

.admin-content {
	flex: 1;
	min-width: 0;
	background: var(--bg)
}

.wrap {
	padding: 16px
}

.title {
	font-weight: 700;
	font-size: 20px;
	margin: 8px 0 4px
}

.sub {
	color: var(--muted);
	font-size: 13px;
	margin-bottom: 16px
}

.grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 16px
}

.panel {
	background: var(--card);
	border: 1px solid var(--bd);
	border-radius: var(--r)
}

.panel-hd {
	padding: 12px 16px;
	border-bottom: 1px solid var(--bd);
	font-weight: 700
}

.panel-bd {
	padding: 12px 16px;
	display: flex;
	flex-direction: column;
	gap: 10px
}

.input, .select {
	height: 36px;
	padding: 0 10px;
	border: 1px solid var(--bd);
	border-radius: 8px;
	background: #fff
}

.btn {
	height: 36px;
	padding: 0 12px;
	border: 1px solid var(--bd);
	border-radius: 8px;
	background: #fff;
	cursor: pointer
}

.btn-primary {
	background: var(--primary);
	color: #fff;
	border-color: transparent
}

.muted {
	color: var(--muted)
}
</style>

<div class="admin-shell">
	<%@ include file="/WEB-INF/views/admin/sidebar.jsp"%>
	<main class="admin-content">
		<div class="wrap">
			<div class="title">Cài đặt hệ thống</div>
			<div class="sub">Cấu hình chung c