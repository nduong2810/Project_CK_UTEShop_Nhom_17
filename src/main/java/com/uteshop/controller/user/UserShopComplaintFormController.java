package com.uteshop.controller.user;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/shop-complaint-form")
public class UserShopComplaintFormController extends HttpServlet {

	private final CuaHangDAO shopDAO = new CuaHangDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		String shopIdStr = req.getParameter("shopId");
		if (shopIdStr != null) {
			try {
				Integer shopId = Integer.parseInt(shopIdStr.trim());
				CuaHang shop = shopDAO.findById(shopId);
				if (shop != null) {
					req.setAttribute("selectedShop", shop);
					req.setAttribute("shopId", shopId);
				}
			} catch (Exception e) {
				// Invalid shop ID, ignore
			}
		}

		// Load all active shops for selection
		List<CuaHang> shops = shopDAO.findAll();
		req.setAttribute("shops", shops);

		req.getRequestDispatcher("/WEB-INF/views/user/shop-complaint-form.jsp").forward(req, resp);
	}
}
