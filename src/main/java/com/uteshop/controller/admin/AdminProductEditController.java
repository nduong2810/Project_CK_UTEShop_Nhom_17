package com.uteshop.controller.admin;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/products/edit")
@MultipartConfig(fileSizeThreshold = 1 * 1024 * 1024, // 1MB
		maxFileSize = 10L * 1024 * 1024, // 10MB
		maxRequestSize = 20L * 1024 * 1024 // 20MB
)
public class AdminProductEditController extends HttpServlet {

	private final SanPhamDAO spDAO = new SanPhamDAO();

	/* ============================ GET ============================ */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer id = tryParseInt(req.getParameter("id"));
		if (id == null)
			id = tryParseInt(req.getParameter("maSP")); // chấp nhận cả ?maSP=
		SanPham sp = (id == null) ? new SanPham() : spDAO.findById(id);
		if (id != null && sp == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/products?msg=notfound");
			return;
		}

		List<DanhMuc> categories = spDAO.listCategories();
		req.setAttribute("p", sp);
		req.setAttribute("categories", categories);
		req.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(req, resp);
	}

	/* ============================ POST =========================== */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		Integer maSP = tryParseInt(req.getParameter("maSP"));
		SanPham sp = (maSP == null) ? new SanPham() : spDAO.findById(maSP);
		if (maSP != null && sp == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/products?msg=notfound");
			return;
		}

		// Map các trường text
		sp.setTenSP(nvl(req.getParameter("tenSP")));
		sp.setMoTa(trimToNull(req.getParameter("moTa")));
		sp.setDonGia(parseDecimal(req.getParameter("donGia")));
		sp.setSoLuongTon(parseInt(req.getParameter("soLuongTon"), 0));
		sp.setTrangThai("on".equals(req.getParameter("trangThai")));

		Integer catId = tryParseInt(req.getParameter("maDM"));
		if (catId != null)
			sp.setMaDM(catId);

		// Ảnh: ưu tiên file upload; nếu không có file thì dùng ô text; nếu cả hai rỗng
		// → giữ ảnh cũ
		String uploadedName = saveUploadedImage(req.getPart("fileImage")); // chỉ tên file, hoặc null
		if (uploadedName != null) {
			sp.setHinhAnh(uploadedName);
		} else {
			String typed = trimToNull(req.getParameter("hinhAnh"));
			if (typed != null)
				sp.setHinhAnh(Path.of(typed).getFileName().toString());
			// nếu typed == null → KHÔNG đụng vào sp.hinhAnh để DAO không ghi đè
		}

		boolean ok;
		if (maSP == null) {
			// tạo mới
			ok = spDAO.insert(sp);
		} else {
			// cập nhật (DAO.update chỉ set HinhAnh khi có giá trị mới)
			ok = spDAO.update(sp);
		}

		String qs = ok ? "msg=saved" : "msg=error";
		if (maSP == null && ok) {
			// vừa tạo xong → quay về list
			resp.sendRedirect(req.getContextPath() + "/admin/products?" + qs);
		} else {
			// sửa → ở lại trang sửa
			Integer backId = (sp.getMaSP() != null) ? sp.getMaSP() : maSP;
			resp.sendRedirect(req.getContextPath() + "/admin/products/edit?id=" + backId + "&" + qs);
		}
	}

	/* ======================== IMAGE HELPER ======================= */
	/**
	 * Lưu ảnh vào /assets/img (webapp) và trả về TÊN FILE (không path). Trả về null
	 * nếu không có file.
	 */
	private String saveUploadedImage(Part part) throws IOException, ServletException {
		if (part == null || part.getSize() == 0)
			return null;

		String ct = part.getContentType();
		if (ct == null || !ct.startsWith("image/")) {
			throw new ServletException("File tải lên không phải ảnh hợp lệ.");
		}

		// Tạo tên file an toàn + timestamp
		String submitted = part.getSubmittedFileName();
		String base = (submitted == null ? "image" : submitted.replace("\\", "/"));
		base = base.substring(base.lastIndexOf('/') + 1);
		base = base.replaceAll("[^a-zA-Z0-9._-]", "_");
		int dot = base.lastIndexOf('.');
		String ts = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
		String safeName = (dot > 0) ? base.substring(0, dot) + "_" + ts + base.substring(dot) : base + "_" + ts;

		String uploadDir = getServletContext().getRealPath("/assets/img");
		if (uploadDir == null) {
			// nếu WAR không exploded → nên chuyển qua thư mục ngoài + static mapping
			throw new ServletException(
					"Không xác định được thư mục /assets/img. Bật exploded deployment hoặc cấu hình thư mục upload ngoài.");
		}

		Files.createDirectories(Path.of(uploadDir));
		try (InputStream is = part.getInputStream()) {
			Files.copy(is, Path.of(uploadDir, safeName), StandardCopyOption.REPLACE_EXISTING);
		}
		return safeName; // chỉ tên file để ghép với /assets/img khi render
	}

	/* ============================ Utils ========================== */
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

	private BigDecimal parseDecimal(String s) {
		try {
			return (s == null || s.trim().isEmpty()) ? BigDecimal.ZERO : new BigDecimal(s.trim());
		} catch (Exception e) {
			return BigDecimal.ZERO;
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
