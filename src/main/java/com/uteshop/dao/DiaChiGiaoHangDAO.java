package com.uteshop.dao;

import com.uteshop.entity.DiaChiGiaoHang;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.util.List;

public class DiaChiGiaoHangDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    public boolean save(DiaChiGiaoHang diaChi) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Nếu đây là địa chỉ mặc định, bỏ mặc định của các địa chỉ khác
            if (diaChi.isLaMacDinh()) {
                em.createQuery("UPDATE DiaChiGiaoHang d SET d.laMacDinh = false WHERE d.nguoiDung.maND = :userId")
                  .setParameter("userId", diaChi.getNguoiDung().getMaND())
                  .executeUpdate();
            }
            
            if (diaChi.getMaDC() == 0) {
                diaChi.setNgayTao(LocalDateTime.now());
                diaChi.setNgayCapNhat(LocalDateTime.now());
                em.persist(diaChi);
            } else {
                diaChi.setNgayCapNhat(LocalDateTime.now());
                em.merge(diaChi);
            }
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public List<DiaChiGiaoHang> getAddressesByUser(int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DiaChiGiaoHang> query = em.createQuery(
                "SELECT d FROM DiaChiGiaoHang d WHERE d.nguoiDung.maND = :userId ORDER BY d.laMacDinh DESC, d.ngayTao DESC", 
                DiaChiGiaoHang.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public DiaChiGiaoHang getDefaultAddress(int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<DiaChiGiaoHang> query = em.createQuery(
                "SELECT d FROM DiaChiGiaoHang d WHERE d.nguoiDung.maND = :userId AND d.laMacDinh = true", 
                DiaChiGiaoHang.class);
            query.setParameter("userId", userId);
            List<DiaChiGiaoHang> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public DiaChiGiaoHang findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(DiaChiGiaoHang.class, id);
        } finally {
            em.close();
        }
    }

    public boolean delete(int id, int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            DiaChiGiaoHang diaChi = em.find(DiaChiGiaoHang.class, id);
            if (diaChi != null && diaChi.getNguoiDung().getMaND() == userId) {
                em.remove(diaChi);
                
                // Nếu xóa địa chỉ mặc định, đặt địa chỉ đầu tiên làm mặc định
                if (diaChi.isLaMacDinh()) {
                    TypedQuery<DiaChiGiaoHang> query = em.createQuery(
                        "SELECT d FROM DiaChiGiaoHang d WHERE d.nguoiDung.maND = :userId ORDER BY d.ngayTao ASC", 
                        DiaChiGiaoHang.class);
                    query.setParameter("userId", userId);
                    query.setMaxResults(1);
                    
                    List<DiaChiGiaoHang> remainingAddresses = query.getResultList();
                    if (!remainingAddresses.isEmpty()) {
                        DiaChiGiaoHang newDefault = remainingAddresses.get(0);
                        newDefault.setLaMacDinh(true);
                        em.merge(newDefault);
                    }
                }
            }
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean setAsDefault(int addressId, int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            // Bỏ mặc định tất cả địa chỉ của user
            em.createQuery("UPDATE DiaChiGiaoHang d SET d.laMacDinh = false WHERE d.nguoiDung.maND = :userId")
              .setParameter("userId", userId)
              .executeUpdate();
            
            // Đặt địa chỉ được chọn làm mặc định
            DiaChiGiaoHang diaChi = em.find(DiaChiGiaoHang.class, addressId);
            if (diaChi != null && diaChi.getNguoiDung().getMaND() == userId) {
                diaChi.setLaMacDinh(true);
                diaChi.setNgayCapNhat(LocalDateTime.now());
                em.merge(diaChi);
            }
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public long countAddressesByUser(int userId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(d) FROM DiaChiGiaoHang d WHERE d.nguoiDung.maND = :userId", 
                Long.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public boolean update(DiaChiGiaoHang diaChi) {
        return save(diaChi); // Sử dụng lại phương thức save
    }
}