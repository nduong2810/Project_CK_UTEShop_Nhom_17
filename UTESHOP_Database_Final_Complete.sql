/* ============================================
   DATABASE: UTESHOP - COMPLETE SETUP SCRIPT
   MÔ TẢ: Script SQL hoàn chỉnh để setup database UTESHOP
   Tác giả: Nhóm sinh viên Khoa CNTT - HCMUTE
   Version: 3.0 - Final Complete Version
   
   TÍNH NĂNG:
   - Tạo database và tất cả các bảng
   - Sửa tất cả lỗi schema validation
   - Tài khoản mẫu với mật khẩu BCrypt đúng
   - Dữ liệu mẫu đầy đủ
   - Hỗ trợ vai trò: Guest, User, Vendor, Admin, Shipper
   
   HƯỚNG DẪN SỬ DỤNG:
   1. Chạy toàn bộ script này để tạo database hoàn chỉnh
   2. Không cần chạy thêm script nào khác
   3. Restart Tomcat server sau khi chạy xong
   4. Đăng nhập bằng các tài khoản mẫu bên dưới
============================================ */

-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'UTESHOP')
BEGIN
    CREATE DATABASE UTESHOP;
    PRINT 'Database UTESHOP đã được tạo thành công!';
END
ELSE
BEGIN
    PRINT 'Database UTESHOP đã tồn tại!';
END
GO

USE UTESHOP;
GO

-- Bật ANSI_NULLS và QUOTED_IDENTIFIER
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

PRINT '🚀 Bắt đầu setup database UTESHOP hoàn chỉnh...';

/* ========================================
   PHẦN 1: TẠO CÁC BẢNG CHÍNH
======================================== */

