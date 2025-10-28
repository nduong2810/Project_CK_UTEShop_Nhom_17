package com.uteshop.dao;

import com.uteshop.entity.KhieuNaiNguoiDung;
import com.uteshop.entity.KhieuNaiNguoiDung.TrangThai;
import com.uteshop.util.JPAUtil;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

public class KhieuNaiNguoiDungDAO {

	private boolean notBlank(String s) {
		return s != null && !s.isBlank();
	}

	public KhieuNaiNguoiDung findById(Integer id) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			return em.find(KhieuNaiNguoiDung.class, id);
		} finally {
			em.close();
		}
	}

	public boolean create(KhieuNaiNguoiDung k) {
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

	public boolean updateStatus(Integer maKN, TrangThai st, String ghiChu) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			KhieuNaiNguoiDung k = em.find(KhieuNaiNguoiDung.class, maKN);
			if (k == null) {
				tx.rollback();
				return false;
			}
			k.setTrangThai(st);
			k.setGhiChu(ghiChu);
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

	public int countAll(String q, TrangThai status, Integer userId) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder(
					"SELECT COUNT(k) FROM KhieuNaiNguoiDung k JOIN k.nguoiDung n WHERE 1=1 ");
			if (notBlank(q))
				jpql.append(
						" AND (LOWER(n.hoTen) LIKE :kw OR LOWER(n.email) LIKE :kw OR CAST(n.maND AS string) LIKE :kw) ");
			if (status != null)
				jpql.append(" AND k.trangThai = :st ");
			if (userId != null)
				jpql.append(" AND n.maND = :uid ");

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (status != null)
				query.setParameter("st", status);
			if (userId != null)
				query.setParameter("uid", userId);

			return query.getSingleResult().intValue();
		} finally {
			em.close();
		}
	}

	public List<KhieuNaiNguoiDung> findPaged(int page, int pageSize, String q, TrangThai status, Integer userId,
			String sort) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder(
					"SELECT k FROM KhieuNaiNguoiDung k JOIN FETCH k.nguoiDung n WHERE 1=1 ");
			if (notBlank(q))
				jpql.append(
						" AND (LOWER(n.hoTen) LIKE :kw OR LOWER(n.email) LIKE :kw OR CAST(n.maND AS string) LIKE :kw) ");
			if (status != null)
				jpql.append(" AND k.trangThai = :st ");
			if (userId != null)
				jpql.append(" AND n.maND = :uid ");

			// Sắp xếp: mặc định mới nhất
			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "id_asc" -> jpql.append(" k.maKN ASC ");
			case "id_desc" -> jpql.append(" k.maKN DESC ");
			case "date_asc" -> jpql.append(" k.ngayGui ASC, k.maKN ASC ");
			default -> jpql.append(" k.ngayGui DESC, k.maKN DESC ");
			}

			TypedQuery<KhieuNaiNguoiDung> query = em.createQuery(jpql.toString(), KhieuNaiNguoiDung.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (status != null)
				query.setParameter("st", status);
			if (userId != null)
				query.setParameter("uid", userId);

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
