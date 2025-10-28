package com.uteshop.dao;

import com.uteshop.entity.CuaHang;
import com.uteshop.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.math.BigDecimal;
import java.util.List;

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

	/**
	 * Tìm CuaHang dựa trên ID của NguoiDung (userId/maTK).
	 * 
	 * @param userId ID của người dùng (MaND/MaTK)
	 * @return CuaHang của người dùng đó, hoặc null nếu không tìm thấy.
	 */
	public CuaHang findByUserId(Integer userId) {
		EntityManager em = getEntityManager();
		try {
			// Sử dụng trực tiếp field maND thay vì đi qua relationship nguoiDung
			// Sử dụng getResultList() và lấy phần tử đầu tiên để tránh NonUniqueResultException
			TypedQuery<CuaHang> query = em.createQuery(
					"SELECT c FROM CuaHang c WHERE c.maND = :userId ORDER BY c.ngayTao ASC",
					CuaHang.class);
			query.setParameter("userId", userId);
			query.setMaxResults(1); // Chỉ lấy 1 kết quả
			
			List<CuaHang> results = query.getResultList();
			
			if (results.isEmpty()) {
				System.err.println("Không tìm thấy CuaHang cho userId: " + userId);
				return null;
			}
			
			// Nếu có nhiều hơn 1 cửa hàng, cảnh báo (lỗi dữ liệu)
			TypedQuery<Long> countQuery = em.createQuery(
					"SELECT COUNT(c) FROM CuaHang c WHERE c.maND = :userId", Long.class);
			countQuery.setParameter("userId", userId);
			Long count = countQuery.getSingleResult();
			
			if (count > 1) {
				System.err.println("⚠️ CẢNH BÁO: User " + userId + " có " + count + " cửa hàng! Nên chỉ có 1 cửa hàng/user.");
			}
			
			return results.get(0);
			
		} catch (Exception e) {
			System.err.println("Lỗi tìm CuaHang cho userId " + userId + ": " + e.getMessage());
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	public boolean insert(CuaHang cuaHang) {
		EntityManager em = getEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(cuaHang);
			em.getTransaction().commit();
			return true;
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

	public List<CuaHang> findAll() {
		EntityManager em = getEntityManager();
		try {
			// Cần cẩn thận với JOIN và SUM trong findAll, nếu không có dữ liệu sẽ trả về 0.
			// Nếu bạn muốn hiển thị tất cả cửa hàng đang hoạt động, hãy đơn giản hóa truy
			// vấn.
			String jpql = "SELECT ch FROM CuaHang ch WHERE ch.trangThai = TRUE";
			TypedQuery<CuaHang> query = em.createQuery(jpql, CuaHang.class);
			return query.getResultList();
		} finally {
			em.close();
		}
	}

	public long countStores() {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT COUNT(c) FROM CuaHang c WHERE c.trangThai = TRUE";
			TypedQuery<Long> query = em.createQuery(jpql, Long.class);
			return query.getSingleResult();
		} finally {
			em.close();
		}
	}

	public List<CuaHang> findPaged(int page, int pageSize, String q, Boolean active, Integer ownerId, String sort) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT c FROM CuaHang c WHERE 1=1 ");
			if (notBlank(q)) {
				jpql.append("""
						AND (LOWER(c.tenCH) LIKE :kw OR LOWER(c.email) LIKE :kw
						OR LOWER(c.soDienThoai) LIKE :kw OR LOWER(c.diaChi) LIKE :kw)
						""");
			}
			if (active != null) {
				jpql.append(" AND c.trangThai = :act ");
			}
			if (ownerId != null) {
				jpql.append(" AND c.maND = :owner ");
			}

			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "name_asc" -> jpql.append(" c.tenCH ASC ");
			case "name_desc" -> jpql.append(" c.tenCH DESC ");
			case "date_desc" -> jpql.append(" c.ngayTao DESC ");
			default -> jpql.append(" c.ngayTao DESC ");
			}

			TypedQuery<CuaHang> query = em.createQuery(jpql.toString(), CuaHang.class);

			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (active != null)
				query.setParameter("act", active);
			if (ownerId != null)
				query.setParameter("owner", ownerId);

			int first = Math.max(0, (page - 1) * pageSize);
			return query.setFirstResult(first).setMaxResults(pageSize).getResultList();
		} finally {
			em.close();
		}
	}

	/** Đếm tổng theo filter để tính totalPages */
	public int countAll(String q, Boolean active, Integer ownerId) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(c) FROM CuaHang c WHERE 1=1 ");
			if (notBlank(q)) {
				jpql.append("""
						AND (LOWER(c.tenCH) LIKE :kw OR LOWER(c.email) LIKE :kw
						OR LOWER(c.soDienThoai) LIKE :kw OR LOWER(c.diaChi) LIKE :kw)
						""");
			}
			if (active != null) {
				jpql.append(" AND c.trangThai = :act ");
			}
			if (ownerId != null) {
				jpql.append(" AND c.maND = :owner ");
			}

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (active != null)
				query.setParameter("act", active);
			if (ownerId != null)
				query.setParameter("owner", ownerId);

			Long count = query.getSingleResult();
			return count == null ? 0 : count.intValue();
		} finally {
			em.close();
		}
	}

	/* ====================== CRUD ====================== */

	public CuaHang findById(int id) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			return em.find(CuaHang.class, id);
		} finally {
			em.close();
		}
	}

	public boolean create(CuaHang c) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(c);
			tx.commit();
			return true;
		} catch (Exception ex) {
			if (tx.isActive())
				tx.rollback();
			ex.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean update(CuaHang c) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.merge(c);
			tx.commit();
			return true;
		} catch (Exception ex) {
			if (tx.isActive())
				tx.rollback();
			ex.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean toggleTrangThai(int maCH, boolean active) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			CuaHang c = em.find(CuaHang.class, maCH);
			if (c != null) {
				c.setTrangThai(active);
			}
			tx.commit();
			return c != null;
		} catch (Exception ex) {
			if (tx.isActive())
				tx.rollback();
			ex.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean delete(int maCH) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			CuaHang c = em.find(CuaHang.class, maCH);
			if (c != null)
				em.remove(c);
			tx.commit();
			return c != null;
		} catch (Exception ex) {
			if (tx.isActive())
				tx.rollback();
			ex.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	/* ====================== Helpers ====================== */
	private boolean notBlank(String s) {
		return s != null && !s.trim().isEmpty();
	}

	private String safeSort(String sort) {
		if (sort == null)
			return "";
		return switch (sort) {
		case "name_asc", "name_desc", "date_desc" -> sort;
		default -> "";
		};
	}

	public boolean updateTyLeChietKhau(Integer maCH, BigDecimal rate) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			CuaHang c = em.find(CuaHang.class, maCH);
			if (c == null) {
				tx.rollback();
				return false;
			}
			c.setTyLeChietKhau(rate);
			em.merge(c);
			tx.commit();
			return true;
		} catch (Exception ex) {
			if (tx.isActive())
				tx.rollback();
			ex.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public List<CuaHang> findPaged(int page, int pageSize, String q) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			String jpql = "SELECT c FROM CuaHang c WHERE (:kw IS NULL OR LOWER(c.tenCH) LIKE :kw OR LOWER(c.email) LIKE :kw) ORDER BY c.maCH DESC";
			TypedQuery<CuaHang> tq = em.createQuery(jpql, CuaHang.class);
			tq.setParameter("kw", q == null ? null : ("%" + q.toLowerCase().trim() + "%"));
			return tq.setFirstResult(Math.max(0, (page - 1) * pageSize)).setMaxResults(pageSize).getResultList();
		} finally {
			em.close();
		}
	}

	public int countAll(String q) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			String jpql = "SELECT COUNT(c) FROM CuaHang c WHERE (:kw IS NULL OR LOWER(c.tenCH) LIKE :kw OR LOWER(c.email) LIKE :kw)";
			TypedQuery<Long> tq = em.createQuery(jpql, Long.class);
			tq.setParameter("kw", q == null ? null : ("%" + q.toLowerCase().trim() + "%"));
			Long x = tq.getSingleResult();
			return x == null ? 0 : x.intValue();
		} finally {
			em.close();
		}
	}

	/**
	 * Cập nhật thông tin thanh toán cho cửa hàng
	 */
	public boolean updatePaymentInfo(Integer maCH, 
									Boolean momoEnable, String momoPhone, String momoName, String momoQR,
									Boolean bankEnable, String bankName, String bankAccountNumber, 
									String bankAccountName, String bankQR) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			CuaHang cuaHang = em.find(CuaHang.class, maCH);
			if (cuaHang == null) {
				tx.rollback();
				return false;
			}
			
			// Cập nhật thông tin MoMo
			cuaHang.setMomoEnable(momoEnable != null ? momoEnable : false);
			cuaHang.setMomoPhone(momoPhone);
			cuaHang.setMomoName(momoName);
			if (momoQR != null && !momoQR.trim().isEmpty()) {
				cuaHang.setMomoQR(momoQR);
			}
			
			// Cập nhật thông tin Ngân hàng
			cuaHang.setBankEnable(bankEnable != null ? bankEnable : false);
			cuaHang.setBankName(bankName);
			cuaHang.setBankAccountNumber(bankAccountNumber);
			cuaHang.setBankAccountName(bankAccountName);
			if (bankQR != null && !bankQR.trim().isEmpty()) {
				cuaHang.setBankQR(bankQR);
			}
			
			em.merge(cuaHang);
			tx.commit();
			return true;
		} catch (Exception ex) {
			if (tx.isActive()) {
				tx.rollback();
			}
			ex.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}
}
