const { Order, OrderItem, Cart, CartItem, Product, Inventory, Coupon, Address, Payment } = require('../models');
const { generateOrderNumber, successResponse } = require('../utils/helpers');
const mailService = require('../services/mail.service');

const createOrder = async (req, res, next) => {
    try {
        const { shipping_address_id, billing_address_id, coupon_code, notes } = req.body;

        const cart = await Cart.findOne({
            where: { user_id: req.user.id },
            include: [{ model: CartItem, as: 'items', include: [{ model: Product, as: 'product' }] }]
        });

        if (!cart || !cart.items || cart.items.length === 0) {
            return res.status(400).json({ success: false, message: 'Your shopping cart is empty' });
        }

        // Validate Addresses
        const shippingAddr = await Address.findByPk(shipping_address_id);
        if (!shippingAddr || shippingAddr.user_id !== req.user.id) {
            return res.status(400).json({ success: false, message: 'Invalid shipping address' });
        }

        // Subtotal calculation
        let subtotal = 0;
        for (const item of cart.items) {
            const product = item.product;
            subtotal += (product.discount_price || product.price) * item.quantity;

            // Check inventory
            const stock = await Inventory.findOne({ where: { product_id: product.id } });
            if (!stock || stock.quantity < item.quantity) {
                return res.status(400).json({
                    success: false,
                    message: `Product "${product.name}" has insufficient stock. Available: ${stock ? stock.quantity : 0}`
                });
            }
        }

        // Handle Coupon
        let discount = 0;
        let coupon = null;
        if (coupon_code) {
            coupon = await Coupon.findOne({ where: { code: coupon_code, is_active: true } });
            if (coupon) {
                const now = new Date();
                const validTime = (!coupon.starts_at || new Date(coupon.starts_at) <= now) &&
                                  (!coupon.expires_at || new Date(coupon.expires_at) >= now);
                const withinLimit = !coupon.usage_limit || coupon.used_count < coupon.usage_limit;

                if (validTime && withinLimit && subtotal >= parseFloat(coupon.min_order)) {
                    if (coupon.type === 'percentage') {
                        discount = (subtotal * parseFloat(coupon.value)) / 100;
                        if (coupon.max_discount && discount > parseFloat(coupon.max_discount)) {
                            discount = parseFloat(coupon.max_discount);
                        }
                    } else {
                        discount = parseFloat(coupon.value);
                    }
                }
            }
        }

        // Fixed calculations
        const tax = subtotal * 0.05; // 5% tax
        const shipping_cost = subtotal > 500 ? 0 : 30; // Free shipping above 500 QAR, otherwise 30 QAR
        const total = subtotal + tax + shipping_cost - discount;

        // Create Order
        const order = await Order.create({
            user_id: req.user.id,
            order_number: generateOrderNumber(),
            subtotal,
            tax,
            shipping_cost,
            discount,
            total,
            shipping_address_id,
            billing_address_id: billing_address_id || shipping_address_id,
            notes,
            coupon_id: coupon ? coupon.id : null
        });

        // Create OrderItems & update Inventory
        for (const item of cart.items) {
            const finalPrice = item.product.discount_price || item.product.price;
            await OrderItem.create({
                order_id: order.id,
                product_id: item.product_id,
                quantity: item.quantity,
                unit_price: finalPrice,
                total: finalPrice * item.quantity
            });

            // Decrement Stock
            const stock = await Inventory.findOne({ where: { product_id: item.product_id } });
            if (stock) {
                const newQty = stock.quantity - item.quantity;
                await stock.update({ quantity: newQty });

                // Low stock alert email triggers asynchronously if stock drops below threshold
                if (newQty <= stock.low_stock_threshold) {
                    mailService.sendLowStockAlert(item.product, stock).catch(err => console.error('Low stock alert error:', err));
                }
            }

            // Increment product total sales
            await item.product.increment('total_sold', { by: item.quantity });
        }

        // Increment coupon use count
        if (coupon) {
            await coupon.increment('used_count');
        }

        // Clear Cart
        await CartItem.destroy({ where: { cart_id: cart.id } });

        // Send order confirmation mail
        mailService.sendOrderConfirmation(req.user, order).catch(err => console.error('Order confirmation email error:', err));

        successResponse(res, { data: order }, 'Order created successfully', 201);
    } catch (err) { next(err); }
};

const getMyOrders = async (req, res, next) => {
    try {
        const orders = await Order.findAll({
            where: { user_id: req.user.id },
            order: [['created_at', 'DESC']]
        });
        successResponse(res, { data: orders });
    } catch (err) { next(err); }
};

const getOrderDetails = async (req, res, next) => {
    try {
        const order = await Order.findOne({
            where: { id: req.params.id, user_id: req.user.id },
            include: [
                { model: OrderItem, as: 'items', include: [{ model: Product, as: 'product' }] },
                { model: Address, as: 'shippingAddress' },
                { model: Payment, as: 'payment' }
            ]
        });
        if (!order) return res.status(404).json({ success: false, message: 'Order not found' });
        successResponse(res, { data: order });
    } catch (err) { next(err); }
};

const cancelOrder = async (req, res, next) => {
    try {
        const order = await Order.findOne({ where: { id: req.params.id, user_id: req.user.id } });
        if (!order) return res.status(404).json({ success: false, message: 'Order not found' });
        if (order.status !== 'pending') {
            return res.status(400).json({ success: false, message: 'Only pending orders can be cancelled' });
        }

        await order.update({ status: 'cancelled' });

        // Restore Stock
        const items = await OrderItem.findAll({ where: { order_id: order.id } });
        for (const item of items) {
            const stock = await Inventory.findOne({ where: { product_id: item.product_id } });
            if (stock) {
                await stock.increment('quantity', { by: item.quantity });
            }
        }

        successResponse(res, { data: order }, 'Order cancelled');
    } catch (err) { next(err); }
};

const getAdminOrders = async (req, res, next) => {
    try {
        const { status } = req.query;
        const where = {};
        if (status) where.status = status;

        const orders = await Order.findAll({
            where,
            include: [{ model: require('../models/User'), as: 'user', attributes: ['id', 'name', 'email'] }],
            order: [['created_at', 'DESC']]
        });
        successResponse(res, { data: orders });
    } catch (err) { next(err); }
};

const updateOrderStatus = async (req, res, next) => {
    try {
        const { status, tracking_number, shipping_carrier } = req.body;
        const order = await Order.findByPk(req.params.id, {
            include: [{ model: require('../models/User'), as: 'user' }]
        });
        if (!order) return res.status(404).json({ success: false, message: 'Order not found' });

        const updates = { status };
        if (tracking_number) updates.tracking_number = tracking_number;
        if (shipping_carrier) updates.shipping_carrier = shipping_carrier;

        if (status === 'shipped') updates.shipped_at = new Date();
        if (status === 'delivered') updates.delivered_at = new Date();

        await order.update(updates);

        // Send status update email
        if (order.user) {
            mailService.sendOrderStatusUpdate(order.user, order).catch(err => console.error('Status update email error:', err));
        }

        successResponse(res, { data: order }, 'Order status updated');
    } catch (err) { next(err); }
};

module.exports = { createOrder, getMyOrders, getOrderDetails, cancelOrder, getAdminOrders, updateOrderStatus };
