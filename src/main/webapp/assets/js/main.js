// UTESHOP - Main JavaScript File
// Modern Interactive Effects and Functionality

// Đặt tất cả các hàm tiện ích và biến toàn cục cần thiết ở đầu
// Lưu ý: Thư viện Bootstrap (bootstrap.Tooltip) được giả định đã được load.

const STORAGE_KEYS = {
    CART: 'cart',
    WISHLIST: 'wishlist',
    COMPARISON: 'comparison',
    DARK_MODE: 'darkMode'
};

// ===================================
// ===== UTILITY FUNCTIONS (Tiện ích) =====
// ===================================

/** Định dạng giá tiền theo tiền Việt Nam */
function formatPrice(price) {
    if (typeof price !== 'number') price = parseInt(price) || 0;
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(price);
}

/** Chống rung (Debounce) cho các sự kiện input */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/** Lấy icon cho thông báo */
function getNotificationIcon(type) {
    const icons = {
        success: 'check-circle',
        error: 'exclamation-circle',
        warning: 'exclamation-triangle',
        info: 'info-circle'
    };
    return icons[type] || 'info-circle';
}


// ==================================================
// ===== CORE INITIALIZATION (Khởi tạo cốt lõi) =====
// ==================================================

document.addEventListener('DOMContentLoaded', function() {
    console.log('🚀 UTESHOP initialized successfully!');
    
    // Khởi tạo các module chính
    initNotifications(); // Phải khởi tạo trước để các module khác có thể dùng showNotification
    
    initThemeMode();
    initLoadingStates();
    initShoppingCart();
    initWishlist();
    initProductComparison();
    
    // Khởi tạo các module dựa trên DOM
    initScrollEffects();
    initAnimations();
    initTooltips();
    initSearchEnhancements(); // Tối ưu hóa: Thay thế initRealTimeSearch
    initProductCards();
    initAdvancedFilters();
    initInfiniteScroll();
    initSocialSharing();
    initBackToTop();
    initImageViewer();
    
    // Khởi tạo các tính năng nâng cao
    initPWAFeatures();
    initErrorHandling();
    initAnalytics();
    preloadCriticalResources();
});


// =========================================
// ===== MODULE IMPLEMENTATIONS (Module) =====
// =========================================

// --- SCROLL EFFECTS ---
function initScrollEffects() {
    const navbar = document.querySelector('.navbar');
    let lastScrollTop = 0;
    
    if (navbar) {
        window.addEventListener('scroll', function() {
            const scrollTop = window.scrollY || document.documentElement.scrollTop;
            const isScrollingDown = scrollTop > lastScrollTop && scrollTop > 200;
            
            // Background change effect
            if (scrollTop > 100) {
                navbar.style.background = 'rgba(0, 43, 91, 0.95)';
                navbar.style.backdropFilter = 'blur(20px)';
            } else {
                // Giả định var(--gradient-primary) đã được định nghĩa trong CSS
                navbar.style.background = 'var(--gradient-primary, #002b5b)'; 
                navbar.style.backdropFilter = 'blur(10px)';
            }
            
            // Hide/show navbar on scroll
            navbar.style.transform = isScrollingDown ? 'translateY(-100%)' : 'translateY(0)';
            
            lastScrollTop = scrollTop;
        });
    }
    
    // Parallax effect
    const heroSection = document.querySelector('.carousel');
    if (heroSection) {
        window.addEventListener('scroll', function() {
            const scrolled = window.scrollY;
            const rate = scrolled * -0.5;
            heroSection.style.transform = `translateY(${rate}px)`;
        });
    }
}

// --- ANIMATIONS ---
function initAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries, observer) { // Lấy observer trong callback
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);
    
    document.querySelectorAll('.fade-in-up, .fade-in-left, .product-card').forEach(el => {
        observer.observe(el);
    });
    
    // Stagger animation
    document.querySelectorAll('.product-card').forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
}

