package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Entity cho bảng TinNhan (Messages)
 * Lưu thông tin về các tin nhắn trong hội thoại
 */
@Entity
@Table(name = "TinNhan")
public class TinNhan implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaTinNhan")
    private Integer maTinNhan;

    @Column(name = "MaHoiThoai", nullable = false)
    private Integer maHoiThoai;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaHoiThoai", insertable = false, updatable = false)
    private HoiThoai hoiThoai;

    @Column(name = "MaNguoiGui", nullable = false)
    private Integer maNguoiGui;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MaNguoiGui", insertable = false, updatable = false)
    private NguoiDung nguoiGui;

    @Column(name = "NoiDung", nullable = false, length = 2000)
    private String noiDung;

    @Column(name = "NgayGui", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayGui;

    @Column(name = "DaDoc")
    private Boolean daDoc = false;

    @Column(name = "NgayDoc")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayDoc;

    @Column(name = "LoaiTinNhan", length = 20)
    private String loaiTinNhan = "TEXT"; // TEXT, IMAGE, FILE

    @Column(name = "DuongDanFile", length = 500)
    private String duongDanFile; // Đường dẫn file đính kèm (nếu có)

    // Constructors
    public TinNhan() {
        this.ngayGui = new Date();
        this.daDoc = false;
        this.loaiTinNhan = "TEXT";
    }

    // Getters and Setters
    public Integer getMaTinNhan() {
        return maTinNhan;
    }

    public void setMaTinNhan(Integer maTinNhan) {
        this.maTinNhan = maTinNhan;
    }

    public Integer getMaHoiThoai() {
        return maHoiThoai;
    }

    public void setMaHoiThoai(Integer maHoiThoai) {
        this.maHoiThoai = maHoiThoai;
    }

    public HoiThoai getHoiThoai() {
        return hoiThoai;
    }

    public void setHoiThoai(HoiThoai hoiThoai) {
        this.hoiThoai = hoiThoai;
    }

    public Integer getMaNguoiGui() {
        return maNguoiGui;
    }

    public void setMaNguoiGui(Integer maNguoiGui) {
        this.maNguoiGui = maNguoiGui;
    }

    public NguoiDung getNguoiGui() {
        return nguoiGui;
    }

    public void setNguoiGui(NguoiDung nguoiGui) {
        this.nguoiGui = nguoiGui;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public Date getNgayGui() {
        return ngayGui;
    }

    public void setNgayGui(Date ngayGui) {
        this.ngayGui = ngayGui;
    }

    public Boolean getDaDoc() {
        return daDoc;
    }

    public void setDaDoc(Boolean daDoc) {
        this.daDoc = daDoc;
    }

    public Date getNgayDoc() {
        return ngayDoc;
    }

    public void setNgayDoc(Date ngayDoc) {
        this.ngayDoc = ngayDoc;
    }

    public String getLoaiTinNhan() {
        return loaiTinNhan;
    }

    public void setLoaiTinNhan(String loaiTinNhan) {
        this.loaiTinNhan = loaiTinNhan;
    }

    public String getDuongDanFile() {
        return duongDanFile;
    }

    public void setDuongDanFile(String duongDanFile) {
        this.duongDanFile = duongDanFile;
    }
}
