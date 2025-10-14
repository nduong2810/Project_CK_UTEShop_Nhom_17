package com.uteshop.controller.guest;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/guest/product")
public class ProductController extends HttpServlet {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = "/WEB-INF/views/guest/product-detail.jsp";
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing.");
                return;
            }

            Integer productId = Integer.parseInt(idParam);
            SanPham product = sanPhamDAO.findById(productId); // Giả sử có phương thức findById

            if (product != null) {
                request.setAttribute("product", product);
            } else {
                request.setAttribute("errorMessage", "Sản phẩm không tồn tại.");
                pathInfo = "/WEB-INF/views/guest/home.jsp"; // Chuyển hướng về trang chủ nếu không tìm thấy
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID format.");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi không xác định khi tải sản phẩm.");
            pathInfo = "/WEB-INF/views/guest/home.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(pathInfo);
        dispatcher.forward(request, response);
    }
}
