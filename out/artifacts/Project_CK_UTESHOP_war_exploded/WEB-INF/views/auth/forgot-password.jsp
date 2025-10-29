<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
            --gradient-secondary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        body {
            background: var(--gradient-primary);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            overflow-x: hidden;
            margin: 0;
            padding: 0;
        }
        
        /* Background Animation */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png') no-repeat center center;
            background-size: 30%;
            opacity: 0.03;
            z-index: -1;
            animation: float 8s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg) scale(1); }
            50% { transform: translateY(-30px) rotate(5deg) scale(1.05); }
        }
        
        /* Container wrapper để đảm bảo căn giữa hoàn hảo */
        .container-fluid {
            padding: 1rem;
        }
        
        .forgot-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 80px rgba(0,0,0,0.25);
            overflow: hidden;
            max-width: 500px;
            width: 90%;
            position: relative;
            backdrop-filter: blur(10px);
            margin: auto;
        }
        
        .forgot-header {
            background: var(--gradient-primary);
            color: white;
            padding: 3rem 2.5rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .forgot-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shine 5s infinite;
        }
        
        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }
        
        .brand-logo {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            position: relative;
            z-index: 2;
            backdrop-filter: blur(10px);
            border: 3px solid rgba(255,255,255,0.3);
        }
        
        .brand-logo i {
            font-size: 2rem;
            color: white;
        }
        
        .forgot-content {
            padding: 2.5rem;
            position: relative;
        }
        
        .form-floating {
            margin-bottom: 1.5rem;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 0.8rem 1.2rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
        }
        
        .form-control:focus {
            border-color: #ff6b35;
            box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.15);
            background: white;
            transform: translateY(-2px);
        }
        
        .form-floating label {
            color: #6c757d;
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .btn-forgot {
            background: var(--gradient-primary);
            border: none;
            color: white;
            padding: 1rem 2rem;
            border-radius: 15px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
        }
        
        .btn-forgot:hover {
            background: var(--gradient-secondary);
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(255, 107, 53, 0.6);
            color: white;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            margin-bottom: 1.5rem;
            backdrop-filter: blur(10px);
            font-size: 0.9rem;
        }
        
        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            z-index: 1000;
        }
        
        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        .info-text {
            color: #6c757d;
            font-size: 0.9rem;
            text-align: center;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .login-link a {
            color: #ff6b35;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .login-link a:hover {
            color: #f7931e;
            text-decoration: underline;
        }
        
        /* OTP Section */
        .otp-section {
            background: rgba(255, 107, 53, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            border: 2px solid rgba(255, 107, 53, 0.2);
            margin-bottom: 1.5rem;
        }
        
        .otp-input-section {
            background: rgba(255, 107, 53, 0.03);
            border-radius: 12px;
            padding: 1.5rem;
            border: 2px solid rgba(255, 107, 53, 0.1);
        }
        
        #otpCode {
            font-size: 1.2rem;
            letter-spacing: 0.3rem;
            font-weight: bold;
            text-align: center;
        }
        
        .alert-info {
            background: rgba(13, 202, 240, 0.1);
            color: #055160;
            border-left: 4px solid #0dcaf0;
        }
        
        .alert-warning {
            background: rgba(255, 193, 7, 0.1);
            color: #664d03;
            border-left: 4px solid #ffc107;
        }
        
        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        
        #resendTimer {
            font-weight: bold;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 1rem 0;
            }
            
            .forgot-container {
                margin: 0.5rem;
                border-radius: 20px;
            }
            
            .forgot-header {
                padding: 2rem 1.5rem 1.5rem;
            }
            
            .forgot-content {
                padding: 2rem 1.5rem;
            }
            
            .brand-logo {
                width: 60px;
                height: 60px;
            }
            
            .brand-logo i {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Nút quay lại -->
    <a href="${pageContext.request.contextPath}/auth/login" class="back-btn">
        <i class="fas fa-arrow-left me-2"></i>Quay lại
    </a>
    
    <div class="container-fluid d-flex justify-content-center align-items-center min-vh-100">
        <div class="forgot-container">
            <!-- Header -->
            <div class="forgot-header">
                <div class="brand-logo">
                    <i class="fas fa-key"></i>
                </div>
                <h2>Quên mật khẩu?</h2>
                <p>Đừng lo lắng, chúng tôi sẽ giúp bạn khôi phục!</p>
            </div>
            
            <!-- Content -->
            <div class="forgot-content">
                <!-- Error/Success Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                    </div>
                </c:if>
                
                <div class="info-text">
                    <i class="fas fa-info-circle me-2"></i>
                    Nhập email của bạn và chúng tôi sẽ gửi mã xác thực để đặt lại mật khẩu.
                </div>
                
                <!-- Email Form -->
                <form id="forgotForm">
                    <div class="form-floating">
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="name@example.com" required>
                        <label for="email">
                            <i class="fas fa-envelope me-2"></i>Email của bạn
                        </label>
                    </div>
                    
                    <div class="d-grid">
                        <button type="button" class="btn btn-forgot" id="sendOTPBtn">
                            <i class="fas fa-paper-plane me-2"></i>Gửi mã xác thực
                        </button>
                    </div>
                </form>
                
                <!-- OTP Section (Hidden initially) -->
                <div class="otp-section" id="otpSection" style="display: none;">
                    <div class="alert alert-info">
                        <i class="fas fa-shield-alt me-2"></i>
                        <strong>Kiểm tra email:</strong> Mã OTP đã được gửi đến email của bạn
                    </div>
                    
                    <div class="otp-input-section" id="otpInputSection">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="otpCode" name="otpCode" 
                                   placeholder="123456" maxlength="6" pattern="[0-9]{6}">
                            <label for="otpCode">
                                <i class="fas fa-key me-2"></i>Nhập mã OTP (6 chữ số)
                            </label>
                        </div>
                        
                        <div class="text-center mb-3">
                            <button type="button" class="btn btn-success" id="verifyOTPBtn">
                                <i class="fas fa-check-circle me-2"></i>Xác thực OTP
                            </button>
                            <button type="button" class="btn btn-outline-secondary ms-2" id="resendOTPBtn" disabled>
                                <i class="fas fa-redo me-2"></i>Gửi lại (<span id="resendTimer">60</span>s)
                            </button>
                        </div>
                        
                        <div class="alert alert-warning">
                            <i class="fas fa-clock me-2"></i>
                            Mã OTP có hiệu lực trong <strong>5 phút</strong>. Kiểm tra hộp thư spam nếu không thấy email.
                        </div>
                    </div>
                </div>
                
                <!-- Login Link -->
                <div class="login-link">
                    <p>Nhớ lại mật khẩu? 
                        <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập ngay</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sendOTPBtn = document.getElementById('sendOTPBtn');
            const verifyOTPBtn = document.getElementById('verifyOTPBtn');
            const resendOTPBtn = document.getElementById('resendOTPBtn');
            const otpSection = document.getElementById('otpSection');
            const emailInput = document.getElementById('email');
            const otpCodeInput = document.getElementById('otpCode');
            
            let resendTimer = null;
            let resendCountdown = 60;
            
            // Gửi OTP
            sendOTPBtn.addEventListener('click', function() {
                const email = emailInput.value.trim();
                
                if (!email) {
                    showNotification('Vui lòng nhập email', 'error');
                    return;
                }
                
                if (!isValidEmail(email)) {
                    showNotification('Email không hợp lệ', 'error');
                    return;
                }
                
                this.disabled = true;
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
                
                fetch('${pageContext.request.contextPath}/auth/forgot-send-otp', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'email=' + encodeURIComponent(email)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        otpSection.style.display = 'block';
                        startResendTimer();
                        showNotification('Mã OTP đã được gửi đến email của bạn!', 'success');
                        emailInput.disabled = true; // Khóa input email
                    } else {
                        showNotification(data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showNotification('Có lỗi xảy ra khi gửi OTP', 'error');
                })
                .finally(() => {
                    this.disabled = false;
                    this.innerHTML = '<i class="fas fa-paper-plane me-2"></i>Gửi mã xác thực';
                });
            });
            
            // Xác thực OTP
            verifyOTPBtn.addEventListener('click', function() {
                const otpCode = otpCodeInput.value.trim();
                
                if (!otpCode || otpCode.length !== 6) {
                    showNotification('Vui lòng nhập mã OTP 6 chữ số', 'error');
                    return;
                }
                
                this.disabled = true;
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xác thực...';
                
                fetch('${pageContext.request.contextPath}/auth/forgot-verify-otp', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'otpCode=' + encodeURIComponent(otpCode)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showNotification('Xác thực OTP thành công!', 'success');
                        // Redirect đến trang reset password
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/auth/reset-password';
                        }, 1000);
                    } else {
                        showNotification(data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showNotification('Có lỗi xảy ra khi xác thực OTP', 'error');
                })
                .finally(() => {
                    this.disabled = false;
                    this.innerHTML = '<i class="fas fa-check-circle me-2"></i>Xác thực OTP';
                });
            });
            
            // Gửi lại OTP
            resendOTPBtn.addEventListener('click', function() {
                if (this.disabled) return;
                
                const email = emailInput.value.trim();
                
                this.disabled = true;
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi lại...';
                
                fetch('${pageContext.request.contextPath}/auth/forgot-send-otp', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'email=' + encodeURIComponent(email)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        startResendTimer();
                        showNotification('Mã OTP đã được gửi lại thành công!', 'success');
                    } else {
                        showNotification(data.message, 'error');
                        // Nếu gửi lại thất bại, enable lại nút ngay lập tức
                        resendOTPBtn.disabled = false;
                        resendOTPBtn.innerHTML = '<i class="fas fa-redo me-2"></i>Gửi lại';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showNotification('Có lỗi xảy ra khi gửi lại OTP', 'error');
                    // Nếu có lỗi, enable lại nút ngay lập tức
                    resendOTPBtn.disabled = false;
                    resendOTPBtn.innerHTML = '<i class="fas fa-redo me-2"></i>Gửi lại';
                });
            });
            
            // Timer gửi lại OTP - Sửa lại để hoạt động chính xác
            function startResendTimer() {
                resendCountdown = 60;
                resendOTPBtn.disabled = true;
                
                // Clear timer cũ nếu có
                if (resendTimer) {
                    clearInterval(resendTimer);
                }
                
                // Bắt đầu đếm ngược
                updateTimerDisplay();
                
                resendTimer = setInterval(() => {
                    resendCountdown--;
                    updateTimerDisplay();
                    
                    if (resendCountdown <= 0) {
                        clearInterval(resendTimer);
                        resendOTPBtn.disabled = false;
                        resendOTPBtn.innerHTML = '<i class="fas fa-redo me-2"></i>Gửi lại';
                        resendTimer = null;
                    }
                }, 1000);
            }
            
            // Hàm cập nhật hiển thị timer
            function updateTimerDisplay() {
                const timerElement = document.getElementById('resendTimer');
                if (timerElement) {
                    timerElement.textContent = resendCountdown;
                }
                resendOTPBtn.innerHTML = '<i class="fas fa-redo me-2"></i>Gửi lại (' + resendCountdown + 's)';
            }
            
            // Format OTP input
            otpCodeInput.addEventListener('input', function() {
                this.value = this.value.replace(/[^0-9]/g, '');
                if (this.value.length > 6) {
                    this.value = this.value.slice(0, 6);
                }
            });
            
            // Validate email
            function isValidEmail(email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailRegex.test(email);
            }
            
            // Show notification
            function showNotification(message, type) {
                const notification = document.createElement('div');
                notification.className = 'alert alert-' + (type === 'error' ? 'danger' : 'success') + ' position-fixed';
                notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px; max-width: 400px;';
                notification.innerHTML = 
                    '<i class="fas fa-' + (type === 'error' ? 'exclamation-triangle' : 'check-circle') + ' me-2"></i>' +
                    message +
                    '<button type="button" class="btn-close ms-2" onclick="this.parentElement.remove()"></button>';
                
                document.body.appendChild(notification);
                
                setTimeout(() => {
                    if (notification.parentElement) {
                        notification.remove();
                    }
                }, 4000);
            }
        });
    </script>
</body>
</html>