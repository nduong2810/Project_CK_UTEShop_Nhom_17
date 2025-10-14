<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>Xác thực OTP - UTESHOP</title>

<div class="container-fluid vh-100 d-flex align-items-center justify-content-center" style="background: linear-gradient(135deg, #002b5b, #004080);">
    <div class="row w-100">
        <div class="col-md-4 mx-auto">
            <div class="card shadow-lg border-0">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" alt="Logo HCMUTE" width="80" class="mb-3">
                        <h3 class="fw-bold text-primary">Xác thực tài khoản</h3>
                        <p class="text-muted">Nhập mã OTP gồm 6 số được gửi qua email của bạn</p>
                    </div>

                    <!-- Error/Success Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fa fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            <i class="fa fa-check-circle"></i> ${success}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth/verify-otp" method="post" id="otpForm">
                        <div class="mb-4">
                            <label class="form-label text-center d-block">Mã OTP</label>
                            <div class="d-flex justify-content-center gap-2 otp-inputs">
                                <input type="text" class="form-control text-center otp-input" maxlength="1" name="otp1" style="width: 50px; height: 50px; font-size: 20px; font-weight: bold;">
                                <input type="text" class="form-control text-center otp-input" maxlength="1" name="otp2" style="width: 50px; height: 50px; font-size: 20px; font-weight: bold;">
                                <input type="text" class="form-control text-center otp-input" maxlength="1" name="otp3" style="width: 50px; height: 50px; font-size: 20px; font-weight: bold;">
                                <input type="text" class="form-control text-center otp-input" maxlength="1" name="otp4" style="width: 50px; height: 50px; font-size: 20px; font-weight: bold;">
                                <input type="text" class="form-control text-center otp-input" maxlength="1" name="otp5" style="width: 50px; height: 50px; font-size: 20px; font-weight: bold;">
                                <input type="text" class="form-control text-center otp-input" maxlength="1" name="otp6" style="width: 50px; height: 50px; font-size: 20px; font-weight: bold;">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 mb-3">
                            <i class="fa fa-check"></i> Xác nhận
                        </button>

                        <div class="text-center">
                            <p class="mb-2">
                                <a href="${pageContext.request.contextPath}/auth/resend-otp" class="text-decoration-none">
                                    <i class="fa fa-redo"></i> Gửi lại mã OTP
                                </a>
                            </p>
                            <hr class="my-3">
                            <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-outline-secondary btn-sm">
                                <i class="fa fa-home"></i> Về trang chủ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Auto focus next OTP input
document.querySelectorAll('.otp-input').forEach((input, index) => {
    input.addEventListener('input', function() {
        if (this.value.length === 1 && index < 5) {
            document.querySelectorAll('.otp-input')[index + 1].focus();
        }
    });
    
    input.addEventListener('keydown', function(e) {
        if (e.key === 'Backspace' && this.value.length === 0 && index > 0) {
            document.querySelectorAll('.otp-input')[index - 1].focus();
        }
    });
});

// Validate OTP form
document.getElementById('otpForm').addEventListener('submit', function(e) {
    const otpInputs = document.querySelectorAll('.otp-input');
    let otp = '';
    
    otpInputs.forEach(input => {
        otp += input.value;
    });
    
    if (otp.length !== 6) {
        e.preventDefault();
        alert('Vui lòng nhập đầy đủ 6 số OTP!');
    }
});
</script>