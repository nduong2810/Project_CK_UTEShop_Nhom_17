package com.uteshop.dao;

import com.uteshop.entity.DanhGiaSanPham;
import com.uteshop.entity.SanPham;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.List;

public class DanhGiaSanPhamDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public boolean addReview(DanhGiaSanPham danhGia) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
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
                Integer productId = danhGia.getSanPham().getMaSP();
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

    private void updateProductRating(Integer productId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            TypedQuery<Object[]> query = em.createQuery(
                "SELECT AVG(d.diemDanhGia), COUNT(d) FROM DanhGiaSanPham d WHERE d.sanPham.maSP = :productId AND d.trangThai = true", 
                Object[].class);
            query.setParameter("productId", productId);
            
            Object[] result = query.getSingleResult();
            Double avgRatingDouble = (Double) result[0];
            Long reviewCount = (Long) result[1];
            
            SanPham sanPham = em.find(SanPham.class, productId);
            if (sanPham != null) {
                if (avgRatingDouble != null) {
                    sanPham.setDiemDanhGiaTrungBinh(BigDecimal.valueOf(avgRatingDouble)); // Convert Double to BigDecimal
                } else {
                    sanPham.setDiemDanhGiaTrungBinh(BigDecimal.ZERO);
                }
                sanPham.setSoLuongDanhGia(reviewCount != null ? reviewCount.intValue() : 0);
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
