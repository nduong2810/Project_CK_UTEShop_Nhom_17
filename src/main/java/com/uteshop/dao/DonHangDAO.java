package com.uteshop.dao;

import com.uteshop.entity.DonHang;
import com.uteshop.entity.ChiTietDonHang;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class DonHangDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public DonHang findById(Integer id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(DonHang.class, id);
        } finally {
            em.close();
        }
    }

    // New method to find a completed order by user and product
    public DonHang findCompletedOrderByUserAndProduct(Integer userId, Integer productId) {
        EntityManager em = emf.createEntityManager();
        try {
            // Query to find orders by user and product, where order status is 'DA_GIAO' (Completed)
            TypedQuery<DonHang> query = em.createQuery(
                "SELECT dh FROM DonHang dh JOIN dh.chiTietDonHangs ctdh " +
                "WHERE dh.nguoiDung.maND = :userId AND ctdh.sanPham.maSP = :productId AND dh.trangThai = :status",
                DonHang.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            query.setParameter("status", DonHang.TrangThaiDonHang.DA_GIAO); // Corrected to use enum
            query.setMaxResults(1); // Get at most one order
            List<DonHang> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);
        } finally {
            em.close();
        }
    }
}
