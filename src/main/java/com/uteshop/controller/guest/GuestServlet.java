package com.uteshop.controller.guest;


import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

/**
 * DEPRECATED: Servlet này đã được thay thế bởi các controller riêng biệt:
 * - HomeController: xử lý /guest/home
 * - ProductController: xử lý /guest/product
 * - CategoryController: xử lý /guest/category
 * 
 * Servlet này đã bị VÔ HIỆU HÓA (commented out @WebServlet annotation)
 * để tránh xung đột với các controller mới.
 */
// @WebServlet(urlPatterns = "/guest/*")  // ← COMMENTED OUT - Servlet bị vô hiệu hóa
public class GuestServlet extends HttpServlet {

    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        System.out.println("GuestServlet (DEPRECATED) - PathInfo received: " + path);
        System.out.println("WARNING: GuestServlet is deprecated and should not be called.");

        String view;
        switch (path == null ? "" : path) {
            case "/login":
                view = "/WEB-INF/views/auth/login.jsp";
                break;
            case "/register":
                view = "/WEB-INF/views/auth/register.jsp";
                break;
            case "/verify-otp":
                view = "/WEB-INF/views/auth/verify-otp.jsp";
                break;
            case "/logout":
                // Xử lý đăng xuất
                req.getSession().invalidate();
                resp.sendRedirect(req.getContextPath() + "/guest/home");
                return;
            case "/home":
                // Deprecated: Use HomeController instead
                loadHomeData(req);
                view = "/WEB-INF/views/guest/home.jsp";
                break;
            case "/loadMoreProducts":
                // Forward request đến LoadMoreController để xử lý AJAX
                System.out.println("GuestServlet_DEPRECATED - Forwarding loadMoreProducts to LoadMoreController");
                req.getRequestDispatcher("/guest/loadMoreProducts").include(req, resp);
                return;
            default:
                // Redirect về /guest/home nếu path không hợp lệ
                System.out.println("GuestServlet_DEPRECATED - Unknown path: " + path + ", redirecting to home");
                resp.sendRedirect(req.getContextPath() + "/guest/home");
                return;
        }

        System.out.println("GuestServlet_DEPRECATED - Forwarding to view: " + view);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String path = req.getPathInfo();
        System.out.println("GuestServlet (DEPRECATED) POST - PathInfo received: " + path);

        switch (path == null ? "" : path) {
            case "/login":
                // Xử lý đăng nhập
                handleLogin(req, resp);
                break;
            case "/register":
                // Xử lý đăng ký
                handleRegister(req, resp);
                break;
            case "/verify-otp":
                // Xử lý xác thực OTP
                handleVerifyOtp(req, resp);
                break;
            case "/resend-otp":
                // Xử lý gửi lại OTP
                handleResendOtp(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/guest/home");
        }
    }

    private void loadHomeData(HttpServletRequest request) {
        try {
            List<SanPham> top10 = sanPhamDAO.findTopNProducts(10);
            request.setAttribute("top10", top10);
            System.out.println("GuestServlet_DEPRECATED - Loaded " + top10.size() + " products for home page");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("top10", Collections.emptyList());
            request.setAttribute("errorMessage", "Không thể tải sản phẩm. Vui lòng thử lại sau.");
            System.err.println("GuestServlet_DEPRECATED - Error loading home data: " + e.getMessage());
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: Implement login logic
        System.out.println("GuestServlet_DEPRECATED - Handling login");
        req.setAttribute("message", "Chức năng đăng nhập đang phát triển");
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
        rd.forward(req, resp);
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: Implement register logic
        System.out.println("GuestServlet_DEPRECATED - Handling register");
        req.setAttribute("message", "Chức năng đăng ký đang phát triển");
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp");
        rd.forward(req, resp);
    }

    private void handleVerifyOtp(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: Implement OTP verification logic
        System.out.println("GuestServlet_DEPRECATED - Handling verify OTP");
        req.setAttribute("message", "Chức năng xác thực OTP đang phát triển");
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp");
        rd.forward(req, resp);
    }

    private void handleResendOtp(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: Implement resend OTP logic
        System.out.println("GuestServlet_DEPRECATED - Handling resend OTP");
        req.setAttribute("success", "Mã OTP đã được gửi lại");
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp");
        rd.forward(req, resp);
    }
}