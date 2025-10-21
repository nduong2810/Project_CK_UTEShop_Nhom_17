package com.uteshop.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.uteshop.dao.DonHangDAO;
import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;

@WebServlet("/admin/home")
public class AdminController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy số liệu hiển thị trên dashboard
		int totalUsers = 0;
		int totalOrders = 0;
		int totalProducts = 0;
		
		
		NguoiDungDAO userDAO = new NguoiDungDAO();
		SanPhamDAO productDAO = new SanPhamDAO();
//		DonHangDAO orderDAO = new DonHangDAO();

		totalUsers = userDAO.countAllActive();
//		totalOrders = orderDAO.countAll();
		totalProducts  = productDAO.countActive();
		
		
		req.setAttribute("totalUsers", totalUsers);
//		req.setAttribute("totalOrders", totalOrders);
		req.setAttribute("totalProducts", totalProducts);
		req.getRequestDispatcher("/WEB-INF/views/admin/home.jsp").forward(req, resp);
	}
}