package com.uteshop.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "DonHang")
public class DonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maDH")
    private int maDH;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maND", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "ngayDat", nullable = false)
    private LocalDateTime ngayDat;
    
    @Column(name = "tongTien", nullable = false, precision = 18, scale = 2)
    private BigDecimal tongTien;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "trangThai", nullable = false, length = 20)
    private TrangThaiDonHang trangThai;
    
    @Column(name = "diaChiGiaoHang", nullable = false, length = 500)
    private String diaChiGiaoHang;
    
    @Column(name = "soDienThoaiNhanHang", length = 15)
    private String soDienThoaiNhanHang;
    
    @Column(name = "ghiChu", length = 1000)
    private String ghiChu;
    
    @Column(name = "ngayGiaoHang")
    private LocalDateTime ngayGiaoHang;
    
    @Column(name = "ngayCapNhat")
    private LocalDateTime ngayCapNhat;

    // One-to-many relationship with order details (if you have that entity)
    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ChiTietDonHang> chiTietDonHangs;

    // Enum for order status
    public enum TrangThaiDonHang {
        CHO_XAC_NHAN, DA_XAC_NHAN, DANG_GIAO, DA_GIAO, DA_HUY
    }

    // Constructors
    public DonHang() {
        this.ngayDat = LocalDateTime.now();
        this.trangThai = TrangThaiDonHang.CHO_XAC_NHAN;
    }

    public DonHang(NguoiDung nguoiDung, BigDecimal tongTien, String diaChiGiaoHang) {
        this();
        this.nguoiDung = nguoiDung;
        this.tongTien = tongTien;
        this.diaChiGiaoHang = diaChiGiaoHang;
    }

    // Getters and Setters
    public int getMaDH() { return maDH; }
    public void setMaDH(int maDH) { this.maDH = maDH; }

    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }

    public LocalDateTime getNgayDat() { return ngayDat; }
    public void setNgayDat(LocalDateTime ngayDat) { this.ngayDat = ngayDat; }

    public BigDecimal getTongTien() { return tongTien; }
    public void setTongTien(BigDecimal tongTien) { this.tongTien = tongTien; }

    public TrangThaiDonHang getTrangThai() { return trangThai; }
    public void setTrangThai(TrangThaiDonHang trangThai) { this.trangThai = trangThai; }

    public String getDiaChiGiaoHang() { return diaChiGiaoHang; }
    public void setDiaChiGiaoHang(String diaChiGiaoHang) { this.diaChiGiaoHang = diaChiGiaoHang; }

    public String getSoDienThoaiNhanHang() { return soDienThoaiNhanHang; }
    public void setSoDienThoaiNhanHang(String soDienThoaiNhanHang) { this.soDienThoaiNhanHang = soDienThoaiNhanHang; }

    public String getGhiChu() { return ghiChu; }
    public void setGhiChu(String ghiChu) { this.ghiChu = ghiChu; }

    public LocalDateTime getNgayGiaoHang() { return ngayGiaoHang; }
    public void setNgayGiaoHang(LocalDateTime ngayGiaoHang) { this.ngayGiaoHang = ngayGiaoHang; }

    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    public List<ChiTietDonHang> getChiTietDonHangs() { return chiTietDonHangs; }
    public void setChiTietDonHangs(List<ChiTietDonHang> chiTietDonHangs) { this.chiTietDonHangs = chiTietDonHangs; }

    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "DonHang{" +
                "maDH=" + maDH +
                ", ngayDat=" + ngayDat +
                ", tongTien=" + tongTien +
                ", trangThai=" + trangThai +
                ", diaChiGiaoHang='" + diaChiGiaoHang + '\'' +
                '}';
    }
}