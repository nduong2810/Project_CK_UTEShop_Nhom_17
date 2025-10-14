package com.uteshop.entity;

import java.math.BigDecimal;
import jakarta.persistence.*;

@Entity
@Table(name = "SanPham")
public class SanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maSP")
    private int maSP;
    
    @Column(name = "tenSP", nullable = false, length = 255)
    private String tenSP;
    
    @Column(name = "donGia", nullable = false, precision = 18, scale = 2)
    private BigDecimal donGia;
    
    @Column(name = "soLuongBan", nullable = false)
    private int soLuongBan;
    
    @Column(name = "hinhAnh", length = 500)
    private String hinhAnh;
    
    @Column(name = "moTa", columnDefinition = "NTEXT")
    private String moTa;

    // Many-to-one relationship with DanhMuc
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maDM")
    private DanhMuc danhMuc;

    // Default constructor
    public SanPham() {}

    // Constructor with parameters
    public SanPham(String tenSP, BigDecimal donGia, int soLuongBan, String hinhAnh, String moTa) {
        this.tenSP = tenSP;
        this.donGia = donGia;
        this.soLuongBan = soLuongBan;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
    }

    public int getMaSP() { return maSP; }
    public void setMaSP(int maSP) { this.maSP = maSP; }

    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }

    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { this.donGia = donGia; }

    public int getSoLuongBan() { return soLuongBan; }
    public void setSoLuongBan(int soLuongBan) { this.soLuongBan = soLuongBan; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public DanhMuc getDanhMuc() { return danhMuc; }
    public void setDanhMuc(DanhMuc danhMuc) { this.danhMuc = danhMuc; }

    @Override
    public String toString() {
        return "SanPham{" +
                "maSP=" + maSP +
                ", tenSP='" + tenSP + '\'' +
                ", donGia=" + donGia +
                ", soLuongBan=" + soLuongBan +
                ", hinhAnh='" + hinhAnh + '\'' +
                ", moTa='" + moTa + '\'' +
                '}';
    }
}