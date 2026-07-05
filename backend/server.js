const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path');
const fs = require('fs');
const dotenv = require('dotenv');
const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');
const { rateLimit } = require('express-rate-limit');

// Force Vercel bundler to include database drivers
try {
    require('pg');
} catch (e) {
    // Ignore locally if not needed yet
}

// Load environment variables
dotenv.config();

const { sequelize, Role, User } = require('./models');
const errorHandler = require('./middleware/error.middleware');

const app = express();

// Ensure uploads folder exists
const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) {
    fs.mkdirSync(uploadsDir);
}

// ── Middlewares ──
app.use(cors());
app.use(helmet({
    contentSecurityPolicy: false // Allows loading local assets easily
}));
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static uploads
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Rate Limiter
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 200, // Limit each IP to 200 requests per window
    standardHeaders: true,
    legacyHeaders: false,
    message: 'Too many requests from this IP, please try again later.'
});
app.use('/api/', limiter);

// ── Swagger Documentation Setup ──
const swaggerOptions = {
    definition: {
        openapi: '3.0.0',
        info: {
            title: 'Amwaj Almesela E-commerce API',
            version: '1.0.0',
            description: 'Comprehensive backend REST API documentation for the Amwaj Almesela catalog and checkout.'
        },
        servers: [
            {
                url: `http://localhost:${process.env.PORT || 5000}`
            }
        ]
    },
    apis: [path.join(__dirname, 'routes', '*.js')]
};
const specs = swaggerJsdoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs));

// ── Serve Static Assets (no DB needed) ──
app.use(express.static(path.join(__dirname, '..'), {
    etag: false,
    maxAge: 0,
    setHeaders: (res) => {
        res.set('Cache-Control', 'no-store, no-cache, must-revalidate, private');
    }
}));

// ── Database Initialization (lazy, runs once) ──
let dbInitPromise = null;

function initializeDatabase() {
    if (!dbInitPromise) {
        dbInitPromise = (async () => {
            await sequelize.authenticate();
            console.log('✅ Database connection established successfully.');

            await sequelize.sync();
            console.log('✅ Database tables synchronized.');

            // Seed roles individually if they don't exist
            let adminRole = await Role.findOne({ where: { name: 'admin' } });
            if (!adminRole) {
                adminRole = await Role.create({
                    name: 'admin',
                    permissions: ['all']
                });
                console.log('✅ Admin Role created.');
            }

            let customerRole = await Role.findOne({ where: { name: 'customer' } });
            if (!customerRole) {
                await Role.create({
                    name: 'customer',
                    permissions: []
                });
                console.log('✅ Customer Role created.');
            }

            if (adminRole) {
                const adminEmail = process.env.ADMIN_EMAIL || 'admin@amwaj.com';
                const adminPass = process.env.ADMIN_PASSWORD || 'admin123@';
                const adminName = process.env.ADMIN_NAME || 'Super Admin';

                const bcrypt = require('bcryptjs');
                const salt = await bcrypt.genSalt(10);
                const hashedPass = await bcrypt.hash(adminPass, salt);

                // Find admin user by email
                let adminUser = await User.findOne({ where: { email: adminEmail } });

                if (!adminUser) {
                    // Create admin, bypassing hooks to avoid double-hashing
                    adminUser = await User.create({
                        name: adminName,
                        email: adminEmail,
                        password: hashedPass,
                        role_id: adminRole.id,
                        email_verified_at: new Date()
                    }, { hooks: false });
                    console.log(`✅ Seeded default admin account: ${adminEmail}`);
                } else {
                    // Update admin, bypassing hooks to enforce exact single hashing
                    await User.update({
                        name: adminName,
                        password: hashedPass,
                        role_id: adminRole.id
                    }, {
                        where: { id: adminUser.id },
                        hooks: false
                    });
                    console.log(`✅ Admin account verified and synchronized: ${adminEmail}`);
                }
            }
        })();
    }
    return dbInitPromise;
}

// Middleware: wait for DB to be ready before handling any request
app.use(async (req, res, next) => {
    try {
        await initializeDatabase();
        next();
    } catch (err) {
        console.error('❌ Database init failed:', err.message);
        res.status(500).json({ success: false, message: 'Database initialization failed', error: err.message });
    }
});

