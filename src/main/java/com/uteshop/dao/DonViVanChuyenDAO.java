package com.uteshop.dao;

import com.uteshop.entity.DonViVanChuyen;
import com.uteshop.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.math.BigDecimal;
import java.util.List;

public class DonViVanChuyenDAO {

    // Lấy EntityManager từ JPAUtil thay vì static init
    private EntityManager getEntityManager() {
        return JPAUtil.getEntityManager();
    }

    // Lấy tất cả đơn vị vận chuyển
    public List<DonViVanChuyen> findAll() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<DonViVanChuyen> query = em.createQuery(
                    "SELECT d FROM DonViVanChuyen d ORDER BY d.phiVanChuyen ASC",
                    DonViVanChuyen.class
            );
            List<DonViVanChuyen> list = query.getResultList();
            System.out.println("✅ Loaded shipping partners: " + list.size());
            return list;
        } catch (Exception e) {
            System.err.println("❌ Error in DonViVanChuyenDAO.findAll: " + e.getMessage());
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    // Lấy theo ID
    public DonViVanChuyen findById(int maVC) {
        EntityManager em = getEntityManager();
        try {
            return em.find(DonViVanChuyen.class, maVC);
        } finally {
            em.close();
        }
    }

    // Lấy n đơn vị có phí thấp nhất
    public List<DonViVanChuyen> findCheapestShipping(int limit) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT d FROM DonViVanChuyen d ORDER BY d.phiVanChuyen ASC",
                    DonViVanChuyen.class
            ).setMaxResults(limit).getResultList();
        } finally {
            em.close();
        }
    }

    // Tính phí vận chuyển theo khoảng cách
    public BigDecimal calculateShippingFee(int maVC, double distance) {
        DonViVanChuyen dvvc = findById(maVC);
        if (dvvc == null) return BigDecimal.ZERO;
        BigDecimal baseFee = dvvc.getPhiVanChuyen();
        BigDecimal distanceFee = BigDecimal.valueOf(distance * 1000);
        return baseFee.add(distanceFee);
    }

    // Đếm tổng số đơn vị vận chuyển
    public long countShippingPartners() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(d) FROM DonViVanChuyen d", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    // Thêm mới
    public boolean insert(DonViVanChuyen dvvc) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(dvvc);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.err.println("❌ Error in DonViVanChuyenDAO.insert: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // Cập nhật
    public boolean update(DonViVanChuyen dvvc) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(dvvc);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.err.println("❌ Error in DonViVanChuyenDAO.update: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
