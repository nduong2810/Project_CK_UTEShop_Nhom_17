-- ================================================
-- CLEAR ALL DATA AND INSERT NEW SAMPLE DATA (FINAL CORRECTED VERSION)
-- Database: UTESHOP
-- Date: 2025-01-17
-- ================================================

USE UTESHOP;
GO

-- Set proper options for database operations
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO

-- Disable foreign key constraints to allow delete operations
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
GO

-- Clear all existing data (in correct order due to foreign keys)
DELETE FROM ChiTietGioHang;
DELETE FROM GioHang;
DELETE FROM SanPhamYeuThich;
DELETE FROM SanPhamDaXem;
DELETE FROM DanhGiaSanPham;
DELETE FROM DanhGia;
DELETE FROM ChiTietDonHang;
DELETE FROM PhanCongGiaoHang;
DELETE FROM DonHang;
DELETE FROM DiaChiGiaoHang;
DELETE FROM SanPham;
DELETE FROM CuaHang;
DELETE FROM MaGiamGia;
DELETE FROM KhuyenMai;
DELETE FROM OtpXacThuc;
DELETE FROM DanhMuc;
DELETE FROM NguoiDung;
DELETE FROM DonViVanChuyen;

-- Reset identity columns
DBCC CHECKIDENT ('NguoiDung', RESEED, 0);
DBCC CHECKIDENT ('DanhMuc', RESEED, 0);
DBCC CHECKIDENT ('CuaHang', RESEED, 0);
DBCC CHECKIDENT ('SanPham', RESEED, 0);
DBCC CHECKIDENT ('DonHang', RESEED, 0);
DBCC CHECKIDENT ('MaGiamGia', RESEED, 0);
DBCC CHECKIDENT ('GioHang', RESEED, 0);
DBCC CHECKIDENT ('DiaChiGiaoHang', RESEED, 0);
DBCC CHECKIDENT ('DonViVanChuyen', RESEED, 0);

-- Re-enable foreign key constraints
EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"
GO

-- ================================================
-- INSERT NEW DATA
-- ================================================

-- 1. INSERT USERS (NguoiDung) - Password: 123456 for all
INSERT INTO NguoiDung (TenDangNhap, MatKhau, Email, HoTen, soDienThoai, diaChi, VaiTro, TrangThai, NgayTao)
VALUES 
-- Admin
('admin', '123456', 'admin@uteshop.com', N'Quản trị viên hệ thống', '0901234567', N'123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM', 'ADMIN', 1, GETDATE()),

-- Vendors
('vendor1', '123456', 'vendor1@uteshop.com', N'Nguyễn Văn Shop', '0902345678', N'456 Đường Lê Văn Việt, Quận 9, TP.HCM', 'VENDOR', 1, GETDATE()),
('vendor2', '123456', 'vendor2@uteshop.com', N'Trần Thị Fashion', '0903456789', N'789 Đường Nguyễn Văn Cừ, Quận 5, TP.HCM', 'VENDOR', 1, GETDATE()),
('vendor3', '123456', 'vendor3@uteshop.com', N'Phạm Minh Electronics', '0904567890', N'321 Đường Cách Mạng Tháng 8, Quận 3, TP.HCM', 'VENDOR', 1, GETDATE()),

-- Shippers
('shipper1', '123456', 'shipper1@uteshop.com', N'Lê Văn Giao', '0905678901', N'654 Đường Phan Văn Trị, Gò Vấp, TP.HCM', 'SHIPPER', 1, GETDATE()),
('shipper2', '123456', 'shipper2@uteshop.com', N'Hoàng Thị Nhanh', '0906789012', N'987 Đường Điện Biên Phủ, Quận 1, TP.HCM', 'SHIPPER', 1, GETDATE()),

