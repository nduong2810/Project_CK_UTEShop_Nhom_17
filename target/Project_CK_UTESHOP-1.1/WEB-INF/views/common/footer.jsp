<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
/* Modern E-commerce Footer */
.footer-section {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #232f3e;
    color: #ffffff;
    line-height: 1.6;
}

.footer-section h5 {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 20px;
    color: #ffffff;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.footer-brand h3 {
    font-size: 1.8rem;
    font-weight: 700;
    color: #2874f0;
}

.footer-brand p {
    font-size: 14px;
    line-height: 1.7;
    color: #ddd;
}

.footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-links li {
    margin-bottom: 10px;
}

.footer-links a {
    color: #ddd;
    text-decoration: none;
    font-size: 14px;
    transition: all 0.3s ease;
    display: inline-block;
}

.footer-links a:hover {
    color: #2874f0;
    padding-left: 5px;
}

.contact-info .contact-item {
    display: flex;
    align-items: flex-start;
    margin-bottom: 15px;
}

.contact-info .contact-item i {
    margin-top: 2px;
    width: 20px;
    font-size: 16px;
    color: #2874f0;
}

.contact-info .contact-item span {
    font-size: 14px;
    line-height: 1.6;
    color: #ddd;
}

.social-links {
    margin-top: 20px;
}

.social-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: #37475a;
    color: white;
    border-radius: 4px;
    text-decoration: none;
    transition: all 0.3s ease;
    margin-right: 10px;
}

.social-link:hover {
    background: #2874f0;
    color: white;
    transform: translateY(-3px);
}

.social-link i {
    font-size: 16px;
}

.payment-methods {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.payment-method {
    transition: all 0.3s ease;
    padding: 8px;
}

.payment-method:hover {
    transform: scale(1.1);
}

.footer-bottom {
    background: #131a22;
    padding: 20px 0;
    font-size: 14px;
}

.back-to-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    background: #2874f0;
    color: white;
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 1000;
    box-shadow: 0 2px 10px rgba(0,0,0,0.3);
}

.back-to-top.show {
    opacity: 1;
    visibility: visible;
}

.back-to-top:hover {
    background: #1557bf;
    transform: translateY(-3px);
    color: white;
}

@media (max-width: 768px) {
    .footer-section h5 {
        font-size: 15px;
        margin-bottom: 15px;
    }
    
    .social-links {
        text-align: center;
    }
    
    .footer-bottom {
        text-align: center !important;
    }
    
    .footer-bottom .col-md-6 {
        text-align: center !important;
        margin-bottom: 10px;
    }
}
</style>

<footer class="footer-section mt-5">
    <div class="container py-5">
        <div class="row">
            <!-- Company Info -->
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="footer-brand mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-shopping-bag fa-2x text-primary me-3"></i>
                        <h3 class="mb-0">UTESHOP</h3>
                    </div>
                    <p class="mb-4">Nền tảng thương mại điện tử hàng đầu dành cho sinh viên, mang đến trải nghiệm mua sắm tuyệt vời với sản phẩm chất lượng và giá cả hợp lý.</p>
                    
                    <!-- Social Media -->
                    <div class="social-links">
                        <a href="#" class="social-link" title="Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-link" title="Instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="social-link" title="YouTube">
                            <i class="fab fa-youtube"></i>
                        </a>
                        <a href="#" class="social-link" title="TikTok">
                            <i class="fab fa-tiktok"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-lg-2 col-md-6 mb-4">
                <h5>Liên kết nhanh</h5>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/categories">Danh mục</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/about">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/contact">Liên hệ</a></li>
                </ul>
            </div>

            <!-- Customer Support -->
            <div class="col-lg-3 col-md-6 mb-4">
                <h5>Hỗ trợ khách hàng</h5>
                <ul class="footer-links">
                    <li><a href="#">Hướng dẫn mua hàng</a></li>
                    <li><a href="#">Chính sách đổi trả</a></li>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Điều khoản sử dụng</a></li>
                    <li><a href="#">Câu hỏi thường gặp</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="col-lg-3 col-md-6 mb-4">
                <h5>Thông tin liên hệ</h5>
                <div class="contact-info">
                    <div class="contact-item mb-3">
                        <i class="fas fa-map-marker-alt me-3"></i>
                        <span>Đại học Sư phạm Kỹ thuật TP.HCM<br>1 Võ Văn Ngân, Q.Thủ Đức, TP.HCM</span>
                    </div>
                    <div class="contact-item mb-3">
                        <i class="fas fa-phone me-3"></i>
                        <span>Hotline: 1900-0000</span>
                    </div>
                    <div class="contact-item mb-3">
                        <i class="fas fa-envelope me-3"></i>
                        <span>Email: nhom17@uteshop.edu.vn</span>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-clock me-3"></i>
                        <span>24/7 - Hỗ trợ mọi lúc</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Methods -->
        <div class="row mt-4 pt-4" style="border-top: 1px solid #37475a;">
            <div class="col-12 text-center">
                <h6 class="mb-3" style="color: #ddd;">Phương thức thanh toán</h6>
                <div class="payment-methods">
                    <span class="payment-method" title="Visa">
                        <i class="fab fa-cc-visa fa-2x" style="color: #ddd;"></i>
                    </span>
                    <span class="payment-method" title="Mastercard">
                        <i class="fab fa-cc-mastercard fa-2x" style="color: #ddd;"></i>
                    </span>
                    <span class="payment-method" title="PayPal">
                        <i class="fab fa-cc-paypal fa-2x" style="color: #ddd;"></i>
                    </span>
                    <span class="payment-method" title="Mobile Banking">
                        <i class="fas fa-mobile-alt fa-2x" style="color: #ddd;"></i>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Copyright -->
    <div class="footer-bottom">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0" style="color: #ddd;">
                        © 2025 <strong style="color: #2874f0;">UTESHOP</strong> | Bản quyền thuộc về Nhóm 17 
                    </p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="mb-0" style="color: #ddd;">
                        Thiết kế bởi <span style="color: #2874f0;">Nhóm 17</span> với <i class="fas fa-heart text-danger"></i>
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Back to top button -->
<a href="#" class="back-to-top" id="backToTop" title="Về đầu trang">
    <i class="fas fa-chevron-up"></i>
</a>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const backToTop = document.getElementById('backToTop');
    
    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            backToTop.classList.add('show');
        } else {
            backToTop.classList.remove('show');
        }
    });
    
    backToTop.addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
});
</script>