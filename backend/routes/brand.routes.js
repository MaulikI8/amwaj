const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');
const ctrl = require('../controllers/brand.controller');

router.get('/', ctrl.getBrands);
router.get('/:id', ctrl.getBrand);
router.post('/', protect, authorize('admin'), upload.single('logo'), ctrl.createBrand);
router.put('/:id', protect, authorize('admin'), upload.single('logo'), ctrl.updateBrand);
router.delete('/:id', protect, authorize('admin'), ctrl.deleteBrand);

module.exports = router;
