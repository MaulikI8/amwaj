const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/notification.controller');

router.get('/', protect, ctrl.getNotifications);
router.put('/read-all', protect, ctrl.markAllAsRead);
router.put('/:id/read', protect, ctrl.markAsRead);
router.post('/admin/send', protect, authorize('admin'), ctrl.sendAdminNotification);

module.exports = router;
