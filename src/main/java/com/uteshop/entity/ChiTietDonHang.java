package com.uteshop.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "ChiTietDonHang")
public class ChiTietDonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaCTDH")
    private int maCTDH;
    
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

    public ChiTietDonHang(DonHang donHang, SanPham sanPham, int soLuong, BigDecimal donGia) {
        this.donHang = donHang;
        this.sanPham = sanPham;
        this.soLuong = soLuong;
        this.donGia = donGia;
        this.thanhTien = donGia.multiply(BigDecimal.valueOf(soLuong));
    }

    // Getters and Setters
    public int getMaCTDH() { return maCTDH; }
    public void setMaCTDH(int maCTDH) { this.maCTDH = maCTDH; }

    public DonHang getDonHang() { return donHang; }
    public void setDonHang(DonHang donHang) { this.donHang = donHang; }

    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { 
        this.soLuong = soLuong;
        if (this.donGia != null) {
            this.thanhTien = this.donGia.multiply(BigDecimal.valueOf(soLuong));
        }
    }

    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { 
        this.donGia = donGia;
        if (this.soLuong > 0) {
            this.thanhTien = donGia.multiply(BigDecimal.valueOf(this.soLuong));
        }
    }

    public BigDecimal getThanhTien() { return thanhTien; }
    public void setThanhTien(BigDecimal thanhTien) { this.thanhTien = thanhTien; }

    @Override
    public String toString() {
        return "ChiTietDonHang{" +
                "maCTDH=" + maCTDH +
                ", soLuong=" + soLuong +
                ", donGia=" + donGia +
                ", thanhTien=" + thanhTien +
                '}';
    }
}