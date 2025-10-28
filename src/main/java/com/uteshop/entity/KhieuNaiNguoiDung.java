package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "KhieuNaiNguoiDung")
public class KhieuNaiNguoiDung implements Serializable {
	private static final long serialVersionUID = 1L;

	public enum TrangThai {
		PENDING, APPROVED, REJECTED
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "MaKN")
	private Integer maKN;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MaND", nullable = false)
	private NguoiDung nguoiDung;

	@Column(name = "NoiDung", nullable = false, length = 1000)
	private String noiDung;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "NgayGui", nullable = false)
	private Date ngayGui = new Date();

	@Enumerated(EnumType.STRING)
	@Column(name = "TrangThai", nullable = false, length = 20)
	private TrangThai trangThai = TrangThai.PENDING;

	@Column(name = "GhiChu", length = 500)
	private String ghiChu;

	// getters & setters
	public Integer getMaKN() {
		return maKN;
	}

	public void setMaKN(Integer maKN) {
		this.maKN = maKN;
	}

	public NguoiDung getNguoiDung() {
		return nguoiDung;
	}

	public void setNguoiDung(NguoiDung nguoiDung) {
		this.nguoiDung = nguoiDung;
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
}
