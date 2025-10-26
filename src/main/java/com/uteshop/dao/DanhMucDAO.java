package com.uteshop.dao;

import com.uteshop.entity.DanhMuc;
import com.uteshop.util.JPAUtil; // Sử dụng JPAUtil đã tạo trước đó
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.List;

public class DanhMucDAO {

    // Phương thức chung để lấy EntityManager
    private EntityManager getEntityManager() {
        return JPAUtil.getEntityManager();
    }

    /**
     * Find category by ID
     */
    public DanhMuc findById(Integer id) {
        EntityManager em = getEntityManager();
        try {
            // Sử dụng find() là cách chuẩn và đơn giản nhất trong JPA để tìm theo Primary Key.
            return em.find(DanhMuc.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Find all active categories (TrangThai = 1 or TRUE).
     * Assumes TrangThai is mapped as a boolean or integer in the entity.
     */
    public List<DanhMuc> findAll() {
        EntityManager em = getEntityManager();
        // Giả định TrangThai được lưu là TRUE/1
        String jpql = "SELECT d FROM DanhMuc d WHERE d.trangThai = 1"; 

        try {
            // TypedQuery tự động ánh xạ kết quả truy vấn sang List<DanhMuc>
            TypedQuery<DanhMuc> query = em.createQuery(jpql, DanhMuc.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Get all active categories, ordered by name (TenDM ASC).
     */
    public List<DanhMuc> getAllCategories() {
        EntityManager em = getEntityManager();
        String jpql = "SELECT d FROM DanhMuc d WHERE d.trangThai = 1 ORDER BY d.tenDM ASC";

        try {
            TypedQuery<DanhMuc> query = em.createQuery(jpql, DanhMuc.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
