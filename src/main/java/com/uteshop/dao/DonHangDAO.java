package com.uteshop.dao;

import com.uteshop.entity.DonHang;
import com.uteshop.entity.DonHang.TrangThaiDonHang;
import com.uteshop.util.JPAUtil;
import com.uteshop.entity.ChiTietDonHang;
import com.uteshop.entity.ChiTietDonHangPK;
import com.uteshop.entity.NguoiDung;
import java.math.BigDecimal;
import java.util.Date;

// import com.uteshop.config.DBConnect; // KHÔNG CẦN NỮA
// import com.uteshop.util.JPAUtil; // Nếu bạn dùng JPAUtil
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.PersistenceException; // Import thêm để xử lý lỗi JPA

import java.util.ArrayList;
// import java.sql.Connection; // KHÔNG CẦN NỮA
// import java.sql.PreparedStatement; // KHÔNG CẦN NỮA
// import java.sql.ResultSet; // KHÔNG CẦN NỮA
// import java.sql.SQLException; // KHÔNG CẦN NỮA
import java.util.List;

public class DonHangDAO {
	// Giữ nguyên cách khởi tạo trực tiếp này, giả định "uteshop-pu" đã được cấu
	// hình.
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

	// Phương thức chung để lấy EntityManager
	private EntityManager getEntityManager() {
		return emf.createEntityManager();
	}

