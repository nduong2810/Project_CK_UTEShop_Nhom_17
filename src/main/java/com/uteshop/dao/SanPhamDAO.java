package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.SanPham;

import java.sql.*;
import java.util.*;

public class SanPhamDAO {

    public List<SanPham> getTop10SanPhamBanChay() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT TOP 10 MaSP, TenSP, DonGia, SoLuongBan, HinhAnh, MoTa " +
                "FROM SanPham ORDER BY SoLuongBan DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SanPham sp = new SanPham();
                sp.setMaSP(rs.getInt("MaSP"));
                sp.setTenSP(rs.getString("TenSP"));
                sp.setDonGia(rs.getBigDecimal("DonGia"));
                sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                sp.setHinhAnh(rs.getString("HinhAnh"));
                sp.setMoTa(rs.getString("MoTa"));
                list.add(sp);
            }

        } catch (Exception e) {
            System.err.println("Error in getTop10SanPhamBanChay: " + e.getMessage());
        }

        return list;
    }

    public SanPham findById(Integer id) {
        String sql = "SELECT * FROM SanPham WHERE MaSP = ?";
        SanPham sp = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    sp = new SanPham();
                    sp.setMaSP(rs.getInt("MaSP"));
                    sp.setTenSP(rs.getString("TenSP"));
                    sp.setDonGia(rs.getBigDecimal("DonGia"));
                    sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                    sp.setHinhAnh(rs.getString("HinhAnh"));
                    sp.setMoTa(rs.getString("MoTa"));
                }
            }
        } catch (Exception e) {
            System.err.println("Error in findById: " + e.getMessage());
            e.printStackTrace();
        }

        return sp;
    }

    public List<SanPham> findByCategoryId(int categoryId) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT MaSP, TenSP, DonGia, SoLuongBan, HinhAnh, MoTa FROM SanPham WHERE MaDM = ? ORDER BY NgayTao DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham();
                    sp.setMaSP(rs.getInt("MaSP"));
                    sp.setTenSP(rs.getString("TenSP"));
                    sp.setDonGia(rs.getBigDecimal("DonGia"));
                    sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                    sp.setHinhAnh(rs.getString("HinhAnh"));
                    sp.setMoTa(rs.getString("MoTa"));
                    list.add(sp);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in findByCategoryId: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}
