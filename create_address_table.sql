-- Script tạo bảng DiaChiGiaoHang cho UTEShop
-- Chạy script này nếu bảng chưa tồn tại trong database

USE [UTEShop];
GO

-- Kiểm tra và tạo bảng DiaChiGiaoHang nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DiaChiGiaoHang')
BEGIN
    CREATE TABLE DiaChiGiaoHang (
        maDC INT IDENTITY(1,1) PRIMARY KEY,
        maND INT NOT NULL,
        tenNguoiNhan NVARCHAR(100) NOT NULL,
        soDienThoai NVARCHAR(15) NOT NULL,
        diaChiCuThe NVARCHAR(255) NOT NULL,
        phuong NVARCHAR(100) NOT NULL,
        quan NVARCHAR(100) NOT NULL,
        thanhPho NVARCHAR(100) NOT NULL,
        laMacDinh BIT DEFAULT 0,
        ngayTao DATETIME2 DEFAULT GETDATE(),
        ngayCapNhat DATETIME2 DEFAULT GETDATE(),
        
        -- Foreign Key
        CONSTRAINT FK_DiaChiGiaoHang_NguoiDung 
            FOREIGN KEY (maND) REFERENCES NguoiDung(MaND) 
            ON DELETE CASCADE
    );
    
    PRINT 'Đã tạo bảng DiaChiGiaoHang thành công!';
END
ELSE
BEGIN
    PRINT 'Bảng DiaChiGiaoHang đã tồn tại!';
END
GO

-- Tạo index để tăng tốc độ truy vấn
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DiaChiGiaoHang_maND')
BEGIN
    CREATE INDEX IX_DiaChiGiaoHang_maND ON DiaChiGiaoHang(maND);
    PRINT 'Đã tạo index IX_DiaChiGiaoHang_maND!';
END
GO

-- Thêm dữ liệu mẫu (tuỳ chọn - comment dòng này nếu không muốn)
-- INSERT INTO DiaChiGiaoHang (maND, tenNguoiNhan, soDienThoai, diaChiCuThe, phuong, quan, thanhPho, laMacDinh)
-- VALUES 
-- (1, N'Nguyễn Văn A', '0901234567', N'123 Đường ABC', N'Phường 1', N'Quận 1', N'TP. Hồ Chí Minh', 1),
-- (1, N'Nguyễn Văn A', '0901234567', N'456 Đường XYZ', N'Phường 2', N'Quận 3', N'TP. Hồ Chí Minh', 0);

PRINT 'Hoàn tất script DiaChiGiaoHang!';
GO
