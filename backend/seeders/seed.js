const fs = require('fs');
const path = require('path');
const dotenv = require('dotenv');

// Load environment variables
dotenv.config({ path: path.join(__dirname, '..', '.env') });

const { sequelize, Role, User, Category, Brand, Product, Image, Inventory, Coupon, Setting } = require('../models');
const { createSlug, parsePrice } = require('../utils/helpers');

const seed = async () => {
    try {
        console.log('🔄 Seeding database...');

        // Sync Database (Force true to reset)
        await sequelize.sync({ force: true });
        console.log('✅ Database tables dropped and synchronized.');

        // 1. Seed Roles
        const adminRole = await Role.create({
            name: 'admin',
            permissions: ['all']
        });
        const customerRole = await Role.create({
            name: 'customer',
            permissions: []
        });
        console.log('✅ Roles seeded.');

        // 2. Seed Admin User
        const adminEmail = process.env.ADMIN_EMAIL || 'admin@amwaj.com';
        const adminPass = process.env.ADMIN_PASSWORD || 'Admin@123';
        const adminName = process.env.ADMIN_NAME || 'Super Admin';

        await User.create({
            name: adminName,
            email: adminEmail,
            password: adminPass,
            role_id: adminRole.id,
            email_verified_at: new Date()
        });
        console.log(`✅ Admin account created: ${adminEmail}`);

        // 3. Seed Brand
        const defaultBrand = await Brand.create({
            name: 'AMWAJ',
            slug: 'amwaj',
            logo: null
        });
        console.log('✅ Default Brand seeded.');

        // 4. Seed Categories from data/categories.json
        const categoriesPath = path.join(__dirname, '..', '..', 'data', 'categories.json');
        if (fs.existsSync(categoriesPath)) {
            const rawCategories = JSON.parse(fs.readFileSync(categoriesPath, 'utf-8'));
            for (const cat of rawCategories) {
                const parent = await Category.create({
                    id: cat.id,
                    name: cat.name,
                    slug: createSlug(cat.name),
                    position: cat.id
                });

                if (cat.subcategories && cat.subcategories.length > 0) {
                    for (const sub of cat.subcategories) {
                        await Category.create({
                            id: sub.id,
                            name: sub.name,
                            slug: createSlug(sub.name),
                            parent_id: parent.id,
                            position: sub.id
                        });
                    }
                }
            }
            console.log('✅ Categories and subcategories seeded from data/categories.json.');
        } else {
            console.warn('⚠️ Warning: data/categories.json not found. Skipping category seed.');
        }

        // 5. Seed Products and Inventory from data/products.json
        const productsPath = path.join(__dirname, '..', '..', 'data', 'products.json');
        if (fs.existsSync(productsPath)) {
            const rawProducts = JSON.parse(fs.readFileSync(productsPath, 'utf-8'));
            for (const prod of rawProducts) {
                // Ensure category exists
                const catExists = await Category.findByPk(prod.category_id);

                const product = await Product.create({
                    name: prod.name,
                    slug: prod.slug || (createSlug(prod.name) + '-' + prod.id),
                    description: prod.description || `${prod.name} description.`,
                    price: parsePrice(prod.price),
                    sku: `SKU-${prod.id}`,
                    category_id: catExists ? prod.category_id : null,
                    brand_id: defaultBrand.id,
                    featured: prod.featured || false,
                    best_selling: prod.best_selling || false,
                    top_rated: prod.top_rated || false,
                    is_active: true
                });

                // Primary Image
                await Image.create({
                    product_id: product.id,
                    url: prod.image,
                    alt_text: prod.name,
                    is_primary: true
                });

                // Inventory
                await Inventory.create({
                    product_id: product.id,
                    quantity: prod.in_stock ? 50 : 0,
                    low_stock_threshold: 5,
                    warehouse_location: 'Aisle-3'
                });
            }
            console.log('✅ Products, images, and inventory seeded from data/products.json.');
        } else {
            console.warn('⚠️ Warning: data/products.json not found. Skipping product seed.');
        }

        // 6. Seed default Coupon
        await Coupon.create({
            code: 'AMWAJ10',
            type: 'percentage',
            value: 10.00,
            min_order: 100.00,
            max_discount: 50.00,
            starts_at: new Date(),
            expires_at: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000)
        });

        // 7. Seed Settings
        await Setting.create({ key: 'shop_name', value: 'Amwaj Almesela' });
        await Setting.create({ key: 'currency', value: 'QAR' });
        await Setting.create({ key: 'tax_rate', value: '5' });
        console.log('✅ Default settings and coupons seeded.');

        console.log('🎉 Database seeding completed successfully.');
        process.exit(0);
    } catch (err) {
        console.error('❌ Seeding error:', err);
        process.exit(1);
    }
};

seed();
