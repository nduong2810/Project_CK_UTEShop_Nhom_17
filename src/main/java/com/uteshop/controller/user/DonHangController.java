package com.uteshop.controller.user;

import com.uteshop.dao.DonHangDAO;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/orders")
public class DonHangController extends HttpServlet {
    
    private DonHangDAO donHangDAO = new DonHangDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        try {
            // ✅ Lấy danh sách đơn hàng của user
            List<DonHang> orders = donHangDAO.findByUser(user.getMaND());
            
            // Set attributes
            request.setAttribute("orders", orders);
            request.setAttribute("orderCount", orders != null ? orders.size() : 0);
            
            // Thông báo success nếu có
            String success = request.getParameter("success");
            if ("1".equals(success)) {
                request.setAttribute("successMessage", "Đặt hàng thành công! Đơn hàng của bạn đang được xử lý.");
            }
            
            System.out.println("✅ Loaded " + (orders != null ? orders.size() : 0) + " orders for user #" + user.getMaND());
            
        } catch (Exception e) {
            System.err.println("❌ Error loading orders: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải danh sách đơn hàng");
        }
        
        // Forward đến JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/orders.jsp");
        dispatcher.forward(request, response);
    }
}
