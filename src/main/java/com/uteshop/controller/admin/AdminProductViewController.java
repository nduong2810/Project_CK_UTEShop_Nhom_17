// src/main/java/com/uteshop/controller/admin/AdminProductViewController.java
package com.uteshop.controller.admin;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/products/view")
public class AdminProductViewController extends HttpServlet {

	private final SanPhamDAO spDAO = new SanPhamDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer id = tryParseInt(req.getParameter("id"));
		if (id == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/products?msg=invalid");
			return;
		}

		SanPham p = spDAO.findById(id);
		if (p == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/products?msg=notfound");
			return;
		}

		// (tuỳ chọn) lấy tên danh mục nếu cần hiển thị
		String tenDanhMuc = spDAO.findCategoryNameById(p.getMaDM()); // thêm ở DAO, xem bên dưới

		req.setAttribute("p", p);
		req.setAttribute("tenDanhMuc", tenDanhMuc);
		req.getRequestDispatcher("/WEB-INF/views/admin/product-detail.jsp").forward(req, resp);
	}

	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.trim().isEmpty()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}
}
