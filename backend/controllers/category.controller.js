const { Category } = require('../models');
const { createSlug, successResponse } = require('../utils/helpers');

const getCategories = async (req, res, next) => {
    try {
        const categories = await Category.findAll({
            where: { parent_id: null, is_active: true },
            include: [{ model: Category, as: 'children', where: { is_active: true }, required: false }],
            order: [['position', 'ASC'], ['name', 'ASC']]
        });
        successResponse(res, { data: categories });
    } catch (err) { next(err); }
};

const getCategory = async (req, res, next) => {
    try {
        const category = await Category.findByPk(req.params.id, {
            include: [{ model: Category, as: 'children' }, { model: Category, as: 'parent' }]
        });
        if (!category) return res.status(404).json({ success: false, message: 'Category not found' });
        successResponse(res, { data: category });
    } catch (err) { next(err); }
};

const createCategory = async (req, res, next) => {
    try {
        const { name, parent_id, icon, position } = req.body;
        const slug = createSlug(name);
        const category = await Category.create({ name, slug, parent_id, icon, position });
        successResponse(res, { data: category }, 'Category created', 201);
    } catch (err) { next(err); }
};

const updateCategory = async (req, res, next) => {
    try {
        const category = await Category.findByPk(req.params.id);
        if (!category) return res.status(404).json({ success: false, message: 'Category not found' });
        const updates = { ...req.body };
        if (updates.name) updates.slug = createSlug(updates.name);
        await category.update(updates);
        successResponse(res, { data: category }, 'Category updated');
    } catch (err) { next(err); }
};

const deleteCategory = async (req, res, next) => {
    try {
        const category = await Category.findByPk(req.params.id);
        if (!category) return res.status(404).json({ success: false, message: 'Category not found' });
        await category.update({ is_active: false });
        successResponse(res, {}, 'Category deleted');
    } catch (err) { next(err); }
};

module.exports = { getCategories, getCategory, createCategory, updateCategory, deleteCategory };
