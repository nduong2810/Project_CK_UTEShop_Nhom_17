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
           const heartIcon = button.querySelector('i.fa-heart');
           if (data.action === 'removed') {
                if (window.location.pathname.includes('/user/favorites')) {
                    // Remove the product card from the DOM
                    const productCard = button.closest('.col');
                    if (productCard) {
                        productCard.remove();
                    }
                } else {
                    // Update button state
                    button.classList.remove('active');
                    if (heartIcon) {
                        heartIcon.classList.replace('fas', 'far');
                    }
                }
            } else { // added
                // Update button state
                button.classList.add('active');
                if (heartIcon) {
                    heartIcon.classList.replace('far', 'fas');
                }
            }
           // Hiển thị thông báo thành công
           showNotification(data.message, data.action === 'removed' ? 'info' : 'success');
       } else {
           showNotification(data.message, 'danger');
       }
   })
   .catch(error => {
       console.error('Error:', error);
       showNotification('Đã có lỗi xảy ra. Vui lòng thử lại sau.', 'danger');
   });
}
