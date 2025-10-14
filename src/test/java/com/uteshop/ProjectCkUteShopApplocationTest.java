package com.uteshop;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class ProjectCkUteShopApplocationTest {
	public static void main(String[] args) {
		System.out.println("=== 🔰 UTESHOP PROJECT TEST START ===");

		// Tên persistence-unit trong persistence.xml
		final String PERSISTENCE_UNIT = "uteshopPU";

		EntityManagerFactory emf = null;
		EntityManager em = null;

		try {
			System.out.println("🔧 Khởi tạo EntityManagerFactory...");
			emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
			em = emf.createEntityManager();

			System.out.println("✅ Kết nối JPA thành công!");
			System.out.println("🧱 Kiểm tra EntityManager: " + (em.isOpen() ? "Đã mở" : "Chưa mở"));

			// Gợi ý test nhẹ — nếu có entity, test thử count bảng NguoiDung
			try {
				Long count = (Long) em.createQuery("SELECT COUNT(n) FROM NguoiDung n").getSingleResult();
				System.out.println("📊 Số lượng người dùng trong DB: " + count);
			} catch (Exception e) {
				System.out.println("⚠️ Không thể truy vấn Entity NguoiDung (chưa có bảng hoặc entity).");
			}

		} catch (Exception ex) {
			System.err.println("❌ Lỗi khởi tạo JPA / persistence.xml:");
			ex.printStackTrace();
		} finally {
			if (em != null)
				em.close();
			if (emf != null)
				emf.close();
			System.out.println("=== ✅ Kết thúc kiểm tra dự án UTESHOP ===");
		}
	}
}
