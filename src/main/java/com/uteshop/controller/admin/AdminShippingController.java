package com.uteshop.controller.admin;

import com.uteshop.dao.DonViVanChuyenDAO;
import com.uteshop.entity.DonViVanChuyen;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/shipping")
public class AdminShippingController extends HttpServlet {

	private final DonViVanChuyenDAO shipDAO = new DonViVanChuyenDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int pageSize = parseInt(req.getParameter("pageSize"), 10);
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String sort = trimToNull(req.getParameter("sort"));

		int total = shipDAO.countAll(q);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<DonViVanChuyen> list = shipDAO.findPaged(page, pageSize, q, sort);

		req.setAttribute("shippings", list);
		req.setAttribute("totalShippings", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		req.setAttribute("param_q", q);
		req.setAttribute("param_sort", sort);

		req.getRequestDispatcher("/WEB-INF/views/admin/shipping.jsp").forward(req, resp);
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
