package com.uteshop.controller.guest;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/guest/category")
public class CategoryController extends HttpServlet {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();
    private static final int PAGINATION_PAGE_SIZE = 8; // Products per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = "/WEB-INF/views/guest/category-products.jsp";
        try {
            // Get filter parameters from request
            String categoryParam = request.getParameter("category");
            if (categoryParam == null) {
                categoryParam = request.getParameter("id"); // Fallback for old links
            }
            String sortParam = request.getParameter("sort");
            String priceParam = request.getParameter("price");

            Integer categoryId = null;
            if (categoryParam != null && !categoryParam.isEmpty() && !categoryParam.equals("all")) {
                try {
                    categoryId = Integer.parseInt(categoryParam);
                } catch (NumberFormatException e) {
                    // Ignore invalid category parameter, treat as "all"
                }
            }

            // Count total products for pagination
            long totalProducts = sanPhamDAO.countProducts(sortParam, priceParam, categoryId);
            int totalPages = (int) Math.ceil((double) totalProducts / PAGINATION_PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            // Get pagination parameters
            String pageParam = request.getParameter("page");
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            // Validate current page
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            // Calculate offset
            int currentOffset = (currentPage - 1) * PAGINATION_PAGE_SIZE;

            // Fetch products using the findAll method
            List<SanPham> products = sanPhamDAO.findAll(currentOffset, PAGINATION_PAGE_SIZE, sortParam, priceParam, categoryId);

            // Get category info and all categories for the filter dropdown
            List<DanhMuc> allCategories = danhMucDAO.getAllCategories();
            request.setAttribute("allCategories", allCategories); // For the filter dropdown

            if (categoryId != null) {
                DanhMuc category = danhMucDAO.findById(categoryId);
                if (category != null) {
                    request.setAttribute("category", category);
                }
                // Get top 3 best-selling products for this category
                List<SanPham> top3Products = sanPhamDAO.findTopNProductsByCategoryId(3, categoryId);
                List<Integer> top3ProductIds = top3Products.stream().map(SanPham::getMaSP).collect(Collectors.toList());
                request.setAttribute("top3ProductIds", top3ProductIds);
            }

            request.setAttribute("products", products);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi không xác định khi tải trang danh mục.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(pathInfo);
        dispatcher.forward(request, response);
    }
}
