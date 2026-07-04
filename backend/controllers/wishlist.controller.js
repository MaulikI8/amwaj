const { Wishlist, Product, Image } = require('../models');
const { successResponse } = require('../utils/helpers');

const getWishlist = async (req, res, next) => {
    try {
        const wishlist = await Wishlist.findAll({
            where: { user_id: req.user.id },
            include: [{
                model: Product,
                as: 'product',
                include: [{ model: Image, as: 'images', where: { is_primary: true }, required: false }]
            }]
        });
        successResponse(res, { data: wishlist });
    } catch (err) { next(err); }
};

const addToWishlist = async (req, res, next) => {
    try {
        const { product_id } = req.body;
        const product = await Product.findByPk(product_id);
        if (!product) return res.status(404).json({ success: false, message: 'Product not found' });

        const [item, created] = await Wishlist.findOrCreate({
            where: { user_id: req.user.id, product_id }
        });

        successResponse(
            res, 
            { data: item }, 
            created ? 'Added to wishlist' : 'Product already in wishlist', 
            created ? 201 : 200
        );
    } catch (err) { next(err); }
};

const removeFromWishlist = async (req, res, next) => {
    try {
        const affected = await Wishlist.destroy({
            where: { user_id: req.user.id, product_id: req.params.productId }
        });
        if (!affected) return res.status(404).json({ success: false, message: 'Product not in wishlist' });
        successResponse(res, {}, 'Removed from wishlist');
    } catch (err) { next(err); }
};

const checkWishlist = async (req, res, next) => {
    try {
        const item = await Wishlist.findOne({
            where: { user_id: req.user.id, product_id: req.params.productId }
        });
        successResponse(res, { in_wishlist: !!item });
    } catch (err) { next(err); }
};

module.exports = { getWishlist, addToWishlist, removeFromWishlist, checkWishlist };
