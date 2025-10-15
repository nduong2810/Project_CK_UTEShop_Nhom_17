(function () {
  "use strict";

  // ======= Thông báo mặc định (fallback nếu chưa có toastr hoặc alert đẹp) =======
  window.showNotification = window.showNotification || function (msg, type) {
    var prefix = type ? "[" + type.toUpperCase() + "] " : "";
    alert(prefix + msg);
  };

  // ======= Khóa lưu trữ =======
  var STORAGE_KEYS = {
    CART: "uteshop_cart",
    WISHLIST: "uteshop_wishlist",
    COMPARISON: "uteshop_comparison"
  };

  // ======= Hàm định dạng giá =======
  function formatPrice(p) {
    return p.toLocaleString("vi-VN") + " ₫";
  }

  // ======= Debounce =======
  function debounce(fn, delay) {
    var timer;
    return function () {
      var args = arguments;
      clearTimeout(timer);
      timer = setTimeout(function () {
        fn.apply(null, args);
      }, delay);
    };
  }

  // ======= Wishlist =======
  function initWishlist() {
    var list = JSON.parse(localStorage.getItem(STORAGE_KEYS.WISHLIST) || "[]");

    function updateCount() {
      var el = document.querySelector(".wishlist-count");
      if (el) el.textContent = list.length;
    }

    document.querySelectorAll(".product-card").forEach(function (card) {
      var id = card.dataset.productId;
      var btn = document.createElement("button");
      btn.className = "wishlist-btn";
      var active = list.indexOf(id) > -1;
      btn.innerHTML = active ? '<i class="fa fa-heart"></i>' : '<i class="fa fa-heart-o"></i>';
      btn.classList.toggle("active", active);

      btn.addEventListener("click", function (e) {
        e.stopPropagation();
        var idx = list.indexOf(id);
        if (idx > -1) {
          list.splice(idx, 1);
          btn.innerHTML = '<i class="fa fa-heart-o"></i>';
          window.showNotification("Đã xóa khỏi yêu thích", "info");
        } else {
          list.push(id);
          btn.innerHTML = '<i class="fa fa-heart"></i>';
          window.showNotification("Đã thêm vào yêu thích", "success");
        }
        localStorage.setItem(STORAGE_KEYS.WISHLIST, JSON.stringify(list));
        updateCount();
      });

      var img = card.querySelector(".card-img-top");
      if (img && img.parentNode) img.parentNode.appendChild(btn);
    });

    updateCount();
  }

  // ======= So sánh sản phẩm =======
  function initProductComparison() {
    var list = JSON.parse(localStorage.getItem(STORAGE_KEYS.COMPARISON) || "[]");
    var max = 3;

    function updateCount() {
      var el = document.querySelector(".comparison-count");
      if (el) el.textContent = list.length;
    }

    document.querySelectorAll(".product-card").forEach(function (card) {
      var id = card.dataset.productId;
      var btn = document.createElement("button");
      btn.className = "compare-btn btn btn-outline-secondary btn-sm";
      btn.innerHTML = '<i class="fa fa-balance-scale"></i> So sánh';

      btn.addEventListener("click", function (e) {
        e.stopPropagation();
        if (list.indexOf(id) > -1) {
          window.showNotification("Đã có trong danh sách", "warning");
          return;
        }
        if (list.length >= max) {
          window.showNotification("Tối đa " + max + " sản phẩm", "warning");
          return;
        }
        list.push(id);
        localStorage.setItem(STORAGE_KEYS.COMPARISON, JSON.stringify(list));
        updateCount();
        showBar();
        window.showNotification("Đã thêm vào so sánh", "success");
      });

      var body = card.querySelector(".card-body");
      if (body) body.appendChild(btn);
    });

    function showBar() {
      var bar = document.querySelector(".comparison-bar");
      if (!bar) {
        bar = document.createElement("div");
        bar.className = "comparison-bar";
        document.body.appendChild(bar);
        bar.addEventListener("click", function (e) {
          if (e.target.classList.contains("clear-comparison")) {
            list = [];
            localStorage.setItem(STORAGE_KEYS.COMPARISON, JSON.stringify(list));
            bar.remove();
            updateCount();
            window.showNotification("Đã xóa tất cả", "info");
          }
        });
      }

      bar.innerHTML =
        '<div class="comparison-content">' +
        '<span>So sánh (' + list.length + '/' + max + ')</span>' +
        '<button class="btn btn-primary btn-sm">So sánh ngay</button>' +
        '<button class="btn btn-outline-secondary btn-sm clear-comparison">Xóa tất cả</button>' +
        '</div>';
      bar.classList.add("show");
    }

    if (list.length) showBar();
    updateCount();
  }

  // ======= Bộ lọc nâng cao =======
  function initAdvancedFilters() {
    var container = document.querySelector(".filter-container");
    if (!container) return;

    var minIn = document.getElementById("minPrice");
    var maxIn = document.getElementById("maxPrice");
    var minDisp = document.getElementById("minPriceDisplay");
    var maxDisp = document.getElementById("maxPriceDisplay");

    function apply() {
      var min = parseInt(minIn && minIn.value ? minIn.value : 0);
      var max = parseInt(maxIn && maxIn.value ? maxIn.value : 10000000);
      var ratings = Array.prototype.slice
        .call(document.querySelectorAll(".rating-filter input:checked"))
        .map(function (i) {
          return parseInt(i.value);
        });

      if (minDisp) minDisp.textContent = formatPrice(min);
      if (maxDisp) maxDisp.textContent = formatPrice(max);

      document.querySelectorAll(".product-card").forEach(function (p) {
        var price = parseInt(p.dataset.price || 0);
        var rate = parseInt(p.dataset.rating || 0);
        var show = price >= min && price <= max;
        if (ratings.length && !ratings.some(function (r) { return rate >= r; })) {
          show = false;
        }
        var col = p.closest(".col-lg-3, .col-md-4, .col-sm-6");
        if (col) col.style.display = show ? "block" : "none";
      });
    }

    if (minIn && maxIn) {
      minIn.addEventListener("input", debounce(apply, 100));
      maxIn.addEventListener("input", debounce(apply, 100));
    }
    container.addEventListener("change", debounce(apply, 300));
    apply();
  }

  // ======= Khởi chạy =======
  document.addEventListener("DOMContentLoaded", function () {
    initWishlist();
    initProductComparison();
    initAdvancedFilters();
  });
})();
