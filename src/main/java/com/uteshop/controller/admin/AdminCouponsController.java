package com.uteshop.controller.admin;

import com.uteshop.dao.MaGiamGiaDAO;
import com.uteshop.entity.MaGiamGia;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/coupons")
public class AdminCouponsController extends HttpServlet {

	private final MaGiamGiaDAO couponDAO = new MaGiamGiaDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//		int pageSize = parseInt(req.getParameter("pageSize"), 10);
//		int page = parseInt(req.getParameter("page"), 1);
//		String q = trimToNull(req.getParameter("q"));
//		String type = trimToNull(req.getParameter("type")); // percent/amount tuỳ bạn lưu
//		String status = trimToNull(req.getParameter("status")); // ongoing/upcoming/expired
//		String sort = trimToNull(req.getParameter("sort"));
//
//		int total = couponDAO.countAll(q, type, status);
//		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
//		page = Math.min(Math.max(page, 1), totalPages);
//
//		List<MaGiamGia> list = couponDAO.findPaged(page, pageSize, q, type, status, sort);
//
//		req.setAttribute("coupons", list);
//		req.setAttribute("totalCoupons", total);
//		req.setAttribute("currentPage", page);
//		req.setAttribute("totalPages", totalPages);
//		req.setAttribute("pageSize", pageSize);
//
//		req.setAttribute("param_q", q);
//		req.setAttribute("param_type", type);
//		req.setAttribute("param_status", status);
//		req.setAttribute("param_sort", sort);
//
//		req.setAttribute("now", new Date()); // để JSP tính trạng thái hiển thị
//
//		req.getRequestDispatcher("/WEB-INF/views/admin/coupons.jsp").forward(req, resp);
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
