package com.uteshop.controller.admin;

import com.uteshop.dao.DonViVanChuyenDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/shipping/delete")
public class AdminShippingDeleteController extends HttpServlet {
	private final DonViVanChuyenDAO shipDAO = new DonViVanChuyenDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		Integer id = tryParseInt(req.getParameter("id"));

		boolean ok = (id != null) && shipDAO.delete(id);
		resp.sendRedirect(req.getContextPath() + "/admin/shipping?" + (ok ? "msg=deleted" : "msg=error"));
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// Không hỗ trợ GET để xoá -> quay lại list
		resp.sendRedirect(req.getContextPath() + "/admin/shipping");
	}

	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}
}
