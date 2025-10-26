package com.uteshop.dao;

import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.List;

// Kế thừa AbstractDAO, giả định DashboardDAO không cần Generic <T>
// hoặc bạn có thể tạo một lớp tiện ích thay vì DAO, nhưng giữ nguyên cấu trúc
public class DashboardDAO extends AbstractDAO<Object> {
    
    // Khởi tạo AbstractDAO. Dùng Object.class vì đây là DAO tổng hợp
    public DashboardDAO() {
        super(Object.class); 
    }
    
    // Phương thức tiện ích để lấy EntityManager (kế thừa từ AbstractDAO)
    private EntityManager getManager() {
        return getEntityManager();
    }
    
    /**
     * Đếm tổng số lượng người dùng.
     * Tương đương: SELECT COUNT(*) FROM NguoiDung
     */
    public long countUsers() {
        EntityManager em = getManager();
        try {
            return em.createQuery("SELECT COUNT(u) FROM NguoiDung u", Long.class)
                     .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Đếm tổng số đơn hàng đã đặt trong ngày hiện tại.
     * Tương đương: SELECT COUNT(*) FROM DonHang WHERE CAST(NgayDat AS date) = CAST(GETDATE() AS date)
     */
    public long countOrdersToday() {
        EntityManager em = getManager();
        try {
            // Sử dụng hàm CURRENT_DATE() của JPQL/Hibernate để so sánh ngày
            // hoặc hàm DATE_TRUNC nếu cần chính xác. Dùng phép so sánh đơn giản.
            // Lưu ý: Tên cột Entity là ngayDat
            return em.createQuery(
                    "SELECT COUNT(d) FROM DonHang d WHERE d.ngayDat >= CURRENT_DATE()", 
                    Long.class)
                    .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Tính tổng doanh thu (TongThanhToan) của các đơn không bị hủy trong ngày.
     */
    public BigDecimal revenueToday() {
        EntityManager em = getManager();
        try {
            // JPQL: Tính SUM của TongThanhToan
            // Lọc theo ngày (ngayDat >= ngày hôm nay) VÀ trạng thái KHÔNG phải 'Đã hủy'
            // Dùng COALESCE(SUM, 0) để đảm bảo trả về BigDecimal.ZERO thay vì NULL
            TypedQuery<BigDecimal> query = em.createQuery(
                "SELECT COALESCE(SUM(d.tongThanhToan), 0) FROM DonHang d " +
                "WHERE d.ngayDat >= CURRENT_DATE() " + 
                "  AND (d.trangThai IS NULL OR d.trangThai NOT LIKE 'Đã hủy%')",
                BigDecimal.class);
            
            return query.getSingleResult();
            
        } catch (NoResultException e) {
            // Xảy ra nếu không có đơn hàng nào, nhưng COALESCE đã xử lý
            return BigDecimal.ZERO;
        } catch (Exception e) {
            e.printStackTrace();
            return BigDecimal.ZERO;
        } finally {
            em.close();
        }
    }

    /**
     * Đếm tổng số sản phẩm đang hoạt động (TrangThai = true hoặc NULL).
     */
    public long countActiveProducts() {
        EntityManager em = getManager();
        try {
            // JPQL: COUNT SanPham (s) với TrangThai = TRUE (hoặc NULL coi là TRUE)
            // ISNULL(TrangThai, 1) trong SQL Server tương đương với COALESCE(s.trangThai, true) trong JPQL
            return em.createQuery(
                    "SELECT COUNT(s) FROM SanPham s WHERE COALESCE(s.trangThai, TRUE) = TRUE", 
                    Long.class)
                    .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy N đơn hàng gần nhất.
     */
    public List<DonHang> getRecentOrders(int topN) {
        EntityManager em = getManager();
        try {
            return em.createQuery("SELECT d FROM DonHang d ORDER BY d.ngayDat DESC", DonHang.class)
                    .setMaxResults(topN)
                    .getResultList();
        } finally {
            // Kiểm tra if (em.isOpen()) là không cần thiết vì em.close() luôn an toàn
            em.close();
        }
    }

    // Xóa phương thức main() để giữ cho DAO là POJO thuần
}
