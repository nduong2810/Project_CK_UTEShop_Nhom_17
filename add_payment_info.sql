-- Script để thêm thông tin thanh toán vào bảng CuaHang
-- Ngày tạo: 2025-10-28

USE [UTEShop];
GO

-- Thêm các cột cho thông tin thanh toán MoMo
ALTER TABLE CuaHang ADD MomoEnable BIT DEFAULT 0;
ALTER TABLE CuaHang ADD MomoPhone NVARCHAR(15) NULL;
ALTER TABLE CuaHang ADD MomoName NVARCHAR(255) NULL;
ALTER TABLE CuaHang ADD MomoQR NVARCHAR(500) NULL;

-- Thêm các cột cho thông tin thanh toán Ngân hàng
ALTER TABLE CuaHang ADD BankEnable BIT DEFAULT 0;
ALTER TABLE CuaHang ADD BankName NVARCHAR(255) NULL;
ALTER TABLE CuaHang ADD BankAccountNumber NVARCHAR(50) NULL;
ALTER TABLE CuaHang ADD BankAccountName NVARCHAR(255) NULL;
ALTER TABLE CuaHang ADD BankQR NVARCHAR(500) NULL;

-- Cập nhật giá trị mặc định cho các cửa hàng hiện có
UPDATE CuaHang 
SET MomoEnable = 0, BankEnable = 0
WHERE MomoEnable IS NULL OR BankEnable IS NULL;

GO

PRINT 'Đã thêm thành công các cột thông tin thanh toán vào bảng CuaHang';
