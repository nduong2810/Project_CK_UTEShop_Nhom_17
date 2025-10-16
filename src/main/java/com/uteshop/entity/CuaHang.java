package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "CuaHang")
public class CuaHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaCH")
    private Integer maCH;
    
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
    
    @Column(name = "MaND", nullable = false)
    private Integer maND;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaND", insertable = false, updatable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "TrangThai", nullable = false)
    private Boolean trangThai = true;
    
    @Column(name = "NgayTao", nullable = false)
    private LocalDateTime ngayTao;
    
    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;

    // One-to-many relationship with products
    @OneToMany(mappedBy = "cuaHang", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<SanPham> sanPhams = new ArrayList<>();

    // Constructors
    public CuaHang() {
        this.ngayTao = LocalDateTime.now();
        this.trangThai = true;
    }

    public CuaHang(String tenCH, String diaChi, Integer maND) {
        this();
        this.tenCH = tenCH;
        this.diaChi = diaChi;
        this.maND = maND;
    }

    // Getters and Setters
    public Integer getMaCH() { 
        return maCH; 
    }
    
    public void setMaCH(Integer maCH) { 
        this.maCH = maCH; 
    }

    public String getTenCH() { 
        return tenCH; 
    }
    
    public void setTenCH(String tenCH) { 
        this.tenCH = tenCH; 
    }

    public String getMoTa() { 
        return moTa; 
    }
    
    public void setMoTa(String moTa) { 
        this.moTa = moTa; 
    }

    public String getDiaChi() { 
        return diaChi; 
    }
    
    public void setDiaChi(String diaChi) { 
        this.diaChi = diaChi; 
    }

    public String getSoDienThoai() { 
        return soDienThoai; 
    }
    
    public void setSoDienThoai(String soDienThoai) { 
        this.soDienThoai = soDienThoai; 
    }

    public String getEmail() { 
        return email; 
    }
    
    public void setEmail(String email) { 
        this.email = email; 
    }

    public Integer getMaND() {
        return maND;
    }

    public void setMaND(Integer maND) {
        this.maND = maND;
    }

    public NguoiDung getNguoiDung() { 
        return nguoiDung; 
    }
    
    public void setNguoiDung(NguoiDung nguoiDung) { 
        this.nguoiDung = nguoiDung;
        if (nguoiDung != null) {
            this.maND = nguoiDung.getMaND();
        }
    }

    public Boolean getTrangThai() { 
        return trangThai; 
    }
    
    public void setTrangThai(Boolean trangThai) { 
        this.trangThai = trangThai; 
    }

    public LocalDateTime getNgayTao() { 
        return ngayTao; 
    }
    
    public void setNgayTao(LocalDateTime ngayTao) { 
        this.ngayTao = ngayTao; 
    }

    public LocalDateTime getNgayCapNhat() { 
        return ngayCapNhat; 
    }
    
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { 
        this.ngayCapNhat = ngayCapNhat; 
    }

    public List<SanPham> getSanPhams() {
        return sanPhams;
    }

    public void setSanPhams(List<SanPham> sanPhams) {
        this.sanPhams = sanPhams;
    }

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
                ", nguoiDung=" + (nguoiDung != null ? nguoiDung.getHoTen() : "null") +
                '}';
    }
}