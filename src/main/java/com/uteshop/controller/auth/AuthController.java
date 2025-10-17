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
        
        // Ensure UTF-8 encoding for request parameters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean remember = "on".equals(request.getParameter("remember"));

        try {
            // Validate input with proper encoding handling
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập");
                showLoginPage(request, response);
                return;
            }

            // Trim and handle Unicode characters properly
            username = username.trim();
            
            // Authenticate user
            NguoiDung user = nguoiDungDAO.authenticate(username, password);
            
            if (user == null) {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
                showLoginPage(request, response);
                return;
            }

            // Check if account is active
            if (!user.isTrangThai()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ admin");
                showLoginPage(request, response);
                return;
            }

            // Log successful login with role information
            System.out.println("User login successful: " + user.getTenDangNhap() + 
                             " | Role: " + user.getVaiTro().name() + 
                             " | Full Name: " + user.getHoTen());

            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getMaND());
            session.setAttribute("userRole", user.getVaiTro().name());
            session.setAttribute("userName", user.getHoTen());
            session.setMaxInactiveInterval(remember ? 30 * 24 * 60 * 60 : 2 * 60 * 60); // 30 days or 2 hours

            // Set remember me cookie
            if (remember) {
                Cookie userCookie = new Cookie("rememberedUser", username);
                userCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                userCookie.setPath(request.getContextPath());
                response.addCookie(userCookie);
            }

            // Redirect based on user's role from database
            redirectToUserDashboard(user, response, request.getContextPath());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng nhập. Vui lòng thử lại");
            showLoginPage(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Ensure UTF-8 encoding for request parameters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
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
            // Validate input with proper Unicode handling
            if (fullName == null || fullName.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                showRegisterPage(request, response);
                return;
            }

            // Trim inputs and handle Unicode properly
            fullName = fullName.trim();
            username = username.trim();
            email = email.trim();
            phone = phone != null ? phone.trim() : null;
            address = address != null ? address.trim() : null;

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
            if (nguoiDungDAO.findByUsername(username) != null) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại");
                showRegisterPage(request, response);
                return;
            }

            // Check if email exists
            if (nguoiDungDAO.findByEmail(email) != null) {
                request.setAttribute("error", "Email đã được sử dụng");
                showRegisterPage(request, response);
                return;
            }

            // Create new user
            NguoiDung newUser = new NguoiDung();
            newUser.setHoTen(fullName);
            newUser.setTenDangNhap(username);
            newUser.setEmail(email);
            newUser.setSoDienThoai(phone);
            newUser.setDiaChi(address);
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
        // Redirect dựa trên role từ database
        switch (user.getVaiTro()) {
            case ADMIN:
                // Admin -> trang quản lý sản phẩm
                response.sendRedirect(contextPath + "/admin/products");
                break;
            case VENDOR:
                // Vendor -> TẠM THỜI về trang home (dashboard chưa có view)
                // TODO: Sau khi tạo vendor/dashboard.jsp, đổi lại thành /vendor/dashboard
                response.sendRedirect(contextPath + "/guest/home");
                break;
            case SHIPPER:
                // Shipper -> TẠM THỜI về trang home (dashboard chưa có view)
                // TODO: Sau khi tạo shipper/dashboard.jsp, đổi lại thành /shipper/dashboard
                response.sendRedirect(contextPath + "/guest/home");
                break;
            case USER:
            default:
                // User -> trang home
                response.sendRedirect(contextPath + "/guest/home");
                break;
        }
    }
    
    /**
     * Helper method to convert role names to Vietnamese
     */
    private String getVietneseRoleName(String roleName) {
        switch (roleName.toUpperCase()) {
            case "ADMIN":
                return "Quản trị viên";
            case "VENDOR":
                return "Người bán";
            case "SHIPPER":
                return "Shipper";
            case "USER":
                return "Người dùng";
            default:
                return roleName;
        }
    }
}