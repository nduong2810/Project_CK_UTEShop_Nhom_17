package com.uteshop.dao;

import com.uteshop.entity.PhanCongGiaoHang;
// Phải import JPAUtil nếu nó nằm trong package com.uteshop.util
import com.uteshop.util.JPAUtil; 
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction; // Cần thiết để quản lý transaction
import jakarta.persistence.TypedQuery;

import java.time.LocalDateTime;
import java.util.List;

public class PhanCongGiaoHangDAO {



	/**
	 * Chỉ lấy lịch sử đơn hàng (đã hoàn thành/trả hàng) của một shipper.
	 * Sử dụng JOIN FETCH để tải luôn thông tin DonHang, tránh lỗi lazy loading.
	 */
	public List<PhanCongGiaoHang> findHistoryOrdersByShipperId(Integer shipperMaND) {
	    EntityManager em = JPAUtil.getEntityManager();
	    try {
	        String jpql = "SELECT p FROM PhanCongGiaoHang p JOIN FETCH p.donHang " +
	                      "WHERE p.nguoiGiao.maND = :shipperId " +
	                      "AND p.trangThai IN ('HOAN_THANH', 'TRA_HANG') " +
	                      "ORDER BY p.ngayHoanThanh DESC"; // Sắp xếp theo ngày hoàn thành gần nhất
	                      
	        TypedQuery<PhanCongGiaoHang> query = em.createQuery(jpql, PhanCongGiaoHang.class);
	        query.setParameter("shipperId", shipperMaND);
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}
	public List<PhanCongGiaoHang> findPendingOrdersByShipperId(Integer shipperMaND) {
	    EntityManager em = JPAUtil.getEntityManager();
	    try {
	        String jpql = "SELECT p FROM PhanCongGiaoHang p JOIN FETCH p.donHang " +
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
	// SỬA LẠI NHƯ SAU:
	public List<PhanCongGiaoHang> findAssignedOrdersByShipperId(Integer shipperMaND) {
	    EntityManager em = JPAUtil.getEntityManager();
	    try {
	        // Thêm JOIN FETCH p.donHang để tránh LazyInitializationException
	        String jpql = "SELECT p FROM PhanCongGiaoHang p JOIN FETCH p.donHang " +
	                      "WHERE p.nguoiGiao.maND = :shipperId";

	        TypedQuery<PhanCongGiaoHang> query = em.createQuery(jpql, PhanCongGiaoHang.class);
	        query.setParameter("shipperId", shipperMaND);
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}
    /**
     * Cập nhật trạng thái giao hàng.
     * (Thao tác Ghi - BẮT BUỘC phải dùng Transaction)
     */
    public void updateDeliveryStatus(Integer maPC, String trangThai, LocalDateTime ngayHoanThanh) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin(); // Bắt đầu giao dịch
            
            PhanCongGiaoHang pc = em.find(PhanCongGiaoHang.class, maPC);
            if (pc != null) {
                pc.setTrangThai(trangThai);
                if (ngayHoanThanh != null) {
                    pc.setNgayHoanThanh(ngayHoanThanh);
                }
                em.merge(pc);
            }
            
            transaction.commit(); // Hoàn thành giao dịch
            
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback(); // Hoàn tác nếu có lỗi
            }
            // Ném lại ngoại lệ để lớp Controller có thể bắt và xử lý redirect lỗi
            throw new RuntimeException("Cập nhật trạng thái giao hàng thất bại.", e); 
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    /**
     * Đếm số đơn hàng được giao theo trạng thái.
     * (Thao tác Đọc - Chỉ cần mở và đóng EM)
     */
    public Long countOrdersByShipperAndStatus(Integer maND, String trangThai) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Cần sửa lại query để xử lý trường hợp "Tất cả" (như trong Controller)
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
}