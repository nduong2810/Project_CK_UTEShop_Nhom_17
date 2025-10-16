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
    @Column(name = "MaDH")
    private int maDH;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaND", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "NgayDat", nullable = false)
    private LocalDateTime ngayDat;
    
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
    private LocalDateTime ngayXacNhan;
    
    @Column(name = "ngayGiaoHang")
    private LocalDateTime ngayGiaoHang;
    
    @Column(name = "ngayNhanHang")
    private LocalDateTime ngayNhanHang;
    
    @Column(name = "ngayHuy")
    private LocalDateTime ngayHuy;
    
    @Column(name = "ngayCapNhat")
    private LocalDateTime ngayCapNhat;

    // One-to-many relationship with order details
    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ChiTietDonHang> chiTietDonHangs;

    // Enum for order status - Cập nhật đầy đủ các trạng thái
    public enum TrangThaiDonHang {
        DON_HANG_MOI("Đơn hàng mới"),
        DA_XAC_NHAN("Đã xác nhận"), 
        DANG_GIAO("Đang giao"), 
        DA_GIAO("Đã giao"), 
        DA_HUY("Đã hủy"),
        TRA_HANG("Trả hàng"),
        HOAN_TIEN("Hoàn tiền");
        
        private final String description;
        
        TrangThaiDonHang(String description) {
            this.description = description;
        }
        
        public String getDescription() {
            return description;
        }
    }
    
    // Enum for payment method
    public enum PhuongThucThanhToan {
        COD("Thanh toán khi nhận hàng"),
        VNPAY("VNPay"),
        MOMO("MoMo");
        
        private final String description;
        
        PhuongThucThanhToan(String description) {
            this.description = description;
        }
        
        public String getDescription() {
            return description;
        }
    }

    // Constructors
    public DonHang() {
        this.ngayDat = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
        this.trangThai = TrangThaiDonHang.DON_HANG_MOI;
        this.tienGiam = BigDecimal.ZERO;
        this.phiVanChuyen = BigDecimal.ZERO;
    }

    public DonHang(NguoiDung nguoiDung, BigDecimal tongTien, String diaChiGiaoHang) {
        this();
        this.nguoiDung = nguoiDung;
        this.tongTien = tongTien;
        this.tongThanhToan = tongTien;
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
    
    public BigDecimal getTienGiam() { return tienGiam; }
    public void setTienGiam(BigDecimal tienGiam) { this.tienGiam = tienGiam; }
    
    public BigDecimal getPhiVanChuyen() { return phiVanChuyen; }
    public void setPhiVanChuyen(BigDecimal phiVanChuyen) { this.phiVanChuyen = phiVanChuyen; }
    
    public BigDecimal getTongThanhToan() { return tongThanhToan; }
    public void setTongThanhToan(BigDecimal tongThanhToan) { this.tongThanhToan = tongThanhToan; }

    public TrangThaiDonHang getTrangThai() { return trangThai; }
    public void setTrangThai(TrangThaiDonHang trangThai) { 
        this.trangThai = trangThai;
        this.ngayCapNhat = LocalDateTime.now();
        
        // Set specific dates based on status - Xử lý đầy đủ tất cả trạng thái
        switch (trangThai) {
            case DON_HANG_MOI:
                // Không cần xử lý gì thêm
                break;
            case DA_XAC_NHAN:
                if (this.ngayXacNhan == null) this.ngayXacNhan = LocalDateTime.now();
                break;
            case DANG_GIAO:
                if (this.ngayGiaoHang == null) this.ngayGiaoHang = LocalDateTime.now();
                break;
            case DA_GIAO:
                if (this.ngayNhanHang == null) this.ngayNhanHang = LocalDateTime.now();
                break;
            case DA_HUY:
                if (this.ngayHuy == null) this.ngayHuy = LocalDateTime.now();
                break;
            case TRA_HANG:
                if (this.ngayHuy == null) this.ngayHuy = LocalDateTime.now();
                break;
            case HOAN_TIEN:
                if (this.ngayHuy == null) this.ngayHuy = LocalDateTime.now();
                break;
            default:
                break;
        }
    }
    
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
    
    public LocalDateTime getNgayXacNhan() { return ngayXacNhan; }
    public void setNgayXacNhan(LocalDateTime ngayXacNhan) { this.ngayXacNhan = ngayXacNhan; }

    public LocalDateTime getNgayGiaoHang() { return ngayGiaoHang; }
    public void setNgayGiaoHang(LocalDateTime ngayGiaoHang) { this.ngayGiaoHang = ngayGiaoHang; }
    
    public LocalDateTime getNgayNhanHang() { return ngayNhanHang; }
    public void setNgayNhanHang(LocalDateTime ngayNhanHang) { this.ngayNhanHang = ngayNhanHang; }
    
    public LocalDateTime getNgayHuy() { return ngayHuy; }
    public void setNgayHuy(LocalDateTime ngayHuy) { this.ngayHuy = ngayHuy; }

    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    public List<ChiTietDonHang> getChiTietDonHangs() { return chiTietDonHangs; }
    public void setChiTietDonHangs(List<ChiTietDonHang> chiTietDonHangs) { this.chiTietDonHangs = chiTietDonHangs; }
    
    // Utility methods
    public boolean canCancel() {
        return trangThai == TrangThaiDonHang.DON_HANG_MOI || trangThai == TrangThaiDonHang.DA_XAC_NHAN;
    }
    
    public boolean canReturn() {
        return trangThai == TrangThaiDonHang.DA_GIAO;
    }
    
    public void calculateTotalPayment() {
        if (this.tongTien != null) {
            BigDecimal phiVC = this.phiVanChuyen != null ? this.phiVanChuyen : BigDecimal.ZERO;
            BigDecimal giam = this.tienGiam != null ? this.tienGiam : BigDecimal.ZERO;
            this.tongThanhToan = this.tongTien.add(phiVC).subtract(giam);
        }
    }

    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "DonHang{" +
                "maDH=" + maDH +
                ", nguoiDung=" + (nguoiDung != null ? nguoiDung.getHoTen() : "null") +
                ", ngayDat=" + ngayDat +
                ", tongTien=" + tongTien +
                ", trangThai=" + trangThai +
                ", phuongThucThanhToan=" + phuongThucThanhToan +
                '}';
    }
}