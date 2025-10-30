package com.uteshop.dao;

import com.uteshop.entity.KhieuNaiCuaHang;
import com.uteshop.entity.KhieuNaiCuaHang.TrangThai;
import com.uteshop.util.JPAUtil;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

public class KhieuNaiCuaHangDAO {

	private boolean notBlank(String s) {
		return s != null && !s.isBlank();
	}

	public KhieuNaiCuaHang findById(Integer id) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			KhieuNaiCuaHang kn = em.find(KhieuNaiCuaHang.class, id);
			if (kn != null) {
				kn.getNguoiDung().getHoTen(); // Force load
				kn.getCuaHang().getTenCH(); // Force load
			}
			return kn;
		} finally {
			em.close();
		}
	}

	public boolean create(KhieuNaiCuaHang k) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(k);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean updateStatus(Integer maKNCH, TrangThai st, String ghiChu) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			KhieuNaiCuaHang k = em.find(KhieuNaiCuaHang.class, maKNCH);
			if (k == null) {
				tx.rollback();
				return false;
			}
			k.setTrangThai(st);
			k.setGhiChu(ghiChu);
			k.setNgayXuLy(new Date());
			em.merge(k);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean withdraw(Integer maKNCH, Integer userId) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			KhieuNaiCuaHang k = em.find(KhieuNaiCuaHang.class, maKNCH);
			if (k == null || !k.getNguoiDung().getMaND().equals(userId)) {
				tx.rollback();
				return false;
			}
			// Chỉ cho phép thu hồi nếu đang ở trạng thái PENDING
			if (k.getTrangThai() != TrangThai.PENDING) {
				tx.rollback();
				return false;
			}
			k.setTrangThai(TrangThai.WITHDRAWN);
			k.setNgayXuLy(new Date());
			em.merge(k);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean update(Integer maKNCH, String tieuDe, String noiDung) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			KhieuNaiCuaHang k = em.find(KhieuNaiCuaHang.class, maKNCH);
			if (k == null || k.getTrangThai() != TrangThai.PENDING) {
				tx.rollback();
				return false;
			}
			k.setTieuDe(tieuDe);
			k.setNoiDung(noiDung);
			em.merge(k);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean delete(Integer maKNCH) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			KhieuNaiCuaHang k = em.find(KhieuNaiCuaHang.class, maKNCH);
			if (k == null || k.getTrangThai() != TrangThai.PENDING) {
				tx.rollback();
				return false;
			}
			em.remove(k);
			tx.commit();
			return true;
		} catch (Exception e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public int countAll(String q, TrangThai status, Integer userId, Integer vendorId) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder(
					"SELECT COUNT(k) FROM KhieuNaiCuaHang k JOIN k.nguoiDung n JOIN k.cuaHang ch WHERE 1=1 ");
			if (notBlank(q))
				jpql.append(
						" AND (LOWER(k.tieuDe) LIKE :kw OR LOWER(k.noiDung) LIKE :kw OR LOWER(ch.tenCH) LIKE :kw OR LOWER(n.hoTen) LIKE :kw) ");
			if (status != null)
				jpql.append(" AND k.trangThai = :st ");
			if (userId != null)
				jpql.append(" AND n.maND = :uid ");
			if (vendorId != null)
				jpql.append(" AND ch.maCH = :vid ");

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (status != null)
				query.setParameter("st", status);
			if (userId != null)
				query.setParameter("uid", userId);
			if (vendorId != null)
				query.setParameter("vid", vendorId);

			return query.getSingleResult().intValue();
		} finally {
			em.close();
		}
	}

	public List<KhieuNaiCuaHang> findPaged(int page, int pageSize, String q, TrangThai status, Integer userId,
			Integer vendorId, String sort) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder(
					"SELECT k FROM KhieuNaiCuaHang k JOIN FETCH k.nguoiDung n JOIN FETCH k.cuaHang ch WHERE 1=1 ");
			if (notBlank(q))
				jpql.append(
						" AND (LOWER(k.tieuDe) LIKE :kw OR LOWER(k.noiDung) LIKE :kw OR LOWER(ch.tenCH) LIKE :kw OR LOWER(n.hoTen) LIKE :kw) ");
			if (status != null)
				jpql.append(" AND k.trangThai = :st ");
			if (userId != null)
				jpql.append(" AND n.maND = :uid ");
			if (vendorId != null)
				jpql.append(" AND ch.maCH = :vid ");

			// Sắp xếp: mặc định mới nhất
			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "id_asc" -> jpql.append(" k.maKNCH ASC ");
			case "id_desc" -> jpql.append(" k.maKNCH DESC ");
			case "date_asc" -> jpql.append(" k.ngayGui ASC, k.maKNCH ASC ");
			default -> jpql.append(" k.ngayGui DESC, k.maKNCH DESC ");
			}

			TypedQuery<KhieuNaiCuaHang> query = em.createQuery(jpql.toString(), KhieuNaiCuaHang.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (status != null)
				query.setParameter("st", status);
			if (userId != null)
				query.setParameter("uid", userId);
			if (vendorId != null)
				query.setParameter("vid", vendorId);

			int first = Math.max(0, (page - 1) * pageSize);
			return query.setFirstResult(first).setMaxResults(pageSize).getResultList();
		} finally {
			em.close();
		}
	}

	private String safeSort(String s) {
		if (s == null || s.isBlank())
			return "date_desc";
		s = s.trim().toLowerCase();
		return switch (s) {
		case "id_asc", "id_desc", "date_asc", "date_desc" -> s;
		default -> "date_desc";
		};
	}
}