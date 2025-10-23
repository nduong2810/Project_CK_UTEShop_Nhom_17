package com.uteshop.controller.user;

import com.uteshop.dao.GioHangDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.ChiTietGioHang;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/user/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private GioHangDAO gioHangDAO = new GioHangDAO();
    private SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("view")) {
                // Hiển thị giỏ hàng
                viewCart(request, response, user);
            } else if (action.equals("delete")) {
                // Xóa sản phẩm khỏi giỏ hàng
                deleteFromCart(request, response, user);
            } else if (action.equals("clear")) {
                // Xóa toàn bộ giỏ hàng
                clearCart(request, response, user);
            } else {
                viewCart(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            viewCart(request, response, user);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action.equals("add")) {
                // Thêm sản phẩm vào giỏ hàng
                addToCart(request, response, user);
            } else if (action.equals("update")) {
                // Cập nhật số lượng sản phẩm
                updateCartItem(request, response, user);
            } else {
                viewCart(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            viewCart(request, response, user);
        }
    }
    
    private void viewCart(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        List<ChiTietGioHang> cartItems = gioHangDAO.getCartItems(user.getMaND());
        
        // Tính tổng tiền
        BigDecimal totalAmount = cartItems.stream()
            .map(item -> item.getThanhTien())
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("cartCount", cartItems.size());
        
        request.getRequestDispatcher("/WEB-INF/views/user/cart.jsp").forward(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String quantityStr = request.getParameter("quantity");
            int quantity = quantityStr != null ? Integer.parseInt(quantityStr) : 1;
            
            if (quantity <= 0) {
                request.setAttribute("error", "Số lượng không hợp lệ");
                viewCart(request, response, user);
                return;
            }
            
            boolean success = gioHangDAO.addToCart(user.getMaND(), productId, quantity);
            
            if (success) {
                request.setAttribute("success", "Đã thêm vào giỏ hàng thành công");
            } else {
                request.setAttribute("error", "Không thể thêm vào giỏ hàng");
            }
            
            // Redirect để tránh resubmit form
            response.sendRedirect(request.getContextPath() + "/user/cart");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            viewCart(request, response, user);
        }
    }
    
    private void updateCartItem(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            
            boolean success = gioHangDAO.updateQuantity(user.getMaND(), productId, newQuantity);
            
            if (success) {
                request.setAttribute("success", "Đã cập nhật giỏ hàng");
            } else {
                request.setAttribute("error", "Không thể cập nhật giỏ hàng");
            }
            
            // Redirect để tránh resubmit form
            response.sendRedirect(request.getContextPath() + "/user/cart");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            viewCart(request, response, user);
        }
    }
    
    private void deleteFromCart(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            boolean success = gioHangDAO.removeFromCart(user.getMaND(), productId);
            
            if (success) {
                request.setAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng");
            } else {
                request.setAttribute("error", "Không thể xóa sản phẩm");
            }
            
            // Redirect để tránh resubmit form
            response.sendRedirect(request.getContextPath() + "/user/cart");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            viewCart(request, response, user);
        }
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        boolean success = gioHangDAO.clearCart(user.getMaND());
        
        if (success) {
            request.setAttribute("success", "Đã xóa toàn bộ giỏ hàng");
        } else {
            request.setAttribute("error", "Không thể xóa giỏ hàng");
        }
        
        // Redirect để tránh resubmit form
        response.sendRedirect(request.getContextPath() + "/user/cart");
    }
}
