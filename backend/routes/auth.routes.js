const router = require('express').Router();
const { protect } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');
const ctrl = require('../controllers/auth.controller');

router.post('/register', ctrl.registerRules, ctrl.register);
router.post('/login', ctrl.loginRules, ctrl.login);
router.get('/me', protect, ctrl.getMe);
router.put('/update-profile', protect, upload.single('avatar'), ctrl.updateProfile);
router.put('/change-password', protect, ctrl.changePassword);
router.post('/forgot-password', ctrl.forgotPassword);
router.post('/reset-password/:token', ctrl.resetPassword);

module.exports = router;
