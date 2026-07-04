const { Product, Category, Brand, Image, Inventory, Review } = require('../models');
const { Op } = require('sequelize');
const { createSlug, paginate, paginationMeta, successResponse } = require('../utils/helpers');

// @desc    Get all products
// @route   GET /api/v1/products
const getProducts = async (req, res, next) => {
    try {
        const { page, limit, offset } = paginate(req.query);
        const where = { is_active: true };

        if (req.query.category_id) where.category_id = req.query.category_id;
        if (req.query.brand_id) where.brand_id = req.query.brand_id;
        if (req.query.featured) where.featured = req.query.featured === 'true';
        if (req.query.best_selling) where.best_selling = req.query.best_selling === 'true';
        if (req.query.min_price || req.query.max_price) {
            where.price = {};
            if (req.query.min_price) where.price[Op.gte] = parseFloat(req.query.min_price);
            if (req.query.max_price) where.price[Op.lte] = parseFloat(req.query.max_price);
        }

        let order = [['created_at', 'DESC']];
        if (req.query.sort === 'price_asc') order = [['price', 'ASC']];
        if (req.query.sort === 'price_desc') order = [['price', 'DESC']];
        if (req.query.sort === 'name') order = [['name', 'ASC']];
        if (req.query.sort === 'popular') order = [['total_sold', 'DESC']];

        const { count, rows } = await Product.findAndCountAll({
            where,
            include: [
                { model: Category, as: 'category', attributes: ['id', 'name', 'slug'] },
                { model: Brand, as: 'brand', attributes: ['id', 'name', 'slug'] },
                { model: Image, as: 'images', attributes: ['id', 'url', 'alt_text', 'is_primary'], order: [['position', 'ASC']] },
                { model: Inventory, as: 'inventory', attributes: ['quantity', 'low_stock_threshold'] }
            ],
            order,
            limit,
            offset,
            distinct: true
        });

        successResponse(res, {
            data: rows,
            pagination: paginationMeta(count, page, limit)
        });
    } catch (err) {
        next(err);
    }
};

// @desc    Get single product
// @route   GET /api/v1/products/:id
const getProduct = async (req, res, next) => {
    try {
        const product = await Product.findByPk(req.params.id, {
            include: [
                { model: Category, as: 'category' },
                { model: Brand, as: 'brand' },
                { model: Image, as: 'images', order: [['position', 'ASC']] },
                { model: Inventory, as: 'inventory' },
                { model: Review, as: 'reviews', where: { is_approved: true }, required: false, limit: 10 }
            ]
        });
        if (!product) {
            return res.status(404).json({ success: false, message: 'Product not found' });
        }

        // Increment view count
        await product.increment('view_count');

        successResponse(res, { data: product });
    } catch (err) {
        next(err);
    }
};

// @desc    Create product
// @route   POST /api/v1/products
const createProduct = async (req, res, next) => {
    try {
        const { name, description, price, discount_price, sku, category_id, brand_id,
                featured, best_selling, top_rated, meta_title, meta_description, quantity } = req.body;

        const slug = createSlug(name) + '-' + Date.now().toString(36);

        const product = await Product.create({
            name, slug, description, price, discount_price, sku,
            category_id, brand_id, featured, best_selling, top_rated,
            meta_title, meta_description
        });

        // Create inventory
        await Inventory.create({
            product_id: product.id,
            quantity: quantity || 0,
            low_stock_threshold: req.body.low_stock_threshold || 5
        });

        // Handle uploaded images
        if (req.files && req.files.length > 0) {
            const images = req.files.map((file, index) => ({
                product_id: product.id,
                url: `/uploads/${file.filename}`,
                alt_text: name,
                is_primary: index === 0,
                position: index
            }));
            await Image.bulkCreate(images);
        }

        const fullProduct = await Product.findByPk(product.id, {
            include: [
                { model: Category, as: 'category' },
                { model: Brand, as: 'brand' },
                { model: Image, as: 'images' },
                { model: Inventory, as: 'inventory' }
            ]
        });

        successResponse(res, { data: fullProduct }, 'Product created', 201);
    } catch (err) {
        next(err);
    }
};

