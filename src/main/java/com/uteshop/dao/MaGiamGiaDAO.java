package com.uteshop.dao;

import com.uteshop.entity.MaGiamGia;
<<<<<<< HEAD
import com.uteshop.entity.CuaHang;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.time.LocalDateTime;
import java.util.List;

public class MaGiamGiaDAO {
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    // Lấy danh sách mã giảm giá theo cửa hàng
    public List<MaGiamGia> findByCuaHangId(int maCH) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<MaGiamGia> query = em.createQuery(
                "SELECT m FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH ORDER BY m.ngayTao DESC", 
                MaGiamGia.class
            );
            query.setParameter("maCH", maCH);
            return query.getResultList();
=======
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class MaGiamGiaDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public MaGiamGia findByCode(String code) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<MaGiamGia> q = em.createQuery("SELECT m FROM MaGiamGia m WHERE m.maSo = :code", MaGiamGia.class);
            q.setParameter("code", code);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
>>>>>>> origin/main
        } finally {
            em.close();
        }
    }

<<<<<<< HEAD
    // Lấy danh sách mã giảm giá theo cửa hàng với phân trang
    public List<MaGiamGia> findByCuaHangIdWithPaging(int maCH, int offset, int limit) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<MaGiamGia> query = em.createQuery(
                "SELECT m FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH ORDER BY m.ngayTao DESC", 
                MaGiamGia.class
            );
            query.setParameter("maCH", maCH);
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Đếm số lượng mã giảm giá theo cửa hàng
    public int countByCuaHangId(int maCH) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(m) FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH", 
                Long.class
            );
            query.setParameter("maCH", maCH);
            return query.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }

    // Tìm mã giảm giá theo mã số
    public MaGiamGia findByMaSo(String maSo) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<MaGiamGia> query = em.createQuery(
                "SELECT m FROM MaGiamGia m WHERE m.maSo = :maSo", 
                MaGiamGia.class
            );
            query.setParameter("maSo", maSo);
            List<MaGiamGia> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    // Tìm mã giảm giá theo ID
    public MaGiamGia findById(int maGG) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(MaGiamGia.class, maGG);
        } finally {
            em.close();
        }
    }

    // Thêm mã giảm giá mới
    public boolean save(MaGiamGia maGiamGia) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            if (maGiamGia.getMaGG() == 0) {
                em.persist(maGiamGia);
            } else {
                em.merge(maGiamGia);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
=======
    public boolean incrementUsage(int maGG) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            MaGiamGia m = em.find(MaGiamGia.class, maGG);
            if (m == null) {
                em.getTransaction().rollback();
                return false;
            }
            m.setSoLuongDaSuDung(m.getSoLuongDaSuDung() + 1);
            em.merge(m);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try { if (em.getTransaction().isActive()) em.getTransaction().rollback(); } catch (Exception ex) {}
>>>>>>> origin/main
            return false;
        } finally {
            em.close();
        }
    }
<<<<<<< HEAD

    // Cập nhật mã giảm giá
    public boolean update(MaGiamGia maGiamGia) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(maGiamGia);
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

    // Xóa mã giảm giá
    public boolean delete(int maGG) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            MaGiamGia maGiamGia = em.find(MaGiamGia.class, maGG);
            if (maGiamGia != null) {
                em.remove(maGiamGia);
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

    // Kiểm tra mã giảm giá có hợp lệ không (chưa hết hạn, còn lượt sử dụng)
    public boolean isValidDiscountCode(String maSo, int maCH) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<MaGiamGia> query = em.createQuery(
                "SELECT m FROM MaGiamGia m WHERE m.maSo = :maSo AND m.cuaHang.maCH = :maCH " +
                "AND m.trangThai = true AND m.ngayBatDau <= :now AND m.ngayKetThuc >= :now " +
                "AND (m.soLuongToiDa IS NULL OR m.soLuongDaSuDung < m.soLuongToiDa)", 
                MaGiamGia.class
            );
            query.setParameter("maSo", maSo);
            query.setParameter("maCH", maCH);
            query.setParameter("now", LocalDateTime.now());
            
            List<MaGiamGia> results = query.getResultList();
            return !results.isEmpty();
        } finally {
            em.close();
        }
    }

    // Cập nhật số lượng đã sử dụng
    public boolean incrementUsageCount(int maGG) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            MaGiamGia maGiamGia = em.find(MaGiamGia.class, maGG);
            if (maGiamGia != null) {
                maGiamGia.setSoLuongDaSuDung(maGiamGia.getSoLuongDaSuDung() + 1);
                em.merge(maGiamGia);
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

    // Lấy danh sách mã giảm giá đang hoạt động của cửa hàng
    public List<MaGiamGia> getActiveDiscountsByStore(int maCH) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<MaGiamGia> query = em.createQuery(
                "SELECT m FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH " +
                "AND m.trangThai = true AND m.ngayBatDau <= :now AND m.ngayKetThuc >= :now " +
                "ORDER BY m.ngayTao DESC", 
                MaGiamGia.class
            );
            query.setParameter("maCH", maCH);
            query.setParameter("now", LocalDateTime.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
=======
}
>>>>>>> origin/main
