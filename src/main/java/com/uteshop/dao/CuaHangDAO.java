package com.uteshop.dao;

import com.uteshop.entity.CuaHang;
import com.uteshop.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class CuaHangDAO {

    public CuaHang findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(CuaHang.class, id);
        } finally {
            em.close();
        }
    }

    public CuaHang findByUserId(Integer userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<CuaHang> query = em.createQuery("SELECT c FROM CuaHang c WHERE c.nguoiDung.id = :userId", CuaHang.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            System.err.println("Không tìm thấy CuaHang cho userId: " + userId);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    public boolean insert(CuaHang cuaHang) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(cuaHang);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public List<CuaHang> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT ch FROM CuaHang ch LEFT JOIN ch.sanPhams sp LEFT JOIN sp.chiTietDonHangs ctdh " +
                          "WHERE ch.trangThai = TRUE " +
                          "GROUP BY ch " +
                          "ORDER BY SUM(ctdh.soLuong) DESC";
            TypedQuery<CuaHang> query = em.createQuery(jpql, CuaHang.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long countStores() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(c) FROM CuaHang c WHERE c.trangThai = TRUE";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}