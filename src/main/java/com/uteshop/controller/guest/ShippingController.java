package com.uteshop.controller.guest;

import com.uteshop.dao.DonViVanChuyenDAO;
import com.uteshop.entity.DonViVanChuyen;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/guest/shipping/partners") // ✅ sửa mapping
public class ShippingController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DonViVanChuyenDAO donViVanChuyenDAO;

    @Override
    public void init() throws ServletException {
        this.donViVanChuyenDAO = new DonViVanChuyenDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Lấy danh sách đơn vị vận chuyển
            List<DonViVanChuyen> list = donViVanChuyenDAO.findAll();

            // Truyền sang JSP để hiển thị
            req.setAttribute("shippingPartners", list);

            // ✅ forward tới đúng JSP
            req.getRequestDispatcher("/WEB-INF/views/guest/shipping-partners.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi khi tải danh sách đơn vị vận chuyển", e);
        }
    }
}
