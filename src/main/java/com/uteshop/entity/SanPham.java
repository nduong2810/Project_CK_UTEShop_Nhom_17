package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "SanPham")
public class SanPham implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaSP")
    private Integer maSP;

    @Column(name = "TenSP", nullable = false, length = 255)
    private String tenSP;

    @Column(name = "MoTa", columnDefinition = "NTEXT")
    private String moTa;

    @Column(name = "DonGia", nullable = false, precision = 18, scale = 2)
    private BigDecimal donGia;

    @Column(name = "SoLuongTon", nullable = false)
    private Integer soLuongTon = 0;

    @Column(name = "SoLuongBan")
    private Integer soLuongBan = 0;

    @Column(name = "HinhAnh", length = 500)
    private String hinhAnh;

    @Column(name = "TrangThai")
    private Boolean trangThai = true;

    @Column(name = "NgayTao")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayTao;

    @Column(name = "NgayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat;

    @Column(name = "LuotXem")
    private Integer luotXem = 0;

    @Column(name = "LuotYeuThich")
    private Integer luotYeuThich = 0;

    @Column(name = "DiemDanhGiaTrungBinh", precision = 3, scale = 2)
    private BigDecimal diemDanhGiaTrungBinh = BigDecimal.ZERO;

    @Column(name = "SoLuongDanhGia")
    private Integer soLuongDanhGia = 0;

    // Foreign key columns
    @Column(name = "MaDM")
    private Integer maDM;
    
    @Column(name = "MaCH", nullable = false)
    private Integer maCH;
    
    // Relationships
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaDM", insertable = false, updatable = false)
    private DanhMuc danhMuc;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaCH", insertable = false, updatable = false)
    private CuaHang cuaHang;

    // Default constructor
    public SanPham() {
        this.ngayTao = new Date();
        this.trangThai = true;
        this.soLuongTon = 0;
        this.soLuongBan = 0;
        this.luotXem = 0;
        this.luotYeuThich = 0;
        this.soLuongDanhGia = 0;
        this.diemDanhGiaTrungBinh = BigDecimal.ZERO;
    }

    // Constructor with parameters
    public SanPham(String tenSP, BigDecimal donGia, Integer soLuongTon, String hinhAnh, String moTa, Integer maCH) {
        this();
        this.tenSP = tenSP;
        this.donGia = donGia;
        this.soLuongTon = soLuongTon;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
        this.maCH = maCH;
    }

    // Getters and Setters
    public Integer getMaSP() {
        return maSP;
    }

    public void setMaSP(Integer maSP) {
        this.maSP = maSP;
    }

    public String getTenSP() {
        return tenSP;
    }

    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public BigDecimal getDonGia() {
        return donGia;
    }

    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
    }

    public Integer getSoLuongTon() {
        return soLuongTon;
    }

    public void setSoLuongTon(Integer soLuongTon) {
        this.soLuongTon = soLuongTon;
    }

    public Integer getSoLuongBan() {
        return soLuongBan;
    }

    public void setSoLuongBan(Integer soLuongBan) {
        this.soLuongBan = soLuongBan;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public Boolean getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(Boolean trangThai) {
        this.trangThai = trangThai;
    }

    public Date getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(Date ngayTao) {
        this.ngayTao = ngayTao;
    }

    public Date getNgayCapNhat() {
        return ngayCapNhat;
    }

    public void setNgayCapNhat(Date ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }

    public Integer getMaDM() {
        return maDM;
    }

    public void setMaDM(Integer maDM) {
        this.maDM = maDM;
    }
    
    public Integer getMaCH() {
        return maCH;
    }

    public void setMaCH(Integer maCH) {
        this.maCH = maCH;
    }
    
    public DanhMuc getDanhMuc() {
        return danhMuc;
    }

    public void setDanhMuc(DanhMuc danhMuc) {
        this.danhMuc = danhMuc;
        if (danhMuc != null) {
            this.maDM = danhMuc.getMaDM();
        }
    }

    public CuaHang getCuaHang() {
        return cuaHang;
    }

    public void setCuaHang(CuaHang cuaHang) {
        this.cuaHang = cuaHang;
        if (cuaHang != null) {
            this.maCH = cuaHang.getMaCH();
        }
    }

    public Integer getLuotXem() {
        return luotXem;
    }

    public void setLuotXem(Integer luotXem) {
        this.luotXem = luotXem;
    }

    public Integer getLuotYeuThich() {
        return luotYeuThich;
    }

    public void setLuotYeuThich(Integer luotYeuThich) {
        this.luotYeuThich = luotYeuThich;
    }

    public BigDecimal getDiemDanhGiaTrungBinh() {
        return diemDanhGiaTrungBinh;
    }

    public void setDiemDanhGiaTrungBinh(BigDecimal diemDanhGiaTrungBinh) {
        this.diemDanhGiaTrungBinh = diemDanhGiaTrungBinh;
    }

    public Integer getSoLuongDanhGia() {
        return soLuongDanhGia;
    }

    public void setSoLuongDanhGia(Integer soLuongDanhGia) {
        this.soLuongDanhGia = soLuongDanhGia;
    }

    // Additional helper methods for compatibility
    
    // Compatibility methods for DAO that might use double/int
    public void setDonGia(double donGia) {
        this.donGia = BigDecimal.valueOf(donGia);
    }
    
    public void setTrangThai(int trangThai) {
        this.trangThai = trangThai == 1;
    }
    
    public void setDiemDanhGiaTrungBinh(double diemDanhGia) {
        this.diemDanhGiaTrungBinh = BigDecimal.valueOf(diemDanhGia);
    }

    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = new Date();
    }

    @Override
    public String toString() {
        return "SanPham{" +
                "maSP=" + maSP +
                ", tenSP='" + tenSP + '\'' +
                ", donGia=" + donGia +
                ", soLuongTon=" + soLuongTon +
                ", trangThai=" + trangThai +
                ", maCH=" + maCH +
                '}';
    }
}