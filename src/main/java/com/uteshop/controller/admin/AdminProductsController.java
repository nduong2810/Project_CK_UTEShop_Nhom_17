package com.uteshop.controller.admin;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductsController extends HttpServlet {
	private final SanPhamDAO spDAO = new SanPhamDAO();

	private int parseInt(String value, int defaultValue) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return defaultValue;
		}
	}

	private String trimToNull(String value) {
		if (value == null)
			return null;
		value = value.trim();
		return value.isEmpty() ? null : value;
	}

	private Integer tryParseInt(String value) {
		try {
			if (value == null)
				return null; // nếu tham số là null → trả về null
			return Integer.parseInt(value.trim()); // ép kiểu chuỗi sang số nguyên
		} catch (NumberFormatException e) {
			return null; // nếu chuỗi không phải là số → trả về null
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int pageSize = parseInt(req.getParameter("pageSize"), 8); // 8 hoặc 10
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String sort = trimToNull(req.getParameter("sort"));
		Integer cat = tryParseInt(req.getParameter("cat"));

		int total = spDAO.countAll(q, cat);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<SanPham> products = spDAO.findPaged(page, pageSize, q, cat, sort);

		req.setAttribute("products", products);
		req.setAttribute("totalProducts", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("categories", spDAO.listCategories()); // cho sidebar nếu dùng

		req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
}