-- Regular Users
('user1', '123456', 'user1@gmail.com', N'Nguyễn Văn A', '0907890123', N'111 Đường Nguyễn Thái Học, Quận 1, TP.HCM', 'USER', 1, GETDATE()),
('user2', '123456', 'user2@gmail.com', N'Trần Thị B', '0908901234', N'222 Đường Lý Tự Trọng, Quận 1, TP.HCM', 'USER', 1, GETDATE()),
('user3', '123456', 'user3@gmail.com', N'Phạm Văn C', '0909012345', N'333 Đường Hai Bà Trưng, Quận 3, TP.HCM', 'USER', 1, GETDATE()),
('user4', '123456', 'user4@gmail.com', N'Lê Thị D', '0910123456', N'444 Đường Pasteur, Quận 1, TP.HCM', 'USER', 1, GETDATE());

-- 2. INSERT CATEGORIES (DanhMuc) - 10 categories
INSERT INTO DanhMuc (TenDM, MoTa, NgayTao)
VALUES 
(N'Điện tử', N'Các sản phẩm điện tử, công nghệ', GETDATE()),
(N'Thời trang', N'Quần áo, phụ kiện thời trang', GETDATE()),
(N'Gia dụng', N'Đồ gia dụng, nội thất', GETDATE()),
(N'Sách & Văn phòng phẩm', N'Sách, dụng cụ học tập và văn phòng', GETDATE()),
(N'Thể thao & Du lịch', N'Đồ thể thao, dụng cụ du lịch', GETDATE()),
(N'Mẹ & Bé', N'Sản phẩm cho mẹ và bé', GETDATE()),
(N'Làm đẹp & Sức khỏe', N'Mỹ phẩm, sản phẩm chăm sóc sức khỏe', GETDATE()),
(N'Xe máy & Ô tô', N'Phụ tùng xe, đồ chơi xe', GETDATE()),
(N'Nhà cửa & Đời sống', N'Đồ dùng nhà bếp, trang trí nhà cửa', GETDATE()),
(N'Giải trí & Sở thích', N'Đồ chơi, nhạc cụ, sưu tập', GETDATE());

-- 3. INSERT SHIPPING COMPANIES (DonViVanChuyen) - 10 companies with correct column names
INSERT INTO DonViVanChuyen (TenDonVi, PhiVanChuyen)
VALUES 
(N'Giao Hàng Nhanh', 25000),
(N'Viettel Post', 30000),
(N'Vietnam Post', 35000),
(N'J&T Express', 22000),
(N'Shopee Express', 20000),
(N'Best Express', 28000),
(N'Ninja Van', 26000),
(N'Kerry Express', 32000),
(N'DHL Express', 45000),
(N'FedEx Vietnam', 50000);

-- 4. INSERT SHOPS (CuaHang) - 10 shops with correct column names
INSERT INTO CuaHang (TenCH, MoTa, DiaChi, soDienThoai, email, MaND, TrangThai, NgayTao)
VALUES 
(N'Tech Store VN', N'Chuyên bán các sản phẩm công nghệ chính hãng', N'456 Đường Lê Văn Việt, Quận 9, TP.HCM', '0902345678', 'vendor1@uteshop.com', 2, 1, GETDATE()),
(N'Fashion House', N'Thời trang cao cấp cho nam và nữ', N'789 Đường Nguyễn Văn Cừ, Quận 5, TP.HCM', '0903456789', 'vendor2@uteshop.com', 3, 1, GETDATE()),
(N'Electronics Pro', N'Điện tử tiêu dùng và linh kiện máy tính', N'321 Đường Cách Mạng Tháng 8, Quận 3, TP.HCM', '0904567890', 'vendor3@uteshop.com', 4, 1, GETDATE()),
(N'Home & Living', N'Đồ gia dụng và nội thất hiện đại', N'654 Đường Phan Văn Trị, Gò Vấp, TP.HCM', '0905111222', 'homeliving@gmail.com', 2, 1, GETDATE()),
(N'Book World', N'Sách và văn phòng phẩm đa dạng', N'987 Đường Điện Biên Phủ, Quận 1, TP.HCM', '0906222333', 'bookworld@gmail.com', 3, 1, GETDATE()),
(N'Sport Zone', N'Thể thao và du lịch chuyên nghiệp', N'159 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0907333444', 'sportzone@gmail.com', 4, 1, GETDATE()),
(N'Baby Care', N'Sản phẩm chăm sóc mẹ và bé', N'357 Đường Lê Lợi, Quận 1, TP.HCM', '0908444555', 'babycare@gmail.com', 2, 1, GETDATE()),
(N'Beauty Paradise', N'Mỹ phẩm và chăm sóc sức khỏe', N'753 Đường Nam Kỳ Khởi Nghĩa, Quận 3, TP.HCM', '0909555666', 'beauty@gmail.com', 3, 1, GETDATE()),
(N'Auto Parts Store', N'Phụ tùng xe máy và ô tô', N'951 Đường Cộng Hòa, Tân Bình, TP.HCM', '0910666777', 'autoparts@gmail.com', 4, 1, GETDATE()),
(N'Fun & Games', N'Giải trí và đồ chơi sưu tập', N'147 Đường Trường Chinh, Tân Bình, TP.HCM', '0911777888', 'fungames@gmail.com', 2, 1, GETDATE());

