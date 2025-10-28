package com.uteshop.controller.admin;

import com.uteshop.dao.KhieuNaiNguoiDungDAO;
import com.uteshop.entity.KhieuNaiNguoiDung.TrangThai;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.uteshop.entity.KhieuNaiNguoiDung;

@WebServlet("/admin/appeals")
public class AdminAppealsController extends HttpServlet {

	private final KhieuNaiNguoiDungDAO dao = new KhieuNaiNguoiDungDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int pageSize = parseInt(req.getParameter("pageSize"), 10);
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String stStr = trimToNull(req.getParameter("status"));
		String sort = trimToNull(req.getParameter("sort"));
		Integer userId = tryParseInt(req.getParameter("userId"));

		TrangThai status = null;
		if (stStr != null) {
			try {
				status = TrangThai.valueOf(stStr.toUpperCase());
			} catch (Exception ignored) {
			}
		}

		int total = dao.countAll(q, status, userId);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<KhieuNaiNguoiDung> list = dao.findPaged(page, pageSize, q, status, userId, sort);

		req.setAttribute("appeals", list);
		req.setAttribute("total", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		req.setAttribute("param_q", q);
		req.setAttribute("param_status", stStr);
		req.setAttribute("param_sort", sort);
		req.setAttribute("param_userId", userId);

		req.getRequestDispatcher("/WEB-INF/views/admin/appeals.jsp").forward(req, resp);
	}

	// helpers
	private int parseInt(String s, int def) {
		try {
			return (s == null || s.isBlank()) ? def : Integer.parseInt(s.trim());
		} catch (Exception e) {
			return def;
		}
	}

	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}

	private String trimToNull(String s) {
		if (s == null)
			return null;
		String t = s.trim();
		return t.isEmpty() ? null : t;
	}
}
