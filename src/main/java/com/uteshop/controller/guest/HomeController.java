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
    private static final int PAGE_SIZE = 8; // số sản phẩm mỗi trang

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        handleHomePage(req, resp);
    }

    private void handleHomePage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // --- Lấy tham số lọc ---
            String sort = req.getParameter("sort");
            String price = req.getParameter("price");
            String category = req.getParameter("category");

            Integer categoryId = null;
            if (category != null && !category.isEmpty() && !category.equals("all")) {
                try {
                    categoryId = Integer.parseInt(category);
                } catch (NumberFormatException ignored) {}
            }

            // --- Lấy tổng sản phẩm theo bộ lọc ---
            long totalProducts = sanPhamDAO.countProducts(sort, price, categoryId);
            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            // --- Xử lý phân trang ---
            int currentPage = 1;
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException ignored) {}
            }
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            int offset = (currentPage - 1) * PAGE_SIZE;

            // --- Truy vấn danh sách sản phẩm ---
            List<SanPham> products = sanPhamDAO.findAll(offset, PAGE_SIZE, sort, price, categoryId);

            // --- Danh mục ---
            List<DanhMuc> categories = danhMucDAO.getAllCategories();

            // --- Sản phẩm HOT ---
            List<Integer> hotProductIds;
            if (categoryId != null) {
                hotProductIds = sanPhamDAO.findTopNProductsByCategoryId(3, categoryId)
                        .stream().map(SanPham::getMaSP).collect(Collectors.toList());
            } else {
                hotProductIds = sanPhamDAO.findTopNProducts(5)
                        .stream().map(SanPham::getMaSP).collect(Collectors.toList());
            }

            // --- Gửi dữ liệu sang JSP ---
            req.setAttribute("products", products);
            req.setAttribute("categories", categories);
            req.setAttribute("hotProductIds", hotProductIds);
            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentPage", currentPage);
            req.setAttribute("price", price);
            req.setAttribute("sort", sort);
            req.setAttribute("category", categoryId);

            req.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(req, resp);

        } catch (Exception e) {
            System.err.println("❌ ERROR in HomeController.handleHomePage()");
            e.printStackTrace();
            req.setAttribute("errorMessage", "Không thể tải danh sách sản phẩm. Vui lòng thử lại sau.");
            req.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method not supported for /guest/home");
    }
}
