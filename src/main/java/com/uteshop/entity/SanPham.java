package com.uteshop.entity;

import java.math.BigDecimal;

public class SanPham {
    private int maSP;
    private String tenSP;
    private BigDecimal donGia;
    private int soLuongBan;
    private String hinhAnh;
    private String moTa;

    public int getMaSP() { return maSP; }
    public void setMaSP(int maSP) { this.maSP = maSP; }

    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }

    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { this.donGia = donGia; }

    public int getSoLuongBan() { return soLuongBan; }
    public void setSoLuongBan(int soLuongBan) { this.soLuongBan = soLuongBan; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
}
