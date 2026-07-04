const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Setting = sequelize.define('settings', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    key: {
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: true
    },
    value: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    group: {
        type: DataTypes.STRING(50),
        defaultValue: 'general'
    }
});

module.exports = Setting;
