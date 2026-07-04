const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Address = sequelize.define('addresses', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    label: {
        type: DataTypes.STRING(50),
        allowNull: true,
        defaultValue: 'Home'
    },
    full_name: {
        type: DataTypes.STRING(100),
        allowNull: false
    },
    phone: {
        type: DataTypes.STRING(20),
        allowNull: false
    },
    address_line1: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    address_line2: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    city: {
        type: DataTypes.STRING(100),
        allowNull: false
    },
    state: {
        type: DataTypes.STRING(100),
        allowNull: true
    },
    country: {
        type: DataTypes.STRING(100),
        allowNull: false,
        defaultValue: 'Qatar'
    },
    zip_code: {
        type: DataTypes.STRING(20),
        allowNull: true
    },
    is_default: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    }
});

module.exports = Address;
