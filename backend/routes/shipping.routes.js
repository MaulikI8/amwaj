const router = require('express').Router();
const { protect } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/shipping.controller');

router.get('/addresses', protect, ctrl.getAddresses);
router.post('/addresses', protect, ctrl.createAddress);
router.put('/addresses/:id', protect, ctrl.updateAddress);
router.delete('/addresses/:id', protect, ctrl.deleteAddress);

module.exports = router;
