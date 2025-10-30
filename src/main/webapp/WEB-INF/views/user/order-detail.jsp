<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Đơn hàng #${order.maDH} - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .order-detail-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 15px;
        }
        
        .section-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .order-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        
        .order-status {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .status-CHO_XAC_NHAN { background: #fff3cd; color: #856404; }
        .status-DA_XAC_NHAN { background: #cfe2ff; color: #084298; }
        .status-DANG_CHUAN_BI { background: #e7f1ff; color: #0c63e4; }
        .status-DANG_GIAO { background: #cff4fc; color: #055160; }
        .status-DA_GIAO { background: #d1e7dd; color: #0f5132; }
        .status-HOAN_THANH { background: #d1e7dd; color: #0f5132; }
        .status-DA_HUY { background: #f8d7da; color: #842029; }
        .status-TRA_HANG { background: #fff3cd; color: #664d03; }
        .status-HOAN_TIEN { background: #cfe2ff; color: #084298; }
        
        .product-item {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .product-item:last-child {
            border-bottom: none;
        }
        
        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }
        
        .product-info {
            flex: 1;
        }
        
        .product-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 1.1rem;
        }
        
        .product-quantity {
            color: #666;
            margin-bottom: 5px;
        }
        
        .product-price {
            font-weight: 600;
            color: #667eea;
            font-size: 1.2rem;
        }
        
        .total-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            position: sticky;
            top: 20px;
        }
        
        .total-summary h5 {
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .summary-row:last-child {
            border-bottom: none;
            font-size: 1.3rem;
            font-weight: 700;
            color: #667eea;
            padding-top: 15px;
            margin-top: 10px;
            border-top: 2px solid #667eea;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
        }
        
        .info-value {
            color: #333;
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-back:hover {
            background: #5568d3;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="order-detail-container">
        <!-- Breadcrumbs -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/orders">Đơn hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết #${order.maDH}</li>
            </ol>
        </nav>

        <div class="row">
            <!-- Left Column - Order Details -->
            <div class="col-lg-8">
                <!-- Order Header -->
                <div class="section-card">
                    <div class="order-header">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div>
                                <h3 class="mb-2">
                                    <i class="fas fa-receipt me-2"></i>Đơn hàng #${order.maDH}
                                </h3>
                                <p class="text-muted mb-0">
                                    <i class="far fa-calendar me-1"></i>
                                    Đặt ngày: <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                            </div>
                            <span class="order-status status-${order.trangThai}">
                                <c:choose>
                                    <c:when test="${order.trangThai == 'CHO_XAC_NHAN'}">CHỜ XÁC NHẬN</c:when>
                                    <c:when test="${order.trangThai == 'DA_XAC_NHAN'}">ĐÃ XÁC NHẬN</c:when>
                                    <c:when test="${order.trangThai == 'DANG_CHUAN_BI'}">ĐANG CHUẨN BỊ</c:when>
                                    <c:when test="${order.trangThai == 'DANG_GIAO'}">ĐANG GIAO HÀNG</c:when>
                                    <c:when test="${order.trangThai == 'DA_GIAO'}">ĐÃ GIAO</c:when>
                                    <c:when test="${order.trangThai == 'HOAN_THANH'}">HOÀN THÀNH</c:when>
                                    <c:when test="${order.trangThai == 'DA_HUY'}">ĐÃ HỦY</c:when>
                                    <c:when test="${order.trangThai == 'TRA_HANG'}">TRẢ HÀNG</c:when>
                                    <c:when test="${order.trangThai == 'HOAN_TIEN'}">HOÀN TIỀN</c:when>
                                    <c:otherwise>${order.trangThai}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    
                    <!-- Shipping Address -->
                    <div class="mb-4">
                        <h5 class="mb-3">
                            <i class="fas fa-map-marker-alt me-2"></i>Địa chỉ giao hàng
                        </h5>
                        <div class="info-row">
                            <span class="info-label">Người nhận:</span>
                            <span class="info-value">${order.tenNguoiNhan}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Số điện thoại:</span>
                            <span class="info-value">${order.soDienThoaiNhanHang}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Địa chỉ:</span>
                            <span class="info-value">${order.diaChiGiaoHang}</span>
                        </div>
                    </div>
                    
                    <!-- Payment Method -->
                    <div class="mb-4">
                        <h5 class="mb-3">
                            <i class="fas fa-credit-card me-2"></i>Phương thức thanh toán
                        </h5>
                        <div class="info-row">
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${order.phuongThucThanhToan == 'COD'}">
                                        <i class="fas fa-money-bill-wave me-2"></i>Thanh toán khi nhận hàng (COD)
                                    </c:when>
                                    <c:when test="${order.phuongThucThanhToan == 'BANK_TRANSFER'}">
                                        <i class="fas fa-university me-2"></i>Chuyển khoản Ngân hàng
                                    </c:when>
                                    <c:when test="${order.phuongThucThanhToan == 'MOMO'}">
                                        <i class="fab fa-cc-amazon-pay me-2"></i>Ví MoMo
                                    </c:when>
                                    <c:otherwise>${order.phuongThucThanhToan}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    
                    <!-- Note -->
                    <c:if test="${not empty order.ghiChu}">
                        <div class="mb-4">
                            <h5 class="mb-3">
                                <i class="fas fa-comment me-2"></i>Ghi chú
                            </h5>
                            <div class="alert alert-info mb-0">
                                ${order.ghiChu}
                            </div>
                        </div>
                    </c:if>
                </div>
                
                <!-- Products -->
                <div class="section-card">
                    <h5 class="mb-4">
                        <i class="fas fa-box me-2"></i>Sản phẩm trong đơn hàng
                    </h5>
                    
                    <c:forEach var="item" items="${order.chiTietDonHangs}">
                        <div class="product-item">
                            <c:choose>
                                <c:when test="${not empty item.sanPham.hinhAnh}">
                                    <img src="${pageContext.request.contextPath}/assets/img/products/${item.sanPham.hinhAnh}" 
                                         alt="${item.sanPham.tenSP}" class="product-image"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
                                </c:when>
                                <c:otherwise>
                                    <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                        <i class="fas fa-image text-muted fa-2x"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="product-info">
                                <div class="product-name">${item.sanPham.tenSP}</div>
                                <div class="product-quantity">
                                    <i class="fas fa-cube me-1"></i>Số lượng: ${item.soLuong}
                                </div>
                                <div class="text-muted">
                                    <i class="fas fa-store me-1"></i>${item.sanPham.cuaHang.tenCH}
                                </div>
                                <c:if test="${order.trangThai == 'HOAN_THANH'}">
                                    <div class="mt-2">
                                        <button class="btn btn-sm btn-outline-warning" 
                                                onclick="openReviewModal(${item.sanPham.maSP}, '${item.sanPham.tenSP}', ${order.maDH})">
                                            <i class="fas fa-star me-1"></i>Đánh giá sản phẩm
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                            <div class="text-end">
                                <div class="text-muted mb-1">
                                    <fmt:formatNumber value="${item.donGia}" type="number" groupingUsed="true"/>₫
                                </div>
                                <div class="product-price">
                                    <fmt:formatNumber value="${item.donGia * item.soLuong}" type="number" groupingUsed="true"/>₫
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <!-- Right Column - Order Summary -->
            <div class="col-lg-4">
                <div class="total-summary">
                    <h5>
                        <i class="fas fa-calculator me-2"></i>Tổng kết đơn hàng
                    </h5>
                    
                    <div class="summary-row">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${order.tongTien}" type="number" groupingUsed="true"/>₫</span>
                    </div>
                    
                    <c:if test="${not empty order.tienGiam and order.tienGiam > 0}">
                        <div class="summary-row text-warning">
                            <span><i class="fas fa-tag me-1"></i>Giảm giá:</span>
                            <span class="fw-bold">-<fmt:formatNumber value="${order.tienGiam}" type="number" groupingUsed="true"/>₫</span>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty order.phiVanChuyen}">
                        <div class="summary-row">
                            <span><i class="fas fa-shipping-fast me-1"></i>Phí vận chuyển:</span>
                            <span><fmt:formatNumber value="${order.phiVanChuyen}" type="number" groupingUsed="true"/>₫</span>
                        </div>
                    </c:if>
                    
                    <div class="summary-row">
                        <span>Tổng thanh toán:</span>
                        <span><fmt:formatNumber value="${order.tongThanhToan}" type="number" groupingUsed="true"/>₫</span>
                    </div>
                    
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/user/orders" class="btn-back w-100 text-center">
                            <i class="fas fa-arrow-left"></i>
                            Quay lại danh sách đơn hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Review Modal -->
    <div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="reviewModalLabel">Đánh giá sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="reviewForm" action="${pageContext.request.contextPath}/user/submit-review" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="productId" id="reviewProductId">
                        <input type="hidden" name="orderId" id="reviewOrderId">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold" id="reviewProductName"></label>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Đánh giá của bạn <span class="text-danger">*</span></label>
                            <div class="rating-stars d-flex justify-content-center gap-2" style="font-size: 2rem;">
                                <i class="fas fa-star star-icon" data-rating="1"></i>
                                <i class="fas fa-star star-icon" data-rating="2"></i>
                                <i class="fas fa-star star-icon" data-rating="3"></i>
                                <i class="fas fa-star star-icon" data-rating="4"></i>
                                <i class="fas fa-star star-icon" data-rating="5"></i>
                            </div>
                            <input type="hidden" name="rating" id="ratingValue" required>
                            <div class="text-center mt-2 text-muted" id="ratingText">Chọn số sao</div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="reviewText" class="form-label fw-bold">Nhận xét của bạn</label>
                            <textarea class="form-control" id="reviewText" name="reviewText" rows="4" 
                                      placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
                        </div>
                        

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-warning">
                            <i class="fas fa-paper-plane me-1"></i>Gửi đánh giá
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Rating stars functionality
        const stars = document.querySelectorAll('.star-icon');
        const ratingValue = document.getElementById('ratingValue');
        const ratingText = document.getElementById('ratingText');
        let currentRating = 0;

        const ratingTexts = {
            1: 'Rất không hài lòng',
            2: 'Không hài lòng',
            3: 'Bình thường',
            4: 'Hài lòng',
            5: 'Rất hài lòng'
        };

        stars.forEach(star => {
            star.addEventListener('click', function() {
                currentRating = parseInt(this.getAttribute('data-rating'));
                ratingValue.value = currentRating;
                updateStars(currentRating);
                ratingText.textContent = ratingTexts[currentRating];
            });

            star.addEventListener('mouseenter', function() {
                const hoverRating = parseInt(this.getAttribute('data-rating'));
                updateStars(hoverRating);
            });
        });

        document.querySelector('.rating-stars').addEventListener('mouseleave', function() {
            updateStars(currentRating);
        });

        function updateStars(rating) {
            stars.forEach(star => {
                const starRating = parseInt(star.getAttribute('data-rating'));
                if (starRating <= rating) {
                    star.style.color = '#ffc107';
                } else {
                    star.style.color = '#e4e5e9';
                }
            });
        }

        function openReviewModal(productId, productName, orderId) {
            // Reset form
            document.getElementById('reviewForm').reset();
            currentRating = 0;
            updateStars(0);
            ratingText.textContent = 'Chọn số sao';
            
            // Set product info
            document.getElementById('reviewProductId').value = productId;
            document.getElementById('reviewOrderId').value = orderId;
            document.getElementById('reviewProductName').textContent = productName;
            
            // Check if already reviewed
            fetch('${pageContext.request.contextPath}/user/check-review?productId=' + productId + '&orderId=' + orderId)
                .then(response => response.json())
                .then(data => {
                    if (data.hasReviewed) {
                        alert('Bạn đã đánh giá sản phẩm này rồi!');
                    } else {
                        const modal = new bootstrap.Modal(document.getElementById('reviewModal'));
                        modal.show();
                    }
                })
                .catch(error => {
                    console.error('Error checking review:', error);
                    const modal = new bootstrap.Modal(document.getElementById('reviewModal'));
                    modal.show();
                });
        }

        // Form validation
        document.getElementById('reviewForm').addEventListener('submit', function(e) {
            if (!ratingValue.value) {
                e.preventDefault();
                alert('Vui lòng chọn số sao đánh giá!');
                return false;
            }
        });

        // Show success/error messages
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'reviewed') {
            alert('Đánh giá của bạn đã được gửi thành công!');
            // Remove parameter from URL
            window.history.replaceState({}, document.title, window.location.pathname + '?id=${order.maDH}');
        } else if (urlParams.get('error') === 'already_reviewed') {
            alert('Bạn đã đánh giá sản phẩm này rồi!');
            window.history.replaceState({}, document.title, window.location.pathname + '?id=${order.maDH}');
        } else if (urlParams.get('error') === 'not_completed') {
            alert('Chỉ có thể đánh giá sản phẩm khi đơn hàng đã hoàn thành!');
            window.history.replaceState({}, document.title, window.location.pathname + '?id=${order.maDH}');
        }

        // Handle redirect from review button in orders page
        if (urlParams.get('fromReview') === 'true') {
            // Show notification banner
            const productSection = document.querySelector('.section-card:has(.product-item)');
            if (productSection) {
                const banner = document.createElement('div');
                banner.className = 'alert alert-info alert-dismissible fade show mb-3';
                banner.style.cssText = 'animation: slideDown 0.5s ease-out;';
                banner.innerHTML = '<i class="fas fa-star me-2"></i><strong>Đánh giá sản phẩm:</strong> Click vào nút "Đánh giá sản phẩm" bên dưới để đánh giá từng sản phẩm trong đơn hàng này.<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                productSection.insertBefore(banner, productSection.firstChild);

                // Scroll to product section
                setTimeout(() => {
                    productSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }, 100);

                // Highlight review buttons
                const reviewButtons = document.querySelectorAll('button[onclick^="openReviewModal"]');
                reviewButtons.forEach(btn => {
                    btn.classList.add('pulse-animation');
                    btn.style.cssText = 'animation: pulse 2s infinite;';
                });

                // Stop animation after 6 seconds
                setTimeout(() => {
                    reviewButtons.forEach(btn => {
                        btn.classList.remove('pulse-animation');
                        btn.style.animation = '';
                    });
                }, 6000);
            }

            // Remove fromReview parameter from URL
            window.history.replaceState({}, document.title, window.location.pathname + '?id=${order.maDH}');
        }
    </script>
    <style>
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes pulse {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(255, 193, 7, 0.7);
            }
            50% {
                box-shadow: 0 0 0 10px rgba(255, 193, 7, 0);
            }
        }
    </style>
</body>
</html>
