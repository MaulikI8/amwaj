const { Coupon } = require('../models');
const { successResponse } = require('../utils/helpers');

const getCoupons = async (req, res, next) => {
    try {
        const coupons = await Coupon.findAll({ order: [['created_at', 'DESC']] });
        successResponse(res, { data: coupons });
    } catch (err) { next(err); }
};

const createCoupon = async (req, res, next) => {
    try {
        const coupon = await Coupon.create(req.body);
        successResponse(res, { data: coupon }, 'Coupon created', 201);
    } catch (err) { next(err); }
};

const updateCoupon = async (req, res, next) => {
    try {
        const coupon = await Coupon.findByPk(req.params.id);
        if (!coupon) return res.status(404).json({ success: false, message: 'Coupon not found' });
        await coupon.update(req.body);
        successResponse(res, { data: coupon }, 'Coupon updated');
    } catch (err) { next(err); }
};

const deleteCoupon = async (req, res, next) => {
    try {
        const coupon = await Coupon.findByPk(req.params.id);
        if (!coupon) return res.status(404).json({ success: false, message: 'Coupon not found' });
        await coupon.destroy();
        successResponse(res, {}, 'Coupon deleted');
    } catch (err) { next(err); }
};

const validateCoupon = async (req, res, next) => {
    try {
        const { code, amount } = req.body;
        const coupon = await Coupon.findOne({ where: { code, is_active: true } });
        if (!coupon) return res.status(404).json({ success: false, message: 'Invalid coupon code' });

        const now = new Date();
        const validTime = (!coupon.starts_at || new Date(coupon.starts_at) <= now) &&
                          (!coupon.expires_at || new Date(coupon.expires_at) >= now);
        
        if (!validTime) return res.status(400).json({ success: false, message: 'Coupon has expired or is not active yet' });

        if (coupon.usage_limit && coupon.used_count >= coupon.usage_limit) {
            return res.status(400).json({ success: false, message: 'Coupon usage limit reached' });
        }

        const subtotal = parseFloat(amount) || 0;
        if (subtotal < parseFloat(coupon.min_order)) {
            return res.status(400).json({
                success: false,
                message: `Minimum order amount for this coupon is QAR ${coupon.min_order}`
            });
        }

        let discount = 0;
        if (coupon.type === 'percentage') {
            discount = (subtotal * parseFloat(coupon.value)) / 100;
            if (coupon.max_discount && discount > parseFloat(coupon.max_discount)) {
                discount = parseFloat(coupon.max_discount);
            }
        } else {
            discount = parseFloat(coupon.value);
        }

        successResponse(res, {
            data: {
                id: coupon.id,
                code: coupon.code,
                type: coupon.type,
                value: coupon.value,
                discount
            }
        }, 'Coupon validated successfully');
    } catch (err) { next(err); }
};

module.exports = { getCoupons, createCoupon, updateCoupon, deleteCoupon, validateCoupon };
