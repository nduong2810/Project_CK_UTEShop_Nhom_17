package com.uteshop.dao;

import com.uteshop.entity.SanPhamDaXem;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.util.List;

public class SanPhamDaXemDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public boolean addViewedProduct(int userId, int productId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Check if already viewed
            TypedQuery<SanPhamDaXem> query = em.createQuery(
                "SELECT s FROM SanPhamDaXem s WHERE s.nguoiDung.maND = :userId AND s.sanPham.maSP = :productId", 
                SanPhamDaXem.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            
            List<SanPhamDaXem> existing = query.getResultList();
            
            if (!existing.isEmpty()) {
                // Update view count and time
                SanPhamDaXem viewed = existing.get(0);
                viewed.setSoLanXem(viewed.getSoLanXem() + 1);
                viewed.setNgayXem(LocalDateTime.now());
                em.merge(viewed);
            } else {
                // Create new view record
                NguoiDung nguoiDung = em.find(NguoiDung.class, userId);
                SanPham sanPham = em.find(SanPham.class, productId);
                
                if (nguoiDung == null || sanPham == null) {
                    em.getTransaction().rollback();
                    return false;
                }
                
                SanPhamDaXem viewed = new SanPhamDaXem(nguoiDung, sanPham);
                em.persist(viewed);
            }
            
            // Update product view count
            SanPham sanPham = em.find(SanPham.class, productId);
            if (sanPham != null) {
                sanPham.setLuotXem(sanPham.getLuotXem() + 1);
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

    public List<SanPhamDaXem> getViewedProductsByUser(int userId, int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPhamDaXem> query = em.createQuery(
                "SELECT s FROM SanPhamDaXem s JOIN FETCH s.sanPham WHERE s.nguoiDung.maND = :userId ORDER BY s.ngayXem DESC", 
                SanPhamDaXem.class);
            query.setParameter("userId", userId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<SanPham> getMostViewedProducts(int limit) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<SanPham> query = em.createQuery(
                "SELECT s FROM SanPham s WHERE s.trangThai = true ORDER BY s.luotXem DESC", 
                SanPham.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public boolean clearViewHistory(int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            em.createQuery("DELETE FROM SanPhamDaXem s WHERE s.nguoiDung.maND = :userId")
              .setParameter("userId", userId)
              .executeUpdate();
            
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
}