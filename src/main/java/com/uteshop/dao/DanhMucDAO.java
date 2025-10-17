package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.DanhMuc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DanhMucDAO {

    private static final Logger LOGGER = Logger.getLogger(DanhMucDAO.class.getName());

    public List<DanhMuc> getAllCategories() {
        List<DanhMuc> categoryList = new ArrayList<>();
        // Sửa lại query để phù hợp với cấu trúc thực tế của bảng DanhMuc
        String sql = "SELECT MaDM, TenDM, moTa FROM DanhMuc ORDER BY TenDM ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            LOGGER.info("Loading categories from database...");
            while (rs.next()) {
                DanhMuc danhMuc = new DanhMuc();
                danhMuc.setMaDM(rs.getInt("MaDM"));
                danhMuc.setTenDM(rs.getString("TenDM"));
                danhMuc.setMoTa(rs.getString("moTa"));

                categoryList.add(danhMuc);
                LOGGER.info("Found category: " + danhMuc.getTenDM());
            }
            LOGGER.info("Total categories loaded: " + categoryList.size());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in DanhMucDAO.getAllCategories", e);
        }

        return categoryList;
    }

    public List<DanhMuc> findAll() {
        return getAllCategories();
    }

    public DanhMuc findById(Integer id) {
        String sql = "SELECT MaDM, TenDM, moTa FROM DanhMuc WHERE MaDM = ?";
        DanhMuc danhMuc = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    danhMuc = new DanhMuc();
                    danhMuc.setMaDM(rs.getInt("MaDM"));
                    danhMuc.setTenDM(rs.getString("TenDM"));
                    danhMuc.setMoTa(rs.getString("moTa"));
                }
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in DanhMucDAO.findById", e);
        }

        return danhMuc;
    }

    // Thêm phương thức lấy danh mục có sản phẩm
    public List<DanhMuc> getCategoriesWithProducts() {
        List<DanhMuc> categoryList = new ArrayList<>();
        String sql = "SELECT DISTINCT dm.MaDM, dm.TenDM, dm.moTa, COUNT(sp.MaSP) as SoLuongSanPham " +
                    "FROM DanhMuc dm " +
                    "LEFT JOIN SanPham sp ON dm.MaDM = sp.MaDM AND sp.TrangThai = 1 " +
                    "GROUP BY dm.MaDM, dm.TenDM, dm.moTa " +
                    "HAVING COUNT(sp.MaSP) > 0 " +
                    "ORDER BY dm.TenDM ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DanhMuc danhMuc = new DanhMuc();
                danhMuc.setMaDM(rs.getInt("MaDM"));
                danhMuc.setTenDM(rs.getString("TenDM"));
                danhMuc.setMoTa(rs.getString("moTa"));
                categoryList.add(danhMuc);
                LOGGER.info("Category with products: " + danhMuc.getTenDM() + 
                                 " (" + rs.getInt("SoLuongSanPham") + " products)");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in DanhMucDAO.getCategoriesWithProducts", e);
        }

        return categoryList;
    }

    // Đếm tổng số danh mục
    public long countCategories() {
        String sql = "SELECT COUNT(*) FROM DanhMuc";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in countCategories", e);
        }

        return 0;
    }
}