package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.DanhMuc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DanhMucDAO {

    public List<DanhMuc> getAllCategories() {
        List<DanhMuc> categoryList = new ArrayList<>();
        // Sửa lại query để phù hợp với cấu trúc thực tế của bảng DanhMuc
        String sql = "SELECT MaDM, TenDM, moTa FROM DanhMuc ORDER BY TenDM ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("Loading categories from database...");
            while (rs.next()) {
                DanhMuc danhMuc = new DanhMuc();
                danhMuc.setMaDM(rs.getInt("MaDM"));
                danhMuc.setTenDM(rs.getString("TenDM"));
                danhMuc.setMoTa(rs.getString("moTa"));
                
                categoryList.add(danhMuc);
                System.out.println("Found category: " + danhMuc.getTenDM());
            }
            System.out.println("Total categories loaded: " + categoryList.size());
        } catch (Exception e) {
            System.err.println("Error in DanhMucDAO.getAllCategories: " + e.getMessage());
            e.printStackTrace();
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
            System.err.println("Error in DanhMucDAO.findById: " + e.getMessage());
            e.printStackTrace();
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
                System.out.println("Category with products: " + danhMuc.getTenDM() + 
                                 " (" + rs.getInt("SoLuongSanPham") + " products)");
            }

        } catch (Exception e) {
            System.err.println("Error in DanhMucDAO.getCategoriesWithProducts: " + e.getMessage());
            e.printStackTrace();
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
            System.err.println("Error in countCategories: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }
}