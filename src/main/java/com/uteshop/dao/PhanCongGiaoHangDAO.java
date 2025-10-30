package com.uteshop.dao;

import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.PhanCongGiaoHang;
import com.uteshop.util.JPAUtil; 
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.util.List;

public class PhanCongGiaoHangDAO {

    /**
     * Chỉ lấy lịch sử đơn hàng (đã hoàn thành/trả hàng) của một shipper.
     * SỬA LẠI: Thêm JOIN FETCH p.nguoiGiao để tải đầy đủ thông tin Shipper.
     */
    public List<PhanCongGiaoHang> findHistoryOrdersByShipperId(Integer shipperMaND) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM PhanCongGiaoHang p " +
                          "JOIN FETCH p.donHang " +
                          "JOIN FETCH p.nguoiGiao " + // THÊM DÒNG NÀY
                          "WHERE p.nguoiGiao.maND = :shipperId " +
                          "AND p.trangThai IN ('HOAN_THANH', 'TRA_HANG') " +
                          "ORDER BY p.ngayHoanThanh DESC";
                          
            TypedQuery<PhanCongGiaoHang> query = em.createQuery(jpql, PhanCongGiaoHang.class);
            query.setParameter("shipperId", shipperMaND);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Chỉ lấy các đơn hàng đang chờ giao của một shipper.
     * SỬA LẠI: Thêm JOIN FETCH p.nguoiGiao.
     */
    public List<PhanCongGiaoHang> findPendingOrdersByShipperId(Integer shipperMaND) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM PhanCongGiaoHang p " +
                          "JOIN FETCH p.donHang " +
                          "JOIN FETCH p.nguoiGiao " + // THÊM DÒNG NÀY
                          "WHERE p.nguoiGiao.maND = :shipperId " +
                          "AND p.trangThai NOT IN ('HOAN_THANH', 'TRA_HANG') " +
                          "ORDER BY p.ngayGiao DESC";
                          
            TypedQuery<PhanCongGiaoHang> query = em.createQuery(jpql, PhanCongGiaoHang.class);
            query.setParameter("shipperId", shipperMaND);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật trạng thái giao hàng.
     * (Phương thức này đã đúng, không cần sửa)
     */
    public void updateDeliveryStatus(Integer maPC, String trangThai, LocalDateTime ngayHoanThanh) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            
            PhanCongGiaoHang pc = em.find(PhanCongGiaoHang.class, maPC);
            if (pc != null) {
                pc.setTrangThai(trangThai);
                if (ngayHoanThanh != null) {
                    pc.setNgayHoanThanh(ngayHoanThanh);
                }
                em.merge(pc);
            }
            
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Cập nhật trạng thái giao hàng thất bại.", e); 
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    /**
     * Đếm số đơn hàng được giao theo trạng thái.
     * (Phương thức này đã đúng, không cần sửa)
     */
    public Long countOrdersByShipperAndStatus(Integer maND, String trangThai) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql;
            if ("Tất cả".equals(trangThai)) {
                jpql = "SELECT COUNT(pc) FROM PhanCongGiaoHang pc WHERE pc.nguoiGiao.maND = :maND";
            } else {
                jpql = "SELECT COUNT(pc) FROM PhanCongGiaoHang pc WHERE pc.nguoiGiao.maND = :maND AND pc.trangThai = :trangThai";
            }
            
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("maND", maND);
            
            if (!"Tất cả".equals(trangThai)) {
                query.setParameter("trangThai", trangThai);
            }
            
            return query.getSingleResult();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    // BẠN CÓ THỂ XÓA PHƯƠNG THỨC NÀY NẾU KHÔNG DÙNG ĐẾN
    // Hoặc sửa lại nó như bên dưới để an toàn
    public List<PhanCongGiaoHang> findAssignedOrdersByShipperId(Integer shipperMaND) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT p FROM PhanCongGiaoHang p " +
                          "JOIN FETCH p.donHang " +
                          "JOIN FETCH p.nguoiGiao " + // THÊM DÒNG NÀY
                          "WHERE p.nguoiGiao.maND = :shipperId";

            TypedQuery<PhanCongGiaoHang> query = em.createQuery(jpql, PhanCongGiaoHang.class);
            query.setParameter("shipperId", shipperMaND);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
 // Trong file PhanCongGiaoHangDAO.java

    public boolean assignOrderToShipper(Integer maDH, Integer shipperMaND) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();

            DonHang donHang = em.find(DonHang.class, maDH);
            NguoiDung shipper = em.find(NguoiDung.class, shipperMaND);

            // SỬA LẠI: Kiểm tra xem đơn hàng có ở trạng thái hợp lệ để nhận không
            if (donHang == null || shipper == null ||
                (donHang.getTrangThai() != DonHang.TrangThaiDonHang.DA_XAC_NHAN &&
                 donHang.getTrangThai() != DonHang.TrangThaiDonHang.DANG_CHUAN_BI)) {
                
                transaction.rollback();
                return false; // Đơn hàng không hợp lệ để nhận
            }

            // Tạo bản ghi phân công mới
            PhanCongGiaoHang phanCong = new PhanCongGiaoHang();
            phanCong.setDonHang(donHang);
            phanCong.setNguoiGiao(shipper);
            phanCong.setNgayGiao(LocalDateTime.now());
            phanCong.setTrangThai("DANG_GIAO");
            em.persist(phanCong);

            // Cập nhật trạng thái của DonHang thành DANG_GIAO
            donHang.setTrangThai(DonHang.TrangThaiDonHang.DANG_GIAO);
            em.merge(donHang);

            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}