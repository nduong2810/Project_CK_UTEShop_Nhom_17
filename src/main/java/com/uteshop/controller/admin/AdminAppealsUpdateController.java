package com.uteshop.controller.admin;

import com.uteshop.dao.KhieuNaiNguoiDungDAO;
import com.uteshop.entity.KhieuNaiNguoiDung.TrangThai;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/appeals/update")
public class AdminAppealsUpdateController extends HttpServlet {

	private final KhieuNaiNguoiDungDAO dao = new KhieuNaiNguoiDungDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		Integer id = tryParseInt(req.getParameter("id"));
		String act = req.getParameter("action"); // approve | reject
		String note = req.getParameter("note");
		String back = req.getParameter("back"); // optional to redirect back with filters

		TrangThai st = "approve".equalsIgnoreCase(act) ? TrangThai.APPROVED : TrangThai.REJECTED;

		boolean ok = id != null && dao.updateStatus(id, st, note);
		String qs = ok ? "msg=updated" : "msg=error";

		String url = req.getContextPath() + "/admin/appeals?" + qs;
		if (back != null && !back.isBlank())
			url = url + "&" + back;
		resp.sendRedirect(url);
	}

	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}
}