-- 5. INSERT PRODUCTS (SanPham) - 40 products
INSERT INTO SanPham (TenSP, MoTa, DonGia, SoLuongTon, SoLuongBan, HinhAnh, trangThai, NgayTao, MaDM, MaCH)
VALUES 
-- Electronics (Category 1)
(N'iPhone 15 Pro Max', N'Điện thoại thông minh cao cấp Apple', 29990000, 50, 15, 'iphone15promax.jpg', 1, GETDATE(), 1, 1),
(N'Samsung Galaxy S24 Ultra', N'Flagship Android với bút S-Pen', 26990000, 45, 12, 'galaxys24ultra.jpg', 1, GETDATE(), 1, 1),
(N'MacBook Air M3', N'Laptop siêu mỏng với chip M3', 27990000, 30, 8, 'macbookairm3.jpg', 1, GETDATE(), 1, 3),
(N'Dell XPS 13', N'Ultrabook cao cấp cho doanh nhân', 24990000, 25, 6, 'dellxps13.jpg', 1, GETDATE(), 1, 3),
(N'iPad Pro 12.9 inch', N'Máy tính bảng chuyên nghiệp', 22990000, 35, 10, 'ipadpro.jpg', 1, GETDATE(), 1, 1),
(N'Sony WH-1000XM5', N'Tai nghe chống ồn cao cấp', 7990000, 60, 25, 'sonywh1000xm5.jpg', 1, GETDATE(), 1, 3),
(N'Apple Watch Series 9', N'Đồng hồ thông minh Apple', 9990000, 40, 18, 'applewatch9.jpg', 1, GETDATE(), 1, 1),
(N'Gaming PC RTX 4080', N'Máy tính chơi game hiệu năng cao', 45990000, 15, 3, 'gamingpc4080.jpg', 1, GETDATE(), 1, 3),

-- Fashion (Category 2)
(N'Áo Polo Nam Premium', N'Áo polo nam chất liệu cao cấp', 450000, 100, 35, 'polo_nam.jpg', 1, GETDATE(), 2, 2),
(N'Đầm Công Sở Nữ', N'Đầm công sở thanh lịch', 680000, 80, 28, 'dam_congso.jpg', 1, GETDATE(), 2, 2),
(N'Quần Jeans Nam Slim Fit', N'Quần jeans nam form slim hiện đại', 520000, 120, 42, 'jeans_nam.jpg', 1, GETDATE(), 2, 2),
(N'Áo Blazer Nữ', N'Áo blazer nữ phong cách Hàn Quốc', 780000, 70, 22, 'blazer_nu.jpg', 1, GETDATE(), 2, 2),
(N'Giày Sneaker Nam', N'Giày thể thao nam phong cách', 890000, 90, 38, 'sneaker_nam.jpg', 1, GETDATE(), 2, 2),
(N'Túi Xách Nữ Cao Cấp', N'Túi xách nữ da thật', 1250000, 50, 15, 'tui_xach.jpg', 1, GETDATE(), 2, 2),
(N'Đồng Hồ Nam Thời Trang', N'Đồng hồ nam phong cách cổ điển', 950000, 65, 20, 'dongho_nam.jpg', 1, GETDATE(), 2, 2),
(N'Kính Mắt Nữ UV400', N'Kính râm nữ chống tia UV', 320000, 110, 45, 'kinh_nu.jpg', 1, GETDATE(), 2, 2),

