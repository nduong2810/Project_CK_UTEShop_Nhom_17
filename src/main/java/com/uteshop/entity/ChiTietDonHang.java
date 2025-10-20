package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "ChiTietDonHang")
public class ChiTietDonHang implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaCTDH")
    private Integer maCTDH; // Changed to Integer for consistency
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaDH", nullable = false)
    private DonHang donHang;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaSP", nullable = false)
    private SanPham sanPham;
    
    @Column(name = "SoLuong", nullable = false)
    private int soLuong;
    
    @Column(name = "DonGia", nullable = false, precision = 18, scale = 2)
    private BigDecimal donGia;
    
    @Column(name = "ThanhTien", nullable = false, precision = 18, scale = 2)
    private BigDecimal thanhTien;

    // Constructors
    public ChiTietDonHang() {}

    // Getters and Setters
    public Integer getMaCTDH() { return maCTDH; }
    public void setMaCTDH(Integer maCTDH) { this.maCTDH = maCTDH; }

    public DonHang getDonHang() { return donHang; }
    public void setDonHang(DonHang donHang) { this.donHang = donHang; }

    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { this.donGia = donGia; }

    public BigDecimal getThanhTien() { return thanhTien; }
    public void setThanhTien(BigDecimal thanhTien) { this.thanhTien = thanhTien; }
}
