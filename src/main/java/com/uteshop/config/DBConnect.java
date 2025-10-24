package com.uteshop.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {
	private static final Logger LOGGER = Logger.getLogger(DBConnect.class.getName());

    // ⚙️ URL dùng Windows Authentication
    private static final String URL =
        "jdbc:sqlserver://localhost:1433;"
        + "databaseName=UTESHOP;"
        + "integratedSecurity=true;"
        + "encrypt=false;"
        + "trustServerCertificate=true;"
        + "sendStringParametersAsUnicode=true;";

    static {
        try {
            // Tải driver JDBC
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            LOGGER.info("✅ SQL Server JDBC driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "❌ SQL Server JDBC driver not found!", e);
        }
    }

    // 🔌 Hàm lấy Connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL);
    }

    // 🧪 Hàm test kết nối
    public static void testConnection() {
        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Kết nối thành công SQL Server (Windows Authentication)!");
            } else {
                System.out.println("❌ Kết nối thất bại!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối database: " + e.getMessage());
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        System.out.println("🔍 Đang kiểm tra kết nối đến SQL Server...");
        testConnection();
    }
}