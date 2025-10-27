package com.uteshop.controller.admin;

import com.uteshop.dao.CuaHangDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/suppliers/delete")
public class AdminSupplierDeleteController extends HttpServlet {
	private final CuaHangDAO shopDao = new CuaHangDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer id = parseInt(req.getParameter("id"));
		boolean ok = (id != null) && shopDao.delete(id);
		resp.sendRedirect(req.getContextPath() + "/admin/suppliers?" + (ok ? "msg=deleted" : "msg=error"));
	}

	private Integer parseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}
}
