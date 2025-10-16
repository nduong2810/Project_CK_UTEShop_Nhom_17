package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.NguoiDung;
import com.uteshop.util.PasswordUtil;

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
            
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("MatKhau");
                    
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
            
            ps.setString(1, username);
            
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
            
            ps.setString(1, email);
            
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
     * Save new user
     */
    public boolean save(NguoiDung user) {
        String sql = "INSERT INTO NguoiDung (TenDangNhap, MatKhau, Email, HoTen, SoDienThoai, DiaChi, VaiTro, TrangThai, NgayTao) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, user.getTenDangNhap());
            ps.setString(2, user.getMatKhau());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getHoTen());
            ps.setString(5, user.getSoDienThoai());
            ps.setString(6, user.getDiaChi());
            ps.setString(7, user.getVaiTro().name());
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
     * Update user information
     */
    public boolean update(NguoiDung user) {
        String sql = "UPDATE NguoiDung SET HoTen = ?, Email = ?, SoDienThoai = ?, DiaChi = ?, NgayCapNhat = ? WHERE MaND = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getHoTen());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getSoDienThoai());
            ps.setString(4, user.getDiaChi());
            ps.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(6, user.getMaND());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    /**
     * Map ResultSet to NguoiDung object
     */
    private NguoiDung mapResultSetToNguoiDung(ResultSet rs) throws SQLException {
        NguoiDung user = new NguoiDung();
        user.setMaND(rs.getInt("MaND"));
        user.setTenDangNhap(rs.getString("TenDangNhap"));
        user.setMatKhau(rs.getString("MatKhau"));
        user.setEmail(rs.getString("Email"));
        user.setHoTen(rs.getString("HoTen"));
        user.setSoDienThoai(rs.getString("SoDienThoai"));
        user.setDiaChi(rs.getString("DiaChi"));
        user.setVaiTro(NguoiDung.VaiTro.valueOf(rs.getString("VaiTro")));
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