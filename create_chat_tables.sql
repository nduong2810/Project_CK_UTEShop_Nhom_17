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
    FOREIGN KEY (MaKhachHang) REFERENCES NguoiDung(MaND),
    FOREIGN KEY (MaCuaHang) REFERENCES CuaHang(MaCH),
    CONSTRAINT UK_HoiThoai UNIQUE (MaKhachHang, MaCuaHang)
);

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
    FOREIGN KEY (MaHoiThoai) REFERENCES HoiThoai(MaHoiThoai) ON DELETE CASCADE,
    FOREIGN KEY (MaNguoiGui) REFERENCES NguoiDung(MaND)
);

-- Tạo indexes để tăng performance
CREATE INDEX IDX_HoiThoai_MaKhachHang ON HoiThoai(MaKhachHang);
CREATE INDEX IDX_HoiThoai_MaCuaHang ON HoiThoai(MaCuaHang);
CREATE INDEX IDX_HoiThoai_NgayCapNhat ON HoiThoai(NgayCapNhat DESC);
CREATE INDEX IDX_TinNhan_MaHoiThoai ON TinNhan(MaHoiThoai);
CREATE INDEX IDX_TinNhan_NgayGui ON TinNhan(NgayGui DESC);
CREATE INDEX IDX_TinNhan_DaDoc ON TinNhan(DaDoc);

-- Thêm một số dữ liệu mẫu (tùy chọn)
-- INSERT INTO HoiThoai (MaKhachHang, MaCuaHang, TinNhanCuoi, NgayTaoHoiThoai, NgayCapNhat, SoTinNhanChuaDoc, TrangThai)
-- VALUES (1, 1, N'Chào bạn, shop có sản phẩm này không?', GETDATE(), GETDATE(), 1, 1);

PRINT 'Đã tạo bảng HoiThoai và TinNhan thành công!';