	/**
	 * Lấy đơn hàng theo ID với EAGER loading cho chi tiết đơn hàng
	 */
	public DonHang findById(Integer id) {
		EntityManager em = getEntityManager();
		try {
			// ✅ FIX: Use JPQL with JOIN FETCH to eagerly load chiTietDonHangs
			String jpql = "SELECT DISTINCT dh FROM DonHang dh " +
						  "LEFT JOIN FETCH dh.chiTietDonHangs ctdh " +
						  "LEFT JOIN FETCH ctdh.sanPham sp " +
						  "LEFT JOIN FETCH sp.cuaHang ch " +
						  "LEFT JOIN FETCH dh.nguoiDung nd " +
						  "WHERE dh.maDH = :id";
			
			TypedQuery<DonHang> query = em.createQuery(jpql, DonHang.class);
			query.setParameter("id", id);
			
			List<DonHang> results = query.getResultList();
			
			if (results.isEmpty()) {
				System.out.println("⚠️ Order #" + id + " not found");
				return null;
			}
			
			DonHang order = results.get(0);
			
			// ✅ Force initialization of collections to avoid lazy loading issues
			if (order.getChiTietDonHangs() != null) {
				order.getChiTietDonHangs().size();
			}
			
			System.out.println("✅ Loaded order #" + id + " with " + 
				(order.getChiTietDonHangs() != null ? order.getChiTietDonHangs().size() : 0) + " items");
			
			return order;
		} catch (Exception e) {
			System.err.println("❌ Error loading order #" + id + ": " + e.getMessage());
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy tất cả đơn hàng của user theo thời gian đặt (mới nhất trước)
	 */
	public List<DonHang> findByUser(Integer userId) {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT dh FROM DonHang dh " +
						  "LEFT JOIN FETCH dh.chiTietDonHangs ctdh " +
						  "LEFT JOIN FETCH ctdh.sanPham sp " +
						  "WHERE dh.nguoiDung.maND = :userId " +
						  "ORDER BY dh.ngayDat DESC";
			
			TypedQuery<DonHang> query = em.createQuery(jpql, DonHang.class);
			query.setParameter("userId", userId);
			
			List<DonHang> orders = query.getResultList();
			System.out.println("📦 Found " + orders.size() + " orders for user #" + userId);
			
			// ✅ DEBUG: Log discount values
			for (DonHang order : orders) {
				System.out.println("   Order #" + order.getMaDH() + 
					" - TongTien: " + order.getTongTien() + 
					", TienGiam: " + order.getTienGiam() + 
					", PhiVanChuyen: " + order.getPhiVanChuyen() + 
					", TongThanhToan: " + order.getTongThanhToan());
			}
			
			return orders;
		} catch (Exception e) {
			System.err.println("❌ Error finding orders for user #" + userId + ": " + e.getMessage());
			e.printStackTrace();
			return new ArrayList<>();
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
	 * 
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
		// Tính doanh thu cho cả đơn hàng DA_GIAO và HOAN_THANH - Fixed for SQL Server
		String jpql = "SELECT SUM(dh.tongThanhToan) " + "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH "
				+ "  AND (dh.trangThai = :status_da_giao OR dh.trangThai = :status_hoan_thanh) "
				+ "  AND MONTH(dh.ngayDat) = :month " + "  AND YEAR(dh.ngayDat) = :year";

		try {
			TypedQuery<BigDecimal> query = em.createQuery(jpql, BigDecimal.class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_da_giao", DonHang.TrangThaiDonHang.DA_GIAO);
			query.setParameter("status_hoan_thanh", DonHang.TrangThaiDonHang.HOAN_THANH);
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
		String jpql = "SELECT DISTINCT dh FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh " + "JOIN ctdh.sanPham sp "
				+ "WHERE sp.cuaHang.maCH = :maCH AND dh.trangThai = :status " + "ORDER BY dh.ngayDat DESC";
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
				// merge() không bắt buộc nếu Entity còn trong Persistence Context, nhưng là
				// cách an toàn
				em.merge(dh);
				trans.commit();
				return true;
			}
			return false;
		} catch (Exception e) {
			if (trans.isActive())
				trans.rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}
	// Trong DonHangDAO.java (Phiên bản JPA)

	public long countNewOrders(Integer maCH) {
		EntityManager em = getEntityManager();

		// Đơn hàng mới có trạng thái CHO_XAC_NHAN
		String jpql = "SELECT COUNT(DISTINCT dh) FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH " + "  AND dh.trangThai = :status";

		try {
			Long count = em.createQuery(jpql, Long.class)
					.setParameter("maCH", maCH)
					.setParameter("status", TrangThaiDonHang.CHO_XAC_NHAN)
					.getSingleResult();
			return count != null ? count : 0L;
		} catch (Exception e) {
			e.printStackTrace();
			return 0L;
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy danh sách đơn hàng của cửa hàng với phân trang và lọc theo trạng thái
	 * Fixed: Avoid HHH90003004 warning and SQL Server DISTINCT + ORDER BY issue
	 */
	public List<DonHang> findByStoreWithPagination(Integer maCH, DonHang.TrangThaiDonHang status, int page, int size) {
		EntityManager em = getEntityManager();
		try {
			System.out.println("🔍 Finding orders for store #" + maCH + ", status: " + status + ", page: " + page);
			
			// Step 1: Get order IDs with pagination
			// Fix: Include ngayDat in SELECT when using ORDER BY ngayDat with DISTINCT
			String idJpql = "SELECT DISTINCT dh.maDH, dh.ngayDat FROM DonHang dh " + 
							"JOIN dh.chiTietDonHangs ctdh " +
							"JOIN ctdh.sanPham sp " + 
							"WHERE sp.cuaHang.maCH = :maCH";

			if (status != null) {
				idJpql += " AND dh.trangThai = :status";
			}

			idJpql += " ORDER BY dh.ngayDat DESC";

			TypedQuery<Object[]> idQuery = em.createQuery(idJpql, Object[].class);
			idQuery.setParameter("maCH", maCH);

			if (status != null) {
				idQuery.setParameter("status", status);
			}

			idQuery.setFirstResult((page - 1) * size);
			idQuery.setMaxResults(size);

			List<Object[]> results = idQuery.getResultList();
			
			if (results.isEmpty()) {
				System.out.println("✅ No orders found");
				return new ArrayList<>();
			}

			// Extract order IDs from results
			List<Integer> orderIds = new ArrayList<>();
			for (Object[] result : results) {
				orderIds.add((Integer) result[0]);
			}

			System.out.println("✅ Found " + orderIds.size() + " order IDs, now fetching details...");
			
			// Step 2: Fetch full order details for those IDs (with JOIN FETCH, no pagination)
			String detailJpql = "SELECT DISTINCT dh FROM DonHang dh " + 
								"LEFT JOIN FETCH dh.chiTietDonHangs ctdh " +
								"LEFT JOIN FETCH ctdh.sanPham sp " + 
								"LEFT JOIN FETCH sp.cuaHang ch " + 
								"LEFT JOIN FETCH dh.nguoiDung nd " +
								"WHERE dh.maDH IN :orderIds " +
								"ORDER BY dh.ngayDat DESC";

			TypedQuery<DonHang> detailQuery = em.createQuery(detailJpql, DonHang.class);
			detailQuery.setParameter("orderIds", orderIds);

			List<DonHang> orders = detailQuery.getResultList();
			System.out.println("✅ Loaded " + orders.size() + " orders with full details");
			return orders;
			
		} catch (Exception e) {
			System.err.println("❌ Error in findByStoreWithPagination: " + e.getMessage());
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	/**
	 * Đếm tổng số đơn hàng của cửa hàng theo trạng thái
	 */
	public long countByStoreAndStatus(Integer maCH, DonHang.TrangThaiDonHang status) {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT COUNT(DISTINCT dh) FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
					+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH";

			if (status != null) {
				jpql += " AND dh.trangThai = :status";
			}

			TypedQuery<Long> query = em.createQuery(jpql, Long.class);
			query.setParameter("maCH", maCH);

			if (status != null) {
				query.setParameter("status", status);
			}

			Long result = query.getSingleResult();
			return result != null ? result : 0L;
		} catch (Exception e) {
			System.err.println("❌ Error in countByStoreAndStatus: " + e.getMessage());
			e.printStackTrace();
			return 0L;
		} finally {
			em.close();
		}
	}

	/**
	 * Thống kê số lượng đơn hàng theo từng trạng thái của cửa hàng
	 */
	public java.util.Map<DonHang.TrangThaiDonHang, Long> getOrderStatsByStore(Integer maCH) {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT dh.trangThai, COUNT(DISTINCT dh) FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
					+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH " + "GROUP BY dh.trangThai";

			TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
			query.setParameter("maCH", maCH);

			List<Object[]> results = query.getResultList();
			java.util.Map<DonHang.TrangThaiDonHang, Long> stats = new java.util.HashMap<>();

			// Khởi tạo tất cả trạng thái với giá trị 0
			for (DonHang.TrangThaiDonHang status : DonHang.TrangThaiDonHang.values()) {
				stats.put(status, 0L);
			}

			// Cập nhật với dữ liệu thực tế
			for (Object[] result : results) {
				DonHang.TrangThaiDonHang status = (DonHang.TrangThaiDonHang) result[0];
				Long count = (Long) result[1];
				stats.put(status, count);
			}

			return stats;
		} catch (Exception e) {
			System.err.println("❌ Error in getOrderStatsByStore: " + e.getMessage());
			e.printStackTrace();
			// Return empty map with zeros
			java.util.Map<DonHang.TrangThaiDonHang, Long> stats = new java.util.HashMap<>();
			for (DonHang.TrangThaiDonHang status : DonHang.TrangThaiDonHang.values()) {
				stats.put(status, 0L);
			}
			return stats;
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy doanh thu theo ngày cụ thể
	 * Fixed: Use DAY/MONTH/YEAR functions properly for SQL Server
	 */
	public BigDecimal getDailyRevenue(Integer maCH, int day, int month, int year) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT SUM(dh.tongThanhToan) " + "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH "
				+ "  AND (dh.trangThai = :status_da_giao OR dh.trangThai = :status_hoan_thanh) "
				+ "  AND DAY(dh.ngayDat) = :day " + "  AND MONTH(dh.ngayDat) = :month "
				+ "  AND YEAR(dh.ngayDat) = :year";

		try {
			TypedQuery<BigDecimal> query = em.createQuery(jpql, BigDecimal.class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_da_giao", DonHang.TrangThaiDonHang.DA_GIAO);
			query.setParameter("status_hoan_thanh", DonHang.TrangThaiDonHang.HOAN_THANH);
			query.setParameter("day", day);
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

	/**
	 * Lấy doanh thu theo năm - Fixed for SQL Server
	 */
	public BigDecimal getYearlyRevenue(Integer maCH, int year) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT SUM(dh.tongThanhToan) " + "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH "
				+ "  AND (dh.trangThai = :status_da_giao OR dh.trangThai = :status_hoan_thanh) "
				+ "  AND YEAR(dh.ngayDat) = :year";

		try {
			TypedQuery<BigDecimal> query = em.createQuery(jpql, BigDecimal.class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_da_giao", DonHang.TrangThaiDonHang.DA_GIAO);
			query.setParameter("status_hoan_thanh", DonHang.TrangThaiDonHang.HOAN_THANH);
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

	/**
	 * Lấy doanh thu 7 ngày gần nhất
	 * Fixed: Accept startDate parameter to avoid HQL date arithmetic error
	 */
	public List<Object[]> getLast7DaysRevenue(Integer maCH) {
		EntityManager em = getEntityManager();
		try {
			// Calculate 7 days ago in Java
			java.time.LocalDate sevenDaysAgo = java.time.LocalDate.now().minusDays(7);
			java.sql.Date sqlStartDate = java.sql.Date.valueOf(sevenDaysAgo);
			
			// Query to get revenue data - Use parameter instead of HQL date arithmetic
			String jpql = "SELECT CAST(dh.ngayDat AS date) as orderDate, SUM(dh.tongThanhToan) " + "FROM DonHang dh "
					+ "JOIN dh.chiTietDonHangs ctdh " + "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH "
					+ "  AND (dh.trangThai = :status_da_giao OR dh.trangThai = :status_hoan_thanh) "
					+ "  AND dh.ngayDat >= :startDate "
					+ "GROUP BY CAST(dh.ngayDat AS date) " + "ORDER BY CAST(dh.ngayDat AS date) ASC";

			TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_da_giao", DonHang.TrangThaiDonHang.DA_GIAO);
			query.setParameter("status_hoan_thanh", DonHang.TrangThaiDonHang.HOAN_THANH);
			query.setParameter("startDate", sqlStartDate);

			List<Object[]> results = query.getResultList();
			
			// Create a map of date -> revenue for easy lookup
			java.util.Map<String, BigDecimal> revenueMap = new java.util.HashMap<>();
			for (Object[] result : results) {
				java.sql.Date date = (java.sql.Date) result[0];
				BigDecimal revenue = (BigDecimal) result[1];
				revenueMap.put(date.toString(), revenue);
			}
			
			// Generate all 7 days with revenue (0 if no data)
			List<Object[]> allDays = new java.util.ArrayList<>();
			java.time.LocalDate today = java.time.LocalDate.now();
			
			for (int i = 6; i >= 0; i--) {
				java.time.LocalDate date = today.minusDays(i);
				String dateStr = date.toString();
				BigDecimal revenue = revenueMap.getOrDefault(dateStr, BigDecimal.ZERO);
				
				// Format date as dd/MM
				String displayDate = String.format("%02d/%02d", date.getDayOfMonth(), date.getMonthValue());
				allDays.add(new Object[]{displayDate, revenue});
			}
			
			return allDays;
		} catch (Exception e) {
			System.err.println("❌ Error in getLast7DaysRevenue: " + e.getMessage());
			e.printStackTrace();
			
			// Return 7 days with zero revenue as fallback
			List<Object[]> fallback = new java.util.ArrayList<>();
			java.time.LocalDate today = java.time.LocalDate.now();
			for (int i = 6; i >= 0; i--) {
				java.time.LocalDate date = today.minusDays(i);
				String displayDate = String.format("%02d/%02d", date.getDayOfMonth(), date.getMonthValue());
				fallback.add(new Object[]{displayDate, BigDecimal.ZERO});
			}
			return fallback;
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy doanh thu 12 tháng gần nhất
	 */
	/**
	 * Lấy doanh thu 12 tháng gần nhất
	 * Fixed: Accept startDate parameter to avoid HQL date arithmetic error
	 * Improved: Returns all 12 months with 0 revenue for months without orders
	 */
	public List<Object[]> getLast12MonthsRevenue(Integer maCH) {
		EntityManager em = getEntityManager();
		try {
			// Calculate 12 months ago in Java
			java.time.LocalDate twelveMonthsAgo = java.time.LocalDate.now().minusMonths(12);
			java.sql.Date sqlStartDate = java.sql.Date.valueOf(twelveMonthsAgo);
			
			// Query to get revenue data - Use parameter instead of HQL date arithmetic
			String jpql = "SELECT YEAR(dh.ngayDat), MONTH(dh.ngayDat), SUM(dh.tongThanhToan) "
					+ "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh " + "JOIN ctdh.sanPham sp "
					+ "WHERE sp.cuaHang.maCH = :maCH "
					+ "  AND (dh.trangThai = :status_da_giao OR dh.trangThai = :status_hoan_thanh) "
					+ "  AND dh.ngayDat >= :startDate "
					+ "GROUP BY YEAR(dh.ngayDat), MONTH(dh.ngayDat) "
					+ "ORDER BY YEAR(dh.ngayDat) ASC, MONTH(dh.ngayDat) ASC";

			TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_da_giao", DonHang.TrangThaiDonHang.DA_GIAO);
			query.setParameter("status_hoan_thanh", DonHang.TrangThaiDonHang.HOAN_THANH);
			query.setParameter("startDate", sqlStartDate);

			List<Object[]> results = query.getResultList();
			
			// Create a map of year-month -> revenue for easy lookup
			java.util.Map<String, BigDecimal> revenueMap = new java.util.HashMap<>();
			for (Object[] result : results) {
				Integer year = (Integer) result[0];
				Integer month = (Integer) result[1];
				BigDecimal revenue = (BigDecimal) result[2];
				String key = year + "-" + month;
				revenueMap.put(key, revenue);
			}
			
			// Generate all 12 months with revenue (0 if no data)
			List<Object[]> allMonths = new java.util.ArrayList<>();
			java.time.LocalDate today = java.time.LocalDate.now();
			
			for (int i = 11; i >= 0; i--) {
				java.time.LocalDate date = today.minusMonths(i);
				int year = date.getYear();
				int month = date.getMonthValue();
				String key = year + "-" + month;
				BigDecimal revenue = revenueMap.getOrDefault(key, BigDecimal.ZERO);
				
				allMonths.add(new Object[]{year, month, revenue});
			}
			
			System.out.println("✅ Generated 12 months revenue data for store #" + maCH);
			return allMonths;
		} catch (Exception e) {
			System.err.println("❌ Error in getLast12MonthsRevenue: " + e.getMessage());
			e.printStackTrace();
			
			// Return 12 months with zero revenue as fallback
			List<Object[]> fallback = new java.util.ArrayList<>();
			java.time.LocalDate today = java.time.LocalDate.now();
			for (int i = 11; i >= 0; i--) {
				java.time.LocalDate date = today.minusMonths(i);
				fallback.add(new Object[]{date.getYear(), date.getMonthValue(), BigDecimal.ZERO});
			}
			return fallback;
		} finally {
			em.close();
		}
	}

	/**
	 * Cập nhật trạng thái đơn hàng (chỉ vendor có quyền cập nhật đơn hàng của cửa
	 * hàng mình)
	 */
	public boolean updateOrderStatusByStore(Integer maDH, Integer maCH, DonHang.TrangThaiDonHang newStatus) {
		EntityManager em = getEntityManager();
		try {
			em.getTransaction().begin();

			// Kiểm tra đơn hàng có thuộc cửa hàng không
			String checkJpql = "SELECT COUNT(dh) FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
					+ "JOIN ctdh.sanPham sp " + "WHERE dh.maDH = :maDH AND sp.cuaHang.maCH = :maCH";

			TypedQuery<Long> checkQuery = em.createQuery(checkJpql, Long.class);
			checkQuery.setParameter("maDH", maDH);
			checkQuery.setParameter("maCH", maCH);

			if (checkQuery.getSingleResult() == 0) {
				em.getTransaction().rollback();
				return false; // Đơn hàng không thuộc cửa hàng này
			}

			// Cập nhật trạng thái
			String updateJpql = "UPDATE DonHang dh SET dh.trangThai = :newStatus, dh.ngayCapNhat = CURRENT_TIMESTAMP "
					+ "WHERE dh.maDH = :maDH";

			int updated = em.createQuery(updateJpql).setParameter("newStatus", newStatus).setParameter("maDH", maDH)
					.executeUpdate();

			em.getTransaction().commit();
			return updated > 0;
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
	 * Lấy chi tiết đơn hàng của cửa hàng
	 * Fixed: Correctly check if order belongs to vendor's store
	 */
	public DonHang findByIdAndStore(Integer maDH, Integer maCH) {
		EntityManager em = getEntityManager();
		try {
			System.out.println("🔍 Finding order #" + maDH + " for store #" + maCH);
			
			// First, check if this order contains products from this store
			String checkJpql = "SELECT COUNT(DISTINCT ctdh.sanPham.maSP) FROM ChiTietDonHang ctdh " +
							   "WHERE ctdh.donHang.maDH = :maDH AND ctdh.sanPham.cuaHang.maCH = :maCH";
			
			TypedQuery<Long> checkQuery = em.createQuery(checkJpql, Long.class);
			checkQuery.setParameter("maDH", maDH);
			checkQuery.setParameter("maCH", maCH);
			
			Long productCount = checkQuery.getSingleResult();
			
			// If no products from this store in the order, return null
			if (productCount == null || productCount == 0) {
				System.out.println("⚠️ Order #" + maDH + " không có sản phẩm từ cửa hàng #" + maCH);
				return null;
			}
			
			System.out.println("✅ Order #" + maDH + " has " + productCount + " products from store #" + maCH);
			
			// Now fetch the order with all details - using multiple queries to avoid MultipleBagFetchException
			String jpql = "SELECT DISTINCT dh FROM DonHang dh " +
						  "LEFT JOIN FETCH dh.nguoiDung nd " +
						  "WHERE dh.maDH = :maDH";

			TypedQuery<DonHang> query = em.createQuery(jpql, DonHang.class);
			query.setParameter("maDH", maDH);

			List<DonHang> results = query.getResultList();
			
			if (results.isEmpty()) {
				System.out.println("⚠️ Order #" + maDH + " not found");
				return null;
			}
			
			DonHang order = results.get(0);
			
			// Fetch order items separately to avoid lazy loading issues
			String itemsJpql = "SELECT DISTINCT ctdh FROM ChiTietDonHang ctdh " +
							   "LEFT JOIN FETCH ctdh.sanPham sp " +
							   "LEFT JOIN FETCH sp.cuaHang ch " +
							   "WHERE ctdh.donHang.maDH = :maDH";
			
			TypedQuery<ChiTietDonHang> itemsQuery = em.createQuery(itemsJpql, ChiTietDonHang.class);
			itemsQuery.setParameter("maDH", maDH);
			
			List<ChiTietDonHang> items = itemsQuery.getResultList();
			
			// Manually initialize the collection to avoid lazy loading issues
			if (order.getChiTietDonHangs() != null) {
				order.getChiTietDonHangs().size(); // Force initialization
			}
			
			// ✅ DEBUG: Log order financial details
			System.out.println("✅ Successfully loaded order #" + maDH + " with " + items.size() + " items");
			System.out.println("   💰 Financial Details:");
			System.out.println("      TongTien: " + order.getTongTien());
			System.out.println("      TienGiam: " + order.getTienGiam());
			System.out.println("      PhiVanChuyen: " + order.getPhiVanChuyen());
			System.out.println("      TongThanhToan: " + order.getTongThanhToan());
			
			return order;
			
		} catch (Exception e) {
			System.err.println("❌ Error finding order #" + maDH + " for store #" + maCH + ": " + e.getMessage());
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	public List<DonHang> findPaged(String q, // từ khóa: tên, email, mã đơn
			DonHang.TrangThaiDonHang status, // trạng thái đơn
			Date from, // ngày đặt từ
			Date to, // ngày đặt đến (<= 23:59:59 cùng ngày)
			int page, // trang
			int pageSize, // kích thước trang
			String sort // id_desc | id_asc | date_desc | date_asc | total_desc | total_asc | status_* |
						// customer_*
	) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT d FROM DonHang d JOIN FETCH d.nguoiDung n WHERE 1=1 ");

			// ---- Filters
			boolean hasKw = (q != null && !q.isBlank());
			if (hasKw) {
				jpql.append(" AND (LOWER(n.hoTen) LIKE :kw ").append(" OR LOWER(n.email) LIKE :kw ")
						.append(" OR CAST(d.maDH AS string) LIKE :kw) ");
			}
			if (status != null) {
				jpql.append(" AND d.trangThai = :st ");
			}
			if (from != null) {
				jpql.append(" AND d.ngayDat >= :from ");
			}
			if (to != null) {
				jpql.append(" AND d.ngayDat < :toNext "); // < (to + 1 day)
			}

			// ---- Sort
			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "id_asc" -> jpql.append(" d.maDH ASC ");
			case "date_desc" -> jpql.append(" d.ngayDat DESC ");
			case "date_asc" -> jpql.append(" d.ngayDat ASC ");
			case "total_desc" -> jpql.append(" d.tongThanhToan DESC ");
			case "total_asc" -> jpql.append(" d.tongThanhToan ASC ");
			case "status_asc" -> jpql.append(" d.trangThai ASC, d.maDH DESC ");
			case "status_desc" -> jpql.append(" d.trangThai DESC, d.maDH DESC ");
			case "customer_asc" -> jpql.append(" n.hoTen ASC, d.maDH DESC ");
			case "customer_desc" -> jpql.append(" n.hoTen DESC, d.maDH DESC ");
			default -> jpql.append(" d.maDH DESC "); // id_desc
			}

			TypedQuery<DonHang> query = em.createQuery(jpql.toString(), DonHang.class);

			// ---- Bind params
			if (hasKw) {
				String kw = "%" + q.toLowerCase().trim() + "%";
				query.setParameter("kw", kw);
			}
			if (status != null)
				query.setParameter("st", status);
			if (from != null)
				query.setParameter("from", from);
			if (to != null)
				query.setParameter("toNext", new Date(to.getTime() + 24L * 60 * 60 * 1000));

			// ---- Paging
			int first = Math.max(0, (page - 1) * pageSize);
			query.setFirstResult(first);
			query.setMaxResults(pageSize);

			return query.getResultList();
		} finally {
			em.close();
		}
	}

	private String safeSort(String sort) {
		if (sort == null || sort.isBlank())
			return "id_desc";
		return switch (sort) {
		case "id_asc", "id_desc", "date_asc", "date_desc", "total_asc", "total_desc", "status_asc", "status_desc",
				"customer_asc", "customer_desc" ->
			sort;
		default -> "id_desc";
		};
	}

	/** Đếm tổng dòng theo cùng bộ lọc */
	public int countAll(String q, TrangThaiDonHang status, Date from, Date to) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(d) FROM DonHang d JOIN d.nguoiDung n WHERE 1=1 ");

			if (q != null && !q.isBlank()) {
				jpql.append(
						" AND (LOWER(n.hoTen) LIKE :kw OR LOWER(n.email) LIKE :kw OR CAST(d.maDH AS string) LIKE :kw) ");
			}
			if (status != null) {
				jpql.append(" AND d.trangThai = :st ");
			}
			if (from != null) {
				jpql.append(" AND d.ngayDat >= :from ");
			}
			if (to != null) {
				jpql.append(" AND d.ngayDat < :toNext ");
			}

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (q != null && !q.isBlank()) {
				String kw = "%" + q.toLowerCase().trim() + "%";
				query.setParameter("kw", kw);
			}
			if (status != null)
				query.setParameter("st", status);
			if (from != null)
				query.setParameter("from", from);
			if (to != null)
				query.setParameter("toNext", new Date(to.getTime() + 24L * 60 * 60 * 1000));

			Long c = query.getSingleResult();
			return (c == null) ? 0 : c.intValue();
		} finally {
			em.close();
		}
	}

	public boolean updateStatus(int maDH, TrangThaiDonHang newStatus) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			DonHang d = em.find(DonHang.class, maDH);
			if (d == null) {
				tx.rollback();
				return false;
			}
			d.setTrangThai(newStatus);
			d.setNgayCapNhat(new Date());
			em.merge(d);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx.isActive())
				tx.rollback();
			throw e;
		} finally {
			em.close();
		}
	}

	/**
	 * Map tham số string trên UI về enum (chấp nhận cả tiếng Việt lẫn enum name)
	 */
	public TrangThaiDonHang mapStatus(String s) {
		if (s == null || s.isBlank())
			return null;
		String x = s.trim();
		// Cho phép nhập label tiếng Việt
		switch (x.toLowerCase()) {
		case "chờ xác nhận":
		case "mới tạo":
			return TrangThaiDonHang.CHO_XAC_NHAN;
		case "đã xác nhận":
			return TrangThaiDonHang.DA_XAC_NHAN;
		case "đang chuẩn bị":
			return TrangThaiDonHang.DANG_CHUAN_BI;
		case "đang giao":
			return TrangThaiDonHang.DANG_GIAO;
		case "đã giao":
			return TrangThaiDonHang.DA_GIAO;
		case "hoàn thành":
			return TrangThaiDonHang.HOAN_THANH;
		case "đã huỷ":
		case "đã hủy":
			return TrangThaiDonHang.DA_HUY;
		case "trả hàng":
			return TrangThaiDonHang.TRA_HANG;
		case "hoàn tiền":
			return TrangThaiDonHang.HOAN_TIEN;
		default:
			// hoặc người dùng truyền đúng enum name
			try {
				return TrangThaiDonHang.valueOf(x);
			} catch (Exception ignore) {
				return null;
			}
		}
	}

	public DonHang findByIdWithItems(int id) {
		var em = JPAUtil.getEntityManager();
		try {
			// JOIN FETCH để dùng được nguoiDung + chiTietDonHangs + sanPham trong JSP
			String jpql = "SELECT d FROM DonHang d " + " LEFT JOIN FETCH d.nguoiDung n "
					+ " LEFT JOIN FETCH d.chiTietDonHangs c " + " LEFT JOIN FETCH c.sanPham s " + " WHERE d.maDH = :id";
			return em.createQuery(jpql, DonHang.class).setParameter("id", id).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} finally {
			em.close();
		}
	}

	/**
	 * Insert new order with order details
	 * Fixed: Handle detached SanPham entities properly
	 */
	public boolean insert(DonHang donHang) {
		EntityManager em = getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			
			// Lưu đơn hàng trước (không có chi tiết)
			List<ChiTietDonHang> chiTietList = donHang.getChiTietDonHangs();
			donHang.setChiTietDonHangs(null); // Tạm thời set null
			
			// ✅ FIX: Merge NguoiDung nếu detached
			if (donHang.getNguoiDung() != null && donHang.getNguoiDung().getMaND() != null) {
				NguoiDung managedUser = em.find(NguoiDung.class, donHang.getNguoiDung().getMaND());
				if (managedUser == null) {
					throw new RuntimeException("Người dùng ID " + donHang.getNguoiDung().getMaND() + " không tồn tại");
				}
				donHang.setNguoiDung(managedUser);
			}
			
			// Persist đơn hàng (không có chi tiết)
			em.persist(donHang);
			em.flush(); // Flush để có maDH
			
			System.out.println("✅ Đã persist đơn hàng, maDH = " + donHang.getMaDH());
			
			// Sau khi có maDH, tạo chi tiết đơn hàng
			if (chiTietList != null && !chiTietList.isEmpty()) {
				for (ChiTietDonHang detail : chiTietList) {
					// ✅ FIX: Load lại SanPham từ database để có managed entity
					com.uteshop.entity.SanPham managedSanPham = em.find(
						com.uteshop.entity.SanPham.class, 
						detail.getSanPham().getMaSP()
					);
					
					if (managedSanPham == null) {
						throw new RuntimeException("Sản phẩm ID " + detail.getSanPham().getMaSP() + " không tồn tại");
					}
					
					// Khởi tạo lại composite key với maDH đã có
					ChiTietDonHangPK pk = new ChiTietDonHangPK();
					pk.setDonHang(donHang.getMaDH());
					pk.setSanPham(managedSanPham.getMaSP());
					
					detail.setId(pk);
					detail.setDonHang(donHang);
					detail.setSanPham(managedSanPham); // Sử dụng managed entity
					
					em.persist(detail);
				}
				em.flush(); // Flush các chi tiết đơn hàng
				donHang.setChiTietDonHangs(chiTietList);
			}
			
			tx.commit();
			System.out.println("✅ Đơn hàng #" + donHang.getMaDH() + " được tạo thành công với " + 
							   (chiTietList != null ? chiTietList.size() : 0) + " sản phẩm!");
			return true;
		} catch (Exception e) {
			if (tx.isActive()) {
				tx.rollback();
			}
			System.err.println("❌ Lỗi tạo đơn hàng: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}
}
