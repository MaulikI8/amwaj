const { Order, User, Product, OrderItem, Cart, CartItem, Image } = require('../models');
const { successResponse } = require('../utils/helpers');
const { fn, col } = require('sequelize');

const getOverview = async (req, res, next) => {
    try {
        // Total Revenue (completed payments/orders)
        const revenueResult = await Order.findAll({
            where: { status: ['confirmed', 'processing', 'shipped', 'delivered', 'completed'] },
            attributes: [[fn('SUM', col('total')), 'total_revenue']]
        });
        const totalRevenue = parseFloat(revenueResult[0].getDataValue('total_revenue')) || 0;

        // Total Orders
        const totalOrders = await Order.count();

        // Total Customers
        const totalCustomers = await User.count({
            include: [{ model: require('../models/Role'), as: 'role', where: { name: 'customer' } }]
        });

        // Conversion Rates (Completed orders / Carts created)
        const totalCarts = await Cart.count();
        const conversionRate = totalCarts > 0 ? ((totalOrders / totalCarts) * 100).toFixed(2) : '0.00';

        // Best Sellers (Top products sold)
        const bestSellers = await Product.findAll({
            where: { is_active: true },
            attributes: ['id', 'name', 'slug', 'price', 'total_sold'],
            include: [{ model: Image, as: 'images', where: { is_primary: true }, attributes: ['url'], required: false }],
            order: [['total_sold', 'DESC']],
            limit: 5
        });

        // Recent Orders
        const recentOrders = await Order.findAll({
            include: [{ model: User, as: 'user', attributes: ['id', 'name'] }],
            limit: 5,
            order: [['created_at', 'DESC']]
        });

        successResponse(res, {
            data: {
                metrics: {
                    totalRevenue: `QAR ${totalRevenue.toFixed(2)}`,
                    totalOrders,
                    totalCustomers,
                    conversionRate: `${conversionRate}%`
                },
                bestSellers,
                recentOrders
            }
        });
    } catch (err) { next(err); }
};

const getSalesChartData = async (req, res, next) => {
    try {
        // Aggregates sales revenue grouped by day/date for the past 30 days
        const salesData = await Order.findAll({
            where: {
                status: ['confirmed', 'processing', 'shipped', 'delivered', 'completed'],
                created_at: {
                    [require('sequelize').Op.gte]: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000)
                }
            },
            attributes: [
                [fn('date', col('created_at')), 'date'],
                [fn('SUM', col('total')), 'revenue'],
                [fn('COUNT', col('id')), 'orders']
            ],
            group: [fn('date', col('created_at'))],
            order: [[fn('date', col('created_at')), 'ASC']]
        });

        successResponse(res, { data: salesData });
    } catch (err) { next(err); }
};

module.exports = { getOverview, getSalesChartData };
