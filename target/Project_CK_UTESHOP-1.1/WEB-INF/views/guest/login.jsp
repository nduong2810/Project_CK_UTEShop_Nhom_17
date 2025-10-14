<%@ page contentType="text/html;charset=UTF-8" %>
<sitemesh:page title="Đăng nhập - UTE SHOP">
<div class="form-container">
    <img src="${pageContext.request.contextPath}/assets/img/logo-hcmute.png" alt="Logo">
    <h2>Đăng nhập</h2>
    <form action="LoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <button class="btn" type="submit">Đăng nhập</button>
        <p style="text-align:center; margin-top:10px;">
            <a href="register.jsp">Chưa có tài khoản? Đăng ký</a><br>
            <a href="verify-otp.jsp">Quên mật khẩu?</a>
        </p>
    </form>
</div>
</sitemesh:page>
