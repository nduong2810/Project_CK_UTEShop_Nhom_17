package com.uteshop.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "DonViVanChuyen")
public class DonViVanChuyen {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaVC")
    private int maVC;
    
    @Column(name = "TenDonVi", nullable = false, length = 150)
    private String tenDonVi;
    
    @Column(name = "PhiVanChuyen", precision = 10, scale = 2)
    private BigDecimal phiVanChuyen;

    // Constructors
    public DonViVanChuyen() {
        this.phiVanChuyen = BigDecimal.ZERO;
    }

    public DonViVanChuyen(String tenDonVi, BigDecimal phiVanChuyen) {
        this.tenDonVi = tenDonVi;
        this.phiVanChuyen = phiVanChuyen;
    }

    // Getters and Setters
    public int getMaVC() { 
        return maVC; 
    }
    
    public void setMaVC(int maVC) { 
        this.maVC = maVC; 
    }

    public String getTenDonVi() { 
        return tenDonVi; 
    }
    
    public void setTenDonVi(String tenDonVi) { 
        this.tenDonVi = tenDonVi; 
    }

    public BigDecimal getPhiVanChuyen() { 
        return phiVanChuyen; 
    }
    
    public void setPhiVanChuyen(BigDecimal phiVanChuyen) { 
        this.phiVanChuyen = phiVanChuyen; 
    }

    @Override
    public String toString() {
        return "DonViVanChuyen{" +
                "maVC=" + maVC +
                ", tenDonVi='" + tenDonVi + '\'' +
                ", phiVanChuyen=" + phiVanChuyen +
                '}';
    }
}
