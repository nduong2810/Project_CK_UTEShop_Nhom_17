package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "CuaHang")
public class CuaHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maCH")
    private int maCH;
    
    @Column(name = "tenCH", nullable = false, length = 255)
    private String tenCH;
    
    @Column(name = "moTa", length = 1000)
    private String moTa;
    
    @Column(name = "diaChi", nullable = false, length = 500)
    private String diaChi;
    
    @Column(name = "soDienThoai", length = 15)
    private String soDienThoai;
    
    @Column(name = "email", length = 100)
    private String email;
    
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maNguoiDung", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "trangThai", nullable = false)
    private boolean trangThai = true;
    
    @Column(name = "ngayTao", nullable = false)
    private LocalDateTime ngayTao;
    
    @Column(name = "ngayCapNhat")
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