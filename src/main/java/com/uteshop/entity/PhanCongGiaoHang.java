package com.uteshop.entity;

import jakarta.persistence.*;

// =======================================================
// SỬA LỖI: Thay đổi import từ java.sql.Date sang java.util.Date
// =======================================================
import java.util.Date; 
import java.time.LocalDateTime;
import java.time.ZoneId;

@Entity
@Table(name = "PhanCongGiaoHang")
public class PhanCongGiaoHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaPC")
    private Integer maPC;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaDH", nullable = false)
    private DonHang donHang;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaND", nullable = false)
    private NguoiDung nguoiGiao;

    @Column(name = "NgayGiao")
    private LocalDateTime ngayGiao;

    @Column(name = "NgayHoanThanh")
    private LocalDateTime ngayHoanThanh;

    @Column(name = "TrangThai", length = 50)
    private String trangThai;

    // Constructors và các Getters/Setters cũ giữ nguyên
    public PhanCongGiaoHang() {}

    public PhanCongGiaoHang(DonHang donHang, NguoiDung nguoiGiao,
                            LocalDateTime ngayGiao, LocalDateTime ngayHoanThanh, String trangThai) {
        this.donHang = donHang;
        this.nguoiGiao = nguoiGiao;
        this.ngayGiao = ngayGiao;
        this.ngayHoanThanh = ngayHoanThanh;
        this.trangThai = trangThai;
    }

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

    /**
     * Trả về ngayHoanThanh dưới dạng java.util.Date để tương thích với JSTL fmt:formatDate.
     */
    // =======================================================
    // SỬA LỖI: Thay đổi kiểu trả về thành java.util.Date
    // =======================================================
    public Date getNgayHoanThanhAsDate() {
        if (this.ngayHoanThanh == null) {
            return null;
        }
        // Chuyển đổi LocalDateTime sang java.util.Date
        return Date.from(this.ngayHoanThanh.atZone(ZoneId.systemDefault()).toInstant());
    }
}