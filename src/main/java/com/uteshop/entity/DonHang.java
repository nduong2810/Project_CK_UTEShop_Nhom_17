package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "DonHang")
public class DonHang implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaDH")
    private Integer maDH;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaND", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "NgayDat", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayDat;
    
    @Column(name = "TongTien", nullable = false, precision = 18, scale = 2)
    private BigDecimal tongTien;
    
    @Column(name = "TienGiam", precision = 18, scale = 2)
    private BigDecimal tienGiam = BigDecimal.ZERO;
    
    @Column(name = "PhiVanChuyen", precision = 18, scale = 2)
    private BigDecimal phiVanChuyen = BigDecimal.ZERO;
    
    @Column(name = "TongThanhToan", nullable = false, precision = 18, scale = 2)
    private BigDecimal tongThanhToan;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "TrangThai", nullable = false, length = 30)
    private TrangThaiDonHang trangThai;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "PhuongThucThanhToan", length = 20)
    private PhuongThucThanhToan phuongThucThanhToan;
    
    @Column(name = "DiaChiGiaoHang", nullable = false, length = 500)
    private String diaChiGiaoHang;
    
    @Column(name = "TenNguoiNhan", length = 100)
    private String tenNguoiNhan;
    
    @Column(name = "SoDienThoaiNhanHang", length = 15)
    private String soDienThoaiNhanHang;
    
    @Column(name = "ghiChu", length = 1000)
    private String ghiChu;
    
    @Column(name = "lyDoHuy", length = 500)
    private String lyDoHuy;
    
    @Column(name = "ngayXacNhan")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayXacNhan;
    
    @Column(name = "ngayGiaoHang")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayGiaoHang;
    
    @Column(name = "ngayNhanHang")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayNhanHang;
    
    @Column(name = "ngayHuy")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayHuy;
    
    @Column(name = "ngayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat;

    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ChiTietDonHang> chiTietDonHangs;

    public enum TrangThaiDonHang {
        DON_HANG_MOI, DA_XAC_NHAN, DANG_GIAO, DA_GIAO, DA_HUY, TRA_HANG, HOAN_TIEN
    }
    
    public enum PhuongThucThanhToan {
        COD, VNPAY, MOMO
    }

    public DonHang() {
        this.ngayDat = new Date();
        this.ngayCapNhat = new Date();
        this.trangThai = TrangThaiDonHang.DON_HANG_MOI;
    }

    // Getters and Setters
    public Integer getMaDH() { return maDH; }
    public void setMaDH(Integer maDH) { this.maDH = maDH; }

    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }

    public Date getNgayDat() { return ngayDat; }
    public void setNgayDat(Date ngayDat) { this.ngayDat = ngayDat; }

    public BigDecimal getTongTien() { return tongTien; }
    public void setTongTien(BigDecimal tongTien) { this.tongTien = tongTien; }
    
    public BigDecimal getTienGiam() { return tienGiam; }
    public void setTienGiam(BigDecimal tienGiam) { this.tienGiam = tienGiam; }
    
    public BigDecimal getPhiVanChuyen() { return phiVanChuyen; }
    public void setPhiVanChuyen(BigDecimal phiVanChuyen) { this.phiVanChuyen = phiVanChuyen; }
    
    public BigDecimal getTongThanhToan() { return tongThanhToan; }
    public void setTongThanhToan(BigDecimal tongThanhToan) { this.tongThanhToan = tongThanhToan; }

    public TrangThaiDonHang getTrangThai() { return trangThai; }
    public void setTrangThai(TrangThaiDonHang trangThai) { this.trangThai = trangThai; }
    
    public PhuongThucThanhToan getPhuongThucThanhToan() { return phuongThucThanhToan; }
    public void setPhuongThucThanhToan(PhuongThucThanhToan phuongThucThanhToan) { this.phuongThucThanhToan = phuongThucThanhToan; }

    public String getDiaChiGiaoHang() { return diaChiGiaoHang; }
    public void setDiaChiGiaoHang(String diaChiGiaoHang) { this.diaChiGiaoHang = diaChiGiaoHang; }
    
    public String getTenNguoiNhan() { return tenNguoiNhan; }
    public void setTenNguoiNhan(String tenNguoiNhan) { this.tenNguoiNhan = tenNguoiNhan; }

    public String getSoDienThoaiNhanHang() { return soDienThoaiNhanHang; }
    public void setSoDienThoaiNhanHang(String soDienThoaiNhanHang) { this.soDienThoaiNhanHang = soDienThoaiNhanHang; }

    public String getGhiChu() { return ghiChu; }
    public void setGhiChu(String ghiChu) { this.ghiChu = ghiChu; }
    
    public String getLyDoHuy() { return lyDoHuy; }
    public void setLyDoHuy(String lyDoHuy) { this.lyDoHuy = lyDoHuy; }
    
    public Date getNgayXacNhan() { return ngayXacNhan; }
    public void setNgayXacNhan(Date ngayXacNhan) { this.ngayXacNhan = ngayXacNhan; }

    public Date getNgayGiaoHang() { return ngayGiaoHang; }
    public void setNgayGiaoHang(Date ngayGiaoHang) { this.ngayGiaoHang = ngayGiaoHang; }
    
    public Date getNgayNhanHang() { return ngayNhanHang; }
    public void setNgayNhanHang(Date ngayNhanHang) { this.ngayNhanHang = ngayNhanHang; }
    
    public Date getNgayHuy() { return ngayHuy; }
    public void setNgayHuy(Date ngayHuy) { this.ngayHuy = ngayHuy; }

    public Date getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Date ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    public List<ChiTietDonHang> getChiTietDonHangs() { return chiTietDonHangs; }
    public void setChiTietDonHangs(List<ChiTietDonHang> chiTietDonHangs) { this.chiTietDonHangs = chiTietDonHangs; }

    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = new Date();
    }
}
