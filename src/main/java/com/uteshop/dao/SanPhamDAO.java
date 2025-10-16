package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.CuaHang;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.sql.*;
import java.util.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class SanPhamDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    // Phương thức cũ sử dụng JDBC (giữ lại để tương thích)
    public List<SanPham> getTop10SanPhamBanChay() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT TOP 10 MaSP, TenSP, DonGia, SoLuongBan, HinhAnh, MoTa " +
                "FROM SanPham ORDER BY SoLuongBan DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("Executing query: " + sql);
            int count = 0;
            while (rs.next()) {
                SanPham sp = new SanPham();
                sp.setMaSP(rs.getInt("MaSP"));
                sp.setTenSP(rs.getString("TenSP"));
                sp.setDonGia(rs.getBigDecimal("DonGia"));
                sp.setSoLuongBan(rs.getInt("SoLuongBan"));
                sp.setHinhAnh(rs.getString("HinhAnh"));
                sp.setMoTa(rs.getString("MoTa"));
                list.add(sp);
                count++;
                System.out.println("Found product: " + sp.getTenSP());
            }
            System.out.println("Total products found: " + count);

        } catch (Exception e) {
            System.err.println("Error in getTop10SanPhamBanChay: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    // Các phương thức mới sử dụng JPA
    public List<SanPham> getTopSellingProducts(int limit) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true ORDER BY s.soLuongBan DESC", 
                SanPham.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } catch (Exception e) {
            // Fallback to JDBC method
            return getTop10SanPhamBanChay();
        } finally {
            em.close();
        }
    }

    public List<SanPham> getNewestProducts(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true ORDER BY s.ngayTao DESC", 
                SanPham.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            // Fallback to top selling products
            return getTopSellingProducts(pageSize);
        } finally {
            em.close();
        }
    }

    public List<SanPham> getBestSellingProducts(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true ORDER BY s.soLuongBan DESC", 
                SanPham.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            // Fallback to top selling products
            return getTopSellingProducts(pageSize);
        } finally {
            em.close();
        }
    }

    public List<SanPham> getHighestRatedProducts(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true AND s.soLuongDanhGia > 0 ORDER BY s.diemDanhGiaTrungBinh DESC, s.soLuongDanhGia DESC", 
                SanPham.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            // Fallback to top selling products
            return getTopSellingProducts(pageSize);
        } finally {
            em.close();
        }
    }

    public List<SanPham> getMostFavoriteProducts(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true ORDER BY s.luotYeuThich DESC", 
                SanPham.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            // Fallback to top selling products
            return getTopSellingProducts(pageSize);
        } finally {
            em.close();
        }
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

    // Lấy sản phẩm theo danh mục (có phân trang)
    public List<SanPham> getProductsByCategory(int categoryId, int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.danhMuc.maDM = :categoryId AND s.trangThai = true ORDER BY s.ngayTao DESC", 
                SanPham.class);
            query.setParameter("categoryId", categoryId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // Tìm kiếm sản phẩm
    public List<SanPham> searchProducts(String keyword, int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true AND (LOWER(s.tenSP) LIKE LOWER(:keyword) OR LOWER(s.moTa) LIKE LOWER(:keyword)) ORDER BY s.soLuongBan DESC", 
                SanPham.class);
            query.setParameter("keyword", "%" + keyword + "%");
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // CRUD Operations
    public boolean save(SanPham sanPham) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            if (sanPham.getMaSP() == 0) {
                sanPham.setNgayTao(LocalDateTime.now());
                sanPham.setNgayCapNhat(LocalDateTime.now());
                em.persist(sanPham);
            } else {
                sanPham.setNgayCapNhat(LocalDateTime.now());
                em.merge(sanPham);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public List<SanPham> findAll(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true ORDER BY s.ngayTao DESC", 
                SanPham.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    public long countProducts() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(s) FROM SanPham s WHERE s.trangThai = true", 
                Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            return 0;
        } finally {
            em.close();
        }
    }

    // Phương thức thiếu cho CategoryController
    public List<SanPham> findByCategoryId(Integer categoryId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.danhMuc.maDM = :categoryId AND s.trangThai = true ORDER BY s.ngayTao DESC", 
                SanPham.class);
            query.setParameter("categoryId", categoryId);
            return query.getResultList();
        } catch (Exception e) {
            // Fallback to JDBC if JPA fails
            return findByCategoryIdJDBC(categoryId);
        } finally {
            em.close();
        }
    }

    // Fallback JDBC method for findByCategoryId
    private List<SanPham> findByCategoryIdJDBC(Integer categoryId) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT MaSP, TenSP, DonGia, SoLuongBan, HinhAnh, MoTa FROM SanPham WHERE MaDM = ? ORDER BY MaSP DESC";

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
            System.err.println("Error in findByCategoryIdJDBC: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}