// --- TOOLTIPS ---
function initTooltips() {
    // 1. Initialize Bootstrap tooltips (requires Bootstrap JS)
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach(tooltipTriggerEl => {
        // Kiểm tra sự tồn tại của biến Bootstrap toàn cục
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            new bootstrap.Tooltip(tooltipTriggerEl);
        } else {
            console.warn('Bootstrap Tooltip not found. Custom tooltips will still work.');
        }
    });
    
    // 2. Custom tooltips for product features
    document.querySelectorAll('.product-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            const tooltip = document.createElement('div');
            tooltip.className = 'custom-tooltip';
            tooltip.innerHTML = '<i class="fa fa-info-circle"></i> Nhấp để xem chi tiết';
            document.body.appendChild(tooltip);
            
            const mouseMoveHandler = function(e) {
                tooltip.style.left = e.pageX + 10 + 'px';
                tooltip.style.top = e.pageY - 30 + 'px';
            };
            
            this.addEventListener('mousemove', mouseMoveHandler);
            
            this.addEventListener('mouseleave', function() {
                tooltip.remove();
                this.removeEventListener('mousemove', mouseMoveHandler);
            }, { once: true }); // Tự động xóa listener khi chuột rời đi
        });
    });
}

// --- SEARCH ENHANCEMENTS (Tối ưu hóa: Gộp chung Real-time và Basic Search) ---
function initSearchEnhancements() {
    const searchInput = document.querySelector('.search-input');
    const searchBtn = document.querySelector('.search-btn');
    
    if (!searchInput) return;

    let searchTimeout;

    // Gán hàm tìm kiếm vào window để gọi từ gợi ý
    window.selectSuggestion = function(suggestion) { // Đặt lại hàm này để fix lỗi
        searchInput.value = suggestion;
        hideSuggestions();
        performSearch(suggestion);
    };

    searchInput.addEventListener('input', function() {
        clearTimeout(searchTimeout);
        const query = this.value.trim();
        
        if (query.length > 2) {
            searchTimeout = setTimeout(async () => {
                await fetchSearchSuggestions(query);
            }, 300);
        } else {
            hideSuggestions();
        }
    });

    if (searchBtn) {
        searchBtn.addEventListener('click', function(e) {
            e.preventDefault();
            const originalIcon = '<i class="fa fa-search"></i>';
            this.innerHTML = '<i class="fa fa-spinner fa-spin"></i>';
            
            setTimeout(() => {
                this.innerHTML = originalIcon;
                performSearch(searchInput.value);
            }, 1000);
        });
    }

    // Voice search (Tách hàm)
    if ('webkitSpeechRecognition' in window) {
        const voiceBtn = document.createElement('button');
        voiceBtn.innerHTML = '<i class="fa fa-microphone"></i>';
        voiceBtn.className = 'btn btn-outline-secondary btn-sm ms-2 voice-btn';
        voiceBtn.type = 'button';
        
        voiceBtn.addEventListener('click', startVoiceSearch);
        
        searchInput.parentNode.appendChild(voiceBtn);
    }
    
    // Hàm ẩn gợi ý
    function hideSuggestions() {
        const basicSuggestions = document.querySelector('.search-suggestions');
        const advancedSuggestions = document.querySelector('.advanced-suggestions');
        if (basicSuggestions) basicSuggestions.style.display = 'none';
        if (advancedSuggestions) advancedSuggestions.style.display = 'none';
    }

    // Hàm tìm kiếm và hiển thị gợi ý
    async function fetchSearchSuggestions(query) {
        try {
            // Sử dụng logic hiển thị gợi ý Nâng cao
            // Mock API response
            const suggestions = [
                { id: 1, name: `${query} - iPhone 15 Pro Max`, category: 'Điện thoại' },
                { id: 2, name: `${query} - Samsung Galaxy S24`, category: 'Laptop' },
                { id: 3, name: `${query} - MacBook Air M3`, category: 'Phụ kiện' }
            ].filter(item => item.name.toLowerCase().includes(query.toLowerCase()));
            
            displayAdvancedSuggestions(suggestions);
        } catch (error) {
            console.error('Error fetching suggestions:', error);
            window.showNotification('Lỗi tải gợi ý tìm kiếm', 'error');
        }
    }

    // Hàm hiển thị gợi ý Nâng cao (tối ưu hóa từ displayAdvancedSuggestions)
    function displayAdvancedSuggestions(suggestions) {
        const searchContainer = searchInput.parentNode;
        let suggestionsContainer = document.querySelector('.advanced-suggestions');
        
        if (!suggestionsContainer) {
            suggestionsContainer = document.createElement('div');
            suggestionsContainer.className = 'advanced-suggestions';
            searchContainer.appendChild(suggestionsContainer);
        }
        
        if (suggestions.length === 0) {
            suggestionsContainer.style.display = 'none';
            return;
        }

        suggestionsContainer.innerHTML = suggestions.map(item => `
            <div class="suggestion-item advanced" onclick="selectSuggestion('${item.name.replace(/'/g, "\\'")}')">
                <div class="suggestion-content">
                    <span class="suggestion-name">${item.name}</span>
                    <small class="suggestion-category">${item.category}</small>
                </div>
                <i class="fa fa-arrow-up-right-from-square"></i>
            </div>
        `).join('');
        
        suggestionsContainer.style.display = 'block';
    }

    // Hàm thực hiện tìm kiếm
    function performSearch(query) {
        if (query.trim()) {
            // Chuyển hướng đến trang tìm kiếm
            window.location.href = `/guest/search?keyword=${encodeURIComponent(query)}`;
        }
    }

    // Hàm tìm kiếm bằng giọng nói
    function startVoiceSearch() {
        const recognition = new webkitSpeechRecognition();
        recognition.lang = 'vi-VN';
        recognition.continuous = false;
        recognition.interimResults = false;
        
        recognition.onstart = function() {
            window.showNotification('Đang nghe...', 'info');
        };
        
        recognition.onresult = function(event) {
            const result = event.results[0][0].transcript;
            searchInput.value = result;
            performSearch(result);
        };
        
        recognition.onerror = function() {
            window.showNotification('Lỗi nhận dạng giọng nói', 'error');
        };
        
        recognition.start();
    }
}

