const { Cart, CartItem, Product, Image } = require('../models');
const { successResponse } = require('../utils/helpers');

const getCart = async (req, res, next) => {
    try {
        let cart = await Cart.findOne({
            where: { user_id: req.user.id },
            include: [{
                model: CartItem,
                as: 'items',
                include: [{
                    model: Product,
                    as: 'product',
                    include: [{ model: Image, as: 'images', where: { is_primary: true }, required: false }]
                }]
            }]
        });

        if (!cart) {
            cart = await Cart.create({ user_id: req.user.id });
            cart = await Cart.findByPk(cart.id, {
                include: [{ model: CartItem, as: 'items' }]
            });
        }

        successResponse(res, { data: cart });
    } catch (err) { next(err); }
};

const addItem = async (req, res, next) => {
    try {
        const { product_id, quantity } = req.body;
        const product = await Product.findByPk(product_id);
        if (!product) return res.status(404).json({ success: false, message: 'Product not found' });

        let cart = await Cart.findOne({ where: { user_id: req.user.id } });
        if (!cart) cart = await Cart.create({ user_id: req.user.id });

        let cartItem = await CartItem.findOne({
            where: { cart_id: cart.id, product_id }
        });

        const qtyToAdd = parseInt(quantity) || 1;
        const unit_price = product.discount_price || product.price;

        if (cartItem) {
            await cartItem.update({ quantity: cartItem.quantity + qtyToAdd, unit_price });
        } else {
            cartItem = await CartItem.create({
                cart_id: cart.id,
                product_id,
                quantity: qtyToAdd,
                unit_price
            });
        }

        successResponse(res, { data: cartItem }, 'Item added to cart', 201);
    } catch (err) { next(err); }
};

const updateItem = async (req, res, next) => {
    try {
        const { quantity } = req.body;
        const cartItem = await CartItem.findByPk(req.params.id);
        if (!cartItem) return res.status(404).json({ success: false, message: 'Cart item not found' });

        const cart = await Cart.findByPk(cartItem.cart_id);
        if (cart.user_id !== req.user.id) {
            return res.status(403).json({ success: false, message: 'Forbidden' });
        }

        const newQty = parseInt(quantity);
        if (newQty <= 0) {
            await cartItem.destroy();
            return successResponse(res, {}, 'Item removed from cart');
        }

        await cartItem.update({ quantity: newQty });
        successResponse(res, { data: cartItem }, 'Cart updated');
    } catch (err) { next(err); }
};

const removeItem = async (req, res, next) => {
    try {
        const cartItem = await CartItem.findByPk(req.params.id);
        if (!cartItem) return res.status(404).json({ success: false, message: 'Cart item not found' });

        const cart = await Cart.findByPk(cartItem.cart_id);
        if (cart.user_id !== req.user.id) {
            return res.status(403).json({ success: false, message: 'Forbidden' });
        }

        await cartItem.destroy();
        successResponse(res, {}, 'Item removed from cart');
    } catch (err) { next(err); }
};

const clearCart = async (req, res, next) => {
    try {
        const cart = await Cart.findOne({ where: { user_id: req.user.id } });
        if (cart) {
            await CartItem.destroy({ where: { cart_id: cart.id } });
        }
        successResponse(res, {}, 'Cart cleared');
    } catch (err) { next(err); }
};

module.exports = { getCart, addItem, updateItem, removeItem, clearCart };
