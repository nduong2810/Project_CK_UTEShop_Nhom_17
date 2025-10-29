package com.uteshop.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "SanPhamYeuThich")
public class SanPhamYeuThich implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaYT")
    private Integer maYT;

    @ManyToOne
    @JoinColumn(name = "MaND")
    private NguoiDung nguoiDung;

    @ManyToOne
    @JoinColumn(name = "MaSP")
    private SanPham sanPham;

    @Column(name = "NgayThich")
    private LocalDateTime ngayYeuThich;

    public SanPhamYeuThich() {
        // No-argument constructor
    }

    public SanPhamYeuThich(Integer maYT, NguoiDung nguoiDung, SanPham sanPham, LocalDateTime ngayYeuThich) {
        this.maYT = maYT;
        this.nguoiDung = nguoiDung;
        this.sanPham = sanPham;
        this.ngayYeuThich = ngayYeuThich;
    }

    public SanPhamYeuThich(NguoiDung nguoiDung, SanPham sanPham) {
        this.nguoiDung = nguoiDung;
        this.sanPham = sanPham;
    }

    // Getters and Setters
    public Integer getMaYT() {
        return maYT;
    }

    public void setMaYT(Integer maYT) {
        this.maYT = maYT;
    }

    public NguoiDung getNguoiDung() {
        return nguoiDung;
    }

    public void setNguoiDung(NguoiDung nguoiDung) {
        this.nguoiDung = nguoiDung;
    }

    public SanPham getSanPham() {
        return sanPham;
    }

    public void setSanPham(SanPham sanPham) {
        this.sanPham = sanPham;
    }

    public LocalDateTime getNgayYeuThich() {
        return ngayYeuThich;
    }

    public void setNgayYeuThich(LocalDateTime ngayYeuThich) {
        this.ngayYeuThich = ngayYeuThich;
    }
}