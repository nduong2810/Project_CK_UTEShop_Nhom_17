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
            return em.createQuery(
                            "SELECT s FROM SanPham s WHERE s.trangThai = TRUE ORDER BY s.soLuongBan DESC",
                            SanPham.class)
                    .setMaxResults(limit)
                    .getResultList();
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
            return em.createQuery(
                            "SELECT s FROM SanPham s WHERE s.trangThai = TRUE AND s.danhMuc.maDM = :cat ORDER BY s.soLuongBan DESC",
                            SanPham.class)
                    .setParameter("cat", categoryId)
                    .setMaxResults(limit)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /* ===================== PAGINATION & FILTER ===================== */

    public List<SanPham> findAll(int offset, int limit, String sort, String price, Integer categoryId) {
        EntityManager em = getEntityManager();
        List<SanPham> result = new ArrayList<>();

        try {
            StringBuilder jpql = new StringBuilder("SELECT s FROM SanPham s WHERE s.trangThai = TRUE");

            BigDecimal min = null;
            BigDecimal max = null;

            // ----- Bộ lọc giá -----
            if (price != null && !price.isBlank()) {
                price = price.replace("₫", "")
                        .replace(",", "")
                        .replace(" ", "")
                        .toLowerCase();

                if (price.contains("0-100000") || price.contains("duoi100000")) {
                    max = new BigDecimal("100000");
                    jpql.append(" AND s.donGia < :max");

                } else if (price.contains("100000-500000")) {
                    min = new BigDecimal("100000");
                    max = new BigDecimal("500000");
                    jpql.append(" AND s.donGia BETWEEN :min AND :max");

                } else if (price.contains("500000-1000000")) {
                    min = new BigDecimal("500000");
                    max = new BigDecimal("1000000");
                    jpql.append(" AND s.donGia BETWEEN :min AND :max");

                } else if (price.contains("1000000") || price.contains("tren1000000") || price.contains("over1000000")) {
                    min = new BigDecimal("1000000");
                    jpql.append(" AND s.donGia >= :min");
                }
            }

            // ----- Lọc danh mục -----
            if (categoryId != null && categoryId > 0) {
                jpql.append(" AND s.maDM = :categoryId");
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

            if (min != null) query.setParameter("min", min);
            if (max != null) query.setParameter("max", max);
            if (categoryId != null && categoryId > 0) query.setParameter("categoryId", categoryId);

            query.setFirstResult(offset);
            query.setMaxResults(limit);

            result = query.getResultList();

        } catch (Exception e) {
            System.err.println("Error in SanPhamDAO.findAll: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }

        return result;
    }

    public long countProducts(String sortBy, String priceRange, Integer categoryId) {
        EntityManager em = getEntityManager();
        StringBuilder jpql = new StringBuilder("SELECT COUNT(s) FROM SanPham s WHERE s.trangThai = TRUE");

        BigDecimal min = null;
        BigDecimal max = null;

        if (priceRange != null && !priceRange.isBlank()) {
            priceRange = priceRange.replace("₫", "")
                    .replace(",", "")
                    .replace(" ", "")
                    .toLowerCase();

            if (priceRange.contains("0-100000") || priceRange.contains("duoi100000")) {
                max = new BigDecimal("100000");
                jpql.append(" AND s.donGia < :max");

            } else if (priceRange.contains("100000-500000")) {
                min = new BigDecimal("100000");
                max = new BigDecimal("500000");
                jpql.append(" AND s.donGia BETWEEN :min AND :max");

            } else if (priceRange.contains("500000-1000000")) {
                min = new BigDecimal("500000");
                max = new BigDecimal("1000000");
                jpql.append(" AND s.donGia BETWEEN :min AND :max");

            } else if (priceRange.contains("1000000") || priceRange.contains("tren1000000") || priceRange.contains("over1000000")) {
                min = new BigDecimal("1000000");
                jpql.append(" AND s.donGia >= :min");
            }
        }

        if (categoryId != null && categoryId > 0)
            jpql.append(" AND s.maDM = :categoryId");
        if ("bestseller".equalsIgnoreCase(sortBy))
            jpql.append(" AND s.soLuongBan > 10");

        try {
            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (min != null) query.setParameter("min", min);
            if (max != null) query.setParameter("max", max);
            if (categoryId != null && categoryId > 0) query.setParameter("categoryId", categoryId);

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
                            SanPham.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<SanPham> findByCategoryId(Integer categoryId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT s FROM SanPham s WHERE s.trangThai = TRUE AND s.danhMuc.maDM = :cat ORDER BY s.soLuongBan DESC",
                            SanPham.class)
                    .setParameter("cat", categoryId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<SanPham> findByStoreId(int maCH) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT s FROM SanPham s WHERE s.cuaHang.maCH = :store AND s.trangThai = TRUE",
                            SanPham.class)
                    .setParameter("store", maCH)
                    .getResultList();
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
            
            System.out.println("MaCH before processing: " + (sp.getCuaHang() != null ? sp.getCuaHang().getMaCH() : "NULL"));
            
            // Xử lý DanhMuc
            if (sp.getMaDM() != null) {
                DanhMuc dm = em.find(DanhMuc.class, sp.getMaDM());
                if (dm == null) throw new IllegalArgumentException("Danh mục (maDM) không tồn tại: " + sp.getMaDM());
                sp.setDanhMuc(dm);
            } else {
                throw new IllegalArgumentException("Thiếu thông tin Danh mục.");
            }
            
            // Xử lý CuaHang
            if (sp.getCuaHang() != null && sp.getCuaHang().getMaCH() != null) {
                CuaHang ch = em.find(CuaHang.class, sp.getCuaHang().getMaCH());
                if (ch == null) throw new IllegalArgumentException("Cửa hàng (maCH) không tồn tại.");
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
            if (trans.isActive()) trans.rollback();
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
            SanPham managed = em.find(SanPham.class, sp.getMaSP());
            if (managed != null) {
                managed.setTenSP(sp.getTenSP());
                managed.setMoTa(sp.getMoTa());
                managed.setDonGia(sp.getDonGia());
                managed.setSoLuongTon(sp.getSoLuongTon());
                if (sp.getHinhAnh() != null) managed.setHinhAnh(sp.getHinhAnh());
                managed.setTrangThai(sp.getTrangThai());
                em.merge(managed);
            }
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
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
            if (tx.isActive()) tx.rollback();
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
            return em.createQuery("SELECT d FROM DanhMuc d ORDER BY d.tenDM ASC", DanhMuc.class)
                    .getResultList();
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
    public List<SanPham> getAllProducts() {
        return findAll(0, 1000, "bestseller", null, null);
    }

    /** Dành cho AdminProductsController (giữ chữ ký cũ) */
    public List<SanPham> findPaged(int page, int pageSize, String q, Integer catId, String sort) {
        int offset = Math.max(0, (page - 1)) * pageSize;
        return findAll(offset, pageSize, sort, null, catId);
    }

    /** Dành cho ProductController (giữ tương thích cũ) */
    public List<SanPham> findByStore(Integer storeId, int limit) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT s FROM SanPham s WHERE s.cuaHang.maCH = :store AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC",
                            SanPham.class)
                    .setParameter("store", storeId)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
