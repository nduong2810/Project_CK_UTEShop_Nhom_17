package com.uteshop.dao;

import com.uteshop.entity.HoiThoai;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.Date;
import java.util.List;

public class HoiThoaiDAO {
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    /**
     * Tìm hoặc tạo hội thoại giữa khách hàng và cửa hàng
     */
    public HoiThoai findOrCreateConversation(Integer maKhachHang, Integer maCuaHang) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<HoiThoai> query = em.createQuery(
                "SELECT h FROM HoiThoai h WHERE h.maKhachHang = :maKhachHang AND h.maCuaHang = :maCuaHang",
                HoiThoai.class
            );
            query.setParameter("maKhachHang", maKhachHang);
            query.setParameter("maCuaHang", maCuaHang);
            
            List<HoiThoai> results = query.getResultList();
            
            if (!results.isEmpty()) {
                return results.get(0);
            }
            
            // Tạo hội thoại mới
            em.getTransaction().begin();
            HoiThoai hoiThoai = new HoiThoai();
            hoiThoai.setMaKhachHang(maKhachHang);
            hoiThoai.setMaCuaHang(maCuaHang);
            hoiThoai.setNgayTaoHoiThoai(new Date());
            hoiThoai.setNgayCapNhat(new Date());
            hoiThoai.setSoTinNhanChuaDoc(0);
            hoiThoai.setTrangThai(true);
            em.persist(hoiThoai);
            em.getTransaction().commit();
            
            return hoiThoai;
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
     * Lấy tất cả hội thoại của người dùng
     */
    public List<HoiThoai> getConversationsByUserId(Integer maNguoiDung) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<HoiThoai> query = em.createQuery(
                "SELECT DISTINCT h FROM HoiThoai h " +
                "LEFT JOIN FETCH h.khachHang " +
                "LEFT JOIN FETCH h.cuaHang " +
                "WHERE (h.maKhachHang = :maNguoiDung OR " +
                "       h.maCuaHang IN (SELECT c.maCH FROM CuaHang c WHERE c.maND = :maNguoiDung)) " +
                "AND h.trangThai = true " +
                "ORDER BY h.ngayCapNhat DESC",
                HoiThoai.class
            );
            query.setParameter("maNguoiDung", maNguoiDung);
            
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật tin nhắn cuối cùng
     */
    public void updateLastMessage(Integer maHoiThoai, String tinNhanCuoi, Integer maNguoiGui) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            HoiThoai hoiThoai = em.find(HoiThoai.class, maHoiThoai);
            if (hoiThoai != null) {
                hoiThoai.setTinNhanCuoi(tinNhanCuoi);
                hoiThoai.setNgayCapNhat(new Date());
                hoiThoai.setNguoiGuiCuoi(maNguoiGui);
                em.merge(hoiThoai);
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
     * Tăng số tin nhắn chưa đọc
     */
    public void incrementUnreadCount(Integer maHoiThoai) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            HoiThoai hoiThoai = em.find(HoiThoai.class, maHoiThoai);
            if (hoiThoai != null) {
                hoiThoai.setSoTinNhanChuaDoc(hoiThoai.getSoTinNhanChuaDoc() + 1);
                em.merge(hoiThoai);
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
     * Reset số tin nhắn chưa đọc
     */
    public void resetUnreadCount(Integer maHoiThoai) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            HoiThoai hoiThoai = em.find(HoiThoai.class, maHoiThoai);
            if (hoiThoai != null) {
                hoiThoai.setSoTinNhanChuaDoc(0);
                em.merge(hoiThoai);
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
     * Lấy hội thoại theo ID
     */
    public HoiThoai getConversationById(Integer maHoiThoai) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<HoiThoai> query = em.createQuery(
                "SELECT h FROM HoiThoai h " +
                "LEFT JOIN FETCH h.khachHang " +
                "LEFT JOIN FETCH h.cuaHang ch " +
                "LEFT JOIN FETCH ch.nguoiDung " +
                "WHERE h.maHoiThoai = :maHoiThoai",
                HoiThoai.class
            );
            query.setParameter("maHoiThoai", maHoiThoai);
            
            List<HoiThoai> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tổng số tin nhắn chưa đọc của người dùng
     */
    public int getTotalUnreadCount(Integer maNguoiDung) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT SUM(h.soTinNhanChuaDoc) FROM HoiThoai h " +
                "WHERE (h.maKhachHang = :maNguoiDung OR " +
                "       h.maCuaHang IN (SELECT c.maCH FROM CuaHang c WHERE c.maND = :maNguoiDung)) " +
                "AND h.trangThai = true",
                Long.class
            );
            query.setParameter("maNguoiDung", maNguoiDung);
            
            Long result = query.getSingleResult();
            return result != null ? result.intValue() : 0;
        } finally {
            em.close();
        }
    }
}
