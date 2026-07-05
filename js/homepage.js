(function () {
    'use strict';

    const API_BASE = '/api/v1';

    $(document).ready(function () {
        loadDynamicSidebarCategories();
        loadDynamicCircularCategories();
        loadDynamicBanners();
        loadDynamicFeaturedProducts();
        loadDynamicLatestAndNewProducts();
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

    // 1.5 DYNAMIC CIRCULAR CATEGORIES ON HOMEPAGE
    function loadDynamicCircularCategories() {
        $.ajax({
            url: `${API_BASE}/categories`,
            success: function (res) {
                const categories = res.data || res;
                const desktopContainer = $('#dynamic-homepage-categories-desktop');
                const mobileContainer = $('#dynamic-homepage-categories-mobile');

                // Render up to 12 top-level categories
                const topCats = categories.filter(c => !c.parent_id).slice(0, 12);

                if (topCats.length === 0) {
                    return; // Keep hardcoded fallback if empty
                }

                // Render desktop grid
                let desktopHtml = '';
                topCats.forEach(cat => {
                    const img = cat.image || 'images/image-place-holder.png';
                    desktopHtml += `
                        <div class="text-center __m-5px __cate-item">
                            <a href="products.html?id=${cat.id}&amp;data_from=category&amp;page=1">
                                <div class="__img">
                                    <img onerror="this.src='images/image-place-holder.png'" src="${img}" alt="${cat.name}">
                                </div>
                                <p class="text-center small mt-2">${cat.name}</p>
                            </a>
                        </div>
                    `;
                });
                if (desktopContainer.length) desktopContainer.html(desktopHtml);

                // Render mobile slider
                if (mobileContainer.length) {
                    mobileContainer.trigger('destroy.owl.carousel');
                    mobileContainer.empty();
                    topCats.forEach(cat => {
                        const img = cat.image || 'images/image-place-holder.png';
                        mobileContainer.append(`
                            <div class="text-center m-0 __cate-item w-100">
                                <a href="products.html?id=${cat.id}&amp;data_from=category&amp;page=1">
                                    <div class="__img mw-100 h-auto">
                                        <img onerror="this.src='images/image-place-holder.png'" src="${img}" alt="${cat.name}">
                                    </div>
                                    <p class="text-center small mt-2">${cat.name}</p>
                                </a>
                            </div>
                        `);
                    });
                    
                    mobileContainer.owlCarousel({
                        loop: topCats.length > 4,
                        autoplay: true,
                        margin: 10,
                        nav: false,
                        dots: false,
                        responsive: {
                            0: { items: 4 },
                            360: { items: 4 },
                            375: { items: 4 },
                            540: { items: 5 },
                            576: { items: 6 }
                        }
                    });
                }
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

    // 4. DYNAMIC LATEST & NEW ARRIVALS & RECOMMENDED PRODUCTS
    function loadDynamicLatestAndNewProducts() {
        $.ajax({
            url: `${API_BASE}/products?limit=100`,
            success: function (res) {
                const products = res.data || res;
                if (products.length === 0) return; // Keep fallbacks if database is empty

                // A. Recommended Product (first featured product, or first product)
                const recommended = products.find(p => p.featured === true || p.featured === 'true' || p.featured === 1) || products[0];
                const recContainer = $('#dynamic-recommended-product');
                if (recContainer.length && recommended) {
                    const slugStr = recommended.slug || recommended.id;
                    const priceVal = parseFloat(recommended.price) || 0;
                    const img = (recommended.images && recommended.images.length > 0) ? recommended.images[0].url : (recommended.image || 'images/image-place-holder.png');
                    
                    recContainer.html(`
                        <div class="d-flex justify-content-center align-items-center __pt-20 __m-20-r">
                            <div class="position-relative">
                                <img src="${img}" onerror="this.src='images/image-place-holder.png'" alt="${recommended.name}">
                            </div>
                        </div>
                        <div class="__i-1 bg-transparent text-center mb-0">
                            <div class="__p-20px px-0 pb-0">
                                <h6 class="font-semibold pt-2">${recommended.name}</h6>
                                <div class="mb-4 pt-1 d-flex flex-wrap justify-content-center align-items-center text-center gap-8">
                                    <span class="text-accent __text-22px text-dark">
                                        QAR ${priceVal.toFixed(2)}
                                    </span>
                                </div>
                                <button class="btn btn--primary font-bold px-4 rounded-10 text-uppercase"
                                    onclick="location.href='product-detail.html?product=${encodeURIComponent(slugStr)}'">
                                    Buy now
                                </button>
                            </div>
                        </div>
                    `);
                }

                // B. Latest Products (slice first 8)
                const latestContainer = $('#dynamic-latest-products');
                if (latestContainer.length) {
                    let latestHtml = '';
                    products.slice(0, 8).forEach(p => {
                        const slugStr = p.slug || p.id;
                        const priceVal = parseFloat(p.price) || 0;
                        const img = (p.images && p.images.length > 0) ? p.images[0].url : (p.image || 'images/image-place-holder.png');

                        latestHtml += `
                            <div class="col-xl-3 col-sm-4 col-md-6 col-lg-4 col-6">
                                <div>
                                    <div class="product-single-hover style--card">
                                        <div class="overflow-hidden position-relative">
                                            <div class="inline_product clickable d-flex justify-content-center">
                                                <div class="p-10px pb-0">
                                                    <a href="product-detail.html?product=${encodeURIComponent(slugStr)}" class="w-100">
                                                        <img src="${img}" onerror="this.src='images/image-place-holder.png'" alt="${p.name}">
                                                    </a>
                                                </div>
                                                <div class="quick-view">
                                                    <a class="btn-circle stopPropagation" href="javascript:" onclick="quickView('${p.id}')">
                                                        <i class="czi-eye align-middle"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="single-product-details">
                                                <div class="text-center">
                                                    <a href="product-detail.html?product=${encodeURIComponent(slugStr)}" class="text-truncate d-block">
                                                        ${p.name}
                                                    </a>
                                                </div>
                                                <div class="justify-content-between text-center">
                                                    <div class="product-price text-center d-flex flex-wrap justify-content-center align-items-center gap-8">
                                                        <span class="text-accent text-dark font-weight-bold">
                                                            QAR ${priceVal.toFixed(2)}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `;
                    });
                    latestContainer.html(latestHtml);
                }

                // C. New Arrivals (slice first 8 inside owl carousel)
                const newArrivalsContainer = $('#dynamic-new-arrivals');
                if (newArrivalsContainer.length) {
                    newArrivalsContainer.trigger('destroy.owl.carousel');
                    newArrivalsContainer.empty();

                    products.slice(0, 8).forEach(p => {
                        const slugStr = p.slug || p.id;
                        const priceVal = parseFloat(p.price) || 0;
                        const img = (p.images && p.images.length > 0) ? p.images[0].url : (p.image || 'images/image-place-holder.png');

                        newArrivalsContainer.append(`
                            <div class="flash_deal_product rtl" style="cursor: pointer;" onclick="location.href='product-detail.html?product=${encodeURIComponent(slugStr)}'">
                                <div class="d-flex">
                                    <div class="d-flex align-items-center justify-content-center" style="padding-left:12px;padding-block:12px;">
                                        <div class="flash-deals-background-image">
                                            <img class="__img-125px" src="${img}" onerror="this.src='images/image-place-holder.png'" alt="${p.name}" />
                                        </div>
                                    </div>
                                    <div class="flash_deal_product_details pl-3 pr-3 pr-1 d-flex mt-3">
                                        <div>
                                            <div>
                                                <a href="product-detail.html?product=${encodeURIComponent(slugStr)}" class="flash-product-title text-capitalize fw-semibold text-truncate d-block">
                                                    ${p.name}
                                                </a>
                                            </div>
                                            <div class="d-flex flex-wrap gap-8 align-items-center row-gap-0">
                                                <span class="flash-product-price text-dark fw-semibold">
                                                    QAR ${priceVal.toFixed(2)}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `);
                    });

                    newArrivalsContainer.owlCarousel({
                        loop: products.length > 3,
                        autoplay: true,
                        margin: 20,
                        nav: true,
                        navText: ["<i class='czi-arrow-left'></i>", "<i class='czi-arrow-right'></i>"],
                        dots: false,
                        responsive: {
                            0: { items: 1 },
                            576: { items: 2 },
                            768: { items: 2 },
                            992: { items: 3 }
                        }
                    });
                }
            }
        });
    }

})();
