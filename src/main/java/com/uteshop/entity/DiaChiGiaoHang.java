package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "DiaChiGiaoHang")
public class DiaChiGiaoHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maDC")
    private int maDC;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "maND", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(name = "tenNguoiNhan", nullable = false, length = 100)
    private String tenNguoiNhan;
    
    @Column(name = "soDienThoai", nullable = false, length = 15)
    private String soDienThoai;
    
    @Column(name = "diaChiCuThe", nullable = false, length = 255)
    private String diaChiCuThe;
    
    @Column(name = "phuong", nullable = false, length = 100)
    private String phuong;
    
    @Column(name = "quan", nullable = false, length = 100)
    private String quan;
    
    @Column(name = "thanhPho", nullable = false, length = 100)
    private String thanhPho;
    
    @Column(name = "laMacDinh")
    private boolean laMacDinh = false;
    
    @Column(name = "ngayTao")
    private LocalDateTime ngayTao;
    
    @Column(name = "ngayCapNhat")
    private LocalDateTime ngayCapNhat;
    
    // Constructors
    public DiaChiGiaoHang() {
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }
    
    public DiaChiGiaoHang(NguoiDung nguoiDung, String tenNguoiNhan, String soDienThoai, 
                         String diaChiCuThe, String phuong, String quan, String thanhPho) {
        this.nguoiDung = nguoiDung;
        this.tenNguoiNhan = tenNguoiNhan;
        this.soDienThoai = soDienThoai;
        this.diaChiCuThe = diaChiCuThe;
        this.phuong = phuong;
        this.quan = quan;
        this.thanhPho = thanhPho;
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }
    
    // Getters and Setters
    public int getMaDC() { return maDC; }
    public void setMaDC(int maDC) { this.maDC = maDC; }
    
    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }
    
    public String getTenNguoiNhan() { return tenNguoiNhan; }
    public void setTenNguoiNhan(String tenNguoiNhan) { this.tenNguoiNhan = tenNguoiNhan; }
    
    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }
    
    public String getDiaChiCuThe() { return diaChiCuThe; }
    public void setDiaChiCuThe(String diaChiCuThe) { this.diaChiCuThe = diaChiCuThe; }
    
    public String getPhuong() { return phuong; }
    public void setPhuong(String phuong) { this.phuong = phuong; }
    
    public String getQuan() { return quan; }
    public void setQuan(String quan) { this.quan = quan; }
    
    public String getThanhPho() { return thanhPho; }
    public void setThanhPho(String thanhPho) { this.thanhPho = thanhPho; }
    
    public boolean isLaMacDinh() { return laMacDinh; }
    public void setLaMacDinh(boolean laMacDinh) { this.laMacDinh = laMacDinh; }
    
    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }
    
    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
    
    // Utility method
    public String getDiaChiDayDu() {
        return diaChiCuThe + ", " + phuong + ", " + quan + ", " + thanhPho;
    }
}