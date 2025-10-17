package com.uteshop.controller.vendor;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.dao.CuaHangDAO;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.CuaHang;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/vendor/dashboard", "/vendor/products", "/vendor/orders", "/vendor/store"})
public class VendorController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final CuaHangDAO cuaHangDAO = new CuaHangDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        // Kiểm tra quyền VENDOR
        if (user.getVaiTro() != NguoiDung.VaiTro.VENDOR && user.getVaiTro() != NguoiDung.VaiTro.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/guest/home");
            return;
        }
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/vendor/dashboard":
                showDashboard(request, response, user);
                break;
            case "/vendor/products":
                showProducts(request, response, user);
                break;
            case "/vendor/orders":
                showOrders(request, response, user);
                break;
            case "/vendor/store":
                showStoreInfo(request, response, user);
                break;
            default:
                showDashboard(request, response, user);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        try {
            // Lấy thống kê cho vendor
            // TODO: Implement các phương thức thống kê trong DAO
            
            request.setAttribute("user", user);
            request.setAttribute("pageTitle", "Vendor Dashboard");
            
            // Tạm thời redirect về trang home với thông báo
            response.sendRedirect(request.getContextPath() + "/guest/home");
            
            // TODO: Tạo view vendor/dashboard.jsp
            // RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/dashboard.jsp");
            // dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/guest/home");
        }
    }
    
    private void showProducts(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        // TODO: Implement hiển thị sản phẩm của vendor
        response.sendRedirect(request.getContextPath() + "/guest/home");
    }
    
    private void showOrders(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        // TODO: Implement hiển thị đơn hàng của vendor
        response.sendRedirect(request.getContextPath() + "/guest/home");
    }
    
    private void showStoreInfo(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        // TODO: Implement hiển thị thông tin cửa hàng
        response.sendRedirect(request.getContextPath() + "/guest/home");
    }
}