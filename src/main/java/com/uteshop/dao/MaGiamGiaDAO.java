package com.uteshop.dao;

import com.uteshop.entity.MaGiamGia;
import com.uteshop.util.JPAUtil;
import com.uteshop.entity.CuaHang;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public class MaGiamGiaDAO {
	private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

	private EntityManager getEntityManager() {
		return emf.createEntityManager();
	}

	// Lấy danh sách mã giảm giá theo cửa hàng
	public List<MaGiamGia> findByCuaHangId(int maCH) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<MaGiamGia> query = em.createQuery(
					"SELECT m FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH ORDER BY m.ngayTao DESC", MaGiamGia.class);
			query.setParameter("maCH", maCH);
			return query.getResultList();
		} finally {
			em.close();
		}
	}

	public MaGiamGia findByCode(String code) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<MaGiamGia> q = em.createQuery("SELECT m FROM MaGiamGia m WHERE m.maSo = :code", MaGiamGia.class);
			q.setParameter("code", code);
			return q.getSingleResult();
		} catch (NoResultException e) {
			return null;
		} finally {
			em.close();
		}
	}

	// Lấy danh sách mã giảm giá theo cửa hàng với phân trang
	public List<MaGiamGia> findByCuaHangIdWithPaging(int maCH, int offset, int limit) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<MaGiamGia> query = em.createQuery(
					"SELECT m FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH ORDER BY m.ngayTao DESC", MaGiamGia.class);
			query.setParameter("maCH", maCH);
			query.setFirstResult(offset);
			query.setMaxResults(limit);
			return query.getResultList();
		} finally {
			em.close();
		}
	}

	// Đếm số lượng mã giảm giá theo cửa hàng
	public int countByCuaHangId(int maCH) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<Long> query = em.createQuery("SELECT COUNT(m) FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH",
					Long.class);
			query.setParameter("maCH", maCH);
			return query.getSingleResult().intValue();
		} finally {
			em.close();
		}
	}

	// Tìm mã giảm giá theo mã số
	public MaGiamGia findByMaSo(String maSo) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<MaGiamGia> query = em.createQuery("SELECT m FROM MaGiamGia m WHERE m.maSo = :maSo",
					MaGiamGia.class);
			query.setParameter("maSo", maSo);
			List<MaGiamGia> results = query.getResultList();
			return results.isEmpty() ? null : results.get(0);
		} finally {
			em.close();
		}
	}

	// Tìm mã giảm giá theo ID
	public MaGiamGia findById(int maGG) {
		EntityManager em = getEntityManager();
		try {
			return em.find(MaGiamGia.class, maGG);
		} finally {
			em.close();
		}
	}

	// Thêm mã giảm giá mới
	public boolean save(MaGiamGia maGiamGia) {
		EntityManager em = getEntityManager();
		try {
			em.getTransaction().begin();
			if (maGiamGia.getMaGG() == 0) {
				em.persist(maGiamGia);
			} else {
				em.merge(maGiamGia);
			}
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	// Cập nhật mã giảm giá
	public boolean update(MaGiamGia maGiamGia) {
		EntityManager em = getEntityManager();
		try {
			em.getTransaction().begin();
			em.merge(maGiamGia);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	// Xóa mã giảm giá
	public boolean delete(int maGG) {
		EntityManager em = getEntityManager();
		try {
			em.getTransaction().begin();
			MaGiamGia maGiamGia = em.find(MaGiamGia.class, maGG);
			if (maGiamGia != null) {
				em.remove(maGiamGia);
			}
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	// Cập nhật số lượng đã sử dụng
	public boolean incrementUsageCount(int maGG) {
		EntityManager em = getEntityManager();
		try {
			em.getTransaction().begin();
			MaGiamGia maGiamGia = em.find(MaGiamGia.class, maGG);
			if (maGiamGia == null) {
				em.getTransaction().rollback();
				return false;
			}
			maGiamGia.setSoLuongDaSuDung(maGiamGia.getSoLuongDaSuDung() + 1);
			em.merge(maGiamGia);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (em.getTransaction().isActive()) {
					em.getTransaction().rollback();
				}
			} catch (Exception ex) {
			}
			return false;
		} finally {
			em.close();
		}
	}

	// Kiểm tra mã giảm giá có hợp lệ không (chưa hết hạn, còn lượt sử dụng)
	public boolean isValidDiscountCode(String maSo, int maCH) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<MaGiamGia> query = em
					.createQuery(
							"SELECT m FROM MaGiamGia m WHERE m.maSo = :maSo AND m.cuaHang.maCH = :maCH "
									+ "AND m.trangThai = true AND m.ngayBatDau <= :now AND m.ngayKetThuc >= :now "
									+ "AND (m.soLuongToiDa IS NULL OR m.soLuongDaSuDung < m.soLuongToiDa)",
							MaGiamGia.class);
			query.setParameter("maSo", maSo);
			query.setParameter("maCH", maCH);
			query.setParameter("now", LocalDateTime.now());

			List<MaGiamGia> results = query.getResultList();
			return !results.isEmpty();
		} finally {
			em.close();
		}
	}

	// Lấy danh sách mã giảm giá đang hoạt động của cửa hàng
	public List<MaGiamGia> getActiveDiscountsByStore(int maCH) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<MaGiamGia> query = em.createQuery("SELECT m FROM MaGiamGia m WHERE m.cuaHang.maCH = :maCH "
					+ "AND m.trangThai = true AND m.ngayBatDau <= :now AND m.ngayKetThuc >= :now "
					+ "ORDER BY m.ngayTao DESC", MaGiamGia.class);
			query.setParameter("maCH", maCH);
			query.setParameter("now", LocalDateTime.now());
			return query.getResultList();
		} finally {
			em.close();
		}
	}

	public int countAll(String q, String type, String status) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(c) FROM MaGiamGia c WHERE 1=1 ");
			if (notBlank(q))
				jpql.append(" AND (LOWER(c.maCode) LIKE :kw OR LOWER(c.tenChuongTrinh) LIKE :kw) ");
			if (notBlank(type))
				jpql.append(" AND LOWER(c.loaiGiam) = :type ");
			if (notBlank(status)) {
				jpql.append(" AND ");
				switch (status) {
				case "ongoing" -> jpql.append(" :now BETWEEN c.ngayBatDau AND c.ngayKetThuc ");
				case "upcoming" -> jpql.append(" c.ngayBatDau > :now ");
				case "expired" -> jpql.append(" c.ngayKetThuc < :now ");
				default -> {
				}
				}
			}

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (notBlank(type))
				query.setParameter("type", type.toLowerCase().trim());
			if (notBlank(status))
				query.setParameter("now", new Date());

			Long c = query.getSingleResult();
			return c == null ? 0 : c.intValue();
		} finally {
			em.close();
		}
	}

	private boolean notBlank(String s) {
		return s != null && !s.trim().isEmpty();
	}

	

	public List<MaGiamGia> findPaged(int page, int pageSize, String q, String type, String status, String sort) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT c FROM MaGiamGia c WHERE 1=1 ");

			if (notBlank(q)) {
				jpql.append(" AND (LOWER(c.maCode) LIKE :kw OR LOWER(c.tenChuongTrinh) LIKE :kw) ");
			}
			if (notBlank(type)) {
				jpql.append(" AND LOWER(c.loaiGiam) = :type ");
			}
			if (notBlank(status)) {
				jpql.append(" AND ");
				switch (status) {
				case "ongoing" -> jpql.append(" :now BETWEEN c.ngayBatDau AND c.ngayKetThuc ");
				case "upcoming" -> jpql.append(" c.ngayBatDau > :now ");
				case "expired" -> jpql.append(" c.ngayKetThuc < :now ");
				default -> {
				}
				}
			}

			// ---- ORDER BY: mặc định mã tăng dần
			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "id_desc" -> jpql.append(" c.maGG DESC ");
			case "id_asc" -> jpql.append(" c.maGG ASC ");
			case "name_asc" -> jpql.append(" c.tenChuongTrinh ASC, c.maGG ASC ");
			case "name_desc" -> jpql.append(" c.tenChuongTrinh DESC, c.maGG ASC ");
			case "start_asc" -> jpql.append(" c.ngayBatDau ASC, c.maGG ASC ");
			case "start_desc" -> jpql.append(" c.ngayBatDau DESC, c.maGG ASC ");
			case "end_asc" -> jpql.append(" c.ngayKetThuc ASC, c.maGG ASC ");
			case "end_desc" -> jpql.append(" c.ngayKetThuc DESC, c.maGG ASC ");
			default -> jpql.append(" c.maGG ASC "); // mặc định: mã tăng dần
			}

			TypedQuery<MaGiamGia> query = em.createQuery(jpql.toString(), MaGiamGia.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (notBlank(type))
				query.setParameter("type", type.toLowerCase().trim());
			if (notBlank(status))
				query.setParameter("now", new Date());

			int first = Math.max(0, (page - 1) * pageSize);
			return query.setFirstResult(first).setMaxResults(pageSize).getResultList();
		} finally {
			em.close();
		}
	}

	private String safeSort(String s) {
		if (s == null || s.isBlank())
			return "id_asc"; // mặc định tăng dần
		s = s.trim().toLowerCase();
		return switch (s) {
		case "id_asc", "id_desc", "name_asc", "name_desc", "start_asc", "start_desc", "end_asc", "end_desc" -> s;
		default -> "id_asc";
		};
	}

	public boolean create(MaGiamGia e) {
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

}
