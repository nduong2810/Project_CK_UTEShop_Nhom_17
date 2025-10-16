package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "DanhGiaSanPham")
public class DanhGiaSanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maDG")
    private int maDG;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maND", nullable = false)
    private NguoiDung nguoiDung;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maSP", nullable = false)
    private SanPham sanPham;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maDH", nullable = false)
    private DonHang donHang;
    
    @Column(name = "diemDanhGia", nullable = false)
    private int diemDanhGia; // 1-5 sao
    
    @Column(name = "noiDung", columnDefinition = "NTEXT")
    private String noiDung;
    
    @Column(name = "hinhAnh", length = 500)
    private String hinhAnh; // Đường dẫn ảnh đánh giá
    
    @Column(name = "video", length = 500)
    private String video; // Đường dẫn video đánh giá
    
    @Column(name = "ngayDanhGia")
    private LocalDateTime ngayDanhGia;
    
    @Column(name = "trangThai")
    private boolean trangThai = true; // true: hiển thị, false: ẩn
    
    // Constructors
    public DanhGiaSanPham() {
        this.ngayDanhGia = LocalDateTime.now();
    }
    
    public DanhGiaSanPham(NguoiDung nguoiDung, SanPham sanPham, DonHang donHang, int diemDanhGia, String noiDung) {
        this.nguoiDung = nguoiDung;
        this.sanPham = sanPham;
        this.donHang = donHang;
        this.diemDanhGia = diemDanhGia;
        this.noiDung = noiDung;
        this.ngayDanhGia = LocalDateTime.now();
        this.trangThai = true;
    }
    
    // Getters and Setters
    public int getMaDG() { return maDG; }
    public void setMaDG(int maDG) { this.maDG = maDG; }
    
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
    
    public LocalDateTime getNgayDanhGia() { return ngayDanhGia; }
    public void setNgayDanhGia(LocalDateTime ngayDanhGia) { this.ngayDanhGia = ngayDanhGia; }
    
    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }
}