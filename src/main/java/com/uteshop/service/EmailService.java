package com.uteshop.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Date;

/**
 * Service để gửi email OTP và các email thông báo khác
 * 
 * HƯỚNG DẪN THIẾT LẬP GMAIL APP PASSWORD:
 * 1. Đăng nhập Gmail của bạn
 * 2. Vào Google Account settings (myaccount.google.com)
 * 3. Chọn "Security" ở menu bên trái
 * 4. Bật "2-Step Verification" nếu chưa bật
 * 5. Tìm "App passwords" và click vào
 * 6. Chọn "Mail" và "Other (custom name)" 
 * 7. Nhập tên "UTESHOP" và tạo password
 * 8. Copy mã 16 ký tự được tạo ra
 * 9. Thay thế EMAIL_USERNAME và EMAIL_PASSWORD bên dưới
 * 
 * Lưu ý: App Password khác với mật khẩu thật của bạn và an toàn hơn
 */
public class EmailService {
    private static EmailService instance;
    
    // CẤU HÌNH EMAIL - THAY ĐỔI THÔNG TIN DƯỚI ĐÂY
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    
    // Thay bằng email Gmail của bạn
    private static final String EMAIL_USERNAME = "duongboil5@gmail.com"; // VD: uteshop2024@gmail.com
    
    // Thay bằng App Password 16 ký tự từ Gmail (KHÔNG PHẢI MẬT KHẨU THẬT)
    private static final String EMAIL_PASSWORD = "ealx qjce rabm hxib"; // VD: "abcd efgh ijkl mnop"
    
    private EmailService() {}
    
    public static synchronized EmailService getInstance() {
        if (instance == null) {
            instance = new EmailService();
        }
        return instance;
    }
    
    /**
     * Gửi OTP qua email (KHÔNG SMS)
     * @param toEmail Email người nhận
     * @param otpCode Mã OTP 6 chữ số
     * @return true nếu gửi thành công
     */
    public boolean sendOTPEmail(String toEmail, String otpCode) {
        return sendOTPEmail(toEmail, otpCode, "Khách hàng");
    }
    
