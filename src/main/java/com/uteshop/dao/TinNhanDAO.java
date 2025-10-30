package com.uteshop.dao;

import com.uteshop.entity.TinNhan;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.Date;
import java.util.List;

public class TinNhanDAO {
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    /**
     * Lưu tin nhắn mới
     */
    public TinNhan saveMessage(TinNhan tinNhan) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(tinNhan);
            em.getTransaction().commit();
            return tinNhan;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tin nhắn theo hội thoại
     */
    public List<TinNhan> getMessagesByConversationId(Integer maHoiThoai, int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<TinNhan> query = em.createQuery(
                "SELECT t FROM TinNhan t " +
                "LEFT JOIN FETCH t.nguoiGui " +
                "WHERE t.maHoiThoai = :maHoiThoai " +
                "ORDER BY t.ngayGui DESC",
                TinNhan.class
            );
            query.setParameter("maHoiThoai", maHoiThoai);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tất cả tin nhắn theo hội thoại
     */
    public List<TinNhan> getAllMessagesByConversationId(Integer maHoiThoai) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<TinNhan> query = em.createQuery(
                "SELECT t FROM TinNhan t " +
                "LEFT JOIN FETCH t.nguoiGui " +
                "WHERE t.maHoiThoai = :maHoiThoai " +
                "ORDER BY t.ngayGui ASC",
                TinNhan.class
            );
            query.setParameter("maHoiThoai", maHoiThoai);
            
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Đánh dấu tin nhắn đã đọc
     */
    public void markAsRead(Integer maTinNhan) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            TinNhan tinNhan = em.find(TinNhan.class, maTinNhan);
            if (tinNhan != null && !tinNhan.getDaDoc()) {
                tinNhan.setDaDoc(true);
                tinNhan.setNgayDoc(new Date());
                em.merge(tinNhan);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    /**
     * Đánh dấu tất cả tin nhắn của hội thoại đã đọc
     */
    public void markAllAsRead(Integer maHoiThoai, Integer maNguoiNhan) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery(
                "UPDATE TinNhan t SET t.daDoc = true, t.ngayDoc = :ngayDoc " +
                "WHERE t.maHoiThoai = :maHoiThoai AND t.maNguoiGui != :maNguoiNhan AND t.daDoc = false"
            )
            .setParameter("ngayDoc", new Date())
            .setParameter("maHoiThoai", maHoiThoai)
            .setParameter("maNguoiNhan", maNguoiNhan)
            .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    /**
     * Đếm số tin nhắn chưa đọc trong hội thoại
     */
    public int countUnreadMessages(Integer maHoiThoai, Integer maNguoiNhan) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(t) FROM TinNhan t " +
                "WHERE t.maHoiThoai = :maHoiThoai AND t.maNguoiGui != :maNguoiNhan AND t.daDoc = false",
                Long.class
            );
            query.setParameter("maHoiThoai", maHoiThoai);
            query.setParameter("maNguoiNhan", maNguoiNhan);
            
            Long result = query.getSingleResult();
            return result != null ? result.intValue() : 0;
        } finally {
            em.close();
        }
    }

    /**
     * Xóa tin nhắn
     */
    public boolean deleteMessage(Integer maTinNhan) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            TinNhan tinNhan = em.find(TinNhan.class, maTinNhan);
            if (tinNhan != null) {
                em.remove(tinNhan);
            }
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
}
