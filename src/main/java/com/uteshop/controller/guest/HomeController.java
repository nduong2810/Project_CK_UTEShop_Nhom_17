package com.uteshop.controller.guest;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet({"/guest/home"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();

    // Constants for pagination logic
    private static final int PAGINATION_PAGE_SIZE = 10; // Products per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("============================================");
        System.out.println("HomeController.doGet() CALLED!");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Context Path: " + request.getContextPath());
        System.out.println("============================================");
        
        // Ensure request/response use UTF-8 to avoid mojibake
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        handleHomePage(request, response);
    }
    
    private void handleHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println(">>> handleHomePage() started");
        
        try {
            long totalProducts = sanPhamDAO.countProducts();
            int totalPages = (int) Math.ceil((double) totalProducts / PAGINATION_PAGE_SIZE);
            if (totalPages == 0) totalPages = 1; // Ensure at least 1 page if no products

            String pageParam = request.getParameter("page");
            System.out.println("DEBUG: pageParam from request: " + pageParam); // ADDED LOG
            int currentPage = 1; // Default page

            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    System.out.println("DEBUG: Parsed currentPage: " + currentPage); // ADDED LOG
                } catch (NumberFormatException e) {
                    System.err.println("Invalid page parameter: " + pageParam + ". Using default page 1.");
                    e.printStackTrace(); // ADDED: Print stack trace for detailed error info
                    // currentPage remains 1
                }
            }
            System.out.println("DEBUG: Final currentPage before bounds check: " + currentPage); // ADDED LOG
            
            // Ensure currentPage is within valid bounds
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;

            // Get sort parameter from request
            String sortParam = request.getParameter("sort");

            // Always calculate offset and fetch products using findAll for consistent pagination
            int currentOffset = (currentPage - 1) * PAGINATION_PAGE_SIZE;
            List<SanPham> products = sanPhamDAO.findAll(currentOffset, PAGINATION_PAGE_SIZE, sortParam);
            System.out.println("HomeController: Paginated Load - Page " + currentPage + ", Offset " + currentOffset + ", Limit " + PAGINATION_PAGE_SIZE + ", Sort By: " + (sortParam != null ? sortParam : "default"));
            
            // ADDED DEBUG LOGGING FOR SoLuongBan
            System.out.println("DEBUG HomeController: Products SoLuongBan values:");
            for (SanPham sp : products) {
                System.out.println("  - MaSP: " + sp.getMaSP() + ", SoLuongBan: " + sp.getSoLuongBan());
            }
            
            // Lấy danh sách danh mục để hiển thị bộ lọc
            List<DanhMuc> categories = danhMucDAO.getAllCategories();
            System.out.println("Loaded categories: " + categories.size());

            // Set attributes
            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("paginationPageSize", PAGINATION_PAGE_SIZE);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            
            System.out.println("All attributes set, forwarding to JSP...");
            
            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(request, response);
            
            System.out.println(">>> handleHomePage() completed successfully");
            
        } catch (Exception e) {
            System.err.println("!!! ERROR in HomeController.handleHomePage()");
            System.err.println("Error message: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải danh sách sản phẩm. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // For now, POST requests are not directly handled by HomeController for /guest/home
        // You might have other controllers handling specific POST actions.
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method not supported for /guest/home");
    }
    
    // Removed handleLoadMore as it's no longer used for pure pagination
    
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\"", "\\\"")
                  .replace("\\", "\\\\")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}