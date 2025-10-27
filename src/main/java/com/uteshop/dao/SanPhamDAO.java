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
            StringBuilder jpql = new StringBuilder(
                "SELECT COUNT(s) FROM SanPham s WHERE s.cuaHang.maCH = :maCH");
            
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
            String jpql = "SELECT s FROM SanPham s " +
                         "WHERE s.cuaHang.maCH = :maCH AND s.trangThai = true " +
                         "ORDER BY s.soLuongBan DESC";
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
     * Lấy sản phẩm bán chạy theo cửa hàng với số lượng đã bán
     * Trả về: [SanPham, soLuongDaBan]
     */
    public List<Object[]> findTopSellingWithQuantityByStore(Integer maCH, int limit) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT s, COALESCE(SUM(ctdh.soLuong), 0) as totalSold " +
                         "FROM SanPham s " +
                         "LEFT JOIN s.chiTietDonHangs ctdh " +
                         "LEFT JOIN ctdh.donHang dh " +
                         "WHERE s.cuaHang.maCH = :maCH " +
                         "  AND s.trangThai = true " +
                         "  AND (dh.trangThai = com.uteshop.entity.DonHang.TrangThaiDonHang.DA_GIAO " +
                         "       OR dh.trangThai IS NULL) " +
                         "GROUP BY s " +
                         "ORDER BY totalSold DESC";
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
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
}