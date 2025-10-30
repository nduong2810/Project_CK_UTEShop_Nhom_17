package com.uteshop.controller.admin;

import com.uteshop.dao.KhieuNaiCuaHangDAO;
import com.uteshop.entity.KhieuNaiCuaHang;
import com.uteshop.entity.KhieuNaiCuaHang.TrangThai;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/shop-complaints")
public class AdminShopComplaintsController extends HttpServlet {

	private final KhieuNaiCuaHangDAO dao = new KhieuNaiCuaHangDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int pageSize = parseInt(req.getParameter("pageSize"), 10);
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String stStr = trimToNull(req.getParameter("status"));
		String sort = trimToNull(req.getParameter("sort"));
		Integer userId = tryParseInt(req.getParameter("userId"));
		Integer vendorId = tryParseInt(req.getParameter("vendorId"));

		TrangThai status = null;
		if (stStr != null) {
			try {
				status = TrangThai.valueOf(stStr.toUpperCase());
			} catch (Exception ignored) {
			}
		}

		int total = dao.countAll(q, status, userId, vendorId);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<KhieuNaiCuaHang> list = dao.findPaged(page, pageSize, q, status, userId, vendorId, sort);

		req.setAttribute("complaints", list);
		req.setAttribute("total", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		req.setAttribute("param_q", q);
		req.setAttribute("param_status", stStr);
		req.setAttribute("param_sort", sort);
		req.setAttribute("param_userId", userId);
		req.setAttribute("param_vendorId", vendorId);

		req.getRequestDispatcher("/WEB-INF/views/admin/shop-complaints.jsp").forward(req, resp);
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
