package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.CuaHang;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CuaHangDAO {
    
    // Lấy tất cả cửa hàng hoạt động
    public List<CuaHang> findAll() {
        List<CuaHang> list = new ArrayList<>();
        String sql = "SELECT ch.*, nd.HoTen as TenChuCuaHang, " +
                "COUNT(sp.MaSP) as SoLuongSanPham, " +
                "AVG(CAST(sp.DiemDanhGiaTrungBinh as DECIMAL(3,2))) as DiemTrungBinh " +
                "FROM CuaHang ch " +
                "LEFT JOIN NguoiDung nd ON ch.MaND = nd.MaND " +
                "LEFT JOIN SanPham sp ON ch.MaCH = sp.MaCH AND sp.TrangThai = 1 " +
                "WHERE ch.TrangThai = 1 " +
                "GROUP BY ch.MaCH, ch.TenCH, ch.MoTa, ch.DiaChi, ch.SoDienThoai, " +
                "ch.Email, ch.MaND, ch.TrangThai, ch.NgayTao, ch.NgayCapNhat, nd.HoTen " +
                "ORDER BY ch.NgayTao DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CuaHang ch = new CuaHang();
                ch.setMaCH(rs.getInt("MaCH"));
                ch.setTenCH(rs.getString("TenCH"));
                ch.setMoTa(rs.getString("MoTa"));
                ch.setDiaChi(rs.getString("DiaChi"));
                ch.setSoDienThoai(rs.getString("SoDienThoai"));
                ch.setEmail(rs.getString("Email"));
                ch.setMaND(rs.getInt("MaND"));
                ch.setTrangThai(rs.getBoolean("TrangThai"));
                
                // Xử lý ngày tạo
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    ch.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                // Xử lý ngày cập nhật
                Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                if (ngayCapNhat != null) {
                    ch.setNgayCapNhat(ngayCapNhat.toLocalDateTime());
                }
                
                System.out.println("Found store: " + ch.getTenCH() + " with " + rs.getInt("SoLuongSanPham") + " products");
                list.add(ch);
            }

        } catch (Exception e) {
            System.err.println("Error in CuaHangDAO.findAll: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
    
    // Lấy cửa hàng theo ID
    public CuaHang findById(Integer id) {
        String sql = "SELECT ch.*, nd.HoTen as TenChuCuaHang " +
                "FROM CuaHang ch " +
                "LEFT JOIN NguoiDung nd ON ch.MaND = nd.MaND " +
                "WHERE ch.MaCH = ? AND ch.TrangThai = 1";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CuaHang ch = new CuaHang();
                    ch.setMaCH(rs.getInt("MaCH"));
                    ch.setTenCH(rs.getString("TenCH"));
                    ch.setMoTa(rs.getString("MoTa"));
                    ch.setDiaChi(rs.getString("DiaChi"));
                    ch.setSoDienThoai(rs.getString("SoDienThoai"));
                    ch.setEmail(rs.getString("Email"));
                    ch.setMaND(rs.getInt("MaND"));
                    ch.setTrangThai(rs.getBoolean("TrangThai"));
                    
                    // Xử lý ngày tạo
                    Timestamp ngayTao = rs.getTimestamp("NgayTao");
                    if (ngayTao != null) {
                        ch.setNgayTao(ngayTao.toLocalDateTime());
                    }
                    
                    return ch;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in CuaHangDAO.findById: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Lấy cửa hàng nổi bật (có nhiều sản phẩm bán chạy)
    public List<CuaHang> getFeaturedStores(int limit) {
        List<CuaHang> list = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " ch.*, nd.HoTen as TenChuCuaHang, " +
                "COUNT(sp.MaSP) as SoLuongSanPham, " +
                "SUM(sp.SoLuongBan) as TongSanPhamBan " +
                "FROM CuaHang ch " +
                "LEFT JOIN NguoiDung nd ON ch.MaND = nd.MaND " +
                "LEFT JOIN SanPham sp ON ch.MaCH = sp.MaCH AND sp.TrangThai = 1 " +
                "WHERE ch.TrangThai = 1 " +
                "GROUP BY ch.MaCH, ch.TenCH, ch.MoTa, ch.DiaChi, ch.SoDienThoai, " +
                "ch.Email, ch.MaND, ch.TrangThai, ch.NgayTao, ch.NgayCapNhat, nd.HoTen " +
                "ORDER BY TongSanPhamBan DESC, SoLuongSanPham DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CuaHang ch = new CuaHang();
                ch.setMaCH(rs.getInt("MaCH"));
                ch.setTenCH(rs.getString("TenCH"));
                ch.setMoTa(rs.getString("MoTa"));
                ch.setDiaChi(rs.getString("DiaChi"));
                ch.setSoDienThoai(rs.getString("SoDienThoai"));
                ch.setEmail(rs.getString("Email"));
                ch.setMaND(rs.getInt("MaND"));
                ch.setTrangThai(rs.getBoolean("TrangThai"));
                
                // Xử lý ngày tạo
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    ch.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                System.out.println("Featured store: " + ch.getTenCH() + " sold " + rs.getInt("TongSanPhamBan") + " products");
                list.add(ch);
            }

        } catch (Exception e) {
            System.err.println("Error in CuaHangDAO.getFeaturedStores: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
    
    // Đếm tổng số cửa hàng
    public long countStores() {
        String sql = "SELECT COUNT(*) FROM CuaHang WHERE TrangThai = 1";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }

        } catch (Exception e) {
            System.err.println("Error in countStores: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }
    
    // Lấy cửa hàng với pagination
    public List<CuaHang> findWithPagination(int offset, int limit) {
        List<CuaHang> list = new ArrayList<>();
        String sql = "SELECT ch.*, nd.HoTen as TenChuCuaHang " +
                "FROM CuaHang ch " +
                "LEFT JOIN NguoiDung nd ON ch.MaND = nd.MaND " +
                "WHERE ch.TrangThai = 1 " +
                "ORDER BY ch.NgayTao DESC " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, offset);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CuaHang ch = new CuaHang();
                    ch.setMaCH(rs.getInt("MaCH"));
                    ch.setTenCH(rs.getString("TenCH"));
                    ch.setMoTa(rs.getString("MoTa"));
                    ch.setDiaChi(rs.getString("DiaChi"));
                    ch.setSoDienThoai(rs.getString("SoDienThoai"));
                    ch.setEmail(rs.getString("Email"));
                    ch.setMaND(rs.getInt("MaND"));
                    ch.setTrangThai(rs.getBoolean("TrangThai"));
                    
                    // Xử lý ngày tạo
                    Timestamp ngayTao = rs.getTimestamp("NgayTao");
                    if (ngayTao != null) {
                        ch.setNgayTao(ngayTao.toLocalDateTime());
                    }
                    
                    list.add(ch);
                }
            }

        } catch (Exception e) {
            System.err.println("Error in CuaHangDAO.findWithPagination: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}