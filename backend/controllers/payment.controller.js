const { Payment, Order } = require('../models');
const { successResponse } = require('../utils/helpers');

const processPayment = async (req, res, next) => {
    try {
        const { order_id, method, card_number } = req.body;
        const order = await Order.findOne({ where: { id: order_id, user_id: req.user.id } });
        if (!order) return res.status(404).json({ success: false, message: 'Order not found' });

        const transaction_id = 'TXN-' + Math.random().toString(36).substring(2, 10).toUpperCase();
        
        // Mock payment verification (always succeeds unless card ends in '0000')
        const status = (card_number && card_number.endsWith('0000')) ? 'failed' : 'completed';

        const payment = await Payment.create({
            order_id,
            method: method || 'credit_card',
            transaction_id,
            amount: order.total,
            status,
            paid_at: status === 'completed' ? new Date() : null
        });

        if (status === 'completed') {
            await order.update({ status: 'confirmed' });
        }

        successResponse(res, { data: payment }, status === 'completed' ? 'Payment successful' : 'Payment failed', status === 'completed' ? 201 : 400);
    } catch (err) { next(err); }
};

const getPaymentStatus = async (req, res, next) => {
    try {
        const payment = await Payment.findOne({
            where: { order_id: req.params.orderId },
            include: [{ model: Order, as: 'order', attributes: ['id', 'user_id', 'status'] }]
        });

        if (!payment) return res.status(404).json({ success: false, message: 'Payment record not found' });
        if (payment.order.user_id !== req.user.id && req.user.role.name !== 'admin') {
            return res.status(403).json({ success: false, message: 'Forbidden' });
        }

        successResponse(res, { data: payment });
    } catch (err) { next(err); }
};

const getAdminPayments = async (req, res, next) => {
    try {
        const payments = await Payment.findAll({
            include: [{ model: Order, as: 'order', attributes: ['id', 'order_number'] }],
            order: [['created_at', 'DESC']]
        });
        successResponse(res, { data: payments });
    } catch (err) { next(err); }
};

module.exports = { processPayment, getPaymentStatus, getAdminPayments };
