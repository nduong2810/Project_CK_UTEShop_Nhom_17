<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #28a745 0%, #20c997 100%);
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
        
        .reset-container {
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
        
        .reset-header {
            background: var(--gradient-primary);
            color: white;
            padding: 3rem 2.5rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .reset-header::before {
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
        
        .reset-content {
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
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.15);
            background: white;
            transform: translateY(-2px);
        }
        
        .form-floating label {
            color: #6c757d;
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .btn-reset {
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
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
        }
        
        .btn-reset:hover {
            background: var(--gradient-secondary);
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(40, 167, 69, 0.6);
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
            color: #28a745;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .login-link a:hover {
            color: #20c997;
            text-decoration: underline;
        }
        
        /* Password strength indicator */
        .password-strength {
            margin-top: 0.5rem;
            padding: 0.5rem;
            border-radius: 8px;
            font-size: 0.8rem;
        }
        
        .strength-weak {
            background: rgba(220, 53, 69, 0.1);
            color: #721c24;
            border-left: 3px solid #dc3545;
        }
        
        .strength-medium {
            background: rgba(255, 193, 7, 0.1);
            color: #664d03;
            border-left: 3px solid #ffc107;
        }
        
        .strength-strong {
            background: rgba(40, 167, 69, 0.1);
            color: #155724;
            border-left: 3px solid #28a745;
        }
        
        .password-requirements {
            background: rgba(13, 202, 240, 0.1);
            border-left: 4px solid #0dcaf0;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
        }
        
        .requirement {
            margin: 0.3rem 0;
            color: #6c757d;
        }
        
        .requirement.valid {
            color: #28a745;
        }
        
        .requirement i {
            width: 16px;
            margin-right: 0.5rem;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 1rem 0;
            }
            
            .reset-container {
                margin: 0.5rem;
                border-radius: 20px;
            }
            
            .reset-header {
                padding: 2rem 1.5rem 1.5rem;
            }
            
            .reset-content {
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
    <a href="${pageContext.request.contextPath}/auth/forgot-password" class="back-btn">
        <i class="fas fa-arrow-left me-2"></i>Quay lại
    </a>
    
    <div class="container-fluid d-flex justify-content-center align-items-center min-vh-100">
        <div class="reset-container">
            <!-- Header -->
            <div class="reset-header">
                <div class="brand-logo">
                    <i class="fas fa-lock"></i>
                </div>
                <h2>Đặt lại mật khẩu</h2>
                <p>Tạo mật khẩu mới cho tài khoản của bạn</p>
            </div>
            
            <!-- Content -->
            <div class="reset-content">
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
                    <i class="fas fa-shield-alt me-2"></i>
                    Nhập mật khẩu mới và xác nhận để hoàn tất quá trình đặt lại mật khẩu.
                </div>
                
                <!-- Password Requirements -->
                <div class="password-requirements">
                    <strong><i class="fas fa-info-circle me-2"></i>Yêu cầu mật khẩu:</strong>
                    <div class="requirement" id="req-length">
                        <i class="fas fa-times text-danger"></i>Ít nhất 8 ký tự
                    </div>
                    <div class="requirement" id="req-uppercase">
                        <i class="fas fa-times text-danger"></i>Có ít nhất 1 chữ hoa
                    </div>
                    <div class="requirement" id="req-lowercase">
                        <i class="fas fa-times text-danger"></i>Có ít nhất 1 chữ thường
                    </div>
                    <div class="requirement" id="req-number">
                        <i class="fas fa-times text-danger"></i>Có ít nhất 1 chữ số
                    </div>
                    <div class="requirement" id="req-special">
                        <i class="fas fa-times text-danger"></i>Có ít nhất 1 ký tự đặc biệt (!@#$%^&*)
                    </div>
                </div>
                
                <!-- Reset Password Form -->
                <form id="resetForm">
                    <div class="form-floating">
                        <input type="password" class="form-control" id="newPassword" name="newPassword" 
                               placeholder="Mật khẩu mới" required>
                        <label for="newPassword">
                            <i class="fas fa-lock me-2"></i>Mật khẩu mới
                        </label>
                        <div id="passwordStrength" class="password-strength" style="display: none;"></div>
                    </div>
                    
                    <div class="form-floating">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                               placeholder="Xác nhận mật khẩu" required>
                        <label for="confirmPassword">
                            <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu
                        </label>
                        <div id="passwordMatch" class="password-strength" style="display: none;"></div>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-reset" id="resetBtn" disabled>
                            <i class="fas fa-key me-2"></i>Đặt lại mật khẩu
                        </button>
                    </div>
                </form>
                
                <!-- Login Link -->
                <div class="login-link">
                    <p>Đã có mật khẩu mới? 
                        <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập ngay</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const resetForm = document.getElementById('resetForm');
            const resetBtn = document.getElementById('resetBtn');
            const newPasswordInput = document.getElementById('newPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const passwordStrength = document.getElementById('passwordStrength');
            const passwordMatch = document.getElementById('passwordMatch');
            
            // Password requirements elements
            const reqLength = document.getElementById('req-length');
            const reqUppercase = document.getElementById('req-uppercase');
            const reqLowercase = document.getElementById('req-lowercase');
            const reqNumber = document.getElementById('req-number');
            const reqSpecial = document.getElementById('req-special');
            
            // Password validation
            newPasswordInput.addEventListener('input', function() {
                const password = this.value;
                validatePassword(password);
                checkFormValidity();
            });
            
            confirmPasswordInput.addEventListener('input', function() {
                const password = newPasswordInput.value;
                const confirmPassword = this.value;
                validatePasswordMatch(password, confirmPassword);
                checkFormValidity();
            });
            
            // Form submission
            resetForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const newPassword = newPasswordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                
                if (!isValidPassword(newPassword)) {
                    showNotification('Mật khẩu không đáp ứng yêu cầu bảo mật!', 'error');
                    return;
                }
                
                if (newPassword !== confirmPassword) {
                    showNotification('Mật khẩu xác nhận không khớp!', 'error');
                    return;
                }
                
                resetBtn.disabled = true;
                resetBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                
                fetch('${pageContext.request.contextPath}/auth/reset-password', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'newPassword=' + encodeURIComponent(newPassword) + 
                          '&confirmPassword=' + encodeURIComponent(confirmPassword)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showNotification('Đặt lại mật khẩu thành công!', 'success');
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/auth/login';
                        }, 2000);
                    } else {
                        showNotification(data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showNotification('Có lỗi xảy ra khi đặt lại mật khẩu', 'error');
                })
                .finally(() => {
                    resetBtn.disabled = false;
                    resetBtn.innerHTML = '<i class="fas fa-key me-2"></i>Đặt lại mật khẩu';
                });
            });
            
            function validatePassword(password) {
                const requirements = {
                    length: password.length >= 8,
                    uppercase: /[A-Z]/.test(password),
                    lowercase: /[a-z]/.test(password),
                    number: /[0-9]/.test(password),
                    special: /[!@#$%^&*(),.?":{}|<>]/.test(password)
                };
                
                // Update requirement indicators
                updateRequirement(reqLength, requirements.length);
                updateRequirement(reqUppercase, requirements.uppercase);
                updateRequirement(reqLowercase, requirements.lowercase);
                updateRequirement(reqNumber, requirements.number);
                updateRequirement(reqSpecial, requirements.special);
                
                // Show strength indicator
                const strength = calculatePasswordStrength(requirements);
                showPasswordStrength(strength);
            }
            
            function updateRequirement(element, isValid) {
                const icon = element.querySelector('i');
                if (isValid) {
                    icon.className = 'fas fa-check text-success';
                    element.classList.add('valid');
                } else {
                    icon.className = 'fas fa-times text-danger';
                    element.classList.remove('valid');
                }
            }
            
            function calculatePasswordStrength(requirements) {
                const validCount = Object.values(requirements).filter(Boolean).length;
                if (validCount < 3) return 'weak';
                if (validCount < 5) return 'medium';
                return 'strong';
            }
            
            function showPasswordStrength(strength) {
                passwordStrength.style.display = 'block';
                passwordStrength.className = 'password-strength strength-' + strength;
                
                const messages = {
                    weak: '<i class="fas fa-exclamation-triangle me-2"></i>Mật khẩu yếu',
                    medium: '<i class="fas fa-exclamation-circle me-2"></i>Mật khẩu trung bình',
                    strong: '<i class="fas fa-check-circle me-2"></i>Mật khẩu mạnh'
                };
                
                passwordStrength.innerHTML = messages[strength];
            }
            
            function validatePasswordMatch(password, confirmPassword) {
                if (confirmPassword.length === 0) {
                    passwordMatch.style.display = 'none';
                    return;
                }
                
                passwordMatch.style.display = 'block';
                
                if (password === confirmPassword) {
                    passwordMatch.className = 'password-strength strength-strong';
                    passwordMatch.innerHTML = '<i class="fas fa-check-circle me-2"></i>Mật khẩu khớp';
                } else {
                    passwordMatch.className = 'password-strength strength-weak';
                    passwordMatch.innerHTML = '<i class="fas fa-times-circle me-2"></i>Mật khẩu không khớp';
                }
            }
            
            function isValidPassword(password) {
                return password.length >= 8 &&
                       /[A-Z]/.test(password) &&
                       /[a-z]/.test(password) &&
                       /[0-9]/.test(password) &&
                       /[!@#$%^&*(),.?":{}|<>]/.test(password);
            }
            
            function checkFormValidity() {
                const password = newPasswordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                
                const isValid = isValidPassword(password) && 
                               password === confirmPassword && 
                               password.length > 0 && 
                               confirmPassword.length > 0;
                
                resetBtn.disabled = !isValid;
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
                }, 5000);
            }
        });
    </script>
</body>
</html>