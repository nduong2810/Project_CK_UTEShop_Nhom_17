<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
    <title>Danh sách nhà cung cấp - UTESHOP</title>
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
        
        .store-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .store-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        
        .store-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
        }

        .store-rank {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(0,0,0,0.2);
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1rem;
            border: 2px solid white;
        }
        
        .store-icon {
            width: 80px;
            height: 80px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 2rem;
            color: #667eea;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .store-name {
            font-size: 1.3rem;
            font-weight: bold;
            margin: 0;
        }
        
        .store-body {
            padding: 1.5rem;
            flex-grow: 1;
        }
        
        .store-info {
            margin-bottom: 1rem;
        }
        
        .store-info i {
            color: #667eea;
            width: 20px;
        }
        
        .store-footer {
            padding: 1rem 1.5rem;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }
        
        .badge-featured {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--gradient-hot);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
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
                <i class="fas fa-store me-2"></i>Danh sách nhà cung cấp
            </h1>
            <p class="lead mb-0">
                Các nhà cung cấp uy tín, được sắp xếp theo mức độ phổ biến.
            </p>
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
            <c:when test="${empty suppliers}">
                <div class="text-center py-5">
                    <img src="https://res.cloudinary.com/dflh3p423/image/upload/v1716904322/uteshop/img/no-supplier_vbnxov.png" alt="Không có nhà cung cấp" class="img-fluid mb-4" style="max-width: 250px;">
                    <h4 class="text-muted">Ôi, chưa có nhà cung cấp nào!</h4>
                    <p class="text-muted">Có vẻ như chúng tôi đang cập nhật danh sách. Vui lòng quay lại sau nhé!</p>
                    <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-primary mt-3">
                        <i class="fas fa-home me-2"></i>Về Trang Chủ
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Suppliers Grid -->
                <div class="row g-4">
                    <c:forEach var="supplier" items="${suppliers}" varStatus="status">
                        <div class="col-lg-4 col-md-6 mb-4 fade-in-up" style="animation-delay: ${status.index * 0.1}s;">
                            <div class="store-card">
                                <div class="store-header">
                                    <span class="store-rank">${status.count}</span>
                                    
                                    <c:if test="${status.index < 3}">
                                        <span class="badge-featured">
                                            <i class="fas fa-star"></i> NỔI BẬT
                                        </span>
                                    </c:if>
                                    
                                    <div class="store-icon">
                                        <i class="fas fa-store"></i>
                                    </div>
                                    <h3 class="store-name">${supplier.tenCH}</h3>
                                </div>
                                
                                <div class="store-body">
                                    <c:if test="${not empty supplier.moTa}">
                                        <p class="text-muted mb-3">${fn:substring(supplier.moTa, 0, 100)}...</p>
                                    </c:if>
                                    
                                    <div class="store-info">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <small class="text-muted">${supplier.diaChi}</small>
                                    </div>
                                    
                                    <c:if test="${not empty supplier.soDienThoai}">
                                        <div class="store-info">
                                            <i class="fas fa-phone"></i>
                                            <small class="text-muted">${supplier.soDienThoai}</small>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${not empty supplier.email}">
                                        <div class="store-info">
                                            <i class="fas fa-envelope"></i>
                                            <small class="text-muted">${supplier.email}</small>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="store-footer">
                                    <a href="${pageContext.request.contextPath}/guest/supplier/detail?id=${supplier.maCH}" 
                                       class="btn btn-primary w-100">
                                        <i class="fas fa-eye me-2"></i>Xem sản phẩm
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Summary -->
                <div class="text-center mt-5">
                    <p class="text-muted">
                        <i class="fas fa-info-circle me-2"></i>
                        Tổng số: <strong>${fn:length(suppliers)}</strong> nhà cung cấp
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</body>