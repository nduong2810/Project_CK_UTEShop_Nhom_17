<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
/* Footer Font Styles */
.footer-section {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
}

.footer-section h3,
.footer-section h5,
.footer-section h6 {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-weight: 600;
    letter-spacing: 0.5px;
}

.footer-section p,
.footer-section span,
.footer-section a {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 14px;
    line-height: 1.6;
}

/* Footer Brand */
.footer-brand h3 {
    font-size: 2rem;
    font-weight: 700;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.footer-brand p {
    font-size: 15px;
    line-height: 1.7;
}

/* Footer Links */
.footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-links li {
    margin-bottom: 12px;
}

.footer-links a {
    color: rgba(255,255,255,0.7);
    text-decoration: none;
    font-size: 14px;
    font-weight: 400;
    transition: all 0.3s ease;
    display: inline-block;
    position: relative;
}

.footer-links a:hover {
    color: #ffc107;
    transform: translateX(5px);
}

.footer-links a::before {
    content: '›';
    margin-right: 8px;
    font-weight: bold;
    color: #ffc107;
    transition: transform 0.3s ease;
}

.footer-links a:hover::before {
    transform: translateX(3px);
}

/* Section Headers */
.footer-section h5 {
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 20px;
    position: relative;
    padding-bottom: 10px;
}

.footer-section h5::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 40px;
    height: 3px;
    background: linear-gradient(135deg, #ffc107 0%, #ff6b6b 100%);
    border-radius: 2px;
}

/* Contact Info */
.contact-info .contact-item {
    display: flex;
    align-items: flex-start;
    margin-bottom: 15px;
}

.contact-info .contact-item i {
    margin-top: 2px;
    width: 20px;
    font-size: 16px;
}

.contact-info .contact-item span {
    font-size: 14px;
    line-height: 1.6;
    color: rgba(255,255,255,0.8);
}

/* Social Links */
.social-links {
    margin-top: 20px;
}

.social-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 45px;
    height: 45px;
    background: rgba(255,255,255,0.1);
    color: white;
    border-radius: 50%;
    text-decoration: none;
    transition: all 0.3s ease;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255,255,255,0.2);
}

.social-link:hover {
    background: #ffc107;
    color: #333;
    transform: translateY(-3px);
    box-shadow: 0 10px 20px rgba(255,193,7,0.3);
}

.social-link i {
    font-size: 18px;
}

/* Newsletter */
.newsletter-form {
    gap: 10px;
}

.newsletter-input {
    background: rgba(255,255,255,0.1);
    border: 1px solid rgba(255,255,255,0.3);
    color: white;
    font-size: 14px;
    padding: 12px 16px;
    border-radius: 25px;
    backdrop-filter: blur(10px);
}

.newsletter-input::placeholder {
    color: rgba(255,255,255,0.6);
    font-size: 14px;
}

.newsletter-input:focus {
    background: rgba(255,255,255,0.15);
    border-color: #ffc107;
    box-shadow: 0 0 0 0.2rem rgba(255,193,7,0.25);
    color: white;
}

.newsletter-btn {
    background: #ffc107;
    border: none;
    color: #333;
    padding: 12px 20px;
    border-radius: 25px;
    font-weight: 600;
    transition: all 0.3s ease;
    min-width: 60px;
}

.newsletter-btn:hover {
    background: #ffca2c;
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(255,193,7,0.4);
}

/* Payment Methods */
.payment-methods {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
}

.payment-method {
    transition: all 0.3s ease;
    padding: 10px;
    border-radius: 8px;
    background: rgba(255,255,255,0.05);
}

.payment-method:hover {
    transform: scale(1.1);
    background: rgba(255,255,255,0.1);
}

/* Footer Bottom */
.footer-bottom {
    font-size: 13px;
}

.footer-bottom p {
    font-size: 13px;
    margin: 0;
}

.footer-bottom .text-warning {
    font-weight: 600;
}

/* Decorative Elements */
.footer-wave {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 120px;
    z-index: 1;
}

.footer-wave svg {
    width: 100%;
    height: 100%;
}

.container {
    position: relative;
    z-index: 2;
}

/* Animations */
.fade-in-up {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeInUp 0.8s ease forwards;
}