// --- PRODUCT CARDS ---
function initProductCards() {
    document.querySelectorAll('.product-card').forEach(card => {
        // Add to cart animation
        const addToCartBtn = card.querySelector('.btn-primary');
        if (addToCartBtn) {
            addToCartBtn.addEventListener('click', function(e) {
                e.preventDefault();
                // Tách hàm và gọi tại đây
                addToCartAnimation(this);
            });
        }
        
        // Quick view functionality
        const quickViewBtn = card.querySelector('.product-overlay button');
        if (quickViewBtn) {
            quickViewBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                showQuickView(card);
            });
        }
        
        // Image zoom on hover (tối ưu: dùng CSS thay JS cho hiệu suất tốt hơn)
        const productImage = card.querySelector('.card-img-top');
        if (productImage) {
            card.addEventListener('mouseenter', function() {
                productImage.style.transform = 'scale(1.1)';
            });
            
            card.addEventListener('mouseleave', function() {
                productImage.style.transform = 'scale(1)';
            });
        }
    });
}

// Hàm phụ cho Product Cards: Animation thêm vào giỏ hàng
function addToCartAnimation(button) {
    const originalText = button.innerHTML;
    button.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Đang thêm...';
    button.disabled = true;
    
    const productCard = button.closest('.product-card');
    const product = {
        id: productCard.dataset.productId || Date.now().toString(),
        name: productCard.querySelector('.card-title').textContent,
        // Đảm bảo lấy giá từ dataset, không phải từ text (tính ổn định cao hơn)
        price: parseInt(productCard.dataset.price) || 0, 
        image: productCard.querySelector('.card-img-top').src
    };
    
    setTimeout(() => {
        button.innerHTML = '<i class="fa fa-check"></i> Đã thêm!';
        button.classList.remove('btn-primary');
        button.classList.add('btn-success');
        
        window.addToCart(product); // Gọi hàm toàn cục đã được expose
        
        const cartIcon = document.querySelector('.cart-icon');
        if (cartIcon) {
            cartIcon.classList.add('bounce-animation');
            setTimeout(() => cartIcon.classList.remove('bounce-animation'), 600);
        }
        
        setTimeout(() => {
            button.innerHTML = originalText;
            button.classList.remove('btn-success');
            button.classList.add('btn-primary');
            button.disabled = false;
        }, 2000);
    }, 1000);
}

