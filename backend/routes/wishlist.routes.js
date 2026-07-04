const router = require('express').Router();
const { protect } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/wishlist.controller');

router.get('/', protect, ctrl.getWishlist);
router.post('/', protect, ctrl.addToWishlist);
router.delete('/:productId', protect, ctrl.removeFromWishlist);
router.get('/check/:productId', protect, ctrl.checkWishlist);

module.exports = router;