.fade-in-left {
    opacity: 0;
    transform: translateX(-30px);
    animation: fadeInLeft 0.8s ease forwards;
}

@keyframes fadeInUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeInLeft {
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.hover-scale {
    transition: transform 0.3s ease;
}

.hover-scale:hover {
    transform: scale(1.1);
}

.floating {
    animation: floating 3s ease-in-out infinite;
}

@keyframes floating {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
}

/* Back to top button */
.back-to-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 1000;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.back-to-top.show {
    opacity: 1;
    visibility: visible;
}

.back-to-top:hover {
    background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.4);
    color: white;
}

.back-to-top i {
    font-size: 18px;
}

/* Border utilities */
.border-white-25 {
    border-color: rgba(255,255,255,0.25) !important;
}

/* Text utilities */
.text-white-50 {
    color: rgba(255,255,255,0.5) !important;
}

/* Responsive */
@media (max-width: 768px) {
    .footer-section h3 {
        font-size: 1.5rem;
        text-align: center;
    }
    
    .footer-section h5 {
        font-size: 16px;
        text-align: center;
    }
    
    .footer-section h5::after {
        left: 50%;
        transform: translateX(-50%);
    }
    
    .social-links {
        text-align: center;
    }
    
    .contact-info {
        text-align: center;
    }
    
    .contact-info .contact-item {
        justify-content: center;
        text-align: left;
    }
    
    .newsletter-form {
        flex-direction: column;
    }
    
    .newsletter-input {
        margin-bottom: 10px;
    }
    
    .payment-methods {
        gap: 15px;
    }
    
    .footer-bottom {
        text-align: center !important;
    }
    
    .footer-bottom .col-md-6 {
        text-align: center !important;
        margin-bottom: 10px;
    }
}

@media (max-width: 576px) {
    .footer-section {
        padding: 30px 0;
    }
    
    .footer-brand p {
        font-size: 14px;
    }
    
    .social-link {
        width: 40px;
        height: 40px;
    }
    
    .social-link i {
        font-size: 16px;
    }
    
    .contact-info .contact-item span {
        font-size: 13px;
    }
    
    .back-to-top {
        width: 45px;
        height: 45px;
        bottom: 20px;
        right: 20px;
    }
}
</style>

