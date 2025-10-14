package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.model.SanPham;

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
            e.printStackTrace();
        }

        return list;
    }
}
