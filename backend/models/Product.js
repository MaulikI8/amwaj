const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Product = sequelize.define('products', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    slug: {
        type: DataTypes.STRING(300),
        allowNull: false,
        unique: true
    },
    description: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    price: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
        defaultValue: 0
    },
    discount_price: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: true
    },
    sku: {
        type: DataTypes.STRING(100),
        allowNull: true,
        unique: true
    },
    category_id: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    brand_id: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    featured: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    },
    best_selling: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    },
    top_rated: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    },
    is_active: {
        type: DataTypes.BOOLEAN,
        defaultValue: true
    },
    meta_title: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    meta_description: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    total_sold: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    },
    view_count: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    }
});

module.exports = Product;
