const { Product, Image } = require('../models');
const { Op } = require('sequelize');
const { successResponse } = require('../utils/helpers');

const searchProducts = async (req, res, next) => {
    try {
        const query = (req.query.q || '').trim();
        if (!query) {
            return successResponse(res, { data: [] });
        }

        const products = await Product.findAll({
            where: {
                is_active: true,
                [Op.or]: [
                    { name: { [Op.like]: `%${query}%` } },
                    { brand: { [Op.like]: `%${query}%` } },
                    { description: { [Op.like]: `%${query}%` } }
                ]
            },
            include: [{ model: Image, as: 'images', where: { is_primary: true }, required: false }],
            limit: 20
        });

        successResponse(res, { data: products });
    } catch (err) { next(err); }
};

const getSearchSuggestions = async (req, res, next) => {
    try {
        const query = (req.query.q || '').trim();
        if (!query) {
            return successResponse(res, { data: [] });
        }

        const products = await Product.findAll({
            where: {
                is_active: true,
                [Op.or]: [
                    { name: { [Op.like]: `%${query}%` } },
                    { brand: { [Op.like]: `%${query}%` } }
                ]
            },
            attributes: ['id', 'name', 'slug', 'price', 'discount_price'],
            include: [{ model: Image, as: 'images', where: { is_primary: true }, attributes: ['url'], required: false }],
            limit: 10
        });

        successResponse(res, { data: products });
    } catch (err) { next(err); }
};

module.exports = { searchProducts, getSearchSuggestions };
