const { Inventory, Product } = require('../models');
const { successResponse } = require('../utils/helpers');

const getInventory = async (req, res, next) => {
    try {
        const inventory = await Inventory.findAll({
            include: [{ model: Product, as: 'product', attributes: ['id', 'name', 'sku'] }]
        });
        successResponse(res, { data: inventory });
    } catch (err) { next(err); }
};

const getProductInventory = async (req, res, next) => {
    try {
        const item = await Inventory.findOne({
            where: { product_id: req.params.productId },
            include: [{ model: Product, as: 'product', attributes: ['id', 'name', 'sku'] }]
        });
        if (!item) return res.status(404).json({ success: false, message: 'Inventory record not found' });
        successResponse(res, { data: item });
    } catch (err) { next(err); }
};

const updateStock = async (req, res, next) => {
    try {
        const { quantity, low_stock_threshold, warehouse_location } = req.body;
        const item = await Inventory.findOne({ where: { product_id: req.params.productId } });
        if (!item) return res.status(404).json({ success: false, message: 'Inventory record not found' });
        
        await item.update({
            quantity: quantity !== undefined ? quantity : item.quantity,
            low_stock_threshold: low_stock_threshold !== undefined ? low_stock_threshold : item.low_stock_threshold,
            warehouse_location: warehouse_location !== undefined ? warehouse_location : item.warehouse_location
        });
        successResponse(res, { data: item }, 'Inventory updated');
    } catch (err) { next(err); }
};

const getLowStock = async (req, res, next) => {
    try {
        const items = await Inventory.findAll({
            where: {
                quantity: {
                    [require('sequelize').Op.lte]: require('sequelize').col('low_stock_threshold')
                }
            },
            include: [{ model: Product, as: 'product', attributes: ['id', 'name', 'sku'] }]
        });
        successResponse(res, { data: items });
    } catch (err) { next(err); }
};

module.exports = { getInventory, getProductInventory, updateStock, getLowStock };
