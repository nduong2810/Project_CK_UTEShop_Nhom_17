package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.SanPham;

import java.sql.*;
import java.util.*;

public class SanPhamDAO {

    // Lấy top 10 sản phẩm bán chạy nhất
    public List<SanPham> getTop10SanPhamBanChay() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT TOP 10 sp.MaSP, sp.TenSP, sp.DonGia, sp.SoLuongBan, sp.HinhAnh, sp.MoTa, " +
                "sp.SoLuongTon, sp.TrangThai, sp.LuotXem, sp.LuotYeuThich, sp.DiemDanhGiaTrungBinh, " +
                "sp.SoLuongDanhGia, sp.MaCH, ch.TenCH " +
                "FROM SanPham sp " +
                "LEFT JOIN CuaHang ch ON sp.MaCH = ch.MaCH " +
                "WHERE sp.TrangThai = 1 " +
                "ORDER BY sp.SoLuongBan DESC, sp.MaSP ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("Executing query: " + sql);
            int count = 0;
            while (rs.next()) {
                SanPham sp = new SanPham();
                sp.setMaSP(rs.getInt("MaSP"));
                sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED: Dùng getNString thay vì getString
                sp.setDonGia(rs.getBigDecimal("DonGia"));
                sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                sp.setTrangThai(rs.getBoolean("TrangThai"));
                sp.setLuotXem(rs.getInt("LuotXem"));
                sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
                sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
                sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
                sp.setMaCH(rs.getInt("MaCH"));
                list.add(sp);
                count++;
                System.out.println("Top 10 Product #" + count + ": " + sp.getTenSP() + " (ID: " + sp.getMaSP() + ") - Sales: " + sp.getSoLuongBan());
            }
            System.out.println("Total top 10 products found: " + count);

        } catch (Exception e) {
            System.err.println("Error in getTop10SanPhamBanChay: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    // Lấy sản phẩm với pagination (cho load more)
    public List<SanPham> findAllWithPagination(int offset, int limit) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.DonGia, sp.SoLuongBan, sp.HinhAnh, sp.MoTa, " +
                "sp.SoLuongTon, sp.TrangThai, sp.LuotXem, sp.LuotYeuThich, sp.DiemDanhGiaTrungBinh, " +
                "sp.SoLuongDanhGia, sp.MaCH, sp.MaDM, sp.NgayTao, sp.NgayCapNhat, " +
                "ch.TenCH, ch.DiaChi as DiaChiCuaHang, ch.SoDienThoai as SdtCuaHang, " +
                "dm.TenDM " +
                "FROM SanPham sp " +
                "LEFT JOIN CuaHang ch ON sp.MaCH = ch.MaCH " +
                "LEFT JOIN DanhMuc dm ON sp.MaDM = dm.MaDM " +
                "WHERE sp.TrangThai = 1 " +
                "ORDER BY sp.SoLuongBan DESC, sp.MaSP ASC " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, offset);
            ps.setInt(2, limit);
            
            System.out.println("Executing pagination query: offset=" + offset + ", limit=" + limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    SanPham sp = new SanPham();
                    sp.setMaSP(rs.getInt("MaSP"));
                    sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED
                    sp.setDonGia(rs.getBigDecimal("DonGia"));
                    sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                    sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                    sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                    sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                    sp.setTrangThai(rs.getBoolean("TrangThai"));
                    sp.setLuotXem(rs.getInt("LuotXem"));
                    sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
                    sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
                    sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
                    sp.setMaCH(rs.getInt("MaCH"));
                    sp.setMaDM(rs.getInt("MaDM"));
                    sp.setNgayTao(rs.getDate("NgayTao"));
                    sp.setNgayCapNhat(rs.getDate("NgayCapNhat"));
                    
                    count++;
                    System.out.println("LoadMore Product #" + count + ": " + sp.getTenSP() + " (ID: " + sp.getMaSP() + ") - Sales: " + sp.getSoLuongBan());
                    
                    list.add(sp);
                }
                System.out.println("Total products loaded with pagination: " + count);
            }

        } catch (Exception e) {
            System.err.println("Error in findAllWithPagination: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    // Lấy sản phẩm với pagination - overloaded method for AdminController
    public List<SanPham> findAll(int offset, int limit) {
        return findAllWithPagination(offset, limit);
    }

    // Đếm tổng số sản phẩm
    public long countProducts() {
        String sql = "SELECT COUNT(*) FROM SanPham sp " +
                "WHERE sp.TrangThai = 1";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                long count = rs.getLong(1);
                System.out.println("Total products in database: " + count);
                return count;
            }

        } catch (Exception e) {
            System.err.println("Error in countProducts: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    // Tìm sản phẩm theo ID
    public SanPham findById(Integer id) {
        String sql = "SELECT sp.*, ch.TenCH FROM SanPham sp " +
                "LEFT JOIN CuaHang ch ON sp.MaCH = ch.MaCH " +
                "WHERE sp.MaSP = ? AND sp.TrangThai = 1";
        SanPham sp = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    sp = new SanPham();
                    sp.setMaSP(rs.getInt("MaSP"));
                    sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED
                    sp.setDonGia(rs.getBigDecimal("DonGia"));
                    sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                    sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                    sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                    sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                    sp.setTrangThai(rs.getBoolean("TrangThai"));
                    sp.setLuotXem(rs.getInt("LuotXem"));
                    sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
                    sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
                    sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
                    sp.setMaCH(rs.getInt("MaCH"));
                }
            }

        } catch (Exception e) {
            System.err.println("Error in findById: " + e.getMessage());
            e.printStackTrace();
        }

        return sp;
    }

    // Thêm sản phẩm mới
    public boolean save(SanPham sanPham) {
        String sql = "INSERT INTO SanPham (TenSP, MoTa, DonGia, SoLuongTon, SoLuongBan, HinhAnh, " +
                "TrangThai, NgayTao, NgayCapNhat, LuotXem, LuotYeuThich, DiemDanhGiaTrungBinh, " +
                "SoLuongDanhGia, MaDM, MaCH) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setNString(1, sanPham.getTenSP()); // ✅ FIXED: Dùng setNString
            ps.setNString(2, sanPham.getMoTa()); // ✅ FIXED
            ps.setBigDecimal(3, sanPham.getDonGia());
            ps.setInt(4, sanPham.getSoLuongTon());
            ps.setInt(5, sanPham.getSoLuongBan() != null ? sanPham.getSoLuongBan() : 0);
            ps.setNString(6, sanPham.getHinhAnh()); // ✅ FIXED
            ps.setBoolean(7, sanPham.getTrangThai() != null ? sanPham.getTrangThai() : true);
            ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            ps.setInt(10, sanPham.getLuotXem() != null ? sanPham.getLuotXem() : 0);
            ps.setInt(11, sanPham.getLuotYeuThich() != null ? sanPham.getLuotYeuThich() : 0);
            ps.setBigDecimal(12, sanPham.getDiemDanhGiaTrungBinh() != null ? sanPham.getDiemDanhGiaTrungBinh() : java.math.BigDecimal.ZERO);
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
                System.out.println("Product saved successfully: " + sanPham.getTenSP());
                return true;
            }
            
        } catch (Exception e) {
            System.err.println("Error in save: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Cập nhật sản phẩm
    public boolean update(SanPham sanPham) {
        String sql = "UPDATE SanPham SET TenSP = ?, MoTa = ?, DonGia = ?, SoLuongTon = ?, " +
                "SoLuongBan = ?, HinhAnh = ?, TrangThai = ?, NgayCapNhat = ?, LuotXem = ?, " +
                "LuotYeuThich = ?, DiemDanhGiaTrungBinh = ?, SoLuongDanhGia = ?, MaDM = ? " +
                "WHERE MaSP = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setNString(1, sanPham.getTenSP()); // ✅ FIXED
            ps.setNString(2, sanPham.getMoTa()); // ✅ FIXED
            ps.setBigDecimal(3, sanPham.getDonGia());
            ps.setInt(4, sanPham.getSoLuongTon());
            ps.setInt(5, sanPham.getSoLuongBan() != null ? sanPham.getSoLuongBan() : 0);
            ps.setNString(6, sanPham.getHinhAnh()); // ✅ FIXED
            ps.setBoolean(7, sanPham.getTrangThai() != null ? sanPham.getTrangThai() : true);
            ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            ps.setInt(9, sanPham.getLuotXem() != null ? sanPham.getLuotXem() : 0);
            ps.setInt(10, sanPham.getLuotYeuThich() != null ? sanPham.getLuotYeuThich() : 0);
            ps.setBigDecimal(11, sanPham.getDiemDanhGiaTrungBinh() != null ? sanPham.getDiemDanhGiaTrungBinh() : java.math.BigDecimal.ZERO);
            ps.setInt(12, sanPham.getSoLuongDanhGia() != null ? sanPham.getSoLuongDanhGia() : 0);
            ps.setObject(13, sanPham.getMaDM());
            ps.setInt(14, sanPham.getMaSP());
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                System.out.println("Product updated successfully: " + sanPham.getTenSP());
                return true;
            }
            
        } catch (Exception e) {
            System.err.println("Error in update: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Xóa sản phẩm (soft delete)
    public boolean delete(int maSP) {
        String sql = "UPDATE SanPham SET TrangThai = 0, NgayCapNhat = ? WHERE MaSP = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, maSP);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                System.out.println("Product deleted successfully: ID = " + maSP);
                return true;
            }
            
        } catch (Exception e) {
            System.err.println("Error in delete: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    // Lấy sản phẩm theo danh mục
    public List<SanPham> findByCategoryId(Integer categoryId) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.DonGia, sp.SoLuongBan, sp.HinhAnh, sp.MoTa, " +
                "sp.MaCH, ch.TenCH FROM SanPham sp " +
                "LEFT JOIN CuaHang ch ON sp.MaCH = ch.MaCH " +
                "WHERE sp.MaDM = ? AND sp.TrangThai = 1 AND ch.TrangThai = 1 " +
                "ORDER BY sp.SoLuongBan DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham();
                    sp.setMaSP(rs.getInt("MaSP"));
                    sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED
                    sp.setDonGia(rs.getBigDecimal("DonGia"));
                    sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                    sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                    sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                    sp.setMaCH(rs.getInt("MaCH"));
                    list.add(sp);
                }
            }

        } catch (Exception e) {
            System.err.println("Error in findByCategoryId: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    // Lấy tất cả sản phẩm sắp xếp theo số lượng bán (cho chức năng Xem thêm)
    public List<SanPham> getAllProductsSorted() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.DonGia, sp.SoLuongBan, sp.HinhAnh, sp.MoTa, " +
                "sp.SoLuongTon, sp.TrangThai, sp.LuotXem, sp.LuotYeuThich, sp.DiemDanhGiaTrungBinh, " +
                "sp.SoLuongDanhGia, sp.MaCH, ch.TenCH " +
                "FROM SanPham sp " +
                "LEFT JOIN CuaHang ch ON sp.MaCH = ch.MaCH " +
                "WHERE sp.TrangThai = 1 " +
                "ORDER BY sp.SoLuongBan DESC, sp.MaSP ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("Executing getAllProductsSorted query...");
            int count = 0;
            while (rs.next()) {
                SanPham sp = new SanPham();
                sp.setMaSP(rs.getInt("MaSP"));
                sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED
                sp.setDonGia(rs.getBigDecimal("DonGia"));
                sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                sp.setTrangThai(rs.getBoolean("TrangThai"));
                sp.setLuotXem(rs.getInt("LuotXem"));
                sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
                sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
                sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
                sp.setMaCH(rs.getInt("MaCH"));
                list.add(sp);
                count++;
            }
            System.out.println("Total products loaded (sorted): " + count);

        } catch (Exception e) {
            System.err.println("Error in getAllProductsSorted: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    // Lấy tất cả sản phẩm
    public List<SanPham> getAllProducts() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.DonGia, sp.SoLuongBan, sp.HinhAnh, sp.MoTa, " +
                "sp.MaCH, ch.TenCH FROM SanPham sp " +
                "LEFT JOIN CuaHang ch ON sp.MaCH = ch.MaCH " +
                "WHERE sp.TrangThai = 1 AND ch.TrangThai = 1 " +
                "ORDER BY sp.SoLuongBan DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SanPham sp = new SanPham();
                sp.setMaSP(rs.getInt("MaSP"));
                sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED
                sp.setDonGia(rs.getBigDecimal("DonGia"));
                sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                sp.setMaCH(rs.getInt("MaCH"));
                list.add(sp);
            }

        } catch (Exception e) {
            System.err.println("Error in getAllProducts: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
    
    // Lấy sản phẩm của một cửa hàng
    public List<SanPham> findByStoreId(Integer storeId) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM SanPham WHERE MaCH = ? AND TrangThai = 1 ORDER BY SoLuongBan DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, storeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham();
                    sp.setMaSP(rs.getInt("MaSP"));
                    sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED
                    sp.setDonGia(rs.getBigDecimal("DonGia"));
                    sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                    sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                    sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                    sp.setMaCH(rs.getInt("MaCH"));
                    list.add(sp);
                }
            }

        } catch (Exception e) {
            System.err.println("Error in findByStoreId: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
    
    // Tìm kiếm sản phẩm theo tên
    public List<SanPham> searchByName(String keyword) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.*, ch.TenCH FROM SanPham sp " +
                "LEFT JOIN CuaHang ch ON sp.MaCH = ch.MaCH " +
                "WHERE sp.TenSP LIKE ? AND sp.TrangThai = 1 AND ch.TrangThai = 1 " +
                "ORDER BY sp.SoLuongBan DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham();
                    sp.setMaSP(rs.getInt("MaSP"));
                    sp.setTenSP(rs.getNString("TenSP")); // ✅ FIXED
                    sp.setDonGia(rs.getBigDecimal("DonGia"));
                    sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                    sp.setHinhAnh(rs.getNString("HinhAnh")); // ✅ FIXED
                    sp.setMoTa(rs.getNString("MoTa")); // ✅ FIXED
                    sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                    sp.setTrangThai(rs.getBoolean("TrangThai"));
                    sp.setLuotXem(rs.getInt("LuotXem"));
                    sp.setLuotYeuThich(rs.getInt("LuotYeuThich"));
                    sp.setDiemDanhGiaTrungBinh(rs.getBigDecimal("DiemDanhGiaTrungBinh"));
                    sp.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
                    sp.setMaCH(rs.getInt("MaCH"));
                    list.add(sp);
                }
            }
            
        } catch (Exception e) {
            System.err.println("Error in searchByName: " + e.getMessage());
            e.printStackTrace();
        }
        
        return list;
    }

    // Cập nhật các trường text cho sản phẩm
    public void updateSanPhamTextFields(SanPham sp) {
        String sql = "UPDATE SanPham SET TenSP = ?, MoTa = ?, HinhAnh = ? WHERE MaSP = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setNString(1, sp.getTenSP());
            ps.setNString(2, sp.getMoTa());
            ps.setNString(3, sp.getHinhAnh());
            ps.setInt(4, sp.getMaSP());
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error in updateSanPhamTextFields: " + e.getMessage());
        }
    }
}