// Hàm phụ cho Product Cards: Hiển thị Quick View
function showQuickView(productCard) {
    const productName = productCard.querySelector('.card-title').textContent;
    const productPrice = productCard.querySelector('.price').textContent;
    const productImage = productCard.querySelector('.card-img-top').src;
    const productRating = productCard.querySelector('.rating')?.innerHTML || ''; // Use innerHTML to keep star icons

    const modal = document.createElement('div');
    modal.className = 'quick-view-modal';
    modal.innerHTML = `
        <div class="modal-overlay"></div>
        <div class="modal-content">
            <button class="btn-close">&times;</button>
            <div class="row">
                <div class="col-md-6">
                    <img src="${productImage}" alt="${productName}" class="img-fluid">
                </div>
                <div class="col-md-6">
                    <h2>${productName}</h2>
                    <div class="price-rating">
                        <span class="price">${productPrice}</span>
                        <span class="rating">${productRating}</span>
                    </div>
                    <p>Đây là mô tả nhanh về sản phẩm. Thông tin chi tiết hơn sẽ có trên trang sản phẩm chính.</p>
                    <div class="quantity-controls">
                        <button class="btn btn-secondary qty-decrease">-</button>
                        <input type="number" value="1" min="1" class="form-control d-inline-block" style="width: 70px;">
                        <button class="btn btn-secondary qty-increase">+</button>
                    </div>
                    <button class="btn btn-primary mt-3">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>
    `;
    
    document.body.appendChild(modal);
    setTimeout(() => modal.classList.add('show'), 10);
    
    // Close modal handlers
    function closeModal() {
        modal.classList.remove('show');
        setTimeout(() => modal.remove(), 300);
    }
    
    modal.querySelector('.btn-close').addEventListener('click', closeModal);
    modal.querySelector('.modal-overlay').addEventListener('click', closeModal);
    
    // Quantity controls
    const quantityInput = modal.querySelector('input[type="number"]');
    modal.querySelector('.qty-decrease').addEventListener('click', () => {
        if (quantityInput.value > 1) quantityInput.value--;
    });
    modal.querySelector('.qty-increase').addEventListener('click', () => {
        quantityInput.value++;
    });
}


// --- NOTIFICATIONS ---
function initNotifications() {
    function showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <i class="fa fa-${getNotificationIcon(type)}"></i>
                <span>${message}</span>
                <button class="notification-close">&times;</button>
            </div>
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => notification.classList.add('show'), 100);
        
        // Auto remove after 5 seconds
        const timer = setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => notification.remove(), 300);
        }, 5000);
        
        // Manual close
        notification.querySelector('.notification-close').addEventListener('click', function() {
            clearTimeout(timer); // Xóa timer tự động đóng
            notification.classList.remove('show');
            setTimeout(() => notification.remove(), 300);
        });
    }
    
    window.showNotification = showNotification; // Expose globally
}

// --- THEME MODE ---
function initThemeMode() {
    const themeToggle = document.createElement('button');
    themeToggle.innerHTML = '<i class="fa fa-moon"></i>';
    themeToggle.className = 'theme-toggle';
    themeToggle.title = 'Chuyển đổi chế độ tối';
    
    document.body.appendChild(themeToggle);
    
    themeToggle.addEventListener('click', function() {
        document.body.classList.toggle('dark-mode');
        const isDark = document.body.classList.contains('dark-mode');
        
        this.innerHTML = isDark ? '<i class="fa fa-sun"></i>' : '<i class="fa fa-moon"></i>';
        localStorage.setItem(STORAGE_KEYS.DARK_MODE, String(isDark));
    });
    
    // Load saved theme
    if (localStorage.getItem(STORAGE_KEYS.DARK_MODE) === 'true') {
        document.body.classList.add('dark-mode');
        themeToggle.innerHTML = '<i class="fa fa-sun"></i>';
    }
}

