package com.uteshop.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=UTESHOP;encrypt=false";
    private static final String USER = "sa";           // 🔹 thay bằng user của bạn
    private static final String PASSWORD = "1";   // 🔹 thay bằng mật khẩu SQL Server của bạn

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

    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            if (conn != null) System.out.println("✅ Kết nối thành công SQL Server!");
            else System.out.println("❌ Kết nối thất bại!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
