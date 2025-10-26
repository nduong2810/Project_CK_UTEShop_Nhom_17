package com.uteshop.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    // Tên của Persistence Unit (đơn vị bền vững) được định nghĩa trong file persistence.xml
    private static final String PERSISTENCE_UNIT_NAME = "uteshop-pu"; // Đặt tên theo dự án của bạn, thường là Tên_Dự_Án + PU

    // EntityManagerFactory chỉ cần tạo một lần duy nhất khi ứng dụng khởi động
    private static EntityManagerFactory factory;

    /**
     * Khởi tạo EntityManagerFactory
     * Phương thức này nên được gọi 1 lần khi ứng dụng bắt đầu (ví dụ: trong context listener)
     */
    public static void buildEntityManagerFactory() {
        if (factory == null) {
            try {
                // Tạo Factory từ tên Persistence Unit
                factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
                System.out.println("✅ EntityManagerFactory initialized successfully.");
            } catch (Exception e) {
                System.err.println("❌ Initializing EntityManagerFactory failed.");
                e.printStackTrace();
                throw new ExceptionInInitializerError(e);
            }
        }
    }

    /**
     * Cung cấp một EntityManager mới để thực hiện các thao tác CRUD.
     * Mỗi request (hoặc mỗi DAO method) nên tạo và đóng một EntityManager riêng biệt.
     */
    public static EntityManager getEntityManager() {
        if (factory == null) {
            // Đảm bảo Factory đã được khởi tạo
            buildEntityManagerFactory(); 
        }
        return factory.createEntityManager();
    }

    /**
     * Đóng EntityManagerFactory khi ứng dụng tắt.
     */
    public static void shutdown() {
        if (factory != null && factory.isOpen()) {
            factory.close();
            System.out.println("ℹ️ EntityManagerFactory shut down.");
        }
    }
}