// src/main/java/com/uteshop/controller/admin/AdminCustomersController.java
package com.uteshop.controller.admin;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/customers")
public class AdminCustomersController extends HttpServlet {

	private final NguoiDungDAO userDAO = new NguoiDungDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int pageSize = parseInt(req.getParameter("pageSize"), 10); // 8/10/20 tuỳ ý
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String sort = trimToNull(req.getParameter("sort"));
		String roleS = trimToNull(req.getParameter("role"));

		NguoiDung.VaiTro role = null;
		try {
			if (roleS != null)
				role = NguoiDung.VaiTro.valueOf(roleS);
		} catch (Exception ignore) {
		}

		int total = userDAO.countAll(q, role);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<NguoiDung> users = userDAO.findPaged(page, pageSize, q, role, sort);

		req.setAttribute("users", users);
		req.setAttribute("totalUsers", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("param_q", q);
		req.setAttribute("param_role", roleS);
		req.setAttribute("param_sort", sort);

		req.getRequestDispatcher("/WEB-INF/views/admin/customers.jsp").forward(req, resp);
	}

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
