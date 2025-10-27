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

@WebServlet({"/user/favorites/*"})
public class FavoriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SanPhamYeuThichDAO sanPhamYeuThichDAO;

    public void init() {
        sanPhamYeuThichDAO = new SanPhamYeuThichDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        String action = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "list";

        switch (action) {
            case "remove":
                removeFromFavorites(request, response, user);
                break;
            default:
                viewFavorites(request, response, user);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Vui lòng đăng nhập\"}");
            return;
        }

        String pathInfo = request.getPathInfo();
        String action = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "add";

        switch (action) {
            case "add":
                addToFavorites(request, response, user);
                break;
            case "toggle":
                toggleFavorite(request, response, user);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                break;
        }
    }

    private void viewFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        int page = 0;
        int pageSize = 12;
        
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 0) page = 0;
            }
        } catch (NumberFormatException e) {
            page = 0;
        }

        List<SanPhamYeuThich> favorites = sanPhamYeuThichDAO.getFavoritesByUser(user.getMaND(), page, pageSize);
        long totalItems = sanPhamYeuThichDAO.countFavoritesByUser(user.getMaND());
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        request.setAttribute("favorites", favorites);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/WEB-INF/views/user/wishlist.jsp").forward(request, response);
    }

    private void addToFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("maSP"));
            
            if (sanPhamYeuThichDAO.isFavorite(user.getMaND(), productId)) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Sản phẩm đã có trong danh sách yêu thích\"}");
                return;
            }

            boolean success = sanPhamYeuThichDAO.addToFavorites(user.getMaND(), productId);
            
            if (success) {
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Đã thêm vào danh sách yêu thích\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể thêm sản phẩm vào danh sách yêu thích\"}");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Mã sản phẩm không hợp lệ\"}");
        }
    }

    private void removeFromFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("maSP"));
            boolean success = sanPhamYeuThichDAO.removeFromFavorites(user.getMaND(), productId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/user/favorites");
            } else {
                request.setAttribute("error", "Không thể xóa sản phẩm khỏi danh sách yêu thích");
                viewFavorites(request, response, user);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã sản phẩm không hợp lệ");
            viewFavorites(request, response, user);
        }
    }

    private void toggleFavorite(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("maSP"));
            
            if (sanPhamYeuThichDAO.isFavorite(user.getMaND(), productId)) {
                boolean success = sanPhamYeuThichDAO.removeFromFavorites(user.getMaND(), productId);
                if (success) {
                    response.getWriter().write("{\"status\":\"success\",\"message\":\"Đã xóa khỏi danh sách yêu thích\",\"action\":\"removed\"}");
                } else {
                    response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể xóa sản phẩm khỏi danh sách yêu thích\"}");
                }
            } else {
                boolean success = sanPhamYeuThichDAO.addToFavorites(user.getMaND(), productId);
                if (success) {
                    response.getWriter().write("{\"status\":\"success\",\"message\":\"Đã thêm vào danh sách yêu thích\",\"action\":\"added\"}");
                } else {
                    response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể thêm sản phẩm vào danh sách yêu thích\"}");
                }
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Mã sản phẩm không hợp lệ\"}");
        }
    }
}