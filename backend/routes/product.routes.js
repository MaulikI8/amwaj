const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');
const ctrl = require('../controllers/product.controller');

router.get('/featured', ctrl.getFeatured);
router.get('/best-selling', ctrl.getBestSelling);
router.get('/', ctrl.getProducts);
router.get('/:id', ctrl.getProduct);
router.post('/', protect, authorize('admin'), upload.array('images', 10), ctrl.createProduct);
router.put('/:id', protect, authorize('admin'), ctrl.updateProduct);
router.delete('/:id', protect, authorize('admin'), ctrl.deleteProduct);
router.post('/:id/images', protect, authorize('admin'), upload.array('images', 10), ctrl.uploadImages);

module.exports = router;
