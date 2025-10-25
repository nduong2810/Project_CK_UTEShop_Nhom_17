package com.uteshop.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.uteshop.dao.DashboardDAO;
import com.uteshop.dao.DonHangDAO;
import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.SanPham;

@WebServlet("/admin/home")
public class AdminController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy số liệu hiển thị trên dashboard
		DashboardDAO dao = new DashboardDAO();

		int totalUsers = dao.countUsers();
		int ordersToday = dao.countOrdersToday();
		BigDecimal revenueToday = dao.revenueToday();
		int activeProducts = dao.countActiveProducts();
		List<DonHang> recentOrders = dao.getRecentOrders(5);
		
		req.setAttribute("totalUsers", totalUsers);
		req.setAttribute("totalOrders", ordersToday);
		req.setAttribute("revenueToday", revenueToday);
		req.setAttribute("totalProducts", activeProducts);
		req.setAttribute("recentOrders", recentOrders);
		req.getRequestDispatcher("/WEB-INF/views/admin/home.jsp").forward(req, resp);
	}
}