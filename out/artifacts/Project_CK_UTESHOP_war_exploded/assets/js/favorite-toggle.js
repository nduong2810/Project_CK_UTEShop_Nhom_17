document.addEventListener('DOMContentLoaded', function () {
    // Find all favorite toggle buttons on the page
    const favoriteButtons = document.querySelectorAll('.favorite-toggle-btn');

    favoriteButtons.forEach(button => {
        button.addEventListener('click', function (event) {
            event.preventDefault(); // Prevent the default link behavior

            const productId = this.dataset.productId;
            const icon = this.querySelector('i');

            // Immediately toggle the icon for better user experience
            const isFavorited = icon.classList.contains('fas'); // 'fas' for solid heart, 'far' for regular
            if (isFavorited) {
                icon.classList.remove('fas', 'fa-heart');
                icon.classList.add('far', 'fa-heart');
                this.classList.remove('active');
            } else {
                icon.classList.remove('far', 'fa-heart');
                icon.classList.add('fas', 'fa-heart');
                this.classList.add('active');
            }

            // Send the request to the server
            fetch(`${contextPath}/user/favorites/toggle`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'X-Requested-With': 'XMLHttpRequest' // Useful for server-side detection of AJAX requests
                },
                body: `maSP=${productId}`
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'success') {
                    // The UI is already updated, so we just confirm.
                    console.log('Favorite status toggled:', data.message);

                    // If on the favorites page, we might want to remove the item from the view
                    if (document.body.classList.contains('page-favorites') && data.action === 'removed') {
                        const productCard = button.closest('.col');
                        if (productCard) {
                            productCard.style.transition = 'opacity 0.5s ease';
                            productCard.style.opacity = '0';
                            setTimeout(() => {
                                productCard.remove();
                                // Check if the container is empty and show a message
                                const container = document.querySelector('.favorite-items-container');
                                if (container && container.children.length === 0) {
                                    const emptyMessage = document.querySelector('.empty-state-favorites');
                                    if(emptyMessage) emptyMessage.style.display = 'block';
                                }
                            }, 500);
                        }
                    }
                } else {
                    // If the server-side action failed, revert the icon change
                    console.error('Failed to toggle favorite:', data.message);
                    if (isFavorited) {
                        icon.classList.remove('far', 'fa-heart');
                        icon.classList.add('fas', 'fa-heart');
                        this.classList.add('active');
                    } else {
                        icon.classList.remove('fas', 'fa-heart');
                        icon.classList.add('far', 'fa-heart');
                        this.classList.remove('active');
                    }
                    // Optionally, show an error message to the user
                    alert(`Lỗi: ${data.message}`);
                }
            })
            .catch(error => {
                console.error('Error during fetch:', error);
                // Revert icon on network error as well
                if (isFavorited) {
                    icon.classList.remove('far', 'fa-heart');
                    icon.classList.add('fas', 'fa-heart');
                    this.classList.add('active');
                } else {
                    icon.classList.remove('fas', 'fa-heart');
                    icon.classList.add('far', 'fa-heart');
                    this.classList.remove('active');
                }
                alert('Đã xảy ra lỗi kết nối. Vui lòng thử lại.');
            });
        });
    });
});
