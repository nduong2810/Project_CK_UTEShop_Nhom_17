package com.uteshop.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "MaGiamGia")
public class MaGiamGia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maGG")
    private int maGG;
    
    @Column(name = "maSo", unique = true, nullable = false, length = 20, columnDefinition = "varchar(20) NOT NULL DEFAULT ''")
    private String maSo = ""; // Mã code người dùng nhập
    
    @Column(name = "tenChuongTrinh", nullable = false, length = 255, columnDefinition = "varchar(255) NOT NULL DEFAULT ''")
    private String tenChuongTrinh = "";
    
    @Column(name = "moTa", columnDefinition = "NTEXT")
    private String moTa;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "loaiGiam", nullable = false, columnDefinition = "varchar(20) NOT NULL DEFAULT 'PERCENT'")
    private LoaiGiam loaiGiam = LoaiGiam.PERCENT; // PERCENT hoặc FIXED_AMOUNT
    
    @Column(name = "giaTriGiam", nullable = false, precision = 18, scale = 2)
    private BigDecimal giaTriGiam; // % hoặc số tiền cố định
    
    @Column(name = "giaTriDonHangToiThieu", precision = 18, scale = 2)
    private BigDecimal giaTriDonHangToiThieu; // Giá trị đơn hàng tối thiểu để áp dụng
    
    @Column(name = "giaTriGiamToiDa", precision = 18, scale = 2)
    private BigDecimal giaTriGiamToiDa; // Giá trị giảm tối đa (dành cho loại %)
    
    @Column(name = "ngayBatDau", nullable = false, columnDefinition = "datetime2(6) NOT NULL DEFAULT GETDATE()")
    private LocalDateTime ngayBatDau = LocalDateTime.now();
    
    @Column(name = "ngayKetThuc", nullable = false, columnDefinition = "datetime2(6) NOT NULL DEFAULT GETDATE()")
    private LocalDateTime ngayKetThuc = LocalDateTime.now().plusDays(30);
    
    @Column(name = "soLuongToiDa")
    private Integer soLuongToiDa; // Số lượng mã có thể sử dụng tối đa
    
    @Column(name = "soLuongDaSuDung")
    private int soLuongDaSuDung = 0;
    
    @Column(name = "trangThai")
    private boolean trangThai = true;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maCH") // Null nếu là mã của admin, có giá trị nếu là mã của shop
    private CuaHang cuaHang;
    
    @Column(name = "ngayTao")
    private LocalDateTime ngayTao;
    
    public enum LoaiGiam {
        PERCENT, FIXED_AMOUNT
    }
    
    // Constructors
    public MaGiamGia() {
        this.ngayTao = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getMaGG() { return maGG; }
    public void setMaGG(int maGG) { this.maGG = maGG; }
    
    public String getMaSo() { return maSo; }
    public void setMaSo(String maSo) { this.maSo = maSo; }
    
    public String getTenChuongTrinh() { return tenChuongTrinh; }
    public void setTenChuongTrinh(String tenChuongTrinh) { this.tenChuongTrinh = tenChuongTrinh; }
    
    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
    
    public LoaiGiam getLoaiGiam() { return loaiGiam; }
    public void setLoaiGiam(LoaiGiam loaiGiam) { this.loaiGiam = loaiGiam; }
    
    public BigDecimal getGiaTriGiam() { return giaTriGiam; }
    public void setGiaTriGiam(BigDecimal giaTriGiam) { this.giaTriGiam = giaTriGiam; }
    
    public BigDecimal getGiaTriDonHangToiThieu() { return giaTriDonHangToiThieu; }
    public void setGiaTriDonHangToiThieu(BigDecimal giaTriDonHangToiThieu) { this.giaTriDonHangToiThieu = giaTriDonHangToiThieu; }
    
    public BigDecimal getGiaTriGiamToiDa() { return giaTriGiamToiDa; }
    public void setGiaTriGiamToiDa(BigDecimal giaTriGiamToiDa) { this.giaTriGiamToiDa = giaTriGiamToiDa; }
    
    public LocalDateTime getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(LocalDateTime ngayBatDau) { this.ngayBatDau = ngayBatDau; }
    
    public LocalDateTime getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(LocalDateTime ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }
    
    public Integer getSoLuongToiDa() { return soLuongToiDa; }
    public void setSoLuongToiDa(Integer soLuongToiDa) { this.soLuongToiDa = soLuongToiDa; }
    
    public int getSoLuongDaSuDung() { return soLuongDaSuDung; }
    public void setSoLuongDaSuDung(int soLuongDaSuDung) { this.soLuongDaSuDung = soLuongDaSuDung; }
    
    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }
    
    public CuaHang getCuaHang() { return cuaHang; }
    public void setCuaHang(CuaHang cuaHang) { this.cuaHang = cuaHang; }
    
    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }
    
    // Utility methods
    public boolean isValid() {
        LocalDateTime now = LocalDateTime.now();
        return trangThai && 
               now.isAfter(ngayBatDau) && 
               now.isBefore(ngayKetThuc) &&
               (soLuongToiDa == null || soLuongDaSuDung < soLuongToiDa);
    }
    
    public BigDecimal tinhGiaTriGiam(BigDecimal giaTriDonHang) {
        if (!isValid() || (giaTriDonHangToiThieu != null && giaTriDonHang.compareTo(giaTriDonHangToiThieu) < 0)) {
            return BigDecimal.ZERO;
        }
        
        BigDecimal giaTriGiam;
        if (loaiGiam == LoaiGiam.PERCENT) {
            giaTriGiam = giaTriDonHang.multiply(this.giaTriGiam).divide(BigDecimal.valueOf(100));
            if (giaTriGiamToiDa != null && giaTriGiam.compareTo(giaTriGiamToiDa) > 0) {
                giaTriGiam = giaTriGiamToiDa;
            }
        } else {
            giaTriGiam = this.giaTriGiam;
        }
        
        return giaTriGiam;
    }
}