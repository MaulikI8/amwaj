const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');
const ctrl = require('../controllers/category.controller');

router.get('/', ctrl.getCategories);
router.get('/:id', ctrl.getCategory);
router.post('/', protect, authorize('admin'), upload.single('image'), ctrl.createCategory);
router.put('/:id', protect, authorize('admin'), upload.single('image'), ctrl.updateCategory);
router.delete('/:id', protect, authorize('admin'), ctrl.deleteCategory);

module.router = router;
module.exports = router;
