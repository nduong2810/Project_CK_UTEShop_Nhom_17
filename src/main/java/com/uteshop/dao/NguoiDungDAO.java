package com.uteshop.dao;

import com.uteshop.entity.NguoiDung;
import com.uteshop.util.JPAUtil; // New utility class for JPA
import com.uteshop.util.PasswordUtil;
// import com.uteshop.util.VietnameseEncodingUtil; // No longer needed with JPA/Hibernate

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Date;
import java.util.ArrayList;

public class NguoiDungDAO {

	/**
	 * Authenticate user by username/email and password
	 */
	public NguoiDung authenticate(String usernameOrEmail, String password) {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT u FROM NguoiDung u WHERE (u.tenDangNhap = :userOrEmail OR u.email = :userOrEmail) AND u.trangThai = true";

		try {
			// Use TypedQuery for automatic object mapping
			TypedQuery<NguoiDung> query = em.createQuery(jpql, NguoiDung.class);
			query.setParameter("userOrEmail", usernameOrEmail);

			// Limit to one result
			NguoiDung user = query.getSingleResult();

			System.out.println("🔍 Attempting authentication for: " + usernameOrEmail);
			System.out.println("🔐 Stored password hash: " + user.getMatKhau());
			System.out.println("🔑 Input password: " + password);

			// Use PasswordUtil.verifyPassword
			boolean passwordMatches = PasswordUtil.verifyPassword(password, user.getMatKhau());
			System.out.println("✅ Password match result: " + passwordMatches);

			if (passwordMatches) {
				System.out.println("🎉 Authentication successful for user: " + usernameOrEmail);
				return user;
			} else {
				System.out.println("❌ Password verification failed for user: " + usernameOrEmail);
				return null;
			}

		} catch (NoResultException e) {
			System.out.println("❌ User not found: " + usernameOrEmail);
			return null;
		} catch (Exception e) {
			System.err.println("💥 Authentication error: " + e.getMessage());
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	// -------------------------------------------------------------------------
	// FIND OPERATIONS
	// -------------------------------------------------------------------------

	/**
	 * Find user by ID
	 */
	public NguoiDung findById(int id) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			// EntityManager.find is the simplest way to retrieve an entity by its primary
			// key
			return em.find(NguoiDung.class, id);
		} finally {
			em.close();
		}
	}

	/**
	 * Find user by username
	 */
	public NguoiDung findByUsername(String username) {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT u FROM NguoiDung u WHERE u.tenDangNhap = :username";

		try {
			return em.createQuery(jpql, NguoiDung.class).setParameter("username", username).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} finally {
			em.close();
		}
	}

	/**
	 * Find user by email
	 */
	public NguoiDung findByEmail(String email) {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT u FROM NguoiDung u WHERE u.email = :email";

		try {
			return em.createQuery(jpql, NguoiDung.class).setParameter("email", email).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} finally {
			em.close();
		}
	}

	/**
	 * Get all users (for admin management)
	 */
	public List<NguoiDung> getAllUsers() {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT u FROM NguoiDung u ORDER BY u.ngayTao DESC";

		try {
			return em.createQuery(jpql, NguoiDung.class).getResultList();
		} finally {
			em.close();
		}
	}

	/**
	 * Get users by role
	 */
	public List<NguoiDung> getUsersByRole(NguoiDung.VaiTro vaiTro) {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT u FROM NguoiDung u WHERE u.vaiTro = :role ORDER BY u.ngayTao DESC";

		try {
			return em.createQuery(jpql, NguoiDung.class).setParameter("role", vaiTro).getResultList();
		} finally {
			em.close();
		}
	}

	// -------------------------------------------------------------------------
	// SAVE / UPDATE OPERATIONS
	// -------------------------------------------------------------------------