/* ========== 1. BẢNG NGƯỜI DÙNG ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'NguoiDung')
BEGIN
    CREATE TABLE NguoiDung (
        MaND         INT IDENTITY(1,1) PRIMARY KEY,
        HoTen        NVARCHAR(100) NOT NULL,
        Email        NVARCHAR(100) UNIQUE NOT NULL,
        MatKhau      NVARCHAR(255) NOT NULL,
        TenDangNhap  NVARCHAR(50) UNIQUE NOT NULL,
        VaiTro       NVARCHAR(20) CHECK (VaiTro IN ('USER','VENDOR','ADMIN','SHIPPER')) NOT NULL,
        TrangThai    BIT DEFAULT 1 NOT NULL,
        NgayTao      DATETIME DEFAULT GETDATE(),
        NgayCapNhat  DATETIME DEFAULT GETDATE(),
        SoDienThoai  NVARCHAR(15) NULL,
        DiaChi       NVARCHAR(255) NULL
    );
    PRINT '✓ Bảng NguoiDung đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng NguoiDung đã tồn tại!';
    
    -- Đảm bảo cột TrangThai là BIT type
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'NguoiDung' AND COLUMN_NAME = 'TrangThai' AND DATA_TYPE != 'bit')
    BEGIN
        PRINT '🔧 Fixing NguoiDung.TrangThai column type...';
        
        -- Drop constraint if exists
        DECLARE @ConstraintName NVARCHAR(255);
        SELECT @ConstraintName = dc.name
        FROM sys.default_constraints dc
        INNER JOIN sys.columns c ON dc.parent_column_id = c.column_id
        INNER JOIN sys.tables t ON dc.parent_object_id = t.object_id
        WHERE t.name = 'NguoiDung' AND c.name = 'TrangThai';
        
        IF @ConstraintName IS NOT NULL
        BEGIN
            EXEC('ALTER TABLE NguoiDung DROP CONSTRAINT ' + @ConstraintName);
        END
        
        -- Convert to BIT
        ALTER TABLE NguoiDung ADD TrangThai_New BIT NULL;
        UPDATE NguoiDung SET TrangThai_New = CASE 
            WHEN UPPER(LTRIM(RTRIM(CAST(TrangThai AS NVARCHAR(50))))) IN ('1', 'TRUE', 'T', 'YES', 'Y', N'KÍCH HOẠT', N'HOẠT ĐỘNG') THEN 1 
            ELSE 0 
        END;
        ALTER TABLE NguoiDung DROP COLUMN TrangThai;
        EXEC sp_rename 'NguoiDung.TrangThai_New', 'TrangThai', 'COLUMN';
        ALTER TABLE NguoiDung ALTER COLUMN TrangThai BIT NOT NULL;
        ALTER TABLE NguoiDung ADD CONSTRAINT DF_NguoiDung_TrangThai DEFAULT (1) FOR TrangThai;
        
        PRINT '✓ NguoiDung.TrangThai fixed to BIT type!';
    END
END
GO

/* ========== 2. BẢNG OTP XÁC THỨC ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OtpXacThuc')
BEGIN
    CREATE TABLE OtpXacThuc (
        maOtp        INT IDENTITY(1,1) PRIMARY KEY,
        email        NVARCHAR(100) NOT NULL,
        maOtpCode    NVARCHAR(6) NOT NULL,
        ngayTao      DATETIME2(6) DEFAULT GETDATE(),
        ngayHetHan   DATETIME2(6) NOT NULL,
        daSuDung     BIT DEFAULT 0 NOT NULL,
        MaND         INT NULL,
        CONSTRAINT FK_OtpXacThuc_NguoiDung FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND) ON DELETE CASCADE
    );
    PRINT '✓ Bảng OtpXacThuc đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng OtpXacThuc đã tồn tại!';
END
GO

/* ========== 3. BẢNG CỬA HÀNG ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CuaHang')
BEGIN
    CREATE TABLE CuaHang (
        MaCH         INT IDENTITY(1,1) PRIMARY KEY,
        MaND         INT NOT NULL,
        TenCH        NVARCHAR(255) NOT NULL,
        MoTa         NVARCHAR(1000),
        DiaChi       NVARCHAR(500) NOT NULL,
        SoDienThoai  NVARCHAR(15),
        Email        NVARCHAR(100),
        TrangThai    BIT DEFAULT 1 NOT NULL,
        NgayTao      DATETIME2(6) DEFAULT GETDATE() NOT NULL,
        NgayCapNhat  DATETIME2(6),
        FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND)
    );
    PRINT '✓ Bảng CuaHang đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng CuaHang đã tồn tại!';
END
GO

/* ========== 4. BẢNG DANH MỤC ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DanhMuc')
BEGIN
    CREATE TABLE DanhMuc (
        MaDM        INT IDENTITY(1,1) PRIMARY KEY,
        TenDM       NVARCHAR(100) NOT NULL,
        MaCha       INT NULL,
        NgayTao     DATETIME DEFAULT GETDATE(),
        NgayCapNhat DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (MaCha) REFERENCES DanhMuc(MaDM)
    );
    PRINT '✓ Bảng DanhMuc đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng DanhMuc đã tồn tại!';
    
    -- Đảm bảo có cột NgayTao và NgayCapNhat
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DanhMuc' AND COLUMN_NAME = 'NgayTao')
    BEGIN
        ALTER TABLE DanhMuc ADD NgayTao DATETIME DEFAULT GETDATE();
        UPDATE DanhMuc SET NgayTao = GETDATE() WHERE NgayTao IS NULL;
        PRINT '✓ Added NgayTao column to DanhMuc';
    END
    
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DanhMuc' AND COLUMN_NAME = 'NgayCapNhat')
    BEGIN
        ALTER TABLE DanhMuc ADD NgayCapNhat DATETIME DEFAULT GETDATE();
        UPDATE DanhMuc SET NgayCapNhat = GETDATE() WHERE NgayCapNhat IS NULL;
        PRINT '✓ Added NgayCapNhat column to DanhMuc';
    END
END
GO

/* ========== 5. BẢNG SẢN PHẨM ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SanPham')
BEGIN
    CREATE TABLE SanPham (
        MaSP        INT IDENTITY(1,1) PRIMARY KEY,
        MaCH        INT NOT NULL,
        MaDM        INT NULL,
        TenSP       NVARCHAR(255) NOT NULL,
        DonGia      DECIMAL(18,2) CHECK (DonGia >= 0) NOT NULL,
        SoLuongTon  INT DEFAULT 0 CHECK (SoLuongTon >= 0),
        SoLuongBan  INT DEFAULT 0,
        HinhAnh     NVARCHAR(500) NULL,
        MoTa        NTEXT NULL,
        NgayTao     DATETIME DEFAULT GETDATE(),
        NgayCapNhat DATETIME2,
        TrangThai   BIT DEFAULT 1,
        LuotXem     INT DEFAULT 0,
        LuotYeuThich INT DEFAULT 0,
        DiemDanhGiaTrungBinh DECIMAL(3,2) DEFAULT 0,
        SoLuongDanhGia INT DEFAULT 0,
        FOREIGN KEY (MaCH) REFERENCES CuaHang(MaCH),
        FOREIGN KEY (MaDM) REFERENCES DanhMuc(MaDM)
    );
    PRINT '✓ Bảng SanPham đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng SanPham đã tồn tại!';
END
GO

/* ========== 6. BẢNG ĐƠN VỊ VẬN CHUYỂN ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DonViVanChuyen')
BEGIN
    CREATE TABLE DonViVanChuyen (
        MaVC          INT IDENTITY(1,1) PRIMARY KEY,
        TenDonVi      NVARCHAR(150) NOT NULL,
        PhiVanChuyen  DECIMAL(10,2) DEFAULT 0 CHECK (PhiVanChuyen >= 0)
    );
    PRINT '✓ Bảng DonViVanChuyen đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng DonViVanChuyen đã tồn tại!';
END
GO

/* ========== 7. BẢNG ĐƠN HÀNG ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DonHang')
BEGIN
    CREATE TABLE DonHang (
        MaDH            INT IDENTITY(1,1) PRIMARY KEY,
        MaND            INT NOT NULL,
        MaVC            INT NULL,
        NgayDat         DATETIME2(6) DEFAULT GETDATE() NOT NULL,
        TongTien        DECIMAL(18,2) DEFAULT 0 CHECK (TongTien >= 0),
        TienGiam        DECIMAL(18,2) DEFAULT 0,
        PhiVanChuyen    DECIMAL(18,2) DEFAULT 0,
        TongThanhToan   DECIMAL(18,2) DEFAULT 0 NOT NULL,
        HinhThucTT      NVARCHAR(50) CHECK (HinhThucTT IN ('COD','VNPAY','MOMO')),
        TrangThai       NVARCHAR(50) DEFAULT N'Mới tạo',
        NgayLap         DATETIME DEFAULT GETDATE(),
        DiaChiGiaoHang  NVARCHAR(500) NOT NULL,
        TenNguoiNhan    NVARCHAR(100),
        SoDienThoaiNhanHang NVARCHAR(15),
        GhiChu          NVARCHAR(1000),
        LyDoHuy         NVARCHAR(500),
        NgayXacNhan     DATETIME2,
        NgayGiaoHang    DATETIME2,
        NgayNhanHang    DATETIME2,
        NgayHuy         DATETIME2,
        NgayCapNhat     DATETIME2,
        PhuongThucThanhToan NVARCHAR(20),
        FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND),
        FOREIGN KEY (MaVC) REFERENCES DonViVanChuyen(MaVC)
    );
    PRINT '✓ Bảng DonHang đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng DonHang đã tồn tại!';
    
    -- Đảm bảo có các cột cần thiết
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DonHang' AND COLUMN_NAME = 'DiaChiGiaoHang')
    BEGIN
        ALTER TABLE DonHang ADD DiaChiGiaoHang NVARCHAR(500) NOT NULL DEFAULT N'Địa chỉ mặc định';
        PRINT '✓ Added DiaChiGiaoHang column to DonHang';
    END
    
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DonHang' AND COLUMN_NAME = 'NgayDat')
    BEGIN
        ALTER TABLE DonHang ADD NgayDat DATETIME2(6) NOT NULL DEFAULT GETDATE();
        PRINT '✓ Added NgayDat column to DonHang';
    END
    
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DonHang' AND COLUMN_NAME = 'TongThanhToan')
    BEGIN
        ALTER TABLE DonHang ADD TongThanhToan DECIMAL(18,2) NOT NULL DEFAULT 0;
        UPDATE DonHang SET TongThanhToan = ISNULL(TongTien, 0) + ISNULL(PhiVanChuyen, 0) - ISNULL(TienGiam, 0);
        PRINT '✓ Added TongThanhToan column to DonHang';
    END
END
GO

/* ========== 8. BẢNG CHI TIẾT ĐƠN HÀNG ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ChiTietDonHang')
BEGIN
    CREATE TABLE ChiTietDonHang (
        MaDH      INT NOT NULL,
        MaSP      INT NOT NULL,
        SoLuong   INT DEFAULT 1 CHECK (SoLuong > 0),
        DonGia    DECIMAL(18,2) CHECK (DonGia >= 0) NOT NULL,
        GiamGia   DECIMAL(5,2) DEFAULT 0 CHECK (GiamGia >= 0),
        ThanhTien AS (SoLuong * DonGia * (1 - GiamGia/100)) PERSISTED,
        PRIMARY KEY (MaDH, MaSP),
        FOREIGN KEY (MaDH) REFERENCES DonHang(MaDH) ON DELETE CASCADE,
        FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
    );
    PRINT '✓ Bảng ChiTietDonHang đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng ChiTietDonHang đã tồn tại!';
END
GO

/* ========== 9. BẢNG GIỎ HÀNG ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GioHang')
BEGIN
    CREATE TABLE GioHang (
        MaGH     INT IDENTITY(1,1) PRIMARY KEY,
        MaND     INT NOT NULL,
        NgayTao  DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND)
    );
    PRINT '✓ Bảng GioHang đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng GioHang đã tồn tại!';
END
GO

/* ========== 10. BẢNG CHI TIẾT GIỎ HÀNG ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ChiTietGioHang')
BEGIN
    CREATE TABLE ChiTietGioHang (
        MaGH     INT NOT NULL,
        MaSP     INT NOT NULL,
        SoLuong  INT DEFAULT 1 CHECK (SoLuong > 0),
        NgayThem DATETIME DEFAULT GETDATE(),
        PRIMARY KEY (MaGH, MaSP),
        FOREIGN KEY (MaGH) REFERENCES GioHang(MaGH) ON DELETE CASCADE,
        FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
    );
    PRINT '✓ Bảng ChiTietGioHang đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng ChiTietGioHang đã tồn tại!';
END
GO

/* ========== 11. BẢNG ĐÁNH GIÁ SẢN PHẨM ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DanhGiaSanPham')
BEGIN
    CREATE TABLE DanhGiaSanPham (
        MaDG     INT IDENTITY(1,1) PRIMARY KEY,
        MaSP     INT NOT NULL,
        MaND     INT NOT NULL,
        SoSao    INT CHECK (SoSao BETWEEN 1 AND 5),
        NoiDung  NVARCHAR(500) NOT NULL,
        HinhAnh  NVARCHAR(255) NULL,
        NgayDG   DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP),
        FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND)
    );
    PRINT '✓ Bảng DanhGiaSanPham đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng DanhGiaSanPham đã tồn tại!';
END
GO

/* ========== 12. BẢNG MÃ GIẢM GIÁ ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MaGiamGia')
BEGIN
    CREATE TABLE MaGiamGia (
        MaGG           INT IDENTITY(1,1) PRIMARY KEY,
        MaCode         NVARCHAR(50) UNIQUE NOT NULL,
        maSo           NVARCHAR(20) UNIQUE NOT NULL,
        tenChuongTrinh NVARCHAR(255) NOT NULL,
        loaiGiam       NVARCHAR(20) NOT NULL,
        giaTriGiam     DECIMAL(18,2) NOT NULL,
        ngayBatDau     DATETIME2(6) NOT NULL,
        ngayKetThuc    DATETIME2(6) NOT NULL,
        PhanTramGiam   INT CHECK (PhanTramGiam BETWEEN 0 AND 100),
        GiaTriToiThieu DECIMAL(18,2) DEFAULT 0,
        HanSuDung      DATETIME NOT NULL
    );
    PRINT '✓ Bảng MaGiamGia đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng MaGiamGia đã tồn tại!';
END
GO

/* ========== 13. BẢNG ĐỊA CHỈ GIAO HÀNG ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DiaChiGiaoHang')
BEGIN
    CREATE TABLE DiaChiGiaoHang (
        MaDC INT IDENTITY(1,1) PRIMARY KEY,
        MaND INT NOT NULL,
        TenNguoiNhan NVARCHAR(100) NOT NULL,
        SoDienThoai NVARCHAR(15) NOT NULL,
        DiaChi NVARCHAR(500) NOT NULL,
        TinhThanh NVARCHAR(100) NOT NULL,
        QuanHuyen NVARCHAR(100) NOT NULL,
        PhuongXa NVARCHAR(100) NOT NULL,
        LaMacDinh BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND)
    );
    PRINT '✓ Bảng DiaChiGiaoHang đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng DiaChiGiaoHang đã tồn tại!';
END
GO

/* ========== 14. BẢNG SẢN PHẨM YÊU THÍCH ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SanPhamYeuThich')
BEGIN
    CREATE TABLE SanPhamYeuThich (
        MaND INT NOT NULL,
        MaSP INT NOT NULL,
        NgayThem DATETIME DEFAULT GETDATE(),
        PRIMARY KEY (MaND, MaSP),
        FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND) ON DELETE CASCADE,
        FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE
    );
    PRINT '✓ Bảng SanPhamYeuThich đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng SanPhamYeuThich đã tồn tại!';
END
GO

/* ========== 15. BẢNG SẢN PHẨM ĐÃ XEM ========== */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SanPhamDaXem')
BEGIN
    CREATE TABLE SanPhamDaXem (
        MaND INT NOT NULL,
        MaSP INT NOT NULL,
        NgayXem DATETIME DEFAULT GETDATE(),
        PRIMARY KEY (MaND, MaSP),
        FOREIGN KEY (MaND) REFERENCES NguoiDung(MaND) ON DELETE CASCADE,
        FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE
    );
    PRINT '✓ Bảng SanPhamDaXem đã được tạo!';