// @desc    Update product
// @route   PUT /api/v1/products/:id
const updateProduct = async (req, res, next) => {
    try {
        const product = await Product.findByPk(req.params.id);
        if (!product) {
            return res.status(404).json({ success: false, message: 'Product not found' });
        }

        const updates = { ...req.body };
        if (updates.name && updates.name !== product.name) {
            updates.slug = createSlug(updates.name) + '-' + Date.now().toString(36);
        }
        delete updates.id;

        await product.update(updates);

        // Update inventory if quantity provided
        if (req.body.quantity !== undefined) {
            const inventory = await Inventory.findOne({ where: { product_id: product.id } });
            if (inventory) {
                await inventory.update({ quantity: req.body.quantity });
            }
        }

        const fullProduct = await Product.findByPk(product.id, {
            include: [
                { model: Category, as: 'category' },
                { model: Brand, as: 'brand' },
                { model: Image, as: 'images' },
                { model: Inventory, as: 'inventory' }
            ]
        });

        successResponse(res, { data: fullProduct }, 'Product updated');
    } catch (err) {
        next(err);
    }
};

// @desc    Delete product (soft)
// @route   DELETE /api/v1/products/:id
const deleteProduct = async (req, res, next) => {
    try {
        const product = await Product.findByPk(req.params.id);
        if (!product) {
            return res.status(404).json({ success: false, message: 'Product not found' });
        }
        await product.update({ is_active: false });
        successResponse(res, {}, 'Product deleted');
    } catch (err) {
        next(err);
    }
};

// @desc    Upload product images
// @route   POST /api/v1/products/:id/images
const uploadImages = async (req, res, next) => {
    try {
        const product = await Product.findByPk(req.params.id);
        if (!product) {
            return res.status(404).json({ success: false, message: 'Product not found' });
        }

        if (!req.files || req.files.length === 0) {
            return res.status(400).json({ success: false, message: 'No images uploaded' });
        }

        const existingCount = await Image.count({ where: { product_id: product.id } });
        const images = req.files.map((file, index) => ({
            product_id: product.id,
            url: `/uploads/${file.filename}`,
            alt_text: product.name,
            is_primary: existingCount === 0 && index === 0,
            position: existingCount + index
        }));

        const created = await Image.bulkCreate(images);
        successResponse(res, { data: created }, 'Images uploaded', 201);
    } catch (err) {
        next(err);
    }
};

// @desc    Get featured products
// @route   GET /api/v1/products/featured
const getFeatured = async (req, res, next) => {
    try {
        const limit = parseInt(req.query.limit) || 10;
        const products = await Product.findAll({
            where: { is_active: true, featured: true },
            include: [
                { model: Image, as: 'images', where: { is_primary: true }, required: false },
                { model: Brand, as: 'brand', attributes: ['id', 'name'] }
            ],
            limit,
            order: [['created_at', 'DESC']]
        });
        successResponse(res, { data: products });
    } catch (err) {
        next(err);
    }
};

// @desc    Get best-selling products
// @route   GET /api/v1/products/best-selling
const getBestSelling = async (req, res, next) => {
    try {
        const limit = parseInt(req.query.limit) || 10;
        const products = await Product.findAll({
            where: { is_active: true },
            include: [
                { model: Image, as: 'images', where: { is_primary: true }, required: false },
                { model: Brand, as: 'brand', attributes: ['id', 'name'] }
            ],
            limit,
            order: [['total_sold', 'DESC']]
        });
        successResponse(res, { data: products });
    } catch (err) {
        next(err);
    }
};

module.exports = {
    getProducts, getProduct, createProduct, updateProduct, deleteProduct,
    uploadImages, getFeatured, getBestSelling
};
