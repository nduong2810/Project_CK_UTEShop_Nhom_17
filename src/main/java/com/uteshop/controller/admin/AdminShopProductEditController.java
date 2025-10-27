package com.uteshop.controller.admin;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.DanhMuc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/suppliers/products/edit")
public class AdminShopProductEditController extends HttpServlet {

	private final SanPhamDAO spDAO = new SanPhamDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer id = tryParseInt(req.getParameter("id"));
		Integer shopId = tryParseInt(req.getParameter("shopId"));
		if (id == null || shopId == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/suppliers?msg=invalid");
			return;
		}

		SanPham p = spDAO.findById(id);
		if (p == null || !shopId.equals(p.getMaCH())) {
			resp.sendRedirect(req.getContextPath() + "/admin/suppliers/products?shopId=" + shopId + "&msg=notfound");
			return;
		}

		List<DanhMuc> categories = spDAO.listCategories();

		req.setAttribute("shopId", shopId);
		req.setAttribute("p", p);
		req.setAttribute("categories", categories);
		req.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(req, resp); // tái dùng trang edit
																								// trước đó
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		Integer id = tryParseInt(req.getParameter("maSP"));
		Integer shopId = tryParseInt(req.getParameter("shopId"));
		if (id == null || shopId == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/suppliers?msg=invalid");
			return;
		}

		SanPham p = spDAO.findById(id);
		if (p == null || !shopId.equals(p.getMaCH())) {
			resp.sendRedirect(req.getContextPath() + "/admin/suppliers/products?shopId=" + shopId + "&msg=notfound");
			return;
		}

		// map form (giống bạn đang dùng)
		p.setTenSP(nvl(req.getParameter("tenSP")));
		p.setDonGia(parseDecimal(req.getParameter("donGia")));
		p.setSoLuongTon(parseInt(req.getParameter("soLuongTon"), 0));
		p.setHinhAnh(trimToNull(req.getParameter("hinhAnh")));
		p.setMoTa(trimToNull(req.getParameter("moTa")));
		p.setTrangThai("on".equals(req.getParameter("trangThai")));
		Integer catId = tryParseInt(req.getParameter("maDM"));
		if (catId != null)
			p.setMaDM(catId);

		boolean ok = spDAO.update(p);
		String qs = ok ? "msg=saved" : "msg=error";
		resp.sendRedirect(
				req.getContextPath() + "/admin/suppliers/products/edit?id=" + id + "&shopId=" + shopId + "&" + qs);
	}

	/* helpers */
	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}

	private int parseInt(String s, int def) {
		try {
			return (s == null || s.isBlank()) ? def : Integer.parseInt(s.trim());
		} catch (Exception e) {
			return def;
		}
	}

	private java.math.BigDecimal parseDecimal(String s) {
		try {
			return (s == null || s.isBlank()) ? java.math.BigDecimal.ZERO : new java.math.BigDecimal(s.trim());
		} catch (Exception e) {
			return java.math.BigDecimal.ZERO;
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
	