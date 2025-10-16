package com.uteshop.dao;

import com.uteshop.entity.DanhGiaSanPham;
import com.uteshop.entity.SanPham;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

public class DanhGiaSanPhamDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public boolean addReview(DanhGiaSanPham danhGia) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Validate content length (minimum 50 characters)
            if (danhGia.getNoiDung() != null && danhGia.getNoiDung().trim().length() < 50) {
                em.getTransaction().rollback();
                return false;
            }
            
            // Check if user has purchased this product
            if (!hasUserPurchasedProduct(danhGia.getNguoiDung().getMaND(), 
                                       danhGia.getSanPham().getMaSP(), 
                                       danhGia.getDonHang().getMaDH())) {
                em.getTransaction().rollback();
                return false;
            }
            
            // Check if user already reviewed this product for this order
            if (hasUserReviewedProduct(danhGia.getNguoiDung().getMaND(), 
                                     danhGia.getSanPham().getMaSP(), 
                                     danhGia.getDonHang().getMaDH())) {
                em.getTransaction().rollback();
                return false;
            }
            
            em.persist(danhGia);
            
            // Update product rating
            updateProductRating(danhGia.getSanPham().getMaSP());
            
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

    public boolean updateReview(DanhGiaSanPham danhGia) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Validate content length
            if (danhGia.getNoiDung() != null && danhGia.getNoiDung().trim().length() < 50) {
                em.getTransaction().rollback();
                return false;
            }
            
            em.merge(danhGia);
            
            // Update product rating
            updateProductRating(danhGia.getSanPham().getMaSP());
            
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

    public boolean deleteReview(int reviewId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            DanhGiaSanPham danhGia = em.find(DanhGiaSanPham.class, reviewId);
            if (danhGia != null) {
                int productId = danhGia.getSanPham().getMaSP();
                em.remove(danhGia);
                
                // Update product rating
                updateProductRating(productId);
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

    public List<DanhGiaSanPham> getReviewsByProduct(int productId, int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DanhGiaSanPham> query = em.createQuery(
                "SELECT d FROM DanhGiaSanPham d JOIN FETCH d.nguoiDung WHERE d.sanPham.maSP = :productId AND d.trangThai = true ORDER BY d.ngayDanhGia DESC", 
                DanhGiaSanPham.class);
            query.setParameter("productId", productId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<DanhGiaSanPham> getReviewsByUser(int userId, int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DanhGiaSanPham> query = em.createQuery(
                "SELECT d FROM DanhGiaSanPham d JOIN FETCH d.sanPham WHERE d.nguoiDung.maND = :userId ORDER BY d.ngayDanhGia DESC", 
                DanhGiaSanPham.class);
            query.setParameter("userId", userId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<SanPham> getHighestRatedProducts(int limit) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true AND s.soLuongDanhGia > 0 ORDER BY s.diemDanhGiaTrungBinh DESC, s.soLuongDanhGia DESC", 
                SanPham.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    private boolean hasUserPurchasedProduct(int userId, int productId, int orderId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(ct) FROM ChiTietDonHang ct WHERE ct.donHang.maDH = :orderId AND ct.donHang.nguoiDung.maND = :userId AND ct.sanPham.maSP = :productId AND ct.donHang.trangThai = 'DA_GIAO'", 
                Long.class);
            query.setParameter("orderId", orderId);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    private boolean hasUserReviewedProduct(int userId, int productId, int orderId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(d) FROM DanhGiaSanPham d WHERE d.nguoiDung.maND = :userId AND d.sanPham.maSP = :productId AND d.donHang.maDH = :orderId", 
                Long.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            query.setParameter("orderId", orderId);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    private void updateProductRating(int productId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Calculate average rating
            TypedQuery<Object[]> query = em.createQuery(
                "SELECT AVG(d.diemDanhGia), COUNT(d) FROM DanhGiaSanPham d WHERE d.sanPham.maSP = :productId AND d.trangThai = true", 
                Object[].class);
            query.setParameter("productId", productId);
            
            Object[] result = query.getSingleResult();
            Double avgRating = (Double) result[0];
            Long reviewCount = (Long) result[1];
            
            SanPham sanPham = em.find(SanPham.class, productId);
            if (sanPham != null) {
                if (avgRating != null) {
                    sanPham.setDiemDanhGiaTrungBinh(
                        BigDecimal.valueOf(avgRating).setScale(2, RoundingMode.HALF_UP));
                } else {
                    sanPham.setDiemDanhGiaTrungBinh(BigDecimal.ZERO);
                }
                sanPham.setSoLuongDanhGia(reviewCount.intValue());
                em.merge(sanPham);
            }
            
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}