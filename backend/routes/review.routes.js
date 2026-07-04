const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/review.controller');

router.get('/:productId', ctrl.getReviews);
router.post('/', protect, ctrl.createReview);

// Admin Routes
router.get('/admin/pending', protect, authorize('admin'), ctrl.getAdminPendingReviews);
router.put('/admin/moderate/:id', protect, authorize('admin'), ctrl.approveReview);

module.exports = router;
