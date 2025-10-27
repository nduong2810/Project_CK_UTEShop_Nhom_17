package com.uteshop.dao;

import com.uteshop.entity.MaGiamGia;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class MaGiamGiaDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("uteshop-pu");

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public MaGiamGia findByCode(String code) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<MaGiamGia> q = em.createQuery("SELECT m FROM MaGiamGia m WHERE m.maSo = :code", MaGiamGia.class);
            q.setParameter("code", code);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public boolean incrementUsage(int maGG) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            MaGiamGia m = em.find(MaGiamGia.class, maGG);
            if (m == null) {
                em.getTransaction().rollback();
                return false;
            }
            m.setSoLuongDaSuDung(m.getSoLuongDaSuDung() + 1);
            em.merge(m);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try { if (em.getTransaction().isActive()) em.getTransaction().rollback(); } catch (Exception ex) {}
            return false;
        } finally {
            em.close();
        }
    }
}
