package com.uteshop.controller.admin;

import com.uteshop.dao.MaGiamGiaDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/coupons/delete")
public class AdminCouponsDeleteController extends HttpServlet {
	private final MaGiamGiaDAO couponDAO = new MaGiamGiaDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer id = tryParseInt(req.getParameter("id"));
		boolean ok = (id != null) && couponDAO.delete(id);
		resp.sendRedirect(req.getContextPath() + "/admin/coupons?" + (ok ? "msg=deleted" : "msg=error"));
	}

	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}
}
