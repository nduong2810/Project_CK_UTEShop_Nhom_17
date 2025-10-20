package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.DanhMuc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DanhMucDAO {

    public DanhMuc findById(Integer id) {
        String sql = "SELECT * FROM DanhMuc WHERE MaDM = ?";
        DanhMuc dm = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    dm = new DanhMuc();
                    dm.setMaDM(rs.getInt("MaDM"));
                    dm.setTenDM(rs.getNString("TenDM"));
                    dm.setMoTa(rs.getNString("MoTa"));
                    dm.setHinhAnh(rs.getNString("HinhAnh"));
                    dm.setNgayTao(rs.getTimestamp("NgayTao"));
                    dm.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
                    dm.setTrangThai(rs.getInt("TrangThai"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dm;
    }

    public List<DanhMuc> findAll() {
        List<DanhMuc> list = new ArrayList<>();
        String sql = "SELECT * FROM DanhMuc WHERE TrangThai = 1";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DanhMuc dm = new DanhMuc();
                dm.setMaDM(rs.getInt("MaDM"));
                dm.setTenDM(rs.getNString("TenDM"));
                dm.setMoTa(rs.getNString("MoTa"));
                dm.setHinhAnh(rs.getNString("HinhAnh"));
                dm.setNgayTao(rs.getTimestamp("NgayTao"));
                dm.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
                dm.setTrangThai(rs.getInt("TrangThai"));
                list.add(dm);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<DanhMuc> getAllCategories() {
        List<DanhMuc> list = new ArrayList<>();
        String sql = "SELECT * FROM DanhMuc WHERE TrangThai = 1 ORDER BY TenDM ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DanhMuc dm = new DanhMuc();
                dm.setMaDM(rs.getInt("MaDM"));
                dm.setTenDM(rs.getNString("TenDM"));
                dm.setMoTa(rs.getNString("MoTa"));
                dm.setHinhAnh(rs.getNString("HinhAnh"));
                dm.setNgayTao(rs.getTimestamp("NgayTao"));
                dm.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
                dm.setTrangThai(rs.getInt("TrangThai"));
                list.add(dm);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