END
ELSE
BEGIN
    PRINT '✓ Bảng SanPhamDaXem đã tồn tại!';
END
GO

/* ========================================
   PHẦN 2: DỮ LIỆU MẪU VỚI MẬT KHẨU BCRYPT ĐÚNG
======================================== */

PRINT '📊 Thêm dữ liệu mẫu...';

-- Xóa dữ liệu cũ để tránh trùng lặp
DELETE FROM ChiTietDonHang;
DELETE FROM DonHang;
DELETE FROM ChiTietGioHang;
DELETE FROM GioHang;
DELETE FROM DanhGiaSanPham;
DELETE FROM SanPham;
DELETE FROM CuaHang;
DELETE FROM DanhMuc;
DELETE FROM NguoiDung WHERE MaND > 0;
DELETE FROM DonViVanChuyen;
DELETE FROM MaGiamGia;
DBCC CHECKIDENT ('NguoiDung', RESEED, 0);
DBCC CHECKIDENT ('CuaHang', RESEED, 0);
DBCC CHECKIDENT ('DanhMuc', RESEED, 0);
DBCC CHECKIDENT ('SanPham', RESEED, 0);
DBCC CHECKIDENT ('DonHang', RESEED, 0);

-- Thêm tài khoản người dùng với mật khẩu BCrypt ĐÚNG
INSERT INTO NguoiDung (TenDangNhap, MatKhau, Email, HoTen, VaiTro, TrangThai, NgayTao, NgayCapNhat, SoDienThoai, DiaChi) VALUES 
-- Tài khoản Admin
('admin', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin@uteshop.com', N'Quản trị viên', 'ADMIN', 1, GETDATE(), GETDATE(), '0901234567', N'123 Admin Street, TP.HCM'),

-- Tài khoản Vendor  
('vendor', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'vendor@uteshop.com', N'Người bán hàng', 'VENDOR', 1, GETDATE(), GETDATE(), '0901234568', N'456 Vendor Street, TP.HCM'),

-- Tài khoản User
('user', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user@uteshop.com', N'Khách hàng', 'USER', 1, GETDATE(), GETDATE(), '0901234569', N'789 User Street, TP.HCM'),

-- Tài khoản Shipper
('shipper', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'shipper@uteshop.com', N'Nhân viên giao hàng', 'SHIPPER', 1, GETDATE(), GETDATE(), '0901234570', N'101 Shipper Street, TP.HCM'),

-- Tài khoản test đơn giản
('test', 'test', 'test@uteshop.com', N'Test User', 'USER', 1, GETDATE(), GETDATE(), '0901234571', N'Test Address');

PRINT '✓ Đã thêm 5 tài khoản người dùng (Admin, Vendor, User, Shipper, Test)';

-- Thêm danh mục sản phẩm
INSERT INTO DanhMuc (TenDM, MaCha, NgayTao, NgayCapNhat) VALUES 
(N'Điện thoại', NULL, GETDATE(), GETDATE()),
(N'Laptop', NULL, GETDATE(), GETDATE()),
(N'Thời trang', NULL, GETDATE(), GETDATE()),
(N'Phụ kiện', NULL, GETDATE(), GETDATE()),
(N'Đồng hồ', NULL, GETDATE(), GETDATE()),
(N'iPhone', 1, GETDATE(), GETDATE()),
(N'Samsung', 1, GETDATE(), GETDATE()),
(N'Asus', 2, GETDATE(), GETDATE()),
(N'Dell', 2, GETDATE(), GETDATE()),
(N'Áo thun', 3, GETDATE(), GETDATE());

PRINT '✓ Đã thêm 10 danh mục sản phẩm';

-- Thêm đơn vị vận chuyển
INSERT INTO DonViVanChuyen (TenDonVi, PhiVanChuyen) VALUES 
(N'Giao hàng nhanh', 25000),
(N'Giao hàng tiết kiệm', 15000),
(N'Giao hàng hỏa tốc', 50000),
(N'Giao hàng miễn phí', 0);

PRINT '✓ Đã thêm 4 đơn vị vận chuyển';

-- Thêm cửa hàng mẫu
INSERT INTO CuaHang (MaND, TenCH, MoTa, DiaChi, SoDienThoai, Email, TrangThai, NgayTao) VALUES 
(2, N'Cửa hàng điện tử ABC', N'Chuyên bán điện thoại, laptop chính hãng', N'123 Nguyễn Văn Cừ, Quận 5, TP.HCM', '0281234567', 'abc@shop.com', 1, GETDATE()),
(2, N'Thời trang XYZ', N'Thời trang nam nữ trendy', N'456 Lê Văn Sỹ, Quận 3, TP.HCM', '0281234568', 'xyz@fashion.com', 1, GETDATE());

PRINT '✓ Đã thêm 2 cửa hàng mẫu';

-- Thêm sản phẩm mẫu
INSERT INTO SanPham (MaCH, MaDM, TenSP, DonGia, SoLuongTon, SoLuongBan, HinhAnh, MoTa, NgayTao, TrangThai) VALUES 
(1, 6, N'iPhone 15 Pro Max', 29999000, 50, 10, '/images/iphone15pro.jpg', N'iPhone 15 Pro Max 256GB - Chính hãng Apple Việt Nam', GETDATE(), 1),
(1, 7, N'Samsung Galaxy S24 Ultra', 25999000, 30, 5, '/images/s24ultra.jpg', N'Samsung Galaxy S24 Ultra 512GB - Chính hãng', GETDATE(), 1),
(1, 8, N'ASUS ROG Strix G15', 22999000, 20, 3, '/images/asus-rog.jpg', N'ASUS ROG Strix G15 - Gaming Laptop RTX 4060', GETDATE(), 1),
(2, 10, N'Áo thun nam basic', 199000, 100, 25, '/images/ao-thun-nam.jpg', N'Áo thun nam cotton 100% thoáng mát', GETDATE(), 1),
(2, 5, N'Đồng hồ thông minh Apple Watch', 9999000, 15, 8, '/images/apple-watch.jpg', N'Apple Watch Series 9 GPS 45mm', GETDATE(), 1);

PRINT '✓ Đã thêm 5 sản phẩm mẫu';

-- Thêm mã giảm giá
INSERT INTO MaGiamGia (MaCode, maSo, tenChuongTrinh, loaiGiam, giaTriGiam, ngayBatDau, ngayKetThuc, PhanTramGiam, GiaTriToiThieu, HanSuDung) VALUES 
('WELCOME10', 'WELCOME10', N'Chào mừng khách hàng mới', 'PERCENT', 10, GETDATE(), DATEADD(month, 3, GETDATE()), 10, 500000, DATEADD(month, 3, GETDATE())),
('FREESHIP', 'FREESHIP', N'Miễn phí vận chuyển', 'FIXED', 25000, GETDATE(), DATEADD(month, 1, GETDATE()), 0, 1000000, DATEADD(month, 1, GETDATE())),
('SALE20', 'SALE20', N'Giảm giá 20%', 'PERCENT', 20, GETDATE(), DATEADD(week, 2, GETDATE()), 20, 2000000, DATEADD(week, 2, GETDATE()));

PRINT '✓ Đã thêm 3 mã giảm giá';

-- Tạo giỏ hàng mẫu
INSERT INTO GioHang (MaND, NgayTao) VALUES 
(3, GETDATE()),
(5, GETDATE());

PRINT '✓ Đã tạo giỏ hàng cho user';

-- Thêm chi tiết giỏ hàng
INSERT INTO ChiTietGioHang (MaGH, MaSP, SoLuong, NgayThem) VALUES 
(1, 1, 1, GETDATE()),
(1, 4, 2, GETDATE()),
(2, 2, 1, GETDATE());

PRINT '✓ Đã thêm sản phẩm vào giỏ hàng';

/* ========================================
   PHẦN 3: HOÀN THÀNH VÀ KIỂM TRA
======================================== */

-- Kiểm tra kết quả cuối cùng
PRINT '';
PRINT '🎯 ===============================================';
PRINT '🎯 HOÀN THÀNH SETUP DATABASE UTESHOP!';  
PRINT '🎯 ===============================================';
PRINT '';

-- Hiển thị thống kê
PRINT '📊 THỐNG KÊ DATABASE:';
SELECT 'NguoiDung' as TableName, COUNT(*) as RecordCount FROM NguoiDung
UNION ALL SELECT 'DanhMuc', COUNT(*) FROM DanhMuc  
UNION ALL SELECT 'CuaHang', COUNT(*) FROM CuaHang
UNION ALL SELECT 'SanPham', COUNT(*) FROM SanPham
UNION ALL SELECT 'DonViVanChuyen', COUNT(*) FROM DonViVanChuyen
UNION ALL SELECT 'MaGiamGia', COUNT(*) FROM MaGiamGia
UNION ALL SELECT 'GioHang', COUNT(*) FROM GioHang
ORDER BY TableName;

PRINT '';
PRINT '🔑 TÀI KHOẢN ĐĂNG NHẬP:';
PRINT '────────────────────────────────────────────────';
PRINT '👨‍💼 ADMIN:    Username: admin    | Password: password';
PRINT '🏪 VENDOR:   Username: vendor   | Password: password'; 
PRINT '👤 USER:     Username: user     | Password: password';
PRINT '🚚 SHIPPER:  Username: shipper  | Password: password';
PRINT '🧪 TEST:     Username: test     | Password: test';
PRINT '';
PRINT '💡 LƯU Ý: Mật khẩu "password" đã được mã hóa BCrypt';
PRINT '💡 Tài khoản "test" sử dụng plain text password';
PRINT '';
PRINT '✅ Tất cả lỗi schema validation đã được sửa';
PRINT '✅ Database đã sẵn sàng cho ứng dụng UTESHOP';
PRINT '✅ Restart Tomcat server để bắt đầu sử dụng';
PRINT '';
PRINT '🎯 ===============================================';

GO