package com.uteshop.dao;

import com.uteshop.entity.DanhMuc;
import com.uteshop.util.JPAUtil; // Sử dụng JPAUtil đã tạo trước đó
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DanhMucDAO {

	// Phương thức chung để lấy EntityManager
	private EntityManager getEntityManager() {
		return JPAUtil.getEntityManager();
	}

	/**
	 * Find category by ID
	 */
	public DanhMuc findById(Integer id) {
		if (id == null)
			return null;
		EntityManager em = getEntityManager();
		try {
			return em.find(DanhMuc.class, id);
		} finally {
			em.close();
		}
	}

	/**
	 * Find all active categories (TrangThai = 1 or TRUE). Assumes TrangThai is
	 * mapped as a boolean or integer in the entity.
	 */
	public List<DanhMuc> findAll() {
		EntityManager em = getEntityManager();
		// Giả định TrangThai được lưu là TRUE/1
		String jpql = "SELECT d FROM DanhMuc d WHERE d.trangThai = 1";

		try {
			// TypedQuery tự động ánh xạ kết quả truy vấn sang List<DanhMuc>
			TypedQuery<DanhMuc> query = em.createQuery(jpql, DanhMuc.class);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	/**
	 * Get all active categories, ordered by name (TenDM ASC).
	 */
	public List<DanhMuc> getAllCategories() {
		EntityManager em = getEntityManager();
		String jpql = "SELECT d FROM DanhMuc d WHERE d.trangThai = 1 ORDER BY d.tenDM ASC";

		try {
			TypedQuery<DanhMuc> query = em.createQuery(jpql, DanhMuc.class);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	public List<DanhMuc> findPaged(int page, int pageSize, String q, Integer activeInt, String sort) {
		// activeInt: null = tất cả; 1 = hoạt động; 0 = ẩn
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT d FROM DanhMuc d WHERE 1=1 ");
			if (notBlank(q)) {
				jpql.append(" AND (LOWER(d.tenDM) LIKE :kw OR LOWER(d.moTa) LIKE :kw) ");
			}
			if (activeInt != null) {
				jpql.append(" AND d.trangThai = :act ");
			}
			// sort an toàn
			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "name_asc" -> jpql.append(" d.tenDM ASC ");
			case "name_desc" -> jpql.append(" d.tenDM DESC ");
			case "date_desc" -> jpql.append(" d.ngayTao DESC ");
			default -> jpql.append(" d.ngayTao DESC ");
			}

			TypedQuery<DanhMuc> query = em.createQuery(jpql.toString(), DanhMuc.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (activeInt != null)
				query.setParameter("act", activeInt);

			int first = Math.max(0, (page - 1) * pageSize);
			return query.setFirstResult(first).setMaxResults(pageSize).getResultList();
		} finally {
			em.close();
		}
	}

	public int countAll(String q) {
		EntityManager em = getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(c) FROM DanhMuc c WHERE 1=1 ");
			if (notBlank(q)) {
				jpql.append(" AND (LOWER(c.tenDM) LIKE :kw OR LOWER(c.moTa) LIKE :kw) ");
			}
			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			return query.getSingleResult().intValue();
		} finally {
			em.close();
		}
	}

	public boolean create(DanhMuc c) {
		EntityManager em = getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			if (c.getNgayTao() == null)
				c.setNgayTao(new Date());
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

	public boolean update(DanhMuc c) {
		if (c == null || c.getMaDM() == null)
			return false;
		EntityManager em = getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			// cách 1: merge trực tiếp
			em.merge(c);

			// cách 2 (an toàn khi muốn giữ vài field): lấy managed entity rồi set
			// DanhMuc db = em.find(DanhMuc.class, c.getMaDM());
			// if (db == null) { tx.rollback(); return false; }
			// db.setTenDM(c.getTenDM());
			// db.setMoTa(c.getMoTa());
			// db.setTrangThai(c.getTrangThai());
			// db.setHinhAnh(c.getHinhAnh());
			// em.flush();

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
		if (id == null)
			return false;
		EntityManager em = getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			DanhMuc c = em.find(DanhMuc.class, id);
			if (c != null)
				em.remove(c);
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

	public boolean toggleTrangThai(Integer id, boolean active) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			DanhMuc d = em.find(DanhMuc.class, id);
			if (d != null)
				d.setTrangThai(active ? 1 : 0);
			tx.commit();
			return d != null;
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

	private String safeSort(String sort) {
		if (sort == null)
			return "";
		return switch (sort) {
		case "name_asc", "name_desc", "date_desc" -> sort;
		default -> "";
		};
	}
}