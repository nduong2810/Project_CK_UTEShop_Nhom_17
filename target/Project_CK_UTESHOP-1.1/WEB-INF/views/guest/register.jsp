<%@ page contentType="text/html;charset=UTF-8" %>
<sitemesh:page title="Đăng ký - UTE SHOP">
<div class="form-container">
    <img src="${pageContext.request.contextPath}/assets/img/logo-hcmute.png" alt="Logo">
    <h2>Tạo tài khoản</h2>
    <form action="RegisterServlet" method="post">
        <input type="text" name="fullname" placeholder="Họ và tên" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <input type="password" name="confirm" placeholder="Nhập lại mật khẩu" required>
        <button class="btn" type="submit">Đăng ký</button>
    </form>
</div>
</sitemesh:page>
