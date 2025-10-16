package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "SanPhamDaXem")
public class SanPhamDaXem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maDX")
    private int maDX;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maND", nullable = false)
    private NguoiDung nguoiDung;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maSP", nullable = false)
    private SanPham sanPham;
    
    @Column(name = "ngayXem")
    private LocalDateTime ngayXem;
    
    @Column(name = "soLanXem")
    private int soLanXem = 1;
    
    // Constructors
    public SanPhamDaXem() {
        this.ngayXem = LocalDateTime.now();
    }
    
    public SanPhamDaXem(NguoiDung nguoiDung, SanPham sanPham) {
        this.nguoiDung = nguoiDung;
        this.sanPham = sanPham;
        this.ngayXem = LocalDateTime.now();
        this.soLanXem = 1;
    }
    
    // Getters and Setters
    public int getMaDX() { return maDX; }
    public void setMaDX(int maDX) { this.maDX = maDX; }
    
    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }
    
    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }
    
    public LocalDateTime getNgayXem() { return ngayXem; }
    public void setNgayXem(LocalDateTime ngayXem) { this.ngayXem = ngayXem; }
    
    public int getSoLanXem() { return soLanXem; }
    public void setSoLanXem(int soLanXem) { this.soLanXem = soLanXem; }
}