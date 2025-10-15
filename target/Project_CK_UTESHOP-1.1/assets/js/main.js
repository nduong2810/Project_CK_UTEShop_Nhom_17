(function () {
  "use strict";

  // ======= Page Loader Logic =======
  function initPageLoader() {
    const loaderWrapper = document.getElementById('loader-wrapper');
    const pageContent = document.getElementById('page-content');

    if (!loaderWrapper || !pageContent) return;

    // Wait for the entire page (including all resources like images) to load
    window.onload = function() {
      // Fade out the loader
      loaderWrapper.style.opacity = '0';
      loaderWrapper.style.visibility = 'hidden';

      // After the loader fade-out transition (500ms from CSS), hide it completely
      setTimeout(function() {
        loaderWrapper.style.display = 'none';
      }, 500);

      // Fade in the page content
      pageContent.style.visibility = 'visible';
      pageContent.style.opacity = '1';
    };
  }

  // ======= Default Notification =======
  window.showNotification = window.showNotification || function (msg, type) {
    const prefix = type ? "[" + type.toUpperCase() + "] " : "";
    alert(prefix + msg);
  };

  // ======= Debounce Function =======
  function debounce(fn, delay) {
    let timer;
    return function () {
      const args = arguments;
      clearTimeout(timer);
      timer = setTimeout(function () {
        fn.apply(null, args);
      }, delay);
    };
  }

  // ======= Back to Top Button =======
  function initBackToTop() {
    const backToTop = document.getElementById('backToTop');
    if (!backToTop) return;

    const scrollHandler = debounce(function() {
        if (window.scrollY > 300) {
            backToTop.classList.add('show');
        } else {
            backToTop.classList.remove('show');
        }
    }, 150);

    window.addEventListener('scroll', scrollHandler);

    backToTop.addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
  }

  // ======= Newsletter Form =======
  function initNewsletterForm() {
      const newsletterForm = document.querySelector('.newsletter-form');
      if (!newsletterForm) return;

      newsletterForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const emailInput = this.querySelector('.newsletter-input');
        const email = emailInput.value;
        if (email) {
            window.showNotification('Cảm ơn bạn đã đăng ký nhận tin!', 'success');
            emailInput.value = '';
        }
    });
  }

  // ======= Initialization =======
  initPageLoader(); // Initialize the page loader immediately

  document.addEventListener("DOMContentLoaded", function () {
    // Initialize other non-critical scripts after the DOM is ready
    initBackToTop();
    initNewsletterForm();
  });

})();
