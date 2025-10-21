package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;

import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

public class SanPhamDAO {

	private final DanhMucDAO danhMucDAO = new DanhMucDAO();
	private final CuaHangDAO cuaHangDAO = new CuaHangDAO();

	// Lấy N sản phẩm bán chạy nhất (thay thế getTop10SanPhamBanChay)
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
					sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
					sp.setMaCH(rs.getInt("MaCH"));

					// Load related DanhMuc and CuaHang
					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
						// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
						// " + (dm != null ? dm.getTenDM() : "NULL"));
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
						// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
						// " + (ch != null ? ch.getTenCH() : "NULL"));
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// Lấy sản phẩm với pagination và sắp xếp động
	public List<SanPham> findAll(int offset, int limit, String sortBy) {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT * FROM SanPham WHERE TrangThai = 1 ";
		String orderByClause = "ORDER BY SoLuongBan DESC, MaSP ASC"; // Default: Bán chạy nhất

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
			case "bestseller":
			default:
				orderByClause = "ORDER BY SoLuongBan DESC, MaSP ASC";
				break;
			}
		}

		sql += orderByClause + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

		System.out.println("DEBUG SanPhamDAO.findAll - SQL: " + sql); // ADDED LOG
		System.out.println("DEBUG SanPhamDAO.findAll - Offset: " + offset + ", Limit: " + limit); // ADDED LOG

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, offset);
			ps.setInt(2, limit);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					SanPham sp = new SanPham();
					sp.setMaSP(rs.getInt("MaSP"));
					sp.setTenSP(rs.getNString("TenSP"));
					sp.setDonGia(rs.getBigDecimal("DonGia"));

					int soLuongBanFromDb = rs.getInt("SoLuongBan"); // Read SoLuongBan directly from ResultSet
					sp.setSoLuongBan(soLuongBanFromDb);
					System.out.println("DEBUG SanPhamDAO: Read MaSP " + sp.getMaSP() + ", SoLuongBan from DB: "
							+ soLuongBanFromDb); // ADDED LOG

					sp.setHinhAnh(rs.getNString("HinhAnh"));
					sp.setMoTa(rs.getNString("MoTa"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));
					sp.setLuotXem(rs.getInt("LuotXem"));
					sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
					sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
					sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
					sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
					sp.setMaCH(rs.getInt("MaCH"));

					// Load related DanhMuc and CuaHang
					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
						// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
						// " + (dm != null ? dm.getTenDM() : "NULL"));
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
						// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
						// " + (ch != null ? ch.getTenCH() : "NULL"));
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// Overload for backward compatibility if needed, though not strictly necessary
	// if all calls are updated
	public List<SanPham> findAll(int offset, int limit) {
		return findAll(offset, limit, null); // Default to bestseller
	}

	// Đếm tổng số sản phẩm
	public long countProducts() {
		String sql = "SELECT COUNT(*) FROM SanPham WHERE TrangThai = 1";

		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				return rs.getLong(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	// Tìm sản phẩm theo ID
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
					sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
					sp.setMaCH(rs.getInt("MaCH"));

					// System.out.println("SanPhamDAO: Found product with MaSP " + sp.getMaSP() + ",
					// MaDM: " + sp.getMaDM() + ", MaCH: " + sp.getMaCH());
					// Load related DanhMuc and CuaHang
					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
						// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
						// " + (dm != null ? dm.getTenDM() : "NULL"));
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
						// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
						// " + (ch != null ? ch.getTenCH() : "NULL"));
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return sp;
	}

	// Thêm sản phẩm mới
	public boolean save(SanPham sanPham) {
		String sql = "INSERT INTO SanPham (TenSP, MoTa, DonGia, SoLuongTon, SoLuongBan, HinhAnh, "
				+ "TrangThai, NgayTao, NgayCapNhat, LuotXem, LuotYeuThich, DiemDanhGiaTrungBinh, "
				+ "SoLuongDanhGia, MaDM, MaCH) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			ps.setNString(1, sanPham.getTenSP());
			ps.setNString(2, sanPham.getMoTa());
			ps.setBigDecimal(3, sanPham.getDonGia());
			ps.setInt(4, sanPham.getSoLuongTon());
			ps.setInt(5, sanPham.getSoLuongBan() != null ? sanPham.getSoLuongBan() : 0);
			ps.setNString(6, sanPham.getHinhAnh());
			ps.setBoolean(7, sanPham.getTrangThai() != null ? sanPham.getTrangThai() : true);
			ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
			ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
			ps.setInt(10, sanPham.getLuotXem() != null ? sanPham.getLuotXem() : 0);
			ps.setInt(11, sanPham.getLuotYeuThich() != null ? sanPham.getLuotYeuThich() : 0);
			ps.setBigDecimal(12,
					sanPham.getDiemDanhGiaTrungBinh() != null ? sanPham.getDiemDanhGiaTrungBinh() : BigDecimal.ZERO);
			ps.setInt(13, sanPham.getSoLuongDanhGia() != null ? sanPham.getSoLuongDanhGia() : 0);
			ps.setObject(14, sanPham.getMaDM());
			ps.setInt(15, sanPham.getMaCH());

			int result = ps.executeUpdate();

			if (result > 0) {
				try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						sanPham.setMaSP(generatedKeys.getInt(1));
					}
				}
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// Cập nhật sản phẩm
	public boolean update(SanPham sanPham) {
		String sql = "UPDATE SanPham SET TenSP = ?, MoTa = ?, DonGia = ?, SoLuongTon = ?, "
				+ "SoLuongBan = ?, HinhAnh = ?, TrangThai = ?, NgayCapNhat = ?, LuotXem = ?, "
				+ "LuotYeuThich = ?, DiemDanhGiaTrungBinh = ?, SoLuongDanhGia = ?, MaDM = ? " + "WHERE MaSP = ?";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setNString(1, sanPham.getTenSP());
			ps.setNString(2, sanPham.getMoTa());
			ps.setBigDecimal(3, sanPham.getDonGia());
			ps.setInt(4, sanPham.getSoLuongTon());
			ps.setInt(5, sanPham.getSoLuongBan() != null ? sanPham.getSoLuongBan() : 0);
			ps.setNString(6, sanPham.getHinhAnh());
			ps.setBoolean(7, sanPham.getTrangThai() != null ? sanPham.getTrangThai() : true);
			ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
			ps.setInt(9, sanPham.getLuotXem() != null ? sanPham.getLuotXem() : 0);
			ps.setInt(10, sanPham.getLuotYeuThich() != null ? sanPham.getLuotYeuThich() : 0);
			ps.setBigDecimal(11,
					sanPham.getDiemDanhGiaTrungBinh() != null ? sanPham.getDiemDanhGiaTrungBinh() : BigDecimal.ZERO);
			ps.setInt(12, sanPham.getSoLuongDanhGia() != null ? sanPham.getSoLuongDanhGia() : 0);
			ps.setObject(13, sanPham.getMaDM());
			ps.setInt(14, sanPham.getMaSP());

			int result = ps.executeUpdate();

			if (result > 0) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// Xóa sản phẩm (soft delete)
	public boolean delete(int maSP) {
		String sql = "UPDATE SanPham SET TrangThai = ?, NgayCapNhat = ? WHERE MaSP = ?";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setBoolean(1, false);
			ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
			ps.setInt(3, maSP);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// Lấy sản phẩm theo danh mục
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
					sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
					sp.setMaCH(rs.getInt("MaCH"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));

					// System.out.println("SanPhamDAO: Found product in category with MaSP " +
					// sp.getMaSP() + ", MaDM: " + sp.getMaDM() + ", MaCH: " + sp.getMaCH());
					// Load related DanhMuc and CuaHang
					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
						// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
						// " + (dm != null ? dm.getTenDM() : "NULL"));
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
						// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
						// " + (ch != null ? ch.getTenCH() : "NULL"));
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// Lấy tất cả sản phẩm sắp xếp theo số lượng bán (cho chức năng Xem thêm)
	// Phương thức này có thể được thay thế bằng findAll(offset, limit)
	public List<SanPham> getAllProductsSorted() {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT * FROM SanPham WHERE TrangThai = 1 ORDER BY SoLuongBan DESC, MaSP ASC";

		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

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
				sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
				sp.setMaCH(rs.getInt("MaCH"));

				// System.out.println("SanPhamDAO: Found sorted product with MaSP " +
				// sp.getMaSP() + ", MaDM: " + sp.getMaDM() + ", MaCH: " + sp.getMaCH());
				// Load related DanhMuc and CuaHang
				if (sp.getMaDM() != null && sp.getMaDM() > 0) {
					DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
					sp.setDanhMuc(dm);
					// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
					// " + (dm != null ? dm.getTenDM() : "NULL"));
				}
				if (sp.getMaCH() != null && sp.getMaCH() > 0) {
					CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
					sp.setCuaHang(ch);
					// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
					// " + (ch != null ? ch.getTenCH() : "NULL"));
				}
				list.add(sp);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// Lấy tất cả sản phẩm
	// Phương thức này có thể được thay thế bằng findAll(offset, limit)
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
				sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
				sp.setMaCH(rs.getInt("MaCH"));
				sp.setTrangThai(rs.getBoolean("TrangThai"));

				// System.out.println("SanPhamDAO: Found all product with MaSP " + sp.getMaSP()
				// + ", MaDM: " + sp.getMaDM() + ", MaCH: " + sp.getMaCH());
				// Load related DanhMuc and CuaHang
				if (sp.getMaDM() != null && sp.getMaDM() > 0) {
					DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
					sp.setDanhMuc(dm);
					// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
					// " + (dm != null ? dm.getTenDM() : "NULL"));
				}
				if (sp.getMaCH() != null && sp.getMaCH() > 0) {
					CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
					sp.setCuaHang(ch);
					// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
					// " + (ch != null ? ch.getTenCH() : "NULL"));
				}
				list.add(sp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Lấy sản phẩm của một cửa hàng
	public List<SanPham> findByStoreId(Integer storeId) {
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
					sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
					sp.setMaCH(rs.getInt("MaCH"));
					sp.setTrangThai(rs.getBoolean("TrangThai"));

					// System.out.println("SanPhamDAO: Found product by store ID with MaSP " +
					// sp.getMaSP() + ", MaDM: " + sp.getMaDM() + ", MaCH: " + sp.getMaCH());
					// Load related DanhMuc and CuaHang
					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
						// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
						// " + (dm != null ? dm.getTenDM() : "NULL"));
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
						// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
						// " + (ch != null ? ch.getTenCH() : "NULL"));
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// Tìm kiếm sản phẩm theo tên
	public List<SanPham> searchByName(String keyword) {
		List<SanPham> list = new ArrayList<>();
		String sql = "SELECT * FROM SanPham WHERE TenSP LIKE ? AND TrangThai = 1 ORDER BY SoLuongBan DESC";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, "%" + keyword + "%");

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
					sp.setMaDM(rs.getInt("MaDM")); // Read MaDM
					sp.setMaCH(rs.getInt("MaCH"));

					// System.out.println("SanPhamDAO: Found search product with MaSP " +
					// sp.getMaSP() + ", MaDM: " + sp.getMaDM() + ", MaCH: " + sp.getMaCH());
					// Load related DanhMuc and CuaHang
					if (sp.getMaDM() != null && sp.getMaDM() > 0) {
						DanhMuc dm = danhMucDAO.findById(sp.getMaDM());
						sp.setDanhMuc(dm);
						// System.out.println("SanPhamDAO: Loaded DanhMuc for MaDM " + sp.getMaDM() + ":
						// " + (dm != null ? dm.getTenDM() : "NULL"));
					}
					if (sp.getMaCH() != null && sp.getMaCH() > 0) {
						CuaHang ch = cuaHangDAO.findById(sp.getMaCH());
						sp.setCuaHang(ch);
						// System.out.println("SanPhamDAO: Loaded CuaHang for MaCH " + sp.getMaCH() + ":
						// " + (ch != null ? ch.getTenCH() : "NULL"));
					}
					list.add(sp);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public int countActive() {
		String sql = "SELECT COUNT(*) FROM SanPham WHERE TrangThai = 1";
		try (Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			rs.next();
			return rs.getInt(1);
		} catch (SQLException e) {
			// TODO: handle exception
			throw new RuntimeException(e);
		}
	}

	// Cập nhật các trường text cho sản phẩm
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

}