-- Home & Garden (Category 3)
(N'Nồi Cơm Điện Panasonic', N'Nồi cơm điện cao tần 1.8L', 2890000, 40, 18, 'noi_com_dien.jpg', 1, GETDATE(), 3, 4),
(N'Máy Lọc Nước RO 10 Lõi', N'Máy lọc nước gia đình', 5990000, 25, 8, 'may_loc_nuoc.jpg', 1, GETDATE(), 3, 4),
(N'Sofa Phòng Khách 3 Chỗ', N'Sofa da cao cấp cho phòng khách', 12900000, 20, 5, 'sofa_3cho.jpg', 1, GETDATE(), 3, 4),
(N'Tủ Lạnh Inverter 350L', N'Tủ lạnh tiết kiệm điện', 14500000, 30, 12, 'tu_lanh_350l.jpg', 1, GETDATE(), 3, 4),
(N'Máy Giặt LG 9kg', N'Máy giặt cửa trước inverter', 11200000, 35, 14, 'may_giat_9kg.jpg', 1, GETDATE(), 3, 4),
(N'Bếp Từ Đôi Sunhouse', N'Bếp từ đôi tiết kiệm điện', 3400000, 45, 20, 'bep_tu_doi.jpg', 1, GETDATE(), 3, 4),

-- Books & Stationery (Category 4)
(N'Combo Sách Kinh Tế', N'Bộ sách về kinh tế và đầu tư', 350000, 200, 85, 'sach_kinh_te.jpg', 1, GETDATE(), 4, 5),
(N'Bút Bi Parker Cao Cấp', N'Bút bi cao cấp cho doanh nhân', 850000, 150, 48, 'but_parker.jpg', 1, GETDATE(), 4, 5),
(N'Notebook Moleskine', N'Sổ tay cao cấp Moleskine', 420000, 180, 62, 'notebook_moleskine.jpg', 1, GETDATE(), 4, 5),
(N'Máy Tính Casio FX-580', N'Máy tính khoa học Casio', 680000, 120, 45, 'casio_fx580.jpg', 1, GETDATE(), 4, 5),

-- Sports & Travel (Category 5)
(N'Xe Đạp Thể Thao Giant', N'Xe đạp đường trường cao cấp', 15900000, 25, 8, 'xe_dap_giant.jpg', 1, GETDATE(), 5, 6),
(N'Giày Chạy Bộ Nike Air', N'Giày chạy bộ chuyên nghiệp', 2890000, 80, 32, 'giay_chay_bo.jpg', 1, GETDATE(), 5, 6),
(N'Ba Lô Du Lịch 40L', N'Ba lô du lịch chống nước', 1250000, 100, 38, 'balo_du_lich.jpg', 1, GETDATE(), 5, 6),

-- Baby & Kids (Category 6)
(N'Xe Đẩy Em Bé Combi', N'Xe đẩy em bé cao cấp Nhật Bản', 5890000, 30, 12, 'xe_day_be.jpg', 1, GETDATE(), 6, 7),
(N'Ghế Ăn Dặm Cho Bé', N'Ghế ăn dặm an toàn cho trẻ', 1890000, 50, 22, 'ghe_an_dam.jpg', 1, GETDATE(), 6, 7),
(N'Đồ Chơi Lego Classic', N'Bộ đồ chơi Lego sáng tạo', 890000, 120, 55, 'lego_classic.jpg', 1, GETDATE(), 6, 7),

-- Beauty & Health (Category 7)
(N'Serum Vitamin C', N'Serum dưỡng da Vitamin C', 450000, 200, 88, 'serum_vitc.jpg', 1, GETDATE(), 7, 8),
(N'Máy Massage Cầm Tay', N'Máy massage thư giãn', 1250000, 60, 25, 'may_massage.jpg', 1, GETDATE(), 7, 8),
(N'Kem Dưỡng Da Mặt', N'Kem dưỡng da chống lão hóa', 680000, 150, 68, 'kem_duong_da.jpg', 1, GETDATE(), 7, 8),

