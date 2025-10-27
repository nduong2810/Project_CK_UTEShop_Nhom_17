<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - UTESHOP Vendor</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            top: -100px;
            left: -100px;
            animation: float 20s ease-in-out infinite;
            z-index: -1;
        }
        
        .hero-section::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            bottom: -150px;
            right: -150px;
            animation: float 25s ease-in-out infinite;
            animation-delay: -5s;
            z-index: -1;
        }
        
        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            25% {
                transform: translateY(-30px) rotate(90deg);
            }
            50% {
                transform: translateY(0) rotate(180deg);
            }
            75% {
                transform: translateY(30px) rotate(270deg);
            }
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .hero-section h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        }
        
        .hero-section .lead {
            font-size: 1.2rem;
            opacity: 0.9;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.2);
        }
        
        .store-info {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            margin-top: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        /* Statistics Cards */
        .stats-section {
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            border: none;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            height: 100%;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            z-index: -1;
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .stat-card.success::before {
            background: linear-gradient(90deg, #11998e, #38ef7d);
        }
        
        .stat-card.warning::before {
            background: linear-gradient(90deg, #ff9f00, #ff5f00);
        }
        
        .stat-card.info::before {
            background: linear-gradient(90deg, #4facfe, #00f2fe);
        }
        
        .stat-card.danger::before {
            background: linear-gradient(90deg, #fa709a, #fee140);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin-bottom: 20px;
        }
        
        .stat-icon.success {
            background: linear-gradient(45deg, #11998e, #38ef7d);
        }
        
        .stat-icon.warning {
            background: linear-gradient(45deg, #ff9f00, #ff5f00);
        }
        
        .stat-icon.info {
            background: linear-gradient(45deg, #4facfe, #00f2fe);
        }
        
        .stat-icon.danger {
            background: linear-gradient(45deg, #fa709a, #fee140);
        }
        
        .stat-icon.primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
        }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            line-height: 1;
        }
        
        .stat-label {
            font-size: 1rem;
            color: #666;
            font-weight: 500;
            margin-bottom: 15px;
        }
        
        .stat-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }
        
        .stat-link:hover {
            color: #764ba2;
        }
        
        .stat-link i {
            margin-left: 5px;
            transition: transform 0.3s ease;
        }
        
        .stat-link:hover i {
            transform: translateX(3px);
        }
        
        /* Charts Section */
        .chart-section {
            margin-bottom: 40px;
        }
        
        .chart-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            border: none;
        }
        
        .chart-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .chart-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin: 0;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
        }
        
        /* Quick Actions */
        .quick-actions {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        
        .action-btn {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            margin: 5px;
        }
        
        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .action-btn.success {
            background: linear-gradient(45deg, #11998e, #38ef7d);
        }
        
        .action-btn.success:hover {
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.4);
        }
        
        .action-btn.warning {
            background: linear-gradient(45deg, #ff9f00, #ff5f00);
        }
        
        .action-btn.warning:hover {
            box-shadow: 0 8px 20px rgba(255, 159, 0, 0.4);
        }
        
        /* Recent Orders Table */
        .orders-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: #667eea;
        }
        
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            background: #f8f9fa;
            border: none;
            font-weight: 600;
            color: #333;
            padding: 15px;
        }
        
        .table td {
            border: none;
            padding: 15px;
            vertical-align: middle;
        }
        
        .table tbody tr {
            border-bottom: 1px solid #eee;
            transition: background-color 0.3s ease;
        }
        
        .table tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .badge {
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.8rem;
        }
        
        /* Animations */
        .fade-in-up {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.6s ease, transform 0.6s ease;
        }
        
        .fade-in-up.is-visible {
            opacity: 1;
            transform: translateY(0);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2rem;
            }
            
            .hero-section .lead {
                font-size: 1rem;
            }
            
            .stat-value {
                font-size: 2rem;
            }
            
            .action-btn {
                padding: 12px 20px;
                font-size: 0.9rem;
            }
        }
        
        /* Welcome Animation */
        @keyframes welcomeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .welcome-animation {
            animation: welcomeIn 0.8s ease-out;
        }
    </style>
</head>
<body>

    <!-- Hero Section -->
    <section class="hero-section welcome-animation">
        <div class="container">
            <div class="hero-content text-center">
                <h1><i class="fas fa-tachometer-alt me-3"></i>Dashboard Vendor</h1>
                <p class="lead">Quản lý cửa hàng và theo dõi hiệu suất kinh doanh</p>
                
                <div class="store-info">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4 class="mb-2"><i class="fas fa-store me-2"></i>${store.tenCH}</h4>
                            <p class="mb-0">Xin chào, <strong>${user.hoTen}</strong> (${user.vaiTro})</p>
                        </div>
                        <div class="col-md-4 text-md-end mt-3 mt-md-0">
                            <div class="d-flex justify-content-center justify-content-md-end gap-2">
                                <span class="badge bg-light text-dark">
                                    <i class="fas fa-calendar me-1"></i>
                                    <fmt:formatDate value="${now}" pattern="dd/MM/yyyy"/>
                                </span>
                                <span class="badge bg-light text-dark">
                                    <i class="fas fa-clock me-1"></i>
                                    <span id="currentTime"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="container-fluid px-4">
        <!-- Statistics Cards -->
        <section class="stats-section">
            <div class="row g-4">
                <!-- Doanh thu tháng -->
                <div class="col-lg-3 col-md-6 fade-in-up">
                    <div class="stat-card success">
                        <div class="stat-icon success">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencyCode="VND" />
                        </div>
                        <div class="stat-label">Doanh thu tháng này</div>
                        <a href="${pageContext.request.contextPath}/vendor/orders?status=delivered" class="stat-link">
                            Xem chi tiết <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Đơn hàng mới -->
                <div class="col-lg-3 col-md-6 fade-in-up">
                    <div class="stat-card warning">
                        <div class="stat-icon warning">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <div class="stat-value">${newOrdersCount}</div>
                        <div class="stat-label">Đơn hàng chờ xác nhận</div>
                        <a href="${pageContext.request.contextPath}/vendor/orders?status=pending" class="stat-link">
                            Xem đơn hàng <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Tổng sản phẩm -->
                <div class="col-lg-3 col-md-6 fade-in-up">
                    <div class="stat-card info">
                        <div class="stat-icon info">
                            <i class="fas fa-box"></i>
                        </div>
                        <div class="stat-value">${totalProducts}</div>
                        <div class="stat-label">Tổng số sản phẩm</div>
                        <a href="${pageContext.request.contextPath}/vendor/products" class="stat-link">
                            Quản lý sản phẩm <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Tổng đơn hàng -->
                <div class="col-lg-3 col-md-6 fade-in-up">
                    <div class="stat-card primary">
                        <div class="stat-icon primary">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="stat-value">${totalOrders != null ? totalOrders : 0}</div>
                        <div class="stat-label">Tổng đơn hàng</div>
                        <a href="${pageContext.request.contextPath}/vendor/orders" class="stat-link">
                            Xem tất cả <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Quick Actions -->
        <section class="quick-actions fade-in-up">
            <h3 class="section-title">
                <i class="fas fa-bolt"></i>
                Thao tác nhanh
            </h3>
            <div class="d-flex flex-wrap gap-2">
                <a href="${pageContext.request.contextPath}/vendor/product-crud" class="action-btn success">
                    <i class="fas fa-plus"></i>
                    Thêm sản phẩm mới
                </a>
                <a href="${pageContext.request.contextPath}/vendor/orders" class="action-btn warning">
                    <i class="fas fa-list-alt"></i>
                    Quản lý đơn hàng
                </a>
                <a href="${pageContext.request.contextPath}/vendor/products" class="action-btn">
                    <i class="fas fa-boxes"></i>
                    Quản lý kho
                </a>
                <a href="${pageContext.request.contextPath}/vendor/settings" class="action-btn">
                    <i class="fas fa-cog"></i>
                    Cài đặt cửa hàng
                </a>
            </div>
        </section>

        <!-- Charts Row -->
        <div class="row g-4 chart-section">
            <!-- Revenue Chart -->
            <div class="col-lg-8 fade-in-up">
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">
                            <i class="fas fa-chart-area me-2"></i>
                            Biểu đồ doanh thu 7 ngày qua
                        </h3>
                    </div>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Order Status Chart -->
            <div class="col-lg-4 fade-in-up">
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">
                            <i class="fas fa-chart-pie me-2"></i>
                            Trạng thái đơn hàng
                        </h3>
                    </div>
                    <div class="chart-container">
                        <canvas id="orderStatusChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Orders -->
        <section class="orders-section fade-in-up">
            <h3 class="section-title">
                <i class="fas fa-shopping-cart"></i>
                Đơn hàng chờ xử lý
            </h3>
            
            <c:choose>
                <c:when test="${newOrdersCount > 0}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        Bạn có <strong>${newOrdersCount}</strong> đơn hàng cần xác nhận. 
                        <a href="${pageContext.request.contextPath}/vendor/orders" class="alert-link">Xem tất cả</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>
                        Tuyệt vời! Hiện tại không có đơn hàng nào cần xử lý.
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/vendor/orders" class="action-btn">
                    <i class="fas fa-list"></i>
                    Xem tất cả đơn hàng
                </a>
            </div>
        </section>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Current time display
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString('vi-VN');
            document.getElementById('currentTime').textContent = timeString;
        }
        
        // Update time every second
        setInterval(updateTime, 1000);
        updateTime();

        // Fade in animation
        document.addEventListener('DOMContentLoaded', function() {
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('is-visible');
                    }
                });
            }, { threshold: 0.1 });

            document.querySelectorAll('.fade-in-up').forEach(el => {
                observer.observe(el);
            });
        });

        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        const revenueChart = new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ['6 ngày trước', '5 ngày trước', '4 ngày trước', '3 ngày trước', '2 ngày trước', 'Hôm qua', 'Hôm nay'],
                datasets: [{
                    label: 'Doanh thu (VND)',
                    data: [1200000, 1500000, 800000, 2000000, 1800000, 2200000, 1600000],
                    borderColor: '#667eea',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return new Intl.NumberFormat('vi-VN', {
                                    style: 'currency',
                                    currency: 'VND'
                                }).format(value);
                            }
                        }
                    }
                }
            }
        });

        // Order Status Chart
        const orderStatusCtx = document.getElementById('orderStatusChart').getContext('2d');
        const orderStatusChart = new Chart(orderStatusCtx, {
            type: 'doughnut',
            data: {
                labels: ['Chờ xác nhận', 'Đang giao', 'Đã giao', 'Đã hủy'],
                datasets: [{
                    data: [${newOrdersCount}, 5, 20, 2],
                    backgroundColor: [
                        '#ff9f00',
                        '#4facfe',
                        '#11998e',
                        '#fa709a'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    }
                }
            }
        });

        console.log('UTESHOP Vendor Dashboard loaded successfully! 🎉');
    </script>
</body>
</html>
