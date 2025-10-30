<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* General Body and Container Styling */
    body {
        background-color: #f0f2f5; /* Light gray background */
        font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    }

    .container {
        padding-top: 50px;
        padding-bottom: 50px;
    }

    /* User Card Styling */
    .user-card {
        background-color: #ffffff;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        transition: all 0.3s ease;
    }

    .user-card:hover {
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
    }

    .user-card .card-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* Modern gradient */
        color: white;
        font-size: 1.5rem;
        font-weight: 600;
        padding: 20px 25px;
        border-bottom: none;
        text-align: center;
    }

    .user-card .card-body {
        padding: 30px 25px;
    }

    /* Form Elements */
    .form-label {
        font-weight: 500;
        color: #333;
        margin-bottom: 8px;
    }

    .input-group {
        position: relative;
    }

    .input-group .form-control {
        padding-left: 45px; /* Space for the icon */
    }

    .input-group-icon {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: #aaa;
        z-index: 3;
    }

    .form-control {
        border-radius: 8px !important; /* Override Bootstrap defaults */
        padding: 12px 15px;
        border: 1px solid #ced4da;
        transition: all 0.3s ease;
        height: 48px;
    }

    .form-control:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        outline: none;
    }

    .form-control:focus ~ .input-group-icon {
        color: #667eea;
    }

    .password-toggle-btn {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        cursor: pointer;
        color: #aaa;
        z-index: 3;
    }

    /* Password Strength Meter */
    #password-strength-meter {
        height: 8px;
        background-color: #e9ecef;
        border-radius: 4px;
        margin-top: 10px;
    }

    #password-strength-bar {
        height: 100%;
        border-radius: 4px;
        transition: all 0.3s ease;
        width: 0;
    }

    .strength-text {
        font-size: 0.85rem;
        font-weight: 500;
        margin-top: 5px;
    }

    /* Buttons */
    .btn-primary-gradient {
        background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
        border: none;
        color: white;
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(118, 75, 162, 0.2);
    }

    .btn-primary-gradient:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(118, 75, 162, 0.3);
        color: white;
    }

    .btn-primary-gradient:disabled {
        opacity: 0.7;
        cursor: not-allowed;
    }

    .btn-action {
        width: 100%;
        margin-top: 15px;
    }

    /* Alerts */
    .alert {
        border-radius: 8px;
        font-size: 0.95rem;
        padding: 15px 20px;
        margin-bottom: 20px;
    }

    /* Link Styling */
    .text-decoration-none {
        color: #667eea;
        font-weight: 500;
        transition: color 0.3s ease;
    }

    .text-decoration-none:hover {
        color: #764ba2;
    }
</style>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="user-card">
                <div class="card-header">
                    Đổi mật khẩu
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${message}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user/change-password" method="post">

                        <%-- Step 1: Current Password Input --%>
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                            <div class="input-group">
                                <i class="fas fa-lock input-group-icon"></i>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required <c:if test="${passwordVerified}">readonly</c:if>>
                                <button type="button" class="password-toggle-btn" onclick="togglePassword('currentPassword', this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <c:if test="${not passwordVerified}">
                            <div class="d-grid gap-2">
                                <button type="submit" name="action" value="verifyPassword" class="btn btn-action btn-primary-gradient">Tiếp tục</button>
                            </div>
                        </c:if>

                        <%-- Step 2: New Password and OTP fields (shown after verification) --%>
                        <c:if test="${passwordVerified}">
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                <div class="input-group">
                                    <i class="fas fa-key input-group-icon"></i>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                    <button type="button" class="password-toggle-btn" onclick="togglePassword('newPassword', this)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div id="password-strength-meter"><div id="password-strength-bar"></div></div>
                                <div id="password-strength-text" class="strength-text"></div>
                            </div>
                            <div class="mb-3">
                                <label for="confirmNewPassword" class="form-label">Xác nhận mật khẩu mới</label>
                                <div class="input-group">
                                    <i class="fas fa-key input-group-icon"></i>
                                    <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
                                     <button type="button" class="password-toggle-btn" onclick="togglePassword('confirmNewPassword', this)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="otp" class="form-label">Mã OTP</label>
                                <div class="input-group">
                                     <i class="fas fa-shield-alt input-group-icon"></i>
                                    <input type="text" class="form-control" id="otp" name="otp" placeholder="Nhập mã OTP đã gửi đến email" required>
                                </div>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" name="action" value="changePassword" class="btn btn-action btn-primary-gradient">Đổi mật khẩu</button>
                            </div>
                        </c:if>

                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/user/profile" class="text-decoration-none">Quay lại hồ sơ</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function togglePassword(fieldId, button) {
        const passwordField = document.getElementById(fieldId);
        const icon = button.querySelector('i');
        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            passwordField.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    function checkPasswordStrength(password) {
        let score = 0;
        if (password.length >= 8) score++;
        if (password.match(/[a-z]/)) score++;
        if (password.match(/[A-Z]/)) score++;
        if (password.match(/[0-9]/)) score++;
        if (password.match(/[^a-zA-Z0-9]/)) score++;

        const bar = document.getElementById('password-strength-bar');
        const text = document.getElementById('password-strength-text');
        
        if (!bar || !text) return;

        switch (score) {
            case 0: case 1:
                bar.style.width = '20%';
                bar.style.backgroundColor = '#dc3545';
                text.textContent = 'Rất yếu';
                text.style.color = '#dc3545';
                break;
            case 2:
                bar.style.width = '40%';
                bar.style.backgroundColor = '#ffc107';
                text.textContent = 'Yếu';
                text.style.color = '#ffc107';
                break;
            case 3:
                bar.style.width = '60%';
                bar.style.backgroundColor = '#0dcaf0';
                text.textContent = 'Trung bình';
                text.style.color = '#0dcaf0';
                break;
            case 4:
                bar.style.width = '80%';
                bar.style.backgroundColor = '#198754';
                text.textContent = 'Mạnh';
                text.style.color = '#198754';
                break;
            case 5:
                bar.style.width = '100%';
                bar.style.backgroundColor = '#198754';
                text.textContent = 'Rất mạnh';
                text.style.color = '#198754';
                break;
        }
        if(password.length === 0) {
             bar.style.width = '0%';
             text.textContent = '';
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const newPasswordField = document.getElementById('newPassword');
        if (newPasswordField) {
            newPasswordField.addEventListener('input', (e) => {
                checkPasswordStrength(e.target.value);
            });
        }
    });
</script>
