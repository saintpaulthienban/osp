const mysql = require("mysql2/promise");
const path = require("path");
const dotenv = require("dotenv");

// Ensure environment variables are loaded when this module is imported
dotenv.config({ path: path.resolve(__dirname, "../../.env") });

// Support both local .env format and Railway's auto-injected variables
const {
  DB_HOST,
  DB_PORT,
  DB_USER,
  DB_PASSWORD,
  DB_NAME,
  // Railway MySQL plugin variables
  MYSQLHOST,
  MYSQLPORT,
  MYSQLUSER,
  MYSQLPASSWORD,
  MYSQLDATABASE,
} = process.env;

// Use Railway variables if available, otherwise fall back to standard names
const host = MYSQLHOST || DB_HOST;
const port = MYSQLPORT || DB_PORT || 3306;
const user = MYSQLUSER || DB_USER;
const password = MYSQLPASSWORD || DB_PASSWORD;
const database = MYSQLDATABASE || DB_NAME;

if (!host || !user || !database) {
  throw new Error(
    "Missing required database environment variables. Need DB_HOST/MYSQLHOST, DB_USER/MYSQLUSER, and DB_NAME/MYSQLDATABASE"
  );
}

const pool = mysql.createPool({
  host,
  port: Number(port),
  user,
  password,
  database,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

(async () => {
  try {
    const connection = await pool.getConnection();
    connection.release();
    console.log("MySQL connection pool established successfully.");
  } catch (error) {
    console.error("Failed to initialize MySQL connection pool:", error.message);
    throw error;
  }
})();

module.exports = pool;