    /**
     * Gửi OTP đăng ký tài khoản
     */
    public boolean sendOTPEmail(String toEmail, String otpCode, String fullName) {
        // Kiểm tra cấu hình email
        if (EMAIL_USERNAME.equals("your-email@gmail.com") || EMAIL_PASSWORD.equals("abcd efgh ijkl mnop")) {
            System.out.println("⚠️ CHƯA CẤU HÌNH EMAIL: Đang chạy ở chế độ demo");
            System.out.println("📧 Email demo sẽ được gửi đến: " + toEmail);
            System.out.println("🔐 Mã OTP demo: " + otpCode);
            System.out.println("✅ Để cấu hình email thật, xem hướng dẫn trong EmailService.java");
            return true; // Trả về true để test được
        }
        
        try {
            // Cấu hình properties cho Gmail SMTP với App Password
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", SMTP_HOST);
            
            // Tạo session với App Password authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Debug mode
            session.setDebug(false); // Đặt true để debug email
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME, "UTESHOP - Hệ thống HCMUTE"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("🔐 Mã xác thực OTP đăng ký - UTESHOP");
            message.setSentDate(new Date());
            
            // Tạo nội dung email HTML
            String htmlContent = createOTPEmailContent(otpCode, fullName, "đăng ký tài khoản");
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            // Gửi email
            Transport.send(message);
            
            System.out.println("✅ OTP email đã gửi thành công đến: " + toEmail);
            System.out.println("🔐 Mã OTP: " + otpCode);
            return true;
            
        } catch (Exception e) {
            System.out.println("❌ Lỗi khi gửi OTP email đến: " + toEmail);
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Gửi OTP cho chức năng quên mật khẩu
     * @param toEmail Email người nhận
     * @param otpCode Mã OTP 6 chữ số
     * @param fullName Tên người dùng
     * @return true nếu gửi thành công
     */
    public boolean sendForgotPasswordOTP(String toEmail, String otpCode, String fullName) {
        // Kiểm tra cấu hình email
        if (EMAIL_USERNAME.equals("your-email@gmail.com") || EMAIL_PASSWORD.equals("abcd efgh ijkl mnop")) {
            System.out.println("⚠️ CHƯA CẤU HÌNH EMAIL: Đang chạy ở chế độ demo");
            System.out.println("📧 Email quên mật khẩu demo sẽ được gửi đến: " + toEmail);
            System.out.println("🔐 Mã OTP quên mật khẩu demo: " + otpCode);
            System.out.println("✅ Để cấu hình email thật, xem hướng dẫn trong EmailService.java");
            return true; // Trả về true để test được
        }
        
        try {
            // Cấu hình properties cho Gmail SMTP với App Password
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", SMTP_HOST);
            
            // Tạo session với App Password authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Debug mode
            session.setDebug(false);
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME, "UTESHOP - Hệ thống HCMUTE"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("🔒 Mã xác thực đặt lại mật khẩu - UTESHOP");
            message.setSentDate(new Date());
            
            // Tạo nội dung email HTML cho quên mật khẩu
            String htmlContent = createForgotPasswordEmailContent(otpCode, fullName);
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            // Gửi email
            Transport.send(message);
            
            System.out.println("✅ Forgot password OTP email đã gửi thành công đến: " + toEmail);
            System.out.println("🔐 Mã OTP: " + otpCode);
            return true;
            
        } catch (Exception e) {
            System.out.println("❌ Lỗi khi gửi forgot password OTP email đến: " + toEmail);
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Gửi email chào mừng sau khi đăng ký thành công
     * @param toEmail Email người nhận
     * @param firstName Tên người dùng
     * @return true nếu gửi thành công
     */
    public boolean sendWelcomeEmail(String toEmail, String firstName) {
        // Kiểm tra cấu hình email
        if (EMAIL_USERNAME.equals("your-email@gmail.com") || EMAIL_PASSWORD.equals("abcd efgh ijkl mnop")) {
            System.out.println("⚠️ CHƯA CẤU HÌNH EMAIL: Đang chạy ở chế độ demo");
            System.out.println("📧 Email chào mừng demo sẽ được gửi đến: " + toEmail);
            System.out.println("👋 Chào mừng " + firstName + " đến với UTESHOP!");
            System.out.println("✅ Để cấu hình email thật, xem hướng dẫn trong EmailService.java");
            return true; // Trả về true để test được
        }
        
        try {
            // Cấu hình properties cho Gmail SMTP với App Password
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", SMTP_HOST);
            
            // Tạo session với App Password authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Debug mode
            session.setDebug(false);
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME, "UTESHOP - Hệ thống HCMUTE"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("🎉 Chào mừng bạn đến với UTESHOP!");
            message.setSentDate(new Date());
            
            // Tạo nội dung email HTML chào mừng
            String htmlContent = createWelcomeEmailContent(firstName);
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            // Gửi email
            Transport.send(message);
            
            System.out.println("✅ Welcome email đã gửi thành công đến: " + toEmail);
            System.out.println("👋 Chào mừng " + firstName + "!");
            return true;
            
        } catch (Exception e) {
            System.out.println("❌ Lỗi khi gửi welcome email đến: " + toEmail);
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Tạo nội dung HTML cho email OTP đăng ký
     */
    private String createOTPEmailContent(String otpCode, String fullName, String purpose) {
        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #ff6b35 0%%, #f7931e 100%%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
                    .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }
                    .otp-box { background: #fff; padding: 20px; margin: 20px 0; text-align: center; border-radius: 8px; border: 2px solid #ff6b35; }
                    .otp-code { font-size: 32px; font-weight: bold; color: #ff6b35; letter-spacing: 5px; margin: 10px 0; }
                    .warning { background: #fff3cd; padding: 15px; margin: 20px 0; border-radius: 5px; border-left: 4px solid #ffc107; }
                    .footer { text-align: center; margin-top: 30px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>🛒 UTESHOP</h1>
                        <p>Hệ thống thương mại điện tử HCMUTE</p>
                    </div>
                    <div class="content">
                        <h2>Xin chào %s!</h2>
                        <p>Bạn đã yêu cầu mã xác thực OTP để %s trên hệ thống UTESHOP.</p>
                        
                        <div class="otp-box">
                            <h3>Mã xác thực OTP của bạn:</h3>
                            <div class="otp-code">%s</div>
                            <p><em>Mã này có hiệu lực trong 5 phút</em></p>
                        </div>
                        
                        <div class="warning">
                            <strong>⚠️ Lưu ý quan trọng:</strong>
                            <ul>
                                <li>Không chia sẻ mã OTP này với bất kỳ ai</li>
                                <li>UTESHOP không bao giờ yêu cầu mã OTP qua điện thoại</li>
                                <li>Nếu bạn không thực hiện yêu cầu này, hãy bỏ qua email</li>
                            </ul>
                        </div>
                        
                        <p>Trân trọng,<br><strong>Đội ngũ UTESHOP</strong></p>
                    </div>
                    <div class="footer">
                        <p>© 2024 UTESHOP - Hệ thống thương mại điện tử HCMUTE</p>
                        <p>Email này được gửi tự động, vui lòng không trả lời.</p>
                    </div>
                </div>
            </body>
            </html>
            """, fullName, purpose, otpCode);
    }
    
    /**
     * Tạo nội dung HTML cho email OTP quên mật khẩu
     */
    private String createForgotPasswordEmailContent(String otpCode, String fullName) {
        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #dc3545 0%%, #c82333 100%%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
                    .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }
                    .otp-box { background: #fff; padding: 20px; margin: 20px 0; text-align: center; border-radius: 8px; border: 2px solid #dc3545; }
                    .otp-code { font-size: 32px; font-weight: bold; color: #dc3545; letter-spacing: 5px; margin: 10px 0; }
                    .warning { background: #f8d7da; padding: 15px; margin: 20px 0; border-radius: 5px; border-left: 4px solid #dc3545; }
                    .footer { text-align: center; margin-top: 30px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>🔒 UTESHOP</h1>
                        <p>Yêu cầu đặt lại mật khẩu</p>
                    </div>
                    <div class="content">
                        <h2>Xin chào %s!</h2>
                        <p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản UTESHOP của bạn.</p>
                        
                        <div class="otp-box">
                            <h3>🔐 Mã xác thực OTP:</h3>
                            <div class="otp-code">%s</div>
                            <p><em>Mã này có hiệu lực trong 5 phút</em></p>
                        </div>
                        
                        <div class="warning">
                            <strong>🚨 Cảnh báo bảo mật:</strong>
                            <ul>
                                <li><strong>TUYỆT ĐỐI không chia sẻ mã này với ai</strong></li>
                                <li>Nhập mã vào trang web UTESHOP để tiếp tục</li>
                                <li>Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này</li>
                                <li>Liên hệ ngay với chúng tôi nếu nghi ngờ tài khoản bị xâm phạm</li>
                            </ul>
                        </div>
                        
                        <p><strong>Lưu ý:</strong> Sau khi xác thực OTP, bạn sẽ có 10 phút để đặt mật khẩu mới.</p>
                        
                        <p>Trân trọng,<br><strong>Đội ngũ bảo mật UTESHOP</strong></p>
                    </div>
                    <div class="footer">
                        <p>© 2024 UTESHOP - Hệ thống thương mại điện tử HCMUTE</p>
                        <p>Email bảo mật - Vui lòng không trả lời email này</p>
                    </div>
                </div>
            </body>
            </html>
            """, fullName, otpCode);
    }
    
    /**
     * Tạo nội dung HTML cho email chào mừng
     */
    private String createWelcomeEmailContent(String firstName) {
        return String.format("""
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #28a745 0%%, #20c997 100%%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
                    .content { background: #f8f9fa; padding: 30px; border-radius: 0 0 10px 10px; }
                    .welcome-box { background: #fff; padding: 25px; margin: 20px 0; text-align: center; border-radius: 8px; border: 2px solid #28a745; }
                    .features { background: #fff; padding: 20px; margin: 20px 0; border-radius: 8px; }
                    .feature-item { display: flex; align-items: center; margin-bottom: 15px; }
                    .feature-icon { width: 40px; height: 40px; background: #28a745; color: white; border-radius: 50%%; display: flex; align-items: center; justify-content: center; margin-right: 15px; font-weight: bold; }
                    .cta-button { display: inline-block; background: linear-gradient(135deg, #ff6b35 0%%, #f7931e 100%%); color: white; padding: 15px 30px; text-decoration: none; border-radius: 25px; font-weight: bold; margin: 20px 0; }
                    .footer { text-align: center; margin-top: 30px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>🎉 Chào mừng đến với UTESHOP!</h1>
                        <p>Nền tảng mua sắm trực tuyến dành cho sinh viên HCMUTE</p>
                    </div>
                    <div class="content">
                        <div class="welcome-box">
                            <h2>Xin chào %s! 👋</h2>
                            <p>Cảm ơn bạn đã đăng ký tài khoản tại UTESHOP. Chúng tôi rất vui được chào đón bạn vào cộng đồng mua sắm trực tuyến dành riêng cho sinh viên HCMUTE!</p>
                        </div>
                        
                        <div class="features">
                            <h3>🚀 Những gì bạn có thể làm với UTESHOP:</h3>
                            <div class="feature-item">
                                <div class="feature-icon">🛒</div>
                                <div>
                                    <strong>Mua sắm đa dạng</strong><br>
                                    Khám phá hàng ngàn sản phẩm từ văn phòng phẩm đến thời trang
                                </div>
                            </div>
                            <div class="feature-item">
                                <div class="feature-icon">💰</div>
                                <div>
                                    <strong>Giá ưu đãi sinh viên</strong><br>
                                    Giá cả phải chăng, nhiều chương trình khuyến mãi hấp dẫn
                                </div>
                            </div>
                            <div class="feature-item">
                                <div class="feature-icon">🚚</div>
                                <div>
                                    <strong>Giao hàng nhanh chóng</strong><br>
                                    Giao hàng tận nơi trong khuôn viên trường và khu vực lân cận
                                </div>
                            </div>
                            <div class="feature-item">
                                <div class="feature-icon">🎓</div>
                                <div>
                                    <strong>Cộng đồng sinh viên</strong><br>
                                    Kết nối với cộng đồng sinh viên HCMUTE qua mua sắm
                                </div>
                            </div>
                        </div>
                        
                        <div style="text-align: center;">
                            <a href="#" class="cta-button">🛍️ Bắt đầu mua sắm ngay</a>
                        </div>
                        
                        <div style="background: #e9f7ef; padding: 20px; border-radius: 8px; margin: 20px 0;">
                            <h4>📞 Cần hỗ trợ?</h4>
                            <p>Đội ngũ UTESHOP luôn sẵn sàng hỗ trợ bạn:</p>
                            <ul>
                                <li>📧 Email: support@uteshop.edu.vn</li>
                                <li>📱 Hotline: 1900-xxxx</li>
                                <li>🏫 Văn phòng: Tòa A1, Trường ĐH SPKT TP.HCM</li>
                            </ul>
                        </div>
                        
                        <div style="text-align: center; background: #fff3cd; padding: 15px; border-radius: 8px; margin: 20px 0;">
                            <strong>💡 Mẹo:</strong> Theo dõi email để không bỏ lỡ các chương trình khuyến mãi đặc biệt dành cho sinh viên!
                        </div>
                        
                        <p>Chúc bạn có những trải nghiệm mua sắm tuyệt vời tại UTESHOP!</p>
                        
                        <p>Trân trọng,<br><strong>Đội ngũ UTESHOP</strong> 🛒</p>
                    </div>
                    <div class="footer">
                        <p>© 2024 UTESHOP - Nền tảng mua sắm sinh viên HCMUTE</p>
                        <p>Email này được gửi tự động đến %s</p>
                        <p>Nếu bạn không đăng ký tài khoản này, vui lòng bỏ qua email này.</p>
                    </div>
                </div>
            </body>
            </html>
            """, firstName, firstName.toLowerCase() + "@student.hcmute.edu.vn");
    }
    
    /**
     * Tạo nội dung HTML cho email OTP đăng ký (backward compatibility)
     */
    private String createOTPEmailContent(String otpCode) {
        return createOTPEmailContent(otpCode, "Khách hàng", "xác thực tài khoản");
    }
}
