const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Cart = sequelize.define('carts', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    session_id: {
        type: DataTypes.STRING(255),
        allowNull: true
    }
});

module.exports = Cart;
