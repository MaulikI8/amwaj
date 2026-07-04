const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/order.controller');

router.post('/', protect, ctrl.createOrder);
router.get('/my-orders', protect, ctrl.getMyOrders);
router.get('/my-orders/:id', protect, ctrl.getOrderDetails);
router.put('/my-orders/:id/cancel', protect, ctrl.cancelOrder);

// Admin Routes
router.get('/admin/list', protect, authorize('admin'), ctrl.getAdminOrders);
router.put('/admin/status/:id', protect, authorize('admin'), ctrl.updateOrderStatus);

module.exports = router;
