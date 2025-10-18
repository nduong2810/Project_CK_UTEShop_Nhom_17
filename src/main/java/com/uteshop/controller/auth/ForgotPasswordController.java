package com.uteshop.controller.auth;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;
import com.uteshop.service.OTPService;
import com.uteshop.service.EmailService;
import com.uteshop.util.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.JsonObject;

@WebServlet(urlPatterns = {"/auth/forgot-password", "/auth/reset-password", "/auth/forgot-send-otp", "/auth/forgot-verify-otp"})
public class ForgotPasswordController extends HttpServlet {
    
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final OTPService otpService = OTPService.getInstance();
    private final EmailService emailService = EmailService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/auth/forgot-password":
                showForgotPasswordPage(request, response);
                break;
            case "/auth/reset-password":
                showResetPasswordPage(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/auth/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/auth/forgot-send-otp":
                handleSendForgotOTP(request, response);
                break;
            case "/auth/forgot-verify-otp":
                handleVerifyForgotOTP(request, response);
                break;
            case "/auth/reset-password":
                handleResetPassword(request, response);
                break;
            default:
                sendErrorResponse(response, "Invalid endpoint", 404);
        }
    }
    
    /**
     * Hiển thị trang quên mật khẩu
     */
    private void showForgotPasswordPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Hiển thị trang reset mật khẩu
     */
    private void showResetPasswordPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra session có thông tin OTP đã xác thực không
        HttpSession session = request.getSession(false);
        if (session == null || 
            !Boolean.TRUE.equals(session.getAttribute("forgot_otp_verified")) ||
            session.getAttribute("forgot_email") == null) {
            
            request.setAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thực hiện lại quá trình quên mật khẩu.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Xử lý gửi OTP cho quên mật khẩu
     */
    private void handleSendForgotOTP(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            String email = request.getParameter("email");
            
            // Validate input
            if (email == null || email.trim().isEmpty()) {
                sendErrorResponse(response, "Vui lòng nhập email", 400);
                return;
            }
            
            email = email.trim();
            
            // Validate email format
            if (!isValidEmail(email)) {
                sendErrorResponse(response, "Email không hợp lệ", 400);
                return;
            }
            
            // Kiểm tra email có tồn tại trong hệ thống không
            NguoiDung user = nguoiDungDAO.findByEmail(email);
            if (user == null) {
                sendErrorResponse(response, "Email này chưa được đăng ký trong hệ thống", 400);
                return;
            }
            
            // Kiểm tra tài khoản có bị khóa không
            if (!user.isTrangThai()) {
                sendErrorResponse(response, "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ admin", 400);
                return;
            }
            
            // Kiểm tra có thể gửi OTP không (tránh spam)
            if (!otpService.canResendOTP(email)) {
                sendErrorResponse(response, "Vui lòng đợi 1 phút trước khi gửi lại OTP", 429);
                return;
            }
            
            // Tạo OTP cho quên mật khẩu
            String otpCode = otpService.generateOTP(email, "FORGOT_PASSWORD");
            
            // Gửi OTP qua email
            boolean sendSuccess = emailService.sendForgotPasswordOTP(email, otpCode, user.getHoTen());
            
            if (sendSuccess) {
                // Lưu thông tin vào session
                HttpSession session = request.getSession();
                session.setAttribute("forgot_email", email);
                session.setAttribute("forgot_otp_sent_time", System.currentTimeMillis());
                session.removeAttribute("forgot_otp_verified"); // Reset trạng thái verify
                
                sendSuccessResponse(response, "Mã OTP đã được gửi đến email của bạn");
            } else {
                sendErrorResponse(response, "Không thể gửi email. Vui lòng thử lại", 500);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Có lỗi xảy ra: " + e.getMessage(), 500);
        }
    }
    
    /**
     * Xử lý xác thực OTP cho quên mật khẩu
     */
    private void handleVerifyForgotOTP(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            String otpCode = request.getParameter("otpCode");
            
            if (otpCode == null || otpCode.trim().isEmpty()) {
                sendErrorResponse(response, "Vui lòng nhập mã OTP", 400);
                return;
            }
            
            HttpSession session = request.getSession(false);
            if (session == null) {
                sendErrorResponse(response, "Phiên làm việc đã hết hạn", 401);
                return;
            }
            
            String email = (String) session.getAttribute("forgot_email");
            if (email == null) {
                sendErrorResponse(response, "Không tìm thấy thông tin email", 400);
                return;
            }
            
            // Xác thực OTP
            boolean isValid = otpService.verifyOTP(email, otpCode.trim());
            
            if (isValid) {
                // Đánh dấu OTP đã xác thực thành công
                session.setAttribute("forgot_otp_verified", true);
                session.setAttribute("forgot_verified_time", System.currentTimeMillis());
                
                sendSuccessResponse(response, "Xác thực OTP thành công! Bạn có thể đặt lại mật khẩu.");
            } else {
                sendErrorResponse(response, "Mã OTP không đúng hoặc đã hết hạn", 400);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Có lỗi xảy ra: " + e.getMessage(), 500);
        }
    }
    
    /**
     * Xử lý đặt lại mật khẩu mới
     */
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            HttpSession session = request.getSession(false);
            
            // Kiểm tra session và trạng thái xác thực OTP
            if (session == null || 
                !Boolean.TRUE.equals(session.getAttribute("forgot_otp_verified"))) {
                sendErrorResponse(response, "Phiên làm việc không hợp lệ", 401);
                return;
            }
            
            String email = (String) session.getAttribute("forgot_email");
            if (email == null) {
                sendErrorResponse(response, "Không tìm thấy thông tin email", 400);
                return;
            }
            
            // Kiểm tra thời gian xác thực OTP (cho phép reset trong 10 phút)
            Long verifiedTime = (Long) session.getAttribute("forgot_verified_time");
            if (verifiedTime == null || 
                (System.currentTimeMillis() - verifiedTime) > 10 * 60 * 1000) {
                
                // Xóa thông tin session
                session.removeAttribute("forgot_otp_verified");
                session.removeAttribute("forgot_email");
                session.removeAttribute("forgot_verified_time");
                
                sendErrorResponse(response, "Phiên xác thực đã hết hạn. Vui lòng thực hiện lại", 401);
                return;
            }
            
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validate input
            if (newPassword == null || newPassword.trim().isEmpty()) {
                sendErrorResponse(response, "Vui lòng nhập mật khẩu mới", 400);
                return;
            }
            
            if (confirmPassword == null || !newPassword.equals(confirmPassword)) {
                sendErrorResponse(response, "Mật khẩu xác nhận không khớp", 400);
                return;
            }
            
            // Validate password strength
            if (newPassword.length() < 6) {
                sendErrorResponse(response, "Mật khẩu phải có ít nhất 6 ký tự", 400);
                return;
            }
            
            // Tìm user và cập nhật mật khẩu
            NguoiDung user = nguoiDungDAO.findByEmail(email);
            if (user == null) {
                sendErrorResponse(response, "Không tìm thấy tài khoản", 400);
                return;
            }
            
            // Cập nhật mật khẩu mới trực tiếp vào database (không cần hash lại vì DAO đã hash)
            boolean updateSuccess = nguoiDungDAO.updatePasswordByEmail(email, newPassword);
            
            if (updateSuccess) {
                // Xóa thông tin session
                session.removeAttribute("forgot_otp_verified");
                session.removeAttribute("forgot_email");
                session.removeAttribute("forgot_verified_time");
                session.removeAttribute("forgot_otp_sent_time");
                
                // Xóa OTP trong service
                otpService.removeOTP(email);
                
                sendSuccessResponse(response, "Đặt lại mật khẩu thành công! Bạn có thể đăng nhập với mật khẩu mới.");
            } else {
                sendErrorResponse(response, "Không thể cập nhật mật khẩu. Vui lòng thử lại", 500);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Có lỗi xảy ra: " + e.getMessage(), 500);
        }
    }
    
    /**
     * Validate email format
     */
    private boolean isValidEmail(String email) {
        if (email == null || email.isEmpty()) {
            return false;
        }
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
    
    /**
     * Gửi response thành công
     */
    private void sendSuccessResponse(HttpServletResponse response, String message) throws IOException {
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", true);
        jsonResponse.addProperty("message", message);
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    /**
     * Gửi response lỗi
     */
    private void sendErrorResponse(HttpServletResponse response, String message, int statusCode) throws IOException {
        response.setStatus(statusCode);
        
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", false);
        jsonResponse.addProperty("message", message);
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
