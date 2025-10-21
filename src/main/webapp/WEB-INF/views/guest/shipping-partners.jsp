<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
    <title>${pageTitle} - UTESHOP</title>
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-hot: linear-gradient(135deg, #ff6b6b 0%, #ffa726 100%);
        }
        
        .page-header {
            background: var(--gradient-primary);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .shipping-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .shipping-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .shipping-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 2rem auto 1rem;
            font-size: 3rem;
            color: white;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        
        .shipping-name {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        
        .shipping-fee {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 1rem;
        }
        
        .fade-in-up {
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s forwards;
        }
        
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1>
                <i class="fas fa-truck me-2"></i>${pageTitle}
            </h1>
            <p class="lead mb-0">Các đơn vị vận chuyển uy tín đối tác với UTESHOP</p>
        </div>
    </div>

    <!-- Main Content -->
    <main class="container mb-5">
        <c:choose>
            <c:when test="${not empty errorMessage}">
                <div class="alert alert-danger text-center py-5">
                    <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                    <h4>Đã xảy ra lỗi</h4>
                    <p>${errorMessage}</p>
                </div>
            </c:when>
            <c:when test="${empty shippingPartners}">
                <div class="alert alert-warning text-center py-5">
                    <i class="fas fa-truck-loading fa-3x mb-3"></i>
                    <h4>Chưa có đối tác vận chuyển</h4>
                    <p>Hiện tại chưa có đối tác vận chuyển nào trong hệ thống.</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Shipping Partners Grid -->
                <div class="row g-4 mb-5">
                    <c:forEach var="partner" items="${shippingPartners}" varStatus="status">
                        <div class="col-lg-4 col-md-6 mb-4 fade-in-up" style="animation-delay: ${status.index * 0.1}s;">
                            <div class="shipping-card text-center p-4">
                                <div class="shipping-icon">
                                    <i class="fas fa-shipping-fast"></i>
                                </div>
                                
                                <h3 class="shipping-name">${partner.tenDonVi}</h3>
                                
                                <div class="shipping-fee">
                                    <fmt:formatNumber value="${partner.phiVanChuyen}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                                </div>
                                
                                <p class="text-muted mb-3">Phí vận chuyển tiêu chuẩn</p>
                                
                                <div class="d-flex justify-content-center gap-2 mb-3">
                                    <span class="badge bg-success">
                                        <i class="fas fa-check me-1"></i>Uy tín
                                    </span>
                                    <span class="badge bg-info">
                                        <i class="fas fa-clock me-1"></i>Nhanh chóng
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Info Section -->
                <div class="row mt-5">
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="text-center p-4">
                            <div class="mb-3">
                                <i class="fas fa-shield-alt fa-3x text-primary"></i>
                            </div>
                            <h5>An toàn & Bảo mật</h5>
                            <p class="text-muted">Hàng hóa được bảo hiểm toàn diện trong quá trình vận chuyển</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="text-center p-4">
                            <div class="mb-3">
                                <i class="fas fa-clock fa-3x text-success"></i>
                            </div>
                            <h5>Giao hàng nhanh</h5>
                            <p class="text-muted">Cam kết giao hàng trong 2-5 ngày làm việc</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="text-center p-4">
                            <div class="mb-3">
                                <i class="fas fa-headset fa-3x text-warning"></i>
                            </div>
                            <h5>Hỗ trợ 24/7</h5>
                            <p class="text-muted">Đội ngũ hỗ trợ luôn sẵn sàng giải đáp thắc mắc</p>
                        </div>
                    </div>
                </div>
                
                <!-- Summary -->
                <div class="text-center mt-4">
                    <p class="text-muted">
                        <i class="fas fa-info-circle me-2"></i>
                        Tổng số: <strong>${fn:length(shippingPartners)}</strong> đối tác vận chuyển
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</body>