package com.uteshop.dao;

import com.uteshop.entity.CuaHang;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;
import com.uteshop.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SanPhamDAO {

	private EntityManager getEntityManager() {
		return JPAUtil.getEntityManager();
	}

	private void buildProductQuery(StringBuilder jpql, List<Object> params, Integer categoryId, String sortBy,
			String priceRange, boolean isCount) {
		jpql.append(" WHERE s.trangThai = TRUE ");

		if (categoryId != null && categoryId > 0) {
			jpql.append(" AND s.danhMuc.maDM = :categoryId ");
		}

		if (sortBy != null && "bestseller".equals(sortBy)) {
			jpql.append(" AND s.soLuongBan > 10 ");
		}

		if (priceRange != null && !priceRange.isEmpty()) {
			if (priceRange.endsWith("-")) {
				String minPrice = priceRange.substring(0, priceRange.length() - 1);
				jpql.append(" AND s.donGia >= :minPrice ");
			} else {
				String[] prices = priceRange.split("-");
				if (prices.length == 2) {
					jpql.append(" AND s.donGia BETWEEN :minPrice AND :maxPrice ");
				}
			}
		}
	}

	private TypedQuery<SanPham> setProductQueryParams(TypedQuery<SanPham> query, Integer categoryId, String sortBy,
			String priceRange) {
		if (categoryId != null && categoryId > 0) {
			query.setParameter("categoryId", categoryId);
		}
		if (priceRange != null && !priceRange.isEmpty()) {
			if (priceRange.endsWith("-")) {
				String minPrice = priceRange.substring(0, priceRange.length() - 1);
				query.setParameter("minPrice", new BigDecimal(minPrice));
			} else {
				String[] prices = priceRange.split("-");
				if (prices.length == 2) {
					query.setParameter("minPrice", new BigDecimal(prices[0]));
					query.setParameter("maxPrice", new BigDecimal(prices[1]));
				}
			}
		}
		return query;
	}

	public List<SanPham> findTopNProducts(int limit) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT s FROM SanPham s WHERE s.trangThai = TRUE ORDER BY s.soLuongBan DESC, s.maSP ASC";
		try {
			return em.createQuery(jpql, SanPham.class).setMaxResults(limit).getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findTopNProductsByCategoryId(int limit, Integer categoryId) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT s FROM SanPham s WHERE s.trangThai = TRUE AND s.danhMuc.maDM = :categoryId ORDER BY s.soLuongBan DESC, s.maSP ASC";
		try {
			return em.createQuery(jpql, SanPham.class).setParameter("categoryId", categoryId).setMaxResults(limit)
					.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findByStoreId(Integer maCH) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT sp FROM SanPham sp WHERE sp.cuaHang.maCH = :maCH";
		try {
			return em.createQuery(jpql, SanPham.class).setParameter("maCH", maCH).getResultList();
		} finally {
			em.close();
		}
	}

	public boolean insert(SanPham sp) {
		EntityManager em = getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();

			System.out.println(
					"MaCH before processing: " + (sp.getCuaHang() != null ? sp.getCuaHang().getMaCH() : "NULL"));

			// Xử lý DanhMuc
			if (sp.getMaDM() != null) {
				DanhMuc dm = em.find(DanhMuc.class, sp.getMaDM());
				if (dm == null)
					throw new IllegalArgumentException("Danh mục (maDM) không tồn tại: " + sp.getMaDM());
				sp.setDanhMuc(dm);
			} else {
				throw new IllegalArgumentException("Thiếu thông tin Danh mục.");
			}

			// Xử lý CuaHang
			if (sp.getCuaHang() != null && sp.getCuaHang().getMaCH() != null) {
				CuaHang ch = em.find(CuaHang.class, sp.getCuaHang().getMaCH());
				if (ch == null)
					throw new IllegalArgumentException("Cửa hàng (maCH) không tồn tại.");
				sp.setCuaHang(ch);
				System.out.println("MaCH after setting managed CuaHang: " + ch.getMaCH());
			} else {
				throw new IllegalArgumentException("Thiếu thông tin Cửa hàng.");
			}

			if (sp.getTrangThai() == null) {
				sp.setTrangThai(true);
			}

			em.persist(sp);
			System.out.println("Persisted MaCH: " + (sp.getCuaHang() != null ? sp.getCuaHang().getMaCH() : "NULL"));
			trans.commit();
			return true;
		} catch (Exception e) {
			if (trans.isActive())
				trans.rollback();
			System.err.println("Lỗi khi thêm sản phẩm: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public List<SanPham> findAll(int offset, int limit, String sortBy, String priceRange, Integer categoryId) {
		EntityManager em = getEntityManager();
		StringBuilder jpql = new StringBuilder("SELECT s FROM SanPham s");

		buildProductQuery(jpql, new ArrayList<>(), categoryId, sortBy, priceRange, false);

		String orderByClause;
		switch (sortBy != null ? sortBy : "") {
		case "price-asc":
			orderByClause = " ORDER BY s.donGia ASC, s.maSP ASC";
			break;
		case "price-desc":
			orderByClause = " ORDER BY s.donGia DESC, s.maSP ASC";
			break;
		case "newest":
			orderByClause = " ORDER BY s.ngayTao DESC, s.maSP ASC";
			break;
		case "all":
		case "bestseller":
		default:
			orderByClause = " ORDER BY s.soLuongBan DESC, s.maSP ASC";
			break;
		}
		jpql.append(orderByClause);

		try {
			TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);
			query = setProductQueryParams(query, categoryId, sortBy, priceRange);
			query.setFirstResult(offset);
			query.setMaxResults(limit);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	private TypedQuery<Long> setCountQueryParams(TypedQuery<Long> query, Integer categoryId, String sortBy,
			String priceRange) {
		if (categoryId != null && categoryId > 0) {
			query.setParameter("categoryId", categoryId);
		}
		if (priceRange != null && !priceRange.isEmpty()) {
			if (priceRange.endsWith("-")) {
				String minPrice = priceRange.substring(0, priceRange.length() - 1);
				query.setParameter("minPrice", new BigDecimal(minPrice));
			} else {
				String[] prices = priceRange.split("-");
				if (prices.length == 2) {
					query.setParameter("minPrice", new BigDecimal(prices[0]));
					query.setParameter("maxPrice", new BigDecimal(prices[1]));
				}
			}
		}
		return query;
	}

	public long countProducts(String sortBy, String priceRange, Integer categoryId) {
		EntityManager em = getEntityManager();
		StringBuilder jpql = new StringBuilder("SELECT COUNT(s) FROM SanPham s");

		buildProductQuery(jpql, new ArrayList<>(), categoryId, sortBy, priceRange, true);

		try {
			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			query = setCountQueryParams(query, categoryId, sortBy, priceRange);
			return query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			em.close();
		}
	}

	public SanPham findById(Integer id) {
		EntityManager em = getEntityManager();
		try {
			return em.find(SanPham.class, id);
		} finally {
			em.close();
		}
	}

	public List<SanPham> findByCategoryId(Integer categoryId) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT s FROM SanPham s WHERE s.danhMuc.maDM = :categoryId AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
		try {
			return em.createQuery(jpql, SanPham.class).setParameter("categoryId", categoryId).getResultList();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findByStoreId(int storeId) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT s FROM SanPham s WHERE s.cuaHang.maCH = :storeId AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
		try {
			return em.createQuery(jpql, SanPham.class).setParameter("storeId", storeId).getResultList();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findByStore(Integer storeId, int limit) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT s FROM SanPham s WHERE s.cuaHang.maCH = :storeId AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
		try {
			return em.createQuery(jpql, SanPham.class).setParameter("storeId", storeId).setMaxResults(limit)
					.getResultList();
		} finally {
			em.close();
		}
	}

	public List<SanPham> getAllProducts() {
		EntityManager em = getEntityManager();
		String jpql = "SELECT s FROM SanPham s WHERE s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
		try {
			return em.createQuery(jpql, SanPham.class).getResultList();
		} finally {
			em.close();
		}
	}

	public void updateSanPhamTextFields(SanPham sp) {
		EntityManager em = getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			SanPham managedSp = em.find(SanPham.class, sp.getMaSP());
			if (managedSp != null) {
				managedSp.setTenSP(sp.getTenSP());
				managedSp.setMoTa(sp.getMoTa());
				managedSp.setHinhAnh(sp.getHinhAnh());
				em.merge(managedSp);
			}
			trans.commit();
		} catch (Exception e) {
			if (trans.isActive())
				trans.rollback();
			e.printStackTrace();
		} finally {
			em.close();
		}
	}

	public List<DanhMuc> listCategories() {
		EntityManager em = getEntityManager();
		String jpql = "SELECT d FROM DanhMuc d ORDER BY d.tenDM ASC";
		try {
			return em.createQuery(jpql, DanhMuc.class).getResultList();
		} finally {
			em.close();
		}
	}

	public int countAll(String q, Integer catId) {
		EntityManager em = getEntityManager();
		StringBuilder jpql = new StringBuilder("SELECT COUNT(s) FROM SanPham s WHERE 1=1 ");

		if (q != null && !q.isBlank()) {
			jpql.append(" AND (LOWER(s.tenSP) LIKE :keyword OR CAST(s.maSP AS string) LIKE :keyword) ");
		}
		if (catId != null) {
			jpql.append(" AND s.danhMuc.maDM = :catId ");
		}

		try {
			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);

			if (q != null && !q.isBlank()) {
				String kw = "%" + q.toLowerCase() + "%";
				query.setParameter("keyword", kw);
			}
			if (catId != null) {
				query.setParameter("catId", catId);
			}

			return query.getSingleResult().intValue();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			em.close();
		}
	}

	public int countActive() {
		EntityManager em = getEntityManager();
		String jpql = "SELECT COUNT(s) FROM SanPham s WHERE s.trangThai = TRUE";
		try {
			return em.createQuery(jpql, Long.class).getSingleResult().intValue();
		} catch (Exception e) {
			throw new RuntimeException("Error counting active products", e);
		} finally {
			em.close();
		}
	}

	public List<SanPham> findPaged(int page, int pageSize, String q, Integer catId, String sort) {
		EntityManager em = getEntityManager();
		StringBuilder jpql = new StringBuilder("SELECT s FROM SanPham s WHERE 1=1 ");

		if (q != null && !q.isBlank()) {
			jpql.append(" AND (LOWER(s.tenSP) LIKE :keyword OR CAST(s.maSP AS string) LIKE :keyword) ");
		}
		if (catId != null) {
			jpql.append(" AND s.danhMuc.maDM = :catId ");
		}

		jpql.append(" ORDER BY ");
		switch (sort != null ? sort : "") {
		case "price_asc" -> jpql.append(" s.donGia ASC ");
		case "price_desc" -> jpql.append(" s.donGia DESC ");
		case "sold_desc" -> jpql.append(" s.soLuongBan DESC ");
		case "newest" -> jpql.append(" s.ngayTao DESC ");
		default -> jpql.append(" s.maSP DESC ");
		}

		try {
			TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);

			if (q != null && !q.isBlank()) {
				String kw = "%" + q.toLowerCase() + "%";
				query.setParameter("keyword", kw);
			}
			if (catId != null) {
				query.setParameter("catId", catId);
			}

			int offset = Math.max(0, (page - 1)) * pageSize;
			query.setFirstResult(offset);
			query.setMaxResults(pageSize);

			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	public boolean update(SanPham sp) {
		EntityManager em = getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();

			SanPham managedSp = em.find(SanPham.class, sp.getMaSP());
			if (managedSp == null) {
				trans.rollback();
				System.out.println("Không tìm thấy sản phẩm với MaSP: " + sp.getMaSP());
				return false;
			}

			System.out.println("ManagedSp cuaHang before update: "
					+ (managedSp.getCuaHang() != null ? managedSp.getCuaHang().getMaCH() : "NULL"));

			// Xử lý DanhMuc
			Integer maDMToUse = null;
			if (sp.getDanhMuc() != null && sp.getDanhMuc().getMaDM() != null) {
				maDMToUse = sp.getDanhMuc().getMaDM();
			} else if (sp.getMaDM() != null) {
				maDMToUse = sp.getMaDM();
			}
			if (maDMToUse != null) {
				DanhMuc dm = em.find(DanhMuc.class, maDMToUse);
				if (dm == null)
					throw new IllegalArgumentException("Danh mục (maDM) không tồn tại: " + maDMToUse);
				managedSp.setDanhMuc(dm);
			} else {
				throw new IllegalArgumentException("Thiếu thông tin Danh mục.");
			}

			// Xử lý CuaHang
			if (sp.getCuaHang() != null && sp.getCuaHang().getMaCH() != null) {
				CuaHang ch = em.find(CuaHang.class, sp.getCuaHang().getMaCH());
				if (ch == null)
					throw new IllegalArgumentException("Cửa hàng (maCH) không tồn tại: " + sp.getCuaHang().getMaCH());
				managedSp.setCuaHang(ch);
				System.out.println("Updated cuaHang MaCH: " + ch.getMaCH());
			} else if (managedSp.getCuaHang() == null) {
				throw new IllegalArgumentException(
						"Thiếu thông tin Cửa hàng và không thể cập nhật từ dữ liệu hiện tại.");
			}

			managedSp.setTenSP(sp.getTenSP());
			managedSp.setDonGia(sp.getDonGia());
			managedSp.setSoLuongTon(sp.getSoLuongTon());

			if (sp.getHinhAnh() != null && !sp.getHinhAnh().isEmpty()) {
				managedSp.setHinhAnh(sp.getHinhAnh());
			}

			managedSp.setMoTa(sp.getMoTa());
			managedSp.setTrangThai(sp.getTrangThai() != null ? sp.getTrangThai() : true);

			em.merge(managedSp);
			System.out.println("Merged cuaHang MaCH: "
					+ (managedSp.getCuaHang() != null ? managedSp.getCuaHang().getMaCH() : "NULL"));
			trans.commit();
			return true;
		} catch (Exception e) {
			if (trans.isActive()) {
				trans.rollback();
			}
			System.err.println("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public String findCategoryNameById(Integer maDM) {
		if (maDM == null)
			return null;
		EntityManager em = getEntityManager();
		try {
			DanhMuc dm = em.find(DanhMuc.class, maDM);
			return (dm != null) ? dm.getTenDM() : null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}
}