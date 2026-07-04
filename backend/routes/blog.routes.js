const router = require('express').Router();
const { protect, authorize } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');
const ctrl = require('../controllers/blog.controller');

router.get('/', ctrl.getBlogs);
router.get('/:slug', ctrl.getBlog);

// Admin Routes
router.get('/admin/list', protect, authorize('admin'), ctrl.getAdminBlogs);
router.post('/admin/create', protect, authorize('admin'), upload.single('image'), ctrl.createBlog);
router.put('/admin/update/:id', protect, authorize('admin'), upload.single('image'), ctrl.updateBlog);
router.delete('/admin/delete/:id', protect, authorize('admin'), ctrl.deleteBlog);

module.exports = router;
