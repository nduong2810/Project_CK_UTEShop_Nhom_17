package com.uteshop.dao;

import com.uteshop.config.DBConnect;
import com.uteshop.entity.DonHang;

import jakarta.persistence.EntityManager;

import java.math.BigDecimal;
import java.sql.*;
import java.util.List;
import java.util.*;
import jakarta.persistence.*;

public class DashboardDAO {
	private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

	public int countUsers() {
		String sql = "SELECT COUNT(*) FROM NguoiDung";
		try (Connection con = DBConnect.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getInt(1) : 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public int countOrdersToday() {
		// Ngày theo cột NgayDat trong DonHang
		String sql = "SELECT COUNT(*) " + "FROM DonHang ";
		try (Connection con = DBConnect.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getInt(1) : 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public BigDecimal revenueToday() {
		// Doanh thu = tổng TongThanhToan của đơn không hủy trong ngày
		String sql = "SELECT ISNULL(SUM(TongThanhToan),0) " + "FROM DonHang "
				+ "WHERE CAST(NgayDat AS date) = CAST(GETDATE() AS date) "
				+ "  AND (TrangThai IS NULL OR TrangThai NOT LIKE N'Đã hủy%')";
		try (Connection con = DBConnect.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getBigDecimal(1) : BigDecimal.ZERO;
		} catch (Exception e) {
			e.printStackTrace();
			return BigDecimal.ZERO;
		}
	}

	public int countActiveProducts()  {
		// Bảng SanPham có cột TrangThai BIT (có thể null), coi null = đang bán
		String sql = "SELECT COUNT(*) FROM SanPham WHERE ISNULL(TrangThai,1)=1";
		try (Connection con = DBConnect.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getInt(1) : 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public List<DonHang> getRecentOrders(int topN) {
		EntityManager em = emf.createEntityManager();
		try {
			return em.createQuery("SELECT d FROM DonHang d ORDER BY d.ngayDat DESC", DonHang.class).setMaxResults(topN)

					.getResultList();
		} finally {
			if (em.isOpen())
				em.close();
		}
	}

	public static void main(String[] args) {
		DashboardDAO dao = new DashboardDAO();
		int ordersToday = dao.countOrdersToday();
		System.out.println("tổng TongThanhToan: " + ordersToday);
	}
}
