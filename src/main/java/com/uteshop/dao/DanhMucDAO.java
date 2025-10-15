package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.DanhMuc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DanhMucDAO {

    public List<DanhMuc> findAll() {
        List<DanhMuc> categoryList = new ArrayList<>();
        String sql = "SELECT MaDM, TenDM, MaCha FROM DanhMuc ORDER BY TenDM ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DanhMuc danhMuc = new DanhMuc();
                danhMuc.setMaDM(rs.getInt("MaDM"));
                danhMuc.setTenDM(rs.getString("TenDM"));
                // Không set moTa vì cột không tồn tại
                categoryList.add(danhMuc);
            }
        } catch (Exception e) {
            System.err.println("Error in DanhMucDAO.findAll: " + e.getMessage());
            e.printStackTrace();
        }

        return categoryList;
    }

    public DanhMuc findById(Integer id) {
        String sql = "SELECT MaDM, TenDM, MaCha FROM DanhMuc WHERE MaDM = ?";
        DanhMuc danhMuc = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    danhMuc = new DanhMuc();
                    danhMuc.setMaDM(rs.getInt("MaDM"));
                    danhMuc.setTenDM(rs.getString("TenDM"));
                    // Không set moTa vì cột không tồn tại
                }
            }
        } catch (Exception e) {
            System.err.println("Error in DanhMucDAO.findById: " + e.getMessage());
            e.printStackTrace();
        }

        return danhMuc;
    }
}