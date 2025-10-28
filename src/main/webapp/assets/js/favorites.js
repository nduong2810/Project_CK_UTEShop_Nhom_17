function toggleFavorite(event, button, productId, requireLogin) {
   event.preventDefault();
  
   if (requireLogin) {
       window.location.href = contextPath + '/auth/login';
       return;
   }
   fetch(contextPath + '/user/favorites/toggle', {
       method: 'POST',
       headers: {
           'Content-Type': 'application/x-www-form-urlencoded',
       },
       body: 'maSP=' + productId
   })
   .then(response => response.json())
   .then(data => {
       if (data.status === 'success') {
           if (data.action === 'removed') {
               // Nếu đang ở trang favorites, reload để cập nhật danh sách
               if (window.location.pathname.includes('/user/favorites')) {
                   window.location.reload();
               } else {
                   button.classList.remove('active');
               }
           } else {
               button.classList.add('active');
           }
           // Hiển thị thông báo thành công
           showToast(data.message, 'success');
       } else {
           showToast(data.message, 'error');
       }
   })
   .catch(error => {
       console.error('Error:', error);
       showToast('Đã có lỗi xảy ra. Vui lòng thử lại sau.', 'error');
   });
}
function showToast(message, type) {
   // Kiểm tra xem đã có container toast chưa
   let toastContainer = document.querySelector('.toast-container');
   if (!toastContainer) {
       toastContainer = document.createElement('div');
       toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
       document.body.appendChild(toastContainer);
   }
   // Tạo toast mới
   const toastHtml = `
       <div class="toast align-items-center text-white bg-${type === 'success' ? 'success' : 'danger'} border-0" role="alert" aria-live="assertive" aria-atomic="true">
           <div class="d-flex">
               <div class="toast-body">
                   ${message}
               </div>
               <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
           </div>
       </div>
   `;
   // Thêm toast vào container
   toastContainer.insertAdjacentHTML('beforeend', toastHtml);
   // Khởi tạo và hiển thị toast
   const toastElement = toastContainer.lastElementChild;
   const toast = new bootstrap.Toast(toastElement, {
       autohide: true,
       delay: 3000
   });
   toast.show();
   // Xóa toast sau khi ẩn
   toastElement.addEventListener('hidden.bs.toast', () => {
       toastElement.remove();
   });
}