	/**
	 * Save new user
	 */
	public boolean save(NguoiDung user) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			// Assuming the NguoiDung entity handles 'NgayTao' automatically or it's set
			// before calling save.
			em.persist(user); // Persist the new entity
			trans.commit();
			return true;
		} catch (Exception e) {
			if (trans.isActive()) {
				trans.rollback();
			}
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	/**
	 * Update user information
	 */
	public boolean update(NguoiDung user) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			user.setNgayCapNhat(new Date()); // Update the timestamp manually
			em.merge(user); // Merge the detached entity
			trans.commit();
			return true;
		} catch (Exception e) {
			if (trans.isActive()) {
				trans.rollback();
			}
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	/**
	 * Update user status (activate/deactivate account)
	 */
	public boolean updateUserStatus(int userId, boolean status) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			NguoiDung user = em.find(NguoiDung.class, userId);
			if (user == null)
				return false;

			trans.begin();
			user.setTrangThai(status);
			user.setNgayCapNhat(new Date());
			em.merge(user);
			trans.commit();
			return true;
		} catch (Exception e) {
			if (trans.isActive()) {
				trans.rollback();
			}
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	/**
	 * Update user password with proper hashing
	 */
	public boolean updatePassword(int userId, String newPassword) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			NguoiDung user = em.find(NguoiDung.class, userId);
			if (user == null)
				return false;

			// Hash the new password before storing
			String hashedPassword = PasswordUtil.hashPassword(newPassword);
			System.out.println("🔐 Updating password for user ID: " + userId);
			System.out.println("🔑 New hashed password: " + hashedPassword);

			trans.begin();
			user.setMatKhau(hashedPassword);
			user.setNgayCapNhat(new Date());
			em.merge(user);
			trans.commit();

			System.out.println("✅ Password update result: SUCCESS");
			return true;
		} catch (Exception e) {
			if (trans.isActive()) {
				trans.rollback();
			}
			System.err.println("💥 Password update error: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	/**
	 * Update user password by email (for forgot password feature)
	 */
	public boolean updatePasswordByEmail(String email, String newPassword) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction trans = em.getTransaction();

		// Find the user by email first
		NguoiDung user = findByEmail(email);
		if (user == null)
			return false;

		try {
			// Hash the new password before storing
			String hashedPassword = PasswordUtil.hashPassword(newPassword);
			System.out.println("🔐 Updating password for email: " + email);
			System.out.println("🔑 New hashed password: " + hashedPassword);

			trans.begin();
			user.setMatKhau(hashedPassword);
			user.setNgayCapNhat(new Date());
			em.merge(user);
			trans.commit();

			System.out.println("✅ Password update result: SUCCESS");
			return true;
		} catch (Exception e) {
			if (trans.isActive()) {
				trans.rollback();
			}
			System.err.println("💥 Password update error: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	// -------------------------------------------------------------------------
	// EXISTENCE / COUNT OPERATIONS
	// -------------------------------------------------------------------------

	/**
	 * Check if username exists
	 */
	public boolean isUsernameExists(String username) {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT COUNT(u) FROM NguoiDung u WHERE u.tenDangNhap = :username";
		try {
			Long count = em.createQuery(jpql, Long.class).setParameter("username", username).getSingleResult();
			return count > 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Check if email exists
	 */
	public boolean isEmailExists(String email) {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT COUNT(u) FROM NguoiDung u WHERE u.email = :email";
		try {
			Long count = em.createQuery(jpql, Long.class).setParameter("email", email).getSingleResult();
			return count > 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Check if phone number exists
	 */
	public boolean isPhoneExists(String phone) {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT COUNT(u) FROM NguoiDung u WHERE u.soDienThoai = :phone";
		try {
			Long count = em.createQuery(jpql, Long.class).setParameter("phone", phone).getSingleResult();
			return count > 0;
		} finally {
			em.close();
		}
	}

	/**
	 * Count all active users
	 */
	public int countAllActive() {
		EntityManager em = JPAUtil.getEntityManager();
		String jpql = "SELECT COUNT(u) FROM NguoiDung u WHERE u.trangThai = true";
		try {
			Long count = em.createQuery(jpql, Long.class).getSingleResult();
			return count.intValue();
		} finally {
			em.close();
		}
	}

	/**
	 * Count users by role and search query This uses a dynamic JPQL query structure
	 * similar to the original JDBC.
	 */
	public int countByRole(String vaiTro, String q) {
		EntityManager em = JPAUtil.getEntityManager();
		StringBuilder jpql = new StringBuilder("SELECT COUNT(u) FROM NguoiDung u WHERE 1=1");
		List<String> params = new ArrayList<>();

		if (vaiTro != null && !vaiTro.isBlank()) {
			jpql.append(" AND u.vaiTro = :vaiTro");
		}

		if (q != null && !q.isBlank()) {
			jpql.append(
					" AND (u.hoTen LIKE :query OR u.email LIKE :query OR u.tenDangNhap LIKE :query OR u.soDienThoai LIKE :query)");
		}

		try {
			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);

			if (vaiTro != null && !vaiTro.isBlank()) {
				// Assuming VaiTro is an Enum or String that can be set directly
				query.setParameter("vaiTro", NguoiDung.VaiTro.valueOf(vaiTro));
			}
			if (q != null && !q.isBlank()) {
				query.setParameter("query", "%" + q.trim() + "%");
			}

			return query.getSingleResult().intValue();
		} catch (Exception e) {
			throw new RuntimeException("Error counting users by role/query: " + e.getMessage(), e);
		} finally {
			em.close();
		}
	}

	/**
	 * Update user's avatar (store only file name in DB)
	 */
	public boolean updateAvatar(int userId, String fileName) {
		EntityManager em = JPAUtil.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			NguoiDung user = em.find(NguoiDung.class, userId);
			if (user == null) {
				System.err.println("⚠️ User not found for avatar update: " + userId);
				return false;
			}

			trans.begin();
			user.setAvatar(fileName);
			user.setNgayCapNhat(new Date());
			em.merge(user);
			trans.commit();

			System.out.println("✅ Avatar updated successfully for user ID " + userId + ": " + fileName);
			return true;
		} catch (Exception e) {
			if (trans.isActive())
				trans.rollback();
			System.err.println("💥 Error updating avatar: " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	public List<NguoiDung> findPaged(int page, int pageSize, String q, NguoiDung.VaiTro role, String sort) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT n FROM NguoiDung n WHERE 1=1 ");

			if (notBlank(q)) {
				jpql.append(
						" AND (LOWER(n.hoTen) LIKE :kw OR LOWER(n.email) LIKE :kw OR LOWER(n.tenDangNhap) LIKE :kw) ");
			}
			if (role != null) {
				jpql.append(" AND n.vaiTro = :role ");
			}

			// sort:
			// id_asc|id_desc|name_asc|name_desc|created_asc|created_desc|status_asc|status_desc
			switch (sort == null ? "id_asc" : sort) {
			case "id_asc" -> jpql.append(" ORDER BY n.maND ASC ");
			case "name_asc" -> jpql.append(" ORDER BY n.hoTen ASC ");
			case "name_desc" -> jpql.append(" ORDER BY n.hoTen DESC ");
			case "created_asc" -> jpql.append(" ORDER BY n.ngayTao ASC ");
			case "created_desc" -> jpql.append(" ORDER BY n.ngayTao DESC ");
			case "status_asc" -> jpql.append(" ORDER BY n.trangThai ASC, n.maND ASC ");
			case "status_desc" -> jpql.append(" ORDER BY n.trangThai DESC, n.maND ASC ");
			default -> jpql.append(" ORDER BY n.maND DESC ");
			}

			TypedQuery<NguoiDung> query = em.createQuery(jpql.toString(), NguoiDung.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (role != null)
				query.setParameter("role", role);

			int first = Math.max(0, (page - 1) * pageSize);
			query.setFirstResult(first);
			query.setMaxResults(pageSize);
			return query.getResultList();
		} finally {
			em.close();
		}
	}

	public int countAll(String q, NguoiDung.VaiTro role) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
			StringBuilder jpql = new StringBuilder("SELECT COUNT(u) FROM NguoiDung u WHERE 1=1 ");
			if (notBlank(q)) {
				jpql.append(
						" AND (LOWER(u.hoTen) LIKE :kw OR LOWER(u.tenDangNhap) LIKE :kw OR LOWER(u.email) LIKE :kw) ");
			}
			if (role != null) {
				jpql.append(" AND u.vaiTro = :role ");
			}

			TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
			if (notBlank(q))
				query.setParameter("kw", "%" + q.toLowerCase().trim() + "%");
			if (role != null)
				query.setParameter("role", role);

			Long count = query.getSingleResult();
			return count == null ? 0 : count.intValue();
		} finally {
			em.close();
		}
	}

	/* ===== Helpers (private) ===== */
	private boolean notBlank(String s) {
		return s != null && !s.trim().isEmpty();
	}

	/** Chỉ cho phép các giá trị sort hợp lệ để tránh JPQL injection */
	private String safeSort(String s) {
		if (s == null)
			return "id_desc";
		s = s.trim().toLowerCase();
		return switch (s) {
		case "id_asc", "id_desc", "name_asc", "name_desc", "created_asc", "created_desc", "status_asc", "status_desc" ->
			s;
		default -> "id_desc";
		};
	}
}
