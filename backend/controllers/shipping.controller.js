const { Address } = require('../models');
const { successResponse } = require('../utils/helpers');

const getAddresses = async (req, res, next) => {
    try {
        const list = await Address.findAll({ where: { user_id: req.user.id } });
        successResponse(res, { data: list });
    } catch (err) { next(err); }
};

const createAddress = async (req, res, next) => {
    try {
        const { label, full_name, phone, address_line1, address_line2, city, state, country, zip_code, is_default } = req.body;
        
        if (is_default) {
            await Address.update({ is_default: false }, { where: { user_id: req.user.id } });
        }

        const address = await Address.create({
            user_id: req.user.id, label, full_name, phone, address_line1, address_line2, city, state, country, zip_code, is_default
        });

        successResponse(res, { data: address }, 'Address added successfully', 201);
    } catch (err) { next(err); }
};

const updateAddress = async (req, res, next) => {
    try {
        const address = await Address.findOne({ where: { id: req.params.id, user_id: req.user.id } });
        if (!address) return res.status(404).json({ success: false, message: 'Address not found' });

        const updates = { ...req.body };
        if (updates.is_default) {
            await Address.update({ is_default: false }, { where: { user_id: req.user.id } });
        }

        await address.update(updates);
        successResponse(res, { data: address }, 'Address updated');
    } catch (err) { next(err); }
};

const deleteAddress = async (req, res, next) => {
    try {
        const affected = await Address.destroy({ where: { id: req.params.id, user_id: req.user.id } });
        if (!affected) return res.status(404).json({ success: false, message: 'Address not found' });
        successResponse(res, {}, 'Address deleted');
    } catch (err) { next(err); }
};

module.exports = { getAddresses, createAddress, updateAddress, deleteAddress };
