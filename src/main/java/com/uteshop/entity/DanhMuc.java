package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "DanhMuc")
public class DanhMuc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaDM")
    private int maDM;
    
    @Column(name = "TenDM", nullable = false, length = 100)
    private String tenDM;
    
    @Column(name = "MaCha")
    private Integer maCha;
    
    @Column(name = "NgayTao")
    private LocalDateTime ngayTao;
    
    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;
    
    // Self-referencing relationship for parent category
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaCha", insertable = false, updatable = false)
    private DanhMuc danhMucCha;
    
    // One-to-many relationship for child categories
    @OneToMany(mappedBy = "danhMucCha", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<DanhMuc> danhMucCon;
    
    // Default constructor
    public DanhMuc() {
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }
    
    // Constructor with parameters
    public DanhMuc(String tenDM, Integer maCha) {
        this();
        this.tenDM = tenDM;
        this.maCha = maCha;
    }
    
    // Getters and Setters
    public int getMaDM() {
        return maDM;
    }
    
    public void setMaDM(int maDM) {
        this.maDM = maDM;
    }
    
    public String getTenDM() {
        return tenDM;
    }
    
    public void setTenDM(String tenDM) {
        this.tenDM = tenDM;
    }
    
    public Integer getMaCha() {
        return maCha;
    }
    
    public void setMaCha(Integer maCha) {
        this.maCha = maCha;
    }
    
    public LocalDateTime getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public LocalDateTime getNgayCapNhat() {
        return ngayCapNhat;
    }
    
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }
    
    public DanhMuc getDanhMucCha() {
        return danhMucCha;
    }
    
    public void setDanhMucCha(DanhMuc danhMucCha) {
        this.danhMucCha = danhMucCha;
    }
    
    public List<DanhMuc> getDanhMucCon() {
        return danhMucCon;
    }
    
    public void setDanhMucCon(List<DanhMuc> danhMucCon) {
        this.danhMucCon = danhMucCon;
    }
    
    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "DanhMuc{" +
                "maDM=" + maDM +
                ", tenDM='" + tenDM + '\'' +
                ", maCha=" + maCha +
                ", ngayTao=" + ngayTao +
                ", ngayCapNhat=" + ngayCapNhat +
                '}';
    }
}