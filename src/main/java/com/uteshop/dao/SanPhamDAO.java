package com.uteshop.dao;

import com.uteshop.entity.CuaHang;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;
import com.uteshop.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.NoResultException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class SanPhamDAO {

	private EntityManager getEntityManager() {
		return JPAUtil.getEntityManager();
	}

	/* ===================== TOP & FILTER ===================== */

	public List<SanPham> findTopNProducts(int limit) {
		EntityManager em = getEntityManager();
		try {
			// Sửa lỗi Lazy: Thêm JOIN FETCH cho các quan hệ LAZY (CuaHang, DanhMuc)
			return em.createQuery(
					"SELECT s FROM SanPham s JOIN FETCH s.cuaHang JOIN FETCH s.danhMuc WHERE s.trangThai = TRUE ORDER BY s.soLuongBan DESC",
					SanPham.class).setMaxResults(limit).getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findTopNProductsByCategoryId(int limit, Integer categoryId) {
		EntityManager em = getEntityManager();
		try {
			// Sửa lỗi Lazy: Thêm JOIN FETCH cho các quan hệ LAZY (CuaHang)
			return em.createQuery(
					"SELECT s FROM SanPham s JOIN FETCH s.cuaHang WHERE s.trangThai = TRUE AND s.danhMuc.maDM = :cat ORDER BY s.soLuongBan DESC",
					SanPham.class).setParameter("cat", categoryId).setMaxResults(limit).getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	/* ===================== PAGINATION & FILTER ===================== */

	public List<SanPham> searchProducts(String keyword, Integer categoryId, String priceRange, String sort, int offset, int limit) {
		EntityManager em = getEntityManager();
		List<SanPham> result = new ArrayList<>();

		try {
			// ========================= ĐÃ SỬA LỖI =========================
			// Thêm "JOIN FETCH s.cuaHang JOIN FETCH s.danhMuc" để sửa lỗi LazyInitializationException
			StringBuilder jpql = new StringBuilder(
					"SELECT s FROM SanPham s JOIN FETCH s.cuaHang JOIN FETCH s.danhMuc WHERE s.trangThai = TRUE");
			// =============================================================

			// ----- Lọc từ khóa tìm kiếm -----
			if (keyword != null && !keyword.isBlank()) {
				jpql.append(" AND LOWER(s.tenSP) LIKE :keyword");
			}

			BigDecimal min = null;
			BigDecimal max = null;

			// ----- Bộ lọc giá -----
			if (priceRange != null && !priceRange.isBlank()) {
				if ("0-100000".equals(priceRange)) {
					max = new BigDecimal("100000");
					jpql.append(" AND s.donGia < :max");
				} else if ("100000-500000".equals(priceRange)) {
					min = new BigDecimal("100000");
					max = new BigDecimal("500000");
					jpql.append(" AND s.donGia >= :min AND s.donGia < :max");
				} else if ("500000-1000000".equals(priceRange)) {
					min = new BigDecimal("500000");
					max = new BigDecimal("1000000");
					jpql.append(" AND s.donGia >= :min AND s.donGia < :max");
				} else if ("1000000-".equals(priceRange)) {
					min = new BigDecimal("1000000");
					jpql.append(" AND s.donGia >= :min");
				}
			}

			// ----- Lọc danh mục -----
			if (categoryId != null && categoryId > 0) {
				jpql.append(" AND s.danhMuc.maDM = :categoryId");
			}

			// ----- Lọc sản phẩm bán chạy -----
			if ("bestseller".equalsIgnoreCase(sort)) {
				jpql.append(" AND s.soLuongBan > 10");
			}

			// ----- Sắp xếp -----
			if ("bestseller".equalsIgnoreCase(sort)) {
				jpql.append(" ORDER BY s.soLuongBan DESC");
			} else if ("price-asc".equalsIgnoreCase(sort)) {
				jpql.append(" ORDER BY s.donGia ASC");
			} else if ("price-desc".equalsIgnoreCase(sort)) {
				jpql.append(" ORDER BY s.donGia DESC");
			} else {
				jpql.append(" ORDER BY s.ngayTao DESC");
			}

			TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);

			// ----- Set tham số -----
			if (keyword != null && !keyword.isBlank()) {
				query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
			}
			if (min != null)
				query.setParameter("min", min);
			if (max != null)
				query.setParameter("max", max);
			if (categoryId != null && categoryId > 0)
				query.setParameter("categoryId", categoryId);

			query.setFirstResult(offset);
			query.setMaxResults(limit);

			result = query.getResultList();

		} catch (Exception e) {
			System.err.println("Error in SanPhamDAO.searchProducts: " + e.getMessage());
			e.printStackTrace();
		} finally {
			em.close();
		}

		return result;
	}

	public long countSearchResults(String keyword, Integer categoryId, String priceRange) {
		EntityManager em = getEntityManager();
		StringBuilder jpql = new StringBuilder("SELECT COUNT(s) FROM SanPham s WHERE s.trangThai = TRUE");

		// ----- Lọc từ khóa tìm kiếm -----
		if (keyword != null && !keyword.isBlank()) {
			jpql.append(" AND LOWER(s.tenSP) LIKE :keyword");
		}
		
		BigDecimal min = null;
		BigDecimal max = null;

		if (priceRange != null && !priceRange.isBlank()) {
			if ("0-100000".equals(priceRange)) {
				max = new BigDecimal("100000");
				jpql.append(" AND s.donGia < :max");
			} else if ("100000-500000".equals(priceRange)) {
				min = new BigDecimal("100000");
				max = new BigDecimal("500000");
				jpql.append(" AND s.donGia >= :min AND s.donGia < :max");
			} else if ("500000-1000000".equals(priceRange)) {
				min = new BigDecimal("500000");
				max = new BigDecimal("1000000");
				jpql.append(" AND s.donGia >= :min AND s.donGia < :max");
			} else if ("1000000-".equals(priceRange)) {
				min = new BigDecimal("1000000");
				jpql.append(" AND s.donGia >= :min");
			}
		}

		if (categoryId != null && categoryId > 0)
			jpql.append(" AND s.danhMuc.maDM = :categoryId");

		// (Lưu ý: Bỏ logic 'bestseller' ở đây vì hàm đếm không nên phụ thuộc vào 'sort')

		try {
			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);

			// ----- Set tham số -----
			if (keyword != null && !keyword.isBlank()) {
				query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
			}
			if (min != null)
				query.setParameter("min", min);
			if (max != null)
				query.setParameter("max", max);
			if (categoryId != null && categoryId > 0)
				query.setParameter("categoryId", categoryId);

			return query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			em.close();
		}
	}
	/* ===================== FIND BY ID/STORE/CATEGORY ===================== */

	public SanPham findById(Integer id) {
		EntityManager em = getEntityManager();
		try {
			return em.createQuery(
					"SELECT s FROM SanPham s LEFT JOIN FETCH s.danhMuc LEFT JOIN FETCH s.cuaHang WHERE s.maSP = :id",
					SanPham.class).setParameter("id", id).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} finally {
			em.close();
		}
	}

	public List<SanPham> findByCategoryId(Integer categoryId) {
		EntityManager em = getEntityManager();
		try {
			// Sửa lỗi Lazy: Thêm JOIN FETCH
			return em.createQuery(
					"SELECT s FROM SanPham s JOIN FETCH s.cuaHang WHERE s.trangThai = TRUE AND s.danhMuc.maDM = :cat ORDER BY s.soLuongBan DESC",
					SanPham.class).setParameter("cat", categoryId).getResultList();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findByStoreId(int maCH) {
		EntityManager em = getEntityManager();
		try {
			// Sửa lỗi Lazy: Thêm JOIN FETCH
			return em.createQuery("SELECT s FROM SanPham s JOIN FETCH s.danhMuc WHERE s.cuaHang.maCH = :store AND s.trangThai = TRUE",
					SanPham.class).setParameter("store", maCH).getResultList();
		} finally {
			em.close();
		}
	}

	/* ===================== CRUD ===================== */

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
				sp.setMaCH(ch.getMaCH());
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

	public boolean update(SanPham sp) {
		EntityManager em = getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();

			// Tìm sản phẩm hiện tại trong database
			SanPham managed = em.find(SanPham.class, sp.getMaSP());
			if (managed == null) {
				System.err.println("Không tìm thấy sản phẩm với MaSP: " + sp.getMaSP());
				tx.rollback();
				return false;
			}

			// Cập nhật các trường cơ bản
			managed.setTenSP(sp.getTenSP());
			managed.setMoTa(sp.getMoTa());
			managed.setDonGia(sp.getDonGia());
			managed.setSoLuongTon(sp.getSoLuongTon());
			managed.setTrangThai(sp.getTrangThai());
			managed.setNgayCapNhat(new java.util.Date());

			// Cập nhật ảnh nếu có ảnh mới
			if (sp.getHinhAnh() != null && !sp.getHinhAnh().trim().isEmpty()) {
				managed.setHinhAnh(sp.getHinhAnh());
				System.out.println("Updated product image to: " + sp.getHinhAnh());
			}

			// Cập nhật danh mục nếu có thay đổi
			if (sp.getMaDM() != null) {
				DanhMuc dm = em.find(DanhMuc.class, sp.getMaDM());
				if (dm == null) {
					System.err.println("Danh mục không tồn tại: " + sp.getMaDM());
					tx.rollback();
					return false;
				}
				managed.setDanhMuc(dm);
				managed.setMaDM(sp.getMaDM());
				System.out.println("Updated product category to: " + dm.getTenDM());
			}

			// Merge để lưu thay đổi
			em.merge(managed);
			System.out.println("Successfully updated product with MaSP: " + sp.getMaSP());

			tx.commit();
			return true;

		} catch (Exception e) {
			if (tx.isActive()) {
				tx.rollback();
			}
			System.err.println("Error updating product: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public boolean delete(SanPham sp) {
		EntityManager em = getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();

			// Kiểm tra xem sản phẩm có tồn tại không
			SanPham managedSp = em.find(SanPham.class, sp.getMaSP());
			if (managedSp == null) {
				trans.rollback();
				System.out.println("Không tìm thấy sản phẩm với MaSP: " + sp.getMaSP());
				return false;
			}

			// Xóa sản phẩm
			em.remove(managedSp);
			System.out.println("Đã xóa sản phẩm với MaSP: " + sp.getMaSP());
			trans.commit();
			return true;
		} catch (Exception e) {
			if (trans.isActive()) {
				trans.rollback();
			}
			System.err.println("Lỗi khi xóa sản phẩm: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public void updateSanPhamTextFields(SanPham sp) {
		EntityManager em = getEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			SanPham managed = em.find(SanPham.class, sp.getMaSP());
			if (managed != null) {
				managed.setTenSP(sp.getTenSP());
				managed.setMoTa(sp.getMoTa());
				managed.setHinhAnh(sp.getHinhAnh());
				em.merge(managed);
			}
			tx.commit();
		} catch (Exception e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		} finally {
			em.close();
		}
	}

	/* ===================== ADMIN SUPPORT ===================== */

	public int countAll(String q, Integer catId) {
		EntityManager em = getEntityManager();
		String jpql = "SELECT COUNT(s) FROM SanPham s WHERE s.trangThai = TRUE";
		if (q != null && !q.isBlank())
			jpql += " AND LOWER(s.tenSP) LIKE :kw";
		if (catId != null)
			jpql += " AND s.danhMuc.maDM = :cat";

		try {
			TypedQuery<Long> query = em.createQuery(jpql, Long.class);
			if (q != null && !q.isBlank())
				query.setParameter("kw", "%" + q.toLowerCase() + "%");
			if (catId != null)
				query.setParameter("cat", catId);
			return query.getSingleResult().intValue();
		} finally {
			em.close();
		}
	}

	public List<DanhMuc> listCategories() {
		EntityManager em = getEntityManager();
		try {
			return em.createQuery("SELECT d FROM DanhMuc d ORDER BY d.tenDM ASC", DanhMuc.class).getResultList();
		} finally {
			em.close();
		}
	}

	public String findCategoryNameById(Integer maDM) {
		EntityManager em = getEntityManager();
		try {
			DanhMuc dm = em.find(DanhMuc.class, maDM);
			return dm != null ? dm.getTenDM() : null;
		} finally {
			em.close();
		}
	}
// ====== LEGACY COMPATIBILITY METHODS ======

	/** Giữ cho các class cũ như ProductTextNormalizerService hoạt động */
	/** Giữ cho các class cũ như ProductTextNormalizerService hoạt động */
	public List<SanPham> getAllProducts() {
		// Sửa lại đúng thứ tự tham số: (keyword, categoryId, priceRange, sort, offset, limit)
		return searchProducts(null, null, null, "bestseller", 0, 1000); 
	}

	/** Dành cho AdminProductsController (giữ chữ ký cũ) */
	public List<SanPham> findPaged(int page, int pageSize, String q, Integer catId, String sort) {
		EntityManager em = getEntityManager();
		List<SanPham> result = new ArrayList<>();

		try {
			// ========================= ĐÃ SỬA LỖI =========================
			// Thêm "JOIN FETCH s.cuaHang JOIN FETCH s.danhMuc" để sửa lỗi LazyInitializationException
			StringBuilder jpql = new StringBuilder(
					"SELECT s FROM SanPham s JOIN FETCH s.cuaHang JOIN FETCH s.danhMuc WHERE s.trangThai = TRUE");
			// =============================================================

			// Lọc theo từ khóa tìm kiếm
			if (q != null && !q.isBlank()) {
				jpql.append(" AND LOWER(s.tenSP) LIKE :kw");
			}

			// Lọc theo danh mục
			if (catId != null && catId > 0) {
				jpql.append(" AND s.danhMuc.maDM = :categoryId");
			}

			// Sắp xếp
			if ("price_asc".equalsIgnoreCase(sort)) {
				jpql.append(" ORDER BY s.donGia ASC");
			} else if ("price_desc".equalsIgnoreCase(sort)) {
				jpql.append(" ORDER BY s.donGia DESC");
			} else if ("sold_desc".equalsIgnoreCase(sort)) {
				jpql.append(" ORDER BY s.soLuongBan DESC");
			} else if ("newest".equalsIgnoreCase(sort)) {
				jpql.append(" ORDER BY s.ngayTao DESC");
			} else {
				jpql.append(" ORDER BY s.maSP DESC");
			}

			TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);

			if (q != null && !q.isBlank()) {
				query.setParameter("kw", "%" + q.toLowerCase() + "%");
			}
			if (catId != null && catId > 0) {
				query.setParameter("categoryId", catId);
			}

			int offset = Math.max(0, (page - 1)) * pageSize;
			query.setFirstResult(offset);
			query.setMaxResults(pageSize);

			result = query.getResultList();

		} catch (Exception e) {
			System.err.println("Error in SanPhamDAO.findPaged: " + e.getMessage());
			e.printStackTrace();
		} finally {
			em.close();
		}

		return result;
	}

	/** Dành cho ProductController (giữ tương thích cũ) */
	public List<SanPham> findByStore(Integer storeId, int limit) {
		EntityManager em = getEntityManager();
		try {
			// Sửa lỗi Lazy: Thêm JOIN FETCH
			return em.createQuery(
					"SELECT s FROM SanPham s JOIN FETCH s.danhMuc WHERE s.cuaHang.maCH = :store AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC",
					SanPham.class).setParameter("store", storeId).setMaxResults(limit).getResultList();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findByCuaHangId(Integer maCH) {
		EntityManager em = getEntityManager();
		try {
			TypedQuery<SanPham> query = em.createQuery(
					"SELECT s FROM SanPham s JOIN FETCH s.danhMuc WHERE s.cuaHang.maCH = :maCH", SanPham.class);
			query.setParameter("maCH", maCH);
			return query.getResultList();
		} finally {
			em.close();
		}
	}

	/**
	 * Tìm sản phẩm theo cửa hàng với filter, search và pagination
	 */
	public List<SanPham> findByCuaHangIdWithFilter(Integer maCH, String searchKeyword, String sortBy,
			String statusFilter, int offset, int limit) {
		EntityManager em = getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder(
					"SELECT s FROM SanPham s LEFT JOIN FETCH s.danhMuc WHERE s.cuaHang.maCH = :maCH");

			// Bộ lọc từ khóa tìm kiếm
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				jpql.append(" AND (LOWER(s.tenSP) LIKE :keyword OR LOWER(s.moTa) LIKE :keyword)");
			}

			// Bộ lọc trạng thái
			if (statusFilter != null && !statusFilter.trim().isEmpty()) {
				if ("true".equals(statusFilter)) {
					jpql.append(" AND s.trangThai = true");
				} else if ("false".equals(statusFilter)) {
					jpql.append(" AND s.trangThai = false");
				}
			}

			// Sắp xếp
			if ("name-asc".equals(sortBy)) {
				jpql.append(" ORDER BY s.tenSP ASC");
			} else if ("name-desc".equals(sortBy)) {
				jpql.append(" ORDER BY s.tenSP DESC");
			} else if ("price-asc".equals(sortBy)) {
				jpql.append(" ORDER BY s.donGia ASC");
			} else if ("price-desc".equals(sortBy)) {
				jpql.append(" ORDER BY s.donGia DESC");
			} else if ("stock-asc".equals(sortBy)) {
				jpql.append(" ORDER BY s.soLuongTon ASC");
			} else if ("stock-desc".equals(sortBy)) {
				jpql.append(" ORDER BY s.soLuongTon DESC");
			} else if ("status".equals(sortBy)) {
				jpql.append(" ORDER BY s.trangThai DESC");
			} else {
				jpql.append(" ORDER BY s.ngayTao DESC");
			}

			TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);
			query.setParameter("maCH", maCH);

			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				String keyword = "%" + searchKeyword.toLowerCase().trim() + "%";
				query.setParameter("keyword", keyword);
			}

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

	/**
	 * Đếm số lượng sản phẩm theo cửa hàng với filter
	 */
	public int countByCuaHangIdWithFilter(Integer maCH, String searchKeyword, String statusFilter) {
		EntityManager em = getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(s) FROM SanPham s WHERE s.cuaHang.maCH = :maCH");

			// Bộ lọc từ khóa tìm kiếm
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				jpql.append(" AND (LOWER(s.tenSP) LIKE :keyword OR LOWER(s.moTa) LIKE :keyword)");
			}

			// Bộ lọc trạng thái
			if (statusFilter != null && !statusFilter.trim().isEmpty()) {
				if ("true".equals(statusFilter)) {
					jpql.append(" AND s.trangThai = true");
				} else if ("false".equals(statusFilter)) {
					jpql.append(" AND s.trangThai = false");
				}
			}

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			query.setParameter("maCH", maCH);

			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				String keyword = "%" + searchKeyword.toLowerCase().trim() + "%";
				query.setParameter("keyword", keyword);
			}

			return query.getSingleResult().intValue();

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			em.close();
		}
	}

	public int countByShop(int shopId, String q, Integer categoryId, Boolean active) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(p) FROM SanPham p WHERE p.maCH = :shop ");
			if (notBlank(q)) {
				jpql.append(" AND (LOWER(p.tenSP) LIKE :kw OR LOWER(p.moTa) LIKE :kw) ");
			}
			if (categoryId != null) {
				jpql.append(" AND p.maDM = :cat ");
			}
			if (active != null) {
				jpql.append(" AND p.trangThai = :act ");
			}

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			query.setParameter("shop", shopId);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (categoryId != null)
				query.setParameter("cat", categoryId);
			if (active != null)
				query.setParameter("act", active);

			Long c = query.getSingleResult();
			return c == null ? 0 : c.intValue();
		} finally {
			em.close();
		}
	}

	public List<SanPham> findPagedByShop(int shopId, int page, int pageSize, String q, Integer categoryId,
			Boolean active, String sort) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			// Sửa lỗi Lazy: Thêm JOIN FETCH
			StringBuilder jpql = new StringBuilder("SELECT p FROM SanPham p JOIN FETCH p.danhMuc WHERE p.maCH = :shop ");
			if (notBlank(q)) {
				jpql.append(" AND (LOWER(p.tenSP) LIKE :kw OR LOWER(p.moTa) LIKE :kw) ");
			}
			if (categoryId != null) {
				jpql.append(" AND p.maDM = :cat ");
			}
			if (active != null) {
				jpql.append(" AND p.trangThai = :act ");
			}

