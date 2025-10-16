<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        }
        
        body {
            background: var(--gradient-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 2rem 0;
        }
        
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            overflow: hidden;
            max-width: 1000px;
            width: 100%;
        }
        
        .register-left {
            background: var(--gradient-secondary);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }
        
        .register-right {
            padding: 3rem 2rem;
        }
        
        .brand-logo {
            width: 60px;
            height: 60px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 1.5rem;
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
        
        .btn-register {
            background: var(--gradient-primary);
            border: none;
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-register:hover {
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
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: #667eea;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
        }
        
        .password-strength {
            height: 4px;
            border-radius: 2px;
            margin-top: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .strength-weak { background: #dc3545; }
        .strength-medium { background: #ffc107; }
        .strength-strong { background: #28a745; }
        
        .vendor-info {
            background: #f8f9ff;
            border: 1px solid #e3e8ff;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1rem;
            display: none;
        }
        
        .vendor-info.show {
            display: block;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="register-container row g-0">
                    <!-- Left Side - Info -->
                    <div class="col-md-5 register-left">
                        <div class="brand-logo">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <h3 class="fw-bold mb-3">Tham gia UTESHOP</h3>
                        <p class="mb-4">Bắt đầu hành trình mua sắm hoặc kinh doanh của bạn</p>
                        
                        <div class="benefits">
                            <div class="benefit-item mb-3">
                                <i class="fas fa-user-friends me-2"></i>
                                Cộng đồng HCMUTE tin cậy
                            </div>
                            <div class="benefit-item mb-3">
                                <i class="fas fa-shield-alt me-2"></i>
                                Bảo mật thông tin tuyệt đối
                            </div>
                            <div class="benefit-item mb-3">
                                <i class="fas fa-headset me-2"></i>
                                Hỗ trợ 24/7
                            </div>
                            <div class="benefit-item">
                                <i class="fas fa-gift me-2"></i>
                                Ưu đãi đặc biệt cho sinh viên
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Side - Register Form -->
                    <div class="col-md-7 register-right">
                        <div class="text-center mb-4">
                            <h3 class="fw-bold">Đăng Ký Tài Khoản</h3>
                            <p class="text-muted">Tạo tài khoản mới để bắt đầu</p>
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
                        
                        <form method="POST" action="${pageContext.request.contextPath}/auth/register" id="registerForm">
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
                                    <small class="text-muted">Mở shop và bán hàng</small>
                                </label>
                            </div>
                            
                            <!-- Vendor Additional Info -->
                            <div class="vendor-info" id="vendorInfo">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="fas fa-info-circle text-primary me-2"></i>
                                    <strong>Thông tin bổ sung cho Người bán</strong>
                                </div>
                                <p class="small text-muted mb-0">
                                    Để trở thành người bán, bạn cần cung cấp thêm thông tin về shop và được phê duyệt bởi admin.
                                </p>
                            </div>
                            
                            <div class="row">
                                <!-- Full Name -->
                                <div class="col-md-6 mb-3">
                                    <label for="fullName" class="form-label">Họ và tên *</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" required 
                                           placeholder="Nguyễn Văn A">
                                </div>
                                
                                <!-- Username -->
                                <div class="col-md-6 mb-3">
                                    <label for="username" class="form-label">Tên đăng nhập *</label>
                                    <input type="text" class="form-control" id="username" name="username" required 
                                           placeholder="username123" pattern="[a-zA-Z0-9_]{3,20}">
                                    <div class="form-text">3-20 ký tự, chỉ chữ, số và dấu gạch dưới</div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <!-- Email -->
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email *</label>
                                    <input type="email" class="form-control" id="email" name="email" required 
                                           placeholder="student@student.hcmute.edu.vn">
                                    <div class="form-text">Khuyến khích dùng email sinh viên HCMUTE</div>
                                </div>
                                
                                <!-- Phone -->
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           placeholder="0901234567" pattern="[0-9]{10,11}">
                                </div>
                            </div>
                            
                            <!-- Address -->
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <textarea class="form-control" id="address" name="address" rows="2" 
                                          placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố"></textarea>
                            </div>
                            
                            <div class="row">
                                <!-- Password -->
                                <div class="col-md-6 mb-3">
                                    <label for="password" class="form-label">Mật khẩu *</label>
                                    <input type="password" class="form-control" id="password" name="password" required 
                                           placeholder="Nhập mật khẩu" onkeyup="checkPasswordStrength()">
                                    <div class="password-strength" id="passwordStrength"></div>
                                    <div class="form-text">Tối thiểu 6 ký tự, có chữ hoa, chữ thường và số</div>
                                </div>
                                
                                <!-- Confirm Password -->
                                <div class="col-md-6 mb-3">
                                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu *</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required 
                                           placeholder="Nhập lại mật khẩu" onkeyup="checkPasswordMatch()">
                                    <div id="passwordMatch" class="form-text"></div>
                                </div>
                            </div>
                            
                            <!-- Terms and Conditions -->
                            <div class="mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="terms" name="terms" required>
                                    <label class="form-check-label" for="terms">
                                        Tôi đồng ý với 
                                        <a href="${pageContext.request.contextPath}/terms" target="_blank">Điều khoản sử dụng</a> 
                                        và 
                                        <a href="${pageContext.request.contextPath}/privacy" target="_blank">Chính sách bảo mật</a>
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="newsletter" name="newsletter">
                                    <label class="form-check-label" for="newsletter">
                                        Đăng ký nhận thông báo khuyến mãi và tin tức
                                    </label>
                                </div>
                            </div>
                            
                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-register mb-3">
                                <i class="fas fa-user-plus me-2"></i>Đăng Ký Tài Khoản
                            </button>
                            
                            <!-- Login Link -->
                            <div class="text-center">
                                <span class="text-muted">Đã có tài khoản? </span>
                                <a href="${pageContext.request.contextPath}/auth/login" 
                                   class="text-decoration-none fw-bold">Đăng nhập ngay</a>
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
                
                // Show/hide vendor info
                const vendorInfo = document.getElementById('vendorInfo');
                if (this.value === 'VENDOR') {
                    vendorInfo.classList.add('show');
                } else {
                    vendorInfo.classList.remove('show');
                }
            });
        });
        
        // Password strength checker
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('passwordStrength');
            let strength = 0;
            
            if (password.length >= 6) strength++;
            if (password.match(/[a-z]/)) strength++;
            if (password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^A-Za-z0-9]/)) strength++;
            
            strengthBar.classList.remove('strength-weak', 'strength-medium', 'strength-strong');
            
            if (strength <= 2) {
                strengthBar.classList.add('strength-weak');
            } else if (strength <= 3) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        }
        
        // Password match checker
        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchDiv = document.getElementById('passwordMatch');
            
            if (confirmPassword === '') {
                matchDiv.textContent = '';
                return;
            }
            
            if (password === confirmPassword) {
                matchDiv.textContent = '✓ Mật khẩu khớp';
                matchDiv.style.color = '#28a745';
            } else {
                matchDiv.textContent = '✗ Mật khẩu không khớp';
                matchDiv.style.color = '#dc3545';
            }
        }
        
        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return false;
            }
        });
        
        // Initialize role selection
        document.getElementById('roleUser').parentElement.classList.add('active');
    </script>
</body>
</html>