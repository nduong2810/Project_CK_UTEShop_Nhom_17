package com.uteshop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import java.io.Serializable;
import java.util.List;

/**
 * Lớp AbstractDAO cung cấp các thao tác truy cập dữ liệu (CRUD) cơ bản
 * cho bất kỳ Entity nào (T) với khóa chính (ID) là Serializable (ID).
 * * @param <T> Loại Entity mà DAO này làm việc (ví dụ: SanPham, CuaHang).
 */
public abstract class AbstractDAO<T> {

    // Tên đơn vị Persistence (persistence unit name)
    private static final String PERSISTENCE_UNIT_NAME = "UTESHOP_PU"; // Thay thế bằng tên PU của bạn
    
    // Class của Entity (ví dụ: SanPham.class)
    private Class<T> entityClass;

    /**
     * Constructor nhận Entity Class để JPA biết đang làm việc với loại Entity nào.
     */
    public AbstractDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    /**
     * Phương thức tiện ích để lấy EntityManager.
     * Cần đảm bảo rằng EntityManagerFactory đã được khởi tạo.
     */
    protected EntityManager getEntityManager() {
        // Đây là cách thông thường để lấy EntityManager từ JPA/Hibernate.
        // Tùy thuộc vào môi trường (Java SE/EE), bạn có thể cần sử dụng
        // một lớp tiện ích (ví dụ: JPAUtil) nếu cần quản lý EMF phức tạp hơn.
        try {
            return Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME).createEntityManager();
        } catch (Exception e) {
            // Xử lý lỗi khi không thể tạo EntityManager (ví dụ: sai tên PU)
            System.err.println("LỖI: Không thể tạo EntityManager. Kiểm tra persistence.xml.");
            e.printStackTrace();
            throw new RuntimeException("Không thể khởi tạo EntityManager.", e);
        }
    }

    // =========================================================================
    // CRUD OPERATIONS
    // =========================================================================

    /**
     * Thêm một Entity mới vào cơ sở dữ liệu (PERSIST).
     * @param entity Entity cần thêm.
     */
    public void create(T entity) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            em.persist(entity);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new RuntimeException("Lỗi khi thêm Entity mới: " + entityClass.getSimpleName(), e);
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật một Entity đã tồn tại (MERGE).
     * @param entity Entity cần cập nhật.
     * @return Entity đã được quản lý (managed entity).
     */
    public T update(T entity) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        T mergedEntity = null;
        trans.begin();
        try {
            mergedEntity = em.merge(entity);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new RuntimeException("Lỗi khi cập nhật Entity: " + entityClass.getSimpleName(), e);
        } finally {
            em.close();
        }
        return mergedEntity;
    }

    /**
     * Xóa một Entity theo ID của nó (FIND sau đó REMOVE).
     * @param id ID của Entity cần xóa.
     */
    public void delete(Serializable id) {
        EntityManager em = getEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            T entity = em.find(entityClass, id);
            if (entity != null) {
                em.remove(entity);
                trans.commit();
            } else {
                trans.rollback();
                throw new IllegalArgumentException("Không tìm thấy Entity để xóa với ID: " + id);
            }
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new RuntimeException("Lỗi khi xóa Entity: " + entityClass.getSimpleName(), e);
        } finally {
            em.close();
        }
    }

    /**
     * Tìm kiếm một Entity theo ID.
     * @param id ID của Entity.
     * @return Entity tìm thấy hoặc null nếu không tồn tại.
     */
    public T findById(Serializable id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(entityClass, id);
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tất cả các Entity (findAll).
     * Lưu ý: Phương thức này có thể chậm với bảng lớn.
     * @return Danh sách tất cả các Entity.
     */
    @SuppressWarnings("unchecked")
    public List<T> findAll() {
        EntityManager em = getEntityManager();
        try {
            // Lấy tên Entity Class để tạo JPQL động
            String entityName = entityClass.getSimpleName();
            return em.createQuery("SELECT e FROM " + entityName + " e", entityClass)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Đếm tổng số lượng Entity trong bảng.
     * @return Tổng số lượng Entity.
     */
    public long count() {
        EntityManager em = getEntityManager();
        try {
            String entityName = entityClass.getSimpleName();
            return em.createQuery("SELECT COUNT(e) FROM " + entityName + " e", Long.class)
                     .getSingleResult();
        } finally {
            em.close();
        }
    }
}
