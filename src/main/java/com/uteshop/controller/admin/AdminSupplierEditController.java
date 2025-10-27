package com.uteshop.controller.admin;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.entity.CuaHang;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/suppliers/edit")
public class AdminSupplierEditController extends HttpServlet {
	private final CuaHangDAO shopDao = new CuaHangDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer id = parseInt(req.getParameter("id"));
		CuaHang shop = (id == null) ? new CuaHang() : shopDao.findById(id);
		if (id != null && shop == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/suppliers?msg=notfound");
			return;
		}
		req.setAttribute("shop", shop);
		req.getRequestDispatcher("/WEB-INF/views/admin/suppliers-edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		Integer maCH = parseInt(req.getParameter("maCH"));
		CuaHang data = (maCH == null) ? new CuaHang() : shopDao.findById(maCH);
		if (maCH != null && data == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/suppliers?msg=notfound");
			return;
		}

		data.setTenCH(nvl(req.getParameter("tenCH")));
		data.setDiaChi(trimToNull(req.getParameter("diaChi")));
		data.setSoDienThoai(trimToNull(req.getParameter("soDienThoai")));
		data.setEmail(trimToNull(req.getParameter("email")));
		data.setTrangThai("on".equalsIgnoreCase(req.getParameter("trangThai")));

		// TyLeChietKhau 0..100
		BigDecimal rate = parseBig(req.getParameter("tyLeChietKhau"));
		if (rate != null && (rate.compareTo(BigDecimal.ZERO) < 0 || rate.compareTo(new BigDecimal("100")) > 0)) {
			req.setAttribute("error", "Tỷ lệ chiết khấu phải trong khoảng 0..100");
			req.setAttribute("shop", data);
			req.getRequestDispatcher("/WEB-INF/views/admin/suppliers-edit.jsp").forward(req, resp);
			return;
		}
		data.setTyLeChietKhau(rate);

		boolean ok = (maCH == null) ? shopDao.create(data) : shopDao.update(data);
		resp.sendRedirect(req.getContextPath() + "/admin/suppliers?" + (ok ? "msg=saved" : "msg=error"));
	}

	private Integer parseInt(String s) {
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

	private BigDecimal parseBig(String s) {
		try {
			return (s == null || s.isBlank()) ? null : new BigDecimal(s.trim());
		} catch (Exception e) {
			return null;
		}
	}
}
