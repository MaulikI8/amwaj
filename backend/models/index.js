const sequelize = require('../config/database');

// Import all models
const User = require('./User');
const Role = require('./Role');
const Product = require('./Product');
const Category = require('./Category');
const Brand = require('./Brand');
const Image = require('./Image');
const Inventory = require('./Inventory');
const Cart = require('./Cart');
const CartItem = require('./CartItem');
const Order = require('./Order');
const OrderItem = require('./OrderItem');
const Payment = require('./Payment');
const Coupon = require('./Coupon');
const Review = require('./Review');
const Address = require('./Address');
const Wishlist = require('./Wishlist');
const Notification = require('./Notification');
const Setting = require('./Setting');
const Banner = require('./Banner');
const Blog = require('./Blog');

// ── Associations ──

// Role <-> User
Role.hasMany(User, { foreignKey: 'role_id', as: 'users' });
User.belongsTo(Role, { foreignKey: 'role_id', as: 'role' });

// Category self-referencing (parent/children)
Category.hasMany(Category, { foreignKey: 'parent_id', as: 'children' });
Category.belongsTo(Category, { foreignKey: 'parent_id', as: 'parent' });

// Category <-> Product
Category.hasMany(Product, { foreignKey: 'category_id', as: 'products' });
Product.belongsTo(Category, { foreignKey: 'category_id', as: 'category' });

// Brand <-> Product
Brand.hasMany(Product, { foreignKey: 'brand_id', as: 'products' });
Product.belongsTo(Brand, { foreignKey: 'brand_id', as: 'brand' });

// Product <-> Image
Product.hasMany(Image, { foreignKey: 'product_id', as: 'images' });
Image.belongsTo(Product, { foreignKey: 'product_id', as: 'product' });

// Product <-> Inventory (1:1)
Product.hasOne(Inventory, { foreignKey: 'product_id', as: 'inventory' });
Inventory.belongsTo(Product, { foreignKey: 'product_id', as: 'product' });

// User <-> Cart (1:1)
User.hasOne(Cart, { foreignKey: 'user_id', as: 'cart' });
Cart.belongsTo(User, { foreignKey: 'user_id', as: 'user' });

// Cart <-> CartItem
Cart.hasMany(CartItem, { foreignKey: 'cart_id', as: 'items' });
CartItem.belongsTo(Cart, { foreignKey: 'cart_id', as: 'cart' });

// CartItem <-> Product
Product.hasMany(CartItem, { foreignKey: 'product_id', as: 'cartItems' });
CartItem.belongsTo(Product, { foreignKey: 'product_id', as: 'product' });

// User <-> Order
User.hasMany(Order, { foreignKey: 'user_id', as: 'orders' });
Order.belongsTo(User, { foreignKey: 'user_id', as: 'user' });

// Order <-> OrderItem
Order.hasMany(OrderItem, { foreignKey: 'order_id', as: 'items' });
OrderItem.belongsTo(Order, { foreignKey: 'order_id', as: 'order' });

// OrderItem <-> Product
Product.hasMany(OrderItem, { foreignKey: 'product_id', as: 'orderItems' });
OrderItem.belongsTo(Product, { foreignKey: 'product_id', as: 'product' });

// Order <-> Payment (1:1)
Order.hasOne(Payment, { foreignKey: 'order_id', as: 'payment' });
Payment.belongsTo(Order, { foreignKey: 'order_id', as: 'order' });

// Order <-> Coupon
Coupon.hasMany(Order, { foreignKey: 'coupon_id', as: 'orders' });
Order.belongsTo(Coupon, { foreignKey: 'coupon_id', as: 'coupon' });

// Order <-> Address (shipping & billing)
Order.belongsTo(Address, { foreignKey: 'shipping_address_id', as: 'shippingAddress' });
Order.belongsTo(Address, { foreignKey: 'billing_address_id', as: 'billingAddress' });

// User <-> Review
User.hasMany(Review, { foreignKey: 'user_id', as: 'reviews' });
Review.belongsTo(User, { foreignKey: 'user_id', as: 'user' });

// Product <-> Review
Product.hasMany(Review, { foreignKey: 'product_id', as: 'reviews' });
Review.belongsTo(Product, { foreignKey: 'product_id', as: 'product' });

// User <-> Address
User.hasMany(Address, { foreignKey: 'user_id', as: 'addresses' });
Address.belongsTo(User, { foreignKey: 'user_id', as: 'user' });

// User <-> Wishlist
User.hasMany(Wishlist, { foreignKey: 'user_id', as: 'wishlists' });
Wishlist.belongsTo(User, { foreignKey: 'user_id', as: 'user' });

// Product <-> Wishlist
Product.hasMany(Wishlist, { foreignKey: 'product_id', as: 'wishlists' });
Wishlist.belongsTo(Product, { foreignKey: 'product_id', as: 'product' });

// User <-> Notification
User.hasMany(Notification, { foreignKey: 'user_id', as: 'notifications' });
Notification.belongsTo(User, { foreignKey: 'user_id', as: 'user' });

// User <-> Blog (author)
User.hasMany(Blog, { foreignKey: 'author_id', as: 'blogs' });
Blog.belongsTo(User, { foreignKey: 'author_id', as: 'author' });

module.exports = {
    sequelize,
    User,
    Role,
    Product,
    Category,
    Brand,
    Image,
    Inventory,
    Cart,
    CartItem,
    Order,
    OrderItem,
    Payment,
    Coupon,
    Review,
    Address,
    Wishlist,
    Notification,
    Setting,
    Banner,
    Blog
};
