package com.uteshop.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "ChiTietGioHang")
public class ChiTietGioHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maCTGH")
    private int maCTGH;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maGH", nullable = false)
    private GioHang gioHang;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maSP", nullable = false)
    private SanPham sanPham;
    
    @Column(name = "soLuong", nullable = false)
    private int soLuong;
    
    @Column(name = "donGia", nullable = false, precision = 18, scale = 2)
    private BigDecimal donGia;
    
    @Column(name = "ngayThem")
    private LocalDateTime ngayThem;
    
    // Constructors
    public ChiTietGioHang() {
        this.ngayThem = LocalDateTime.now();
    }
    
    public ChiTietGioHang(GioHang gioHang, SanPham sanPham, int soLuong, BigDecimal donGia) {
        this.gioHang = gioHang;
        this.sanPham = sanPham;
        this.soLuong = soLuong;
        this.donGia = donGia;
        this.ngayThem = LocalDateTime.now();
    }
    
    // Constructor nhận Double (để tương thích với SanPham.getDonGia())
    public ChiTietGioHang(GioHang gioHang, SanPham sanPham, int soLuong, Double donGia) {
        this.gioHang = gioHang;
        this.sanPham = sanPham;
        this.soLuong = soLuong;
        this.donGia = BigDecimal.valueOf(donGia);
        this.ngayThem = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getMaCTGH() { return maCTGH; }
    public void setMaCTGH(int maCTGH) { this.maCTGH = maCTGH; }
    
    public GioHang getGioHang() { return gioHang; }
    public void setGioHang(GioHang gioHang) { this.gioHang = gioHang; }
    
    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }
    
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    
    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { this.donGia = donGia; }
    
    public LocalDateTime getNgayThem() { return ngayThem; }
    public void setNgayThem(LocalDateTime ngayThem) { this.ngayThem = ngayThem; }
    
    // Utility method
    public BigDecimal getThanhTien() {
        return donGia.multiply(BigDecimal.valueOf(soLuong));
    }
}