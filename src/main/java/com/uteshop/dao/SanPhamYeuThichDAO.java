package com.uteshop.dao;

import com.uteshop.entity.SanPhamYeuThich;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class SanPhamYeuThichDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public boolean addToFavorites(int userId, int productId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Check if already exists
            if (isFavorite(userId, productId)) {
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
            em.persist(yeuThich);
            
            // Update product favorite count
            sanPham.setLuotYeuThich(sanPham.getLuotYeuThich() + 1);
            em.merge(sanPham);
            
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

    public boolean removeFromFavorites(int userId, int productId) {
        EntityManager em = emf.createEntityManager();
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
                
                // Update product favorite count
                SanPham sanPham = em.find(SanPham.class, productId);
                if (sanPham != null && sanPham.getLuotYeuThich() > 0) {
                    sanPham.setLuotYeuThich(sanPham.getLuotYeuThich() - 1);
                    em.merge(sanPham);
                }
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

    public boolean isFavorite(int userId, int productId) {
        EntityManager em = emf.createEntityManager();
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
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPhamYeuThich> query = em.createQuery(
                "SELECT s FROM SanPhamYeuThich s JOIN FETCH s.sanPham WHERE s.nguoiDung.maND = :userId ORDER BY s.ngayYeuThich DESC", 
                SanPhamYeuThich.class);
            query.setParameter("userId", userId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<SanPham> getMostFavoriteProducts(int limit) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true ORDER BY s.luotYeuThich DESC", 
                SanPham.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}