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
			TypedQuery<DonViVanChuyen> query = em
					.createQuery("SELECT d FROM DonViVanChuyen d ORDER BY d.phiVanChuyen ASC", DonViVanChuyen.class);
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
			return em.createQuery("SELECT d FROM DonViVanChuyen d ORDER BY d.phiVanChuyen ASC", DonViVanChuyen.class)
					.setMaxResults(limit).getResultList();
		} finally {
			em.close();
		}
	}

	// Tính phí vận chuyển theo khoảng cách
	public BigDecimal calculateShippingFee(int maVC, double distance) {
		DonViVanChuyen dvvc = findById(maVC);
		if (dvvc == null)
			return BigDecimal.ZERO;
		BigDecimal baseFee = dvvc.getPhiVanChuyen();
		BigDecimal distanceFee = BigDecimal.valueOf(distance * 1000);
		return baseFee.add(distanceFee);
	}

	// Đếm tổng số đơn vị vận chuyển
	public long countShippingPartners() {
		EntityManager em = getEntityManager();
		try {
			return em.createQuery("SELECT COUNT(d) FROM DonViVanChuyen d", Long.class).getSingleResult();
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
			if (tx.isActive())
				tx.rollback();
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
			if (tx.isActive())
				tx.rollback();
			System.err.println("❌ Error in DonViVanChuyenDAO.update: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public List<DonViVanChuyen> findPaged(int page, int pageSize, String q, String sort) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT s FROM DonViVanChuyen s WHERE 1=1 ");
			if (notBlank(q)) {
				jpql.append(" AND LOWER(s.tenDonVi) LIKE :kw ");
			}

			// ---- ORDER BY (mặc định: id_asc = MaVC ASC)
			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "id_desc" -> jpql.append(" s.maVC DESC ");
			case "name_asc" -> jpql.append(" s.tenDonVi ASC, s.maVC ASC ");
			case "name_desc" -> jpql.append(" s.tenDonVi DESC, s.maVC ASC ");
			case "fee_asc" -> jpql.append(" s.phiVanChuyen ASC, s.maVC ASC ");
			case "fee_desc" -> jpql.append(" s.phiVanChuyen DESC, s.maVC ASC ");
			case "id_asc" -> jpql.append(" s.maVC ASC ");
			default -> jpql.append(" s.maVC ASC "); // tăng dần mặc định
			}

			TypedQuery<DonViVanChuyen> query = em.createQuery(jpql.toString(), DonViVanChuyen.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");

			int first = Math.max(0, (page - 1) * pageSize);
			return query.setFirstResult(first).setMaxResults(pageSize).getResultList();
		} finally {
			em.close();
		}
	}

	private String safeSort(String s) {
		if (s == null || s.isBlank())
			return "id_asc"; // mặc định: tăng dần
		s = s.trim().toLowerCase();
		return switch (s) {
		case "id_asc", "id_desc", "name_asc", "name_desc", "fee_asc", "fee_desc" -> s;
		default -> "id_asc";
		};
	}

	public int countAll(String q) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(s) FROM DonViVanChuyen s WHERE 1=1 ");
			if (notBlank(q)) {
				jpql.append(" AND LOWER(s.tenDonVi) LIKE :kw ");
			}
			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			Long c = query.getSingleResult();
			return c == null ? 0 : c.intValue();
		} finally {
			em.close();
		}
	}

	public boolean create(DonViVanChuyen e) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(e);
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

	public boolean delete(Integer id) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			DonViVanChuyen e = em.find(DonViVanChuyen.class, id);
			if (e != null)
				em.remove(e);
			tx.commit();
			return e != null;
		} catch (Exception ex) {
			if (tx.isActive())
				tx.rollback();
			ex.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	/* ======================= Helpers ======================= */
	private boolean notBlank(String s) {
		return s != null && !s.trim().isEmpty();
	}
	// Trong lớp DonViVanChuyenDAO (nếu bạn có)
	public List<DonViVanChuyen> findAllActive() {
	    EntityManager em = JPAUtil.getEntityManager();
	    try {
	        String jpql = "SELECT d FROM DonViVanChuyen d"; // Thêm WHERE clause nếu cần
	        TypedQuery<DonViVanChuyen> query = em.createQuery(jpql, DonViVanChuyen.class);
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}
	
}
