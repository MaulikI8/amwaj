const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/coupon.controller');

router.post('/validate', protect, ctrl.validateCoupon);

// Admin Routes
router.get('/admin/list', protect, authorize('admin'), ctrl.getCoupons);
router.post('/admin/create', protect, authorize('admin'), ctrl.createCoupon);
router.put('/admin/update/:id', protect, authorize('admin'), ctrl.updateCoupon);
router.delete('/admin/delete/:id', protect, authorize('admin'), ctrl.deleteCoupon);

module.exports = router;
