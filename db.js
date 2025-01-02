const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
});

async function getDataFromDatabase() {
    const [rows] = await pool.query('SELECT id, name, description, price, stock FROM products');
    return rows;
}

module.exports = { getDataFromDatabase };
