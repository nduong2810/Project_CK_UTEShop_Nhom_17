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

    @Column(name = "Avatar", length = 255)
    private String avatar;

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

    @Column(name = "GioiTinh", length = 10)
    private String gioiTinh;

    @Enumerated(EnumType.STRING)
    @Column(name = "VaiTro", nullable = false, length = 20)
    private VaiTro vaiTro;

    @Column(name = "TrangThai")
    private Boolean trangThai;

    @Column(name = "NgayTao", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayTao;

    @Column(name = "NgayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat;

    // ============================================================
    // THAY ĐỔI: Bổ sung mối quan hệ với DonViVanChuyen
    // ============================================================
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaVC", nullable = true) // nullable=true vì chỉ Shipper mới có MaVC
    private DonViVanChuyen donViVanChuyen;
    // ============================================================

    public enum VaiTro {
        ADMIN, USER, VENDOR, SHIPPER
    }

    public NguoiDung() {
        this.ngayTao = new Date();
        this.trangThai = true;
    }

    // ================= GETTERS & SETTERS =================
    public Integer getMaND() {
        return maND;
    }

    public void setMaND(Integer maND) {
        this.maND = maND;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public VaiTro getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(VaiTro vaiTro) {
        this.vaiTro = vaiTro;
    }

    public Boolean getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(Boolean trangThai) {
        this.trangThai = trangThai;
    }

    public Date getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(Date ngayTao) {
        this.ngayTao = ngayTao;
    }

    public Date getNgayCapNhat() {
        return ngayCapNhat;
    }

    public void setNgayCapNhat(Date ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }

    // ============================================================
    // THAY ĐỔI: Bổ sung Getters & Setters cho donViVanChuyen
    // ============================================================
    public DonViVanChuyen getDonViVanChuyen() {
        return donViVanChuyen;
    }

    public void setDonViVanChuyen(DonViVanChuyen donViVanChuyen) {
        this.donViVanChuyen = donViVanChuyen;
    }
    // ============================================================

    @PreUpdate
    public void preUpdate() {
        this.ngayCapNhat = new Date();
    }
}