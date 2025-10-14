<%@ page contentType="text/html;charset=UTF-8" %>
<sitemesh:page title="Xác thực OTP - UTE SHOP">
<div class="form-container">
    <img src="${pageContext.request.contextPath}/assets/img/logo-hcmute.png" alt="Logo">
    <h2>Xác thực tài khoản</h2>
    <p style="text-align:center;">Nhập mã OTP gồm 6 số được gửi qua email của bạn</p>
    <form action="VerifyOtpServlet" method="post">
        <div class="otp-inputs">
            <input type="text" maxlength="1" name="otp1">
            <input type="text" maxlength="1" name="otp2">
            <input type="text" maxlength="1" name="otp3">
            <input type="text" maxlength="1" name="otp4">
            <input type="text" maxlength="1" name="otp5">
            <input type="text" maxlength="1" name="otp6">
        </div>
        <button class="btn" type="submit">Xác nhận</button>
    </form>
</div>
</sitemesh:page>
