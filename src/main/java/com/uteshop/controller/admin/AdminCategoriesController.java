package com.uteshop.controller.admin;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.entity.DanhMuc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoriesController extends HttpServlet {

	private final DanhMucDAO catDAO = new DanhMucDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int pageSize = parseInt(req.getParameter("pageSize"), 10);
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String sort = trimToNull(req.getParameter("sort"));

		// status: all|active|inactive -> map sang Integer 1/0
		String status = trimToNull(req.getParameter("status"));
		Integer activeInt = null;
		if ("active".equalsIgnoreCase(status))
			activeInt = 1;
		else if ("inactive".equalsIgnoreCase(status))
			activeInt = 0;

		int total = catDAO.countAll(q, activeInt);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<DanhMuc> cats = catDAO.findPaged(page, pageSize, q, activeInt, sort);

		req.setAttribute("categories", cats);
		req.setAttribute("totalCategories", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		req.setAttribute("param_q", q);
		req.setAttribute("param_status", status);
		req.setAttribute("param_sort", sort);

		req.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(req, resp);
	}

	/* helpers */
	private int parseInt(String s, int def) {
		try {
			return (s == null || s.isBlank()) ? def : Integer.parseInt(s.trim());
		} catch (Exception e) {
			return def;
		}
	}

	private String trimToNull(String s) {
		if (s == null)
			return null;
		String t = s.trim();
		return t.isEmpty() ? null : t;
	}
}
