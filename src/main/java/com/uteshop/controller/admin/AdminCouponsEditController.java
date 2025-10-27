package com.uteshop.controller.admin;

import com.uteshop.dao.MaGiamGiaDAO;
import com.uteshop.entity.MaGiamGia;
import com.uteshop.entity.MaGiamGia.LoaiGiam;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@WebServlet("/admin/coupons/edit")
public class AdminCouponsEditController extends HttpServlet {

	private final MaGiamGiaDAO couponDAO = new MaGiamGiaDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer id = tryParseInt(req.getParameter("id"));
		MaGiamGia c = (id == null) ? new MaGiamGia() : couponDAO.findById(id);

		if (id != null && c == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/coupons?msg=notfound");
			return;
		}
		req.setAttribute("c", c);
		req.getRequestDispatcher("/WEB-INF/views/admin/coupons-edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		Integer id = tryParseInt(req.getParameter("maGG"));
		MaGiamGia data = (id == null) ? new MaGiamGia() : couponDAO.findById(id);
		if (id != null && data == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/coupons?msg=notfound");
			return;
		}

		// --- Lấy và chuẩn hoá input ---
		// Form vẫn gửi tên 'maCode' => map vào entity field 'maSo'
		String maCode = nvl(req.getParameter("maCode"));
		String ten = nvl(req.getParameter("tenChuongTrinh"));
		String loai = nvl(req.getParameter("loaiGiam")); // "percent" | "amount" | ...
		BigDecimal giaTriGiam = parseMoney(req.getParameter("giaTriGiam"));

		BigDecimal minOrder = parseMoney(req.getParameter("giaTriDonHangToiThieu"));
		BigDecimal capAmt = parseMoney(req.getParameter("giaTriGiamToiDa")); // dùng cho % (optional)

		Integer soLuongToiDa = tryParseInt(req.getParameter("soLuongToiDa"));
		boolean trangThai = "on".equalsIgnoreCase(req.getParameter("trangThai"))
				|| "true".equalsIgnoreCase(req.getParameter("trangThai"));

		LocalDateTime start = parseDateStart(req.getParameter("ngayBatDau")); // yyyy-MM-dd -> 00:00:00
		LocalDateTime end = parseDateEnd(req.getParameter("ngayKetThuc")); // yyyy-MM-dd -> 23:59:59
		// Nếu form có ô riêng cho hạn sử dụng: dùng nó; còn không, mặc định = ngày kết
		// thúc 23:59:59
		LocalDateTime hsd = parseDateEnd(nvl(req.getParameter("hanSuDung")));
		if (hsd == null)
			hsd = end;

		// --- Validate unique code (theo maSo) ---
		MaGiamGia existed = couponDAO.findByCode(maCode); // Hãy đảm bảo DAO tìm theo c.maSo
		if (existed != null && (id == null || existed.getMaGG() != id.intValue())) {
			resp.sendRedirect(req.getContextPath() + "/admin/coupons/edit" + (id != null ? ("?id=" + id) : "")
					+ "&msg=code_exists");
			return;
		}

		// --- Gán vào entity ---
		data.setMaSo(maCode); // <-- map maCode -> maSo
		data.setTenChuongTrinh(ten);
		data.setLoaiGiam(toLoaiGiam(loai)); // enum
		data.setGiaTriGiam(giaTriGiam);

		data.setGiaTriDonHangToiThieu(nullIfZero(minOrder));
		data.setGiaTriGiamToiDa(nullIfZero(capAmt)); // chỉ meaningful cho PERCENT

		if (start != null)
			data.setNgayBatDau(start);
		if (end != null)
			data.setNgayKetThuc(end);
		if (hsd != null)
			data.setHanSuDung(hsd);

		if (soLuongToiDa != null)
			data.setSoLuongToiDa(soLuongToiDa);
		data.setTrangThai(trangThai);

		boolean ok = (id == null) ? couponDAO.create(data) : couponDAO.update(data);
		String qs = ok ? "msg=saved" : "msg=error";

		if (id == null) {
			resp.sendRedirect(req.getContextPath() + "/admin/coupons?" + qs);
		} else {
			resp.sendRedirect(req.getContextPath() + "/admin/coupons/edit?id=" + id + "&" + qs);
		}
	}

	/* ------------ helpers ------------ */

	private Integer tryParseInt(String s) {
		try {
			return (s == null || s.isBlank()) ? null : Integer.valueOf(s.trim());
		} catch (Exception e) {
			return null;
		}
	}

	private BigDecimal parseMoney(String s) {
		try {
			return (s == null || s.isBlank()) ? BigDecimal.ZERO : new BigDecimal(s.trim());
		} catch (Exception e) {
			return BigDecimal.ZERO;
		}
	}

	private String nvl(String s) {
		return s == null ? "" : s.trim();
	}

	private LocalDateTime parseDateStart(String s) {
		if (s == null || s.isBlank())
			return null;
		LocalDate d = LocalDate.parse(s.trim()); // yyyy-MM-dd
		return d.atStartOfDay();
	}

	private LocalDateTime parseDateEnd(String s) {
		if (s == null || s.isBlank())
			return null;
		LocalDate d = LocalDate.parse(s.trim());
		return d.atTime(LocalTime.of(23, 59, 59));
	}

	private MaGiamGia.LoaiGiam toLoaiGiam(String s) {
		if (s == null)
			return LoaiGiam.PERCENT;
		switch (s.trim().toLowerCase()) {
		case "amount":
		case "fixed_amount":
			return LoaiGiam.FIXED_AMOUNT;
		case "percent":
		default:
			return LoaiGiam.PERCENT;
		}
	}

	private BigDecimal nullIfZero(BigDecimal v) {
		if (v == null)
			return null;
		return (v.signum() == 0) ? null : v;
	}
}
