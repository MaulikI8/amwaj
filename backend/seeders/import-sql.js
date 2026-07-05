const fs = require('fs');
const path = require('path');
const dotenv = require('dotenv');

// Load environment variables from backend/.env
dotenv.config({ path: path.join(__dirname, '..', '.env') });

const sequelize = require('../config/database');

const importSql = async () => {
    try {
        console.log('🔄 Connecting to database...');
        await sequelize.authenticate();
        console.log('✅ Connection established successfully.');

        // Path to the postgres import file
        const sqlPath = path.join(__dirname, '..', '..', 'amwaj-products-postgres-import.sql');
        
        if (!fs.existsSync(sqlPath)) {
            console.error(`❌ Error: Could not find SQL import file at ${sqlPath}`);
            process.exit(1);
        }

        console.log('📖 Reading amwaj-products-postgres-import.sql...');
        const sqlContent = fs.readFileSync(sqlPath, 'utf8');

        console.log('🚀 Executing SQL queries against database (this may take a few moments)...');
        
        // Execute the SQL file contents directly
        await sequelize.query(sqlContent);

        console.log('🎉 PostgreSQL import completed successfully!');
        process.exit(0);
    } catch (err) {
        console.error('❌ SQL Import error:', err);
        process.exit(1);
    }
};

importSql();
