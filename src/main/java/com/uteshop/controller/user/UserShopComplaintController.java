package com.uteshop.controller.user;

import com.uteshop.dao.KhieuNaiCuaHangDAO;
import com.uteshop.dao.CuaHangDAO;
import com.uteshop.entity.KhieuNaiCuaHang;
import com.uteshop.entity.KhieuNaiCuaHang.TrangThai;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.CuaHang;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/shop-complaints")
public class UserShopComplaintController extends HttpServlet {

	private final KhieuNaiCuaHangDAO dao = new KhieuNaiCuaHangDAO();
	private final CuaHangDAO shopDAO = new CuaHangDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		NguoiDung user = (NguoiDung) session.getAttribute("user");

		int pageSize = parseInt(req.getParameter("pageSize"), 10);
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String stStr = trimToNull(req.getParameter("status"));
		String sort = trimToNull(req.getParameter("sort"));

		TrangThai status = null;
		if (stStr != null) {
			try {
				status = TrangThai.valueOf(stStr.toUpperCase());
			} catch (Exception ignored) {
			}
		}

		int total = dao.countAll(q, status, user.getMaND(), null);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<KhieuNaiCuaHang> list = dao.findPaged(page, pageSize, q, status, user.getMaND(), null, sort);

		req.setAttribute("complaints", list);
		req.setAttribute("total", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		req.setAttribute("param_q", q);
		req.setAttribute("param_status", stStr);
		req.setAttribute("param_sort", sort);

		req.getRequestDispatcher("/WEB-INF/views/user/shop-complaints.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String action = trimToNull(req.getParameter("action"));
		if ("create".equals(action)) {
			handleCreate(req, resp);
		} else if ("withdraw".equals(action)) {
			handleWithdraw(req, resp);
		} else {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
		}
	}

	private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");

		String shopIdStr = trimToNull(req.getParameter("shopId"));
		String title = trimToNull(req.getParameter("title"));
		String content = trimToNull(req.getParameter("content"));

		if (shopIdStr == null || title == null || content == null) {
			req.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
			req.getRequestDispatcher("/WEB-INF/views/user/shop-complaint-form.jsp").forward(req, resp);
			return;
		}

		Integer shopId = tryParseInt(shopIdStr);
		if (shopId == null) {
			req.setAttribute("error", "ID cửa hàng không hợp lệ!");
			req.getRequestDispatcher("/WEB-INF/views/user/shop-complaint-form.jsp").forward(req, resp);
			return;
		}

		CuaHang shop = shopDAO.findById(shopId);
		if (shop == null) {
			req.setAttribute("error", "Cửa hàng không tồn tại!");
			req.getRequestDispatcher("/WEB-INF/views/user/shop-complaint-form.jsp").forward(req, resp);
			return;
		}

		KhieuNaiCuaHang complaint = new KhieuNaiCuaHang();
		complaint.setNguoiDung(user);
		complaint.setCuaHang(shop);
		complaint.setTieuDe(title);
		complaint.setNoiDung(content);

		boolean success = dao.create(complaint);
		if (success) {
			req.getSession().setAttribute("success", "Gửi khiếu nại thành công!");
			resp.sendRedirect(req.getContextPath() + "/user/shop-complaints");
		} else {
			req.setAttribute("error", "Gửi khiếu nại thất bại!");
			req.setAttribute("shopId", shopId);
			req.setAttribute("title", title);
			req.setAttribute("content", content);
			req.getRequestDispatcher("/WEB-INF/views/user/shop-complaint-form.jsp").forward(req, resp);
		}
	}

	private void handleWithdraw(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		NguoiDung user = (NguoiDung) req.getSession().getAttribute("user");
		Integer complaintId = tryParseInt(req.getParameter("id"));

		if (complaintId == null) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid complaint ID");
			return;
		}

		boolean success = dao.withdraw(complaintId, user.getMaND());
		if (success) {
			req.getSession().setAttribute("success", "Thu hồi khiếu nại thành công!");
		} else {
			req.getSession().setAttribute("error", "Thu hồi khiếu nại thất bại! Chỉ có thể thu hồi khiếu nại đang chờ xử lý.");
		}

		resp.sendRedirect(req.getContextPath() + "/user/shop-complaints");
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
