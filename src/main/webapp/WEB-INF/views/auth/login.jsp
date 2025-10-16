<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        }
        
        body {
            background: var(--gradient-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }
        
        .login-left {
            background: var(--gradient-secondary);
            color: white;
            padding: 4rem 3rem;
            text-align: center;
        }
        
        .login-right {
            padding: 4rem 3rem;
        }
        
        .brand-logo {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            font-size: 2rem;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-login {
            background: var(--gradient-primary);
            border: none;
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .role-selection {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .role-card {
            flex: 1;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .role-card:hover, .role-card.active {
            border-color: #667eea;
            background: #f8f9ff;
        }
        
        .role-card input[type="radio"] {
            display: none;
        }
        
        .role-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: #667eea;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="login-container row g-0">
                    <!-- Left Side - Welcome -->
                    <div class="col-md-6 login-left">
                        <div class="brand-logo">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <h2 class="fw-bold mb-3">Chào mừng đến UTESHOP</h2>
                        <p class="mb-4">Nền tảng thương mại điện tử dành cho cộng đồng HCMUTE</p>
                        
                        <div class="features">
                            <div class="feature-item mb-3">
                                <i class="fas fa-check-circle me-2"></i>
                                Mua sắm dễ dàng và an toàn
                            </div>
                            <div class="feature-item mb-3">
                                <i class="fas fa-check-circle me-2"></i>
                                Đa dạng sản phẩm từ các shop uy tín
                            </div>
                            <div class="feature-item mb-3">
                                <i class="fas fa-check-circle me-2"></i>
                                Hỗ trợ thanh toán đa dạng
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle me-2"></i>
                                Dành cho sinh viên HCMUTE
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Side - Login Form -->
                    <div class="col-md-6 login-right">
                        <div class="text-center mb-4">
                            <h3 class="fw-bold">Đăng Nhập</h3>
                            <p class="text-muted">Truy cập vào tài khoản của bạn</p>
                        </div>
                        
                        <!-- Error/Success Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle me-2"></i>
                                ${success}
                            </div>
                        </c:if>
                        
                        <form method="POST" action="${pageContext.request.contextPath}/auth/login">
                            <!-- Role Selection -->
                            <div class="role-selection">
                                <label class="role-card" for="roleUser">
                                    <input type="radio" name="role" value="USER" id="roleUser" checked>
                                    <div class="role-icon">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="fw-bold">Khách hàng</div>
                                    <small class="text-muted">Mua sắm và đặt hàng</small>
                                </label>
                                
                                <label class="role-card" for="roleVendor">
                                    <input type="radio" name="role" value="VENDOR" id="roleVendor">
                                    <div class="role-icon">
                                        <i class="fas fa-store"></i>
                                    </div>
                                    <div class="fw-bold">Người bán</div>
                                    <small class="text-muted">Quản lý shop và bán hàng</small>
                                </label>
                            </div>
                            
                            <!-- Username/Email -->
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập hoặc Email</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fas fa-user text-muted"></i>
                                    </span>
                                    <input type="text" class="form-control border-start-0" 
                                           id="username" name="username" required 
                                           placeholder="Nhập tên đăng nhập hoặc email">
                                </div>
                            </div>
                            
                            <!-- Password -->
                            <div class="mb-3">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fas fa-lock text-muted"></i>
                                    </span>
                                    <input type="password" class="form-control border-start-0" 
                                           id="password" name="password" required 
                                           placeholder="Nhập mật khẩu">
                                    <button class="btn btn-outline-secondary border-start-0" 
                                            type="button" onclick="togglePassword()">
                                        <i class="fas fa-eye" id="toggleIcon"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Remember & Forgot -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="remember" name="remember">
                                    <label class="form-check-label" for="remember">
                                        Ghi nhớ đăng nhập
                                    </label>
                                </div>
                                <a href="${pageContext.request.contextPath}/auth/forgot-password" 
                                   class="text-decoration-none">Quên mật khẩu?</a>
                            </div>
                            
                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-login mb-3">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                            </button>
                            
                            <!-- Register Link -->
                            <div class="text-center">
                                <span class="text-muted">Chưa có tài khoản? </span>
                                <a href="${pageContext.request.contextPath}/auth/register" 
                                   class="text-decoration-none fw-bold">Đăng ký ngay</a>
                            </div>
                            
                            <!-- Back to Home -->
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/guest/home" 
                                   class="text-muted text-decoration-none">
                                    <i class="fas fa-arrow-left me-1"></i>Về trang chủ
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Role selection
        document.querySelectorAll('input[name="role"]').forEach(radio => {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.role-card').forEach(card => {
                    card.classList.remove('active');
                });
                this.parentElement.classList.add('active');
            });
        });
        
        // Toggle password visibility
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        // Initialize role selection
        document.getElementById('roleUser').parentElement.classList.add('active');
    </script>
</body>
</html>