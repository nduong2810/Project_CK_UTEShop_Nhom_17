package com.uteshop.filter;

import com.uteshop.entity.NguoiDung;
import com.uteshop.util.JwtUtil;
import io.jsonwebtoken.Claims;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebFilter(urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    private static final List<String> PUBLIC_URLS = Arrays.asList(
            "/auth/login", "/auth/register", "/auth/logout",
            "/auth/send-otp", "/auth/verify-otp", "/auth/resend-otp",
            "/auth/forgot-password", "/auth/reset-password",
            "/auth/forgot-send-otp", "/auth/forgot-verify-otp",
            "/guest", "/assets", "/css", "/js", "/images", "/img", "/favicon.ico"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String requestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Debug log
        System.out.println("AuthFilter: Processing " + path);

        // Cho phép truy cập các URL công khai
        if (isPublicUrl(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        NguoiDung user = (session != null) ? (NguoiDung) session.getAttribute("user") : null;

        // Nếu chưa có session thì thử đọc JWT từ cookie
        if (user == null && req.getCookies() != null) {
            for (Cookie cookie : req.getCookies()) {
                if ("jwt_token".equals(cookie.getName())) {
                    try {
                        Claims claims = JwtUtil.validateToken(cookie.getValue());
                        String username = claims.getSubject();
                        String role = (String) claims.get("role");

                        NguoiDung u = new NguoiDung();
                        u.setTenDangNhap(username);
                        u.setVaiTro(NguoiDung.VaiTro.valueOf(role));

                        HttpSession newSession = req.getSession(true);
                        newSession.setAttribute("user", u);
                        newSession.setAttribute("userRole", role);
                        user = u;

                        System.out.println("AuthFilter: Restored session from JWT for " + username);
                    } catch (Exception e) {
                        System.out.println("AuthFilter: Invalid JWT token → " + e.getMessage());
                    }
                    break;
                }
            }
        }

        // Nếu chưa đăng nhập (vẫn không có user)
        if (user == null) {
            System.out.println("AuthFilter: Not logged in, redirecting to login");
            resp.sendRedirect(contextPath + "/auth/login");
            return;
        }

        // Kiểm tra quyền truy cập
        if (!hasAccess(user, path)) {
            System.out.println("AuthFilter: Access denied for role " + user.getVaiTro() + " to " + path);
            resp.sendRedirect(contextPath + getDefaultPageForRole(user.getVaiTro()));
            return;
        }

        // Cho phép truy cập
        chain.doFilter(request, response);
    }

    /** Xác định URL public */
    private boolean isPublicUrl(String path) {
        for (String publicUrl : PUBLIC_URLS) {
            if (path.startsWith(publicUrl)) return true;
        }
        return false;
    }

    /** Kiểm tra quyền theo vai trò */
    private boolean hasAccess(NguoiDung user, String path) {
        NguoiDung.VaiTro role = user.getVaiTro();

        if (path.startsWith("/guest")) return true;
        if (role == NguoiDung.VaiTro.ADMIN) return true;

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

    /** Trang mặc định theo vai trò */
    private String getDefaultPageForRole(NguoiDung.VaiTro role) {
        switch (role) {
            case ADMIN:
                return "/admin/products";
            case VENDOR:
                return "/vendor/dashboard";
            case SHIPPER:
                return "/shipper/dashboard";
            default:
                return "/guest/home";
        }
    }

    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("AuthFilter initialized (JWT-compatible)");
    }

    @Override
    public void destroy() {
        System.out.println("AuthFilter destroyed");
    }
}