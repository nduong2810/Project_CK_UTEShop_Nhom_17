package com.uteshop.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {
	private static final Logger LOGGER = Logger.getLogger(DBConnect.class.getName());

    // Use environment variables or system properties for sensitive data
    private static final String URL = System.getProperty("db.url",
        "jdbc:sqlserver://localhost:1433;databaseName=UTESHOP;encrypt=false;trustServerCertificate=true;sendStringParametersAsUnicode=true");
    private static final String USER = System.getProperty("db.user",
        System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "sa");
    private static final String PASSWORD = System.getProperty("db.password",
        System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "1");

    static {
        try {
            // Load driver class. If the driver JAR is placed in Tomcat's lib, this ensures it's registered.
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            LOGGER.info("SQLServer JDBC driver loaded via Class.forName.");
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "SQL Server JDBC driver not found on classpath.", e);
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