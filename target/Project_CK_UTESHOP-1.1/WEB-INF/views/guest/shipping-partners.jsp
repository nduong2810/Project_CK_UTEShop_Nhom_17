<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đối tác vận chuyển - UTESHOP</title>
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .page-header {
            background: var(--gradient-primary);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            text-align: center;
        }

        .partner-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            text-align: center;
            min-height: 380px; /* Ensures consistent card height */
        }

        .partner-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.3);
        }

        .partner-header {
            padding: 2rem 2rem 1.5rem;
        }

        .partner-icon {
            width: 70px;
            height: 70px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.8rem;
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .partner-name {
            font-size: 1.3rem;
            font-weight: bold;
            margin: 0;
            color: #333;
        }

        .partner-body {
            padding: 1.5rem;
            flex-grow: 1;
            color: #6c757d;
        }

        .partner-footer {
            padding: 1.5rem;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
            margin-top: auto; /* Pushes footer to the bottom */
        }

        .partner-fee {
            font-size: 1.7rem;
            font-weight: 700;
            color: #667eea;
        }
        
        .fee-label {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 0.25rem;
            display: block;
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
        <h1><i class="fas fa-truck-fast me-2"></i>Đối Tác Vận Chuyển</h1>
        <p class="lead mb-0">Các đơn vị vận chuyển uy tín đồng hành cùng UTESHOP.</p>
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
            <div class="text-center py-5">
                <i class="fas fa-box-open fa-5x text-muted mb-4"></i>
                <h4 class="text-muted">Chưa có thông tin đối tác vận chuyển!</h4>
                <p class="text-muted">Chúng tôi đang cập nhật danh sách. Vui lòng quay lại sau.</p>
                <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary mt-3">
                    <i class="fas fa-home me-2"></i>Về Trang Chủ
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Partners Grid -->
            <div class="row g-4">
                <c:forEach var="partner" items="${shippingPartners}" varStatus="status">
                    <div class="col-lg-4 col-md-6 mb-4 fade-in-up" style="animation-delay: ${status.index * 0.05}s;">
                        <div class="partner-card">
                            <div class="partner-header">
                                <div class="partner-icon">
                                    <i class="fas fa-truck"></i>
                                </div>
                                <h3 class="partner-name">${partner.tenDonVi}</h3>
                            </div>
                            <div class="partner-body">
                                <p>Đối tác vận chuyển tin cậy, giao hàng nhanh chóng và an toàn trên toàn quốc.</p>
                            </div>
                            <div class="partner-footer">
                                <span class="fee-label">Phí vận chuyển tham khảo</span>
                                <div class="partner-fee">
                                    <fmt:formatNumber value="${partner.phiVanChuyen}" type="number" groupingUsed="true"/>₫
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Summary -->
            <div class="text-center mt-5">
                <p class="text-muted">
                    <i class="fas fa-info-circle me-2"></i>
                    Tổng số: <strong>${fn:length(shippingPartners)}</strong> đối tác vận chuyển.
                </p>
            </div>
        </c:otherwise>
    </c:choose>
</main>

</body>
</html>
