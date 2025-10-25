package com.uteshop.controller.admin;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.DanhMuc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products/edit")
public class AdminProductEditController extends HttpServlet {

	private final SanPhamDAO spDAO = new SanPhamDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer id = tryParseInt(req.getParameter("id"));
		if (id == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/products");
			return;
		}

		SanPham sp = spDAO.findById(id);
		if (sp == null) {
			// Không thấy sản phẩm -> quay lại danh sách kèm báo lỗi
			resp.sendRedirect(req.getContextPath() + "/admin/products?msg=notfound");
			return;
		}

		// Danh mục để fill select
		List<DanhMuc> categories = spDAO.listCategories();

		req.setAttribute("p", sp);
		req.setAttribute("categories", categories);
		req.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		Integer maSP = tryParseInt(req.getParameter("maSP"));
		if (maSP == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/products?msg=invalid");
			return;
		}

		// Lấy sp hiện có
		SanPham sp = spDAO.findById(maSP);
		if (sp == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/products?msg=notfound");
			return;
		}

		// Map field từ form
		sp.setTenSP(nvl(req.getParameter("tenSP")));
		sp.setDonGia(parseDecimal(req.getParameter("donGia")));
		sp.setSoLuongTon(parseInt(req.getParameter("soLuongTon"), 0));
		sp.setHinhAnh(trimToNull(req.getParameter("hinhAnh")));
		sp.setMoTa(trimToNull(req.getParameter("moTa")));
		sp.setTrangThai("on".equals(req.getParameter("trangThai"))); // checkbox

		Integer catId = tryParseInt(req.getParameter("maDM"));
		if (catId != null) {
			sp.setMaDM(catId); // dùng field ID (JDBC-friendly). Nếu entity của bạn dùng @ManyToOne, hãy thay
								// đổi tương ứng.
		}

		boolean ok = spDAO.update(sp);
		String qs = ok ? "msg=saved" : "msg=error";
		resp.sendRedirect(req.getContextPath() + "/admin/products/edit?id=" + maSP + "&" + qs);
	}

	/* ===== Helpers ===== */
	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.trim().isEmpty()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}

	private int parseInt(String s, int def) {
		try {
			return (s == null || s.trim().isEmpty()) ? def : Integer.parseInt(s.trim());
		} catch (Exception e) {
			return def;
		}
	}

	private java.math.BigDecimal parseDecimal(String s) {
		try {
			return (s == null || s.trim().isEmpty()) ? java.math.BigDecimal.ZERO : new java.math.BigDecimal(s.trim());
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
