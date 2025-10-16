package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "CuaHang")
public class CuaHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaCH")
    private int maCH;
    
    @Column(name = "TenCH", nullable = false, length = 255)
    private String tenCH;
    
    @Column(name = "MoTa", length = 1000)
    private String moTa;
    
    @Column(name = "DiaChi", nullable = false, length = 500)
    private String diaChi;
    
    @Column(name = "SoDienThoai", length = 15)
    private String soDienThoai;
    
    @Column(name = "Email", length = 100)
    private String email;
    
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaND", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "TrangThai", nullable = false)
    private boolean trangThai = true;
    
    @Column(name = "NgayTao", nullable = false)
    private LocalDateTime ngayTao;
    
    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;

    // Constructors
    public CuaHang() {
        this.ngayTao = LocalDateTime.now();
    }

    public CuaHang(String tenCH, String diaChi, NguoiDung nguoiDung) {
        this();
        this.tenCH = tenCH;
        this.diaChi = diaChi;
        this.nguoiDung = nguoiDung;
    }

    // Getters and Setters
    public int getMaCH() { return maCH; }
    public void setMaCH(int maCH) { this.maCH = maCH; }

    public String getTenCH() { return tenCH; }
    public void setTenCH(String tenCH) { this.tenCH = tenCH; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }

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
        return "CuaHang{" +
                "maCH=" + maCH +
                ", tenCH='" + tenCH + '\'' +
                ", diaChi='" + diaChi + '\'' +
                ", trangThai=" + trangThai +
                '}';
    }
}