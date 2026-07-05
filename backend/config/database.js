const { Sequelize } = require('sequelize');
const path = require('path');

let sequelize;

if (process.env.POSTGRES_URL || process.env.DATABASE_URL) {
    const connectionUri = process.env.POSTGRES_URL || process.env.DATABASE_URL;
    sequelize = new Sequelize(connectionUri, {
        dialect: 'postgres',
        logging: false,
        define: {
            timestamps: true,
            underscored: true,
            freezeTableName: true
        },
        dialectOptions: {
            ssl: {
                require: true,
                rejectUnauthorized: false
            }
        }
    });
} else if (process.env.DB_DIALECT && process.env.DB_DIALECT !== 'sqlite') {
    sequelize = new Sequelize(
        process.env.DB_NAME,
        process.env.DB_USER,
        process.env.DB_PASSWORD,
        {
            host: process.env.DB_HOST || 'localhost',
            port: parseInt(process.env.DB_PORT) || (process.env.DB_DIALECT === 'postgres' ? 5432 : 3306),
            dialect: process.env.DB_DIALECT,
            logging: false,
            define: {
                timestamps: true,
                underscored: true,
                freezeTableName: true
            },
            dialectOptions: process.env.DB_SSL === 'true' ? {
                ssl: {
                    require: true,
                    rejectUnauthorized: false
                }
            } : {}
        }
    );
} else {
    const storagePath = process.env.VERCEL
        ? '/tmp/database.sqlite'
        : path.join(__dirname, '..', 'database.sqlite');
    sequelize = new Sequelize({
        dialect: 'sqlite',
        storage: storagePath,
        logging: false,
        define: {
            timestamps: true,
            underscored: true,
            freezeTableName: true
        }
    });
}

module.exports = sequelize;
