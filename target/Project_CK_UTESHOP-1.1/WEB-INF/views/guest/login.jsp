<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>Đăng nhập - UTESHOP</title>

<div class="container-fluid vh-100 d-flex align-items-center justify-content-center" style="background: linear-gradient(135deg, #002b5b, #004080);">
    <div class="row w-100">
        <div class="col-md-4 mx-auto">
            <div class="card shadow-lg border-0">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" alt="Logo HCMUTE" width="80" class="mb-3">
                        <h3 class="fw-bold text-primary">Đăng nhập UTESHOP</h3>
                        <p class="text-muted">Chào mừng bạn quay trở lại!</p>
                    </div>

                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fa fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth/login" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Nhập email của bạn" required value="${email}">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Nhập mật khẩu" required>
                            </div>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="remember" name="remember">
                            <label class="form-check-label" for="remember">Ghi nhớ đăng nhập</label>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 mb-3">
                            <i class="fa fa-sign-in-alt"></i> Đăng nhập
                        </button>

                        <div class="text-center">
                            <p class="mb-2">
                                <a href="${pageContext.request.contextPath}/auth/forgot-password" class="text-decoration-none">
                                    <i class="fa fa-question-circle"></i> Quên mật khẩu?
                                </a>
                            </p>
                            <p class="mb-0">
                                Chưa có tài khoản? 
                                <a href="${pageContext.request.contextPath}/auth/register" class="text-decoration-none fw-bold">
                                    Đăng ký ngay
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