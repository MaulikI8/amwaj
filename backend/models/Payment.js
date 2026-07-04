const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Payment = sequelize.define('payments', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    order_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    method: {
        type: DataTypes.ENUM('credit_card', 'debit_card', 'bank_transfer', 'cash_on_delivery', 'wallet'),
        allowNull: false,
        defaultValue: 'cash_on_delivery'
    },
    transaction_id: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    amount: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    status: {
        type: DataTypes.ENUM('pending', 'processing', 'completed', 'failed', 'refunded'),
        defaultValue: 'pending'
    },
    paid_at: {
        type: DataTypes.DATE,
        allowNull: true
    }
});

module.exports = Payment;
