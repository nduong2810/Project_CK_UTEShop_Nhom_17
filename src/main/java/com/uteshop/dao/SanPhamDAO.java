package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SanPhamDAO {

	private final DanhMucDAO danhMucDAO = new DanhMucDAO();
	private final CuaHangDAO cuaHangDAO = new CuaHangDAO();

	public List<SanPham> findTopNProducts(int limit) {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT TOP (?) * FROM SanPham WHERE TrangThai = 1 ORDER BY SoLuongBan DESC, MaSP ASC";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SanPham sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));
					sp.setSoLuongBan(rs.getInt("SoLuongBan"));
					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setSoLuongTon(rs.getInt("SoLuongTon"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));
					sp.setLuotXem(rs.getInt("LuotXem"));
					sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
					sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
					sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
					sp.setMaDM(rs.getInt("MaDM"));
					sp.setMaCH(rs.getInt("MaCH"));

					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
					}
					list.add(sp);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<SanPham> findTopNProductsByCategoryId(int limit, Integer categoryId) {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT TOP (?) * FROM SanPham WHERE TrangThai = 1 AND MaDM = ? ORDER BY SoLuongBan DESC, MaSP ASC";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);
			ps.setInt(2, categoryId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SanPham sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));
					sp.setSoLuongBan(rs.getInt("SoLuongBan"));
					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setSoLuongTon(rs.getInt("SoLuongTon"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));
					sp.setLuotXem(rs.getInt("LuotXem"));
					sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
					sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
					sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
					sp.setMaDM(rs.getInt("MaDM"));
					sp.setMaCH(rs.getInt("MaCH"));

					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
					}
					list.add(sp);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<SanPham> findAll(int offset, int limit, String sortBy, String priceRange, Integer categoryId) {
		List<SanPham> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder("SELECT * FROM SanPham WHERE TrangThai = 1 ");
		List<Object> params = new ArrayList<>();

		if (categoryId != null) {
			sql.append("AND MaDM = ? ");
			params.add(categoryId);
		}

		if ("bestseller".equals(sortBy)) {
			sql.append("AND SoLuongBan > 10 ");
		}

		if (priceRange != null && !priceRange.isEmpty()) {
			if (priceRange.endsWith("-")) {
				String minPrice = priceRange.substring(0, priceRange.length() - 1);
				sql.append("AND DonGia >= ? ");
				params.add(new BigDecimal(minPrice));
			} else {
				String[] prices = priceRange.split("-");
				if (prices.length == 2) {
					sql.append("AND DonGia BETWEEN ? AND ? ");
					params.add(new BigDecimal(prices[0]));
					params.add(new BigDecimal(prices[1]));
				}
			}
		}

		String orderByClause;
		if (sortBy != null) {
			switch (sortBy) {
			case "price-asc":
				orderByClause = "ORDER BY DonGia ASC, MaSP ASC";
				break;
			case "price-desc":
				orderByClause = "ORDER BY DonGia DESC, MaSP ASC";
				break;
			case "newest":
				orderByClause = "ORDER BY NgayTao DESC, MaSP ASC";
				break;
			case "all":
				orderByClause = "ORDER BY MaSP ASC";
				break;
			case "bestseller":
			default:
				orderByClause = "ORDER BY SoLuongBan DESC, MaSP ASC";
				break;
			}
		} else {
			orderByClause = "ORDER BY SoLuongBan DESC, MaSP ASC";
		}

		sql.append(orderByClause).append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
		params.add(offset);
		params.add(limit);

		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SanPham sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));
					sp.setSoLuongBan(rs.getInt("SoLuongBan"));
					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));
					sp.setLuotXem(rs.getInt("LuotXem"));
					sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
					sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
					sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
					sp.setMaDM(rs.getInt("MaDM"));
					sp.setMaCH(rs.getInt("MaCH"));

					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
					}
					list.add(sp);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public long countProducts(String sortBy, String priceRange, Integer categoryId) {
		StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM SanPham WHERE TrangThai = 1 ");
		List<Object> params = new ArrayList<>();

		if (categoryId != null) {
			sql.append("AND MaDM = ? ");
			params.add(categoryId);
		}

		if ("bestseller".equals(sortBy)) {
			sql.append("AND SoLuongBan > 10 ");
		}

		if (priceRange != null && !priceRange.isEmpty()) {
			if (priceRange.endsWith("-")) {
				String minPrice = priceRange.substring(0, priceRange.length() - 1);
				sql.append("AND DonGia >= ? ");
				params.add(new BigDecimal(minPrice));
			} else {
				String[] prices = priceRange.split("-");
				if (prices.length == 2) {
					sql.append("AND DonGia BETWEEN ? AND ? ");
					params.add(new BigDecimal(prices[0]));
					params.add(new BigDecimal(prices[1]));
				}
			}
		}

		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return rs.getLong(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public SanPham findById(Integer id) {
		String sql = "SELECT * FROM SanPham WHERE MaSP = ?";
		SanPham sp = null;

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));
					sp.setSoLuongBan(rs.getInt("SoLuongBan"));
					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setSoLuongTon(rs.getInt("SoLuongTon"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));
					sp.setLuotXem(rs.getInt("LuotXem"));
					sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
					sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
					sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
					sp.setMaDM(rs.getInt("MaDM"));
					sp.setMaCH(rs.getInt("MaCH"));

					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sp;
	}

	public List<SanPham> findByCategoryId(Integer categoryId) {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT * FROM SanPham WHERE MaDM = ? AND TrangThai = 1 ORDER BY SoLuongBan DESC";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, categoryId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SanPham sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));
					sp.setSoLuongBan(rs.getInt("SoLuongBan"));
					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setMaDM(rs.getInt("MaDM"));
					sp.setMaCH(rs.getInt("MaCH"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));

					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<SanPham> findByStoreId(int storeId) {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT * FROM SanPham WHERE MaCH = ? AND TrangThai = 1 ORDER BY SoLuongBan DESC";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, storeId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SanPham sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));
					sp.setSoLuongBan(rs.getInt("SoLuongBan"));
					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setMaDM(rs.getInt("MaDM"));
					sp.setMaCH(rs.getInt("MaCH"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));

					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<SanPham> findByStore(Integer storeId, int limit) {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT TOP (?) * FROM SanPham WHERE MaCH = ? AND TrangThai = 1 ORDER BY SoLuongBan DESC";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, limit);
			ps.setInt(2, storeId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SanPham sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));
					sp.setSoLuongBan(rs.getInt("SoLuongBan"));
					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setMaDM(rs.getInt("MaDM"));
					sp.setMaCH(rs.getInt("MaCH"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));

					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<SanPham> getAllProducts() {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT * FROM SanPham WHERE TrangThai = 1 ORDER BY SoLuongBan DESC";

		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				SanPham sp = new SanPham();
				sp.setMaSP(rs.getInt("MaSP"));
				sp.setTenSP(rs.getNString("TenSP"));
				sp.setDonGia(rs.getBigDecimal("DonGia"));
				sp.setSoLuongTon(rs.getInt("SoLuongTon"));
				sp.setHinhAnh(rs.getNString("HinhAnh"));
				sp.setMoTa(rs.getNString("MoTa"));
				sp.setMaDM(rs.getInt("MaDM"));
				sp.setMaCH(rs.getInt("MaCH"));
				sp.setTrangThai(rs.getBoolean("TrangThai"));

				if (sp.getMaDM() != null && sp.getMaDM() > 0) {
					DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
					sp.setDanhMuc(dm);
				}
				if (sp.getMaCH() != null && sp.getMaCH() > 0) {
					CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
					sp.setCuaHang(ch);
				}
				list.add(sp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public void updateSanPhamTextFields(SanPham sp) {
		String sql = "UPDATE SanPham SET TenSP = ?, MoTa = ?, HinhAnh = ? WHERE MaSP = ?";
		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setNString(1, sp.getTenSP());
			ps.setNString(2, sp.getMoTa());
			ps.setNString(3, sp.getHinhAnh());
			ps.setInt(4, sp.getMaSP());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<DanhMuc> listCategories() {
		List<DanhMuc> list = new ArrayList<>();
		// Chỉ select cột chắc chắn tồn tại để tránh lỗi schema
		String sql = "SELECT MaDM, TenDM FROM DanhMuc ORDER BY TenDM ASC";

		try (Connection con = DBConnect.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				DanhMuc dm = new DanhMuc();
				dm.setMaDM(rs.getInt("MaDM"));
				dm.setTenDM(rs.getString("TenDM"));
				// Các field còn lại (MoTa, HinhAnh, TrangThai, NgayTao/NgayCapNhat)
				// sẽ giữ default theo constructor của entity.
				list.add(dm);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // hoặc log
		}
		return list;
	}

	public int countAll(String q, Integer catId) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) FROM SanPham WHERE 1=1 ");
		if (q != null && !q.isBlank()) {
			sql.append(" AND (LOWER(TenSP) LIKE ? OR CAST(MaSP AS NVARCHAR(50)) LIKE ?) ");
		}
		if (catId != null) {
			sql.append(" AND MaDM = ? ");
		}

		try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql.toString())) {

			int idx = 1;
			if (q != null && !q.isBlank()) {
				String kw = "%" + q.toLowerCase() + "%";
				ps.setString(idx++, kw);
				ps.setString(idx++, kw);
			}
			if (catId != null) {
				ps.setInt(idx++, catId);
			}

			try (ResultSet rs = ps.executeQuery()) {
				return rs.next() ? rs.getInt(1) : 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	public int countActive() {
		String sql = "SELECT COUNT(*) FROM SanPham WHERE TrangThai = 1";
		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			rs.next();
			return rs.getInt(1);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	private SanPham mapRow(ResultSet rs) throws SQLException {
		SanPham sp = new SanPham();
		sp.setMaSP(rs.getInt("MaSP"));
		sp.setMaCH(rs.getInt("MaCH")); // nếu entity SanPham của bạn có trường này
		sp.setMaDM(rs.getInt("MaDM")); // nếu bạn đang dùng ID thay vì @ManyToOne
		sp.setTenSP(rs.getString("TenSP"));
		sp.setDonGia(rs.getBigDecimal("DonGia"));
		sp.setSoLuongTon(rs.getInt("SoLuongTon"));
		sp.setSoLuongBan(rs.getInt("SoLuongBan"));
		sp.setHinhAnh(rs.getString("HinhAnh"));
		sp.setMoTa(rs.getString("MoTa"));
		sp.setTrangThai(rs.getBoolean("TrangThai"));
		sp.setNgayTao(rs.getTimestamp("NgayTao"));
		return sp;
	}

	private String safeSort(String sort) {
		if (sort == null)
			return "";
		return switch (sort) {
		case "price_asc", "price_desc", "sold_desc", "newest" -> sort;
		default -> "";
		};
	}

	public List<SanPham> findPaged(int page, int pageSize, String q, Integer catId, String sort) {
		List<SanPham> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("""
				SELECT MaSP, MaCH, MaDM, TenSP, DonGia, SoLuongTon, SoLuongBan, HinhAnh, MoTa, TrangThai, NgayTao
				FROM SanPham
				WHERE 1=1
				""");

		// filter
		if (q != null && !q.isBlank()) {
			sql.append(" AND (LOWER(TenSP) LIKE ? OR CAST(MaSP AS NVARCHAR(50)) LIKE ?) ");
		}
		if (catId != null) {
			sql.append(" AND MaDM = ? ");
		}

		// sort an toàn (whitelist cột)
		sql.append(" ORDER BY ");
		switch (safeSort(sort)) {
		case "price_asc" -> sql.append(" DonGia ASC ");
		case "price_desc" -> sql.append(" DonGia DESC ");
		case "sold_desc" -> sql.append(" SoLuongBan DESC ");
		case "newest" -> sql.append(" NgayTao DESC ");
		default -> sql.append(" MaSP DESC ");
		}

		// SQL Server: phân trang bằng OFFSET/FETCH
		sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");

		try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql.toString())) {

			int idx = 1;
			if (q != null && !q.isBlank()) {
				String kw = "%" + q.toLowerCase() + "%";
				ps.setString(idx++, kw);
				ps.setString(idx++, kw);
			}
			if (catId != null) {
				ps.setInt(idx++, catId);
			}

			int offset = Math.max(0, (page - 1)) * pageSize;
			ps.setInt(idx++, offset);
			ps.setInt(idx++, pageSize);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapRow(rs));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace(); // hoặc log
		}
		return list;
	}

	public boolean update(SanPham sp) {
		String sql = "UPDATE SanPham SET MaDM=?, TenSP=?, DonGia=?, SoLuongTon=?, HinhAnh=?, MoTa=?, TrangThai=? "
				+ "WHERE MaSP=?";
		try (Connection con = DBConnect.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			int i = 1;
			ps.setInt(i++, sp.getMaDM());
			ps.setString(i++, sp.getTenSP());
			ps.setBigDecimal(i++, sp.getDonGia());
			ps.setInt(i++, sp.getSoLuongTon());
			ps.setString(i++, sp.getHinhAnh());
			ps.setString(i++, sp.getMoTa());
			ps.setBoolean(i++, sp.getTrangThai());
			ps.setInt(i++, sp.getMaSP());

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public String findCategoryNameById(Integer maDM) {
		if (maDM == null)
			return null;
		String sql = "SELECT TenDM FROM DanhMuc WHERE MaDM = ?";
		try (var con = DBConnect.getConnection(); var ps = con.prepareStatement(sql)) {
			ps.setInt(1, maDM);
			try (var rs = ps.executeQuery()) {
				if (rs.next())
					return rs.getString("TenDM");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
