const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/inventory.controller');

router.get('/', protect, authorize('admin'), ctrl.getInventory);
router.get('/low-stock', protect, authorize('admin'), ctrl.getLowStock);
router.get('/:productId', protect, authorize('admin'), ctrl.getProductInventory);
router.put('/:productId', protect, authorize('admin'), ctrl.updateStock);

module.exports = router;
