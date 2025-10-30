# 🛒 UTESHOP - Hệ thống Thương mại Điện tử

<div align="center">

![Java](https://img.shields.io/badge/Java-22-orange?style=for-the-badge&logo=java)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue?style=for-the-badge&logo=eclipse)
![Hibernate](https://img.shields.io/badge/Hibernate-6.6.1-green?style=for-the-badge&logo=hibernate)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.3-purple?style=for-the-badge&logo=bootstrap)
![SQL Server](https://img.shields.io/badge/SQL%20Server-2019-red?style=for-the-badge&logo=microsoft-sql-server)

**Hệ thống thương mại điện tử đa người dùng với tính năng real-time chat và quản lý toàn diện**

[📖 Tài liệu](#tài-liệu) • [🚀 Bắt đầu](#bắt-đầu-nhanh) • [✨ Tính năng](#tính-năng-chính) • [🏗️ Kiến trúc](#kiến-trúc-hệ-thống) • [👥 Nhóm phát triển](#nhóm-phát-triển)

</div>

---

## 📋 Mục lục

- [Giới thiệu](#giới-thiệu)
- [Tính năng chính](#tính-năng-chính)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [Kiến trúc hệ thống](#kiến-trúc-hệ-thống)
- [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
- [Bắt đầu nhanh](#bắt-đầu-nhanh)
- [Cấu trúc thư mục](#cấu-trúc-thư-mục)
- [Cấu hình](#cấu-hình)
- [Tài liệu](#tài-liệu)
- [Screenshots](#screenshots)
- [API Reference](#api-reference)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)
- [Nhóm phát triển](#nhóm-phát-triển)

---

## 🎯 Giới thiệu

**UTESHOP** là một nền tảng thương mại điện tử toàn diện được xây dựng với Jakarta EE 10 và Hibernate ORM. Hệ thống hỗ trợ đa vai trò người dùng (Khách hàng, Vendor, Admin, Shipper) với đầy đủ tính năng quản lý sản phẩm, đơn hàng, thanh toán và giao tiếp real-time.

### 🌟 Điểm nổi bật

- ✅ **Multi-role System**: Hỗ trợ 4 vai trò với quyền hạn riêng biệt
- ✅ **Real-time Chat**: WebSocket cho chat giữa khách hàng và vendor
- ✅ **Responsive Design**: Giao diện thân thiện trên mọi thiết bị
- ✅ **Security**: JWT authentication + role-based authorization
- ✅ **Performance**: HikariCP connection pooling cho hiệu suất tối ưu
- ✅ **Vietnamese Support**: Hỗ trợ đầy đủ tiếng Việt với UTF-8

### 🎓 Thông tin dự án

- **Đồ án**: Cuối kỳ môn Lập trình Web
- **Trường**: Đại học Sư phạm Kỹ thuật TP.HCM (UTE)
- **Khoa**: Công nghệ Thông tin
- **Năm học**: 2025-2026
- **Nhóm**: 17
- **Version**: 1.1

---

## ✨ Tính năng chính

### 👤 Khách hàng (Customer)

- 🔐 **Tài khoản**: Đăng ký, đăng nhập, quên mật khẩu (OTP via email)
- 🛍️ **Mua sắm**: Duyệt sản phẩm, tìm kiếm, lọc theo danh mục
- 🛒 **Giỏ hàng**: Thêm/xóa sản phẩm, cập nhật số lượng
- 💳 **Thanh toán**: COD, Banking, Mã giảm giá
- 📦 **Đơn hàng**: Xem lịch sử, theo dõi trạng thái, hủy đơn
- ⭐ **Đánh giá**: Review sản phẩm, đánh giá vendor
- ❤️ **Yêu thích**: Lưu sản phẩm yêu thích
- 💬 **Chat**: Nhắn tin trực tiếp với vendor
- 🚩 **Khiếu nại**: Gửi khiếu nại về cửa hàng, sửa/xóa khiếu nại

### 🏪 Vendor (Người bán)

- 📊 **Dashboard**: Thống kê doanh thu, đơn hàng, sản phẩm
- 📦 **Quản lý sản phẩm**: Thêm, sửa, xóa, ẩn/hiện sản phẩm
- 📋 **Quản lý đơn hàng**: Xác nhận, hủy, cập nhật trạng thái
- 🏷️ **Mã giảm giá**: Tạo và quản lý voucher
- 💬 **Chat**: Trả lời tin nhắn khách hàng
- 📈 **Báo cáo**: Doanh thu theo thời gian, sản phẩm bán chạy
- ⚙️ **Cài đặt**: Thông tin cửa hàng, thanh toán

### 👨‍💼 Admin

- 📊 **Dashboard**: Tổng quan hệ thống
- 👥 **Quản lý người dùng**: Khách hàng, vendor, shipper
- 🏪 **Quản lý cửa hàng**: Duyệt, khóa, xóa cửa hàng
- 📦 **Quản lý sản phẩm**: Xem, ẩn/hiện sản phẩm vi phạm
- 📋 **Quản lý đơn hàng**: Xem tất cả đơn hàng
- 🗂️ **Quản lý danh mục**: CRUD danh mục sản phẩm
- 🚚 **Đơn vị vận chuyển**: Quản lý đối tác vận chuyển
- 🏷️ **Mã giảm giá**: Tạo mã giảm giá hệ thống
- 🚩 **Khiếu nại**: Xử lý khiếu nại về cửa hàng và người dùng
- ⚙️ **Cài đặt**: Cấu hình hệ thống

### 🚚 Shipper

- 📦 **Đơn hàng pickup**: Nhận đơn cần lấy hàng
- 🚚 **Đang giao**: Quản lý đơn đang giao
- ✅ **Lịch sử**: Xem đơn đã hoàn thành
- 📍 **Theo dõi**: GPS tracking (planned)

---

## 🛠️ Công nghệ sử dụng

### Backend Stack

| Công nghệ | Version | Mục đích |
|-----------|---------|----------|
| **Java** | 21 | Ngôn ngữ lập trình chính |
| **Jakarta EE** | 10 | Enterprise platform (Servlet, JSP, WebSocket) |
| **Hibernate ORM** | 6.6.1.Final | Object-Relational Mapping |
| **Spring Framework** | 6.1.12 | Dependency Injection, Utilities |
| **Spring Security** | 6.3.2 | Security framework |
| **JWT (JJWT)** | 0.12.6 | Token-based authentication |
| **HikariCP** | 5.1.0 | Connection pooling |
| **Jakarta Mail** | 2.0.1 | Email service (OTP, notifications) |
| **Gson** | 2.10.1 | JSON serialization/deserialization |

### Database

| Công nghệ | Version | Mục đích |
|-----------|---------|----------|
| **Microsoft SQL Server** | 2019+ | Relational database |
| **JPA** | 3.0 |  |

### Frontend Stack

| Công nghệ | Version | Mục đích |
|-----------|---------|----------|
| **JSP** | 3.1.1 | Server-side rendering |
| **JSTL** | 3.0.0 | JSP Standard Tag Library |
| **Bootstrap** | 5.3.3 | CSS framework |
| **Bootstrap Icons** | 1.11.3 | Icon library |
| **JavaScript** | ES6+ | Client-side scripting |
| **WebSocket API** | 2.1.1 | Real-time communication |

### Build & Deployment

| Công nghệ | Version | Mục đích |
|-----------|---------|----------|
| **Maven** | 3.x | Build automation |
| **Apache Tomcat** | 10.1.x | Servlet container |
| **SiteMesh** | 3.2.1 | Layout/decorator pattern |

### Development Tools

- **IDE**: Eclipse/IntelliJ IDEA
- **Database Tool**: SQL Server Management Studio (SSMS)
- **Version Control**: Git + GitHub
- **API Testing**: Postman (optional)

---

## 🏗️ Kiến trúc hệ thống

### Layered Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                    │
│  ┌────────────────────────────────────────────────────┐ │
│  │  JSP Views + Bootstrap + JavaScript                │ │
│  │  • SiteMesh Layouts (Guest, User, Admin, Vendor)  │ │
│  │  • JSTL Tags for dynamic content                  │ │
│  └────────────────────────────────────────────────────┘ │
└───────────────────────┬─────────────────────────────────┘
                        │ HTTP/WebSocket
┌───────────────────────▼─────────────────────────────────┐
│                    CONTROLLER LAYER                      │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Servlets (@WebServlet)                           │ │
│  │  • AuthController, ProductController, etc.        │ │
│  │  • WebSocket Endpoints (ChatWebSocket)            │ │
│  └────────────────────────────────────────────────────┘ │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Filters                                           │ │
│  │  • AuthFilter (JWT validation)                    │ │
│  │  • CharacterEncodingFilter (UTF-8)                │ │
│  │  • SiteMeshFilter (Layout decoration)             │ │
│  └────────────────────────────────────────────────────┘ │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                    SERVICE LAYER                         │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Business Logic Services                          │ │
│  │  • EmailService, OTPService                       │ │
│  │  • ProductTextNormalizer                          │ │
│  └────────────────────────────────────────────────────┘ │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                    DAO LAYER                             │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Data Access Objects                              │ │
│  │  • SanPhamDAO, NguoiDungDAO, DonHangDAO          │ │
│  │  • CuaHangDAO, GioHangDAO, etc.                  │ │
│  └────────────────────────────────────────────────────┘ │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                    PERSISTENCE LAYER                     │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Hibernate ORM (JPA Implementation)               │ │
│  │  • EntityManager, Session Management             │ │
│  │  • HikariCP Connection Pool                      │ │
│  └────────────────────────────────────────────────────┘ │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                    DATABASE LAYER                        │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Microsoft SQL Server                             │ │
│  │  • Database: UTESHOP                              │ │
│  │  • 20+ Tables with relationships                  │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Design Patterns

- **MVC (Model-View-Controller)**: Tách biệt logic, presentation, data
- **DAO (Data Access Object)**: Encapsulate database operations
- **Singleton**: EntityManagerFactory, Service instances
- **Factory**: Entity creation
- **Filter Pattern**: Request/Response processing
- **Decorator Pattern**: SiteMesh layouts

### Database Schema

#### Core Entities

```
NguoiDung (User)
├── MaND (PK)
├── TenDangNhap, MatKhau, Email
├── VaiTro: USER | VENDOR | ADMIN | SHIPPER
└── TrangThai, NgayTao

CuaHang (Shop)
├── MaCH (PK)
├── MaND (FK → NguoiDung)
├── TenCH, MoTa, DiaChi
└── TrangThai, NgayTao

SanPham (Product)
├── MaSP (PK)
├── MaCH (FK → CuaHang)
├── MaDM (FK → DanhMuc)
├── TenSP, MoTa, DonGia
└── SoLuong, SoLuongBan, TrangThai

DonHang (Order)
├── MaDH (PK)
├── MaND (FK → NguoiDung)
├── TongTien, PhiVanChuyen
├── TrangThai: PENDING | CONFIRMED | SHIPPING | COMPLETED | CANCELLED
└── PhuongThucThanhToan: COD | BANKING

ChiTietDonHang (Order Detail)
├── MaDH (FK → DonHang)
├── MaSP (FK → SanPham)
├── SoLuong, DonGia
└── ThanhTien

GioHang (Cart)
└── ChiTietGioHang (Cart Items)

MaGiamGia (Discount Code)
├── MaGG (PK)
├── MaCH (FK → CuaHang, nullable)
├── MaCode, GiaTri, LoaiGiam
└── NgayBatDau, NgayKetThuc

KhieuNaiCuaHang (Shop Complaint)
├── MaKNCH (PK)
├── MaND (FK → NguoiDung)
├── MaCH (FK → CuaHang)
├── TrangThai: PENDING | APPROVED | REJECTED | WITHDRAWN
└── NgayGui, NgayXuLy
```

---

## 💻 Yêu cầu hệ thống

### Phần mềm cần thiết

- **JDK**: 21 hoặc cao hơn
- **Apache Tomcat**: 10.1.x
- **Microsoft SQL Server**: 2019 hoặc cao hơn
- **Maven**: 3.6+
- **IDE**: Eclipse/IntelliJ IDEA (khuyến nghị)
- **Git**: Latest version

### Cấu hình tối thiểu

- **RAM**: 4GB (8GB khuyến nghị)
- **CPU**: Dual-core 2.0GHz+
- **Disk Space**: 2GB cho project và dependencies
- **OS**: Windows 10/11, Linux, macOS

---

## 🚀 Bắt đầu nhanh

### 1. Clone Repository

```bash
git clone https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17.git
cd Project_CK_UTEShop_Nhom_17
```

### 2. Cấu hình Database

#### Tạo Database

```sql
CREATE DATABASE UTESHOP;
GO

USE UTESHOP;
GO
```

#### Import Schema

```bash
# Chạy file SQL để tạo tables
sqlcmd -S localhost -U sa -P your_password -d UTESHOP -i dlTong.sql
```

Hoặc import trong SQL Server Management Studio:
1. Open SSMS
2. Connect to server
3. Right-click `UTESHOP` database
4. Tasks → Execute SQL File → Chọn `dlTong.sql`

#### Import Sample Data (Optional)

```bash
sqlcmd -S localhost -U sa -P your_password -d UTESHOP -i dlmau.sql
```


### 3. Build Project

```bash
mvn clean install
```

Hoặc trong Eclipse/IntelliJ:
- Right-click project → Maven → Update Project
- Project → Clean → Build Project

### 4. Deploy to Tomcat

#### Cách 1: Eclipse/STS
1. Right-click project → Run As → Run on Server
2. Chọn Tomcat 10.1
3. Click Finish

#### Cách 2: Manual
```bash
# Copy WAR file to Tomcat webapps
cp target/Project_CK_UTESHOP-1.1.war /path/to/tomcat/webapps/

# Start Tomcat
cd /path/to/tomcat/bin
./startup.sh   # Linux/Mac
startup.bat    # Windows
```

### 5. Truy cập ứng dụng

Mở browser và truy cập:

```
http://localhost:8080/Project_CK_UTESHOP/
```

### 6. Tài khoản mặc định

Nếu đã import data mẫu:

| Vai trò | Username | Password | Mô tả |
|---------|----------|----------|-------|
| Admin | `admin` | `admin123` | Quản trị hệ thống |
| Vendor | `vendor1` | `vendor123` | Người bán hàng |
| User | `user1` | `user123` | Khách hàng |
| Shipper | `shipper1` | `ship123` | Nhân viên giao hàng |

---

## 📁 Cấu trúc thư mục

```
Project_CK_UTEShop_Nhom_17/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/uteshop/
│   │   │       ├── config/           # Cấu hình
│   │   │       │   └── DBConnect.java
│   │   │       ├── controller/       # Controllers (Servlets)
│   │   │       │   ├── admin/        # Admin controllers
│   │   │       │   ├── auth/         # Authentication
│   │   │       │   ├── guest/        # Public controllers
│   │   │       │   ├── user/         # User controllers
│   │   │       │   ├── vendor/       # Vendor controllers
│   │   │       │   └── shipper/      # Shipper controllers
│   │   │       ├── dao/              # Data Access Objects
│   │   │       │   ├── SanPhamDAO.java
│   │   │       │   ├── NguoiDungDAO.java
│   │   │       │   ├── DonHangDAO.java
│   │   │       │   └── ...
│   │   │       ├── dto/              # Data Transfer Objects
│   │   │       ├── entity/           # JPA Entities
│   │   │       │   ├── NguoiDung.java
│   │   │       │   ├── SanPham.java
│   │   │       │   ├── DonHang.java
│   │   │       │   └── ...
│   │   │       ├── filter/           # Servlet Filters
│   │   │       │   ├── AuthFilter.java
│   │   │       │   └── CharacterEncodingFilter.java
│   │   │       ├── service/          # Business Logic
│   │   │       │   ├── EmailService.java
│   │   │       │   └── OTPService.java
│   │   │       ├── util/             # Utilities
│   │   │       │   ├── JPAUtil.java
│   │   │       │   ├── JwtUtil.java
│   │   │       │   └── PasswordUtil.java
│   │   │       ├── utils/            # Additional utilities
│   │   │       └── websocket/        # WebSocket endpoints
│   │   │           └── ChatWebSocket.java
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml   # JPA configuration
│   │   └── webapp/
│   │       ├── assets/               # Static resources
│   │       │   ├── css/              # Stylesheets
│   │       │   ├── js/               # JavaScript files
│   │       │   ├── img/              # Images
│   │       │   └── uploads/          # User uploads
│   │       ├── WEB-INF/
│   │       │   ├── layouts/          # SiteMesh layouts
│   │       │   │   ├── guest-layout.jsp
│   │       │   │   ├── user-layout.jsp
│   │       │   │   ├── admin-layout.jsp
│   │       │   │   └── vendor-layout.jsp
│   │       │   ├── views/            # JSP views
│   │       │   │   ├── admin/        # Admin views
│   │       │   │   ├── auth/         # Login, register, forgot password
│   │       │   │   ├── chat/         # Chat interface
│   │       │   │   ├── common/       # Shared components (header, footer)
│   │       │   │   ├── guest/        # Public views
│   │       │   │   ├── user/         # User views
│   │       │   │   ├── vendor/       # Vendor views
│   │       │   │   └── shipper/      # Shipper views
│   │       │   ├── tlds/             # Tag library descriptors
│   │       │   ├── sitemesh3.xml     # SiteMesh config
│   │       │   └── web.xml           # Web app config
│   │       └── index.jsp             # Landing page
│   └── test/                         # Unit tests
├── target/                           # Compiled files (ignored)
├── .git/                             # Git repository
├── .gitignore                        # Git ignore rules
├── pom.xml                           # Maven config
├── dlTong.sql                        # Database schema
├── dlmau.sql                         # Sample data
├── create_khieunai_cuahang.sql      # Shop complaint table
├── README.md                         # This file
├── CONG_NGHE_SU_DUNG.md             # Technology documentation
├── HUONG_DAN_KHIEU_NAI_CUAHANG.md   # Complaint feature guide
└── TOMTAT_HOAN_THANH.md             # Project summary
```

---

## ⚙️ Cấu hình

### Cấu hình Email Service

File: `src/main/java/com/uteshop/service/EmailService.java`

```java
private static final String EMAIL = "your-email@gmail.com";
private static final String PASSWORD = "your-app-password";
private static final String SMTP_HOST = "smtp.gmail.com";
private static final String SMTP_PORT = "587";
```

**Lưu ý**: Sử dụng App Password cho Gmail, không dùng mật khẩu thật.

### Cấu hình JWT

File: `src/main/java/com/uteshop/util/JwtUtil.java`

```java
private static final String SECRET_KEY = "your-secret-key-here-change-in-production";
private static final long EXPIRATION_TIME = 86400000; // 24 hours
```

### Cấu hình HikariCP

File: `persistence.xml`

```xml
<property name="hibernate.hikari.minimumIdle" value="5"/>
<property name="hibernate.hikari.maximumPoolSize" value="20"/>
<property name="hibernate.hikari.idleTimeout" value="30000"/>
<property name="hibernate.hikari.connectionTimeout" value="30000"/>
```

### Cấu hình SiteMesh

File: `WEB-INF/sitemesh3.xml`

```xml
<mapping path="/guest/*" decorator="/WEB-INF/layouts/guest-layout.jsp"/>
<mapping path="/user/*" decorator="/WEB-INF/layouts/user-layout.jsp"/>
<mapping path="/admin/*" decorator="/WEB-INF/layouts/admin-layout.jsp"/>
<mapping path="/vendor/*" decorator="/WEB-INF/layouts/vendor-layout.jsp"/>
```

---

## 📚 Tài liệu

### Tài liệu kỹ thuật

- [📖 CONG_NGHE_SU_DUNG.md](CONG_NGHE_SU_DUNG.md) - Chi tiết tất cả công nghệ sử dụng
- [🚩 HUONG_DAN_KHIEU_NAI_CUAHANG.md](HUONG_DAN_KHIEU_NAI_CUAHANG.md) - Hướng dẫn tính năng khiếu nại
- [📋 TOMTAT_HOAN_THANH.md](TOMTAT_HOAN_THANH.md) - Tóm tắt project

### Database Documentation

#### Tables

| Table | Mô tả | Số cột | Relationships |
|-------|-------|--------|---------------|
| `NguoiDung` | Thông tin người dùng | 15 | 1-N với nhiều tables |
| `CuaHang` | Thông tin cửa hàng | 10 | N-1 với NguoiDung |
| `SanPham` | Sản phẩm | 18 | N-1 với CuaHang, DanhMuc |
| `DonHang` | Đơn hàng | 15 | N-1 với NguoiDung |
| `ChiTietDonHang` | Chi tiết đơn hàng | 5 | N-1 với DonHang, SanPham |
| `GioHang` | Giỏ hàng | 4 | 1-1 với NguoiDung |
| `ChiTietGioHang` | Chi tiết giỏ hàng | 4 | N-1 với GioHang, SanPham |
| `DanhMuc` | Danh mục sản phẩm | 5 | 1-N với SanPham |
| `MaGiamGia` | Mã giảm giá | 10 | N-1 với CuaHang |
| `DanhGiaSanPham` | Review sản phẩm | 6 | N-1 với SanPham, NguoiDung |
| `KhieuNaiCuaHang` | Khiếu nại cửa hàng | 8 | N-1 với NguoiDung, CuaHang |
| `HoiThoai` | Cuộc hội thoại chat | 5 | Between User & Shop |
| `TinNhan` | Tin nhắn | 6 | N-1 với HoiThoai |
| `DonViVanChuyen` | Đơn vị vận chuyển | 8 | 1-N với PhanCongGiaoHang |
| `PhanCongGiaoHang` | Phân công shipper | 6 | N-1 với DonHang, Shipper |

### API Endpoints

#### Authentication APIs

```
POST   /auth/login              - Đăng nhập
POST   /auth/register           - Đăng ký
POST   /auth/logout             - Đăng xuất
POST   /auth/forgot-password    - Quên mật khẩu
POST   /auth/verify-otp         - Xác thực OTP
POST   /auth/reset-password     - Đặt lại mật khẩu
```

#### Product APIs

```
GET    /guest/products          - Danh sách sản phẩm
GET    /guest/product?id=       - Chi tiết sản phẩm
GET    /guest/category?id=      - Sản phẩm theo danh mục
GET    /guest/search?q=         - Tìm kiếm sản phẩm
```

#### Cart APIs

```
GET    /user/cart               - Xem giỏ hàng
POST   /user/cart/add           - Thêm vào giỏ
POST   /user/cart/update        - Cập nhật số lượng
POST   /user/cart/remove        - Xóa khỏi giỏ
```

#### Order APIs

```
GET    /user/checkout           - Trang thanh toán
POST   /user/checkout           - Đặt hàng
GET    /user/orders             - Danh sách đơn hàng
GET    /user/order-detail?id=   - Chi tiết đơn hàng
POST   /user/order/cancel       - Hủy đơn hàng
```

#### Admin APIs

```
GET    /admin/dashboard         - Dashboard
GET    /admin/users             - Quản lý users
GET    /admin/shops             - Quản lý shops
GET    /admin/products          - Quản lý products
GET    /admin/orders            - Quản lý orders
GET    /admin/shop-complaints   - Quản lý khiếu nại
```

#### WebSocket Endpoints

```
ws://localhost:8080/Project_CK_UTESHOP/chat/{conversationId}
```

---

## 🖼️ Screenshots

### Homepage
![Homepage](docs/screenshots/home.png)

### Product Detail
![Product Detail](docs/screenshots/product-detail.png)

### Shopping Cart
![Cart](docs/screenshots/cart.png)

### Checkout
![Checkout](docs/screenshots/checkout.png)

### User Dashboard
![User Dashboard](docs/screenshots/user-dashboard.png)

### Admin Panel
![Admin Panel](docs/screenshots/admin-panel.png)

### Vendor Dashboard
![Vendor Dashboard](docs/screenshots/vendor-dashboard.png)

### Real-time Chat
![Chat](docs/screenshots/chat.png)

---

## 🧪 Testing

### Chạy Unit Tests

```bash
mvn test
```

### Test Coverage

```bash
mvn clean test jacoco:report
```

Report sẽ được tạo tại: `target/site/jacoco/index.html`

### Manual Testing

#### Test Authentication
1. Truy cập `/auth/register` để đăng ký tài khoản mới
2. Kiểm tra email nhận OTP
3. Xác thực OTP và login
4. Kiểm tra JWT token trong cookie

#### Test Shopping Flow
1. Duyệt sản phẩm tại homepage
2. Thêm sản phẩm vào giỏ hàng
3. Cập nhật số lượng trong giỏ
4. Checkout và đặt hàng
5. Kiểm tra đơn hàng trong `/user/orders`

#### Test Chat
1. Login với user account
2. Vào trang chi tiết sản phẩm
3. Click nút chat với vendor
4. Gửi tin nhắn và kiểm tra real-time update

---

## 🚢 Deployment

### Production Build

```bash
# Build production WAR
mvn clean package -Pprod

# WAR file sẽ được tạo tại
target/Project_CK_UTESHOP-1.1.war
```

### Deploy lên Server

#### Option 1: Tomcat Manager

1. Truy cập Tomcat Manager: `http://server:8080/manager`
2. Upload WAR file
3. Deploy và start application

#### Option 2: Manual Copy

```bash
# Copy WAR to server
scp target/Project_CK_UTESHOP-1.1.war user@server:/opt/tomcat/webapps/

# Restart Tomcat
ssh user@server
sudo systemctl restart tomcat
```

### Environment Variables (Production)

```bash
# Database
export DB_URL="jdbc:sqlserver://production-db:1433;databaseName=UTESHOP"
export DB_USER="sa"
export DB_PASSWORD="strong-password"

# JWT
export JWT_SECRET="production-secret-key-very-long-and-secure"

# Email
export EMAIL_USER="noreply@uteshop.com"
export EMAIL_PASSWORD="app-password"
```

### Nginx Reverse Proxy (Optional)

```nginx
server {
    listen 80;
    server_name uteshop.com;

    location / {
        proxy_pass http://localhost:8080/Project_CK_UTESHOP/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /chat {
        proxy_pass http://localhost:8080/Project_CK_UTESHOP/chat;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

---

## 🤝 Contributing

Chúng tôi hoan nghênh mọi đóng góp! Để contribute:

### 1. Fork the Project

```bash
git clone https://github.com/YOUR_USERNAME/Project_CK_UTEShop_Nhom_17.git
```

### 2. Create Feature Branch

```bash
git checkout -b feature/AmazingFeature
```

### 3. Commit Changes

```bash
git commit -m "Add some AmazingFeature"
```

### 4. Push to Branch

```bash
git push origin feature/AmazingFeature
```

### 5. Open Pull Request

Tạo Pull Request trên GitHub với mô tả chi tiết về changes.

### Coding Standards

- **Java**: Follow Google Java Style Guide
- **JSP**: Indent với 4 spaces
- **JavaScript**: ESLint configuration
- **SQL**: Uppercase keywords, lowercase identifiers
- **Comments**: Tiếng Việt hoặc English đều được

### Commit Message Convention

```
feat: Thêm tính năng mới
fix: Sửa bug
docs: Cập nhật documentation
style: Format code
refactor: Refactor code
test: Thêm tests
chore: Update dependencies
```

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

```
MIT License

Copyright (c) 2024 UTESHOP - Nhóm 17

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 👥 Nhóm phát triển

### Team Members

| Thành viên | MSSV | Email | GitHub |
|------------|------|-------|--------|
| **Bùi Nhật Dương** | 21110198 |  21110198@student.hcmute.edu.vn | [@BuiNhatDuong](https://github.com/nduong2810) |
| **Hoàng Văn Đông** | 21110093 | 21110093@student.hcmute.edu.vn | [@HoangVanDong](https://github.com/HoangDongDong) |
| **Phạm Ngọc Mạnh** | 21110262 |  21110262@student.hcmute.edu.vn | [@PhamNgocManh](https://github.com/ngocmanhp667) |
| **Trương Tấn Sang** | 21110300 | 21110300@student.hcmute.edu.vn | [@TruongTanSang](https://github.com/sangdeptrailoitaiai) |

### Giảng viên hướng dẫn

- **ThS. Nguyễn Hữu Trung** - Khoa Công nghệ Thông tin, UTE

### Contributors

<a href="https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=nduong2810/Project_CK_UTEShop_Nhom_17" />
</a>

---

## 📞 Liên hệ & Hỗ trợ

### Project Links

- **Repository**: [https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17](https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17)
- **Issues**: [https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17/issues](https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17/issues)
- **Wiki**: [https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17/wiki](https://github.com/nduong2810/Project_CK_UTEShop_Nhom_17/wiki)

### Support

Nếu bạn gặp vấn đề hoặc có câu hỏi:

1. **Check Documentation**: Đọc các file `.md` trong project
2. **Search Issues**: Xem có ai gặp vấn đề tương tự không
3. **Create Issue**: Tạo issue mới với mô tả chi tiết
4. **Email**: uteshop.team17@gmail.com



---

## 🎓 Acknowledgments

### Technologies & Libraries

- [Jakarta EE](https://jakarta.ee/) - Enterprise platform
- [Hibernate ORM](https://hibernate.org/) - ORM framework
- [Spring Framework](https://spring.io/) - Application framework
- [Bootstrap](https://getbootstrap.com/) - UI framework
- [Apache Tomcat](https://tomcat.apache.org/) - Servlet container

### Inspiration & Resources

- [Shopee](https://shopee.vn/) - E-commerce inspiration
- [Lazada](https://lazada.vn/) - Multi-vendor marketplace reference
- [Baeldung](https://www.baeldung.com/) - Java tutorials
- [Stack Overflow](https://stackoverflow.com/) - Problem solving community

### Special Thanks

- **Khoa CNTT - UTE** - Cung cấp môi trường học tập
- **Thầy cô giảng viên** - Hướng dẫn và hỗ trợ
- **Bạn bè lớp** - Review và feedback
- **Open Source Community** - Các thư viện và tools miễn phí

---

## 📈 Project Status

### Current Version: 1.1.0

- ✅ **Phase 1**: Core features (Completed)
- ✅ **Phase 2**: User management (Completed)
- ✅ **Phase 3**: Shop & Product management (Completed)
- ✅ **Phase 4**: Order & Payment (Completed)
- ✅ **Phase 5**: Chat & Communication (Completed)
- ✅ **Phase 6**: Admin Panel (Completed)
- 🚧 **Phase 7**: Mobile app (Planning)
- 📅 **Phase 8**: Performance optimization (Planned)

### Roadmap

#### Version 1.2 (Q1 2025)
- [ ] RESTful API for mobile app
- [ ] Push notifications
- [ ] Advanced analytics dashboard
- [ ] Multi-language support (English)

#### Version 2.0 (Q2 2025)
- [ ] Microservices architecture
- [ ] Docker containerization
- [ ] CI/CD pipeline
- [ ] Cloud deployment (AWS/Azure)

#### Version 3.0 (Q3 2025)
- [ ] AI-powered product recommendations
- [ ] Chatbot customer support
- [ ] Advanced fraud detection
- [ ] Blockchain for payment

---




## 📊 Statistics

```
Total Lines of Code: ~25,000
├── Java: 15,000
├── JSP: 6,000
├── JavaScript: 2,000
├── SQL: 1,500
└── CSS: 500

Total Files: 180+
├── Java Classes: 80+
├── JSP Views: 60+
├── JavaScript Files: 15+
└── SQL Scripts: 5+

Development Time: 4 months
Team Size: 4 members
Commits: 500+
Issues Resolved: 150+
```

---

## 🎉 Thank You!

Cảm ơn bạn đã quan tâm đến project **UTESHOP**! Nếu project này hữu ích, đừng quên:

- ⭐ **Star** repository trên GitHub
- 🍴 **Fork** để phát triển thêm
- 🐛 **Report bugs** qua Issues
- 💡 **Contribute** new features
- 📢 **Share** với bạn bè

---

<div align="center">

**Made with ❤️ by UTESHOP Team - Nhóm 17**

[![GitHub](https://img.shields.io/badge/GitHub-nduong2810-black?style=flat&logo=github)](https://github.com/nduong2810)
[![Email](https://img.shields.io/badge/Email-uteshop.team17%40gmail.com-red?style=flat&logo=gmail)](mailto:uteshop.team17@gmail.com)

**© 2025 UTESHOP. All rights reserved.**

[⬆ Back to top](#-uteshop---hệ-thống-thương-mại-điện-tử)

</div>
