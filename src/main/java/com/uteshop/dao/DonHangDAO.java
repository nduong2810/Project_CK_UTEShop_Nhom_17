package com.uteshop.dao;

import com.uteshop.entity.DonHang;
import com.uteshop.entity.DonHang.TrangThaiDonHang;
import com.uteshop.util.JPAUtil;
import com.uteshop.entity.ChiTietDonHang;
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
		// Dùng tham số :status_done thay vì chuỗi cứng 'DA_GIAO'
		String jpql = "SELECT SUM(dh.tongThanhToan) " + "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH " + "  AND dh.trangThai = :status_done "
				+ "  AND FUNCTION('MONTH', dh.ngayDat) = :month " + "  AND FUNCTION('YEAR', dh.ngayDat) = :year";

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

		// Đơn hàng mới thường có trạng thái là CHUA_XAC_NHAN
		String jpql = "SELECT COUNT(DISTINCT dh) FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH " + "  AND dh.trangThai = 'CHUA_XAC_NHAN'";

		try {
			Long count = em.createQuery(jpql, Long.class).setParameter("maCH", maCH).getSingleResult();
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
	 */
	public List<DonHang> findByStoreWithPagination(Integer maCH, DonHang.TrangThaiDonHang status, int page, int size) {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT DISTINCT dh FROM DonHang dh " + "JOIN FETCH dh.chiTietDonHangs ctdh "
					+ "JOIN FETCH ctdh.sanPham sp " + "JOIN FETCH sp.cuaHang ch " + "WHERE ch.maCH = :maCH";

			if (status != null) {
				jpql += " AND dh.trangThai = :status";
			}

			jpql += " ORDER BY dh.ngayDat DESC";

			TypedQuery<DonHang> query = em.createQuery(jpql, DonHang.class);
			query.setParameter("maCH", maCH);

			if (status != null) {
				query.setParameter("status", status);
			}

			query.setFirstResult((page - 1) * size);
			query.setMaxResults(size);

			return query.getResultList();
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

			return query.getSingleResult();
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
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy doanh thu theo ngày cụ thể
	 */
	public BigDecimal getDailyRevenue(Integer maCH, int day, int month, int year) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT SUM(dh.tongThanhToan) " + "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH " + "  AND dh.trangThai = :status_done "
				+ "  AND FUNCTION('DAY', dh.ngayDat) = :day " + "  AND FUNCTION('MONTH', dh.ngayDat) = :month "
				+ "  AND FUNCTION('YEAR', dh.ngayDat) = :year";

		try {
			TypedQuery<BigDecimal> query = em.createQuery(jpql, BigDecimal.class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_done", DonHang.TrangThaiDonHang.DA_GIAO);
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
	 * Lấy doanh thu theo năm
	 */
	public BigDecimal getYearlyRevenue(Integer maCH, int year) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT SUM(dh.tongThanhToan) " + "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh "
				+ "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH " + "  AND dh.trangThai = :status_done "
				+ "  AND FUNCTION('YEAR', dh.ngayDat) = :year";

		try {
			TypedQuery<BigDecimal> query = em.createQuery(jpql, BigDecimal.class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_done", DonHang.TrangThaiDonHang.DA_GIAO);
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
	 */
	public List<Object[]> getLast7DaysRevenue(Integer maCH) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT FUNCTION('DATE', dh.ngayDat) as orderDate, SUM(dh.tongThanhToan) " + "FROM DonHang dh "
				+ "JOIN dh.chiTietDonHangs ctdh " + "JOIN ctdh.sanPham sp " + "WHERE sp.cuaHang.maCH = :maCH "
				+ "  AND dh.trangThai = :status_done "
				+ "  AND dh.ngayDat >= FUNCTION('DATEADD', DAY, -7, CURRENT_DATE) "
				+ "GROUP BY FUNCTION('DATE', dh.ngayDat) " + "ORDER BY orderDate ASC";

		try {
			TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_done", DonHang.TrangThaiDonHang.DA_GIAO);

			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new java.util.ArrayList<>();
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy doanh thu 12 tháng gần nhất
	 */
	public List<Object[]> getLast12MonthsRevenue(Integer maCH) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT FUNCTION('YEAR', dh.ngayDat), FUNCTION('MONTH', dh.ngayDat), SUM(dh.tongThanhToan) "
				+ "FROM DonHang dh " + "JOIN dh.chiTietDonHangs ctdh " + "JOIN ctdh.sanPham sp "
				+ "WHERE sp.cuaHang.maCH = :maCH " + "  AND dh.trangThai = :status_done "
				+ "  AND dh.ngayDat >= FUNCTION('DATEADD', MONTH, -12, CURRENT_DATE) "
				+ "GROUP BY FUNCTION('YEAR', dh.ngayDat), FUNCTION('MONTH', dh.ngayDat) "
				+ "ORDER BY FUNCTION('YEAR', dh.ngayDat) ASC, FUNCTION('MONTH', dh.ngayDat) ASC";

		try {
			TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
			query.setParameter("maCH", maCH);
			query.setParameter("status_done", DonHang.TrangThaiDonHang.DA_GIAO);

			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new java.util.ArrayList<>();
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
	 */
	public DonHang findByIdAndStore(Integer maDH, Integer maCH) {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT DISTINCT dh FROM DonHang dh " + "JOIN FETCH dh.chiTietDonHangs ctdh "
					+ "JOIN FETCH ctdh.sanPham sp " + "JOIN FETCH sp.cuaHang ch " + "JOIN FETCH dh.nguoiDung nd "
					+ "WHERE dh.maDH = :maDH AND ch.maCH = :maCH";

			TypedQuery<DonHang> query = em.createQuery(jpql, DonHang.class);
			query.setParameter("maDH", maDH);
			query.setParameter("maCH", maCH);

			List<DonHang> results = query.getResultList();
			return results.isEmpty() ? null : results.get(0);
		} catch (Exception e) {
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
		case "mới tạo":
			return TrangThaiDonHang.DON_HANG_MOI;
		case "đã xác nhận":
			return TrangThaiDonHang.DA_XAC_NHAN;
		case "đang giao":
			return TrangThaiDonHang.DANG_GIAO;
		case "đã giao":
			return TrangThaiDonHang.DA_GIAO;
		case "đã huỷ":
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
	 */
	public boolean insert(DonHang donHang) {
		EntityManager em = getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(donHang);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx.isActive()) {
				tx.rollback();
			}
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}
}
