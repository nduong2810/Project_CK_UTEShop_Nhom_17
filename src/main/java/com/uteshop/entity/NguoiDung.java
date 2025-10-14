package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "NguoiDung")
public class NguoiDung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maND")
    private int maND;
    
    @Column(name = "tenDangNhap", unique = true, nullable = false, length = 50)
    private String tenDangNhap;
    
    @Column(name = "matKhau", nullable = false, length = 255)
    private String matKhau;
    
    @Column(name = "email", unique = true, nullable = false, length = 100)
    private String email;
    
    @Column(name = "hoTen", nullable = false, length = 100)
    private String hoTen;
    
    @Column(name = "soDienThoai", length = 15)
    private String soDienThoai;
    
    @Column(name = "diaChi", length = 255)
    private String diaChi;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "vaiTro", nullable = false, length = 20)
    private VaiTro vaiTro;
    
    @Column(name = "trangThai", nullable = false)
    private boolean trangThai = true;
    
    @Column(name = "ngayTao", nullable = false)
    private LocalDateTime ngayTao;
    
    @Column(name = "ngayCapNhat")
    private LocalDateTime ngayCapNhat;

    // Enum for roles
    public enum VaiTro {
        ADMIN, USER, VENDOR, SHIPPER
    }

    // Constructors
    public NguoiDung() {
        this.ngayTao = LocalDateTime.now();
    }

    public NguoiDung(String tenDangNhap, String matKhau, String email, String hoTen, VaiTro vaiTro) {
        this();
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.email = email;
        this.hoTen = hoTen;
        this.vaiTro = vaiTro;
    }

    // Getters and Setters
    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }

    public String getTenDangNhap() { return tenDangNhap; }
    public void setTenDangNhap(String tenDangNhap) { this.tenDangNhap = tenDangNhap; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

    public VaiTro getVaiTro() { return vaiTro; }
    public void setVaiTro(VaiTro vaiTro) { this.vaiTro = vaiTro; }

    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "NguoiDung{" +
                "maND=" + maND +
                ", tenDangNhap='" + tenDangNhap + '\'' +
                ", email='" + email + '\'' +
                ", hoTen='" + hoTen + '\'' +
                ", vaiTro=" + vaiTro +
                ", trangThai=" + trangThai +
                '}';
    }
}