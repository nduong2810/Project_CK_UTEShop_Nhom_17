package com.uteshop.controller.admin;



import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/home")
public class AdminController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy số liệu hiển thị trên dashboard

		req.getRequestDispatcher("/WEB-INF/views/admin/home.jsp").forward(req, resp);
	}
}