// --- LOADING STATES ---
function initLoadingStates() {
    const loadingOverlay = document.createElement('div');
    loadingOverlay.className = 'loading-overlay';
    loadingOverlay.innerHTML = `
        <div class="loading-spinner">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="mt-3">Đang tải...</p>
        </div>
    `;
    document.body.appendChild(loadingOverlay);
    
    // Expose globally
    window.showLoading = () => loadingOverlay.classList.add('show');
    window.hideLoading = () => loadingOverlay.classList.remove('show');
}

// --- SHOPPING CART MANAGEMENT ---
function initShoppingCart() {
    let cart = JSON.parse(localStorage.getItem(STORAGE_KEYS.CART)) || [];
    const cartSidebar = document.createElement('div');
    cartSidebar.className = 'cart-sidebar';
    // ... (HTML structure)

    document.body.appendChild(cartSidebar);
    updateCartDisplay();
    
    // Tách các DOM query ra ngoài để dùng lại
    const cartItemsContainer = cartSidebar.querySelector('.cart-items');
    const totalPriceElement = cartSidebar.querySelector('.total-price');

    // Cart toggle
    document.addEventListener('click', function(e) {
        if (e.target.closest('.cart-icon')) {
            cartSidebar.classList.add('open');
            displayCartItems();
        }
        
        // Sửa lỗi đóng cart: Chỉ đóng khi click ra ngoài hoặc nút đóng
        if (e.target.closest('.cart-close') || (e.target === cartSidebar)) { 
             // Tối ưu hóa: E.target === cartSidebar là khi click vào phần nền overlay
            cartSidebar.classList.remove('open');
        }
    });
    
    function updateCartDisplay() {
        const cartCount = document.querySelector('.cart-count');
        if (cartCount) {
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
            cartCount.textContent = String(totalItems);
            cartCount.style.display = totalItems > 0 ? 'block' : 'none';
        }
    }
    
    function displayCartItems() {
        if (cart.length === 0) {
            cartItemsContainer.innerHTML = '<p class="empty-cart">Giỏ hàng trống</p>';
            totalPriceElement.textContent = '0₫';
            return;
        }
        
        let html = '';
        let total = 0;
        
        cart.forEach(item => {
            const itemTotal = item.price * item.quantity;
            total += itemTotal;
            
            html += `
                <div class="cart-item" data-id="${item.id}">
                    <img src="${item.image}" alt="${item.name}">
                    <div class="item-details">
                        <h6>${item.name}</h6>
                        <p class="item-price">${formatPrice(item.price)}</p>
                        <div class="quantity-controls">
                            <button class="qty-decrease" data-action="decrease">-</button>
                            <span class="quantity">${item.quantity}</span>
                            <button class="qty-increase" data-action="increase">+</button>
                        </div>
                    </div>
                    <button class="remove-item" data-action="remove"><i class="fa fa-trash"></i></button>
                </div>
            `;
        });
        
        cartItemsContainer.innerHTML = html;
        totalPriceElement.textContent = formatPrice(total);
        
        // Gán listener vào container lớn, không gán lặp lại
        cartItemsContainer.onclick = handleCartActions; // Gán handler vào container cha
    }
    
    function handleCartActions(e) {
        const cartItem = e.target.closest('.cart-item');
        const actionButton = e.target.closest('[data-action]');
        if (!cartItem || !actionButton) return;
        
        const itemId = cartItem.dataset.id;
        const action = actionButton.dataset.action;
        const item = cart.find(i => i.id === itemId);

        if (!item) return;
        
        if (action === 'increase') {
            item.quantity++;
        } else if (action === 'decrease') {
            if (item.quantity > 1) {
                item.quantity--;
            } else {
                removeFromCart(itemId);
                return;
            }
        } else if (action === 'remove') {
            removeFromCart(itemId);
            return;
        }
        
        saveCart();
        displayCartItems();
        updateCartDisplay();
    }
    
    function removeFromCart(itemId) {
        const index = cart.findIndex(item => item.id === itemId);
        if (index > -1) {
            cart.splice(index, 1);
            saveCart();
            displayCartItems();
            updateCartDisplay();
            window.showNotification('Đã xóa sản phẩm khỏi giỏ hàng', 'info');
        }
    }
    
    function saveCart() {
        localStorage.setItem(STORAGE_KEYS.CART, JSON.stringify(cart));
    }
    
    // Expose functions globally
    window.addToCart = function(product) {
        const existingItem = cart.find(item => item.id === product.id);
        
        if (existingItem) {
            existingItem.quantity++;
        } else {
            cart.push({...product, quantity: 1});
        }
        
        saveCart();
        updateCartDisplay();
        window.showNotification('Đã thêm vào giỏ hàng!', 'success');
    };
}


