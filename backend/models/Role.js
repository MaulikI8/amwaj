const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Role = sequelize.define('roles', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: DataTypes.STRING(50),
        allowNull: false,
        unique: true
    },
    permissions: {
        type: DataTypes.TEXT,
        defaultValue: '[]',
        get() {
            const raw = this.getDataValue('permissions');
            return raw ? JSON.parse(raw) : [];
        },
        set(val) {
            this.setDataValue('permissions', JSON.stringify(val));
        }
    }
});

module.exports = Role;
