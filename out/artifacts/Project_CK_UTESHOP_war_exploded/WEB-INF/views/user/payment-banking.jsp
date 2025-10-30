<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .payment-container {
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: slideUp 0.5s ease;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .payment-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .payment-header h2 {
            margin: 0;
            font-size: 2rem;
            font-weight: 700;
        }
        
        .payment-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
        }
        
        .payment-body {
            padding: 40px;
        }
        
        .payment-method-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }
        
        .store-section {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            border: 2px solid #e9ecef;
        }
        
        .store-name {
            color: #667eea;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .payment-info-table {
            width: 100%;
            margin-bottom: 20px;
        }
        
        .payment-info-table td {
            padding: 12px 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .payment-info-table td:first-child {
            font-weight: 600;
            color: #555;
            width: 150px;
        }
        
        .payment-info-table td:last-child {
            color: #333;
            font-size: 1.05rem;
        }
        
        .copy-btn {
            padding: 6px 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-left: 10px;
            transition: all 0.3s;
        }
        
        .copy-btn:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        
        .qr-container {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-top: 20px;
        }
        
        .qr-container img {
            max-width: 300px;
            width: 100%;
            border: 3px solid #667eea;
            border-radius: 12px;
            padding: 10px;
        }
        
        .qr-container p {
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }
        
        .alert-info-custom {
            background: #cfe2ff;
            border: 2px solid #9ec5fe;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
        }
        
        .alert-info-custom i {
            color: #0d6efd;
            font-size: 1.5rem;
            margin-right: 10px;
        }
        
        .order-summary {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            border-radius: 15px;
            padding: 25px;
            margin: 30px 0;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .summary-row:last-child {
            border-bottom: none;
            font-size: 1.4rem;
            font-weight: 700;
            color: #667eea;
            padding-top: 20px;
            margin-top: 10px;
            border-top: 2px solid #667eea;
        }
        
        .btn-confirm-payment {
            width: 100%;
            padding: 18px;
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.3rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-confirm-payment:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(40, 167, 69, 0.4);
        }
        
        .btn-cancel {
            width: 100%;
            padding: 15px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn-cancel:hover {
            background: #5a6268;
        }
        
        .countdown {
            text-align: center;
            margin: 20px 0;
            padding: 15px;
            background: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            color: #856404;
        }
        
        .countdown i {
            margin-right: 8px;
        }
        
        .highlight-amount {
            color: #667eea;
            font-size: 1.3rem;
            font-weight: 700;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <!-- Header -->
        <div class="payment-header">
            <h2><i class="fas fa-credit-card me-3"></i>Thanh Toán Đơn Hàng</h2>
            <p>Vui lòng thực hiện chuyển khoản theo thông tin bên dưới</p>
        </div>
        
        <!-- Body -->
        <div class="payment-body">
            <!-- Payment Method Badge -->
            <div class="text-center">
                <c:choose>
                    <c:when test="${paymentMethod == 'BANK_TRANSFER'}">
                        <span class="payment-method-badge">
                            <i class="fas fa-university"></i>
                            Chuyển khoản Ngân hàng
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="payment-method-badge" style="background: linear-gradient(135deg, #d82d8b, #ff6b9d);">
                            <i class="fab fa-cc-amazon-pay"></i>
                            Ví MoMo
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Countdown Timer -->
            <div class="countdown">
                <i class="fas fa-clock"></i>
                Thời gian thanh toán: <span id="countdown">15:00</span>
            </div>
            
            <!-- Alert -->
            <div class="alert-info-custom">
                <i class="fas fa-info-circle"></i>
                <strong>Lưu ý quan trọng:</strong> Vui lòng chuyển khoản <strong>chính xác số tiền</strong> và ghi rõ <strong>nội dung chuyển khoản</strong> để đơn hàng được xử lý nhanh chóng.
            </div>
            
            <!-- Payment Information by Store -->
            <c:forEach var="storeEntry" items="${storePaymentInfo}">
                <div class="store-section">
                    <div class="store-name">
                        <i class="fas fa-store"></i>
                        ${storeEntry.key.tenCH}
                    </div>
                    
                    <c:choose>
                        <c:when test="${paymentMethod == 'BANK_TRANSFER'}">
                            <!-- Bank Transfer Info -->
                            <table class="payment-info-table">
                                <tr>
                                    <td><i class="fas fa-university me-2"></i>Ngân hàng:</td>
                                    <td><strong>${storeEntry.key.bankName}</strong></td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-credit-card me-2"></i>Số tài khoản:</td>
                                    <td>
                                        <span class="highlight-amount">${storeEntry.key.bankAccountNumber}</span>
                                        <button type="button" class="copy-btn" onclick="copyToClipboard('${storeEntry.key.bankAccountNumber}')">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-user me-2"></i>Chủ tài khoản:</td>
                                    <td><strong>${storeEntry.key.bankAccountName}</strong></td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-money-bill-wave me-2"></i>Số tiền:</td>
                                    <td>
                                        <span class="highlight-amount">
                                            <fmt:formatNumber value="${storeEntry.value}" type="number" groupingUsed="true"/>₫
                                        </span>
                                        <button type="button" class="copy-btn" onclick="copyToClipboard('${storeEntry.value}')">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-comment-dots me-2"></i>Nội dung:</td>
                                    <td>
                                        <strong>DH${orderId} ${user.hoTen}</strong>
                                        <button type="button" class="copy-btn" onclick="copyToClipboard('DH${orderId} ${user.hoTen}')">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </td>
                                </tr>
                            </table>
                            
                            <!-- QR Code for Bank -->
                            <c:if test="${not empty storeEntry.key.bankQR}">
                                <div class="qr-container">
                                    <p><i class="fas fa-qrcode me-2"></i>Quét mã QR để thanh toán</p>
                                                    <img src="${pageContext.request.contextPath}/assets/img/${storeEntry.key.bankQR}" 
                                         alt="Bank QR Code"
                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                    <div style="display: none;" class="alert alert-warning mt-3">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        Mã QR chưa có. Vui lòng chuyển khoản theo thông tin bên trên.
                                    </div>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <!-- MoMo Info -->
                            <table class="payment-info-table">
                                <tr>
                                    <td><i class="fas fa-mobile-alt me-2"></i>Số điện thoại:</td>
                                    <td>
                                        <span class="highlight-amount">${storeEntry.key.momoPhone}</span>
                                        <button type="button" class="copy-btn" onclick="copyToClipboard('${storeEntry.key.momoPhone}')">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-user me-2"></i>Chủ tài khoản:</td>
                                    <td><strong>${storeEntry.key.momoName}</strong></td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-money-bill-wave me-2"></i>Số tiền:</td>
                                    <td>
                                        <span class="highlight-amount">
                                            <fmt:formatNumber value="${storeEntry.value}" type="number" groupingUsed="true"/>₫
                                        </span>
                                        <button type="button" class="copy-btn" onclick="copyToClipboard('${storeEntry.value}')">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-comment-dots me-2"></i>Nội dung:</td>
                                    <td>
                                        <strong>DH${orderId} ${user.hoTen}</strong>
                                        <button type="button" class="copy-btn" onclick="copyToClipboard('DH${orderId} ${user.hoTen}')">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </td>
                                </tr>
                            </table>
                            
                            <!-- QR Code for MoMo -->
                            <c:if test="${not empty storeEntry.key.momoQR}">
                                <div class="qr-container">
                                    <p><i class="fas fa-qrcode me-2"></i>Quét mã QR để thanh toán</p>
                                                    <img src="${pageContext.request.contextPath}/assets/img/${storeEntry.key.momoQR}" 
                                         alt="MoMo QR Code"
                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                    <div style="display: none;" class="alert alert-warning mt-3">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        Mã QR chưa có. Vui lòng chuyển khoản theo thông tin bên trên.
                                    </div>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
            
            <!-- Order Summary -->
            <div class="order-summary">
                <h5 class="mb-3"><i class="fas fa-file-invoice-dollar me-2"></i>Tổng quan đơn hàng</h5>
                <div class="summary-row">
                    <span>Tổng tiền hàng:</span>
                    <strong><fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/>₫</strong>
                </div>
                <div class="summary-row">
                    <span>Tổng thanh toán:</span>
                    <strong><fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/>₫</strong>
                </div>
            </div>
            
            <!-- Confirm Button -->
            <form action="${pageContext.request.contextPath}/user/checkout/confirm-payment" method="post">
                <input type="hidden" name="orderId" value="${orderId}">
                <button type="submit" class="btn-confirm-payment">
                    <i class="fas fa-check-circle me-2"></i>Tôi đã thanh toán
                </button>
            </form>
            
            <button type="button" class="btn-cancel" onclick="window.location.href='${pageContext.request.contextPath}/user/orders'">
                <i class="fas fa-arrow-left me-2"></i>Quay lại đơn hàng
            </button>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Copy to clipboard function
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(() => {
                // Show success message
                const Toast = document.createElement('div');
                Toast.className = 'alert alert-success';
                Toast.style.cssText = 'position: fixed; top: 20px; right: 20px; z-index: 9999; animation: slideInRight 0.3s;';
                Toast.innerHTML = '<i class="fas fa-check-circle me-2"></i>Đã sao chép: ' + text;
                document.body.appendChild(Toast);
                
                setTimeout(() => {
                    Toast.remove();
                }, 2000);
            }).catch(err => {
                alert('Không thể sao chép. Vui lòng copy thủ công.');
            });
        }
        
        // Countdown timer (15 minutes)
        let timeLeft = 15 * 60; // 15 minutes in seconds
        const countdownElement = document.getElementById('countdown');
        
        function updateCountdown() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            countdownElement.textContent = 
                String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');
            
            if (timeLeft <= 0) {
                clearInterval(countdownInterval);
                alert('Hết thời gian thanh toán! Vui lòng kiểm tra đơn hàng của bạn.');
                window.location.href = '${pageContext.request.contextPath}/user/orders';
            }
            
            // Change color when time is running out
            if (timeLeft <= 60) {
                countdownElement.style.color = '#dc3545';
            } else if (timeLeft <= 180) {
                countdownElement.style.color = '#ffc107';
            }
            
            timeLeft--;
        }
        
        const countdownInterval = setInterval(updateCountdown, 1000);
        updateCountdown();
    </script>
</body>
</html>
