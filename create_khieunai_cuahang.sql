-- Script tạo bảng KhieuNaiCuaHang
CREATE TABLE KhieuNaiCuaHang (
    MaKNCH INT PRIMARY KEY IDENTITY(1,1),
    MaND INT NOT NULL,
    MaCH INT NOT NULL,
    TieuDe NVARCHAR(255) NOT NULL,
    NoiDung NVARCHAR(2000) NOT NULL,
    NgayGui DATETIME NOT NULL DEFAULT GETDATE(),
    TrangThai VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    GhiChu NVARCHAR(1000),
    NgayXuLy DATETIME,
    FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND),
    FOREIGN KEY (MaCH) REFERENCES CuaHang(MaCH),
    CHECK (TrangThai IN ('PENDING', 'APPROVED', 'REJECTED', 'WITHDRAWN'))
);

-- Thêm index để tăng tốc truy vấn
CREATE INDEX IX_KhieuNaiCuaHang_MaND ON KhieuNaiCuaHang(MaND);
CREATE INDEX IX_KhieuNaiCuaHang_MaCH ON KhieuNaiCuaHang(MaCH);
CREATE INDEX IX_KhieuNaiCuaHang_TrangThai ON KhieuNaiCuaHang(TrangThai);
CREATE INDEX IX_KhieuNaiCuaHang_NgayGui ON KhieuNaiCuaHang(NgayGui DESC);
