package com.uteshop.controller.auth;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.dao.DonViVanChuyenDAO;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.DonViVanChuyen;
import com.uteshop.util.PasswordUtil;
import com.uteshop.service.EmailService;
import com.uteshop.util.JwtUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/auth/login", "/auth/register", "/auth/logout"})
public class AuthController extends HttpServlet {
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final DonViVanChuyenDAO donViVanChuyenDAO = new DonViVanChuyenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/auth/login":
                showLoginPage(request, response);
                break;
            case "/auth/register":
                showRegisterPage(request, response);
                break;
            case "/auth/logout":
                handleLogout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/guest/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/auth/login":
                handleLogin(request, response);
                break;
            case "/auth/register":
                handleRegister(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/guest/home");
        }
    }

    /** ---------------------- LOGIN ---------------------- */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean remember = "on".equals(request.getParameter("remember"));

        try {
            if (username == null || username.trim().isEmpty() ||
                    password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập");
                showLoginPage(request, response);
                return;
            }

            username = username.trim();
            NguoiDung user = nguoiDungDAO.authenticate(username, password);

            if (user == null) {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
                showLoginPage(request, response);
                return;
            }

            if (!user.getTrangThai()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ admin");
                showLoginPage(request, response);
                return;
            }

            // Log thông tin người dùng
            System.out.println("✅ Login: " + user.getTenDangNhap() + " | Role: " + user.getVaiTro());

            // ✅ Sinh JWT token
            String token = JwtUtil.generateToken(user.getTenDangNhap(), user.getVaiTro().name());

            // ✅ Lưu JWT trong cookie HttpOnly (an toàn)
            Cookie jwtCookie = new Cookie("jwt_token", token);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
            jwtCookie.setMaxAge(24 * 60 * 60); // 1 ngày
            response.addCookie(jwtCookie);

            // ✅ Lưu thông tin session (không thay đổi logic cũ)
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getMaND());
            session.setAttribute("userRole", user.getVaiTro().name());
            session.setAttribute("userName", user.getHoTen());
            session.setMaxInactiveInterval(remember ? 30 * 24 * 60 * 60 : 2 * 60 * 60);

            // ✅ Cookie "Remember me" (cũ, giữ nguyên)
            if (remember) {
                Cookie userCookie = new Cookie("rememberedUser", username);
                userCookie.setMaxAge(30 * 24 * 60 * 60);
                userCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                response.addCookie(userCookie);
            }

            redirectToUserDashboard(user, response, request.getContextPath());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng nhập. Vui lòng thử lại");
            showLoginPage(request, response);
        }
    }

    /** ---------------------- REGISTER ---------------------- */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");
        String donViVanChuyenId = request.getParameter("donViVanChuyen");

        try {
            if (firstName == null || lastName == null || username == null || email == null ||
                    phone == null || address == null || password == null || gender == null ||
                    firstName.trim().isEmpty() || username.trim().isEmpty() || email.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                showRegisterPage(request, response);
                return;
            }
            
            // Kiểm tra nếu đăng ký là shipper thì phải chọn đơn vị vận chuyển
            if ("shipper".equalsIgnoreCase(role) && (donViVanChuyenId == null || donViVanChuyenId.trim().isEmpty())) {
                request.setAttribute("error", "Shipper phải chọn đơn vị vận chuyển");
                showRegisterPage(request, response);
                return;
            }

            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp");
                showRegisterPage(request, response);
                return;
            }

            if (password.length() < 6) {
                request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
                showRegisterPage(request, response);
                return;
            }

            HttpSession session = request.getSession(false);
            if (session == null || !Boolean.TRUE.equals(session.getAttribute("otp_verified"))) {
                request.setAttribute("error", "Vui lòng xác thực OTP trước khi đăng ký");
                showRegisterPage(request, response);
                return;
            }

            String verifiedIdentifier = (String) session.getAttribute("verified_identifier");
            String verifiedType = (String) session.getAttribute("verified_type");
            if (verifiedIdentifier == null || verifiedType == null ||
                    !verifiedType.equals("EMAIL") || !verifiedIdentifier.equalsIgnoreCase(email)) {
                request.setAttribute("error", "Email đã xác thực không khớp với email trong form");
                showRegisterPage(request, response);
                return;
            }

            if (nguoiDungDAO.isUsernameExists(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại");
                showRegisterPage(request, response);
                return;
            }

            if (nguoiDungDAO.isEmailExists(email)) {
                request.setAttribute("error", "Email đã được sử dụng");
                showRegisterPage(request, response);
                return;
            }

            if (nguoiDungDAO.isPhoneExists(phone)) {
                request.setAttribute("error", "Số điện thoại đã được sử dụng");
                showRegisterPage(request, response);
                return;
            }

            NguoiDung newUser = new NguoiDung();
            newUser.setHoTen(lastName.trim() + " " + firstName.trim());
            newUser.setTenDangNhap(username.trim());
            newUser.setEmail(email.trim());
            newUser.setSoDienThoai(phone.trim());
            newUser.setDiaChi(address.trim());
            newUser.setMatKhau(PasswordUtil.hashPassword(password));
            newUser.setGioiTinh(gender);
            newUser.setTrangThai(true);
            newUser.setNgayTao(new java.util.Date());

            try {
                newUser.setVaiTro(NguoiDung.VaiTro.valueOf(role.toUpperCase()));
            } catch (Exception e) {
                newUser.setVaiTro(NguoiDung.VaiTro.USER);
            }
            
            // Nếu là shipper, gán đơn vị vận chuyển
            if ("shipper".equalsIgnoreCase(role) && donViVanChuyenId != null && !donViVanChuyenId.trim().isEmpty()) {
                try {
                    int maVC = Integer.parseInt(donViVanChuyenId);
                    DonViVanChuyen donViVanChuyen = donViVanChuyenDAO.findById(maVC);
                    if (donViVanChuyen != null) {
                        newUser.setDonViVanChuyen(donViVanChuyen);
                        System.out.println("✅ Shipper được gán đơn vị vận chuyển: " + donViVanChuyen.getTenDonVi());
                    } else {
                        request.setAttribute("error", "Đơn vị vận chuyển không tồn tại");
                        showRegisterPage(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Mã đơn vị vận chuyển không hợp lệ");
                    showRegisterPage(request, response);
                    return;
                }
            }

            boolean success = nguoiDungDAO.save(newUser);
            if (success) {
                session.removeAttribute("otp_verified");
                session.removeAttribute("verified_identifier");
                session.removeAttribute("verified_type");

                try {
                    EmailService.getInstance().sendWelcomeEmail(email, firstName);
                } catch (Exception e) {
                    System.err.println("Không gửi được email chào mừng: " + e.getMessage());
                }

                request.setAttribute("message", "Đăng ký thành công! Mời bạn đăng nhập để tiếp tục.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                showRegisterPage(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi đăng ký: " + e.getMessage());
            showRegisterPage(request, response);
        }
    }

    /** ---------------------- LOGOUT ---------------------- */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();

        // Xóa cookie "remember me"
        Cookie rememberedUser = new Cookie("rememberedUser", "");
        rememberedUser.setMaxAge(0);
        rememberedUser.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        response.addCookie(rememberedUser);

        // Xóa JWT token
        Cookie jwtCookie = new Cookie("jwt_token", "");
        jwtCookie.setMaxAge(0);
        jwtCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        response.addCookie(jwtCookie);

        response.sendRedirect(request.getContextPath() + "/guest/home?logout=success");
    }

    /** ---------------------- PAGE HANDLER ---------------------- */
    private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            NguoiDung user = (NguoiDung) session.getAttribute("user");
            redirectToUserDashboard(user, response, request.getContextPath());
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Load danh sách đơn vị vận chuyển cho shipper
        List<DonViVanChuyen> danhSachDonViVanChuyen = donViVanChuyenDAO.findAll();
        request.setAttribute("danhSachDonViVanChuyen", danhSachDonViVanChuyen);
        
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    private void redirectToUserDashboard(NguoiDung user, HttpServletResponse response, String contextPath)
            throws IOException {
        switch (user.getVaiTro()) {
            case ADMIN:
                response.sendRedirect(contextPath + "/admin/home");
                break;
            case VENDOR:
            case SHIPPER:
                response.sendRedirect(contextPath + "/guest/home");
                break;
            default:
                response.sendRedirect(contextPath + "/guest/home");
        }
    }
}
