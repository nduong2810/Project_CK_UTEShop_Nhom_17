package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.DonViVanChuyen;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class DonViVanChuyenDAO {
    
    // Lấy tất cả đơn vị vận chuyển với thông tin chi tiết
    public List<DonViVanChuyen> findAll() {
        List<DonViVanChuyen> list = new ArrayList<>();
        String sql = "SELECT MaVC, TenDonVi, PhiVanChuyen FROM DonViVanChuyen ORDER BY PhiVanChuyen ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("Loading shipping partners...");
            while (rs.next()) {
                DonViVanChuyen dvvc = new DonViVanChuyen();
                dvvc.setMaVC(rs.getInt("MaVC"));
                dvvc.setTenDonVi(rs.getString("TenDonVi"));
                dvvc.setPhiVanChuyen(rs.getBigDecimal("PhiVanChuyen"));
                
                System.out.println("Found shipping partner: " + dvvc.getTenDonVi() + " - Fee: " + dvvc.getPhiVanChuyen());
                list.add(dvvc);
            }
            System.out.println("Total shipping partners loaded: " + list.size());

        } catch (Exception e) {
            System.err.println("Error in DonViVanChuyenDAO.findAll: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
    
    // Lấy đơn vị vận chuyển theo ID
    public DonViVanChuyen findById(int maVC) {
        String sql = "SELECT * FROM DonViVanChuyen WHERE MaVC = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maVC);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    DonViVanChuyen dvvc = new DonViVanChuyen();
                    dvvc.setMaVC(rs.getInt("MaVC"));
                    dvvc.setTenDonVi(rs.getString("TenDonVi"));
                    dvvc.setPhiVanChuyen(rs.getBigDecimal("PhiVanChuyen"));
                    return dvvc;
                }
            }

        } catch (Exception e) {
            System.err.println("Error in DonViVanChuyenDAO.findById: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }
    
    // Lấy đơn vị vận chuyển có phí thấp nhất
    public List<DonViVanChuyen> findCheapestShipping(int limit) {
        List<DonViVanChuyen> list = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM DonViVanChuyen ORDER BY PhiVanChuyen ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DonViVanChuyen dvvc = new DonViVanChuyen();
                dvvc.setMaVC(rs.getInt("MaVC"));
                dvvc.setTenDonVi(rs.getString("TenDonVi"));
                dvvc.setPhiVanChuyen(rs.getBigDecimal("PhiVanChuyen"));
                list.add(dvvc);
            }

        } catch (Exception e) {
            System.err.println("Error in DonViVanChuyenDAO.findCheapestShipping: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
    
    // Tính phí vận chuyển theo khoảng cách (ví dụ)
    public BigDecimal calculateShippingFee(int maVC, double distance) {
        DonViVanChuyen dvvc = findById(maVC);
        if (dvvc != null) {
            // Công thức tính phí: phí cơ bản + (khoảng cách * 1000)
            BigDecimal baseFee = dvvc.getPhiVanChuyen();
            BigDecimal distanceFee = BigDecimal.valueOf(distance * 1000);
            return baseFee.add(distanceFee);
        }
        return BigDecimal.ZERO;
    }
    
    // Đếm tổng số đơn vị vận chuyển
    public long countShippingPartners() {
        String sql = "SELECT COUNT(*) FROM DonViVanChuyen";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }

        } catch (Exception e) {
            System.err.println("Error in countShippingPartners: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }
    
    // Thêm đơn vị vận chuyển mới
    public boolean insert(DonViVanChuyen dvvc) {
        String sql = "INSERT INTO DonViVanChuyen (TenDonVi, PhiVanChuyen) VALUES (?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dvvc.getTenDonVi());
            ps.setBigDecimal(2, dvvc.getPhiVanChuyen());
            
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error in DonViVanChuyenDAO.insert: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
    
    // Cập nhật đơn vị vận chuyển
    public boolean update(DonViVanChuyen dvvc) {
        String sql = "UPDATE DonViVanChuyen SET TenDonVi = ?, PhiVanChuyen = ? WHERE MaVC = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dvvc.getTenDonVi());
            ps.setBigDecimal(2, dvvc.getPhiVanChuyen());
            ps.setInt(3, dvvc.getMaVC());
            
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error in DonViVanChuyenDAO.update: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}