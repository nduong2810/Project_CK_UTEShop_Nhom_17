package com.uteshop.controller.admin;

import com.uteshop.dao.DonHangDAO;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.DonHang.TrangThaiDonHang;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrdersController extends HttpServlet {

	private final DonHangDAO orderDao = new DonHangDAO();
	private static final SimpleDateFormat DF = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String q = trimToNull(req.getParameter("q"));
		String statusStr = trimToNull(req.getParameter("status"));
		Date from = parseDate(req.getParameter("from"));
		Date to = parseDate(req.getParameter("to"));
		int page = parseIntOrDefault(req.getParameter("page"), 1);
		int pageSize = parseIntOrDefault(req.getParameter("pageSize"), 10);

		TrangThaiDonHang status = orderDao.mapStatus(statusStr);

		String sort = req.getParameter("sort");
		if (sort == null || sort.isBlank())
			sort = "id_asc";// ví dụ: id_desc (mặc định)
		List<DonHang> orders = orderDao.findPaged(q, status, from, to, page, pageSize, sort);
		int total = orderDao.countAll(q, status, from, to);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		req.setAttribute("orders", orders);
		req.setAttribute("total", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		req.setAttribute("param_q", q);
		req.setAttribute("param_status", statusStr);
		req.setAttribute("param_from", req.getParameter("from"));
		req.setAttribute("param_to", req.getParameter("to"));

		req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String op = req.getParameter("op");
		if ("updateStatus".equalsIgnoreCase(op)) {
			int id = parseIntOrDefault(req.getParameter("id"), -1);
			TrangThaiDonHang st = orderDao.mapStatus(req.getParameter("newStatus"));
			boolean ok = id > 0 && st != null && orderDao.updateStatus(id, st);
			resp.sendRedirect(req.getContextPath() + "/admin/orders?" + (ok ? "msg=updated" : "msg=error"));
			return;
		}
		resp.sendRedirect(req.getContextPath() + "/admin/orders");
	}

	private static Date parseDate(String s) {
		try {
			return (s == null || s.isBlank()) ? null : DF.parse(s.trim());
		} catch (Exception e) {
			return null;
		}
	}

	private static int parseIntOrDefault(String s, int def) {
		try {
			return (s == null || s.isBlank()) ? def : Integer.parseInt(s.trim());
		} catch (Exception e) {
			return def;
		}
	}

	private static String trimToNull(String s) {
		if (s == null)
			return null;
		String t = s.trim();
		return t.isEmpty() ? null : t;
	}
}
