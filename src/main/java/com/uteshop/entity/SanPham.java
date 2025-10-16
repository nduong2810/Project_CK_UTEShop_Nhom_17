package com.uteshop.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "SanPham")
public class SanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaSP")
    private int maSP;
    
    @Column(name = "TenSP", nullable = false, length = 255)
    private String tenSP;
    
    @Column(name = "DonGia", nullable = false, precision = 18, scale = 2)
    private BigDecimal donGia;
    
    @Column(name = "SoLuongBan", nullable = false)
    private int soLuongBan;
    
    @Column(name = "SoLuongTon", nullable = false)
    private int soLuongTon = 0;
    
    @Column(name = "HinhAnh", length = 500)
    private String hinhAnh;
    
    @Column(name = "MoTa", columnDefinition = "NTEXT")
    private String moTa;
    
    @Column(name = "LuotXem")
    private int luotXem = 0;
    
    @Column(name = "LuotYeuThich")
    private int luotYeuThich = 0;
    
    @Column(name = "DiemDanhGiaTrungBinh", precision = 3, scale = 2)
    private BigDecimal diemDanhGiaTrungBinh = BigDecimal.ZERO;
    
    @Column(name = "SoLuongDanhGia")
    private int soLuongDanhGia = 0;
    
    @Column(name = "TrangThai")
    private boolean trangThai = true;
    
    @Column(name = "NgayTao")
    private LocalDateTime ngayTao;
    
    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;

    // Many-to-one relationship with DanhMuc
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaDM")
    private DanhMuc danhMuc;
    
    // Many-to-one relationship with CuaHang
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaCH")
    private CuaHang cuaHang;

    // Default constructor
    public SanPham() {
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }

    // Constructor with parameters
    public SanPham(String tenSP, BigDecimal donGia, int soLuongBan, String hinhAnh, String moTa) {
        this.tenSP = tenSP;
        this.donGia = donGia;
        this.soLuongBan = soLuongBan;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }

    // Getters and Setters
    public int getMaSP() { return maSP; }
    public void setMaSP(int maSP) { this.maSP = maSP; }

    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }

    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { this.donGia = donGia; }

    public int getSoLuongBan() { return soLuongBan; }
    public void setSoLuongBan(int soLuongBan) { this.soLuongBan = soLuongBan; }
    
    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
    
    public int getLuotXem() { return luotXem; }
    public void setLuotXem(int luotXem) { this.luotXem = luotXem; }
    
    public int getLuotYeuThich() { return luotYeuThich; }
    public void setLuotYeuThich(int luotYeuThich) { this.luotYeuThich = luotYeuThich; }
    
    public BigDecimal getDiemDanhGiaTrungBinh() { return diemDanhGiaTrungBinh; }
    public void setDiemDanhGiaTrungBinh(BigDecimal diemDanhGiaTrungBinh) { this.diemDanhGiaTrungBinh = diemDanhGiaTrungBinh; }
    
    public int getSoLuongDanhGia() { return soLuongDanhGia; }
    public void setSoLuongDanhGia(int soLuongDanhGia) { this.soLuongDanhGia = soLuongDanhGia; }
    
    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }
    
    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }
    
    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    public DanhMuc getDanhMuc() { return danhMuc; }
    public void setDanhMuc(DanhMuc danhMuc) { this.danhMuc = danhMuc; }
    
    public CuaHang getCuaHang() { return cuaHang; }
    public void setCuaHang(CuaHang cuaHang) { this.cuaHang = cuaHang; }

    @Override
    public String toString() {
        return "SanPham{" +
                "maSP=" + maSP +
                ", tenSP='" + tenSP + '\'' +
                ", donGia=" + donGia +
                ", soLuongBan=" + soLuongBan +
                ", soLuongTon=" + soLuongTon +
                ", hinhAnh='" + hinhAnh + '\'' +
                ", moTa='" + moTa + '\'' +
                '}';
    }
}