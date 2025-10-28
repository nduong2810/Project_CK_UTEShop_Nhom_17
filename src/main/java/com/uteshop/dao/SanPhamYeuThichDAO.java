package com.uteshop.dao;

import com.uteshop.entity.SanPhamYeuThich;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;
import com.uteshop.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class SanPhamYeuThichDAO {
    public boolean addToFavorites(int userId, int productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // Check if already exists - Sử dụng cùng EntityManager
            TypedQuery<Long> checkQuery = em.createQuery(
                "SELECT COUNT(s) FROM SanPhamYeuThich s WHERE s.nguoiDung.maND = :userId AND s.sanPham.maSP = :productId", 
                Long.class);
            checkQuery.setParameter("userId", userId);
            checkQuery.setParameter("productId", productId);
            
            if (checkQuery.getSingleResult() > 0) {
                em.getTransaction().rollback();
                System.out.println("Sản phẩm đã có trong danh sách yêu thích");
                return false;
            }
            
            NguoiDung nguoiDung = em.find(NguoiDung.class, userId);
            SanPham sanPham = em.find(SanPham.class, productId);
            
            if (nguoiDung == null) {
                em.getTransaction().rollback();
                System.err.println("Không tìm thấy người dùng với ID: " + userId);
                return false;
            }
            
            if (sanPham == null) {
                em.getTransaction().rollback();
                System.err.println("Không tìm thấy sản phẩm với ID: " + productId);
                return false;
            }
            
            SanPhamYeuThich yeuThich = new SanPhamYeuThich(nguoiDung, sanPham);
            em.persist(yeuThich);
            
            // Update product favorite count
            Integer currentLikes = sanPham.getLuotYeuThich();
            sanPham.setLuotYeuThich((currentLikes != null ? currentLikes : 0) + 1);
            em.merge(sanPham);
            
            em.getTransaction().commit();
            System.out.println("✅ Đã thêm sản phẩm " + productId + " vào danh sách yêu thích của user " + userId);
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("❌ Lỗi khi thêm vào danh sách yêu thích: " + e.getMessage());
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
                
                // Update product favorite count
                SanPham sanPham = em.find(SanPham.class, productId);
                if (sanPham != null) {
                    int currentLikes = sanPham.getLuotYeuThich() != null ? sanPham.getLuotYeuThich() : 0;
                    if (currentLikes > 0) {
                        sanPham.setLuotYeuThich(currentLikes - 1);
                        em.merge(sanPham);
                    }
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
            // Load đầy đủ thông tin sản phẩm và cửa hàng để tránh LazyInitializationException
            TypedQuery<SanPhamYeuThich> query = em.createQuery(
                "SELECT DISTINCT s FROM SanPhamYeuThich s " +
                "JOIN FETCH s.sanPham sp " +
                "LEFT JOIN FETCH sp.cuaHang " +
                "WHERE s.nguoiDung.maND = :userId " +
                "ORDER BY s.maYT DESC",
                SanPhamYeuThich.class);
            query.setParameter("userId", userId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            
            List<SanPhamYeuThich> results = query.getResultList();
            
            System.out.println("📋 Đã load " + results.size() + " sản phẩm yêu thích cho user " + userId);
            
            // Force initialize lazy properties
            for (SanPhamYeuThich spy : results) {
                if (spy.getSanPham() != null) {
                    // Touch the properties to initialize them
                    spy.getSanPham().getTenSP();
                    spy.getSanPham().getDonGia();
                    spy.getSanPham().getHinhAnh();
                    System.out.println("  - Sản phẩm: " + spy.getSanPham().getTenSP());
                }
            }
            
            return results;
        } catch (Exception e) {
            System.err.println("❌ Lỗi khi lấy danh sách yêu thích: " + e.getMessage());
            e.printStackTrace();
            return new java.util.ArrayList<>();
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

    public boolean existsByUserAndProduct(int userId, int productId) {
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

    public Set<Integer> getFavoriteProductIds(int userId) {
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