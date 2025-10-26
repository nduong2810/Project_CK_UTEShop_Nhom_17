package com.uteshop.dao;

import com.uteshop.entity.CuaHang;
import com.uteshop.util.JPAUtil;
import jakarta.persistence.*;
import java.util.List;
import java.util.ArrayList;

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

    // TÌM CỬA HÀNG THEO ID NGƯỜI DÙNG (Cho Vendor)
    public CuaHang findByUserId(Integer maND) {
        EntityManager em = JPAUtil.getEntityManager(); // Giả định có JPAUtil
        CuaHang store = null;
        try {
            // JPQL để tìm CuaHang dựa trên MaND
            String jpql = "SELECT ch FROM CuaHang ch WHERE ch.maND = :maND";
            
            TypedQuery<CuaHang> query = em.createQuery(jpql, CuaHang.class);
            query.setParameter("maND", maND);
            
            // THAY THẾ logic getSingleResult() bằng getResultList() 
            // để tránh NonUniqueResultException khi có nhiều kết quả.
            List<CuaHang> results = query.getResultList();

            if (!results.isEmpty()) {
                // Lấy bản ghi đầu tiên trong trường hợp có nhiều bản ghi trùng
                store = results.get(0); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi khác, trả về null
            return null;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
        return store;
    }

    // TÌM TẤT CẢ CỬA HÀNG (Sử dụng cho Frontend/Admin)
    public List<CuaHang> findAll() {
        EntityManager em = getEntityManager();
        // Giữ lại truy vấn phức tạp của bạn
        String jpql = "SELECT ch, SUM(CASE WHEN ctdh.soLuong IS NULL THEN 0L ELSE ctdh.soLuong END) AS TongSoLuongBan " +
                      "FROM CuaHang ch LEFT JOIN ch.sanPhams sp LEFT JOIN sp.chiTietDonHangs ctdh " +
                      "WHERE ch.trangThai = TRUE GROUP BY ch ORDER BY TongSoLuongBan DESC";
        try {
            List<Object[]> results = em.createQuery(jpql, Object[].class).getResultList();
            List<CuaHang> list = new ArrayList<>();
            for (Object[] result : results) {
                list.add((CuaHang) result[0]);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    // THÊM CỬA HÀNG (Đăng ký)
    public boolean insert(CuaHang ch) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(ch);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    // CẬP NHẬT CỬA HÀNG (Quản lý trang chủ shop)
    public boolean update(CuaHang ch) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(ch);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    public long countStores() {
        // ... (giữ nguyên)
        return 0; 
    }
}
