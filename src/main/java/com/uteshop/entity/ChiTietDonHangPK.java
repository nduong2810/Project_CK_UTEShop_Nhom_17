package com.uteshop.entity;

import java.io.Serializable;
import java.util.Objects;
import jakarta.persistence.Embeddable;

/**
 * Lớp Khóa chính Composite cho ChiTietDonHang.
 * Khóa chính bao gồm Mã Đơn Hàng (maDH) và Mã Sản Phẩm (maSP).
 * Cần cài đặt hashCode và equals.
 */
@Embeddable
public class ChiTietDonHangPK implements Serializable {
    
    private static final long serialVersionUID = 1L;

    // Tên trường phải khớp với tên trường của khóa ngoại trong ChiTietDonHang.java
    private Integer donHang; // Tương ứng với donHang.maDH
    private Integer sanPham; // Tương ứng với sanPham.maSP

    public ChiTietDonHangPK() {
    }

    public ChiTietDonHangPK(Integer donHang, Integer sanPham) {
        this.donHang = donHang;
        this.sanPham = sanPham;
    }

    // Getters and Setters
    public Integer getDonHang() {
        return donHang;
    }

    public void setDonHang(Integer donHang) {
        this.donHang = donHang;
    }

    public Integer getSanPham() {
        return sanPham;
    }

    public void setSanPham(Integer sanPham) {
        this.sanPham = sanPham;
    }

    // Yêu cầu bắt buộc của khóa composite: Override hashCode và equals
    @Override
    public int hashCode() {
        return Objects.hash(donHang, sanPham);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        ChiTietDonHangPK other = (ChiTietDonHangPK) obj;
        return Objects.equals(donHang, other.donHang) && 
               Objects.equals(sanPham, other.sanPham);
    }
}
