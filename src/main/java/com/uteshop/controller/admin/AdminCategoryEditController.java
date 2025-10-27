package com.uteshop.controller.admin;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.entity.DanhMuc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/admin/categories/edit")
@MultipartConfig( // giới hạn tuỳ ý
		fileSizeThreshold = 1024 * 1024, // 1MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 20 // 20MB
)
public class AdminCategoryEditController extends HttpServlet {

	private final DanhMucDAO catDAO = new DanhMucDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer id = tryParseInt(req.getParameter("id"));
		DanhMuc cat = (id == null) ? new DanhMuc() : catDAO.findById(id);

		if (id != null && cat == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/categories?msg=notfound");
			return;
		}

		req.setAttribute("c", cat);
		req.getRequestDispatcher("/WEB-INF/views/admin/category-edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		Integer id = tryParseInt(req.getParameter("maDM"));
		DanhMuc data = (id == null) ? new DanhMuc() : catDAO.findById(id);
		if (id != null && data == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/categories?msg=notfound");
			return;
		}

		data.setTenDM(nvl(req.getParameter("tenDM")));
		data.setMoTa(trimToNull(req.getParameter("moTa")));
		data.setTrangThai("on".equals(req.getParameter("trangThai")) ? 1 : 0);

		// 1) Nếu người dùng nhập URL thủ công ở ô hinhAnhInput, ưu tiên dùng
		String manualPath = trimToNull(req.getParameter("hinhAnhInput"));

		// 2) Nếu có file upload => lưu file vào /assets/img và ghi đường dẫn
		Part imagePart = req.getPart("imageFile"); // name="imageFile" trong form
		String savedPath = null;
		if (imagePart != null && imagePart.getSize() > 0) {
			String fileName = extractFileName(imagePart); // tên gốc
			String ext = getExtension(fileName); // .jpg/.png...
			String safeName = UUID.randomUUID().toString().replace("-", "") + ext;

			String uploadDir = getServletContext().getRealPath("/assets/img");
			Files.createDirectories(Path.of(uploadDir));
			Path target = Path.of(uploadDir, safeName);

			try (InputStream is = imagePart.getInputStream()) {
				Files.copy(is, target, StandardCopyOption.REPLACE_EXISTING);
			}
			// Đường dẫn lưu vào DB (không kèm realPath)
			savedPath = "assets/img/" + safeName;
		}

		if (manualPath != null) {
			data.setHinhAnh(manualPath); // người dùng nhập tay
		} else if (savedPath != null) {
			data.setHinhAnh(savedPath); // file upload
		} // nếu không nhập gì => giữ nguyên ảnh cũ

		boolean ok = (id == null) ? catDAO.create(data) : catDAO.update(data);
		String qs = ok ? "msg=saved" : "msg=error";

		if (id == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/categories?" + qs);
		} else {
			resp.sendRedirect(req.getContextPath() + "/admin/categories/edit?id=" + id + "&" + qs);
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

	private String trimToNull(String s) {
		if (s == null)
			return null;
		String t = s.trim();
		return t.isEmpty() ? null : t;
	}

	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}

	private String extractFileName(Part part) {
		// Content-Disposition: form-data; name="imageFile"; filename="abc.jpg"
		String cd = part.getHeader("content-disposition");
		if (cd == null)
			return "file";
		for (String token : cd.split(";")) {
			token = token.trim();
			if (token.startsWith("filename")) {
				String name = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
				return name.contains("\\") ? name.substring(name.lastIndexOf('\\') + 1) : name;
			}
		}
		return "file";
	}

	private String getExtension(String fileName) {
		if (fileName == null)
			return "";
		int dot = fileName.lastIndexOf('.');
		return dot >= 0 ? fileName.substring(dot) : "";
	}
}
