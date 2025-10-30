package com.uteshop.controller.guest;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.dao.SanPhamYeuThichDAO;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet("/guest/search")
public class SearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();
    private final SanPhamYeuThichDAO sanPhamYeuThichDAO = new SanPhamYeuThichDAO();
    private static final int PAGE_SIZE = 12; // Số sản phẩm mỗi trang

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        
        handleSearch(req, resp);
    }

    private void handleSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Lấy các tham số tìm kiếm
            String keyword = req.getParameter("keyword");
            String categoryParam = req.getParameter("category");
            String priceRange = req.getParameter("price");
            String sort = req.getParameter("sort");
            String pageParam = req.getParameter("page");

            // Validate và xử lý keyword
            if (keyword != null) {
                keyword = keyword.trim();
            }

            // Xử lý category ID
            Integer categoryId = null;
            if (categoryParam != null && !categoryParam.isEmpty() && !categoryParam.equals("all")) {
                try {
                    categoryId = Integer.parseInt(categoryParam);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid category ID: " + categoryParam);
                }
            }

            // Xử lý số trang
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) currentPage = 1;
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            // Tính offset cho pagination
            int offset = (currentPage - 1) * PAGE_SIZE;

            // Tìm kiếm sản phẩm
            List<SanPham> searchResults = sanPhamDAO.searchProducts(
                keyword, categoryId, priceRange, sort, offset, PAGE_SIZE
            );

            // Đếm tổng số kết quả
            long totalResults = sanPhamDAO.countSearchResults(keyword, categoryId, priceRange);
            int totalPages = (int) Math.ceil((double) totalResults / PAGE_SIZE);

            // Lấy danh sách sản phẩm yêu thích của user (nếu đã đăng nhập)
            Set<Integer> favoriteProductIds = new HashSet<>();
            NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");
            if (user != null) {
                favoriteProductIds = sanPhamYeuThichDAO.getFavoriteProductIdsByUserId(user.getMaND());
            }

            // Lấy danh sách danh mục cho bộ lọc
            List<DanhMuc> categories = danhMucDAO.findAll();

            // Set attributes để hiển thị trên JSP
            req.setAttribute("searchResults", searchResults);
            req.setAttribute("keyword", keyword);
            req.setAttribute("selectedCategory", categoryId);
            req.setAttribute("selectedPrice", priceRange);
            req.setAttribute("selectedSort", sort);
            req.setAttribute("currentPage", currentPage);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalResults", totalResults);
            req.setAttribute("favoriteProductIds", favoriteProductIds);
            req.setAttribute("categories", categories);

            // Hiển thị thông tin tìm kiếm
            String searchInfo = buildSearchInfo(keyword, categoryId, totalResults);
            req.setAttribute("searchInfo", searchInfo);

            // Forward đến trang kết quả tìm kiếm
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/guest/search-results.jsp");
            dispatcher.forward(req, resp);

        } catch (Exception e) {
            System.err.println("Error in SearchController: " + e.getMessage());
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi tìm kiếm");
        }
    }

    /**
     * Xây dựng chuỗi thông tin tìm kiếm
     */
    private String buildSearchInfo(String keyword, Integer categoryId, long totalResults) {
        StringBuilder info = new StringBuilder();
        
        if (keyword != null && !keyword.isEmpty()) {
            info.append("Kết quả tìm kiếm cho \"").append(keyword).append("\"");
        } else {
            info.append("Tất cả sản phẩm");
        }
        
        if (categoryId != null && categoryId > 0) {
            try {
                String categoryName = sanPhamDAO.findCategoryNameById(categoryId);
                if (categoryName != null) {
                    info.append(" trong danh mục \"").append(categoryName).append("\"");
                }
            } catch (Exception e) {
                System.err.println("Error getting category name: " + e.getMessage());
            }
        }
        
        info.append(" - Tìm thấy ").append(totalResults).append(" sản phẩm");
        
        return info.toString();
    }
}
