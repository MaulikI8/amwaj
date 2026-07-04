const router = require('express').Router();
const ctrl = require('../controllers/search.controller');

router.get('/', ctrl.searchProducts);
router.get('/suggestions', ctrl.getSearchSuggestions);

module.exports = router;
