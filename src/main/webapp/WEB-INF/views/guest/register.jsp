<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>Đăng ký - UTESHOP</title>

<div class="container-fluid vh-100 d-flex align-items-center justify-content-center" style="background: linear-gradient(135deg, #002b5b, #004080);">
    <div class="row w-100">
        <div class="col-md-5 mx-auto">
            <div class="card shadow-lg border-0">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" alt="Logo HCMUTE" width="80" class="mb-3">
                        <h3 class="fw-bold text-primary">Đăng ký UTESHOP</h3>
                        <p class="text-muted">Tạo tài khoản để bắt đầu mua sắm</p>
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

                    <form action="${pageContext.request.contextPath}/guest/register" method="post" id="registerForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="hoTen" class="form-label">Họ và tên</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                                    <input type="text" class="form-control" id="hoTen" name="hoTen" 
                                           placeholder="Nhập họ tên đầy đủ" required value="${hoTen}">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="tenDangNhap" class="form-label">Tên đăng nhập</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-at"></i></span>
                                    <input type="text" class="form-control" id="tenDangNhap" name="tenDangNhap" 
                                           placeholder="Tên đăng nhập" required value="${tenDangNhap}">
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Nhập email của bạn" required value="${email}">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="matKhau" class="form-label">Mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                                    <input type="password" class="form-control" id="matKhau" name="matKhau" 
                                           placeholder="Mật khẩu (ít nhất 6 ký tự)" required minlength="6">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="xacNhanMatKhau" class="form-label">Xác nhận mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                                    <input type="password" class="form-control" id="xacNhanMatKhau" name="xacNhanMatKhau" 
                                           placeholder="Nhập lại mật khẩu" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="soDienThoai" class="form-label">Số điện thoại</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-phone"></i></span>
                                    <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" 
                                           placeholder="Số điện thoại" value="${soDienThoai}">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="vaiTro" class="form-label">Loại tài khoản</label>
                                <select class="form-select" id="vaiTro" name="vaiTro" required>
                                    <option value="">Chọn loại tài khoản</option>
                                    <option value="USER" ${vaiTro == 'USER' ? 'selected' : ''}>Khách hàng</option>
                                    <option value="VENDOR" ${vaiTro == 'VENDOR' ? 'selected' : ''}>Người bán</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="diaChi" class="form-label">Địa chỉ</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-map-marker-alt"></i></span>
                                <textarea class="form-control" id="diaChi" name="diaChi" rows="2" 
                                          placeholder="Nhập địa chỉ của bạn">${diaChi}</textarea>
                            </div>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="dongY" name="dongY" required>
                            <label class="form-check-label" for="dongY">
                                Tôi đồng ý với <a href="#" class="text-decoration-none">Điều khoản sử dụng</a> 
                                và <a href="#" class="text-decoration-none">Chính sách bảo mật</a>
                            </label>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 mb-3">
                            <i class="fa fa-user-plus"></i> Tạo tài khoản
                        </button>

                        <div class="text-center">
                            <p class="mb-0">
                                Đã có tài khoản? 
                                <a href="${pageContext.request.contextPath}/guest/login" class="text-decoration-none fw-bold">
                                    Đăng nhập ngay
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
// Validate password confirmation
document.getElementById('registerForm').addEventListener('submit', function(e) {
    const password = document.getElementById('matKhau').value;
    const confirmPassword = document.getElementById('xacNhanMatKhau').value;
    
    if (password !== confirmPassword) {
        e.preventDefault();
        alert('Mật khẩu xác nhận không khớp!');
    }
});
</script>