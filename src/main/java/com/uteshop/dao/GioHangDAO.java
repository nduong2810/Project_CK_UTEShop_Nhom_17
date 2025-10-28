package com.uteshop.dao;

import com.uteshop.entity.GioHang;
import com.uteshop.entity.ChiTietGioHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class GioHangDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public GioHang findByUserId(int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<GioHang> query = em.createQuery(
                "SELECT g FROM GioHang g WHERE g.nguoiDung.maND = :userId", GioHang.class);
            query.setParameter("userId", userId);
            List<GioHang> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public boolean save(GioHang gioHang) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            if (gioHang.getMaGH() == 0) {
                em.persist(gioHang);
            } else {
                em.merge(gioHang);
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

    public boolean addToCart(int userId, int productId, int quantity) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            // Find or create cart using the same EntityManager to avoid detached entity problems
            TypedQuery<GioHang> cartQuery = em.createQuery(
                "SELECT g FROM GioHang g WHERE g.nguoiDung.maND = :userId", GioHang.class);
            cartQuery.setParameter("userId", userId);
            List<GioHang> carts = cartQuery.getResultList();

            GioHang gioHang;
            if (carts.isEmpty()) {
                NguoiDung nguoiDung = em.find(NguoiDung.class, userId);
                if (nguoiDung == null) {
                    em.getTransaction().rollback();
                    return false;
                }
                gioHang = new GioHang(nguoiDung);
                em.persist(gioHang);
                // make sure managed
                em.flush();
            } else {
                gioHang = carts.get(0);
                gioHang = em.merge(gioHang);
            }

            // Find product
            SanPham sanPham = em.find(SanPham.class, productId);
            if (sanPham == null) {
                em.getTransaction().rollback();
                return false;
            }

            // Check if product already in cart using entity references
            TypedQuery<ChiTietGioHang> query = em.createQuery(
                "SELECT ct FROM ChiTietGioHang ct WHERE ct.gioHang = :gioHang AND ct.sanPham = :sanPham", 
                ChiTietGioHang.class);
            query.setParameter("gioHang", gioHang);
            query.setParameter("sanPham", sanPham);

            List<ChiTietGioHang> existingItems = query.getResultList();

            if (!existingItems.isEmpty()) {
                // Update quantity
                ChiTietGioHang chiTiet = existingItems.get(0);
                chiTiet.setSoLuong(chiTiet.getSoLuong() + quantity);
                em.merge(chiTiet);
            } else {
                // Add new item
                ChiTietGioHang chiTiet = new ChiTietGioHang(gioHang, sanPham, quantity, sanPham.getDonGia());
                em.persist(chiTiet);
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

    public boolean removeFromCart(int userId, int productId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            TypedQuery<ChiTietGioHang> query = em.createQuery(
                "SELECT ct FROM ChiTietGioHang ct WHERE ct.gioHang.nguoiDung.maND = :userId AND ct.sanPham.maSP = :productId", 
                ChiTietGioHang.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);

            List<ChiTietGioHang> items = query.getResultList();
            for (ChiTietGioHang item : items) {
                // ensure managed before remove
                ChiTietGioHang managed = em.contains(item) ? item : em.merge(item);
                em.remove(managed);
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

    public boolean updateQuantity(int userId, int productId, int newQuantity) {
        if (newQuantity <= 0) {
            return removeFromCart(userId, productId);
        }

        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            TypedQuery<ChiTietGioHang> query = em.createQuery(
                "SELECT ct FROM ChiTietGioHang ct WHERE ct.gioHang.nguoiDung.maND = :userId AND ct.sanPham.maSP = :productId", 
                ChiTietGioHang.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);

            List<ChiTietGioHang> items = query.getResultList();
            if (!items.isEmpty()) {
                ChiTietGioHang item = items.get(0);
                item.setSoLuong(newQuantity);
                em.merge(item);
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

    public boolean clearCart(int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            em.createQuery("DELETE FROM ChiTietGioHang ct WHERE ct.gioHang.nguoiDung.maND = :userId")
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

    public List<ChiTietGioHang> getCartItems(int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            // JOIN FETCH cả sanPham và cuaHang để tránh LazyInitializationException
            TypedQuery<ChiTietGioHang> query = em.createQuery(
                "SELECT ct FROM ChiTietGioHang ct " +
                "JOIN FETCH ct.sanPham sp " +
                "JOIN FETCH sp.cuaHang " +
                "WHERE ct.gioHang.nguoiDung.maND = :userId " +
                "ORDER BY ct.ngayThem DESC", 
                ChiTietGioHang.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}