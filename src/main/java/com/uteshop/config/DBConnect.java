package com.uteshop.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    // Use environment variables or system properties for sensitive data
    private static final String URL = System.getProperty("db.url", 
        "jdbc:sqlserver://localhost:1433;databaseName=UTESHOP;encrypt=false");
    private static final String USER = System.getProperty("db.user", 
        System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "sa");
    private static final String PASSWORD = System.getProperty("db.password", 
        System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "1");

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Không tìm thấy driver SQL Server!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Test method should not be in production code - consider removing or making it private
    public static void testConnection() {
        try (Connection conn = getConnection()) {
            if (conn != null) {
                System.out.println("✅ Kết nối thành công SQL Server!");
            } else {
                System.out.println("❌ Kết nối thất bại!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}