// --- WISHLIST FUNCTIONALITY ---
function initWishlist() {
    let wishlist = JSON.parse(localStorage.getItem(STORAGE_KEYS.WISHLIST)) || [];
    
    document.querySelectorAll('.product-card').forEach(card => {
        // ... (HTML structure)
        
        const productId = card.dataset.productId;
        const wishlistBtn = document.createElement('button');
        wishlistBtn.className = 'wishlist-btn';
        wishlistBtn.innerHTML = wishlist.includes(productId) ? '<i class="fa fa-heart"></i>' : '<i class="fa fa-heart-o"></i>';
        wishlistBtn.classList.toggle('active', wishlist.includes(productId));
        
        wishlistBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            toggleWishlist(productId, this);
        });
        
        // Tối ưu hóa: Đảm bảo phần tử cha tồn tại trước khi append
        card.querySelector('.card-img-top')?.parentNode.appendChild(wishlistBtn);
    });
    
    function toggleWishlist(productId, button) {
        const index = wishlist.indexOf(productId);
        
        if (index > -1) {
            wishlist.splice(index, 1);
            button.classList.remove('active');
            button.innerHTML = '<i class="fa fa-heart-o"></i>';
            window.showNotification('Đã xóa khỏi danh sách yêu thích', 'info');
        } else {
            wishlist.push(productId);
            button.classList.add('active');
            button.innerHTML = '<i class="fa fa-heart"></i>';
            window.showNotification('Đã thêm vào danh sách yêu thích', 'success');
        }
        
        localStorage.setItem(STORAGE_KEYS.WISHLIST, JSON.stringify(wishlist));
        updateWishlistCount();
    }
    
    function updateWishlistCount() {
        const wishlistCount = document.querySelector('.wishlist-count');
        if (wishlistCount) {
            wishlistCount.textContent = String(wishlist.length);
        }
    }
    
    updateWishlistCount();
}


