package com.uteshop.controller.guest;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

/**
 * GuestServlet xử lý các yêu cầu public của người dùng chưa đăng nhập
 * (và cũng hỗ trợ người dùng đã đăng nhập).
 * Các chức năng giữ nguyên logic cũ: home, login, register, logout.
 */
@WebServlet(urlPatterns = {"/guest/*"})
public class GuestServlet extends HttpServlet {

    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo();
        String path = (pathInfo == null) ? "/home" : pathInfo;

        switch (path) {
            case "/login":
                forward(req, resp, "/WEB-INF/views/auth/login.jsp");
                break;
            case "/register":
                forward(req, resp, "/WEB-INF/views/auth/register.jsp");
                break;
            case "/verify-otp":
                forward(req, resp, "/WEB-INF/views/auth/verify-otp.jsp");
                break;
            case "/logout":
                handleLogout(req, resp);
                break;
            case "/home":
            default:
                loadHomeData(req);
                forward(req, resp, "/WEB-INF/views/guest/home.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo();
        String path = (pathInfo == null) ? "" : pathInfo;

        switch (path) {
            case "/login":
                req.getRequestDispatcher("/auth/login").forward(req, resp);
                break;
            case "/register":
                req.getRequestDispatcher("/auth/register").forward(req, resp);
                break;
            case "/verify-otp":
                req.getRequestDispatcher("/auth/verify-otp").forward(req, resp);
                break;
            case "/resend-otp":
                req.getRequestDispatcher("/auth/resend-otp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/guest/home");
                break;
        }
    }

    /**
     * Tải dữ liệu trang chủ (10 sản phẩm đầu tiên)
     */
    private void loadHomeData(HttpServletRequest request) {
        try {
            List<SanPham> top10 = sanPhamDAO.findTopNProducts(10);
            request.setAttribute("top10", top10 != null ? top10 : Collections.emptyList());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("top10", Collections.emptyList());
            request.setAttribute("errorMessage", "Không thể tải sản phẩm. Vui lòng thử lại sau.");
        }
    }

    /**
     * Chuyển tiếp request tới view JSP.
     */
    private void forward(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    /**
     * Xử lý đăng xuất, giữ nguyên logic cũ.
     */
    private void handleLogout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Xóa cookie remember
        Cookie rememberedUser = new Cookie("rememberedUser", "");
        rememberedUser.setMaxAge(0);
        rememberedUser.setPath(req.getContextPath());
        resp.addCookie(rememberedUser);

        // Xóa cookie JWT nếu có
        Cookie jwtCookie = new Cookie("jwt_token", "");
        jwtCookie.setMaxAge(0);
        jwtCookie.setPath("/");
        resp.addCookie(jwtCookie);

        resp.sendRedirect(req.getContextPath() + "/guest/home");
    }
}
