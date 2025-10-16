package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "SanPhamYeuThich")
public class SanPhamYeuThich {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maYT")
    private int maYT;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maND", nullable = false)
    private NguoiDung nguoiDung;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maSP", nullable = false)
    private SanPham sanPham;
    
    @Column(name = "ngayYeuThich")
    private LocalDateTime ngayYeuThich;
    
    // Constructors
    public SanPhamYeuThich() {
        this.ngayYeuThich = LocalDateTime.now();
    }
    
    public SanPhamYeuThich(NguoiDung nguoiDung, SanPham sanPham) {
        this.nguoiDung = nguoiDung;
        this.sanPham = sanPham;
        this.ngayYeuThich = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getMaYT() { return maYT; }
    public void setMaYT(int maYT) { this.maYT = maYT; }
    
    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }
    
    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }
    
    public LocalDateTime getNgayYeuThich() { return ngayYeuThich; }
    public void setNgayYeuThich(LocalDateTime ngayYeuThich) { this.ngayYeuThich = ngayYeuThich; }
}