package com.uteshop.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "DanhGiaSanPham")
public class DanhGiaSanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maDG")
    private Integer maDG;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maND", nullable = false)
    private NguoiDung nguoiDung;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maSP", nullable = false)
    private SanPham sanPham;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maDH", nullable = true)
    private DonHang donHang;
    
    @Column(name = "diemDanhGia", nullable = false)
    private int diemDanhGia;
    
    @Column(name = "noiDung", columnDefinition = "NTEXT")
    private String noiDung;
    
    @Column(name = "hinhAnh", length = 500)
    private String hinhAnh;
    
    @Column(name = "video", length = 500)
    private String video;
    
    @Column(name = "ngayDanhGia", columnDefinition = "datetime") // Explicitly define column type
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayDanhGia;
    
    @Column(name = "trangThai")
    private Boolean trangThai = true;
    
    public DanhGiaSanPham() {
        this.ngayDanhGia = new Date();
    }
    
    // Getters and Setters
    public Integer getMaDG() { return maDG; }
    public void setMaDG(Integer maDG) { this.maDG = maDG; }
    
    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }
    
    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }
    
    public DonHang getDonHang() { return donHang; }
    public void setDonHang(DonHang donHang) { this.donHang = donHang; }
    
    public int getDiemDanhGia() { return diemDanhGia; }
    public void setDiemDanhGia(int diemDanhGia) { this.diemDanhGia = diemDanhGia; }
    
    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }
    
    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }
    
    public String getVideo() { return video; }
    public void setVideo(String video) { this.video = video; }
    
    public Date getNgayDanhGia() { return ngayDanhGia; }
    public void setNgayDanhGia(Date ngayDanhGia) { this.ngayDanhGia = ngayDanhGia; }
    
    public Boolean isTrangThai() { return trangThai; }
    public void setTrangThai(Boolean trangThai) { this.trangThai = trangThai; }
}
