package com.uteshop.filter;

import com.uteshop.entity.NguoiDung;
import com.uteshop.util.JwtUtil;
import io.jsonwebtoken.Claims;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebFilter(urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    private EntityManagerFactory emf;

    private static final List<String> PUBLIC_URLS = Arrays.asList(
            "/auth/login", "/auth/register", "/auth/logout",
            "/auth/send-otp", "/auth/verify-otp", "/auth/resend-otp",
            "/auth/forgot-password", "/auth/reset-password",
            "/auth/forgot-send-otp", "/auth/forgot-verify-otp",
            "/guest", "/assets", "/css", "/js", "/images", "/img", "/favicon.ico"
    );

    @Override
    public void init(FilterConfig filterConfig) {
        emf = Persistence.createEntityManagerFactory("uteshop-pu"); // ⚠️ Đúng tên persistence-unit của bạn trong persistence.xml
        System.out.println("✅ AuthFilter initialized (JPA)");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String requestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = requestURI.substring(contextPath.length());
        String normalizedPath = path.replaceAll("//+", "/");

        // ✅ Bỏ qua file tĩnh
        if (isStaticResource(normalizedPath)) {
            chain.doFilter(request, response);
            return;
        }

        // ✅ Cho phép URL công khai
        if (isPublicUrl(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        NguoiDung user = (session != null) ? (NguoiDung) session.getAttribute("user") : null;

        // ✅ Nếu chưa có session → khôi phục từ JWT
        if (user == null && req.getCookies() != null) {
            for (Cookie cookie : req.getCookies()) {
                if ("jwt_token".equals(cookie.getName())) {
                    try {
                        Claims claims = JwtUtil.validateToken(cookie.getValue());
                        String username = claims.getSubject();
                        String role = (String) claims.get("role");

                        // 🔹 Lấy user từ DB bằng JPA
                        NguoiDung u = findUserByUsername(username);
                        if (u != null) {
                            HttpSession newSession = req.getSession(true);
                            newSession.setAttribute("user", u);
                            newSession.setAttribute("userRole", role);
                            user = u;
                            System.out.println("AuthFilter: Restored user from DB → " + username);
                        } else {
                            System.out.println("AuthFilter: Không tìm thấy user trong DB → " + username);
                        }
                    } catch (Exception e) {
                        System.out.println("AuthFilter: Invalid JWT token → " + e.getMessage());
                    }
                    break;
                }
            }
        }

        // ✅ Nếu vẫn chưa có user → chuyển hướng login
        if (user == null) {
            resp.sendRedirect(contextPath + "/auth/login");
            return;
        }

        // ✅ Kiểm tra quyền truy cập
        if (!hasAccess(user, path)) {
            resp.sendRedirect(contextPath + getDefaultPageForRole(user.getVaiTro()));
            return;
        }

        chain.doFilter(request, response);
    }

    /** Truy vấn user từ JPA */
    private NguoiDung findUserByUsername(String username) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery(
                            "SELECT u FROM NguoiDung u WHERE u.tenDangNhap = :username", NguoiDung.class)
                    .setParameter("username", username)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            System.out.println("AuthFilter: Lỗi khi truy vấn JPA → " + e.getMessage());
            return null;
        } finally {
            if (em != null) em.close();
        }
    }

    private boolean isStaticResource(String path) {
        return path.startsWith("/assets/")
                || path.startsWith("/uploads/")
                || path.endsWith(".css") || path.endsWith(".js")
                || path.endsWith(".png") || path.endsWith(".jpg")
                || path.endsWith(".jpeg") || path.endsWith(".gif")
                || path.endsWith(".svg") || path.endsWith(".webp")
                || path.endsWith(".ico");
    }

    private boolean isPublicUrl(String path) {
        for (String publicUrl : PUBLIC_URLS) {
            if (path.startsWith(publicUrl)) return true;
        }
        return false;
    }

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
    public void destroy() {
        if (emf != null && emf.isOpen()) emf.close();
        System.out.println("AuthFilter destroyed");
    }
}