<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    /* Header Styles */
    #mainNavbar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 1030;
        transition: all 0.3s ease;
    }
    
    .navbar-brand {
        font-weight: bold;
        font-size: 1.5rem;
        color: white !important;
        text-decoration: none !important;
    }
    
    .navbar-brand:hover {
        transform: scale(1.05);
        transition: transform 0.3s ease;
    }
    
    /* Navigation Menu */
    .navbar-nav .nav-link {
        color: rgba(255,255,255,0.9) !important;
        font-weight: 500;
        padding: 0.8rem 1rem !important;
        border-radius: 8px;
        margin: 0 0.2rem;
        transition: all 0.3s ease;
        position: relative;
    }
    
    .navbar-nav .nav-link:hover {
        color: white !important;
        background: rgba(255,255,255,0.15);
        transform: translateY(-2px);
    }
    
    .navbar-nav .nav-link.active {
        color: white !important;
        background: rgba(255,255,255,0.2);
        font-weight: 600;
    }
    
    /* Dropdown Menu */
    .dropdown-menu {
        background: white;
        border: none;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        padding: 0.5rem 0;
        margin-top: 0.5rem;
    }
    
    .dropdown-item {
        padding: 0.7rem 1.5rem;
        font-weight: 500;
        color: #333;
        transition: all 0.3s ease;
    }
    
    .dropdown-item:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        transform: translateX(5px);
    }
    
    /* Search Bar */
    .search-container {
        flex: 1;
        max-width: 600px;
        margin: 0 2rem;
    }
    
    .search-group {
        position: relative;
        display: flex;
        border-radius: 50px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    
    .search-input {
        flex: 1;
        padding: 12px 20px;
        border: none;
        background: white;
        color: #333;
        font-size: 1rem;
        outline: none;
    }
    
    .search-input::placeholder {
        color: #999;
    }
    
    .search-btn {
        background: linear-gradient(135deg, #ff6b6b 0%, #ffa726 100%);
        border: none;
        color: white;
        padding: 12px 25px;
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .search-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 15px rgba(255,107,107,0.3);
    }
    
    /* User Menu & Buttons */
    .btn-outline {
        border: 2px solid rgba(255,255,255,0.3);
        color: white;
        background: transparent;
        border-radius: 50px;
        padding: 0.5rem 1rem;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    
    .btn-outline:hover {
        border-color: white;
        background: white;
        color: #667eea;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(255,255,255,0.2);
    }
    
    .btn-warning {
        background: linear-gradient(135deg, #ffa726 0%, #ff6b6b 100%);
        border: none;
        color: white;
        border-radius: 50px;
        padding: 0.5rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-warning:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255,167,38,0.4);
        color: white;
    }
    
    /* Cart Icon */
    .cart-icon {
        position: relative;
    }
    
    .cart-count {
        font-size: 0.7rem;
        min-width: 18px;
        height: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    /* User Avatar */
    .user-avatar {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background: rgba(255,255,255,0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
    }
    
    /* Mobile Responsive */
    @media (max-width: 991px) {
        .search-container {
            margin: 0.5rem 0;
            max-width: 100%;
        }
        
        .navbar-nav {
            background: rgba(255,255,255,0.1);
            border-radius: 12px;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .navbar-nav .nav-link {
            margin: 0.2rem 0;
        }
    }
    
    /* Animation for navbar scroll */
    .navbar-scrolled {
        background: rgba(102, 126, 234, 0.95) !important;
        backdrop-filter: blur(10px);
    }
</style>

<nav class="navbar navbar-expand-lg" id="mainNavbar">
    <div class="container-fluid py-2 px-3">
        <!-- Logo và Brand -->
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/guest/home">
            <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" 
                 width="45" height="45" class="me-2" alt="Logo HCMUTE"
                 onerror="this.style.display='none';">
            <span>UTESHOP</span>
        </a>

        <!-- Toggle button for mobile -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span style="color: white;"><i class="fas fa-bars"></i></span>
        </button>

        <!-- Main Navigation -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <!-- Trang chủ -->
                <li class="nav-item">
                    <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/home') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/guest/home">
                        <i class="fas fa-home me-1"></i>Trang chủ
                    </a>
                </li>
                
                <!-- Sản phẩm với dropdown danh mục -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${fn:contains(pageContext.request.requestURI, '/product') ? 'active' : ''}" 
                       href="#" id="productsDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-box me-1"></i>Sản phẩm
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/home?showAll=true">
                                <i class="fas fa-list me-2"></i>Tất cả sản phẩm
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <c:if test="${not empty applicationScope.categories}">
                            <c:forEach var="cat" items="${applicationScope.categories}">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/category?id=${cat.maDM}">
                                        <i class="fas fa-tag me-2"></i>${cat.tenDM}
                                    </a>
                                </li>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty applicationScope.categories}">
                            <li><span class="dropdown-item-text text-muted">Chưa có danh mục</span></li>
                        </c:if>
                    </ul>
                </li>
                
                <!-- Nhà cung cấp -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${fn:contains(pageContext.request.requestURI, '/supplier') ? 'active' : ''}" 
                       href="#" id="suppliersDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-industry me-1"></i>Nhà cung cấp
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/suppliers">
                                <i class="fas fa-building me-2"></i>Danh sách nhà cung cấp
                            </a>
                        </li>
                    </ul>
                </li>
                
                <!-- Đơn vị vận chuyển -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${fn:contains(pageContext.request.requestURI, '/shipping') ? 'active' : ''}" 
                       href="#" id="shippingDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-truck me-1"></i>Vận chuyển
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/shipping/policy">
                                <i class="fas fa-file-alt me-2"></i>Chính sách vận chuyển
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/shipping/track">
                                <i class="fas fa-search-location me-2"></i>Tra cứu đơn hàng
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/shipping/partners">
                                <i class="fas fa-handshake me-2"></i>Đối tác vận chuyển
                            </a>
                        </li>
                    </ul>
                </li>
                
                <!-- Hỗ trợ -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="supportDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-question-circle me-1"></i>Hỗ trợ
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/contact">
                                <i class="fas fa-envelope me-2"></i>Liên hệ
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/faq">
                                <i class="fas fa-question me-2"></i>Câu hỏi thường gặp
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/guide">
                                <i class="fas fa-book me-2"></i>Hướng dẫn mua hàng
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>

            <!-- Search Bar -->
            <div class="search-container mx-3">
                <form method="GET" action="${pageContext.request.contextPath}/guest/search" class="d-flex">
                    <div class="search-group w-100">
                        <input type="search" name="keyword" class="search-input" 
                               placeholder="Tìm kiếm sản phẩm, nhà cung cấp..." 
                               value="${param.keyword}"
                               autocomplete="off">
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>

            <!-- User Menu & Actions -->
            <div class="d-flex align-items-center gap-2">
                <!-- Cart -->
                <a href="${pageContext.request.contextPath}/user/cart" class="btn btn-outline position-relative cart-icon" 
                   title="Xem giỏ hàng">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-count position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="cartCount">
                        0
                    </span>
                </a>
                
                <!-- Check if user is logged in -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <!-- User is logged in - Show user menu -->
                        <div class="dropdown">
                            <button class="btn btn-outline dropdown-toggle d-flex align-items-center" type="button" 
                                    id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <div class="user-avatar me-2">
                                    <i class="fas fa-user"></i>
                                </div>
                                <span class="d-none d-md-inline">${sessionScope.user.hoTen}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <!-- Role-based menu items -->
                                <li>
                                    <h6 class="dropdown-header">
                                        <i class="fas fa-user-circle me-2"></i>
                                        ${sessionScope.user.hoTen}
                                        <small class="d-block text-muted">${sessionScope.userRole}</small>
                                    </h6>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                
                                <!-- Common user features -->
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                        <i class="fas fa-user-edit me-2"></i>Hồ sơ cá nhân
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/orders">
                                        <i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/wishlist">
                                        <i class="fas fa-heart me-2"></i>Sản phẩm yêu thích
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/addresses">
                                        <i class="fas fa-map-marker-alt me-2"></i>Địa chỉ giao hàng
                                    </a>
                                </li>
                                
                                <!-- Vendor-specific features -->
                                <c:if test="${sessionScope.userRole == 'VENDOR'}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <h6 class="dropdown-header">
                                            <i class="fas fa-store me-2"></i>Quản lý Shop
                                        </h6>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/vendor/dashboard">
                                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                        </a>
                                </c:if>
                                
                                <!-- Admin-specific features -->
                                <c:if test="${sessionScope.userRole == 'ADMIN'}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <h6 class="dropdown-header">
                                            <i class="fas fa-crown me-2"></i>Quản trị
                                        </h6>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                            <i class="fas fa-chart-line me-2"></i>Dashboard Admin
                                        </a>
                                    </li>
                     
                                </c:if>
                                
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/settings">
                                        <i class="fas fa-cog me-2"></i>Cài đặt
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- User is not logged in - Show login/register buttons -->
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline">
                            <i class="fas fa-sign-in-alt me-1"></i>
                            <span class="d-none d-md-inline">Đăng nhập</span>
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-warning">
                            <i class="fas fa-user-plus me-1"></i>
                            <span class="d-none d-md-inline">Đăng ký</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<script>
// Navbar scroll effect
window.addEventListener('scroll', function() {
    const navbar = document.getElementById('mainNavbar');
    if (window.scrollY > 50) {
        navbar.classList.add('navbar-scrolled');
    } else {
        navbar.classList.remove('navbar-scrolled');
    }
});

// Search functionality enhancement
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.querySelector('.search-input');
    
    if (searchInput) {
        // Add search suggestions (you can implement this later)
        searchInput.addEventListener('input', function() {
            const query = this.value.trim();
            if (query.length > 2) {
                // TODO: Implement search suggestions
                console.log('Search query:', query);
            }
        });
    }
    
    // Set default cart count for guest
    const cartCountElement = document.getElementById('cartCount');
    if (cartCountElement) {
        cartCountElement.textContent = '0';
        cartCountElement.style.display = 'none';
    }
});

// Auto-hide dropdown on mobile after selection
document.querySelectorAll('.dropdown-item').forEach(item => {
    item.addEventListener('click', function() {
        const navbar = document.querySelector('.navbar-collapse');
        if (navbar.classList.contains('show')) {
            const toggle = document.querySelector('.navbar-toggler');
            if (toggle) toggle.click();
        }
    });
});
</script>