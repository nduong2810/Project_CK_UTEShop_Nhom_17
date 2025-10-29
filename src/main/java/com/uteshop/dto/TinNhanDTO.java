package com.uteshop.dto;

import java.util.Date;

/**
 * DTO cho TinNhan - Sử dụng để serialize sang JSON
 * Tránh lỗi Hibernate proxy khi dùng Gson
 */
public class TinNhanDTO {
    private Integer maTinNhan;
    private Integer maHoiThoai;
    private Integer maNguoiGui;
    private String tenNguoiGui;
    private String noiDung;
    private Date ngayGui;
    private Boolean daDoc;
    private Date ngayDoc;
    private String loaiTinNhan;
    private String duongDanFile;

    // Constructors
    public TinNhanDTO() {
    }

    // Getters and Setters
    public Integer getMaTinNhan() {
        return maTinNhan;
    }

    public void setMaTinNhan(Integer maTinNhan) {
        this.maTinNhan = maTinNhan;
    }

    public Integer getMaHoiThoai() {
        return maHoiThoai;
    }

    public void setMaHoiThoai(Integer maHoiThoai) {
        this.maHoiThoai = maHoiThoai;
    }

    public Integer getMaNguoiGui() {
        return maNguoiGui;
    }

    public void setMaNguoiGui(Integer maNguoiGui) {
        this.maNguoiGui = maNguoiGui;
    }

    public String getTenNguoiGui() {
        return tenNguoiGui;
    }

    public void setTenNguoiGui(String tenNguoiGui) {
        this.tenNguoiGui = tenNguoiGui;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public Date getNgayGui() {
        return ngayGui;
    }

    public void setNgayGui(Date ngayGui) {
        this.ngayGui = ngayGui;
    }

    public Boolean getDaDoc() {
        return daDoc;
    }

    public void setDaDoc(Boolean daDoc) {
        this.daDoc = daDoc;
    }

    public Date getNgayDoc() {
        return ngayDoc;
    }

    public void setNgayDoc(Date ngayDoc) {
        this.ngayDoc = ngayDoc;
    }

    public String getLoaiTinNhan() {
        return loaiTinNhan;
    }

    public void setLoaiTinNhan(String loaiTinNhan) {
        this.loaiTinNhan = loaiTinNhan;
    }

    public String getDuongDanFile() {
        return duongDanFile;
    }

    public void setDuongDanFile(String duongDanFile) {
        this.duongDanFile = duongDanFile;
    }
}