// sort an toàn
			jpql.append(" ORDER BY ");
			switch (safeSort(sort)) {
			case "price_asc" -> jpql.append(" p.donGia ASC ");
			case "price_desc" -> jpql.append(" p.donGia DESC ");
			case "name_asc" -> jpql.append(" p.tenSP ASC ");
			case "name_desc" -> jpql.append(" p.tenSP DESC ");
			case "date_desc" -> jpql.append(" p.ngayTao DESC ");
			default -> jpql.append(" p.ngayTao DESC ");
			}

			TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);
			query.setParameter("shop", shopId);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (categoryId != null)
				query.setParameter("cat", categoryId);
			if (active != null)
				query.setParameter("act", active);

			int first = Math.max(0, (page - 1) * pageSize);
			return query.setFirstResult(first).setMaxResults(pageSize).getResultList();
		} finally {
			em.close();
		}
	}

	private boolean notBlank(String s) {
		return s != null && !s.trim().isEmpty();
	}

	private String safeSort(String sort) {
		if (sort == null)
			return "";
		return switch (sort) {
		case "price_asc", "price_desc", "name_asc", "name_desc", "date_desc" -> sort;
		default -> "";
		};
	}

	/**
	 * Đếm tổng số lượng sản phẩm theo cửa hàng (không filter)
	 */
	public int countByCuaHangId(Integer maCH) {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT COUNT(s) FROM SanPham s WHERE s.cuaHang.maCH = :maCH";
			TypedQuery<Long> query = em.createQuery(jpql, Long.class);
			query.setParameter("maCH", maCH);
			return query.getSingleResult().intValue();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy top sản phẩm bán chạy nhất theo cửa hàng
	 */
	public List<SanPham> findTopSellingByStore(Integer maCH, int limit) {
		EntityManager em = getEntityManager();
		try {
			// Sửa lỗi Lazy: Thêm JOIN FETCH
			String jpql = "SELECT s FROM SanPham s " 
					+ "JOIN FETCH s.danhMuc "
					+ "WHERE s.cuaHang.maCH = :maCH AND s.trangThai = true "
					+ "ORDER BY s.soLuongBan DESC";
			TypedQuery<SanPham> query = em.createQuery(jpql, SanPham.class);
			query.setParameter("maCH", maCH);
			query.setMaxResults(limit);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy sản phẩm bán chạy theo cửa hàng với số lượng đã bán Trả về: [SanPham,
	 * soLuongDaBan]
	 */
	/**
	 * Lấy top sản phẩm bán chạy nhất của cửa hàng (với số lượng đã bán)
	 * Fixed: Include both DA_GIAO and HOAN_THANH status
	 */
	public List<Object[]> findTopSellingWithQuantityByStore(Integer maCH, int limit) {
		EntityManager em = getEntityManager();
		try {
			String jpql = "SELECT s, COALESCE(SUM(ctdh.soLuong), 0) as totalSold " + "FROM SanPham s "
					+ "JOIN FETCH s.danhMuc " // Sửa lỗi Lazy
					+ "LEFT JOIN s.chiTietDonHangs ctdh " + "LEFT JOIN ctdh.donHang dh "
					+ "WHERE s.cuaHang.maCH = :maCH " + "  AND s.trangThai = true "
					+ "  AND (dh.trangThai = com.uteshop.entity.DonHang.TrangThaiDonHang.DA_GIAO "
					+ "       OR dh.trangThai = com.uteshop.entity.DonHang.TrangThaiDonHang.HOAN_THANH "
					+ "       OR dh.trangThai IS NULL) " + "GROUP BY s, s.maSP, s.tenSP, s.moTa, s.donGia, s.soLuongTon, s.soLuongBan, s.hinhAnh, s.trangThai, s.ngayTao, s.ngayCapNhat, s.luotXem, s.luotYeuThich, s.diemDanhGiaTrungBinh, s.soLuongDanhGia, s.maDM, s.maCH, s.danhMuc.maDM, s.danhMuc.tenDM, s.danhMuc.hinhAnhDM, s.danhMuc.ngayTao " // Cần GROUP BY tất cả các trường non-aggregated của SanPham VÀ DanhMuc (vì đã JOIN FETCH)
					+ "ORDER BY totalSold DESC";
			TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
			query.setParameter("maCH", maCH);
			query.setMaxResults(limit);
			
			List<Object[]> results = query.getResultList();
			System.out.println("✅ Found " + results.size() + " top selling products for store #" + maCH);
			return results;
		} catch (Exception e) {
			System.err.println("❌ Error in findTopSellingWithQuantityByStore: " + e.getMessage());
			e.printStackTrace();
			return new ArrayList<>();
		} finally {
			em.close();
		}
	}

}