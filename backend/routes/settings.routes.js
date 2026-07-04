const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/settings.controller');

router.get('/', ctrl.getSettings);
router.put('/', protect, authorize('admin'), ctrl.updateSettings);

module.exports = router;
