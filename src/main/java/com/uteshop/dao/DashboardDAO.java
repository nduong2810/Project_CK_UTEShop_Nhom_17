package com.uteshop.dao;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import com.uteshop.entity.DonHang;
import com.uteshop.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

public class DashboardDAO {

	/**
	 * Đếm tổng người dùng (bảng NguoiDung)
	 */
	public int countUsers() {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			Long cnt = em.createQuery("SELECT COUNT(u) FROM NguoiDung u", Long.class).getSingleResult();
			return cnt != null ? cnt.intValue() : 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Ở màn dashboard bạn đang hiển thị "ĐƠN HÀNG 10" (ảnh bạn gửi), tức là đang
	 * đếm TẤT CẢ đơn hàng chứ không phải "hôm nay". Nếu muốn đúng "hôm nay" thì
	 * mình để thêm hàm bên dưới.
	 */
	public int countOrders() {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			Long cnt = em.createQuery("SELECT COUNT(d) FROM DonHang d", Long.class).getSingleResult();
			return cnt != null ? cnt.intValue() : 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Nếu thật sự muốn đếm đơn hàng của HÔM NAY (theo ngày của cột ngayDat) thì
	 * dùng hàm này. Lưu ý: JPQL không xử lý date-only đẹp với SQL Server, nên mình
	 * dùng native.
	 */
	public int countOrdersToday() {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			// SQL Server
			String sql = """
					SELECT COUNT(*)
					FROM DonHang
					WHERE DonHang.TrangThai = 'HOAN_THANH'
					""";
			Query q = em.createNativeQuery(sql);
			Number n = (Number) q.getSingleResult();
			return n != null ? n.intValue() : 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Doanh thu hôm nay = tổng TongThanhToan của đơn KHÔNG bị hủy trong ngày
	 */
	public BigDecimal revenueToday() {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			String sql = """
					SELECT ISNULL(SUM(TongThanhToan), 0)
					FROM DonHang
					WHERE CAST(NgayDat AS date) = CAST(GETDATE() AS date)
					  AND (TrangThai IS NULL OR TrangThai NOT LIKE N'Đã hủy%')
					""";
			Query q = em.createNativeQuery(sql);
			Object rs = q.getSingleResult();
			if (rs == null)
				return BigDecimal.ZERO;
			if (rs instanceof BigDecimal bd)
				return bd;
			// phòng trường hợp driver trả về kiểu khác
			return new BigDecimal(rs.toString());
		} finally {
			em.close();
		}
	}

	/**
	 * Sản phẩm đang bán
	 */
	public int countActiveProducts() {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			Long cnt = em
					.createQuery("SELECT COUNT(p) FROM SanPham p WHERE COALESCE(p.trangThai, true) = true", Long.class)
					.getSingleResult();
			return cnt != null ? cnt.intValue() : 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Lấy N đơn hàng gần nhất (để đổ ra bảng "Đơn hàng gần đây")
	 */
	public List<DonHang> getRecentOrders(int topN) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			// nếu muốn luôn có khách hàng thì có thể JOIN FETCH d.nguoiDung
			TypedQuery<DonHang> q = em.createQuery("SELECT d FROM DonHang d ORDER BY d.ngayDat DESC", DonHang.class);
			q.setMaxResults(topN);
			return q.getResultList();
		} finally {
			em.close();
		}
	}

	/*
	 * Nếu vẫn muốn test nhanh thì viết trong servlet hoặc JUnit, không nên để
	 * main() trong DAO nữa.
	 */
	public BigDecimal totalPlatformRevenue() {
		EntityManager em = JPAUtil.getEntityManager(); // bạn đang dùng JPAUtil ở chỗ khác rồi
		try {
			String sql = """
					SELECT ISNULL(
					    SUM(
					        ct.ThanhTien * ISNULL(ch.TyLeChietKhau, 0) / 100.0
					    ),
					    0
					)
					FROM DonHang d
					JOIN ChiTietDonHang ct ON d.MaDH = ct.MaDH
					JOIN SanPham sp ON ct.MaSP = sp.MaSP
					JOIN CuaHang ch ON sp.MaCH = ch.MaCH
					-- CHỈ lấy đơn đã hoàn thành
					WHERE d.TrangThai IN (N'HOAN_THANH')
					""";

			Query q = em.createNativeQuery(sql);
			Object rs = q.getSingleResult();
			if (rs == null) {
				return BigDecimal.ZERO;
			}
			if (rs instanceof BigDecimal bd) {
				return bd;
			}
			return new BigDecimal(rs.toString());
		} finally {
			em.close();
		}
	}
}
