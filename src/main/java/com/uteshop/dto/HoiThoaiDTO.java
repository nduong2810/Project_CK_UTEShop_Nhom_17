package com.uteshop.dto;

import java.util.Date;

/**
 * DTO cho HoiThoai - Sử dụng để serialize sang JSON
 * Tránh lỗi Hibernate proxy khi dùng Gson
 */
public class HoiThoaiDTO {
    private Integer maHoiThoai;
    private Integer maKhachHang;
    private String tenKhachHang;
    private Integer maCuaHang;
    private String tenCuaHang;
    private String tinNhanCuoi;
    private Date ngayTaoHoiThoai;
    private Date ngayCapNhat;
    private Integer soTinNhanChuaDoc;
    private Integer nguoiGuiCuoi;
    private Boolean trangThai;

    // Constructors
    public HoiThoaiDTO() {
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

    public String getTenKhachHang() {
        return tenKhachHang;
    }

    public void setTenKhachHang(String tenKhachHang) {
        this.tenKhachHang = tenKhachHang;
    }

    public Integer getMaCuaHang() {
        return maCuaHang;
    }

    public void setMaCuaHang(Integer maCuaHang) {
        this.maCuaHang = maCuaHang;
    }

    public String getTenCuaHang() {
        return tenCuaHang;
    }

    public void setTenCuaHang(String tenCuaHang) {
        this.tenCuaHang = tenCuaHang;
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
