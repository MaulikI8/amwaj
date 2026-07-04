const { Review, Product, User } = require('../models');
const { successResponse } = require('../utils/helpers');

const getReviews = async (req, res, next) => {
    try {
        const reviews = await Review.findAll({
            where: { product_id: req.params.productId, is_approved: true },
            include: [{ model: User, as: 'user', attributes: ['id', 'name', 'avatar'] }],
            order: [['created_at', 'DESC']]
        });
        successResponse(res, { data: reviews });
    } catch (err) { next(err); }
};

const createReview = async (req, res, next) => {
    try {
        const { product_id, rating, comment } = req.body;
        const product = await Product.findByPk(product_id);
        if (!product) return res.status(404).json({ success: false, message: 'Product not found' });

        const review = await Review.create({
            user_id: req.user.id,
            product_id,
            rating,
            comment,
            is_approved: false // Requires admin moderation
        });

        successResponse(res, { data: review }, 'Review submitted and pending approval', 201);
    } catch (err) { next(err); }
};

const getAdminPendingReviews = async (req, res, next) => {
    try {
        const reviews = await Review.findAll({
            where: { is_approved: false },
            include: [
                { model: User, as: 'user', attributes: ['id', 'name', 'email'] },
                { model: Product, as: 'product', attributes: ['id', 'name', 'slug'] }
            ]
        });
        successResponse(res, { data: reviews });
    } catch (err) { next(err); }
};

const approveReview = async (req, res, next) => {
    try {
        const review = await Review.findByPk(req.params.id);
        if (!review) return res.status(404).json({ success: false, message: 'Review not found' });
        
        await review.update({ is_approved: req.body.approve !== false });

        // Update average product rating if approved
        if (review.is_approved) {
            const product = await Product.findByPk(review.product_id);
            if (product) {
                const ratings = await Review.findAll({
                    where: { product_id: product.id, is_approved: true },
                    attributes: ['rating']
                });
                const total = ratings.reduce((sum, r) => sum + r.rating, 0);
                const avg = ratings.length > 0 ? (total / ratings.length).toFixed(1) : 0;
                
                // If avg is high, flag it as top rated
                await product.update({ top_rated: parseFloat(avg) >= 4.5 });
            }
        }

        successResponse(res, { data: review }, 'Review moderated');
    } catch (err) { next(err); }
};

module.exports = { getReviews, createReview, getAdminPendingReviews, approveReview };
