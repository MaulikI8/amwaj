(function () {
    'use strict';

    const API_BASE = 'http://localhost:5000/api/v1';

    $(document).ready(function () {
        loadDynamicSidebarCategories();
        loadDynamicBanners();
        loadDynamicFeaturedProducts();
    });

    // 1. DYNAMIC CATEGORIES IN SIDEBAR
    function loadDynamicSidebarCategories() {
        $.ajax({
            url: `${API_BASE}/categories`,
            success: function (res) {
                const categories = res.data || res;
                const menuContainer = $('#dynamic-category-menu');
                if (!menuContainer.length) return;

                if (categories.length === 0) {
                    menuContainer.html('<li class="p-3 text-center text-muted small">No categories configured</li>');
                    return;
                }

                let html = '';
                // Render up to 10 top-level categories
                categories.slice(0, 10).forEach(cat => {
                    if (cat.parent_id) return; // Skip subcategories at root level

                    const subs = cat.subcategories || cat.children || [];
                    const hasSubs = subs.length > 0;
                    
                    html += `
                        <li>
                            <a href="products.html?id=${cat.id}&amp;data_from=category&amp;page=1">${cat.name}</a>
                    `;

                    if (hasSubs) {
                        html += `
                            <div class="mega_menu z-2">
                        `;
                        subs.forEach(sub => {
                            html += `
                                <div class="mega_menu_inner">
                                    <h6><a href="products.html?id=${sub.id}&amp;data_from=category&amp;page=1">${sub.name}</a></h6>
                                </div>
                            `;
                        });
                        html += `
                            </div>
                        `;
                    }
                    html += '</li>';
                });

                html += '<li class="text-center"><a href="products.html" class="text-primary font-weight-bold justify-content-center text-capitalize">View all</a></li>';
                menuContainer.html(html);
            },
            error: function () {
                // Fallback to static category menu layout if API fails
            }
        });
    }

    // 2. DYNAMIC SLIDER BANNERS
    function loadDynamicBanners() {
        $.ajax({
            url: `${API_BASE}/banners`,
            success: function (res) {
                const banners = res.data || res;
                const sliderContainer = $('.hero-slider');
                if (!sliderContainer.length) return;

                // Empty original hardcoded static slides
                // We destroy the carousel first if initialized, or just replace HTML and init
                sliderContainer.trigger('destroy.owl.carousel');
                sliderContainer.empty();

                if (banners.length === 0) {
                    // Default fallback slides if database is empty
                    sliderContainer.append(`
                        <a href="/products" class="d-block">
                            <img class="w-100 __slide-img" src="images/2026-05-25-6a1443c7a1f73.webp" onerror="this.src='images/image-place-holder.png'" alt="Default Slide 1">
                        </a>
                        <a href="/products" class="d-block">
                            <img class="w-100 __slide-img" src="images/2026-05-25-6a144077d5971.webp" onerror="this.src='images/image-place-holder.png'" alt="Default Slide 2">
                        </a>
                    `);
                } else {
                    banners.forEach(b => {
                        const img = b.image ? b.image : 'images/image-place-holder.png';
                        sliderContainer.append(`
                            <a href="${b.link || '/products'}" class="d-block">
                                <img class="w-100 __slide-img" src="${img}" onerror="this.src='images/image-place-holder.png'" alt="${b.title}">
                            </a>
                        `);
                    });
                }

                // Re-initialize Owl Carousel slider
                sliderContainer.owlCarousel({
                    loop: banners.length > 1,
                    autoplay: true,
                    margin: 20,
                    nav: true,
                    navText: ["<i class='czi-arrow-left'></i>", "<i class='czi-arrow-right'></i>"],
                    dots: true,
                    autoplayHoverPause: true,
                    items: 1
                });
            },
            error: function () {
                // Fallback owlCarousel init
                $('.hero-slider').owlCarousel({
                    loop: false,
                    autoplay: true,
                    margin: 20,
                    nav: true,
                    navText: ["<i class='czi-arrow-left'></i>", "<i class='czi-arrow-right'></i>"],
                    dots: true,
                    autoplayHoverPause: true,
                    items: 1
                });
            }
        });
    }

    // 3. DYNAMIC FEATURED PRODUCTS
    function loadDynamicFeaturedProducts() {
        $.ajax({
            url: `${API_BASE}/products?limit=100`,
            success: function (res) {
                const products = res.data || res;
                const featuredContainer = $('#featured_products_list');
                if (!featuredContainer.length) return;

                featuredContainer.trigger('destroy.owl.carousel');
                featuredContainer.empty();

                // Filter products marked as featured
                const featuredProducts = products.filter(p => p.featured === true || p.featured === 'true' || p.featured === 1);

                if (featuredProducts.length === 0) {
                    // Fallback: If database is completely empty and they start fresh, display empty catalog message
                    featuredContainer.html('<div class="col-12 text-center py-4 text-muted">No featured products available. Add products in admin panel.</div>');
                    return;
                }

                featuredProducts.forEach(p => {
                    const slugStr = p.slug || p.id;
                    const priceVal = parseFloat(p.price) || 0;
                    const img = (p.images && p.images.length > 0) ? p.images[0].url : (p.image || 'images/image-place-holder.png');

                    featuredContainer.append(`
                        <div>
                            <div class="product-single-hover shadow-none rtl">
                                <div class="overflow-hidden position-relative">
                                    <div class="inline_product clickable">
                                        <a href="product-detail.html?product=${encodeURIComponent(slugStr)}">
                                            <img src="${img}" onerror="this.src='images/image-place-holder.png'">
                                        </a>
                                        <div class="quick-view">
                                            <a class="btn-circle stopPropagation" href="javascript:" onclick="quickView('${p.id}')">
                                                <i class="czi-eye align-middle"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="single-product-details">
                                        <div>
                                            <a href="product-detail.html?product=${encodeURIComponent(slugStr)}" class="text-capitalize fw-semibold text-truncate d-block">
                                                ${p.name}
                                            </a>
                                        </div>
                                        <div class="justify-content-between">
                                            <div class="product-price">
                                                <span class="text-accent text-dark font-weight-bold">
                                                    QAR ${priceVal.toFixed(2)}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `);
                });

                // Re-initialize Owl Carousel for featured products
                featuredContainer.owlCarousel({
                    loop: featuredProducts.length > 4,
                    autoplay: true,
                    margin: 20,
                    nav: true,
                    navText: ["<i class='czi-arrow-left'></i>", "<i class='czi-arrow-right'></i>"],
                    dots: false,
                    autoplayHoverPause: true,
                    responsive: {
                        0: { items: 2 },
                        576: { items: 2 },
                        768: { items: 3 },
                        992: { items: 4 },
                        1200: { items: 4 }
                    }
                });
            },
            error: function () {
                // Initialize fallback owlCarousel anyway
                $('#featured_products_list').owlCarousel({
                    loop: false,
                    autoplay: true,
                    margin: 20,
                    nav: true,
                    navText: ["<i class='czi-arrow-left'></i>", "<i class='czi-arrow-right'></i>"],
                    dots: false,
                    autoplayHoverPause: true,
                    responsive: {
                        0: { items: 2 },
                        576: { items: 2 },
                        768: { items: 3 },
                        992: { items: 4 }
                    }
                });
            }
        });
    }

})();
