package com.uteshop.dao;

import com.uteshop.entity.CuaHang;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;
import com.uteshop.util.JPAUtil; // Sử dụng JPAUtil đã tạo trước đó

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SanPhamDAO {

    // Phương thức chung để lấy EntityManager
    private EntityManager getEntityManager() {
        return JPAUtil.getEntityManager();
    }

    /**
     * Helper method to create dynamic JPQL query for filtering and counting
     */
    private void buildProductQuery(StringBuilder jpql, List<Object> params, Integer categoryId, String sortBy, String priceRange, boolean isCount) {
        // Chỉ chọn các sản phẩm đang hoạt động
        jpql.append(" WHERE s.trangThai = TRUE ");

        if (categoryId != null && categoryId > 0) {
            jpql.append(" AND s.danhMuc.maDM = :categoryId "); // Sử dụng quan hệ s.danhMuc.maDM
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

    /**
     * Helper method to set dynamic parameters for a query
     */
    private TypedQuery<SanPham> setProductQueryParams(TypedQuery<SanPham> query, Integer categoryId, String sortBy, String priceRange) {
        // Logic giống hệt setCountQueryParams, nhưng trả về TypedQuery<SanPham>
        if (categoryId != null && categoryId > 0) {
            query.setParameter("categoryId", categoryId);
        }
        // ... (còn lại logic thiết lập tham số cho giá)
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

    // -------------------------------------------------------------------------
    // FIND OPERATIONS
    // -------------------------------------------------------------------------

    /**
     * Find top N products by sales
     */
    public List<SanPham> findTopNProducts(int limit) {
        EntityManager em = getEntityManager();
        // Sắp xếp theo SoLuongBan DESC (bán chạy nhất)
        String jpql = "SELECT s FROM SanPham s WHERE s.trangThai = TRUE ORDER BY s.soLuongBan DESC, s.maSP ASC";
        try {
            return em.createQuery(jpql, SanPham.class)
                     .setMaxResults(limit)
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Find top N products by category
     */
    public List<SanPham> findTopNProductsByCategoryId(int limit, Integer categoryId) {
        EntityManager em = getEntityManager();
        String jpql = "SELECT s FROM SanPham s WHERE s.trangThai = TRUE AND s.danhMuc.maDM = :categoryId ORDER BY s.soLuongBan DESC, s.maSP ASC";
        try {
            return em.createQuery(jpql, SanPham.class)
                     .setParameter("categoryId", categoryId)
                     .setMaxResults(limit)
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
            return em.createQuery(jpql, SanPham.class)
                     .setParameter("maCH", maCH)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Insert a new product (ĐÃ CẬP NHẬT để xử lý Entity liên quan)
     */
    public boolean insert(SanPham sp) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            // Xử lý DanhMuc (TÌM Entity DanhMuc từ ID được gán trong Controller)
            if (sp.getDanhMuc() != null && sp.getDanhMuc().getMaDM() != null) {
                 DanhMuc dm = em.find(DanhMuc.class, sp.getDanhMuc().getMaDM());
                 if (dm == null) throw new IllegalArgumentException("Danh mục (maDM) không tồn tại.");
                 sp.setDanhMuc(dm);
            } else {
                 throw new IllegalArgumentException("Thiếu thông tin Danh mục.");
            }
            
            // Xử lý CuaHang (TÌM Entity CuaHang)
            if (sp.getCuaHang() != null && sp.getCuaHang().getMaCH() != null) {
                 CuaHang ch = em.find(CuaHang.class, sp.getCuaHang().getMaCH());
                 if (ch == null) throw new IllegalArgumentException("Cửa hàng (maCH) không tồn tại.");
                 sp.setCuaHang(ch);
            } else {
                throw new IllegalArgumentException("Thiếu thông tin Cửa hàng.");
            }
            
            // Thiết lập trạng thái và ngày tạo mặc định nếu cần
            if (sp.getTrangThai() == null) {
                sp.setTrangThai(true); 
            }
            // sp.setNgayTao(new Date()); // Nếu có trường ngày tạo

            em.persist(sp);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            // In chi tiết lỗi để dễ dàng debug
            System.err.println("Lỗi khi thêm sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Find all products with pagination, filtering, and sorting
     */
    public List<SanPham> findAll(int offset, int limit, String sortBy, String priceRange, Integer categoryId) {
        EntityManager em = getEntityManager();
        StringBuilder jpql = new StringBuilder("SELECT s FROM SanPham s");
        
        // 1. Xây dựng JPQL WHERE clauses
        buildProductQuery(jpql, new ArrayList<>(), categoryId, sortBy, priceRange, false);

        // 2. Xây dựng ORDER BY clause
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
            case "bestseller": // Mặc định bestseller (cũng là default)
            default:
                orderByClause = " ORDER BY s.soLuongBan DESC, s.maSP ASC";
                break;
        }
        jpql.append(orderByClause);

        try {
            TypedQuery<SanPham> query = em.createQuery(jpql.toString(), SanPham.class);
            
            // 3. Set Parameters
            query = setProductQueryParams(query, categoryId, sortBy, priceRange);
            
            // 4. Set Pagination
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
     * Count products based on filters
     */
    private TypedQuery<Long> setCountQueryParams(TypedQuery<Long> query, Integer categoryId, String sortBy, String priceRange) {
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

        // 1. Xây dựng JPQL WHERE clauses
        buildProductQuery(jpql, new ArrayList<>(), categoryId, sortBy, priceRange, true);

        try {
            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);

            // 2. Set Parameters (Sử dụng hàm mới hoặc sửa lại hàm cũ)
            // Loại bỏ dòng lỗi: query = (TypedQuery<Long>) setProductQueryParams((TypedQuery<SanPham>) query, categoryId, sortBy, priceRange);
            query = setCountQueryParams(query, categoryId, sortBy, priceRange); 

            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Find product by ID
     */
    public SanPham findById(Integer id) {
        EntityManager em = getEntityManager();
        try {
            // JPA find() tự động xử lý và load các entity liên quan (DanhMuc, CuaHang)
            return em.find(SanPham.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Find products by category ID
     */
    public List<SanPham> findByCategoryId(Integer categoryId) {
        EntityManager em = getEntityManager();
        String jpql = "SELECT s FROM SanPham s WHERE s.danhMuc.maDM = :categoryId AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
        try {
            return em.createQuery(jpql, SanPham.class)
                     .setParameter("categoryId", categoryId)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Find products by store ID
     */
    public List<SanPham> findByStoreId(int storeId) {
        EntityManager em = getEntityManager();
        String jpql = "SELECT s FROM SanPham s WHERE s.cuaHang.maCH = :storeId AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
        try {
            return em.createQuery(jpql, SanPham.class)
                     .setParameter("storeId", storeId)
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Find top N products by store ID
     */
    public List<SanPham> findByStore(Integer storeId, int limit) {
        EntityManager em = getEntityManager();
        String jpql = "SELECT s FROM SanPham s WHERE s.cuaHang.maCH = :storeId AND s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
        try {
            return em.createQuery(jpql, SanPham.class)
                     .setParameter("storeId", storeId)
                     .setMaxResults(limit)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Get all active products
     */
    public List<SanPham> getAllProducts() {
        EntityManager em = getEntityManager();
        String jpql = "SELECT s FROM SanPham s WHERE s.trangThai = TRUE ORDER BY s.soLuongBan DESC";
        try {
            return em.createQuery(jpql, SanPham.class).getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Update SanPham's text fields (TenSP, MoTa, HinhAnh)
     */
    public void updateSanPhamTextFields(SanPham sp) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            // Lấy entity đang được quản lý
            SanPham managedSp = em.find(SanPham.class, sp.getMaSP());
            if (managedSp != null) {
                // Cập nhật các trường cụ thể
                managedSp.setTenSP(sp.getTenSP());
                managedSp.setMoTa(sp.getMoTa());
                managedSp.setHinhAnh(sp.getHinhAnh());
                em.merge(managedSp); // Đảm bảo entity được cập nhật (nếu cần)
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy danh sách danh mục (cần được chuyển sang DanhMucDAO)
     */
    public List<DanhMuc> listCategories() {
        EntityManager em = getEntityManager();
        String jpql = "SELECT d FROM DanhMuc d ORDER BY d.tenDM ASC";
        try {
            return em.createQuery(jpql, DanhMuc.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Count all products with filtering
     */
    public int countAll(String q, Integer catId) {
        EntityManager em = getEntityManager();
        StringBuilder jpql = new StringBuilder("SELECT COUNT(s) FROM SanPham s WHERE 1=1 ");
        
        if (q != null && !q.isBlank()) {
            // Sử dụng hàm LOWER() và LIKE cho việc tìm kiếm không phân biệt chữ hoa/thường
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

    /**
     * Count active products
     */
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

    /**
     * Find paginated products with search/filter/sort
     */
    public List<SanPham> findPaged(int page, int pageSize, String q, Integer catId, String sort) {
        EntityManager em = getEntityManager();
        StringBuilder jpql = new StringBuilder("SELECT s FROM SanPham s WHERE 1=1 ");

        // filter
        if (q != null && !q.isBlank()) {
            jpql.append(" AND (LOWER(s.tenSP) LIKE :keyword OR CAST(s.maSP AS string) LIKE :keyword) ");
        }
        if (catId != null) {
            jpql.append(" AND s.danhMuc.maDM = :catId ");
        }

        // sort an toàn (whitelist cột)
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
            
            int idx = 1;
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

    /**
     * Update a product (all primary fields) (ĐÃ CẬP NHẬT để xử lý Entity liên quan)
     */
    public boolean update(SanPham sp) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            // Lấy entity đang được quản lý để merge
            SanPham managedSp = em.find(SanPham.class, sp.getMaSP());
            if (managedSp == null) {
                trans.rollback();
                return false;
            }
            
            // --- ĐIỂM SỬA LỖI CHÍNH: Xử lý DanhMuc an toàn ---
            // Entity SanPham truyền vào từ Controller thường chỉ có maDM, ta phải tìm Entity đầy đủ.
            if (sp.getDanhMuc() != null && sp.getDanhMuc().getMaDM() != null) {
                 DanhMuc dm = em.find(DanhMuc.class, sp.getDanhMuc().getMaDM());
                 if (dm == null) throw new IllegalArgumentException("Danh mục (maDM) không tồn tại.");
                 managedSp.setDanhMuc(dm);
            } else if (sp.getDanhMuc() == null && sp.getMaDM() != null) { // Trường hợp maDM được gán trực tiếp
                DanhMuc dm = em.find(DanhMuc.class, sp.getMaDM());
                if (dm == null) throw new IllegalArgumentException("Danh mục (maDM) không tồn tại.");
                managedSp.setDanhMuc(dm);
            } else {
                 throw new IllegalArgumentException("Thiếu thông tin Danh mục.");
            }
            
            // Giữ lại CuaHang (Không thay đổi CuaHang khi Update)
            if (managedSp.getCuaHang() == null) {
                // Trường hợp đặc biệt, nếu CuaHang bị null, cố gắng tìm lại từ ID nếu có
                if (sp.getCuaHang() != null && sp.getCuaHang().getMaCH() != null) {
                    CuaHang ch = em.find(CuaHang.class, sp.getCuaHang().getMaCH());
                    managedSp.setCuaHang(ch);
                }
            }
            
            // Cập nhật các trường từ đối tượng sp truyền vào
            managedSp.setTenSP(sp.getTenSP());
            managedSp.setDonGia(sp.getDonGia());
            managedSp.setSoLuongTon(sp.getSoLuongTon());
            
            // Chỉ cập nhật HinhAnh nếu có HinhAnh mới được gửi từ Controller
            if (sp.getHinhAnh() != null && !sp.getHinhAnh().isEmpty()) {
                 managedSp.setHinhAnh(sp.getHinhAnh());
            }

            managedSp.setMoTa(sp.getMoTa());
            managedSp.setTrangThai(sp.getTrangThai() != null ? sp.getTrangThai() : true);
            
            // Nếu bạn có trường ngày cập nhật, hãy cập nhật nó:
            // managedSp.setNgayCapNhat(new Date()); 
            
            em.merge(managedSp); 
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            // In chi tiết lỗi để dễ dàng debug
            System.err.println("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Find category name by ID
     */
    public String findCategoryNameById(Integer maDM) {
        if (maDM == null) return null;
        EntityManager em = getEntityManager();
        try {
            // Lấy entity DanhMuc và truy cập thuộc tính TenDM
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