// TEMPORARY DEBUG ENDPOINT - remove after fixing login
app.get('/api/v1/debug/health', async (req, res) => {
    try {
        const bcrypt = require('bcryptjs');
        const adminEmail = process.env.ADMIN_EMAIL || 'admin@amwaj.com';
        const adminPass = process.env.ADMIN_PASSWORD || 'admin123@';

        const roleCount = await Role.count();
        const userCount = await User.count();
        const adminRole = await Role.findOne({ where: { name: 'admin' } });
        const adminUser = await User.findOne({ where: { email: adminEmail } });

        let passwordCheck = null;
        if (adminUser) {
            passwordCheck = await bcrypt.compare(adminPass, adminUser.password);
        }

        res.json({
            success: true,
            debug: {
                dbConnected: true,
                roleCount,
                userCount,
                adminRoleExists: !!adminRole,
                adminRoleId: adminRole ? adminRole.id : null,
                adminUserExists: !!adminUser,
                adminUserRoleId: adminUser ? adminUser.role_id : null,
                adminPasswordHashLength: adminUser ? adminUser.password.length : null,
                adminPasswordHashPrefix: adminUser ? adminUser.password.substring(0, 7) : null,
                passwordMatchesEnv: passwordCheck,
                envAdminEmail: adminEmail,
                envAdminPass: adminPass ? `${adminPass.substring(0, 3)}***` : null
            }
        });
    } catch (err) {
        res.json({ success: false, error: err.message, stack: err.stack });
    }
});

// ── Mount Routes (AFTER the DB-wait middleware) ──
app.use('/api/v1/auth', require('./routes/auth.routes'));
app.use('/api/v1/products', require('./routes/product.routes'));
app.use('/api/v1/categories', require('./routes/category.routes'));
app.use('/api/v1/brands', require('./routes/brand.routes'));
app.use('/api/v1/inventory', require('./routes/inventory.routes'));
app.use('/api/v1/cart', require('./routes/cart.routes'));
app.use('/api/v1/wishlist', require('./routes/wishlist.routes'));
app.use('/api/v1/orders', require('./routes/order.routes'));
app.use('/api/v1/payments', require('./routes/payment.routes'));
app.use('/api/v1/shipping', require('./routes/shipping.routes'));
app.use('/api/v1/search', require('./routes/search.routes'));
app.use('/api/v1/reviews', require('./routes/review.routes'));
app.use('/api/v1/coupons', require('./routes/coupon.routes'));
app.use('/api/v1/notifications', require('./routes/notification.routes'));
app.use('/api/v1/banners', require('./routes/banner.routes'));
app.use('/api/v1/blogs', require('./routes/blog.routes'));
app.use('/api/v1/admin/analytics', require('./routes/analytics.routes'));
app.use('/api/v1/settings', require('./routes/settings.routes'));

// ── Clean URL & HTML Extension Front-End Routes ──
app.get(['/home', '/index.html'], (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'index.html'));
});

app.get(['/products', '/products.html'], (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'products.html'));
});

app.get(['/product', '/product-detail.html'], (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'product-detail.html'));
});

app.get(['/admin', '/admin.html'], (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'admin.html'));
});

app.get(['/cart', '/cart.html'], (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'cart.html'));
});

app.get(['/checkout', '/checkout.html'], (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'checkout.html'));
});

app.get(['/wishlists', '/wishlists.html'], (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'wishlists.html'));
});

// Root fallback redirects to /home
app.get('/', (req, res) => {
    res.redirect('/home');
});

// Error handling middleware
app.use(errorHandler);

// ── Server Start (local dev only) ──
const PORT = process.env.PORT || 5000;

if (!process.env.VERCEL) {
    initializeDatabase()
        .then(() => {
            app.listen(PORT, () => {
                console.log(`🚀 Server running on port ${PORT}`);
                console.log(`📖 API Documentation: http://localhost:${PORT}/api-docs`);
            });
        })
        .catch(err => {
            console.error('❌ Unable to start server:', err.message);
        });
}

module.exports = app;