// --- PRODUCT COMPARISON ---
function initProductComparison() {
    let comparison = JSON.parse(localStorage.getItem(STORAGE_KEYS.COMPARISON)) || [];
    const maxComparisonItems = 3;
    
    // Thêm nút so sánh
    document.querySelectorAll('.product-card').forEach(card => {
        const compareBtn = document.createElement('button');
        compareBtn.className = 'compare-btn btn btn-outline-secondary btn-sm';
        compareBtn.innerHTML = '<i class="fa fa-balance-scale"></i> So sánh';
        
        compareBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            const productId = card.dataset.productId;
            if (productId) addToComparison(productId);
        });
        
        card.querySelector('.card-body')?.appendChild(compareBtn);
    });
    
    function addToComparison(productId) {
        if (comparison.includes(productId)) {
            window.showNotification('Sản phẩm đã có trong danh sách so sánh', 'warning');
            return;
        }
        
        if (comparison.length >= maxComparisonItems) {
            window.showNotification(`Chỉ có thể so sánh tối đa ${maxComparisonItems} sản phẩm`, 'warning');
            return;
        }
        
        comparison.push(productId);
        localStorage.setItem(STORAGE_KEYS.COMPARISON, JSON.stringify(comparison));
        updateComparisonDisplay();
        window.showNotification('Đã thêm vào danh sách so sánh', 'success');
    }
    
    function updateComparisonDisplay() {
        const comparisonCount = document.querySelector('.comparison-count');
        if (comparisonCount) {
            comparisonCount.textContent = String(comparison.length);
        }
        
        if (comparison.length > 0) {
            showComparisonBar();
        } else {
            hideComparisonBar();
        }
    }
    
    function showComparisonBar() {
        let comparisonBar = document.querySelector('.comparison-bar');
        if (!comparisonBar) {
            comparisonBar = document.createElement('div');
            comparisonBar.className = 'comparison-bar';
            document.body.appendChild(comparisonBar);

            // Gán listener cho nút Xóa
            comparisonBar.addEventListener('click', function(e) {
                if (e.target.closest('.clear-comparison')) {
                    comparison = []; // Clear local array
                    localStorage.setItem(STORAGE_KEYS.COMPARISON, JSON.stringify(comparison));
                    updateComparisonDisplay();
                    window.showNotification('Đã xóa tất cả sản phẩm so sánh', 'info');
                }
            });
        }
        
        comparisonBar.innerHTML = `
            <div class="comparison-content">
                <span>So sánh (${comparison.length}/${maxComparisonItems})</span>
                <button class="btn btn-primary btn-sm compare-now">So sánh ngay</button>
                <button class="btn btn-outline-secondary btn-sm clear-comparison">Xóa tất cả</button>
            </div>
        `;
        
        comparisonBar.classList.add('show');
    }

    function hideComparisonBar() {
        const comparisonBar = document.querySelector('.comparison-bar');
        if (comparisonBar) {
            comparisonBar.classList.remove('show');
            // Tối ưu hóa: Có thể xóa luôn khỏi DOM nếu muốn
            setTimeout(() => comparisonBar.remove(), 300);
        }
    }
    
    updateComparisonDisplay();
}


// --- ADVANCED FILTERS ---
function initAdvancedFilters() {
    const filterContainer = document.querySelector('.filter-container');
    if (!filterContainer) return;
    
    // ... (Price range slider HTML structure)
    // ... (Rating filter HTML structure)
    
    // Tách các DOM elements
    const minPriceInput = document.getElementById('minPrice');
    const maxPriceInput = document.getElementById('maxPrice');
    const minPriceDisplay = document.getElementById('minPriceDisplay');
    const maxPriceDisplay = document.getElementById('maxPriceDisplay');
    
    // Khởi tạo slider (nếu DOM đã được thêm)
    if (minPriceInput && maxPriceInput) {
        // Xử lý sự kiện chung cho 2 slider
        const priceSliderHandler = function() {
            // Đảm bảo min không lớn hơn max
            if (parseInt(minPriceInput.value) > parseInt(maxPriceInput.value)) {
                if (this === minPriceInput) {
                    maxPriceInput.value = minPriceInput.value;
                } else {
                    minPriceInput.value = maxPriceInput.value;
                }
            }
            applyFilters();
        };

        minPriceInput.addEventListener('input', debounce(priceSliderHandler, 50));
        maxPriceInput.addEventListener('input', debounce(priceSliderHandler, 50));
    }

    // Gán sự kiện cho rating và debounce chung
    filterContainer.addEventListener('change', debounce(applyFilters, 300));

    
    function applyFilters() {
        const minPrice = parseInt(minPriceInput?.value || 0);
        const maxPrice = parseInt(maxPriceInput?.value || 10000000);
        const selectedRatings = Array.from(document.querySelectorAll('.rating-filter input:checked')).map(input => parseInt(input.value));
        
        // Update price display (Kiểm tra tồn tại)
        if (minPriceDisplay) minPriceDisplay.textContent = formatPrice(minPrice);
        if (maxPriceDisplay) maxPriceDisplay.textContent = formatPrice(maxPrice);
        
        filterProducts({ minPrice, maxPrice, ratings: selectedRatings });
    }
    
    function filterProducts(filters) {
        const products = document.querySelectorAll('.product-card');
        
        products.forEach(product => {
            let show = true;
            
            // Price filter
            const price = parseInt(product.dataset.price || 0);
            if (price < filters.minPrice || price > filters.maxPrice) {
                show = false;
            }
            
            // Rating filter
            if (filters.ratings.length > 0) {
                const rating = parseInt(product.dataset.rating || 0);
                if (!filters.ratings.some(r => rating >= r)) {
                    show = false;
                }
            }
            
            const column = product.closest('.col-lg-3, .col-md-4, .col-sm-6');
            if (column) {
                column.style.display = show ? 'block' : 'none';
            }
        });
    }

    // Chạy lần đầu để thiết lập giá trị hiển thị
    if (minPriceInput && maxPriceInput) {
       applyFilters(); 
    }
}

