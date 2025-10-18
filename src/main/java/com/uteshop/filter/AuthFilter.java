package com.uteshop.filter;

import com.uteshop.entity.NguoiDung;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Filter để kiểm tra authentication và authorization
 * Tự động redirect về trang login nếu chưa đăng nhập
 * Kiểm tra quyền truy cập dựa trên role từ database
 */
@WebFilter(urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    // Các URL công khai không cần đăng nhập
    private static final List<String> PUBLIC_URLS = Arrays.asList(
        "/auth/login",
        "/auth/register",
        "/auth/logout",
        "/auth/send-otp",      // Thêm endpoint gửi OTP
        "/auth/verify-otp",    // Thêm endpoint xác thực OTP
        "/auth/resend-otp",    // Thêm endpoint gửi lại OTP
        "/auth/forgot-password",    // Thêm trang quên mật khẩu
        "/auth/reset-password",     // Thêm trang đặt lại mật khẩu
        "/auth/forgot-send-otp",    // Thêm endpoint gửi OTP quên mật khẩu
        "/auth/forgot-verify-otp",  // Thêm endpoint xác thực OTP quên mật khẩu
        "/guest",  // Tất cả guest URLs đều public
        "/assets",
        "/css",
        "/js",
        "/images",
        "/img",    // Thêm /img để load hình ảnh
        "/favicon.ico"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Debug logging
        System.out.println("AuthFilter: Processing request - " + path);
        
        // Cho phép truy cập các URL công khai (bao gồm tất cả /guest/*)
        if (isPublicUrl(path)) {
            System.out.println("AuthFilter: Public URL, allowing access - " + path);
            chain.doFilter(request, response);
            return;
        }
        
        // Kiểm tra session
        HttpSession session = httpRequest.getSession(false);
        NguoiDung user = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        
        System.out.println("AuthFilter: User logged in? " + (user != null));
        if (user != null) {
            System.out.println("AuthFilter: User role = " + user.getVaiTro());
        }
        
        // Nếu chưa đăng nhập, redirect về login
        if (user == null) {
            System.out.println("AuthFilter: Not logged in, redirecting to login");
            httpResponse.sendRedirect(contextPath + "/auth/login");
            return;
        }
        
        // Kiểm tra quyền truy cập dựa trên role từ database
        if (!hasAccess(user, path)) {
            System.out.println("AuthFilter: Access denied for role " + user.getVaiTro() + " to path " + path);
            // Redirect về trang dashboard của role hiện tại
            httpResponse.sendRedirect(contextPath + getDefaultPageForRole(user.getVaiTro()));
            return;
        }
        
        System.out.println("AuthFilter: Access granted");
        // Cho phép truy cập
        chain.doFilter(request, response);
    }
    
    /**
     * Kiểm tra xem URL có phải là public không
     */
    private boolean isPublicUrl(String path) {
        // Kiểm tra từng pattern trong PUBLIC_URLS
        for (String publicUrl : PUBLIC_URLS) {
            if (path.startsWith(publicUrl)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Kiểm tra quyền truy cập dựa trên role từ database
     * TẤT CẢ các role đều có thể truy cập /guest/* vì nó là public
     */
    private boolean hasAccess(NguoiDung user, String path) {
        NguoiDung.VaiTro role = user.getVaiTro();
        
        // Guest URLs - TẤT CẢ đã đăng nhập đều truy cập được
        if (path.startsWith("/guest")) {
            return true;
        }
        
        // Admin có quyền truy cập tất cả
        if (role == NguoiDung.VaiTro.ADMIN) {
            return true;
        }
        
        // Kiểm tra quyền theo từng role cho các trang riêng
        switch (role) {
            case VENDOR:
                return path.startsWith("/vendor") || path.startsWith("/user");
            case SHIPPER:
                return path.startsWith("/shipper") || path.startsWith("/user");
            case USER:
                return path.startsWith("/user");
            default:
                return false;
        }
    }
    
    /**
     * Lấy trang mặc định cho mỗi role
     */
    private String getDefaultPageForRole(NguoiDung.VaiTro role) {
        switch (role) {
            case ADMIN:
                return "/admin/products";
            case VENDOR:
                return "/vendor/dashboard";
            case SHIPPER:
                return "/shipper/dashboard";
            case USER:
            default:
                return "/guest/home";
        }
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthFilter initialized - Protecting all routes");
    }
    
    @Override
    public void destroy() {
        System.out.println("AuthFilter destroyed");
    }
}