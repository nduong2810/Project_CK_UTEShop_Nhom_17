package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.NguoiDung;
import com.uteshop.util.PasswordUtil;
import com.uteshop.util.VietnameseEncodingUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class NguoiDungDAO {

    /**
     * Authenticate user by username/email and password
     */
    public NguoiDung authenticate(String usernameOrEmail, String password) {
        String sql = "SELECT * FROM NguoiDung WHERE (TenDangNhap = ? OR Email = ?) AND TrangThai = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Ensure UTF-8 encoding for parameters
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, usernameOrEmail);
            VietnameseEncodingUtil.setVietnameseParameter(ps, 2, usernameOrEmail);
            ps.setBoolean(3, true); // Set TrangThai to true
            
            System.out.println("🔍 Attempting authentication for: " + usernameOrEmail);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = VietnameseEncodingUtil.getVietnameseString(rs, "MatKhau");
                    System.out.println("🔐 Stored password hash: " + storedPassword);
                    System.out.println("🔑 Input password: " + password);
                    
                    // Sử dụng PasswordUtil.verifyPassword cho tất cả loại hash
                    boolean passwordMatches = PasswordUtil.verifyPassword(password, storedPassword);
                    System.out.println("✅ Password match result: " + passwordMatches);
                    
                    if (passwordMatches) {
                        System.out.println("🎉 Authentication successful for user: " + usernameOrEmail);
                        return mapResultSetToNguoiDung(rs);
                    } else {
                        System.out.println("❌ Password verification failed for user: " + usernameOrEmail);
                    }
                } else {
                    System.out.println("❌ User not found: " + usernameOrEmail);
                }
            }
        } catch (Exception e) {
            System.err.println("💥 Authentication error: " + e.getMessage());
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
            ps.setBoolean(8, user.getTrangThai()); 
            ps.setTimestamp(9, new Timestamp(user.getNgayTao().getTime())); 
            
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
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis())); 
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
            user.setNgayTao(new Date(ngayTao.getTime())); 
        }
        
        Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
        if (ngayCapNhat != null) {
            user.setNgayCapNhat(new Date(ngayCapNhat.getTime())); 
        }
        
        return user;
    }
    
    /**
     * Check if username exists
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM NguoiDung WHERE TenDangNhap = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Check if email exists
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM NguoiDung WHERE Email = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Check if phone number exists
     */
    public boolean isPhoneExists(String phone) {
        String sql = "SELECT COUNT(*) FROM NguoiDung WHERE SoDienThoai = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, phone);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Get all users (for admin management)
     */
    public List<NguoiDung> getAllUsers() {
        List<NguoiDung> users = new ArrayList<>();
        String sql = "SELECT * FROM NguoiDung ORDER BY NgayTao DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                users.add(mapResultSetToNguoiDung(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    /**
     * Get users by role
     */
    public List<NguoiDung> getUsersByRole(NguoiDung.VaiTro vaiTro) {
        List<NguoiDung> users = new ArrayList<>();
        String sql = "SELECT * FROM NguoiDung WHERE VaiTro = ? ORDER BY NgayTao DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, vaiTro.name());
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToNguoiDung(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    /**
     * Update user status (activate/deactivate account)
     */
    public boolean updateUserStatus(int userId, boolean status) {
        String sql = "UPDATE NguoiDung SET TrangThai = ?, NgayCapNhat = ? WHERE MaND = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, status); 
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, userId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Change user password
     */
    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE NguoiDung SET MatKhau = ?, NgayCapNhat = ? WHERE MaND = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            VietnameseEncodingUtil.setVietnameseParameter(ps, 1, PasswordUtil.hashPassword(newPassword));
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, userId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    /**
     * Update user password with proper hashing
     * @param userId User ID
     * @param newPassword Plain text new password
     * @return true if password updated successfully
     */
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE NguoiDung SET MatKhau = ?, NgayCapNhat = ? WHERE MaND = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Hash the new password before storing
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            System.out.println("🔐 Updating password for user ID: " + userId);
            System.out.println("🔑 New hashed password: " + hashedPassword);
            
            ps.setString(1, hashedPassword);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, userId);
            
            int result = ps.executeUpdate();
            System.out.println("✅ Password update result: " + (result > 0 ? "SUCCESS" : "FAILED"));
            
            return result > 0;
        } catch (Exception e) {
            System.err.println("💥 Password update error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update user password by email (for forgot password feature)
     * @param email User email
     * @param newPassword Plain text new password
     * @return true if password updated successfully
     */
    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE NguoiDung SET MatKhau = ?, NgayCapNhat = ? WHERE Email = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Hash the new password before storing
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            System.out.println("🔐 Updating password for email: " + email);
            System.out.println("🔑 New hashed password: " + hashedPassword);
            
            ps.setString(1, hashedPassword);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            VietnameseEncodingUtil.setVietnameseParameter(ps, 3, email);
            
            int result = ps.executeUpdate();
            System.out.println("✅ Password update result: " + (result > 0 ? "SUCCESS" : "FAILED"));
            
            return result > 0;
        } catch (Exception e) {
            System.err.println("💥 Password update error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}