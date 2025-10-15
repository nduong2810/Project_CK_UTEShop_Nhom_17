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

@WebServlet("/guest/home")
public class HomeController extends HttpServlet {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy top 10 sản phẩm bán chạy
            List<SanPham> top10 = sanPhamDAO.getTop10SanPhamBanChay();
            request.setAttribute("top10", top10);
            
            // Lấy tất cả danh mục để hiển thị trong bộ lọc
            List<DanhMuc> categories = danhMucDAO.findAll();
            request.setAttribute("categories", categories);
            
        } catch (Exception e) {
            // Ghi lại lỗi để gỡ lỗi
            e.printStackTrace();
            // Đặt một danh sách trống để tránh lỗi NullPointerException trên trang JSP
            request.setAttribute("top10", Collections.emptyList());
            request.setAttribute("categories", Collections.emptyList());
            // Đặt một thông báo lỗi để hiển thị cho người dùng (tùy chọn)
            request.setAttribute("errorMessage", "Không thể tải sản phẩm. Vui lòng thử lại sau.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp");
        dispatcher.forward(request, response);
    }
}