// --- IMAGE VIEWER ---
function initImageViewer() {
    document.addEventListener('click', function(e) {
        // Chỉ kích hoạt nếu click vào ảnh sản phẩm trong card
        if (e.target.classList.contains('card-img-top') && e.target.closest('.product-card')) {
            showImageViewer(e.target.src, e.target.alt);
        }
    });
    
    function showImageViewer(imageSrc, imageAlt) {
        const viewer = document.createElement('div');
        viewer.className = 'image-viewer';
        viewer.innerHTML = `
            <div class="viewer-overlay"></div>
            <div class="viewer-content">
                <img src="${imageSrc}" alt="${imageAlt}" style="transform: scale(1);">
                <button class="viewer-close">&times;</button>
                <div class="viewer-controls">
                    <button class="zoom-in">+</button>
                    <button class="zoom-out">-</button>
                    <button class="reset-zoom">_</button>
                </div>
            </div>
        `;

        document.body.appendChild(viewer);
        setTimeout(() => viewer.classList.add('show'), 100);
        
        let scale = 1;
        const img = viewer.querySelector('img');
        
        function closeViewer() {
            viewer.classList.remove('show');
            setTimeout(() => viewer.remove(), 300);
        }

        viewer.addEventListener('click', function(e) {
            // Đóng khi click vào nền đen hoặc nút X
            if (e.target === viewer || e.target.classList.contains('viewer-close') || e.target.classList.contains('viewer-overlay')) {
                closeViewer();
            }
            
            // Xử lý zoom
            if (e.target.closest('.zoom-in')) {
                scale = Math.min(scale * 1.2, 3);
            } else if (e.target.closest('.zoom-out')) {
                scale = Math.max(scale / 1.2, 0.5);
            } else if (e.target.closest('.reset-zoom')) {
                scale = 1;
            } else {
                return;
            }
            if(img) {
                img.style.transform = `scale(${scale})`;
            }
        });
    }
}

// --- PLACEHOLDER FUNCTIONS ---
function initInfiniteScroll() { /* TODO: Implement */ }
function initSocialSharing() { /* TODO: Implement */ }
function initBackToTop() { /* TODO: Implement */ }
function initPWAFeatures() { /* TODO: Implement */ }
function initErrorHandling() { /* TODO: Implement */ }
function initAnalytics() { /* TODO: Implement */ }
function preloadCriticalResources() { /* TODO: Implement */ }


// Loại bỏ các hàm cũ (showSearchSuggestions, selectSuggestion, hideSearchSuggestions)
// vì chúng đã được gộp và tối ưu hóa trong initSearchEnhancements.

// Loại bỏ initRealTimeSearch vì đã gộp vào initSearchEnhancements.
// Loại bỏ displayAdvancedSuggestions vì đã gộp vào initSearchEnhancements.
// Loại bỏ selectAdvancedSuggestion vì đã gộp vào initSearchEnhancements.
// Loại bỏ hideAdvancedSuggestions vì đã gộp vào initSearchEnhancements.
