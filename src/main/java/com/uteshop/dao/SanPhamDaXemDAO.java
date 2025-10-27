package com.uteshop.dao;

import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.SanPhamDaXem;
import com.uteshop.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

public class SanPhamDaXemDAO {

    public boolean recordView(int userId, int productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            SanPhamDaXem v;
            try {
                v = em.createQuery(
                                "SELECT v FROM SanPhamDaXem v WHERE v.nguoiDung.maND = :uid AND v.sanPham.maSP = :pid",
                                SanPhamDaXem.class)
                        .setParameter("uid", userId)
                        .setParameter("pid", productId)
                        .getSingleResult();
            } catch (NoResultException e) {
                v = null;
            }

            if (v == null) {
                NguoiDung u = em.getReference(NguoiDung.class, userId);
                SanPham p = em.getReference(SanPham.class, productId);
                v = new SanPhamDaXem(u, p);
                em.persist(v);
            } else {
                v.setNgayXem(LocalDateTime.now());
                v.setSoLanXem(v.getSoLanXem() + 1);
                em.merge(v);
            }

            em.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            ex.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public List<SanPham> findRecentProductsByUser(int userId, int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT v.sanPham FROM SanPhamDaXem v " +
                                    "WHERE v.nguoiDung.maND = :uid " +
                                    "ORDER BY v.ngayXem DESC", SanPham.class)
                    .setParameter("uid", userId)
                    .setMaxResults(limit)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }
    public long countViewedByUser(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(v) FROM SanPhamDaXem v WHERE v.nguoiDung.maND = :uid", Long.class)
                    .setParameter("uid", userId)
                    .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    public List<SanPham> findViewedByUser(int userId, int page, int size) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT v.sanPham FROM SanPhamDaXem v " +
                                    "WHERE v.nguoiDung.maND = :uid " +
                                    "ORDER BY v.ngayXem DESC", SanPham.class)
                    .setParameter("uid", userId)
                    .setFirstResult((page - 1) * size)
                    .setMaxResults(size)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    public boolean clearHistory(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("DELETE FROM SanPhamDaXem v WHERE v.nguoiDung.maND = :uid")
                    .setParameter("uid", userId)
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
