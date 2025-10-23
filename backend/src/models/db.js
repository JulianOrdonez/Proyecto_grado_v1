const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'Root@2025',
  database: 'monitoreo_energia',
  port: 3306,
});

module.exports = pool;

