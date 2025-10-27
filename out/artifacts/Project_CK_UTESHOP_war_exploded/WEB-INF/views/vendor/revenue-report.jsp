<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<style>
    .revenue-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 40px 0;
        margin-bottom: 30px;
        border-radius: 15px;
    }
    
    .filter-card {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        margin-bottom: 30px;
    }
    
    .filter-tabs {
        display: flex;
        gap: 15px;
        margin-bottom: 25px;
        border-bottom: 2px solid #e9ecef;
    }
    
    .filter-tab {
        padding: 12px 30px;
        border: none;
        background: transparent;
        color: #666;
        font-weight: 600;
        cursor: pointer;
        position: relative;
        transition: all 0.3s ease;
    }
    
    .filter-tab.active {
        color: #667eea;
    }
    
    .filter-tab.active::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 100%;
        height: 2px;
        background: #667eea;
    }
    
    .filter-content {
        display: none;
    }
    
    .filter-content.active {
        display: block;
    }
    
    .revenue-summary-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 15px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    }
    
    .revenue-table {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    }
    
    .revenue-chart-card {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        margin-bottom: 30px;
    }
    
    .btn-filter {
        background: linear-gradient(45deg, #667eea, #764ba2);
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-filter:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        color: white;
    }
</style>

<div class="container-fluid px-4">
    <!-- Header -->
    <div class="revenue-header">
        <div class="container">
            <h1 class="mb-2"><i class="fas fa-chart-line me-2"></i>Báo cáo Doanh thu</h1>
            <p class="mb-0 opacity-75">Xem chi tiết doanh thu theo ngày, tháng, năm</p>
        </div>
    </div>

    <!-- Filter Card -->
    <div class="filter-card">
        <div class="filter-tabs">
            <button class="filter-tab active" data-tab="daily">
                <i class="fas fa-calendar-day me-2"></i>Theo ngày
            </button>
            <button class="filter-tab" data-tab="monthly">
                <i class="fas fa-calendar-alt me-2"></i>Theo tháng
            </button>
            <button class="filter-tab" data-tab="yearly">
                <i class="fas fa-calendar me-2"></i>Theo năm
            </button>
        </div>

        <!-- Daily Filter -->
        <div class="filter-content active" id="daily">
            <form action="${pageContext.request.contextPath}/vendor/revenue-report" method="get">
                <input type="hidden" name="type" value="daily">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Ngày</label>
                        <input type="date" class="form-control" name="date" 
                               value="${param.date != null ? param.date : ''}" required>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-filter">
                            <i class="fas fa-search me-2"></i>Xem báo cáo
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Monthly Filter -->
        <div class="filter-content" id="monthly">
            <form action="${pageContext.request.contextPath}/vendor/revenue-report" method="get">
                <input type="hidden" name="type" value="monthly">
                <div class="row g-3 align-items-end">
                    <div class="col-md-2">
                        <label class="form-label fw-bold">Tháng</label>
                        <select class="form-select" name="month" required>
                            <c:forEach begin="1" end="12" var="m">
                                <option value="${m}" ${param.month == m ? 'selected' : ''}>Tháng ${m}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label fw-bold">Năm</label>
                        <select class="form-select" name="year" required>
                            <c:forEach begin="2020" end="2025" var="y">
                                <option value="${y}" ${param.year == y ? 'selected' : ''}>${y}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-filter">
                            <i class="fas fa-search me-2"></i>Xem báo cáo
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Yearly Filter -->
        <div class="filter-content" id="yearly">
            <form action="${pageContext.request.contextPath}/vendor/revenue-report" method="get">
                <input type="hidden" name="type" value="yearly">
                <div class="row g-3 align-items-end">
                    <div class="col-md-2">
                        <label class="form-label fw-bold">Năm</label>
                        <select class="form-select" name="year" required>
                            <c:forEach begin="2020" end="2025" var="y">
                                <option value="${y}" ${param.year == y ? 'selected' : ''}>${y}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-filter">
                            <i class="fas fa-search me-2"></i>Xem báo cáo
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Revenue Summary -->
    <c:if test="${revenue != null}">
        <div class="revenue-summary-card">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h3 class="mb-2">
                        <i class="fas fa-money-bill-wave me-2"></i>
                        <c:choose>
                            <c:when test="${param.type == 'daily'}">
                                Doanh thu ngày ${param.date}
                            </c:when>
                            <c:when test="${param.type == 'monthly'}">
                                Doanh thu tháng ${param.month}/${param.year}
                            </c:when>
                            <c:when test="${param.type == 'yearly'}">
                                Doanh thu năm ${param.year}
                            </c:when>
                        </c:choose>
                    </h3>
                    <h2 class="mb-0 fw-bold">
                        <fmt:formatNumber value="${revenue}" type="currency" currencyCode="VND" />
                    </h2>
                </div>
                <div class="col-md-4 text-end">
                    <div class="d-flex flex-column gap-2">
                        <span class="badge bg-light text-dark fs-6">
                            <i class="fas fa-store me-2"></i>${store.tenCH}
                        </span>
                        <span class="badge bg-light text-dark fs-6">
                            <i class="fas fa-clock me-2"></i>Cập nhật: <fmt:formatDate value="${now}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart -->
        <div class="revenue-chart-card">
            <h4 class="mb-4"><i class="fas fa-chart-bar me-2"></i>Biểu đồ doanh thu</h4>
            <div style="height: 400px;">
                <canvas id="revenueDetailChart"></canvas>
            </div>
        </div>
    </c:if>

    <c:if test="${revenue == null && param.type != null}">
        <div class="alert alert-warning">
            <i class="fas fa-info-circle me-2"></i>
            Không có dữ liệu doanh thu cho thời gian đã chọn.
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    // Tab switching
    document.querySelectorAll('.filter-tab').forEach(tab => {
        tab.addEventListener('click', function() {
            // Remove active class from all tabs
            document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.filter-content').forEach(c => c.classList.remove('active'));
            
            // Add active class to clicked tab
            this.classList.add('active');
            const tabId = this.dataset.tab;
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Show chart if revenue data exists
    <c:if test="${revenue != null}">
        const ctx = document.getElementById('revenueDetailChart');
        if (ctx) {
            new Chart(ctx.getContext('2d'), {
                type: 'bar',
                data: {
                    labels: ['Doanh thu'],
                    datasets: [{
                        label: 'VND',
                        data: [${revenue}],
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
                        legend: {
                            display: false
                        },
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
    </c:if>

    // Set active tab based on URL parameter
    const urlParams = new URLSearchParams(window.location.search);
    const activeType = urlParams.get('type');
    if (activeType) {
        document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.filter-content').forEach(c => c.classList.remove('active'));
        
        const activeTab = document.querySelector(`[data-tab="${activeType}"]`);
        const activeContent = document.getElementById(activeType);
        
        if (activeTab && activeContent) {
            activeTab.classList.add('active');
            activeContent.classList.add('active');
        }
    }
</script>
