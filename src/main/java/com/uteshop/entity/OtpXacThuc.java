package com.uteshop.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "OtpXacThuc")
public class OtpXacThuc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maOtp")
    private int maOtp;
    
    @Column(name = "email", nullable = false, length = 100)
    private String email;
    
    @Column(name = "maOtpCode", nullable = false, length = 6)
    private String maOtpCode;
    
    @Column(name = "ngayTao", nullable = false)
    private LocalDateTime ngayTao;
    
    @Column(name = "ngayHetHan", nullable = false)
    private LocalDateTime ngayHetHan;
    
    @Column(name = "daSuDung", nullable = false)
    private boolean daSuDung = false;

    // Constructors
    public OtpXacThuc() {
        this.ngayTao = LocalDateTime.now();
        this.ngayHetHan = this.ngayTao.plusMinutes(5); // OTP expires in 5 minutes
    }

    public OtpXacThuc(String email, String maOtpCode) {
        this();
        this.email = email;
        this.maOtpCode = maOtpCode;
    }

    // Getters and Setters
    public int getMaOtp() { return maOtp; }
    public void setMaOtp(int maOtp) { this.maOtp = maOtp; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMaOtpCode() { return maOtpCode; }
    public void setMaOtpCode(String maOtpCode) { this.maOtpCode = maOtpCode; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public LocalDateTime getNgayHetHan() { return ngayHetHan; }
    public void setNgayHetHan(LocalDateTime ngayHetHan) { this.ngayHetHan = ngayHetHan; }

    public boolean isDaSuDung() { return daSuDung; }
    public void setDaSuDung(boolean daSuDung) { this.daSuDung = daSuDung; }

    // Utility methods
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(this.ngayHetHan);
    }

    public boolean isValid() {
        return !this.daSuDung && !this.isExpired();
    }

    @Override
    public String toString() {
        return "OtpXacThuc{" +
                "maOtp=" + maOtp +
                ", email='" + email + '\'' +
                ", ngayTao=" + ngayTao +
                ", ngayHetHan=" + ngayHetHan +
                ", daSuDung=" + daSuDung +
                '}';
    }
}