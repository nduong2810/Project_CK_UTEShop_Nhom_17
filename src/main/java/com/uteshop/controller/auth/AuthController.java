package com.uteshop.controller.auth;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;
import com.uteshop.util.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(urlPatterns = {"/auth/login", "/auth/register", "/auth/logout"})
public class AuthController extends HttpServlet {
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();

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

    private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu đã đăng nhập, redirect về trang tương ứng
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            NguoiDung user = (NguoiDung) session.getAttribute("user");
            redirectToUserDashboard(user, response, request.getContextPath());
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
        dispatcher.forward(request, response);
    }

    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp");
        dispatcher.forward(request, response);
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        boolean remember = "on".equals(request.getParameter("remember"));

        try {
            // Validate input
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập");
                showLoginPage(request, response);
                return;
            }

            // Authenticate user
            NguoiDung user = nguoiDungDAO.authenticate(username.trim(), password);
            
            if (user == null) {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
                showLoginPage(request, response);
                return;
            }

            if (!user.isTrangThai()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ admin");
                showLoginPage(request, response);
                return;
            }

            // Check role match
            if (role != null && !role.isEmpty() && !user.getVaiTro().name().equals(role)) {
                request.setAttribute("error", "Vai trò đăng nhập không khớp với tài khoản");
                showLoginPage(request, response);
                return;
            }

            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getMaND());
            session.setAttribute("userRole", user.getVaiTro().name());
            session.setMaxInactiveInterval(remember ? 30 * 24 * 60 * 60 : 2 * 60 * 60); // 30 days or 2 hours

            // Set remember me cookie
            if (remember) {
                Cookie userCookie = new Cookie("rememberedUser", username);
                userCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                userCookie.setPath(request.getContextPath());
                response.addCookie(userCookie);
            }

            // Redirect based on role
            redirectToUserDashboard(user, response, request.getContextPath());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng nhập. Vui lòng thử lại");
            showLoginPage(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        boolean newsletter = "on".equals(request.getParameter("newsletter"));

        try {
            // Validate input
            if (fullName == null || fullName.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
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

            // Check if username exists
            if (nguoiDungDAO.findByUsername(username.trim()) != null) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại");
                showRegisterPage(request, response);
                return;
            }

            // Check if email exists
            if (nguoiDungDAO.findByEmail(email.trim()) != null) {
                request.setAttribute("error", "Email đã được sử dụng");
                showRegisterPage(request, response);
                return;
            }

            // Create new user
            NguoiDung newUser = new NguoiDung();
            newUser.setHoTen(fullName.trim());
            newUser.setTenDangNhap(username.trim());
            newUser.setEmail(email.trim());
            newUser.setSoDienThoai(phone != null ? phone.trim() : null);
            newUser.setDiaChi(address != null ? address.trim() : null);
            newUser.setMatKhau(PasswordUtil.hashPassword(password));
            newUser.setVaiTro(NguoiDung.VaiTro.valueOf(role != null ? role : "USER"));
            newUser.setTrangThai(true);
            newUser.setNgayTao(LocalDateTime.now());

            // Save user
            boolean success = nguoiDungDAO.save(newUser);
            
            if (success) {
                request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập để tiếp tục");
                showLoginPage(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại");
                showRegisterPage(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại");
            showRegisterPage(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Remove remember me cookie
        Cookie userCookie = new Cookie("rememberedUser", "");
        userCookie.setMaxAge(0);
        userCookie.setPath(request.getContextPath());
        response.addCookie(userCookie);

        response.sendRedirect(request.getContextPath() + "/guest/home?logout=success");
    }

    private void redirectToUserDashboard(NguoiDung user, HttpServletResponse response, String contextPath)
            throws IOException {
        switch (user.getVaiTro()) {
            case ADMIN:
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case VENDOR:
                response.sendRedirect(contextPath + "/vendor/dashboard");
                break;
            case SHIPPER:
                response.sendRedirect(contextPath + "/shipper/dashboard");
                break;
            case USER:
            default:
                response.sendRedirect(contextPath + "/user/dashboard");
                break;
        }
    }
}