const router = require('express').Router();
const { protect } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/cart.controller');

router.get('/', protect, ctrl.getCart);
router.post('/items', protect, ctrl.addItem);
router.put('/items/:id', protect, ctrl.updateItem);
router.delete('/items/:id', protect, ctrl.removeItem);
router.delete('/clear', protect, ctrl.clearCart);

module.exports = router;
