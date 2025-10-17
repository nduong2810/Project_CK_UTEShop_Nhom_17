package com.uteshop.controller.shipper;

import com.uteshop.entity.NguoiDung;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/shipper/dashboard", "/shipper/orders", "/shipper/history"})
public class ShipperController extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        
        // Kiểm tra quyền SHIPPER
        if (user.getVaiTro() != NguoiDung.VaiTro.SHIPPER && user.getVaiTro() != NguoiDung.VaiTro.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/guest/home");
            return;
        }
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/shipper/dashboard":
                showDashboard(request, response, user);
                break;
            case "/shipper/orders":
                showOrders(request, response, user);
                break;
            case "/shipper/history":
                showHistory(request, response, user);
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
            // Lấy danh sách đơn hàng cần giao
            // TODO: Implement các phương thức lấy đơn hàng trong DAO
            
            request.setAttribute("user", user);
            request.setAttribute("pageTitle", "Shipper Dashboard");
            
            // Tạm thời redirect về trang home với thông báo
            response.sendRedirect(request.getContextPath() + "/guest/home");
            
            // TODO: Tạo view shipper/dashboard.jsp
            // RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/shipper/dashboard.jsp");
            // dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/guest/home");
        }
    }
    
    private void showOrders(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        // TODO: Implement hiển thị danh sách đơn hàng cần giao
        response.sendRedirect(request.getContextPath() + "/guest/home");
    }
    
    private void showHistory(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        // TODO: Implement hiển thị lịch sử giao hàng
        response.sendRedirect(request.getContextPath() + "/guest/home");
    }
}