const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Inventory = sequelize.define('inventory', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    product_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        unique: true
    },
    quantity: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0
    },
    low_stock_threshold: {
        type: DataTypes.INTEGER,
        defaultValue: 5
    },
    warehouse_location: {
        type: DataTypes.STRING(100),
        allowNull: true
    }
});

module.exports = Inventory;
