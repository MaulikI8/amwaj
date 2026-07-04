// Local E-commerce Cart, Wishlist, and QuickView System
// This mocks the backend behavior completely inside the client browser.

(function() {
    window.localProducts = [];

    // Load products database on start
    fetch('data/products.json')
        .then(res => res.json())
        .then(data => {
            window.localProducts = data;
            updateNavCart();
            updateWishlistBadges();
        })
        .catch(err => console.error("Error loading products JSON:", err));

    // Cart Helper Functions
    function getCart() {
        return JSON.parse(localStorage.getItem('local_cart') || '[]');
    }

    function saveCart(cart) {
        localStorage.setItem('local_cart', JSON.stringify(cart));
        updateNavCart();
    }

    // Wishlist Helper Functions
    function getWishlist() {
        return JSON.parse(localStorage.getItem('local_wishlist') || '[]');
    }

    function saveWishlist(wishlist) {
        localStorage.setItem('local_wishlist', JSON.stringify(wishlist));
        updateWishlistBadges();
    }

    // Add to cart
    window.addToCartLocal = function(productId, qty) {
        const cart = getCart();
        const existing = cart.find(item => item.id === productId);
        if (existing) {
            existing.qty += qty;
        } else {
            cart.push({ id: productId, qty: qty });
        }
        saveCart(cart);
        
        // Trigger Toastr success notification if library is loaded
        if (window.toastr) {
            const prod = window.localProducts.find(p => p.id === productId);
            const name = prod ? prod.name : "Product";
            toastr.success(`${name} added to cart!`, 'Cart', {
                CloseButton: true,
                ProgressBar: true
            });
        }
    };

    // Remove from cart
    window.removeFromCartLocal = function(productId) {
        let cart = getCart();
        cart = cart.filter(item => item.id !== productId);
        saveCart(cart);
        
        if (window.toastr) {
            toastr.info('Product removed from cart.', 'Cart');
        }
    };

    // Override original addToCart function
    window.addToCart = function(formId = 'add-to-cart-form', redirectToCheckout = false) {
        // Retrieve quantity and product ID from form
        const form = document.getElementById(formId);
        if (!form) return;
        
        const formData = {};
        const elements = form.elements;
        for (let i = 0; i < elements.length; i++) {
            if (elements[i].name) {
                formData[elements[i].name] = elements[i].value;
            }
        }
        
        const productId = formData['id'] || formData['product_id'];
        const qty = parseInt(formData['quantity'] || '1');
        
        if (!productId) {
            // Find product id dynamically in form if it's hidden or input
            const idInput = form.querySelector('input[name="id"], input[name="product_id"]');
            if (idInput) {
                addToCartLocal(idInput.value, qty);
            } else {
                alert("Error: Product ID not found in form.");
            }
        } else {
            addToCartLocal(productId, qty);
        }
        
        // Hide modal if open
        $('#quick-view').modal('hide');
        
        if (redirectToCheckout) {
            alert("Redirecting to checkout... (Mock Checkout Page)");
        }
    };

    // Wishlist functions
    window.addWishlist = function(productId, modalId) {
        const wishlist = getWishlist();
        if (wishlist.includes(productId)) {
            // Remove it (toggle behavior)
            window.removeWishlist(productId, modalId);
            return;
        }
        wishlist.push(productId);
        saveWishlist(wishlist);
        
        // Update wishlist icons on page
        $(`.wishlist_icon_${productId}`).removeClass('fa-heart-o').addClass('fa-heart text-danger');
        
        // Show success modal
        $('#add-wishlist-modal').modal('show');
    };

    window.removeWishlist = function(productId, modalId) {
        let wishlist = getWishlist();
        wishlist = wishlist.filter(id => id !== productId);
        saveWishlist(wishlist);
        
        // Update wishlist icons on page
        $(`.wishlist_icon_${productId}`).removeClass('fa-heart text-danger').addClass('fa-heart-o');
        
        // Show remove modal
        $('#remove-wishlist-modal').modal('show');
    };

    // Update Header Navigation Cart Display
    window.updateNavCart = function() {
        const cart = getCart();
        const cartItemsContainer = document.getElementById('cart_items');
        if (!cartItemsContainer) return;
        
        // Calculate totals
        let totalCount = 0;
        let totalPrice = 0.0;
        const renderedItems = [];
        
        cart.forEach(item => {
            const prod = window.localProducts.find(p => p.id === item.id || p.slug.endsWith(item.id));
            if (prod) {
                totalCount += item.qty;
                const priceVal = parseFloat(prod.price.replace(/[^\d\.]/g, '')) || 0;
                totalPrice += priceVal * item.qty;
                renderedItems.push({
                    id: prod.id,
                    slug: prod.slug,
                    name: prod.name,
                    price: prod.price,
                    image: prod.image,
                    qty: item.qty
                });
            }
        });
        
        // Update badge counters
        const badges = document.querySelectorAll('.navbar-tool-label');
        badges.forEach(b => {
            // Check if it's the cart badge (inside #cart_items) or wishlist badge
            if (b.closest('#cart_items')) {
                b.innerHTML = totalCount;
            }
        });
        
        // Update text price
        const cartText = cartItemsContainer.querySelector('.navbar-tool-text');
        if (cartText) {
            cartText.innerHTML = `<small>My cart</small> QAR ${totalPrice.toFixed(2)}`;
        }
        
        // Update cart dropdown widget
        const dropdownMenu = cartItemsContainer.querySelector('.dropdown-menu');
        if (dropdownMenu) {
            let itemsHtml = '';
            if (renderedItems.length === 0) {
                itemsHtml = `
                    <div class="text-center text-capitalize p-3">
                        <img class="mb-3 mw-100" src="images/empty-cart.svg" alt="" style="width: 50px;">
                        <p class="text-capitalize small mb-0">Your Cart is Empty!</p>
                    </div>
                `;
            } else {
                itemsHtml = `
                    <div class="widget-cart px-3 pt-2 pb-3">
                        <div class="widget-cart-top rounded border-bottom mb-2 pb-2">
                            <h6 class="m-0 small font-weight-bold">Shopping Cart (${totalCount} Items)</h6>
                        </div>
                        <div style="max-height: 250px; overflow-y: auto;">
                            ${renderedItems.map(item => `
                                <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom">
                                    <div class="d-flex align-items-center">
                                        <img src="${item.image}" width="40" height="40" class="mr-2 rounded" style="object-fit: cover;" onerror="this.src='images/image-place-holder.png'">
                                        <div>
                                            <a href="product-detail.html?product=${item.slug}" class="small font-weight-semibold text-dark text-truncate d-block" style="max-width: 120px;">
                                                ${item.name}
                                            </a>
                                            <span class="small text-muted">${item.qty} x ${item.price}</span>
                                        </div>
                                    </div>
                                    <button class="btn btn-link text-danger p-0 border-0" onclick="removeFromCartLocal('${item.id}')">
                                        <i class="czi-close"></i>
                                    </button>
                                </div>
                            `).join('')}
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top">
                            <span class="font-weight-semibold small">Subtotal:</span>
                            <span class="font-weight-bold text-primary">QAR ${totalPrice.toFixed(2)}</span>
                        </div>
                        <div class="mt-3">
                            <a href="shop-cart.html" class="btn btn-primary btn-sm btn-block">View Cart</a>
                        </div>
                    </div>
                `;
            }
            dropdownMenu.innerHTML = itemsHtml;
        }
    };

    // Update Wishlist display
    window.updateWishlistBadges = function() {
        const wishlist = getWishlist();
        const counts = document.querySelectorAll('.countWishlist');
        counts.forEach(c => {
            c.innerHTML = wishlist.length;
        });
        
        // Highlight active wishlist icons on start
        wishlist.forEach(id => {
            $(`.wishlist_icon_${id}`).removeClass('fa-heart-o').addClass('fa-heart text-danger');
        });
    };

    function findProduct(productId) {
        const id = String(productId);
        return window.localProducts.find(prod =>
            prod.id === id ||
            String(prod.numeric_id) === id ||
            prod.slug === id ||
            prod.slug.endsWith(id)
        );
    }

    // Quick View popup renderer
    window.quickView = function(productId) {
        const p = findProduct(productId);
        if (!p) {
            console.error("Product not found for QuickView id:", productId);
            return;
        }

        // Render dynamic quick view HTML
        const modalContainer = document.getElementById('quick-view-modal');
        if (!modalContainer) {
            // Create quick view modal elements if not exists on products pages
            console.warn("quick-view-modal container not found on this page.");
            return;
        }

        modalContainer.innerHTML = `
            <button class="close" type="button" data-dismiss="modal" aria-label="Close" style="position: absolute; right: 15px; top: 10px; z-index: 10;">
                <span aria-hidden="true">&times;</span>
            </button>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-6 col-md-6 mb-3">
                        <div class="d-flex align-items-center justify-content-center p-3 border rounded bg-white">
                            <img src="${p.image}" class="img-fluid" style="max-height: 250px; object-fit: contain;" onerror="this.src='images/image-place-holder.png'">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="product-details">
                            <span class="small text-primary font-weight-bold">${p.brand}</span>
                            <h2 class="h5 font-weight-bold mt-1">${p.name}</h2>
                            <h3 class="h6 text-accent text-primary">${p.price}</h3>
                            
                            <hr class="my-2">
                            <form id="add-to-cart-form" class="mt-3">
                                <input type="hidden" name="id" value="${p.id}">
                                <div class="form-group d-flex align-items-center mb-3">
                                    <div class="mr-3" style="width: 100px;">
                                        <label class="small text-muted mb-1 d-block">Quantity</label>
                                        <div class="input-group input-group-sm">
                                            <div class="input-group-prepend">
                                                <button class="btn btn-outline-secondary px-2" type="button" onclick="const q = document.getElementById('modal-qty'); if(parseInt(q.value) > 1) q.value = parseInt(q.value) - 1;">-</button>
                                            </div>
                                            <input type="text" class="form-control text-center font-weight-bold p-0" id="modal-qty" name="quantity" value="1" readonly>
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary px-2" type="button" onclick="const q = document.getElementById('modal-qty'); q.value = parseInt(q.value) + 1;">+</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex-grow-1 pt-3">
                                        <button class="btn btn-primary btn-block btn-sm" type="button" onclick="addToCart('add-to-cart-form')">
                                            <i class="czi-cart mr-2"></i>Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </form>
                            
                            <div class="d-flex align-items-center">
                                <button class="btn btn-outline-danger btn-sm" type="button" onclick="addWishlist('${p.id}')">
                                    <i class="czi-heart mr-1"></i>Wishlist
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;

        // Open modal
        $('#quick-view').modal('show');
    };
})();
