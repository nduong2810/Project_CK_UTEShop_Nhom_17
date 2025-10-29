package com.uteshop.dao;

import com.uteshop.entity.SanPhamYeuThich;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;
import com.uteshop.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class SanPhamYeuThichDAO {
    public boolean addToFavorites(int userId, int productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // Check if already favorited
            TypedQuery<SanPhamYeuThich> existingFavoriteQuery = em.createQuery(
                "SELECT s FROM SanPhamYeuThich s WHERE s.nguoiDung.maND = :userId AND s.sanPham.maSP = :productId", 
                SanPhamYeuThich.class);
            existingFavoriteQuery.setParameter("userId", userId);
            existingFavoriteQuery.setParameter("productId", productId);
            
            if (!existingFavoriteQuery.getResultList().isEmpty()) { // If a favorite already exists
                em.getTransaction().rollback();
                return false;
            }
            
            NguoiDung nguoiDung = em.find(NguoiDung.class, userId);
            SanPham sanPham = em.find(SanPham.class, productId);
            
            if (nguoiDung == null || sanPham == null) {
                em.getTransaction().rollback();
                return false;
            }
            
            SanPhamYeuThich yeuThich = new SanPhamYeuThich(nguoiDung, sanPham);
            yeuThich.setNgayYeuThich(LocalDateTime.now());
            em.persist(yeuThich);
            
            // Increment favorite count, handling null
            sanPham.setLuotYeuThich( (sanPham.getLuotYeuThich() == null ? 0 : sanPham.getLuotYeuThich()) + 1);
            em.merge(sanPham);
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback(); // rollback is safe to call even if transaction is not active
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean removeFromFavorites(int userId, int productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            TypedQuery<SanPhamYeuThich> query = em.createQuery(
                "SELECT s FROM SanPhamYeuThich s WHERE s.nguoiDung.maND = :userId AND s.sanPham.maSP = :productId", 
                SanPhamYeuThich.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            
            List<SanPhamYeuThich> favorites = query.getResultList();
            if (!favorites.isEmpty()) {
                SanPhamYeuThich favorite = favorites.get(0);
                em.remove(favorite);
                
                SanPham sanPham = em.find(SanPham.class, productId);
                if (sanPham != null) {
                    // Decrement favorite count, handling null and ensuring it doesn't go below zero
                    int currentLikes = (sanPham.getLuotYeuThich() == null ? 0 : sanPham.getLuotYeuThich());
                    if (currentLikes > 0) {
                        sanPham.setLuotYeuThich(currentLikes - 1);
                        em.merge(sanPham);
                    }
                }
            }
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback(); // rollback is safe to call even if transaction is not active
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean isFavorite(int userId, int productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(s) FROM SanPhamYeuThich s WHERE s.nguoiDung.maND = :userId AND s.sanPham.maSP = :productId", 
                Long.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    public List<SanPhamYeuThich> getFavoritesByUser(int userId, int page, int pageSize) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<SanPhamYeuThich> query = em.createQuery(
                "SELECT s FROM SanPhamYeuThich s JOIN FETCH s.sanPham sp LEFT JOIN FETCH sp.cuaHang WHERE s.nguoiDung.maND = :userId ORDER BY s.maYT DESC",
                SanPhamYeuThich.class);
            query.setParameter("userId", userId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long countFavoritesByUser(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(s) FROM SanPhamYeuThich s WHERE s.nguoiDung.maND = :userId",
                Long.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public Set<Integer> getFavoriteProductIdsByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Integer> query = em.createQuery(
                "SELECT s.sanPham.maSP FROM SanPhamYeuThich s WHERE s.nguoiDung.maND = :userId", 
                Integer.class);
            query.setParameter("userId", userId);
            return query.getResultList().stream().collect(Collectors.toSet());
        } finally {
            em.close();
        }
    }
}