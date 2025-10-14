<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg" id="mainNavbar">
    <div class="container-fluid py-2 px-3">
        <div class="d-flex align-items-center">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/guest/home">
                <img src="${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png" 
                     width="45" height="45" class="me-2" alt="Logo HCMUTE">
                <span>UTESHOP</span>
            </a>

            <!-- Category Dropdown -->
            <div class="nav-item dropdown ms-lg-3">
                <a class="nav-link dropdown-toggle text-white" href="#" id="categoryDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-bars me-1"></i>
                    <span class="d-none d-lg-inline">Danh mục</span>
                </a>
                <ul class="dropdown-menu" aria-labelledby="categoryDropdown">
                    <c:if test="${not empty applicationScope.categories}">
                        <c:forEach var="cat" items="${applicationScope.categories}">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/guest/category?id=${cat.maDM}">${cat.tenDM}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty applicationScope.categories}">
                        <li><span class="dropdown-item-text">Không có danh mục nào</span></li>
                    </c:if>
                </ul>
            </div>
        </div>

        <div class="search-container">
            <form method="GET" action="${pageContext.request.contextPath}/guest/search">
                <div class="search-group">
                    <input type="search" name="keyword" class="search-input" 
                           placeholder="Tìm kiếm sản phẩm..." autocomplete="off">
                    <button type="submit" class="search-btn">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </form>
        </div>

        <div class="d-flex align-items-center gap-3">
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    <!-- User Menu -->
                    <div class="dropdown">
                        <button class="btn btn-outline d-flex align-items-center" data-bs-toggle="dropdown">
                            <div class="user-avatar me-2">
                                <i class="fa fa-user-circle fa-lg"></i>
                            </div>
                            <span class="d-none d-md-inline">${sessionScope.user.hoTen}</span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Tài khoản của tôi</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/orders">Đơn mua</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a></li>
                        </ul>
                    </div>

                    <!-- Cart -->
                    <a href="${pageContext.request.contextPath}/user/cart" class="btn btn-outline position-relative cart-icon">
                        <i class="fa fa-shopping-cart"></i>
                        <span class="cart-count position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-light">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-warning">Đăng ký</a>
                </c:otherwise>
            </c:choose>

            <!-- Mobile menu toggle -->
            <button class="btn btn-outline d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#mobileMenu">
                <i class="fa fa-bars"></i>
            </button>
        </div>
    </div>
</nav>

<!-- Mobile Menu Offcanvas -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="mobileMenu">
    <!-- ... existing mobile menu code ... -->
</div>

<style>
.navbar {
    background: var(--gradient-primary, #002b5b);
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1030;
}
.navbar-brand, .nav-link {
    color: white !important;
}
.search-container {
    flex-grow: 1;
    max-width: 500px;
    margin: 0 1rem;
}
.search-group {
    position: relative;
}
.search-input {
    border: none;
    padding: 10px 20px;
    width: 100%;
    border-radius: 25px;
    background: #f0f2f5;
}
.search-btn {
    position: absolute;
    right: 0;
    top: 0;
    height: 100%;
    border: none;
    padding: 0 20px;
    background: transparent;
    color: #555;
}
.user-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: #eee;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #333;
}
.dropdown-menu {
    border-radius: 0.75rem;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    border: 1px solid #eee;
}
@media (max-width: 991px) {
    .search-container {
        order: 3;
        width: 100%;
        margin: 10px 0 0 0;
    }
    .navbar-nav {
        order: 2;
    }
    .d-flex.align-items-center.gap-3 {
        order: 1;
    }
    .navbar-brand {
        order: 0;
    }
}
</style>