-- Automotive (Category 8)
(N'Lốp Xe Michelin', N'Lốp xe ô tô cao cấp Michelin', 3200000, 40, 15, 'lop_xe_michelin.jpg', 1, GETDATE(), 8, 9),
(N'Camera Hành Trình 4K', N'Camera hành trình ô tô 4K', 2890000, 70, 28, 'camera_hanh_trinh.jpg', 1, GETDATE(), 8, 9),

-- Entertainment (Category 10)
(N'Guitar Acoustic Yamaha', N'Đàn guitar acoustic chuyên nghiệp', 4500000, 30, 12, 'guitar_yamaha.jpg', 1, GETDATE(), 10, 10),
(N'Board Game Monopoly', N'Trò chơi cờ tỷ phú gia đình', 680000, 80, 35, 'monopoly.jpg', 1, GETDATE(), 10, 10),

-- Home & Living (Category 9)
(N'Đèn LED Thông Minh', N'Đèn LED điều khiển từ xa', 1250000, 90, 38, 'den_led_thongminh.jpg', 1, GETDATE(), 9, 4),
(N'Máy Hút Bụi Robot', N'Robot hút bụi tự động', 8900000, 35, 15, 'robot_hut_bui.jpg', 1, GETDATE(), 9, 4);

-- 6. INSERT DISCOUNT CODES (MaGiamGia) - Using correct column names - 10 codes
INSERT INTO MaGiamGia (MaCode, tenChuongTrinh, moTa, loaiGiam, giaTriGiam, giaTriDonHangToiThieu, soLuongToiDa, soLuongDaSuDung, ngayBatDau, ngayKetThuc, trangThai, ngayTao, maCH)
VALUES 
('WELCOME10', N'Chào mừng khách hàng mới', N'Giảm 10% cho đơn hàng đầu tiên', 'PERCENT', 10.00, 500000, 1000, 150, DATEADD(day, -30, GETDATE()), DATEADD(day, 30, GETDATE()), 1, GETDATE(), 1),
('SAVE50K', N'Tiết kiệm 50K', N'Giảm 50,000đ cho đơn từ 1 triệu', 'FIXED', 50000.00, 1000000, 500, 80, DATEADD(day, -15, GETDATE()), DATEADD(day, 45, GETDATE()), 1, GETDATE(), 2),
('VIP20', N'Khách VIP giảm 20%', N'Giảm 20% cho khách hàng VIP', 'PERCENT', 20.00, 2000000, 200, 45, DATEADD(day, -10, GETDATE()), DATEADD(day, 60, GETDATE()), 1, GETDATE(), 3),
('FREESHIP', N'Miễn phí vận chuyển', N'Miễn phí ship cho đơn từ 500K', 'FREESHIP', 0.00, 500000, 2000, 350, DATEADD(day, -20, GETDATE()), DATEADD(day, 40, GETDATE()), 1, GETDATE(), 4),
('TECH15', N'Giảm giá điện tử', N'Giảm 15% cho sản phẩm điện tử', 'PERCENT', 15.00, 1500000, 300, 65, DATEADD(day, -5, GETDATE()), DATEADD(day, 35, GETDATE()), 1, GETDATE(), 1),
('FASHION25', N'Sale thời trang', N'Giảm 25% đồ thời trang', 'PERCENT', 25.00, 800000, 400, 120, DATEADD(day, -25, GETDATE()), DATEADD(day, 25, GETDATE()), 1, GETDATE(), 2),
('COMBO100K', N'Combo siêu tiết kiệm', N'Giảm 100K khi mua combo', 'FIXED', 100000.00, 3000000, 150, 25, DATEADD(day, -12, GETDATE()), DATEADD(day, 50, GETDATE()), 1, GETDATE(), 3),
('STUDENT5', N'Ưu đãi sinh viên', N'Giảm 5% cho sinh viên', 'PERCENT', 5.00, 200000, 1500, 280, DATEADD(day, -40, GETDATE()), DATEADD(day, 90, GETDATE()), 1, GETDATE(), 4),
('WEEKEND30', N'Cuối tuần vui vẻ', N'Giảm 30% cuối tuần', 'PERCENT', 30.00, 1200000, 250, 95, DATEADD(day, -8, GETDATE()), DATEADD(day, 22, GETDATE()), 1, GETDATE(), 1),
('MEGA200K', N'Siêu sale 200K', N'Giảm 200K cho đơn khủng', 'FIXED', 200000.00, 5000000, 100, 15, DATEADD(day, -18, GETDATE()), DATEADD(day, 42, GETDATE()), 1, GETDATE(), 2);

