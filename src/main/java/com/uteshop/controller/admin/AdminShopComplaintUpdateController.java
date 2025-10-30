package com.uteshop.controller.admin;

import com.uteshop.dao.KhieuNaiCuaHangDAO;
import com.uteshop.entity.KhieuNaiCuaHang.TrangThai;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/shop-complaint-update")
public class AdminShopComplaintUpdateController extends HttpServlet {

	private final KhieuNaiCuaHangDAO dao = new KhieuNaiCuaHangDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String idStr = trimToNull(req.getParameter("id"));
		String statusStr = trimToNull(req.getParameter("status"));
		String note = trimToNull(req.getParameter("note"));

		if (idStr == null || statusStr == null) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
			return;
		}

		Integer id;
		try {
			id = Integer.parseInt(idStr);
		} catch (Exception e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
			return;
		}

		TrangThai status;
		try {
			status = TrangThai.valueOf(statusStr.toUpperCase());
		} catch (Exception e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid status");
			return;
		}

		// Only admin can change to APPROVED or REJECTED
		if (status != TrangThai.APPROVED && status != TrangThai.REJECTED) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid status transition");
			return;
		}

		boolean success = dao.updateStatus(id, status, note);

		if (success) {
			req.getSession().setAttribute("success", "Cập nhật trạng thái khiếu nại thành công!");
		} else {
			req.getSession().setAttribute("error", "Cập nhật trạng thái thất bại!");
		}

		resp.sendRedirect(req.getContextPath() + "/admin/shop-complaints");
	}

	private String trimToNull(String s) {
		if (s == null)
			return null;
		String t = s.trim();
		return t.isEmpty() ? null : t;
	}
}
