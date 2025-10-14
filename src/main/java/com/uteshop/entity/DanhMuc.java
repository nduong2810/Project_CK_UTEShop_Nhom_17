package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "DanhMuc")
public class DanhMuc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maDM")
    private int maDM;
    
    @Column(name = "tenDM", nullable = false, length = 100)
    private String tenDM;
    
    @Column(name = "moTa", length = 500)
    private String moTa;
    
    @Column(name = "trangThai", nullable = false)
    private boolean trangThai = true;
    
    @Column(name = "ngayTao", nullable = false)
    private LocalDateTime ngayTao;

    // One-to-many relationship with SanPham
    @OneToMany(mappedBy = "danhMuc", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<SanPham> sanPhams;

    // Constructors
    public DanhMuc() {
        this.ngayTao = LocalDateTime.now();
    }

    public DanhMuc(String tenDM, String moTa) {
        this();
        this.tenDM = tenDM;
        this.moTa = moTa;
    }

    // Getters and Setters
    public int getMaDM() { return maDM; }
    public void setMaDM(int maDM) { this.maDM = maDM; }

    public String getTenDM() { return tenDM; }
    public void setTenDM(String tenDM) { this.tenDM = tenDM; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public List<SanPham> getSanPhams() { return sanPhams; }
    public void setSanPhams(List<SanPham> sanPhams) { this.sanPhams = sanPhams; }

    @Override
    public String toString() {
        return "DanhMuc{" +
                "maDM=" + maDM +
                ", tenDM='" + tenDM + '\'' +
                ", moTa='" + moTa + '\'' +
                ", trangThai=" + trangThai +
                '}';
    }
}