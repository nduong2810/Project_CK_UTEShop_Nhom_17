package com.uteshop.controller.auth;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;
import com.uteshop.util.PasswordUtil;
import com.uteshop.service.EmailService;

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
        
        // Get form parameters
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

        try {
            // Validate input
            if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                gender == null || gender.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                showRegisterPage(request, response);
                return;
            }

            // Trim inputs
            firstName = firstName.trim();
            lastName = lastName.trim();
            username = username.trim();
            email = email.trim();
            phone = phone.trim();
            address = address.trim();

            // Combine first and last name
            String fullName = lastName + " " + firstName;

            // Validate password match
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

            // Check OTP verification
            HttpSession session = request.getSession(false);
            if (session == null || 
                !Boolean.TRUE.equals(session.getAttribute("otp_verified"))) {
                request.setAttribute("error", "Vui lòng xác thực OTP trước khi đăng ký");
                showRegisterPage(request, response);
                return;
            }

            // Get verified contact info from session
            String verifiedIdentifier = (String) session.getAttribute("verified_identifier");
            String verifiedType = (String) session.getAttribute("verified_type");
            
            if (verifiedIdentifier == null || verifiedType == null) {
                request.setAttribute("error", "Phiên xác thực OTP đã hết hạn. Vui lòng thử lại");
                showRegisterPage(request, response);
                return;
            }

            // Validate that the verified contact matches form input (chỉ EMAIL)
            if (!verifiedType.equals("EMAIL") || !verifiedIdentifier.equalsIgnoreCase(email)) {
                request.setAttribute("error", "Email đã xác thực không khớp với email trong form");
                showRegisterPage(request, response);
                return;
            }

            // Check if username exists
            if (nguoiDungDAO.isUsernameExists(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại");
                showRegisterPage(request, response);
                return;
            }

            // Check if email exists
            if (nguoiDungDAO.isEmailExists(email)) {
                request.setAttribute("error", "Email đã được sử dụng");
                showRegisterPage(request, response);
                return;
            }

            // Check if phone exists
            if (nguoiDungDAO.isPhoneExists(phone)) {
                request.setAttribute("error", "Số điện thoại đã được sử dụng");
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
            
            // Set role
            if (role != null && !role.trim().isEmpty()) {
                try {
                    NguoiDung.VaiTro vaiTro = NguoiDung.VaiTro.valueOf(role.toUpperCase());
                    newUser.setVaiTro(vaiTro);
                } catch (IllegalArgumentException e) {
                    newUser.setVaiTro(NguoiDung.VaiTro.USER); // Default to USER
                }
            } else {
                newUser.setVaiTro(NguoiDung.VaiTro.USER);
            }
            
            newUser.setTrangThai(true);
            newUser.setNgayTao(LocalDateTime.now());

            // Save user
            boolean success = nguoiDungDAO.save(newUser);
            
            if (success) {
                // Clear OTP session data
                session.removeAttribute("otp_verified");
                session.removeAttribute("verified_identifier");
                session.removeAttribute("verified_type");
                session.removeAttribute("otp_identifier");
                session.removeAttribute("otp_type");
                
                // Send welcome email
                try {
                    EmailService.getInstance().sendWelcomeEmail(email, firstName);
                } catch (Exception e) {
                    System.err.println("Failed to send welcome email: " + e.getMessage());
                    // Don't fail registration if welcome message fails
                }
                
                request.setAttribute("message", "Đăng ký thành công! Chào mừng bạn đến với UTESHOP. Vui lòng đăng nhập để tiếp tục");
                
                // Forward to login page
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại");
                showRegisterPage(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng ký: " + e.getMessage());
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