package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.NguoiDung;
import com.uteshop.util.PasswordUtil;
import com.uteshop.util.VietnameseEncodingUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungDAO {

    /**
     * Authenticate user by username/email and password
     */
    public NguoiDung authenticate(String usernameOrEmail, String password) {
        String sql = "SELECT * FROM NguoiDung WHERE (TenDangNhap = ? OR Email = ?) AND TrangThai = 1";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Ensure UTF-8 encoding for parameters
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, usernameOrEmail);
            VietnameseEncodingUtil.setVietnameseParameter(ps, 2, usernameOrEmail);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = VietnameseEncodingUtil.getVietnameseString(rs, "MatKhau");
                    
                    // Check if password matches (support both plain text and BCrypt)
                    boolean passwordMatches = false;
                    
                    if (PasswordUtil.isBCryptEncoded(storedPassword)) {
                        // If stored password is BCrypt encoded, use BCrypt verification
                        passwordMatches = PasswordUtil.verifyPassword(password, storedPassword);
                    } else {
                        // If stored password is plain text, do direct comparison
                        passwordMatches = password.equals(storedPassword);
                    }
                    
                    if (passwordMatches) {
                        return mapResultSetToNguoiDung(rs);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }

    /**
     * Find user by username
     */
    public NguoiDung findByUsername(String username) {
        String sql = "SELECT * FROM NguoiDung WHERE TenDangNhap = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNguoiDung(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }

    /**
     * Find user by email
     */
    public NguoiDung findByEmail(String email) {
        String sql = "SELECT * FROM NguoiDung WHERE Email = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNguoiDung(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }

    /**
     * Save new user with proper Vietnamese encoding
     */
    public boolean save(NguoiDung user) {
        String sql = "INSERT INTO NguoiDung (TenDangNhap, MatKhau, Email, HoTen, SoDienThoai, DiaChi, VaiTro, TrangThai, NgayTao) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            // Use VietnameseEncodingUtil for proper Unicode handling
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, user.getTenDangNhap());
            VietnameseEncodingUtil.setVietnameseParameter(ps, 2, user.getMatKhau());
            VietnameseEncodingUtil.setVietnameseParameter(ps, 3, user.getEmail());
            VietnameseEncodingUtil.setVietnameseParameter(ps, 4, VietnameseEncodingUtil.prepareVietnameseText(user.getHoTen()));
            VietnameseEncodingUtil.setVietnameseParameter(ps, 5, user.getSoDienThoai());
            VietnameseEncodingUtil.setVietnameseParameter(ps, 6, VietnameseEncodingUtil.prepareVietnameseText(user.getDiaChi()));
            VietnameseEncodingUtil.setVietnameseParameter(ps, 7, user.getVaiTro().name());
            ps.setBoolean(8, user.isTrangThai());
            ps.setTimestamp(9, Timestamp.valueOf(user.getNgayTao()));
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setMaND(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    /**
     * Find user by ID
     */
    public NguoiDung findById(int id) {
        String sql = "SELECT * FROM NguoiDung WHERE MaND = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNguoiDung(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }

    /**
     * Update user information with proper Vietnamese encoding
     */
    public boolean update(NguoiDung user) {
        String sql = "UPDATE NguoiDung SET HoTen = ?, Email = ?, SoDienThoai = ?, DiaChi = ?, NgayCapNhat = ? WHERE MaND = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Use VietnameseEncodingUtil for proper Unicode handling
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, VietnameseEncodingUtil.prepareVietnameseText(user.getHoTen()));
            VietnameseEncodingUtil.setVietnameseParameter(ps, 2, user.getEmail());
            VietnameseEncodingUtil.setVietnameseParameter(ps, 3, user.getSoDienThoai());
            VietnameseEncodingUtil.setVietnameseParameter(ps, 4, VietnameseEncodingUtil.prepareVietnameseText(user.getDiaChi()));
            ps.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(6, user.getMaND());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    /**
     * Map ResultSet to NguoiDung object with proper UTF-8 handling
     */
    private NguoiDung mapResultSetToNguoiDung(ResultSet rs) throws SQLException {
        NguoiDung user = new NguoiDung();
        user.setMaND(rs.getInt("MaND"));
        // Use VietnameseEncodingUtil for proper Unicode handling
        user.setTenDangNhap(VietnameseEncodingUtil.getVietnameseString(rs, "TenDangNhap"));
        user.setMatKhau(VietnameseEncodingUtil.getVietnameseString(rs, "MatKhau"));
        user.setEmail(VietnameseEncodingUtil.getVietnameseString(rs, "Email"));
        user.setHoTen(VietnameseEncodingUtil.getVietnameseString(rs, "HoTen"));
        user.setSoDienThoai(VietnameseEncodingUtil.getVietnameseString(rs, "SoDienThoai"));
        user.setDiaChi(VietnameseEncodingUtil.getVietnameseString(rs, "DiaChi"));
        user.setVaiTro(NguoiDung.VaiTro.valueOf(VietnameseEncodingUtil.getVietnameseString(rs, "VaiTro")));
        user.setTrangThai(rs.getBoolean("TrangThai"));
        
        Timestamp ngayTao = rs.getTimestamp("NgayTao");
        if (ngayTao != null) {
            user.setNgayTao(ngayTao.toLocalDateTime());
        }

        Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
        if (ngayCapNhat != null) {
            user.setNgayCapNhat(ngayCapNhat.toLocalDateTime());
        }
        
        return user;
    }
}