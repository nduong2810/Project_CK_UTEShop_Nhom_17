package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "NguoiDung")
public class NguoiDung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaND")
    private int maND;
    
    @Column(name = "TenDangNhap", unique = true, nullable = false, length = 50, columnDefinition = "NVARCHAR(50) NOT NULL DEFAULT ''")
    private String tenDangNhap = "";
    
    @Column(name = "MatKhau", nullable = false, length = 255, columnDefinition = "NVARCHAR(255)")
    private String matKhau;
    
    @Column(name = "Email", unique = true, nullable = false, length = 100, columnDefinition = "NVARCHAR(100)")
    private String email;
    
    @Column(name = "HoTen", nullable = false, length = 100, columnDefinition = "NVARCHAR(100)")
    private String hoTen;
    
    @Column(name = "SoDienThoai", length = 15, columnDefinition = "NVARCHAR(15)")
    private String soDienThoai;
    
    @Column(name = "DiaChi", length = 255, columnDefinition = "NVARCHAR(255)")
    private String diaChi;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "VaiTro", nullable = false, length = 20, columnDefinition = "NVARCHAR(20)")
    private VaiTro vaiTro;
    
    @Column(name = "TrangThai", nullable = false, columnDefinition = "bit NOT NULL DEFAULT 1")
    private boolean trangThai = true;
    
    @Column(name = "NgayTao", nullable = false)
    private LocalDateTime ngayTao;
    
    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;

    // Enum for roles
    public enum VaiTro {
        ADMIN, USER, VENDOR, SHIPPER
    }

    // Constructors
    public NguoiDung() {
        this.ngayTao = LocalDateTime.now();
        this.trangThai = true;
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