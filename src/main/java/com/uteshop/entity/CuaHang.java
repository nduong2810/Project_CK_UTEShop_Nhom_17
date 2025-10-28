package com.uteshop.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "CuaHang")
public class CuaHang implements Serializable {
	private static final long serialVersionUID = 1L;

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
	private Boolean trangThai; // Changed to Boolean

	@Column(name = "NgayTao", nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date ngayTao; // Changed to Date

	@Column(name = "NgayCapNhat")
	@Temporal(TemporalType.TIMESTAMP)
	private Date ngayCapNhat; // Changed to Date

	@Column(name = "TyLeChietKhau", precision = 5, scale = 2)
	private java.math.BigDecimal tyLeChietKhau;

	// Thông tin thanh toán MoMo
	@Column(name = "MomoEnable")
	private Boolean momoEnable = false;

	@Column(name = "MomoPhone", length = 15)
	private String momoPhone;

	@Column(name = "MomoName", length = 255)
	private String momoName;

	@Column(name = "MomoQR", length = 500)
	private String momoQR;

	// Thông tin thanh toán Ngân hàng
	@Column(name = "BankEnable")
	private Boolean bankEnable = false;

	@Column(name = "BankName", length = 255)
	private String bankName;

	@Column(name = "BankAccountNumber", length = 50)
	private String bankAccountNumber;

	@Column(name = "BankAccountName", length = 255)
	private String bankAccountName;

	@Column(name = "BankQR", length = 500)
	private String bankQR;

	@OneToMany(mappedBy = "cuaHang", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<SanPham> sanPhams = new ArrayList<>();

	public CuaHang() {
		this.ngayTao = new Date();
		this.trangThai = true; // Use Boolean
		this.momoEnable = false;
		this.bankEnable = false;
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

	public List<SanPham> getSanPhams() {
		return sanPhams;
	}

	public void setSanPhams(List<SanPham> sanPhams) {
		this.sanPhams = sanPhams;
	}

	@PreUpdate
	public void preUpdate() {
		this.ngayCapNhat = new Date();
	}

	public java.math.BigDecimal getTyLeChietKhau() {
		return tyLeChietKhau;
	}

	public void setTyLeChietKhau(java.math.BigDecimal v) {
		this.tyLeChietKhau = v;
	}

	// Getter và Setter cho MoMo
	public Boolean getMomoEnable() {
		return momoEnable;
	}

	public void setMomoEnable(Boolean momoEnable) {
		this.momoEnable = momoEnable;
	}

	public String getMomoPhone() {
		return momoPhone;
	}

	public void setMomoPhone(String momoPhone) {
		this.momoPhone = momoPhone;
	}

	public String getMomoName() {
		return momoName;
	}

	public void setMomoName(String momoName) {
		this.momoName = momoName;
	}

	public String getMomoQR() {
		return momoQR;
	}

	public void setMomoQR(String momoQR) {
		this.momoQR = momoQR;
	}

	// Getter và Setter cho Bank
	public Boolean getBankEnable() {
		return bankEnable;
	}

	public void setBankEnable(Boolean bankEnable) {
		this.bankEnable = bankEnable;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankAccountNumber() {
		return bankAccountNumber;
	}

	public void setBankAccountNumber(String bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}

	public String getBankAccountName() {
		return bankAccountName;
	}

	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}

	public String getBankQR() {
		return bankQR;
	}

	public void setBankQR(String bankQR) {
		this.bankQR = bankQR;
	}
}
