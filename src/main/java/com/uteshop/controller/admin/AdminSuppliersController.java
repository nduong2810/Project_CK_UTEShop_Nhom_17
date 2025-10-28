package com.uteshop.controller.admin;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.entity.CuaHang;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/suppliers")
public class AdminSuppliersController extends HttpServlet {
	private final CuaHangDAO shopDao = new CuaHangDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// ---- đọc tham số
		int pageSize = parseInt(req.getParameter("pageSize"), 10);
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String sort = trimToNull(req.getParameter("sort")); // id_desc (default), id_asc, name_asc, name_desc, date_asc,
															// date_desc
		Boolean active = parseBooleanNullable(req.getParameter("active")); // "true"/"false"/null
		Integer ownerId = parseIntNullable(req.getParameter("ownerId"));

		// ---- đếm & phân trang
		int total = shopDao.countAll(q, active, ownerId);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		// ---- dữ liệu trang
		if (sort == null)
			sort = "id_asc"; // <-- mặc định tăng dần
		List<CuaHang> list = shopDao.findPaged(page, pageSize, q, active, ownerId, sort);
//		List<CuaHang> list = shopDao.findPaged(page, pageSize, q, active, ownerId, sort);

		// ---- gắn attribute ra view
		req.setAttribute("shops", list);
		req.setAttribute("total", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		// giữ lại tham số lọc/sort để render UI
		req.setAttribute("param_q", q);
		req.setAttribute("param_sort", sort);
		req.setAttribute("param_active", active);
		req.setAttribute("param_ownerId", ownerId);

		req.getRequestDispatcher("/WEB-INF/views/admin/suppliers.jsp").forward(req, resp);
	}

	// -------- helpers ----------
	private int parseInt(String s, int def) {
		try {
			return (s == null || s.isBlank()) ? def : Integer.parseInt(s.trim());
		} catch (Exception e) {
			return def;
		}
	}

	private Integer parseIntNullable(String s) {
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

	private Boolean parseBooleanNullable(String s) {
		if (s == null || s.isBlank())
			return null;
		String t = s.trim().toLowerCase();
		if ("true".equals(t) || "1".equals(t) || "yes".equals(t))
			return Boolean.TRUE;
		if ("false".equals(t) || "0".equals(t) || "no".equals(t))
			return Boolean.FALSE;
		return null;
	}
}
