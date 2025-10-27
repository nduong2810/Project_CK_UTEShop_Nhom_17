package com.uteshop.dao;

import com.uteshop.entity.DonHang;
import com.uteshop.util.JPAUtil;
import com.uteshop.entity.ChiTietDonHang;
import com.uteshop.entity.ChiTietGioHang;
import com.uteshop.entity.GioHang;
import com.uteshop.entity.MaGiamGia;
import java.math.BigDecimal;
// import com.uteshop.config.DBConnect; // KHÔNG CẦN NỮA
// import com.uteshop.util.JPAUtil; // Nếu bạn dùng JPAUtil
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.PersistenceException; // Import thêm để xử lý lỗi JPA

// import java.sql.Connection; // KHÔNG CẦN NỮA
// import java.sql.PreparedStatement; // KHÔNG CẦN NỮA
// import java.sql.ResultSet; // KHÔNG CẦN NỮA
// import java.sql.SQLException; // KHÔNG CẦN NỮA
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

public class DonHangDAO {
    // Giữ nguyên cách khởi tạo trực tiếp này, giả định "uteshop-pu" đã được cấu hình.
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu"); 
    
    // Phương thức chung để lấy EntityManager
    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

	public DonHang findById(Integer id) {
		EntityManager em = getEntityManager();
		try {
			return em.find(DonHang.class, id);
		} finally {
			em.close();
		}
	}

