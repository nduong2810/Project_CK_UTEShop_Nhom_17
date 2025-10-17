package com.uteshop.entity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Entity class for DanhMuc (Category)
 */
public class DanhMuc implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int maDM;           // MaDM - Category ID
    private String tenDM;       // TenDM - Category Name  
    private String moTa;        // MoTa - Description
    private String hinhAnh;     // HinhAnh - Image path
    private Timestamp ngayTao;  // NgayTao - Created date
    private Timestamp ngayCapNhat; // NgayCapNhat - Updated date
    private int trangThai;      // TrangThai - Status (1=active, 0=inactive)
    
    // Default constructor
    public DanhMuc() {
    }
    
    // Constructor with essential fields
    public DanhMuc(int maDM, String tenDM) {
        this.maDM = maDM;
        this.tenDM = tenDM;
    }
    
    // Full constructor
    public DanhMuc(int maDM, String tenDM, String moTa, String hinhAnh, 
                   Timestamp ngayTao, Timestamp ngayCapNhat, int trangThai) {
        this.maDM = maDM;
        this.tenDM = tenDM;
        this.moTa = moTa;
        this.hinhAnh = hinhAnh;
        this.ngayTao = ngayTao;
        this.ngayCapNhat = ngayCapNhat;
        this.trangThai = trangThai;
    }
    
    // Getters and Setters
    public int getMaDM() {
        return maDM;
    }
    
    public void setMaDM(int maDM) {
        this.maDM = maDM;
    }
    
    public String getTenDM() {
        return tenDM;
    }
    
    public void setTenDM(String tenDM) {
        this.tenDM = tenDM;
    }
    
    public String getMoTa() {
        return moTa;
    }
    
    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
    
    public String getHinhAnh() {
        return hinhAnh;
    }
    
    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }
    
    public Timestamp getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(Timestamp ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public Timestamp getNgayCapNhat() {
        return ngayCapNhat;
    }
    
    public void setNgayCapNhat(Timestamp ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }
    
    public int getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(int trangThai) {
        this.trangThai = trangThai;
    }
    
    // JSP-friendly alias methods for compatibility
    public int getCategoryId() {
        return this.maDM;
    }
    
    public String getCategoryName() {
        return this.tenDM;
    }
    
    public String getDescription() {
        return this.moTa;
    }
    
    public String getImage() {
        return this.hinhAnh;
    }
    
    public Timestamp getCreatedDate() {
        return this.ngayTao;
    }
    
    public Timestamp getUpdatedDate() {
        return this.ngayCapNhat;
    }
    
    public int getStatus() {
        return this.trangThai;
    }
    
    public boolean isActive() {
        return this.trangThai == 1;
    }
    
    // toString method for debugging
    @Override
    public String toString() {
        return "DanhMuc{" +
                "maDM=" + maDM +
                ", tenDM='" + tenDM + '\'' +
                ", moTa='" + moTa + '\'' +
                ", hinhAnh='" + hinhAnh + '\'' +
                ", ngayTao=" + ngayTao +
                ", ngayCapNhat=" + ngayCapNhat +
                ", trangThai=" + trangThai +
                '}';
    }
    
    // equals and hashCode
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        DanhMuc danhMuc = (DanhMuc) obj;
        return maDM == danhMuc.maDM;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(maDM);
    }
}