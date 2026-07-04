const { Banner } = require('../models');
const { successResponse } = require('../utils/helpers');

const getBanners = async (req, res, next) => {
    try {
        const banners = await Banner.findAll({
            where: { is_active: true },
            order: [['position', 'ASC']]
        });
        successResponse(res, { data: banners });
    } catch (err) { next(err); }
};

const getAdminBanners = async (req, res, next) => {
    try {
        const list = await Banner.findAll({ order: [['position', 'ASC']] });
        successResponse(res, { data: list });
    } catch (err) { next(err); }
};

const createBanner = async (req, res, next) => {
    try {
        const { title, subtitle, link, position, starts_at, ends_at } = req.body;
        const image = req.file ? `/uploads/${req.file.filename}` : null;
        const banner = await Banner.create({
            title, subtitle, link, position, starts_at, ends_at, image
        });
        successResponse(res, { data: banner }, 'Banner created', 201);
    } catch (err) { next(err); }
};

const updateBanner = async (req, res, next) => {
    try {
        const banner = await Banner.findByPk(req.params.id);
        if (!banner) return res.status(404).json({ success: false, message: 'Banner not found' });

        const updates = { ...req.body };
        if (req.file) updates.image = `/uploads/${req.file.filename}`;
        await banner.update(updates);
        successResponse(res, { data: banner }, 'Banner updated');
    } catch (err) { next(err); }
};

const deleteBanner = async (req, res, next) => {
    try {
        const banner = await Banner.findByPk(req.params.id);
        if (!banner) return res.status(404).json({ success: false, message: 'Banner not found' });
        await banner.destroy();
        successResponse(res, {}, 'Banner deleted');
    } catch (err) { next(err); }
};

module.exports = { getBanners, getAdminBanners, createBanner, updateBanner, deleteBanner };
