const jwt = require('jsonwebtoken');
const { User, Role } = require('../models');

// Protect routes — verify JWT
const protect = async (req, res, next) => {
    let token;
    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
        token = req.headers.authorization.split(' ')[1];
    }
    if (!token) {
        return res.status(401).json({ success: false, message: 'Not authorized, no token' });
    }
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = await User.findByPk(decoded.id, {
            include: [{ model: Role, as: 'role' }]
        });
        if (!req.user) {
            return res.status(401).json({ success: false, message: 'User not found' });
        }
        if (!req.user.is_active) {
            return res.status(401).json({ success: false, message: 'Account deactivated' });
        }
        next();
    } catch (err) {
        return res.status(401).json({ success: false, message: 'Not authorized, token invalid' });
    }
};

// Authorize by role name(s)
const authorize = (...roles) => {
    return (req, res, next) => {
        if (!req.user || !req.user.role) {
            return res.status(403).json({ success: false, message: 'Forbidden' });
        }
        if (!roles.includes(req.user.role.name)) {
            return res.status(403).json({
                success: false,
                message: `Role '${req.user.role.name}' is not authorized to access this route`
            });
        }
        next();
    };
};

module.exports = { protect, authorize };
