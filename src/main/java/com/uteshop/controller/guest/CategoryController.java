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

@WebServlet("/guest/category")
public class CategoryController extends HttpServlet {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = "/WEB-INF/views/guest/category-products.jsp";
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is missing.");
                return;
            }

            Integer categoryId = Integer.parseInt(idParam);
            
            // Lấy thông tin danh mục và danh sách sản phẩm
            DanhMuc category = danhMucDAO.findById(categoryId);
            List<SanPham> products = sanPhamDAO.findByCategoryId(categoryId);
            
            // Lấy tất cả danh mục để hiển thị trong dropdown lọc
            List<DanhMuc> allCategories = danhMucDAO.findAll();

            if (category != null) {
                request.setAttribute("category", category);
                request.setAttribute("products", products);
                request.setAttribute("allCategories", allCategories);
            } else {
                request.setAttribute("errorMessage", "Danh mục không tồn tại.");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID format.");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi không xác định khi tải trang danh mục.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(pathInfo);
        dispatcher.forward(request, response);
    }
}