const { User, Role } = require('../models');
const { body } = require('express-validator');
const validate = require('../middleware/validate.middleware');
const mailService = require('../services/mail.service');
const crypto = require('crypto');

// Validation rules
const registerRules = [
    body('name').notEmpty().withMessage('Name is required'),
    body('email').isEmail().withMessage('Valid email is required'),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
    validate
];

const loginRules = [
    body('email').isEmail().withMessage('Valid email is required'),
    body('password').notEmpty().withMessage('Password is required'),
    validate
];

// @desc    Register user
// @route   POST /api/v1/auth/register
const register = async (req, res, next) => {
    try {
        const { name, email, password, phone } = req.body;

        const existing = await User.findOne({ where: { email } });
        if (existing) {
            return res.status(400).json({ success: false, message: 'Email already registered' });
        }

        let customerRole = await Role.findOne({ where: { name: 'customer' } });
        if (!customerRole) {
            customerRole = await Role.create({ name: 'customer', permissions: [] });
        }

        const user = await User.create({
            name, email, password, phone,
            role_id: customerRole.id
        });

        // Send welcome email
        mailService.sendWelcome(user).catch(err => console.error('Mail error:', err));

        const token = user.getSignedJwtToken();
        res.status(201).json({
            success: true,
            message: 'Registration successful',
            data: { user: user.toSafeJSON(), token }
        });
    } catch (err) {
        next(err);
    }
};

// @desc    Login user
// @route   POST /api/v1/auth/login
const login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({
            where: { email },
            include: [{ model: Role, as: 'role' }]
        });

        if (!user) {
            return res.status(401).json({ success: false, message: 'Invalid credentials' });
        }

        const isMatch = await user.matchPassword(password);
        if (!isMatch) {
            return res.status(401).json({ success: false, message: 'Invalid credentials' });
        }

        if (!user.is_active) {
            return res.status(401).json({ success: false, message: 'Account deactivated' });
        }

        const token = user.getSignedJwtToken();
        res.json({
            success: true,
            message: 'Login successful',
            data: { user: user.toSafeJSON(), token }
        });
    } catch (err) {
        next(err);
    }
};

// @desc    Get current user
// @route   GET /api/v1/auth/me
const getMe = async (req, res, next) => {
    try {
        res.json({
            success: true,
            data: { user: req.user.toSafeJSON() }
        });
    } catch (err) {
        next(err);
    }
};

// @desc    Update profile
// @route   PUT /api/v1/auth/update-profile
const updateProfile = async (req, res, next) => {
    try {
        const { name, phone } = req.body;
        const updates = {};
        if (name) updates.name = name;
        if (phone) updates.phone = phone;
        if (req.file) updates.avatar = `/uploads/${req.file.filename}`;

        await req.user.update(updates);
        res.json({
            success: true,
            message: 'Profile updated',
            data: { user: req.user.toSafeJSON() }
        });
    } catch (err) {
        next(err);
    }
};

// @desc    Change password
// @route   PUT /api/v1/auth/change-password
const changePassword = async (req, res, next) => {
    try {
        const { currentPassword, newPassword } = req.body;

        if (!currentPassword || !newPassword) {
            return res.status(400).json({ success: false, message: 'Current and new password required' });
        }

        const isMatch = await req.user.matchPassword(currentPassword);
        if (!isMatch) {
            return res.status(400).json({ success: false, message: 'Current password is incorrect' });
        }

        req.user.password = newPassword;
        await req.user.save();

        res.json({ success: true, message: 'Password changed successfully' });
    } catch (err) {
        next(err);
    }
};

// @desc    Forgot password
// @route   POST /api/v1/auth/forgot-password
const forgotPassword = async (req, res, next) => {
    try {
        const user = await User.findOne({ where: { email: req.body.email } });
        if (!user) {
            return res.status(404).json({ success: false, message: 'No user with that email' });
        }

        const resetToken = user.getResetPasswordToken();
        await user.save();

        const resetUrl = `${req.protocol}://${req.get('host')}/api/v1/auth/reset-password/${resetToken}`;
        await mailService.sendPasswordReset(user, resetUrl);

        res.json({ success: true, message: 'Reset email sent' });
    } catch (err) {
        next(err);
    }
};

// @desc    Reset password
// @route   POST /api/v1/auth/reset-password/:token
const resetPassword = async (req, res, next) => {
    try {
        const hashedToken = crypto.createHash('sha256').update(req.params.token).digest('hex');

        const user = await User.findOne({
            where: {
                reset_password_token: hashedToken
            }
        });

        if (!user || (user.reset_password_expires && new Date(user.reset_password_expires) < new Date())) {
            return res.status(400).json({ success: false, message: 'Invalid or expired token' });
        }

        user.password = req.body.password;
        user.reset_password_token = null;
        user.reset_password_expires = null;
        await user.save();

        res.json({ success: true, message: 'Password reset successful' });
    } catch (err) {
        next(err);
    }
};

module.exports = {
    register, registerRules,
    login, loginRules,
    getMe, updateProfile, changePassword,
    forgotPassword, resetPassword
};
