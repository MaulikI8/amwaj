const { Brand } = require('../models');
const { createSlug, successResponse } = require('../utils/helpers');

const getBrands = async (req, res, next) => {
    try {
        const brands = await Brand.findAll({ where: { is_active: true }, order: [['name', 'ASC']] });
        successResponse(res, { data: brands });
    } catch (err) { next(err); }
};

const getBrand = async (req, res, next) => {
    try {
        const brand = await Brand.findByPk(req.params.id);
        if (!brand) return res.status(404).json({ success: false, message: 'Brand not found' });
        successResponse(res, { data: brand });
    } catch (err) { next(err); }
};

const createBrand = async (req, res, next) => {
    try {
        const { name } = req.body;
        const slug = createSlug(name);
        const logo = req.file ? `/uploads/${req.file.filename}` : null;
        const brand = await Brand.create({ name, slug, logo });
        successResponse(res, { data: brand }, 'Brand created', 201);
    } catch (err) { next(err); }
};

const updateBrand = async (req, res, next) => {
    try {
        const brand = await Brand.findByPk(req.params.id);
        if (!brand) return res.status(404).json({ success: false, message: 'Brand not found' });
        const updates = { ...req.body };
        if (updates.name) updates.slug = createSlug(updates.name);
        if (req.file) updates.logo = `/uploads/${req.file.filename}`;
        await brand.update(updates);
        successResponse(res, { data: brand }, 'Brand updated');
    } catch (err) { next(err); }
};

const deleteBrand = async (req, res, next) => {
    try {
        const brand = await Brand.findByPk(req.params.id);
        if (!brand) return res.status(404).json({ success: false, message: 'Brand not found' });
        await brand.update({ is_active: false });
        successResponse(res, {}, 'Brand deleted');
    } catch (err) { next(err); }
};

module.exports = { getBrands, getBrand, createBrand, updateBrand, deleteBrand };
