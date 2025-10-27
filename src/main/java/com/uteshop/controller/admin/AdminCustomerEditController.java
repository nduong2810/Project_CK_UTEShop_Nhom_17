// src/main/java/com/uteshop/controller/admin/AdminCustomerEditController.java
package com.uteshop.controller.admin;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/customers/edit")
public class AdminCustomerEditController extends HttpServlet {

	private final NguoiDungDAO userDAO = new NguoiDungDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer id = tryParseInt(req.getParameter("id"));
		if (id == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/customers?msg=invalid");
			return;
		}
		NguoiDung u = userDAO.findById(id);
		if (u == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/customers?msg=notfound");
			return;
		}
		req.setAttribute("u", u);
		req.getRequestDispatcher("/WEB-INF/views/admin/customer-edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		Integer id = tryParseInt(req.getParameter("maND"));
		if (id == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/customers?msg=invalid");
			return;
		}
		NguoiDung u = userDAO.findById(id);
		if (u == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/customers?msg=notfound");
			return;
		}

		// Map dữ liệu form (không đổi password ở đây)
		u.setHoTen(nvl(req.getParameter("hoTen")));
		u.setEmail(nvl(req.getParameter("email")));
		u.setSoDienThoai(trimToNull(req.getParameter("soDienThoai")));
		u.setDiaChi(trimToNull(req.getParameter("diaChi")));

		String roleS = req.getParameter("vaiTro");
		try {
			if (roleS != null)
				u.setVaiTro(NguoiDung.VaiTro.valueOf(roleS));
		} catch (Exception ignore) {
		}
		u.setTrangThai("on".equals(req.getParameter("trangThai")));

		boolean ok = userDAO.update(u);
		resp.sendRedirect(req.getContextPath() + "/admin/customers/edit?id=" + id + (ok ? "&msg=saved" : "&msg=error"));
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

	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}
}
