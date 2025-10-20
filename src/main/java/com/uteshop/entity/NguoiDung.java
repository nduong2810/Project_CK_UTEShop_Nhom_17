package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "NguoiDung")
public class NguoiDung implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaND")
    private Integer maND;
    
    @Column(name = "TenDangNhap", unique = true, nullable = false, length = 50)
    private String tenDangNhap;
    
    @Column(name = "MatKhau", nullable = false, length = 255)
    private String matKhau;
    
    @Column(name = "Email", unique = true, nullable = false, length = 100)
    private String email;
    
    @Column(name = "HoTen", nullable = false, length = 100)
    private String hoTen;
    
    @Column(name = "SoDienThoai", length = 15)
    private String soDienThoai;
    
    @Column(name = "DiaChi", length = 255)
    private String diaChi;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "VaiTro", nullable = false, length = 20)
    private VaiTro vaiTro;
    
    @Column(name = "TrangThai")
    private Boolean trangThai; // Changed to Boolean
    
    @Column(name = "NgayTao", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayTao; 
    
    @Column(name = "NgayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat; 

    public enum VaiTro {
        ADMIN, USER, VENDOR, SHIPPER
    }

    public NguoiDung() {
        this.ngayTao = new Date();
        this.trangThai = true; // Changed to Boolean
    }

    // Getters and Setters
    public Integer getMaND() { return maND; }
    public void setMaND(Integer maND) { this.maND = maND; }

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

    public Boolean getTrangThai() { return trangThai; } // Changed to Boolean
    public void setTrangThai(Boolean trangThai) { this.trangThai = trangThai; } // Changed to Boolean

    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }

    public Date getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Date ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = new Date();
    }
}