<footer class="footer-section mt-5" style="background: var(--gradient-primary); position: relative; overflow: hidden;">
    <!-- Decorative wave -->
    <div class="footer-wave">
        <svg viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" fill="rgba(255,255,255,0.1)"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" fill="rgba(255,255,255,0.1)"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" fill="rgba(255,255,255,0.1)"></path>
        </svg>
    </div>
    
    <div class="container py-5 position-relative">
        <div class="row">
            <!-- Company Info -->
            <div class="col-lg-4 col-md-6 mb-4 fade-in-up">
                <div class="footer-brand mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/img/Logo_HCMUTE.png" width="60" class="me-3 floating" alt="Logo HCMUTE"
                             onerror="this.style.display='none';">
                        <h3 class="text-white fw-bold mb-0">UTESHOP</h3>
                    </div>
                    <p class="text-white-50 mb-4">Nền tảng thương mại điện tử hàng đầu dành cho sinh viên, mang đến trải nghiệm mua sắm tuyệt vời với sản phẩm chất lượng và giá cả hợp lý.</p>
                    
                    <!-- Social Media -->
                    <div class="social-links">
                        <a href="#" class="social-link me-3 hover-scale" title="Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-link me-3 hover-scale" title="Instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="social-link me-3 hover-scale" title="YouTube">
                            <i class="fab fa-youtube"></i>
                        </a>
                        <a href="#" class="social-link me-3 hover-scale" title="TikTok">
                            <i class="fab fa-tiktok"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-lg-2 col-md-6 mb-4 fade-in-up" style="animation-delay: 0.2s;">
                <h5 class="text-white fw-bold mb-4">Liên kết nhanh</h5>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/guest/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/products">Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/categories">Danh mục</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/about">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/guest/contact">Liên hệ</a></li>
                </ul>
            </div>

            <!-- Customer Support -->
            <div class="col-lg-3 col-md-6 mb-4 fade-in-up" style="animation-delay: 0.4s;">
                <h5 class="text-white fw-bold mb-4">Hỗ trợ khách hàng</h5>
                <ul class="footer-links">
                    <li><a href="#">Hướng dẫn mua hàng</a></li>
                    <li><a href="#">Chính sách đổi trả</a></li>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Điều khoản sử dụng</a></li>
                    <li><a href="#">Câu hỏi thường gặp</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="col-lg-3 col-md-6 mb-4 fade-in-up" style="animation-delay: 0.6s;">
                <h5 class="text-white fw-bold mb-4">Thông tin liên hệ</h5>
                <div class="contact-info">
                    <div class="contact-item mb-3">
                        <i class="fas fa-map-marker-alt text-warning me-3"></i>
                        <span class="text-white-50">Đại học Sư phạm Kỹ thuật TP.HCM<br>1 Võ Văn Ngân, Q.Thủ Đức, TP.HCM</span>
                    </div>
                    <div class="contact-item mb-3">
                        <i class="fas fa-phone text-warning me-3"></i>
                        <span class="text-white-50">Hotline: 1900-0000</span>
                    </div>
                    <div class="contact-item mb-3">
                        <i class="fas fa-envelope text-warning me-3"></i>
                        <span class="text-white-50">Email: nhom17@uteshop.edu.vn</span>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-clock text-warning me-3"></i>
                        <span class="text-white-50">24/7 - Hỗ trợ mọi lúc</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Methods -->
        <div class="row mt-4 pt-4 border-top border-white-25">
            <div class="col-12 text-center fade-in-up">
                <h6 class="text-white-50 mb-3">Phương thức thanh toán</h6>
                <div class="payment-methods">
                    <span class="payment-method me-3 hover-scale" title="Visa">
                        <i class="fab fa-cc-visa fa-2x text-white-50"></i>
                    </span>
                    <span class="payment-method me-3 hover-scale" title="Mastercard">
                        <i class="fab fa-cc-mastercard fa-2x text-white-50"></i>
                    </span>
                    <span class="payment-method me-3 hover-scale" title="PayPal">
                        <i class="fab fa-cc-paypal fa-2x text-white-50"></i>
                    </span>
                    <span class="payment-method me-3 hover-scale" title="Mobile Banking">
                        <i class="fas fa-mobile-alt fa-2x text-white-50"></i>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Copyright -->
    <div class="footer-bottom py-3" style="background: rgba(0, 0, 0, 0.3);">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start">
                    <p class="text-white-50 mb-0">
                        © 2025 <strong class="text-warning">UTESHOP</strong> | Bản quyền thuộc về Nhóm 17 
                    </p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="text-white-50 mb-0">
                        Thiết kế bởi <span class="text-warning">Nhóm 17</span> với <i class="fas fa-heart text-danger"></i>
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
// Back to top functionality
document.addEventListener('DOMContentLoaded', function() {
    const backToTop = document.getElementById('backToTop');
    
    // Show/hide back to top button
    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            backToTop.classList.add('show');
        } else {
            backToTop.classList.remove('show');
        }
    });
    
    // Smooth scroll to top
    backToTop.addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
    
    // Newsletter form submission
    const newsletterForm = document.querySelector('.newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[type="email"]').value;
            
            if (email) {
                // Show success message
                showNotification('Đăng ký nhận tin thành công! Cảm ơn bạn đã đăng ký.', 'success');
                this.reset();
            }
        });
    }
    
    // Animation on scroll for footer elements
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0) translateX(0)';
            }
        });
    }, observerOptions);

    // Observe footer animation elements
    document.querySelectorAll('.fade-in-up, .fade-in-left').forEach(el => {
        observer.observe(el);
    });
});

// Notification function (if not already defined)
function showNotification(message, type = 'info') {
    if (typeof window.showNotification === 'function') {
        window.showNotification(message, type);
        return;
    }
    
    // Simple fallback notification
    const notification = document.createElement('div');
    notification.className = `alert alert-${type} position-fixed`;
    notification.style.cssText = `
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        border-radius: 8px;
    `;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        if (notification.parentElement) {
            notification.remove();
        }
    }, 3000);
}
</script>