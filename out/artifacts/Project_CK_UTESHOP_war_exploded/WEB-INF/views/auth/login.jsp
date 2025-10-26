<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --gradient-ute: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        }
        
        body {
            background: var(--gradient-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            overflow-x: hidden;
            margin: 0;
            padding: 20px;
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
            background-size: 40%;
            opacity: 0.05;
            z-index: -1;
            animation: float 6s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(3deg); }
        }
        
        .login-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 80px rgba(0,0,0,0.25);
            overflow: hidden;
            max-width: 1100px;
            width: 100%;
            position: relative;
            backdrop-filter: blur(10px);
            min-height: 600px;
            margin: auto;
        }
        
        .login-left {
            background: var(--gradient-ute);
            color: white;
            padding: 3rem 2.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 600px;
        }
        
        .login-left::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shine 4s infinite;
        }
        
        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }
        
        .login-right {
            padding: 3rem 2.5rem;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            min-height: 600px;
        }
        
        .brand-logo {
            width: 120px;
            height: 120px;
            background: rgba(255,255,255,0.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            position: relative;
            z-index: 2;
            backdrop-filter: blur(10px);
            border: 3px solid rgba(255,255,255,0.5);
            overflow: hidden;
        }
        
        .brand-logo img {
            width: 90px;
            height: 90px;
            object-fit: contain;
        }
        
        /* Fix logo loading */
        .brand-logo .logo-fallback {
            font-size: 2.5rem;
            color: #1e3c72;
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
        
        .welcome-text {
            position: relative;
            z-index: 2;
        }
        
        .welcome-text h2 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.3);
        }
        
        .welcome-text p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .form-floating {
            margin-bottom: 1.5rem;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 1rem 1.5rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.15);
            background: white;
            transform: translateY(-2px);
        }
        
        .form-floating label {
            color: #6c757d;
            font-weight: 500;
        }
        
        .btn-login {
            padding: 1.2rem 2rem;
            border-radius: 15px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            background: var(--gradient-primary);
            border: none;
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        
        .btn-login:hover {
            background: var(--gradient-secondary);
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.6);
            color: white;
        }
        
        .form-check {
            margin-bottom: 1.5rem;
        }
        
        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }
        
        .forgot-password {
            text-align: center;
            margin-top: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .forgot-password a {
            color: #667eea;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        
        .forgot-password a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        
        .divider {
            text-align: center;
            margin: 2rem 0;
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
            position: relative;
        }
        
        .register-link {
            text-align: center;
            margin-top: 2rem;
        }
        
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .register-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        
        .alert {
            border-radius: 15px;
            border: none;
            margin-bottom: 2rem;
            backdrop-filter: blur(10px);
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
        
        .login-title {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        
        .login-title h3 {
            font-size: 2rem;
            font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }
        
        .login-subtitle {
            color: #6c757d;
            font-size: 1rem;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            
            .login-container {
                margin: 0;
                border-radius: 20px;
                max-width: 100%;
                min-height: auto;
            }
            
            .login-left, .login-right {
                padding: 2rem 1.5rem;
                min-height: auto;
            }
            
            .brand-logo {
                width: 100px;
                height: 100px;
            }
            
            .brand-logo img {
                width: 70px;
                height: 70px;
            }
            
            .welcome-text h2 {
                font-size: 2rem;
            }
        }
        
        @media (max-width: 992px) {
            .login-container {
                max-width: 90%;
            }
            
            .login-left, .login-right {
                padding: 2.5rem 2rem;
            }
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
                <div class="login-container row g-0">
                    <!-- Left Panel -->
                    <div class="col-lg-5 login-left">
                        <div class="brand-logo">
                            <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" 
                                 alt="HCMUTE Logo" 
                                 onerror="this.style.display='none'; this.parentElement.innerHTML='<i class=\'fas fa-university fa-3x\'></i>';">
                        </div>
                        <div class="welcome-text">
                            <h2>UTESHOP</h2>
                            <p>Chào mừng bạn đến với nền tảng mua sắm trực tuyến dành cho sinh viên HCMUTE. Hãy đăng nhập để khám phá những sản phẩm tuyệt vời!</p>
                            <div class="mt-4">
                                <i class="fas fa-shield-alt fa-2x mb-3" style="opacity: 0.7;"></i>
                                <p style="font-size: 0.9rem; opacity: 0.8;">Bảo mật & An toàn</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Panel -->
                    <div class="col-lg-7 login-right">
                        <div class="login-title">
                            <h3>Đăng nhập</h3>
                            <p class="login-subtitle">Nhập thông tin để đăng nhập vào hệ thống</p>
                        </div>
                        
                        <!-- Error/Success Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>${error}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${success}
                            </div>
                        </c:if>
                        
                        <c:if test="${param.logout eq 'success'}">
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>Đăng xuất thành công!
                            </div>
                        </c:if>
                        
                        <!-- Login Form -->
                        <form method="post" action="${pageContext.request.contextPath}/auth/login" id="loginForm">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="username" name="username" 
                                       placeholder="Tên đăng nhập" required autofocus>
                                <label for="username">
                                    <i class="fas fa-user me-2"></i>Tên đăng nhập
                                </label>
                            </div>
                            
                            <div class="form-floating">
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Mật khẩu" required>
                                <label for="password">
                                    <i class="fas fa-lock me-2"></i>Mật khẩu
                                </label>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="form-check mb-3">
                                    <input type="checkbox" class="form-check-input" id="remember" name="remember">
                                    <label class="form-check-label" for="remember">
                                        Ghi nhớ đăng nhập
                                    </label>
                                </div>
                            </div>
                            
                            <div class="forgot-password">
                                <a href="${pageContext.request.contextPath}/auth/forgot-password">
                                    <i class="fas fa-key me-1"></i>Quên mật khẩu?
                                </a>
                            </div>
                            
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-login" id="loginBtn">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </button>
                            </div>
                        </form>
                        
                        <div class="divider">
                            <span>hoặc</span>
                        </div>
                        
                        <div class="register-link">
                            <p>Chưa có tài khoản? 
                                <a href="${pageContext.request.contextPath}/auth/register">
                                    <i class="fas fa-user-plus me-1"></i>Đăng ký ngay
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('loginForm');
            const loginBtn = document.getElementById('loginBtn');
            
            // Form validation
            form.addEventListener('submit', function(e) {
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value.trim();
                
                if (!username || !password) {
                    e.preventDefault();
                    showNotification('Vui lòng nhập đầy đủ thông tin đăng nhập!', 'error');
                    return;
                }
                
                if (username.length < 3) {
                    e.preventDefault();
                    showNotification('Tên đăng nhập phải có ít nhất 3 ký tự!', 'error');
                    return;
                }
                
                if (password.length < 6) {
                    e.preventDefault();
                    showNotification('Mật khẩu phải có ít nhất 6 ký tự!', 'error');
                    return;
                }
                
                // Show loading state
                loginBtn.disabled = true;
                loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang đăng nhập...';
            });
        });
        
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'alert alert-' + (type === 'error' ? 'danger' : 'success') + ' position-fixed';
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px; animation: slideInRight 0.3s ease;';
            notification.innerHTML = '<i class="fas fa-' + (type === 'error' ? 'exclamation-triangle' : 'check-circle') + ' me-2"></i>' + message;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }
    </script>
</body>
</html>