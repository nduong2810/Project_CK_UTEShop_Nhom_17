package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Entity class for DanhMuc (Category)
 */
@Entity
@Table(name = "DanhMuc")
public class DanhMuc implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaDM")
    private Integer maDM;

    @Column(name = "TenDM", nullable = false, length = 100)
    private String tenDM;

    @Column(name = "MoTa", columnDefinition = "NTEXT")
    private String moTa;

    @Column(name = "HinhAnh", length = 500)
    private String hinhAnh;

    @Column(name = "NgayTao")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayTao;

    @Column(name = "NgayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat;

    @Column(name = "TrangThai")
    private Integer trangThai; // Changed back to Integer to match DB
    
    // Default constructor
    public DanhMuc() {
        this.ngayTao = new Date();
        this.trangThai = 1; // Default to active
    }
    
    // Getters and Setters
    public Integer getMaDM() {
        return maDM;
    }
    
    public void setMaDM(Integer maDM) {
        this.maDM = maDM;
    }
    
    public String getTenDM() {
        return tenDM;
    }
    
    public void setTenDM(String tenDM) {
        this.tenDM = tenDM;
    }
    
    public String getMoTa() {
        return moTa;
    }
    
    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
    
    public String getHinhAnh() {
        return hinhAnh;
    }
    
    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }
    
    public Date getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(Date ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public Date getNgayCapNhat() {
        return ngayCapNhat;
    }
    
    public void setNgayCapNhat(Date ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }
    
    public Integer getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(Integer trangThai) {
        this.trangThai = trangThai;
    }
    
    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = new Date();
    }
}
