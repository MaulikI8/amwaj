const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Image = sequelize.define('images', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    product_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    url: {
        type: DataTypes.STRING(500),
        allowNull: false
    },
    alt_text: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    is_primary: {
        type: DataTypes.BOOLEAN,
        defaultValue: false
    },
    position: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    }
});

module.exports = Image;
