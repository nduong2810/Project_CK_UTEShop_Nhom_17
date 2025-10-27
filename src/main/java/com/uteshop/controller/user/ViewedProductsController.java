package com.uteshop.controller.user;

import com.uteshop.dao.SanPhamDaXemDAO;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/viewed")
public class ViewedProductsController extends HttpServlet {
    private final SanPhamDaXemDAO viewedDAO = new SanPhamDaXemDAO();
    private static final int PRODUCTS_PER_PAGE = 8; // 2 hàng x 4 sản phẩm

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        NguoiDung user = (session != null) ? (NguoiDung) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/guest/login");
            return;
        }

        String pageParam = req.getParameter("page");
        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1; // Default to page 1 if param is invalid
            }
        }

        long totalProducts = viewedDAO.countViewedByUser(user.getMaND());
        int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

        List<SanPham> viewed = viewedDAO.findViewedByUser(user.getMaND(), currentPage, PRODUCTS_PER_PAGE);
        
        req.setAttribute("viewedProducts", viewed);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);

        req.getRequestDispatcher("/WEB-INF/views/user/viewed.jsp").forward(req, resp);
    }
}
