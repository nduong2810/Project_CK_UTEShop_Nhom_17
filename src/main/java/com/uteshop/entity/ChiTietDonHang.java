package com.uteshop.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Entity ChiTietDonHang đại diện cho chi tiết của một đơn hàng, sử dụng khóa
 * chính composite.
 */
@Entity
@Table(name = "ChiTietDonHang")
public class ChiTietDonHang implements Serializable {

	private static final long serialVersionUID = 1L;

	// Sử dụng khóa chính composite
	@EmbeddedId
	private ChiTietDonHangPK id;

	// ----------------------------------------------------
	// MAPPING KHÓA NGOẠI (Foreign Key Mapping)
	// Sử dụng @MapsId để liên kết các trường trong EmbeddedId với các Entity
	// ----------------------------------------------------

	@MapsId("donHang")
	@ManyToOne
	@JoinColumn(name = "MaDH", nullable = false)
	private DonHang donHang;

	@MapsId("sanPham")
	@ManyToOne
	@JoinColumn(name = "MaSP", nullable = false)
	private SanPham sanPham;

	// ----------------------------------------------------
	// CÁC THUỘC TÍNH KHÁC
	// ----------------------------------------------------

	@Column(name = "SoLuong", nullable = false)
	private Integer soLuong;

	@Column(name = "DonGia", nullable = false, precision = 19, scale = 4)
	private BigDecimal donGia; // Đơn giá tại thời điểm đặt hàng

	@Column(name = "ThanhTien", precision = 18, scale = 2, insertable = false, updatable = false)
	private BigDecimal thanhTien;

	// Constructors
	public ChiTietDonHang() {
		this.id = new ChiTietDonHangPK();
	}

	public ChiTietDonHang(DonHang donHang, SanPham sanPham, Integer soLuong, BigDecimal donGia) {
		// Khởi tạo EmbeddedId
		this.id = new ChiTietDonHangPK(donHang.getMaDH(), sanPham.getMaSP());
		this.donHang = donHang;
		this.sanPham = sanPham;
		this.soLuong = soLuong;
		this.donGia = donGia;
	}

	// Getters and Setters
	public ChiTietDonHangPK getId() {
		return id;
	}

	public void setId(ChiTietDonHangPK id) {
		this.id = id;
	}

	public DonHang getDonHang() {
		return donHang;
	}

	public void setDonHang(DonHang donHang) {
		this.donHang = donHang;
		if (this.id == null) {
			this.id = new ChiTietDonHangPK();
		}
		this.id.setDonHang(donHang != null ? donHang.getMaDH() : null);
	}

	public SanPham getSanPham() {
		return sanPham;
	}

	public void setSanPham(SanPham sanPham) {
		this.sanPham = sanPham;
		if (this.id == null) {
			this.id = new ChiTietDonHangPK();
		}
		this.id.setSanPham(sanPham != null ? sanPham.getMaSP() : null);
	}

	public Integer getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(Integer soLuong) {
		this.soLuong = soLuong;
	}

	public BigDecimal getDonGia() {
		return donGia;
	}

	public void setDonGia(BigDecimal donGia) {
		this.donGia = donGia;
	}

	public BigDecimal getThanhTien() {
		return thanhTien;
	}
}
