const { Setting } = require('../models');
const { successResponse } = require('../utils/helpers');

const getSettings = async (req, res, next) => {
    try {
        const settings = await Setting.findAll();
        successResponse(res, { data: settings });
    } catch (err) { next(err); }
};

const updateSettings = async (req, res, next) => {
    try {
        const { key, value } = req.body;
        const [setting, created] = await Setting.findOrCreate({
            where: { key }
        });
        await setting.update({ value });
        successResponse(res, { data: setting }, created ? 'Setting created' : 'Setting updated');
    } catch (err) { next(err); }
};

module.exports = { getSettings, updateSettings };
