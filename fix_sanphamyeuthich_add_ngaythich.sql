-- Fix: Thêm cột NgayThich vào bảng SanPhamYeuThich
-- Ngày: 29/10/2025

USE UTESHOP;
GO

-- Kiểm tra xem cột đã tồn tại chưa
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID(N'[dbo].[SanPhamYeuThich]') 
               AND name = 'NgayThich')
BEGIN
    -- Thêm cột NgayThich với giá trị mặc định là thời gian hiện tại
    ALTER TABLE [dbo].[SanPhamYeuThich]
    ADD [NgayThich] DATETIME2 NULL DEFAULT GETDATE();
    
    -- Cập nhật giá trị cho các bản ghi cũ (nếu có)
    UPDATE [dbo].[SanPhamYeuThich]
    SET [NgayThich] = GETDATE()
    WHERE [NgayThich] IS NULL;
    
    PRINT 'Đã thêm cột NgayThich vào bảng SanPhamYeuThich thành công!';
END
ELSE
BEGIN
    PRINT 'Cột NgayThich đã tồn tại trong bảng SanPhamYeuThich.';
END
GO
