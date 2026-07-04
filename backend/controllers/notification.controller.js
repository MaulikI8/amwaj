const { Notification } = require('../models');
const { successResponse } = require('../utils/helpers');

const getNotifications = async (req, res, next) => {
    try {
        const notifications = await Notification.findAll({
            where: { user_id: req.user.id },
            order: [['created_at', 'DESC']]
        });
        successResponse(res, { data: notifications });
    } catch (err) { next(err); }
};

const markAsRead = async (req, res, next) => {
    try {
        const notification = await Notification.findOne({
            where: { id: req.params.id, user_id: req.user.id }
        });
        if (!notification) return res.status(404).json({ success: false, message: 'Notification not found' });

        await notification.update({ is_read: true });
        successResponse(res, { data: notification }, 'Notification marked as read');
    } catch (err) { next(err); }
};

const markAllAsRead = async (req, res, next) => {
    try {
        await Notification.update({ is_read: true }, { where: { user_id: req.user.id } });
        successResponse(res, {}, 'All notifications marked as read');
    } catch (err) { next(err); }
};

const sendAdminNotification = async (req, res, next) => {
    try {
        const { user_id, title, message, type, data } = req.body;
        const notification = await Notification.create({
            user_id, title, message, type: type || 'info', data
        });
        successResponse(res, { data: notification }, 'Notification sent', 201);
    } catch (err) { next(err); }
};

module.exports = { getNotifications, markAsRead, markAllAsRead, sendAdminNotification };