-- 7. INSERT DELIVERY ADDRESSES (DiaChiGiaoHang) - 10 addresses
INSERT INTO DiaChiGiaoHang (MaND, TenNguoiNhan, SoDienThoai, DiaChi, PhuongXa, QuanHuyen, TinhThanhPho, LoaiDiaChi, MacDinh)
VALUES 
(7, N'Nguyễn Văn A', '0907890123', N'111 Đường Nguyễn Thái Học, Phường Bến Nghé', N'Phường Bến Nghé', N'Quận 1', N'TP. Hồ Chí Minh', N'Nhà riêng', 1),
(8, N'Trần Thị B', '0908901234', N'222 Đường Lý Tự Trọng, Phường Bến Thành', N'Phường Bến Thành', N'Quận 1', N'TP. Hồ Chí Minh', N'Căn hộ', 1),
(9, N'Phạm Văn C', '0909012345', N'333 Đường Hai Bà Trưng, Phường Võ Thị Sáu', N'Phường Võ Thị Sáu', N'Quận 3', N'TP. Hồ Chí Minh', N'Nhà riêng', 1),
(10, N'Lê Thị D', '0910123456', N'444 Đường Pasteur, Phường Nguyễn Thái Bình', N'Phường Nguyễn Thái Bình', N'Quận 1', N'TP. Hồ Chí Minh', N'Văn phòng', 1),
(7, N'Nguyễn Văn A (Công ty)', '0907890123', N'555 Đường Điện Biên Phủ, Phường 1', N'Phường 1', N'Quận 3', N'TP. Hồ Chí Minh', N'Văn phòng', 0),
(8, N'Trần Thị B (Nhà bố mẹ)', '0908901234', N'666 Đường Cách Mạng Tháng 8, Phường 5', N'Phường 5', N'Quận 3', N'TP. Hồ Chí Minh', N'Nhà riêng', 0),
(9, N'Phạm Văn C (Căn hộ mới)', '0909012345', N'777 Đường Nam Kỳ Khởi Nghĩa, Phường 7', N'Phường 7', N'Quận 3', N'TP. Hồ Chí Minh', N'Căn hộ', 0),
(10, N'Lê Thị D (Nhà thuê)', '0910123456', N'888 Đường Lê Văn Sỹ, Phường 1', N'Phường 1', N'Quận Tân Bình', N'TP. Hồ Chí Minh', N'Nhà riêng', 0),
(7, N'Nguyễn Văn A (Kho hàng)', '0907890123', N'999 Đường Hoàng Văn Thụ, Phường 4', N'Phường 4', N'Quận Tân Bình', N'TP. Hồ Chí Minh', N'Kho', 0),
(8, N'Trần Thị B (Shop)', '0908901234', N'101 Đường Phan Văn Trị, Phường 5', N'Phường 5', N'Quận Gò Vấp', N'TP. Hồ Chí Minh', N'Cửa hàng', 0);

PRINT N'✓ Đã xóa toàn bộ dữ liệu cũ và chèn dữ liệu mới thành công!';
PRINT N'✓ Mật khẩu cho tất cả tài khoản: 123456';
PRINT N'✓ Số lượng sản phẩm: 40';
PRINT N'✓ Số lượng bản ghi cho các bảng khác: 10';
GO