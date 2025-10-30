package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "KhieuNaiCuaHang")
public class KhieuNaiCuaHang implements Serializable {
	private static final long serialVersionUID = 1L;

	public enum TrangThai {
		PENDING, APPROVED, REJECTED, WITHDRAWN
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "MaKNCH")
	private Integer maKNCH;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MaND", nullable = false)
	private NguoiDung nguoiDung;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MaCH", nullable = false)
	private CuaHang cuaHang;

	@Column(name = "TieuDe", nullable = false, length = 255)
	private String tieuDe;

	@Column(name = "NoiDung", nullable = false, length = 2000)
	private String noiDung;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "NgayGui", nullable = false)
	private Date ngayGui = new Date();

	@Enumerated(EnumType.STRING)
	@Column(name = "TrangThai", nullable = false, length = 20)
	private TrangThai trangThai = TrangThai.PENDING;

	@Column(name = "GhiChu", length = 1000)
	private String ghiChu;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "NgayXuLy")
	private Date ngayXuLy;

	// Constructors
	public KhieuNaiCuaHang() {
	}

	// Getters & Setters
	public Integer getMaKNCH() {
		return maKNCH;
	}

	public void setMaKNCH(Integer maKNCH) {
		this.maKNCH = maKNCH;
	}

	public NguoiDung getNguoiDung() {
		return nguoiDung;
	}

	public void setNguoiDung(NguoiDung nguoiDung) {
		this.nguoiDung = nguoiDung;
	}

	public CuaHang getCuaHang() {
		return cuaHang;
	}

	public void setCuaHang(CuaHang cuaHang) {
		this.cuaHang = cuaHang;
	}

	public String getTieuDe() {
		return tieuDe;
	}

	public void setTieuDe(String tieuDe) {
		this.tieuDe = tieuDe;
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

	public TrangThai getTrangThai() {
		return trangThai;
	}

	public void setTrangThai(TrangThai trangThai) {
		this.trangThai = trangThai;
	}

	public String getGhiChu() {
		return ghiChu;
	}

	public void setGhiChu(String ghiChu) {
		this.ghiChu = ghiChu;
	}

	public Date getNgayXuLy() {
		return ngayXuLy;
	}

	public void setNgayXuLy(Date ngayXuLy) {
		this.ngayXuLy = ngayXuLy;
	}
}
