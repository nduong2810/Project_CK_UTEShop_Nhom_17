-- =============================================
-- SCRIPT TẠO BẢNG CHAT CHO UTESHOP
-- Chạy file này trong SQL Server Management Studio
-- =============================================

USE UTESHOP;
GO

-- Kiểm tra và xóa bảng cũ nếu tồn tại (cẩn thận!)
IF OBJECT_ID('dbo.TinNhan', 'U') IS NOT NULL
    DROP TABLE dbo.TinNhan;
GO

IF OBJECT_ID('dbo.HoiThoai', 'U') IS NOT NULL
    DROP TABLE dbo.HoiThoai;
GO

PRINT 'Bắt đầu tạo bảng HoiThoai và TinNhan...';
GO

-- Tạo bảng HoiThoai (Conversations)
CREATE TABLE HoiThoai (
    MaHoiThoai INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT NOT NULL,
    MaCuaHang INT NOT NULL,
    TinNhanCuoi NVARCHAR(500),
    NgayTaoHoiThoai DATETIME NOT NULL DEFAULT GETDATE(),
    NgayCapNhat DATETIME NOT NULL DEFAULT GETDATE(),
    SoTinNhanChuaDoc INT DEFAULT 0,
    NguoiGuiCuoi INT,
    TrangThai BIT DEFAULT 1,
    CONSTRAINT FK_HoiThoai_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES NguoiDung(MaND),
    CONSTRAINT FK_HoiThoai_CuaHang FOREIGN KEY (MaCuaHang) REFERENCES CuaHang(MaCH),
    CONSTRAINT UK_HoiThoai UNIQUE (MaKhachHang, MaCuaHang)
);
GO

PRINT 'Đã tạo bảng HoiThoai thành công!';
GO

-- Tạo bảng TinNhan (Messages)
CREATE TABLE TinNhan (
    MaTinNhan INT PRIMARY KEY IDENTITY(1,1),
    MaHoiThoai INT NOT NULL,
    MaNguoiGui INT NOT NULL,
    NoiDung NVARCHAR(2000) NOT NULL,
    NgayGui DATETIME NOT NULL DEFAULT GETDATE(),
    DaDoc BIT DEFAULT 0,
    NgayDoc DATETIME,
    LoaiTinNhan VARCHAR(20) DEFAULT 'TEXT',
    DuongDanFile NVARCHAR(500),
    CONSTRAINT FK_TinNhan_HoiThoai FOREIGN KEY (MaHoiThoai) REFERENCES HoiThoai(MaHoiThoai) ON DELETE CASCADE,
    CONSTRAINT FK_TinNhan_NguoiGui FOREIGN KEY (MaNguoiGui) REFERENCES NguoiDung(MaND)
);
GO

PRINT 'Đã tạo bảng TinNhan thành công!';
GO

-- Tạo indexes để tăng performance
CREATE INDEX IDX_HoiThoai_MaKhachHang ON HoiThoai(MaKhachHang);
CREATE INDEX IDX_HoiThoai_MaCuaHang ON HoiThoai(MaCuaHang);
CREATE INDEX IDX_HoiThoai_NgayCapNhat ON HoiThoai(NgayCapNhat DESC);
CREATE INDEX IDX_TinNhan_MaHoiThoai ON TinNhan(MaHoiThoai);
CREATE INDEX IDX_TinNhan_NgayGui ON TinNhan(NgayGui DESC);
CREATE INDEX IDX_TinNhan_DaDoc ON TinNhan(DaDoc);
GO

PRINT 'Đã tạo indexes thành công!';
GO

-- Kiểm tra kết quả
SELECT 'HoiThoai' AS TableName, COUNT(*) AS RecordCount FROM HoiThoai
UNION ALL
SELECT 'TinNhan' AS TableName, COUNT(*) AS RecordCount FROM TinNhan;
GO

PRINT '========================================';
PRINT 'HOÀN THÀNH! Đã tạo bảng chat thành công!';
PRINT '========================================';
GO
