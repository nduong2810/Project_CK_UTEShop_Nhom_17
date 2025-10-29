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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --warning-gradient: linear-gradient(135deg, #ff9f00 0%, #ffcc00 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }
        
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .stat-card.primary { border-left-color: #667eea; }
        .stat-card.success { border-left-color: #38ef7d; }
        .stat-card.warning { border-left-color: #ff9f00; }
        .stat-card.danger { border-left-color: #fa709a; }
        .stat-card.info { border-left-color: #4facfe; }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            margin-bottom: 15px;
        }
        
        .stat-icon.primary { background: var(--primary-gradient); }
        .stat-icon.success { background: var(--success-gradient); }
        .stat-icon.warning { background: var(--warning-gradient); }
        .stat-icon.danger { background: var(--danger-gradient); }
        .stat-icon.info { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        
        .stat-value {
            font-size: 32px;
            font-weight: bold;
            color: #2d3748;
            margin: 10px 0;
        }
        
        .stat-label {
            color: #718096;
            font-size: 14px;
            font-weight: 500;
        }
        
        .chart-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }
        
        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: #667eea;
        }
        
        .product-table {
            width: 100%;
        }
        
        .product-table th {
            background: #f7fafc;
            color: #4a5568;
            font-weight: 600;
            padding: 15px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .product-table td {
            padding: 15px;
            border-bottom: 1px solid #e2e8f0;
            vertical-align: middle;
        }
        
        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
        }
        
        .rank-badge {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: white;
        }
        
        .rank-1 { background: linear-gradient(135deg, #FFD700, #FFA500); }
        .rank-2 { background: linear-gradient(135deg, #C0C0C0, #808080); }
        .rank-3 { background: linear-gradient(135deg, #CD7F32, #8B4513); }
        .rank-other { background: linear-gradient(135deg, #667eea, #764ba2); }
        
        .progress-bar-custom {
            height: 8px;
            border-radius: 10px;
            background: #e2e8f0;
            overflow: hidden;
        }
        
        .progress-fill {
            height: 100%;
            background: var(--primary-gradient);
            border-radius: 10px;
            transition: width 0.3s ease;
        }
        
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid px-4 py-4">
        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-md-3 col-lg-2">
                <div class="bg-white rounded-3 shadow-sm p-3 mb-4">
                    <h6 class="text-muted mb-3">MENU</h6>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/vendor/dashboard" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/products" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-box me-2"></i> Sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/discounts" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-tags me-2"></i> Mã giảm giá
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/orders" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/statistics" class="list-group-item list-group-item-action border-0 active">
                            <i class="fas fa-chart-pie me-2"></i> Thống kê
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/settings" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-cog me-2"></i> Cài đặt
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
        <div class="page-header">
            <div class="container">
                <h1 class="mb-2">
                    <i class="fas fa-chart-pie me-2"></i>Thống kê & Báo cáo
                </h1>
                <p class="mb-0 opacity-75">Tổng quan hoạt động kinh doanh của cửa hàng ${store.tenCH}</p>
                <small class="opacity-75">
                    <i class="far fa-clock me-1"></i>Cập nhật: <fmt:formatDate value="${now}" pattern="dd/MM/yyyy HH:mm"/>
                </small>
            </div>
        </div>

        <!-- Revenue Statistics -->
        <div class="stats-grid">
            <div class="stat-card success">
                <div class="stat-icon success">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stat-value">
                    <fmt:formatNumber value="${dailyRevenue}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                </div>
                <div class="stat-label">Doanh thu hôm nay</div>
            </div>

            <div class="stat-card primary">
                <div class="stat-icon primary">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="stat-value">
                    <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                </div>
                <div class="stat-label">Doanh thu tháng ${currentMonth}/${currentYear}</div>
            </div>

            <div class="stat-card info">
                <div class="stat-icon info">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-value">
                    <fmt:formatNumber value="${yearlyRevenue}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                </div>
                <div class="stat-label">Doanh thu năm ${currentYear}</div>
            </div>
        </div>

        <!-- Order & Product Statistics -->
        <div class="stats-grid">
            <div class="stat-card warning">
                <div class="stat-icon warning">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-value">${newOrdersCount}</div>
                <div class="stat-label">Đơn hàng chờ xử lý</div>
            </div>

            <div class="stat-card primary">
                <div class="stat-icon primary">
                    <i class="fas fa-list-alt"></i>
                </div>
                <div class="stat-value">${totalOrders}</div>
                <div class="stat-label">Tổng đơn hàng</div>
            </div>

            <div class="stat-card success">
                <div class="stat-icon success">
                    <i class="fas fa-box"></i>
                </div>
                <div class="stat-value">${activeProducts}</div>
                <div class="stat-label">Sản phẩm đang bán</div>
            </div>

            <div class="stat-card danger">
                <div class="stat-icon danger">
                    <i class="fas fa-tags"></i>
                </div>
                <div class="stat-value">${activeDiscounts}</div>
                <div class="stat-label">Mã giảm giá hoạt động</div>
            </div>
        </div>



            <!-- Revenue Chart 12 Months -->
            <div class="col-12 mb-4">
                <div class="chart-section">
                    <h5 class="section-title">
                        <i class="fas fa-chart-bar"></i>
                        Doanh thu 12 tháng gần nhất
                    </h5>
                    <div style="height: 350px;">
                        <canvas id="revenue12MonthsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Top Selling Products -->
        <div class="chart-section">
            <h5 class="section-title">
                <i class="fas fa-fire"></i>
                Top 10 Sản phẩm bán chạy nhất
            </h5>
            
            <c:choose>
                <c:when test="${not empty topSellingProducts}">
                    <div class="table-responsive">
                        <table class="product-table">
                            <thead>
                                <tr>
                                    <th style="width: 80px;">Hạng</th>
                                    <th style="width: 80px;">Hình ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th style="width: 150px;">Giá bán</th>
                                    <th style="width: 150px;">Đã bán</th>
                                    <th style="width: 200px;">Tỷ lệ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="maxSold" value="${topSellingProducts[0][1]}"/>
                                <c:forEach items="${topSellingProducts}" var="item" varStatus="status">
                                    <c:set var="product" value="${item[0]}"/>
                                    <c:set var="soldQty" value="${item[1]}"/>
                                    <tr>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${status.index == 0}">
                                                    <span class="rank-badge rank-1">${status.index + 1}</span>
                                                </c:when>
                                                <c:when test="${status.index == 1}">
                                                    <span class="rank-badge rank-2">${status.index + 1}</span>
                                                </c:when>
                                                <c:when test="${status.index == 2}">
                                                    <span class="rank-badge rank-3">${status.index + 1}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="rank-badge rank-other">${status.index + 1}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.hinhAnh}">
                                                    <img src="${pageContext.request.contextPath}/assets/img/${product.hinhAnh}" 
                                                         alt="${product.tenSP}" class="product-img">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/assets/img/no-image.png" 
                                                         alt="No image" class="product-img">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <strong>${product.tenSP}</strong>
                                            <br>
                                            <small class="text-muted">SKU: ${product.maSP}</small>
                                        </td>
                                        <td>
                                            <strong class="text-primary">
                                                <fmt:formatNumber value="${product.donGia}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                                            </strong>
                                        </td>
                                        <td>
                                            <span class="badge bg-success fs-6">${soldQty} sản phẩm</span>
                                        </td>
                                        <td>
                                            <div class="progress-bar-custom">
                                                <div class="progress-fill" style="width: ${(soldQty / maxSold) * 100}%"></div>
                                            </div>
                                            <small class="text-muted mt-1 d-block">
                                                <fmt:formatNumber value="${(soldQty / maxSold) * 100}" maxFractionDigits="1"/>%
                                            </small>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        Chưa có dữ liệu sản phẩm bán chạy.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/vendor/revenue-report" class="btn btn-lg btn-primary me-2">
                <i class="fas fa-file-invoice-dollar me-2"></i>Xem báo cáo chi tiết
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    
    <script>
        // Prepare data for 7 days revenue chart
        const last7DaysLabels = [];
        const last7DaysData = [];
        <c:forEach items="${last7DaysRevenue}" var="dayData">
            last7DaysLabels.push('${dayData[0]}');
            last7DaysData.push(${dayData[1]});
        </c:forEach>

        // Revenue 7 Days Chart
        const revenue7DaysCtx = document.getElementById('revenue7DaysChart');
        if (revenue7DaysCtx) {
            new Chart(revenue7DaysCtx.getContext('2d'), {
                type: 'line',
                data: {
                    labels: last7DaysLabels,
                    datasets: [{
                        label: 'Doanh thu (VND)',
                        data: last7DaysData,
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#667eea',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5,
                        pointHoverRadius: 7
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return 'Doanh thu: ' + new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND'
                                    }).format(context.parsed.y);
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND',
                                        notation: 'compact'
                                    }).format(value);
                                }
                            }
                        }
                    }
                }
            });
        }

        // Order Status Chart
        const orderStatusCtx = document.getElementById('orderStatusChart');
        if (orderStatusCtx) {
            new Chart(orderStatusCtx.getContext('2d'), {
                type: 'doughnut',
                data: {
                    labels: ['Chờ xử lý', 'Đang giao', 'Đã giao', 'Đã hủy'],
                    datasets: [{
                        data: [
                            ${newOrdersCount},
                            ${orderStats['DANG_GIAO'] != null ? orderStats['DANG_GIAO'] : 0},
                            ${orderStats['DA_GIAO'] != null ? orderStats['DA_GIAO'] : 0},
                            ${orderStats['DA_HUY'] != null ? orderStats['DA_HUY'] : 0}
                        ],
                        backgroundColor: ['#ff9f00', '#4facfe', '#11998e', '#fa709a'],
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
                                padding: 15,
                                usePointStyle: true,
                                font: { size: 12 }
                            }
                        }
                    }
                }
            });
        }

        // Prepare data for 12 months revenue chart
        const last12MonthsLabels = [];
        const last12MonthsData = [];
        <c:forEach items="${last12MonthsRevenue}" var="monthData">
            last12MonthsLabels.push('Tháng ${monthData[1]}/${monthData[0]}');
            last12MonthsData.push(${monthData[2]});
        </c:forEach>

        // Revenue 12 Months Chart
        const revenue12MonthsCtx = document.getElementById('revenue12MonthsChart');
        if (revenue12MonthsCtx) {
            new Chart(revenue12MonthsCtx.getContext('2d'), {
                type: 'bar',
                data: {
                    labels: last12MonthsLabels,
                    datasets: [{
                        label: 'Doanh thu (VND)',
                        data: last12MonthsData,
                        backgroundColor: 'rgba(102, 126, 234, 0.8)',
                        borderColor: '#667eea',
                        borderWidth: 2,
                        borderRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return 'Doanh thu: ' + new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND'
                                    }).format(context.parsed.y);
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND',
                                        notation: 'compact'
                                    }).format(value);
                                }
                            }
                        }
                    }
                }
            });
        }

        console.log('Statistics page loaded successfully! 📊');
    </script>
</body>
</html>
