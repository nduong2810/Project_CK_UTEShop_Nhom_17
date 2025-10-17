<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết nhà cung cấp - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main-styles.css">
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-hot: linear-gradient(135deg, #ff6b6b 0%, #ffa726 100%);
        }
        
        .supplier-header {
            background: var(--gradient-primary);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
        }
        
        .supplier-info-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .product-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        
        .product-image-container {
            position: relative;
            overflow: hidden;
            height: 250px;
            background: #f8f9fa;
        }
        
        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .product-card:hover .product-image {
            transform: scale(1.1);
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
    <!-- Include Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <c:choose>
        <c:when test="${not empty supplier}">
            <!-- Supplier Header -->
            <div class="supplier-header">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-2 text-center">
                            <div style="width: 100px; height: 100px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                <i class="fas fa-store fa-3x" style="color: #667eea;"></i>
                            </div>
                        </div>
                        <div class="col-md-10">
                            <h1 class="mb-2">${supplier.tenCH}</h1>
                            <p class="lead mb-0">
                                <i class="fas fa-map-marker-alt me-2"></i>${supplier.diaChi}
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <main class="container mb-5">
                <!-- Supplier Info -->
                <div class="supplier-info-card">
                    <div class="row">
                        <div class="col-md-6">
                            <h5><i class="fas fa-info-circle me-2 text-primary"></i>Thông tin cửa hàng</h5>
                            <c:if test="${not empty supplier.moTa}">
                                <p class="text-muted mt-3">${supplier.moTa}</p>
                            </c:if>
                        </div>
                        <div class="col-md-6">
                            <h5><i class="fas fa-phone me-2 text-success"></i>Liên hệ</h5>
                            <div class="mt-3">
                                <c:if test="${not empty supplier.soDienThoai}">
                                    <p><i class="fas fa-phone-alt me-2"></i>${supplier.soDienThoai}</p>
                                </c:if>
                                <c:if test="${not empty supplier.email}">
                                    <p><i class="fas fa-envelope me-2"></i>${supplier.email}</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Products Section -->
                <section>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2><i class="fas fa-box me-2"></i>Sản phẩm của cửa hàng</h2>
                    </div>

                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="alert alert-info text-center py-5">
                                <i class="fas fa-box-open fa-3x mb-3"></i>
                                <h4>Chưa có sản phẩm</h4>
                                <p>Cửa hàng này chưa có sản phẩm nào.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <c:forEach var="sp" items="${products}" varStatus="status">
                                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4 fade-in-up" style="animation-delay: ${status.index * 0.1}s;">
                                        <div class="product-card">
                                            <!-- Product Image -->
                                            <div class="product-image-container">
                                                <img src="${pageContext.request.contextPath}/assets/img/${sp.hinhAnh}"
                                                     alt="${sp.tenSP}"
                                                     class="product-image"
                                                     onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
                                            </div>
                                            
                                            <!-- Product Info -->
                                            <div class="card-body p-3">
                                                <h6 class="card-title fw-bold mb-2" style="height: 48px; overflow: hidden;">
                                                    <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}" 
                                                       class="text-decoration-none text-dark">${sp.tenSP}</a>
                                                </h6>
                                                
                                                <!-- Price -->
                                                <div class="price mb-2">
                                                    <span class="h5 text-danger fw-bold">
                                                        <fmt:formatNumber value="${sp.donGia}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
                                                    </span>
                                                </div>
                                                
                                                <!-- Rating and Sales -->
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <div class="rating">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas fa-star text-warning"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <small class="text-muted">
                                                        <i class="fas fa-chart-line"></i> ${sp.soLuongBan}
                                                    </small>
                                                </div>
                                                
                                                <!-- Action Buttons -->
                                                <div class="d-grid">
                                                    <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}" 
                                                       class="btn btn-primary">
                                                        <i class="fas fa-eye me-2"></i>Xem chi tiết
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Product Count -->
                            <div class="text-center mt-4">
                                <p class="text-muted">
                                    Tổng số: <strong>${fn:length(products)}</strong> sản phẩm
                                </p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>
            </main>
        </c:when>
        <c:otherwise>
            <!-- Error Message -->
            <main class="container my-5">
                <div class="alert alert-danger text-center py-5">
                    <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                    <h4>Lỗi</h4>
                    <p>${errorMessage}</p>
                    <a href="${pageContext.request.contextPath}/guest/suppliers" class="btn btn-primary mt-3">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                    </a>
                </div>
            </main>
        </c:otherwise>
    </c:choose>

    <!-- Include Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>