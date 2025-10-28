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

@WebServlet(urlPatterns = {"/user/orders", "/user/order-detail"})
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
        
        String path = request.getServletPath();
        
        // ✅ Xử lý theo path
        if ("/user/order-detail".equals(path)) {
            showOrderDetail(request, response, user);
        } else {
            showOrderList(request, response, user);
        }
    }
    
    /**
     * Hiển thị danh sách đơn hàng
     */
    private void showOrderList(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
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
    
    /**
     * Hiển thị chi tiết đơn hàng
     */
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/orders?error=Invalid order ID");
            return;
        }
        
        try {
            Integer orderId = Integer.parseInt(orderIdParam);
            System.out.println("🔍 Loading order detail #" + orderId + " for user #" + user.getMaND());
            
            // Lấy chi tiết đơn hàng
            DonHang order = donHangDAO.findById(orderId);
            
            if (order == null) {
                System.err.println("❌ Order #" + orderId + " not found");
                response.sendRedirect(request.getContextPath() + "/user/orders?error=Order not found");
                return;
            }
            
            // Kiểm tra quyền truy cập (chỉ cho phép xem đơn hàng của mình)
            if (!order.getNguoiDung().getMaND().equals(user.getMaND())) {
                System.err.println("❌ User #" + user.getMaND() + " không có quyền xem order #" + orderId);
                response.sendRedirect(request.getContextPath() + "/user/orders?error=Access denied");
                return;
            }
            
            System.out.println("✅ Order #" + orderId + " loaded successfully");
            System.out.println("   - Status: " + order.getTrangThai());
            System.out.println("   - Total: " + order.getTongThanhToan());
            System.out.println("   - Discount: " + order.getTienGiam());
            System.out.println("   - Items: " + (order.getChiTietDonHangs() != null ? order.getChiTietDonHangs().size() : 0));
            
            // Đặt attributes
            request.setAttribute("order", order);
            request.setAttribute("pageTitle", "Chi tiết Đơn hàng #" + orderId);
            
            // Forward đến JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/order-detail.jsp");
            dispatcher.forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid order ID format: " + orderIdParam);
            response.sendRedirect(request.getContextPath() + "/user/orders?error=Invalid order ID");
        } catch (Exception e) {
            System.err.println("❌ Error loading order detail: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/orders?error=Error loading order");
        }
    }
}
