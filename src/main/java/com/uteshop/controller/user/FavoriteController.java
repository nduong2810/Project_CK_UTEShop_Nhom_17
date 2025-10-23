package com.uteshop.controller.user;

import com.uteshop.dao.SanPhamYeuThichDAO;
import com.uteshop.entity.SanPhamYeuThich;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/favorites")
public class FavoriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private SanPhamYeuThichDAO sanPhamYeuThichDAO = new SanPhamYeuThichDAO();

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
            if (action == null || action.equals("list")) {
                // Hiển thị danh sách sản phẩm yêu thích
                viewFavorites(request, response, user);
            } else if (action.equals("remove")) {
                // Xóa sản phẩm khỏi danh sách yêu thích
                removeFromFavorites(request, response, user);
            } else {
                viewFavorites(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            viewFavorites(request, response, user);
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
                // Thêm sản phẩm vào danh sách yêu thích
                addToFavorites(request, response, user);
            } else if (action.equals("toggle")) {
                // Toggle trạng thái yêu thích
                toggleFavorite(request, response, user);
            } else {
                viewFavorites(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            viewFavorites(request, response, user);
        }
    }
    
    private void viewFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        // Phân trang
        int page = 0;
        int pageSize = 20;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 0) page = 0;
            } catch (NumberFormatException e) {
                page = 0;
            }
        }
        
        List<SanPhamYeuThich> favorites = sanPhamYeuThichDAO.getFavoritesByUser(user.getMaND(), page, pageSize);
        
        request.setAttribute("favorites", favorites);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        
        request.getRequestDispatcher("/WEB-INF/views/user/favorites.jsp").forward(request, response);
    }
    
    private void addToFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            boolean success = sanPhamYeuThichDAO.addToFavorites(user.getMaND(), productId);
            
            if (success) {
                request.setAttribute("success", "Đã thêm vào danh sách yêu thích");
            } else {
                request.setAttribute("error", "Sản phẩm đã có trong danh sách yêu thích");
            }
            
            // Redirect về trang trước đó hoặc danh sách yêu thích
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.contains("/user/favorites")) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/favorites");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            viewFavorites(request, response, user);
        }
    }
    
    private void removeFromFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            boolean success = sanPhamYeuThichDAO.removeFromFavorites(user.getMaND(), productId);
            
            if (success) {
                request.setAttribute("success", "Đã xóa khỏi danh sách yêu thích");
            } else {
                request.setAttribute("error", "Không thể xóa sản phẩm");
            }
            
            // Redirect để tránh resubmit form
            response.sendRedirect(request.getContextPath() + "/user/favorites");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            viewFavorites(request, response, user);
        }
    }
    
    private void toggleFavorite(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            boolean isFavorite = sanPhamYeuThichDAO.isFavorite(user.getMaND(), productId);
            boolean success;
            String message;
            
            if (isFavorite) {
                success = sanPhamYeuThichDAO.removeFromFavorites(user.getMaND(), productId);
                message = success ? "Đã xóa khỏi danh sách yêu thích" : "Không thể xóa sản phẩm";
            } else {
                success = sanPhamYeuThichDAO.addToFavorites(user.getMaND(), productId);
                message = success ? "Đã thêm vào danh sách yêu thích" : "Không thể thêm sản phẩm";
            }
            
            if (success) {
                request.setAttribute("success", message);
            } else {
                request.setAttribute("error", message);
            }
            
            // Redirect về trang trước đó
            String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/favorites");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            viewFavorites(request, response, user);
        }
    }
}