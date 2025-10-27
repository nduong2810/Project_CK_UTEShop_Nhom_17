package com.uteshop.controller.admin;

import com.uteshop.dao.DonViVanChuyenDAO;
import com.uteshop.entity.DonViVanChuyen;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/shipping/edit")
public class AdminShippingEditController extends HttpServlet {

	private final DonViVanChuyenDAO shipDAO = new DonViVanChuyenDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer id = tryParseInt(req.getParameter("id"));
		DonViVanChuyen s = (id == null) ? new DonViVanChuyen() : shipDAO.findById(id);

		if (id != null && s == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/shipping?msg=notfound");
			return;
		}

		req.setAttribute("s", s);
		req.getRequestDispatcher("/WEB-INF/views/admin/shipping-edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		Integer id = tryParseInt(req.getParameter("maVC"));
		DonViVanChuyen data = (id == null) ? new DonViVanChuyen() : shipDAO.findById(id);
		if (id != null && data == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/shipping?msg=notfound");
			return;
		}

		data.setTenDonVi(nvl(req.getParameter("tenDonVi")));
		data.setPhiVanChuyen(parseMoney(req.getParameter("phiVanChuyen")));

		boolean ok = (id == null) ? shipDAO.create(data) : shipDAO.update(data);
		String qs = ok ? "msg=saved" : "msg=error";

		if (id == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/shipping?" + qs);
		} else {
			resp.sendRedirect(req.getContextPath() + "/admin/shipping/edit?id=" + id + "&" + qs);
		}
	}

	/* helpers */
	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}

	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}

	private BigDecimal parseMoney(String s) {
		try {
			return (s == null || s.isBlank()) ? BigDecimal.ZERO : new BigDecimal(s.trim());
		} catch (Exception e) {
			return BigDecimal.ZERO;
		}
	}
}
