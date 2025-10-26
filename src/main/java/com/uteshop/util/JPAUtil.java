package com.uteshop.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Tiện ích quản lý EntityManagerFactory và EntityManager.
 * Chỉ khởi tạo 1 factory duy nhất trong suốt vòng đời ứng dụng.
 */
public final class JPAUtil {

    private static final String PERSISTENCE_UNIT_NAME = "uteshop-pu";
    private static EntityManagerFactory emf;

    // Private constructor để ngăn tạo đối tượng JPAUtil
    private JPAUtil() {}

    /**
     * Khởi tạo EntityManagerFactory (chỉ 1 lần duy nhất).
     * Gọi tự động khi cần hoặc thủ công trong AppContextListener.
     */
    private static synchronized void init() {
        if (emf == null) {
            try {
                emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
                System.out.println("✅ JPAUtil: EntityManagerFactory initialized for " + PERSISTENCE_UNIT_NAME);
            } catch (Exception e) {
                System.err.println("❌ JPAUtil: Failed to initialize EntityManagerFactory for " + PERSISTENCE_UNIT_NAME);
                e.printStackTrace();
                throw new ExceptionInInitializerError(e);
            }
        }
    }

    /**
     * Trả về một EntityManager mới (dành riêng cho mỗi DAO hoặc mỗi request).
     */
    public static EntityManager getEntityManager() {
        if (emf == null) {
            init();
        }
        return emf.createEntityManager();
    }

    /**
     * Đóng EntityManagerFactory khi ứng dụng dừng.
     * Nên gọi từ ServletContextListener.contextDestroyed().
     */
    public static void closeFactory() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            emf = null;
            System.out.println("ℹ️ JPAUtil: EntityManagerFactory closed.");
        }
    }
}
