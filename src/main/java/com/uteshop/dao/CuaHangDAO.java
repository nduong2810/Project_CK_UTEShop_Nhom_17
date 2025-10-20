package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.CuaHang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CuaHangDAO {

    public CuaHang findById(Integer id) {
        String sql = "SELECT * FROM CuaHang WHERE MaCH = ?";
        CuaHang ch = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ch = new CuaHang();
                    ch.setMaCH(rs.getInt("MaCH"));
                    ch.setTenCH(rs.getNString("TenCH"));
                    ch.setMoTa(rs.getNString("MoTa"));
                    ch.setDiaChi(rs.getNString("DiaChi"));
                    ch.setSoDienThoai(rs.getString("SoDienThoai"));
                    ch.setEmail(rs.getString("Email"));
                    ch.setMaND(rs.getInt("MaND"));
                    ch.setTrangThai(rs.getBoolean("TrangThai"));
                    ch.setNgayTao(rs.getTimestamp("NgayTao"));
                    ch.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ch;
    }

    public List<CuaHang> findAll() {
        List<CuaHang> list = new ArrayList<>();
        String sql = "SELECT * FROM CuaHang WHERE TrangThai = 1";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CuaHang ch = new CuaHang();
                ch.setMaCH(rs.getInt("MaCH"));
                ch.setTenCH(rs.getNString("TenCH"));
                ch.setMoTa(rs.getNString("MoTa"));
                ch.setDiaChi(rs.getNString("DiaChi"));
                ch.setSoDienThoai(rs.getString("SoDienThoai"));
                ch.setEmail(rs.getString("Email"));
                ch.setMaND(rs.getInt("MaND"));
                ch.setTrangThai(rs.getBoolean("TrangThai"));
                ch.setNgayTao(rs.getTimestamp("NgayTao"));
                ch.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
                list.add(ch);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public long countStores() {
        String sql = "SELECT COUNT(*) FROM CuaHang WHERE TrangThai = 1";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<CuaHang> getFeaturedStores(int limit) {
        List<CuaHang> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM CuaHang WHERE TrangThai = 1 ORDER BY NgayTao DESC"; // Or any other criteria for 'featured'
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CuaHang ch = new CuaHang();
                    ch.setMaCH(rs.getInt("MaCH"));
                    ch.setTenCH(rs.getNString("TenCH"));
                    ch.setMoTa(rs.getNString("MoTa"));
                    ch.setDiaChi(rs.getNString("DiaChi"));
                    ch.setSoDienThoai(rs.getString("SoDienThoai"));
                    ch.setEmail(rs.getString("Email"));
                    ch.setMaND(rs.getInt("MaND"));
                    ch.setTrangThai(rs.getBoolean("TrangThai"));
                    ch.setNgayTao(rs.getTimestamp("NgayTao"));
                    ch.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
                    list.add(ch);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
