package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Entity cho bảng HoiThoai (Conversations)
 * Lưu thông tin về các cuộc hội thoại giữa khách hàng và cửa hàng
 */
@Entity
@Table(name = "HoiThoai")
public class HoiThoai implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaHoiThoai")
    private Integer maHoiThoai;

    @Column(name = "MaKhachHang", nullable = false)
    private Integer maKhachHang;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaKhachHang", insertable = false, updatable = false)
    private NguoiDung khachHang;

    @Column(name = "MaCuaHang", nullable = false)
    private Integer maCuaHang;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaCuaHang", insertable = false, updatable = false)
    private CuaHang cuaHang;

    @Column(name = "TinNhanCuoi", length = 500)
    private String tinNhanCuoi;

    @Column(name = "NgayTaoHoiThoai", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayTaoHoiThoai;

    @Column(name = "NgayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat;

    @Column(name = "SoTinNhanChuaDoc")
    private Integer soTinNhanChuaDoc = 0;

    @Column(name = "NguoiGuiCuoi")
    private Integer nguoiGuiCuoi; // MaND của người gửi tin nhắn cuối cùng

    @Column(name = "TrangThai")
    private Boolean trangThai = true; // true = active, false = archived

    // Constructors
    public HoiThoai() {
        this.ngayTaoHoiThoai = new Date();
        this.ngayCapNhat = new Date();
        this.soTinNhanChuaDoc = 0;
        this.trangThai = true;
    }

    // Getters and Setters
    public Integer getMaHoiThoai() {
        return maHoiThoai;
    }

    public void setMaHoiThoai(Integer maHoiThoai) {
        this.maHoiThoai = maHoiThoai;
    }

    public Integer getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(Integer maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public NguoiDung getKhachHang() {
        return khachHang;
    }

    public void setKhachHang(NguoiDung khachHang) {
        this.khachHang = khachHang;
    }

    public Integer getMaCuaHang() {
        return maCuaHang;
    }

    public void setMaCuaHang(Integer maCuaHang) {
        this.maCuaHang = maCuaHang;
    }

    public CuaHang getCuaHang() {
        return cuaHang;
    }

    public void setCuaHang(CuaHang cuaHang) {
        this.cuaHang = cuaHang;
    }

    public String getTinNhanCuoi() {
        return tinNhanCuoi;
    }

    public void setTinNhanCuoi(String tinNhanCuoi) {
        this.tinNhanCuoi = tinNhanCuoi;
    }

    public Date getNgayTaoHoiThoai() {
        return ngayTaoHoiThoai;
    }

    public void setNgayTaoHoiThoai(Date ngayTaoHoiThoai) {
        this.ngayTaoHoiThoai = ngayTaoHoiThoai;
    }

    public Date getNgayCapNhat() {
        return ngayCapNhat;
    }

    public void setNgayCapNhat(Date ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }

    public Integer getSoTinNhanChuaDoc() {
        return soTinNhanChuaDoc;
    }

    public void setSoTinNhanChuaDoc(Integer soTinNhanChuaDoc) {
        this.soTinNhanChuaDoc = soTinNhanChuaDoc;
    }

    public Integer getNguoiGuiCuoi() {
        return nguoiGuiCuoi;
    }

    public void setNguoiGuiCuoi(Integer nguoiGuiCuoi) {
        this.nguoiGuiCuoi = nguoiGuiCuoi;
    }

    public Boolean getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(Boolean trangThai) {
        this.trangThai = trangThai;
    }
}
