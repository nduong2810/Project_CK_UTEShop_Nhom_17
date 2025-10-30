package com.uteshop.dao;

import com.uteshop.entity.DanhGiaSanPham;
import com.uteshop.entity.SanPham;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class DanhGiaSanPhamDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public boolean addReview(DanhGiaSanPham danhGia) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Persist the review
            em.persist(danhGia);
            
            // Update product rating in the same transaction (more efficient)
            updateProductRatingInTransaction(em, danhGia.getSanPham().getMaSP());
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    // New optimized method that uses existing EntityManager (no nested transaction)
    private void updateProductRatingInTransaction(EntityManager em, Integer productId) {
        try {
            // Calculate average and count in one query
            TypedQuery<Object[]> query = em.createQuery(
                "SELECT AVG(d.diemDanhGia), COUNT(d) FROM DanhGiaSanPham d WHERE d.sanPham.maSP = :productId AND d.trangThai = true", 
                Object[].class);
            query.setParameter("productId", productId);
            
            Object[] result = query.getSingleResult();
            Double avgRatingDouble = (Double) result[0];
            Long reviewCount = (Long) result[1];
            
            // Update product using JPQL (faster than merge)
            em.createQuery("UPDATE SanPham s SET s.diemDanhGiaTrungBinh = :avg, s.soLuongDanhGia = :count WHERE s.maSP = :id")
                .setParameter("avg", avgRatingDouble != null ? BigDecimal.valueOf(avgRatingDouble) : BigDecimal.ZERO)
                .setParameter("count", reviewCount != null ? reviewCount.intValue() : 0)
                .setParameter("id", productId)
                .executeUpdate();
        } catch (Exception e) {
            // Don't throw, just log - review is already saved
            System.err.println("Warning: Could not update product rating: " + e.getMessage());
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

    // Check if user has reviewed a product in a specific order
    public boolean hasUserReviewedProduct(Integer userId, Integer productId, Integer orderId) {
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

    // Get review by user, product and order
    public DanhGiaSanPham getReviewByUserProductOrder(Integer userId, Integer productId, Integer orderId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DanhGiaSanPham> query = em.createQuery(
                "SELECT d FROM DanhGiaSanPham d WHERE d.nguoiDung.maND = :userId AND d.sanPham.maSP = :productId AND d.donHang.maDH = :orderId", 
                DanhGiaSanPham.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            query.setParameter("orderId", orderId);
            query.setMaxResults(1);
            List<DanhGiaSanPham> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    // Get total review count for a product
    public long getTotalReviewCount(Integer productId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(d) FROM DanhGiaSanPham d WHERE d.sanPham.maSP = :productId AND d.trangThai = true", 
                Long.class);
            query.setParameter("productId", productId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Get all reviews for a product (without pagination) for display
    public List<DanhGiaSanPham> getAllReviewsByProduct(Integer productId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DanhGiaSanPham> query = em.createQuery(
                "SELECT d FROM DanhGiaSanPham d JOIN FETCH d.nguoiDung WHERE d.sanPham.maSP = :productId AND d.trangThai = true ORDER BY d.ngayDanhGia DESC", 
                DanhGiaSanPham.class);
            query.setParameter("productId", productId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Get user's reviews for a specific product
    public List<DanhGiaSanPham> getUserReviewsForProduct(Integer userId, Integer productId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DanhGiaSanPham> query = em.createQuery(
                "SELECT d FROM DanhGiaSanPham d WHERE d.nguoiDung.maND = :userId AND d.sanPham.maSP = :productId AND d.trangThai = true ORDER BY d.ngayDanhGia DESC", 
                DanhGiaSanPham.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Delete review by ID
    public boolean deleteReviewById(Integer reviewId, Integer userId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            DanhGiaSanPham review = em.find(DanhGiaSanPham.class, reviewId);
            if (review != null && review.getNguoiDung().getMaND().equals(userId)) {
                Integer productId = review.getSanPham().getMaSP();
                em.remove(review);
                
                // Update product rating after deletion
                updateProductRatingInTransaction(em, productId);
                
                em.getTransaction().commit();
                return true;
            }
            
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // Update review by user
    public boolean updateUserReview(Integer reviewId, Integer userId, int newRating, String newContent, String newImage) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            DanhGiaSanPham review = em.find(DanhGiaSanPham.class, reviewId);
            if (review != null && review.getNguoiDung().getMaND().equals(userId)) {
                review.setDiemDanhGia(newRating);
                review.setNoiDung(newContent);
                if (newImage != null) {
                    review.setHinhAnh(newImage);
                }
                review.setNgayDanhGia(new Date()); // Update timestamp
                
                em.merge(review);
                
                // Update product rating
                updateProductRatingInTransaction(em, review.getSanPham().getMaSP());
                
                em.getTransaction().commit();
                return true;
            }
            
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
