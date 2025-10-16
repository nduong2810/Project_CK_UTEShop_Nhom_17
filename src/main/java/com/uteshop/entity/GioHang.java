package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "GioHang")
public class GioHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maGH")
    private int maGH;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maND", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "ngayTao")
    private LocalDateTime ngayTao;
    
    @Column(name = "ngayCapNhat")
    private LocalDateTime ngayCapNhat;
    
    @OneToMany(mappedBy = "gioHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ChiTietGioHang> chiTietGioHang;
    
    // Constructors
    public GioHang() {
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }
    
    public GioHang(NguoiDung nguoiDung) {
        this.nguoiDung = nguoiDung;
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getMaGH() { return maGH; }
    public void setMaGH(int maGH) { this.maGH = maGH; }
    
    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }
    
    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }
    
    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
    
    public List<ChiTietGioHang> getChiTietGioHang() { return chiTietGioHang; }
    public void setChiTietGioHang(List<ChiTietGioHang> chiTietGioHang) { this.chiTietGioHang = chiTietGioHang; }
}