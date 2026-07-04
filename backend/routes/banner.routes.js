const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');
const ctrl = require('../controllers/banner.controller');

router.get('/', ctrl.getBanners);

// Admin Routes
router.get('/admin/list', protect, authorize('admin'), ctrl.getAdminBanners);
router.post('/admin/create', protect, authorize('admin'), upload.single('image'), ctrl.createBanner);
router.put('/admin/update/:id', protect, authorize('admin'), upload.single('image'), ctrl.updateBanner);
router.delete('/admin/delete/:id', protect, authorize('admin'), ctrl.deleteBanner);

module.exports = router;
