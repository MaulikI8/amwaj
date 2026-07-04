const { Blog, User } = require('../models');
const { createSlug, successResponse } = require('../utils/helpers');

const getBlogs = async (req, res, next) => {
    try {
        const blogs = await Blog.findAll({
            where: { status: 'published' },
            include: [{ model: User, as: 'author', attributes: ['id', 'name', 'avatar'] }],
            order: [['published_at', 'DESC']]
        });
        successResponse(res, { data: blogs });
    } catch (err) { next(err); }
};

const getBlog = async (req, res, next) => {
    try {
        const blog = await Blog.findOne({
            where: { slug: req.params.slug, status: 'published' },
            include: [{ model: User, as: 'author', attributes: ['id', 'name', 'avatar'] }]
        });
        if (!blog) return res.status(404).json({ success: false, message: 'Article not found' });
        successResponse(res, { data: blog });
    } catch (err) { next(err); }
};

const getAdminBlogs = async (req, res, next) => {
    try {
        const list = await Blog.findAll({
            include: [{ model: User, as: 'author', attributes: ['id', 'name'] }]
        });
        successResponse(res, { data: list });
    } catch (err) { next(err); }
};

const createBlog = async (req, res, next) => {
    try {
        const { title, content, excerpt, status, meta_title, meta_description } = req.body;
        const slug = createSlug(title) + '-' + Date.now().toString(36);
        const image = req.file ? `/uploads/${req.file.filename}` : null;

        const blog = await Blog.create({
            title, slug, content, excerpt, status: status || 'draft',
            meta_title, meta_description, author_id: req.user.id, image,
            published_at: status === 'published' ? new Date() : null
        });

        successResponse(res, { data: blog }, 'Article created', 201);
    } catch (err) { next(err); }
};

const updateBlog = async (req, res, next) => {
    try {
        const blog = await Blog.findByPk(req.params.id);
        if (!blog) return res.status(404).json({ success: false, message: 'Article not found' });

        const updates = { ...req.body };
        if (updates.title && updates.title !== blog.title) {
            updates.slug = createSlug(updates.title) + '-' + Date.now().toString(36);
        }
        if (req.file) updates.image = `/uploads/${req.file.filename}`;
        
        if (updates.status === 'published' && blog.status !== 'published') {
            updates.published_at = new Date();
        }

        await blog.update(updates);
        successResponse(res, { data: blog }, 'Article updated');
    } catch (err) { next(err); }
};

const deleteBlog = async (req, res, next) => {
    try {
        const blog = await Blog.findByPk(req.params.id);
        if (!blog) return res.status(404).json({ success: false, message: 'Article not found' });
        await blog.destroy();
        successResponse(res, {}, 'Article deleted');
    } catch (err) { next(err); }
};

module.exports = { getBlogs, getBlog, getAdminBlogs, createBlog, updateBlog, deleteBlog };
