// AdminOrderViewController.java
package com.uteshop.controller.admin;

import com.uteshop.dao.DonHangDAO;
import com.uteshop.entity.DonHang;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/orders/view")
public class AdminOrderViewController extends HttpServlet {
	private final DonHangDAO orderDao = new DonHangDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int id;
		try {
			id = Integer.parseInt(req.getParameter("id"));
		} catch (Exception e) {
			resp.sendError(400, "id không hợp lệ");
			return;
		}

		DonHang dh = orderDao.findByIdWithItems(id);
		if (dh == null) {
			resp.sendError(404, "Không tìm thấy đơn hàng");
			return;
		}

		req.setAttribute("order", dh);
		req.getRequestDispatcher("/WEB-INF/views/admin/order-view.jsp").forward(req, resp);
	}
}
