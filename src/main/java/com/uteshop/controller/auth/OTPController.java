package com.uteshop.controller.auth;

import com.uteshop.service.OTPService;
import com.uteshop.service.EmailService;
import com.uteshop.dao.NguoiDungDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.JsonObject;

@WebServlet(urlPatterns = {"/auth/send-otp", "/auth/verify-otp", "/auth/resend-otp"})
public class OTPController extends HttpServlet {
    
    private final OTPService otpService = OTPService.getInstance();
    private final EmailService emailService = EmailService.getInstance();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/auth/send-otp":
                handleSendOTP(request, response);
                break;
            case "/auth/verify-otp":
                handleVerifyOTP(request, response);
                break;
            case "/auth/resend-otp":
                handleResendOTP(request, response);
                break;
            default:
                sendErrorResponse(response, "Invalid endpoint", 404);
        }
    }
    
    /**
     * Xử lý gửi OTP qua email
     */
    private void handleSendOTP(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            String identifier = request.getParameter("identifier");
            String otpType = request.getParameter("otpType");
            
            // Validate input
            if (identifier == null || identifier.trim().isEmpty()) {
                sendErrorResponse(response, "Vui lòng nhập email", 400);
                return;
            }
            
            // Chỉ chấp nhận EMAIL
            if (otpType == null || !otpType.equals("EMAIL")) {
                sendErrorResponse(response, "Hệ thống chỉ hỗ trợ gửi OTP qua email", 400);
                return;
            }
            
            identifier = identifier.trim();
            
            // Kiểm tra xem email đã được sử dụng chưa
            if (nguoiDungDAO.isEmailExists(identifier)) {
                sendErrorResponse(response, "Email này đã được đăng ký", 400);
                return;
            }
            
            // Validate email format
            if (!isValidEmail(identifier)) {
                sendErrorResponse(response, "Email không hợp lệ", 400);
                return;
            }
            
            // Kiểm tra có thể gửi OTP không (tránh spam)
            if (!otpService.canResendOTP(identifier)) {
                sendErrorResponse(response, "Vui lòng đợi 1 phút trước khi gửi lại OTP", 429);
                return;
            }
            
            // Tạo OTP
            String otpCode = otpService.generateOTP(identifier, "EMAIL");
            
            // Gửi OTP qua email
            boolean sendSuccess = emailService.sendOTPEmail(identifier, otpCode);
            
            if (sendSuccess) {
                // Lưu thông tin vào session để xử lý verify
                HttpSession session = request.getSession();
                session.setAttribute("otp_identifier", identifier);
                session.setAttribute("otp_type", "EMAIL");
                session.setAttribute("otp_sent_time", System.currentTimeMillis());
                
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
     * Xử lý xác thực OTP
     */
    private void handleVerifyOTP(HttpServletRequest request, HttpServletResponse response) 
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
            
            String identifier = (String) session.getAttribute("otp_identifier");
            String otpType = (String) session.getAttribute("otp_type");
            
            if (identifier == null || otpType == null) {
                sendErrorResponse(response, "Không tìm thấy thông tin OTP", 400);
                return;
            }
            
            // Xác thực OTP
            boolean isValid = otpService.verifyOTP(identifier, otpCode.trim());
            
            if (isValid) {
                // Đánh dấu OTP đã xác thực thành công
                session.setAttribute("otp_verified", true);
                session.setAttribute("verified_identifier", identifier);
                session.setAttribute("verified_type", otpType);
                
                sendSuccessResponse(response, "Xác thực OTP thành công");
            } else {
                sendErrorResponse(response, "Mã OTP không đúng hoặc đã hết hạn", 400);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Có lỗi xảy ra: " + e.getMessage(), 500);
        }
    }
    
    /**
     * Xử lý gửi lại OTP
     */
    private void handleResendOTP(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                sendErrorResponse(response, "Phiên làm việc đã hết hạn", 401);
                return;
            }
            
            String identifier = (String) session.getAttribute("otp_identifier");
            String otpType = (String) session.getAttribute("otp_type");
            
            if (identifier == null || otpType == null) {
                sendErrorResponse(response, "Không tìm thấy thông tin OTP", 400);
                return;
            }
            
            // Kiểm tra có thể gửi lại không
            if (!otpService.canResendOTP(identifier)) {
                sendErrorResponse(response, "Vui lòng đợi 1 phút trước khi gửi lại OTP", 429);
                return;
            }
            
            // Tạo OTP mới
            String otpCode = otpService.generateOTP(identifier, "EMAIL");
            
            // Gửi OTP qua email
            boolean sendSuccess = emailService.sendOTPEmail(identifier, otpCode);
            
            if (sendSuccess) {
                session.setAttribute("otp_sent_time", System.currentTimeMillis());
                sendSuccessResponse(response, "Mã OTP đã được gửi lại thành công");
            } else {
                sendErrorResponse(response, "Không thể gửi lại email. Vui lòng thử lại", 500);
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
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return email.matches(emailRegex);
    }
    
    /**
     * Gửi response thành công
     */
    private void sendSuccessResponse(HttpServletResponse response, String message) throws IOException {
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", true);
        jsonResponse.addProperty("message", message);
        
        response.setStatus(200);
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    /**
     * Gửi response lỗi
     */
    private void sendErrorResponse(HttpServletResponse response, String message, int statusCode) throws IOException {
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", false);
        jsonResponse.addProperty("message", message);
        
        response.setStatus(statusCode);
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
