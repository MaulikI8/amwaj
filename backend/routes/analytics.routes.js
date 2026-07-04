const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/analytics.controller');

router.get('/overview', protect, authorize('admin'), ctrl.getOverview);
router.get('/sales-chart', protect, authorize('admin'), ctrl.getSalesChartData);

module.exports = router;
