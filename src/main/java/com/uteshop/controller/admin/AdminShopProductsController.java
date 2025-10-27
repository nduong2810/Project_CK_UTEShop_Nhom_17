package com.uteshop.controller.admin;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.DanhMuc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/suppliers/products")
public class AdminShopProductsController extends HttpServlet {

	private final SanPhamDAO spDAO = new SanPhamDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer shopId = tryParseInt(req.getParameter("shopId"));
		if (shopId == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/suppliers?msg=needShop");
			return;
		}

		int pageSize = parseInt(req.getParameter("pageSize"), 10); // 8/10 tuỳ ý
		int page = parseInt(req.getParameter("page"), 1);
		String q = trimToNull(req.getParameter("q"));
		String sort = trimToNull(req.getParameter("sort"));

		Integer catId = tryParseInt(req.getParameter("category"));
		String status = trimToNull(req.getParameter("status")); // all|active|inactive
		Boolean active = null;
		if ("active".equalsIgnoreCase(status))
			active = true;
		else if ("inactive".equalsIgnoreCase(status))
			active = false;

		int total = spDAO.countByShop(shopId, q, catId, active);
		int totalPages = Math.max(1, (int) Math.ceil(total * 1.0 / pageSize));
		page = Math.min(Math.max(page, 1), totalPages);

		List<SanPham> products = spDAO.findPagedByShop(shopId, page, pageSize, q, catId, active, sort);
		List<DanhMuc> categories = spDAO.listCategories();

		req.setAttribute("shopId", shopId);
		req.setAttribute("products", products);
		req.setAttribute("categories", categories);

		req.setAttribute("totalProducts", total);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("pageSize", pageSize);

		req.setAttribute("param_q", q);
		req.setAttribute("param_sort", sort);
		req.setAttribute("param_status", status);
		req.setAttribute("param_category", catId);

		req.getRequestDispatcher("/WEB-INF/views/admin/shop-products.jsp").forward(req, resp);
	}

	/* helpers */
	private int parseInt(String s, int def) {
		try {
			return (s == null || s.isBlank()) ? def : Integer.parseInt(s.trim());
		} catch (Exception e) {
			return def;
		}
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
}
