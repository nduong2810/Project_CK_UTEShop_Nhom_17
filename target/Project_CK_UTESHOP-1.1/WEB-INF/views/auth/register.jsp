<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --gradient-ute: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            --gradient-shipper: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --gradient-user: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        
        body {
            background: var(--gradient-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            overflow-x: hidden;
            padding: 2rem 0;
            margin: 0;
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
        
        .register-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 80px rgba(0,0,0,0.25);
            overflow: hidden;
            max-width: 1100px;
            width: 100%;
            position: relative;
            backdrop-filter: blur(10px);
        }
        
        .register-left {
            background: var(--gradient-ute);
            color: white;
            padding: 3rem 2.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            min-height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .register-left::before {
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
        
        .register-right {
            padding: 3rem 2.5rem;
            position: relative;
        }
        
        .brand-logo {
            width: 100px;
            height: 100px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            position: relative;
            z-index: 2;
            backdrop-filter: blur(10px);
            border: 3px solid rgba(255,255,255,0.3);
            overflow: hidden;
        }
        
        .brand-logo img {
            width: 70px;
            height: 70px;
            object-fit: contain;
        }
        
        /* Fix logo loading */
        .brand-logo .logo-fallback {
            font-size: 2.5rem;
            color: #1e3c72;
        }

        .brand-logo::after {
            content: '';
            position: absolute;
            inset: -2px;
            border-radius: 50%;
            border: 2px solid transparent;
            background: linear-gradient(45deg, rgba(255,255,255,0.4), transparent) border-box;
            mask: linear-gradient(#fff 0 0) padding-box, linear-gradient(#fff 0 0);
            mask-composite: exclude;
            animation: rotate 4s linear infinite;
        }
        
        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .welcome-text {
            position: relative;
            z-index: 2;
        }
        
        .welcome-text h2 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.3);
        }
        
        .welcome-text p {
            font-size: 1rem;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .form-floating {
            margin-bottom: 1.2rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 0.8rem 1.2rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            background: white;
            transform: translateY(-2px);
        }
        
        .form-floating label {
            color: #6c757d;
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .btn-register {
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
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        
        .btn-register:hover {
            background: var(--gradient-secondary);
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.6);
            color: white;
        }
        
        .divider {
            text-align: center;
            margin: 1.5rem 0;
            position: relative;
        }
        
        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(to right, transparent, #ddd, transparent);
        }
        
        .divider span {
            background: white;
            padding: 0 1rem;
            color: #6c757d;
            font-weight: 500;
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .login-link a:hover {
            color: #764ba2;
            text-decoration: underline;
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
        
        .role-selector {
            margin-bottom: 1.5rem;
        }
        
        .role-tabs {
            display: flex;
            background: rgba(102, 126, 234, 0.1);
            border-radius: 15px;
            padding: 0.4rem;
            margin-bottom: 1rem;
            gap: 0.3rem;
        }
        
        .role-tab {
            flex: 1;
            padding: 0.7rem 0.8rem;
            text-align: center;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .role-tab.active {
            background: var(--gradient-primary);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .role-tab.shipper.active {
            background: var(--gradient-shipper);
            box-shadow: 0 4px 15px rgba(17, 153, 142, 0.3);
        }
        
        .role-tab:not(.active) {
            color: #667eea;
        }
        
        .role-tab:not(.active):hover {
            background: rgba(102, 126, 234, 0.2);
        }
        
        .register-title {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .register-title h3 {
            font-size: 1.8rem;
            font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }
        
        .register-subtitle {
            color: #6c757d;
            font-size: 0.95rem;
        }
        
        .row.g-3 .col-md-6 {
            padding-right: 0.5rem;
            padding-left: 0.5rem;
        }
        
        .password-strength {
            margin-bottom: 1rem;
        }
        
        .strength-bar {
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            overflow: hidden;
            margin-top: 0.5rem;
        }
        
        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }
        
        .strength-text {
            font-size: 0.8rem;
            margin-top: 0.3rem;
            font-weight: 500;
        }
        
        .terms-checkbox {
            margin-bottom: 1.5rem;
        }
        
        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }
        
        .form-check-label {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .form-check-label a {
            color: #667eea;
            text-decoration: none;
        }
        
        .form-check-label a:hover {
            text-decoration: underline;
        }
        
        .home-btn {
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
        
        .home-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        @media (max-width: 768px) {
            body {
                padding: 1rem 0;
            }
            
            .register-container {
                margin: 0.5rem;
                border-radius: 20px;
            }
            
            .register-left {
                padding: 2rem 1.5rem;
            }
            
            .register-right {
                padding: 2rem 1.5rem;
            }
            
            .welcome-text h2 {
                font-size: 1.8rem;
            }
            
            .brand-logo {
                width: 80px;
                height: 80px;
            }
            
            .brand-logo img {
                width: 50px;
                height: 50px;
            }
            
            .role-tabs {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .role-tab {
                font-size: 0.8rem;
            }
        }
        
        @media (max-width: 576px) {
            .row.g-3 .col-md-6 {
                padding-right: 0.75rem;
                padding-left: 0.75rem;
            }
        }
        
        /* OTP Styles */
        .otp-method-card {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem;
            transition: all 0.3s ease;
            cursor: pointer;
            text-align: center;
        }
        
        .otp-method-card:hover {
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }
        
        .otp-method-card .form-check-input:checked ~ .form-check-label {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
        }
        
        .otp-method-content {
            pointer-events: none;
        }
        
        .otp-input-section {
            background: rgba(102, 126, 234, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            border: 2px solid rgba(102, 126, 234, 0.2);
        }
        
        #otpCode {
            font-size: 1.2rem;
            letter-spacing: 0.3rem;
            font-weight: bold;
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
    </style>
</head>
<body>
    <!-- Nút về trang chủ -->
    <a href="${pageContext.request.contextPath}/guest/home" class="home-btn">
        <i class="fas fa-home me-2"></i>Trang chủ
    </a>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="register-container row g-0">
                    <!-- Left Panel -->
                    <div class="col-lg-4 register-left">
                        <div class="brand-logo">
                            <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" 
                                 alt="HCMUTE Logo" 
                                 onerror="this.style.display='none'; this.parentElement.innerHTML='<i class=\'fas fa-university fa-3x\'></i>';">
                        </div>
                        <div class="welcome-text">
                            <h2>Tham gia UTESHOP</h2>
                            <p>Tạo tài khoản để trở thành thành viên của cộng đồng mua sắm HCMUTE. Khám phá hàng ngàn sản phẩm chất lượng với giá ưu đãi!</p>
                            <div class="mt-4">
                                <div class="d-flex justify-content-center gap-3 mb-3">
                                    <i class="fas fa-users fa-2x" style="opacity: 0.7;"></i>
                                    <i class="fas fa-shipping-fast fa-2x" style="opacity: 0.7;"></i>
                                    <i class="fas fa-shield-check fa-2x" style="opacity: 0.7;"></i>
                                </div>
                                <p style="font-size: 0.85rem; opacity: 0.8;">Cộng đồng • Giao hàng • Bảo mật</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Panel -->
                    <div class="col-lg-8 register-right">
                        <div class="register-title">
                            <h3>Đăng ký tài khoản</h3>
                            <p class="register-subtitle">Chọn loại tài khoản và điền thông tin để đăng ký</p>
                        </div>
                        
                        <!-- Role Selector -->
                        <div class="role-selector">
                            <div class="role-tabs">
                                <div class="role-tab active" data-role="user">
                                    <i class="fas fa-user me-1"></i>Khách hàng
                                </div>
                                <div class="role-tab shipper" data-role="shipper">
                                    <i class="fas fa-shipping-fast me-1"></i>Shipper
                                </div>
                                <div class="role-tab" data-role="supplier">
                                    <i class="fas fa-store me-1"></i>Nhà cung cấp
                                </div>
                            </div>
                        </div>
                        
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
                        
                        <!-- Register Form -->
                        <form method="post" action="${pageContext.request.contextPath}/auth/register" id="registerForm">
                            <input type="hidden" name="role" id="selectedRole" value="user">
                            
                            <!-- Basic Info Row -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="username" name="username" 
                                               placeholder="Tên đăng nhập" required>
                                        <label for="username">
                                            <i class="fas fa-user me-2"></i>Tên đăng nhập
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="email" class="form-control" id="email" name="email" 
                                               placeholder="name@example.com" required>
                                        <label for="email">
                                            <i class="fas fa-envelope me-2"></i>Email
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Name Row -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="firstName" name="firstName" 
                                               placeholder="Tên" required>
                                        <label for="firstName">
                                            <i class="fas fa-id-card me-2"></i>Tên
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="lastName" name="lastName" 
                                               placeholder="Họ" required>
                                        <label for="lastName">
                                            <i class="fas fa-id-card me-2"></i>Họ
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Phone & Gender -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="tel" class="form-control" id="phone" name="phone" 
                                               placeholder="Số điện thoại" required>
                                        <label for="phone">
                                            <i class="fas fa-phone me-2"></i>Số điện thoại
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select class="form-select" id="gender" name="gender" required>
                                            <option value="">Chọn giới tính</option>
                                            <option value="male">Nam</option>
                                            <option value="female">Nữ</option>
                                            <option value="other">Khác</option>
                                        </select>
                                        <label for="gender">
                                            <i class="fas fa-venus-mars me-2"></i>Giới tính
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Password Row -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="password" class="form-control" id="password" name="password" 
                                               placeholder="Mật khẩu" required minlength="6">
                                        <label for="password">
                                            <i class="fas fa-lock me-2"></i>Mật khẩu
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                               placeholder="Xác nhận mật khẩu" required minlength="6">
                                        <label for="confirmPassword">
                                            <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Address -->
                            <div class="form-floating">
                                <input type="text" class="form-control" id="address" name="address" 
                                       placeholder="Địa chỉ" required>
                                <label for="address">
                                    <i class="fas fa-map-marker-alt me-2"></i>Địa chỉ
                                </label>
                            </div>

                            <!-- OTP Verification Section -->
                            <div class="otp-section" id="otpSection" style="display: none;">
                                <div class="alert alert-info">
                                    <i class="fas fa-shield-alt me-2"></i>
                                    <strong>Bước cuối:</strong> Chọn phương thức nhận mã xác thực để hoàn tất đăng ký
                                </div>
                                
                                <!-- OTP Method Selection -->
                                <div class="otp-method-selection mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-key me-2"></i>Chọn phương thức nhận mã OTP:
                                    </label>
                                    <div class="row g-2">
                                        <div class="col-md-6">
                                            <div class="form-check otp-method-card">
                                                <input class="form-check-input" type="radio" name="otpMethod" id="emailOTP" value="EMAIL" checked>
                                                <label class="form-check-label w-100" for="emailOTP">
                                                    <div class="otp-method-content">
                                                        <i class="fas fa-envelope fa-2x text-primary mb-2"></i>
                                                        <h6>Qua Email</h6>
                                                        <small class="text-muted">Gửi mã về email đã nhập</small>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-check otp-method-card">
                                                <input class="form-check-input" type="radio" name="otpMethod" id="smsOTP" value="SMS">
                                                <label class="form-check-label w-100" for="smsOTP">
                                                    <div class="otp-method-content">
                                                        <i class="fas fa-sms fa-2x text-success mb-2"></i>
                                                        <h6>Qua SMS</h6>
                                                        <small class="text-muted">Gửi mã về số điện thoại</small>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Send OTP Button -->
                                <div class="text-center mb-3">
                                    <button type="button" class="btn btn-primary" id="sendOTPBtn">
                                        <i class="fas fa-paper-plane me-2"></i>Gửi mã xác thực
                                    </button>
                                </div>
                                
                                <!-- OTP Input (hidden initially) -->
                                <div class="otp-input-section" id="otpInputSection" style="display: none;">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control text-center" id="otpCode" name="otpCode" 
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
                            
                            <!-- Terms and Conditions -->
                            <div class="terms-checkbox">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="terms" name="terms" required>
                                    <label class="form-check-label" for="terms">
                                        Tôi đồng ý với 
                                        <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Điều khoản sử dụng</a> 
                                        và 
                                        <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">Chính sách bảo mật</a>
                                    </label>
                                </div>
                            </div>
                            
                            <!-- Submit Button -->
                            <div class="d-grid">
                                <button type="submit" class="btn btn-register" id="submitBtn" disabled>
                                    <i class="fas fa-user-plus me-2"></i>Đăng ký tài khoản
                                </button>
                            </div>
                        </form>
                        
                        <!-- Login Link -->
                        <div class="login-link">
                            <p>Đã có tài khoản? 
                                <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập ngay</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Terms Modal -->
    <div class="modal fade" id="termsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Điều khoản sử dụng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6>1. Chấp nhận điều khoản</h6>
                    <p>Bằng việc sử dụng UTESHOP, bạn đồng ý tuân thủ các điều khoản và điều kiện này.</p>
                    
                    <h6>2. Tài khoản người dùng</h6>
                    <p>Bạn có trách nhiệm bảo mật thông tin tài khoản và mật khẩu của mình.</p>
                    
                    <h6>3. Quy định giao dịch</h6>
                    <p>Mọi giao dịch trên UTESHOP phải tuân thủ quy định của pháp luật Việt Nam.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Privacy Modal -->
    <div class="modal fade" id="privacyModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chính sách bảo mật</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6>1. Thu thập thông tin</h6>
                    <p>UTESHOP chỉ thu thập thông tin cần thiết để cung cấp dịch vụ tốt nhất cho bạn.</p>
                    
                    <h6>2. Bảo mật thông tin</h6>
                    <p>Chúng tôi cam kết bảo vệ thông tin cá nhân của bạn bằng các biện pháp bảo mật hiện đại.</p>
                    
                    <h6>3. Chia sẻ thông tin</h6>
                    <p>Thông tin của bạn sẽ không được chia sẻ với bên thứ ba mà không có sự đồng ý.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const roleTabs = document.querySelectorAll('.role-tab');
            const selectedRoleInput = document.getElementById('selectedRole');
            const registerBtn = document.getElementById('registerBtn');
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const strengthFill = document.getElementById('strengthFill');
            const strengthText = document.getElementById('strengthText');
            
            // Role tab functionality
            roleTabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    // Remove active class from all tabs
                    roleTabs.forEach(t => t.classList.remove('active'));
                    
                    // Add active class to clicked tab
                    this.classList.add('active');
                    
                    // Update hidden input value
                    const role = this.getAttribute('data-role');
                    selectedRoleInput.value = role;
                    
                    // Update button text based on role
                    const buttonTexts = {
                        'user': '<i class="fas fa-user-plus me-2"></i>Đăng ký Khách hàng',
                        'shipper': '<i class="fas fa-shipping-fast me-2"></i>Đăng ký Shipper',
                        'supplier': '<i class="fas fa-store me-2"></i>Đăng ký Nhà cung cấp'
                    };
                    
                    registerBtn.innerHTML = buttonTexts[role] || buttonTexts['user'];
                });
            });
            
            // Password strength checker
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                const strength = checkPasswordStrength(password);
                updatePasswordStrength(strength);
            });
            
            // Form validation
            const form = document.getElementById('registerForm');
            form.addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return;
                }
                
                // Show loading state
                registerBtn.disabled = true;
                registerBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang đăng ký...';
            });
            
            // Real-time password confirmation check
            confirmPasswordInput.addEventListener('input', function() {
                if (this.value && this.value !== passwordInput.value) {
                    this.setCustomValidity('Mật khẩu xác nhận không khớp');
                } else {
                    this.setCustomValidity('');
                }
            });
        });
        
        function checkPasswordStrength(password) {
            let score = 0;
            let feedback = '';
            
            if (password.length >= 8) score += 1;
            if (/[a-z]/.test(password)) score += 1;
            if (/[A-Z]/.test(password)) score += 1;
            if (/[0-9]/.test(password)) score += 1;
            if (/[^A-Za-z0-9]/.test(password)) score += 1;
            
            const strengthLevels = [
                { score: 0, text: 'Rất yếu', color: '#dc3545', width: '0%' },
                { score: 1, text: 'Yếu', color: '#fd7e14', width: '20%' },
                { score: 2, text: 'Trung bình', color: '#ffc107', width: '40%' },
                { score: 3, text: 'Khá', color: '#20c997', width: '60%' },
                { score: 4, text: 'Mạnh', color: '#198754', width: '80%' },
                { score: 5, text: 'Rất mạnh', color: '#0d6efd', width: '100%' }
            ];
            
            return strengthLevels[score] || strengthLevels[0];
        }
        
        function updatePasswordStrength(strength) {
            const strengthFill = document.getElementById('strengthFill');
            const strengthText = document.getElementById('strengthText');
            
            strengthFill.style.width = strength.width;
            strengthFill.style.backgroundColor = strength.color;
            strengthText.textContent = `Độ mạnh mật khẩu: ${strength.text}`;
            strengthText.style.color = strength.color;
        }
        
        function validateForm() {
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const phone = document.getElementById('phone').value.trim();
            const agreeTerms = document.getElementById('agreeTerms').checked;
            
            // Username validation
            if (username.length < 3) {
                showNotification('Tên đăng nhập phải có ít nhất 3 ký tự!', 'error');
                return false;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showNotification('Email không hợp lệ!', 'error');
                return false;
            }
            
            // Password validation
            if (password.length < 6) {
                showNotification('Mật khẩu phải có ít nhất 6 ký tự!', 'error');
                return false;
            }
            
            if (password !== confirmPassword) {
                showNotification('Mật khẩu xác nhận không khớp!', 'error');
                return false;
            }
            
            // Phone validation
            const phoneRegex = /^[0-9]{10,11}$/;
            if (!phoneRegex.test(phone)) {
                showNotification('Số điện thoại phải có 10-11 chữ số!', 'error');
                return false;
            }
            
            // Terms validation
            if (!agreeTerms) {
                showNotification('Bạn phải đồng ý với điều khoản sử dụng!', 'error');
                return false;
            }
            
            return true;
        }
        
        function showNotification(message, type) {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = 'alert alert-' + (type === 'error' ? 'danger' : 'success') + ' position-fixed';
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px; max-width: 400px;';
            notification.innerHTML = 
                '<i class="fas fa-' + (type === 'error' ? 'exclamation-triangle' : 'check-circle') + ' me-2"></i>' +
                message +
                '<button type="button" class="btn-close ms-2" onclick="this.parentElement.remove()"></button>';
            
            document.body.appendChild(notification);
            
            // Auto remove after 4 seconds
            setTimeout(() => {
                if (notification.parentElement) {
                    notification.remove();
                }
            }, 4000);
        }
    </script>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Elements
        const registerForm = document.getElementById('registerForm');
        const roleTabs = document.querySelectorAll('.role-tab');
        const selectedRoleInput = document.getElementById('selectedRole');
        const otpSection = document.getElementById('otpSection');
        const sendOTPBtn = document.getElementById('sendOTPBtn');
        const otpInputSection = document.getElementById('otpInputSection');
        const verifyOTPBtn = document.getElementById('verifyOTPBtn');
        const resendOTPBtn = document.getElementById('resendOTPBtn');
        const submitBtn = document.getElementById('submitBtn');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        
        let otpVerified = false;
        let resendTimer = null;
        let resendCountdown = 60;
        
        // Role selection
        roleTabs.forEach(tab => {
            tab.addEventListener('click', function() {
                roleTabs.forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                selectedRoleInput.value = this.dataset.role;
            });
        });
        
        // Form validation
        function validateForm() {
            const isValid = registerForm.checkValidity();
            const passwordsMatch = passwordInput.value === confirmPasswordInput.value;
            
            if (!passwordsMatch) {
                confirmPasswordInput.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                confirmPasswordInput.setCustomValidity('');
            }
            
            // Show OTP section when basic form is valid
            if (isValid && passwordsMatch) {
                otpSection.style.display = 'block';
            } else {
                otpSection.style.display = 'none';
                otpVerified = false;
            }
            
            // Enable submit only when OTP is verified
            submitBtn.disabled = !otpVerified;
        }
        
        // Form change listeners
        registerForm.addEventListener('input', validateForm);
        registerForm.addEventListener('change', validateForm);
        
        // Password confirmation validation
        confirmPasswordInput.addEventListener('input', function() {
            if (this.value !== passwordInput.value) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });
        
        // Send OTP
        sendOTPBtn.addEventListener('click', function() {
            const emailInput = document.getElementById('email');
            const phoneInput = document.getElementById('phone');
            const otpMethod = document.querySelector('input[name="otpMethod"]:checked').value;
            
            let identifier = otpMethod === 'EMAIL' ? emailInput.value : phoneInput.value;
            
            if (!identifier) {
                alert('Vui lòng nhập ' + (otpMethod === 'EMAIL' ? 'email' : 'số điện thoại'));
                return;
            }
            
            this.disabled = true;
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
            
            // Send OTP request
            fetch('${pageContext.request.contextPath}/auth/send-otp', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `identifier=${encodeURIComponent(identifier)}&otpType=${otpMethod}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    otpInputSection.style.display = 'block';
                    startResendTimer();
                    alert('Mã OTP đã được gửi thành công!');
                } else {
                    alert('Lỗi: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi gửi OTP');
            })
            .finally(() => {
                this.disabled = false;
                this.innerHTML = '<i class="fas fa-paper-plane me-2"></i>Gửi mã xác thực';
            });
        });
        
        // Verify OTP
        verifyOTPBtn.addEventListener('click', function() {
            const otpCode = document.getElementById('otpCode').value;
            
            if (!otpCode || otpCode.length !== 6) {
                alert('Vui lòng nhập mã OTP 6 chữ số');
                return;
            }
            
            this.disabled = true;
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xác thực...';
            
            fetch('${pageContext.request.contextPath}/auth/verify-otp', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `otpCode=${encodeURIComponent(otpCode)}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    otpVerified = true;
                    submitBtn.disabled = false;
                    otpInputSection.style.display = 'none';
                    
                    // Show success message
                    const successDiv = document.createElement('div');
                    successDiv.className = 'alert alert-success';
                    successDiv.innerHTML = '<i class="fas fa-check-circle me-2"></i>Xác thực OTP thành công! Bạn có thể hoàn tất đăng ký.';
                    otpSection.appendChild(successDiv);
                    
                    clearInterval(resendTimer);
                    alert('Xác thực OTP thành công!');
                } else {
                    alert('Lỗi: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi xác thực OTP');
            })
            .finally(() => {
                this.disabled = false;
                this.innerHTML = '<i class="fas fa-check-circle me-2"></i>Xác thực OTP';
            });
        });
        
        // Resend OTP
        resendOTPBtn.addEventListener('click', function() {
            if (this.disabled) return;
            
            this.disabled = true;
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi lại...';
            
            fetch('${pageContext.request.contextPath}/auth/resend-otp', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    startResendTimer();
                    alert('Mã OTP đã được gửi lại thành công!');
                } else {
                    alert('Lỗi: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi gửi lại OTP');
            });
        });
        
        // Resend timer
        function startResendTimer() {
            resendCountdown = 60;
            resendOTPBtn.disabled = true;
            
            resendTimer = setInterval(() => {
                resendCountdown--;
                document.getElementById('resendTimer').textContent = resendCountdown;
                resendOTPBtn.innerHTML = `<i class="fas fa-redo me-2"></i>Gửi lại (${resendCountdown}s)`;
                
                if (resendCountdown <= 0) {
                    clearInterval(resendTimer);
                    resendOTPBtn.disabled = false;
                    resendOTPBtn.innerHTML = '<i class="fas fa-redo me-2"></i>Gửi lại';
                }
            }, 1000);
        }
        
        // OTP input formatting
        document.getElementById('otpCode').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value.length > 6) {
                this.value = this.value.slice(0, 6);
            }
        });
        
        // Form submission validation
        registerForm.addEventListener('submit', function(e) {
            if (!otpVerified) {
                e.preventDefault();
                alert('Vui lòng xác thực OTP trước khi đăng ký');
                return;
            }
            
            if (passwordInput.value !== confirmPasswordInput.value) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp');
                return;
            }
        });
    });
    </script>
</body>
</html>