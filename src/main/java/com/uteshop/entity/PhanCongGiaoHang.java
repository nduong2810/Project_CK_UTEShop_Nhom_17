package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "PhanCongGiaoHang")
public class PhanCongGiaoHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaPC")
    private Integer maPC;

    // Quan hệ Many-to-One với DonHang
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaDH", nullable = false)
    private DonHang donHang;

    // Quan hệ Many-to-One với NguoiDung (người giao hàng)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaND", nullable = false)
    private NguoiDung nguoiGiao;

    @Column(name = "NgayGiao")
    private LocalDateTime ngayGiao;

    @Column(name = "NgayHoanThanh")
    private LocalDateTime ngayHoanThanh;

    @Column(name = "TrangThai", length = 50)
    private String trangThai;

    // ===== Constructors =====
    public PhanCongGiaoHang() {}

    public PhanCongGiaoHang(DonHang donHang, NguoiDung nguoiGiao,
                            LocalDateTime ngayGiao, LocalDateTime ngayHoanThanh, String trangThai) {
        this.donHang = donHang;
        this.nguoiGiao = nguoiGiao;
        this.ngayGiao = ngayGiao;
        this.ngayHoanThanh = ngayHoanThanh;
        this.trangThai = trangThai;
    }

    // ===== Getters & Setters =====
    public Integer getMaPC() {
        return maPC;
    }

    public void setMaPC(Integer maPC) {
        this.maPC = maPC;
    }

    public DonHang getDonHang() {
        return donHang;
    }

    public void setDonHang(DonHang donHang) {
        this.donHang = donHang;
    }

    public NguoiDung getNguoiGiao() {
        return nguoiGiao;
    }

    public void setNguoiGiao(NguoiDung nguoiGiao) {
        this.nguoiGiao = nguoiGiao;
    }

    public LocalDateTime getNgayGiao() {
        return ngayGiao;
    }

    public void setNgayGiao(LocalDateTime ngayGiao) {
        this.ngayGiao = ngayGiao;
    }

    public LocalDateTime getNgayHoanThanh() {
        return ngayHoanThanh;
    }

    public void setNgayHoanThanh(LocalDateTime ngayHoanThanh) {
        this.ngayHoanThanh = ngayHoanThanh;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}