	// New method to find a completed order by user and product
	public DonHang findCompletedOrderByUserAndProduct(Integer userId, Integer productId) {
		EntityManager em = getEntityManager();
		try {
			// Query to find orders by user and product, where order status is 'DA_GIAO'
			// (Completed)
			TypedQuery<DonHang> query = em.createQuery("SELECT dh FROM DonHang dh JOIN dh.chiTietDonHangs ctdh "
					+ "WHERE dh.nguoiDung.maND = :userId AND ctdh.sanPham.maSP = :productId AND dh.trangThai = :status",
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

    /**
     * Count all orders using JPA (JPQL)
     * @return Total number of orders
     */
	public int countAll() {
		EntityManager em = getEntityManager();
		String jpql = "SELECT COUNT(dh) FROM DonHang dh";
		try {
            // Sử dụng TypedQuery<Long> cho các truy vấn COUNT
			TypedQuery<Long> query = em.createQuery(jpql, Long.class);
			return query.getSingleResult().intValue();
		} catch (PersistenceException e) {
			// Xử lý các lỗi liên quan đến JPA
			throw new RuntimeException("Error counting all orders: " + e.getMessage(), e);
		} finally {
            em.close();
        }
	}
	public BigDecimal getMonthlyRevenue(Integer maCH, int month, int year) {
	    EntityManager em = getEntityManager();
        // Dùng tham số :status_done thay vì chuỗi cứng 'DA_GIAO'
	    String jpql = "SELECT SUM(dh.tongThanhToan) "
	                + "FROM DonHang dh "
	                + "JOIN dh.chiTietDonHangs ctdh " 
	                + "JOIN ctdh.sanPham sp "         
	                + "WHERE sp.cuaHang.maCH = :maCH " 
	                + "  AND dh.trangThai = :status_done " 
	                + "  AND FUNCTION('MONTH', dh.ngayDat) = :month "
	                + "  AND FUNCTION('YEAR', dh.ngayDat) = :year";
	    
	    try {
	        TypedQuery<BigDecimal> query = em.createQuery(jpql, BigDecimal.class);
	        query.setParameter("maCH", maCH);
            query.setParameter("status_done", DonHang.TrangThaiDonHang.DA_GIAO); // SỬA: Truyền Enum
	        query.setParameter("month", month);
	        query.setParameter("year", year);
	        
	        BigDecimal result = query.getSingleResult();
	        return result != null ? result : BigDecimal.ZERO;
	        
	    } catch (NoResultException e) {
	        return BigDecimal.ZERO;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return BigDecimal.ZERO;
	    } finally {
	        em.close();
	    }
	}
	
	public List<DonHang> findByStoreAndStatus(Integer maCH, DonHang.TrangThaiDonHang status) {
        EntityManager em = getEntityManager();
        // Cú pháp JPQL phức tạp (đa JOIN)
        String jpql = "SELECT DISTINCT dh FROM DonHang dh "
                    + "JOIN dh.chiTietDonHangs ctdh "
                    + "JOIN ctdh.sanPham sp "
                    + "WHERE sp.cuaHang.maCH = :maCH AND dh.trangThai = :status "
                    + "ORDER BY dh.ngayDat DESC";
        try {
            TypedQuery<DonHang> query = em.createQuery(jpql, DonHang.class);
            query.setParameter("maCH", maCH);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
	public boolean updateOrderStatus(Integer maDH, DonHang.TrangThaiDonHang newStatus) {
        EntityManager em = getEntityManager();
        jakarta.persistence.EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            // Lấy Entity DonHang và cập nhật trạng thái
            DonHang dh = em.find(DonHang.class, maDH);
            if (dh != null) {
                dh.setTrangThai(newStatus);
                // merge() không bắt buộc nếu Entity còn trong Persistence Context, nhưng là cách an toàn
                em.merge(dh); 
                trans.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // --- NEW: create order from cart (supports coupon code) ---
    public DonHang createOrderFromCart(Integer userId, String diaChi, String tenNguoiNhan, String sdt, String ghiChu, DonHang.PhuongThucThanhToan phuongThuc, String maGiamGiaCode) {
        EntityManager em = getEntityManager();
        jakarta.persistence.EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            // Load user's cart items
            TypedQuery<ChiTietGioHang> q = em.createQuery("SELECT ct FROM ChiTietGioHang ct JOIN FETCH ct.sanPham WHERE ct.gioHang.nguoiDung.maND = :userId", ChiTietGioHang.class);
            q.setParameter("userId", userId);
            List<ChiTietGioHang> items = q.getResultList();
            if (items == null || items.isEmpty()) {
                tx.rollback();
                return null; // nothing to order
            }

            // Calculate totals
            BigDecimal tongTien = BigDecimal.ZERO;
            for (ChiTietGioHang ct : items) {
                BigDecimal thanhTien = ct.getDonGia().multiply(BigDecimal.valueOf(ct.getSoLuong()));
                tongTien = tongTien.add(thanhTien);
            }

            BigDecimal tienGiam = BigDecimal.ZERO;
            MaGiamGia magiam = null;
            if (maGiamGiaCode != null && !maGiamGiaCode.trim().isEmpty()) {
                TypedQuery<MaGiamGia> qmg = em.createQuery("SELECT m FROM MaGiamGia m WHERE m.maSo = :code", MaGiamGia.class);
                qmg.setParameter("code", maGiamGiaCode.trim());
                try {
                    magiam = qmg.getSingleResult();
                    if (magiam != null && magiam.isValid()) {
                        tienGiam = magiam.tinhGiaTriGiam(tongTien);
                        // increment usage
                        magiam.setSoLuongDaSuDung(magiam.getSoLuongDaSuDung() + 1);
                        em.merge(magiam);
                    } else {
                        tienGiam = BigDecimal.ZERO;
                    }
                } catch (NoResultException nre) {
                    tienGiam = BigDecimal.ZERO;
                }
            }

            BigDecimal phiVC = BigDecimal.ZERO; // For simplicity
            BigDecimal tongThanhToan = tongTien.subtract(tienGiam).add(phiVC);

            // Create DonHang
            DonHang dh = new DonHang();
            dh.setNguoiDung(em.find(com.uteshop.entity.NguoiDung.class, userId));
            dh.setNgayDat(new Date());
            dh.setTongTien(tongTien);
            dh.setTienGiam(tienGiam);
            dh.setPhiVanChuyen(phiVC);
            dh.setTongThanhToan(tongThanhToan);
            dh.setPhuongThucThanhToan(phuongThuc);
            dh.setDiaChiGiaoHang(diaChi);
            dh.setTenNguoiNhan(tenNguoiNhan);
            dh.setSoDienThoaiNhanHang(sdt);
            dh.setGhiChu(ghiChu);
            dh.setTrangThai(DonHang.TrangThaiDonHang.DON_HANG_MOI);

            em.persist(dh);
            em.flush();

            // Create ChiTietDonHang for each cart item
            for (ChiTietGioHang ct : items) {
                ChiTietDonHang ctdh = new ChiTietDonHang();
                ctdh.setDonHang(dh);
                ctdh.setSanPham(ct.getSanPham());
                ctdh.setSoLuong(ct.getSoLuong());
                ctdh.setDonGia(ct.getDonGia());
                em.persist(ctdh);
            }

            // Clear cart items
            em.createQuery("DELETE FROM ChiTietGioHang ct WHERE ct.gioHang.nguoiDung.maND = :userId")
              .setParameter("userId", userId)
              .executeUpdate();

            tx.commit();
            return dh;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
	// Trong DonHangDAO.java (Phiên bản JPA)

	public long countNewOrders(Integer maCH) {
	    EntityManager em = getEntityManager();
	    
	    // Đơn hàng mới thường có trạng thái là CHUA_XAC_NHAN
	    String jpql = "SELECT COUNT(DISTINCT dh) FROM DonHang dh "
	                + "JOIN dh.chiTietDonHangs ctdh " 
	                + "JOIN ctdh.sanPham sp "         
	                + "WHERE sp.cuaHang.maCH = :maCH " 
	                + "  AND dh.trangThai = 'CHUA_XAC_NHAN'";
	    
	    try {
	        Long count = em.createQuery(jpql, Long.class)
	                     .setParameter("maCH", maCH)
	                     .getSingleResult();
	        return count != null ? count : 0L;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return 0L;
	    } finally {
	        em.close();
	    }
	}
    // Create order from single product (buy now)
    public DonHang createOrderForSingleProduct(Integer userId, Integer productId, int quantity, String diaChi, String tenNguoiNhan, String sdt, String ghiChu, DonHang.PhuongThucThanhToan phuongThuc, String maGiamGiaCode) {
        EntityManager em = getEntityManager();
        jakarta.persistence.EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            com.uteshop.entity.SanPham sp = em.find(com.uteshop.entity.SanPham.class, productId);
            if (sp == null) {
                tx.rollback();
                return null;
            }

            BigDecimal donGia = sp.getDonGia() != null ? sp.getDonGia() : BigDecimal.ZERO;
            BigDecimal tongTien = donGia.multiply(BigDecimal.valueOf(quantity));

            BigDecimal tienGiam = BigDecimal.ZERO;
            MaGiamGia magiam = null;
            if (maGiamGiaCode != null && !maGiamGiaCode.trim().isEmpty()) {
                TypedQuery<MaGiamGia> qmg = em.createQuery("SELECT m FROM MaGiamGia m WHERE m.maSo = :code", MaGiamGia.class);
                qmg.setParameter("code", maGiamGiaCode.trim());
                try {
                    magiam = qmg.getSingleResult();
                    if (magiam != null && magiam.isValid()) {
                        tienGiam = magiam.tinhGiaTriGiam(tongTien);
                        magiam.setSoLuongDaSuDung(magiam.getSoLuongDaSuDung() + 1);
                        em.merge(magiam);
                    } else {
                        tienGiam = BigDecimal.ZERO;
                    }
                } catch (NoResultException nre) {
                    tienGiam = BigDecimal.ZERO;
                }
            }

            BigDecimal phiVC = BigDecimal.ZERO;
            BigDecimal tongThanhToan = tongTien.subtract(tienGiam).add(phiVC);

            DonHang dh = new DonHang();
            dh.setNguoiDung(em.find(com.uteshop.entity.NguoiDung.class, userId));
            dh.setNgayDat(new Date());
            dh.setTongTien(tongTien);
            dh.setTienGiam(tienGiam);
            dh.setPhiVanChuyen(phiVC);
            dh.setTongThanhToan(tongThanhToan);
            dh.setPhuongThucThanhToan(phuongThuc);
            dh.setDiaChiGiaoHang(diaChi);
            dh.setTenNguoiNhan(tenNguoiNhan);
            dh.setSoDienThoaiNhanHang(sdt);
            dh.setGhiChu(ghiChu);
            dh.setTrangThai(DonHang.TrangThaiDonHang.DON_HANG_MOI);

            em.persist(dh);
            em.flush();

            ChiTietDonHang ctdh = new ChiTietDonHang();
            ctdh.setDonHang(dh);
            ctdh.setSanPham(sp);
            ctdh.setSoLuong(quantity);
            ctdh.setDonGia(donGia);
            em.persist(ctdh);

            tx.commit();
            return dh;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}