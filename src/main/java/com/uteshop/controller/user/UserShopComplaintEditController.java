package com.uteshop.controller.user;

import com.uteshop.dao.KhieuNaiCuaHangDAO;
import com.uteshop.entity.KhieuNaiCuaHang;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/shop-complaint-edit")
public class UserShopComplaintEditController extends HttpServlet {

	private final KhieuNaiCuaHangDAO dao = new KhieuNaiCuaHangDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		NguoiDung user = (NguoiDung) session.getAttribute("user");
		
		String idStr = trimToNull(req.getParameter("id"));
		String title = trimToNull(req.getParameter("title"));
		String content = trimToNull(req.getParameter("content"));
		String shopIdStr = trimToNull(req.getParameter("shopId"));

		if (idStr == null || title == null || content == null) {
			session.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
			redirectBack(req, resp, shopIdStr);
			return;
		}

		Integer id;
		try {
			id = Integer.parseInt(idStr);
		} catch (Exception e) {
			session.setAttribute("error", "ID khiếu nại không hợp lệ!");
			redirectBack(req, resp, shopIdStr);
			return;
		}

		// Load complaint and verify ownership
		KhieuNaiCuaHang complaint = dao.findById(id);
		if (complaint == null) {
			session.setAttribute("error", "Khiếu nại không tồn tại!");
			redirectBack(req, resp, shopIdStr);
			return;
		}

		if (!complaint.getNguoiDung().getMaND().equals(user.getMaND())) {
			session.setAttribute("error", "Bạn không có quyền sửa khiếu nại này!");
			redirectBack(req, resp, shopIdStr);
			return;
		}

		if (complaint.getTrangThai() != KhieuNaiCuaHang.TrangThai.PENDING) {
			session.setAttribute("error", "Chỉ có thể sửa khiếu nại đang chờ xử lý!");
			redirectBack(req, resp, shopIdStr);
			return;
		}

		// Update complaint
		boolean success = dao.update(id, title, content);
		if (success) {
			session.setAttribute("success", "Cập nhật khiếu nại thành công!");
		} else {
			session.setAttribute("error", "Cập nhật khiếu nại thất bại!");
		}

		redirectBack(req, resp, shopIdStr);
	}

	private void redirectBack(HttpServletRequest req, HttpServletResponse resp, String shopId) throws IOException {
		if (shopId != null) {
			resp.sendRedirect(req.getContextPath() + "/guest/supplier/detail?id=" + shopId);
		} else {
			resp.sendRedirect(req.getContextPath() + "/user/shop-complaints");
		}
	}

	private String trimToNull(String s) {
		if (s == null)
			return null;
		String t = s.trim();
		return t.isEmpty() ? null : t;
	}
}
