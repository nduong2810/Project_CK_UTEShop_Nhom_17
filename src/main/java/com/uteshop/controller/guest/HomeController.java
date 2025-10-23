package com.uteshop.controller.guest;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet({"/guest/home"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();

    private static final int PAGINATION_PAGE_SIZE = 8; // Products per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        handleHomePage(request, response);
    }

    private void handleHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get filter parameters from request
            String sortParam = request.getParameter("sort");
            String priceParam = request.getParameter("price");
            String categoryParam = request.getParameter("category");

            Integer categoryId = null;
            if (categoryParam != null && !categoryParam.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryParam);
                } catch (NumberFormatException e) {
                    // Ignore invalid category parameter
                }
            }

            long totalProducts = sanPhamDAO.countProducts(sortParam, priceParam, categoryId);
            int totalPages = (int) Math.ceil((double) totalProducts / PAGINATION_PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            String pageParam = request.getParameter("page");
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            int currentOffset = (currentPage - 1) * PAGINATION_PAGE_SIZE;
            List<SanPham> products = sanPhamDAO.findAll(currentOffset, PAGINATION_PAGE_SIZE, sortParam, priceParam, categoryId);

            List<DanhMuc> categories = danhMucDAO.getAllCategories();

            // Get top products for HOT badge
            List<Integer> hotProductIds;
            if (categoryId != null) {
                // Top 3 for the selected category
                List<SanPham> top3Products = sanPhamDAO.findTopNProductsByCategoryId(3, categoryId);
                hotProductIds = top3Products.stream().map(SanPham::getMaSP).collect(Collectors.toList());
            } else {
                // Top 5 overall
                List<SanPham> top5Products = sanPhamDAO.findTopNProducts(5);
                hotProductIds = top5Products.stream().map(SanPham::getMaSP).collect(Collectors.toList());
            }

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("paginationPageSize", PAGINATION_PAGE_SIZE);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("hotProductIds", hotProductIds);

            request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("!!! ERROR in HomeController.handleHomePage()");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải danh sách sản phẩm. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method not supported for /guest/home");
    }
}
