package com.uteshop.dao;

import com.uteshop.entity.CuaHang;
import com.uteshop.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class CuaHangDAO {

    private EntityManager getEntityManager() {
        return JPAUtil.getEntityManager();
    }

    public CuaHang findById(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(CuaHang.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Tìm CuaHang dựa trên ID của NguoiDung (userId/maTK).
     * @param userId ID của người dùng (MaND/MaTK)
     * @return CuaHang của người dùng đó, hoặc null nếu không tìm thấy.
     */
    public CuaHang findByUserId(Integer userId) {
        EntityManager em = getEntityManager();
        try {
            // 🛑 ĐÃ SỬA: Thống nhất JPQL. Giả định Entity CuaHang có mối quan hệ 'nguoiDung' 
            // và ID của người dùng là 'maND' (hoặc 'id'). Tôi chọn 'maND' để tránh nhầm lẫn.
            // Nếu lỗi UnknownPathException xảy ra, hãy kiểm tra lại tên trường khóa ngoại 
            // chính xác của bạn trong CuaHang Entity (ví dụ: c.nguoiDung.maND).
            TypedQuery<CuaHang> query = em.createQuery("SELECT c FROM CuaHang c WHERE c.nguoiDung.maND = :userId", CuaHang.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            System.err.println("Không tìm thấy CuaHang cho userId: " + userId);
            return null;
        } catch (Exception e) {
            // Lỗi NonUniqueResultException hoặc các lỗi khác
            System.err.println("Lỗi tìm CuaHang cho userId " + userId + ": " + e.getMessage());
            return null;
        } finally {
            em.close();
        }
    }
    
    // 🛑 ĐÃ XÓA: Phương thức findByAccountId (Integer maTK) bị lỗi JPQL và trùng lặp mục đích với findByUserId.
    // Nếu Controller của bạn cần nó, hãy sửa lại để gọi findByUserId.

    public boolean insert(CuaHang cuaHang) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(cuaHang);
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
    
    /**
     * Cập nhật thông tin cửa hàng
     */
    public boolean update(CuaHang cuaHang) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(cuaHang);
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

    public List<CuaHang> findAll() {
        EntityManager em = getEntityManager();
        try {
            // Cần cẩn thận với JOIN và SUM trong findAll, nếu không có dữ liệu sẽ trả về 0.
            // Nếu bạn muốn hiển thị tất cả cửa hàng đang hoạt động, hãy đơn giản hóa truy vấn.
            String jpql = "SELECT ch FROM CuaHang ch WHERE ch.trangThai = TRUE"; 
            TypedQuery<CuaHang> query = em.createQuery(jpql, CuaHang.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long countStores() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(c) FROM CuaHang c WHERE c.trangThai = TRUE";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
