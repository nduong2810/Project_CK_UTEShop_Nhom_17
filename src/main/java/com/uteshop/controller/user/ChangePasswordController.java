package com.uteshop.controller.user;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;
import com.uteshop.service.EmailService;
import com.uteshop.service.OTPService;
import com.uteshop.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/user/change-password")
public class ChangePasswordController extends HttpServlet {

    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final OTPService otpService = OTPService.getInstance();
    private final EmailService emailService = EmailService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("verifyPassword".equals(action)) {
            handleVerifyPasswordAndSendOtp(request, response, user);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response, user);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không hợp lệ.");
        }
    }

    private void handleVerifyPasswordAndSendOtp(HttpServletRequest request, HttpServletResponse response, NguoiDung user) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");

        if (!PasswordUtil.verifyPassword(currentPassword, user.getMatKhau())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
            return;
        }

        String userEmail = user.getEmail();
        if (!otpService.canResendOTP(userEmail)) {
            request.setAttribute("error", "Vui lòng đợi 1 phút trước khi yêu cầu lại OTP.");
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
            return;
        }

        String otpCode = otpService.generateOTP(userEmail, "EMAIL");
        boolean sendSuccess = emailService.sendOTPEmail(userEmail, otpCode);

        if (sendSuccess) {
            request.setAttribute("message", "Mật khẩu chính xác. Mã OTP đã được gửi đến email của bạn.");
            request.setAttribute("passwordVerified", true);
        } else {
            request.setAttribute("error", "Không thể gửi email OTP. Vui lòng thử lại.");
        }
        request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, NguoiDung user) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        String userOtp = request.getParameter("otp");

        request.setAttribute("passwordVerified", true);

        if (!newPassword.equals(confirmNewPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
            return;
        }

        if (!PasswordUtil.isValidPassword(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
            return;
        }

        boolean isOtpValid = otpService.verifyOTP(user.getEmail(), userOtp);
        if (!isOtpValid) {
            request.setAttribute("error", "Mã OTP không đúng hoặc đã hết hạn.");
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
            return;
        }

        String hashedNewPassword = PasswordUtil.hashPassword(newPassword);
        user.setMatKhau(hashedNewPassword);

        nguoiDungDAO.update(user);

        // SỬA LỖI: Mã hóa thông báo trước khi gửi redirect
        String message = URLEncoder.encode("Đổi mật khẩu thành công!", StandardCharsets.UTF_8.toString());
        response.sendRedirect(request.getContextPath() + "/user/profile?message=" + message);
    }
}
