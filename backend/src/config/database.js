const mysql = require("mysql2/promise");
const path = require("path");
const dotenv = require("dotenv");

// Ensure environment variables are loaded when this module is imported
dotenv.config({ path: path.resolve(__dirname, "../../.env") });

const {
  MYSQL_URL,
  DATABASE_URL,
  DB_HOST,
  DB_PORT,
  DB_USER,
  DB_PASSWORD,
  DB_NAME,
  MYSQLHOST,
  MYSQLPORT,
  MYSQLUSER,
  MYSQLPASSWORD,
  MYSQLDATABASE,
} = process.env;

let pool;

// Priority 1: Use connection URL if available (Railway preferred method)
if (MYSQL_URL || DATABASE_URL) {
  const connectionUrl = MYSQL_URL || DATABASE_URL;
  console.log("Using MySQL connection URL");
  pool = mysql.createPool({
    uri: connectionUrl,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
  });
} else {
  // Priority 2: Use individual connection parameters
  const host = MYSQLHOST || DB_HOST;
  const port = MYSQLPORT || DB_PORT || 3306;
  const user = MYSQLUSER || DB_USER;
  const password = MYSQLPASSWORD || DB_PASSWORD;
  const database = MYSQLDATABASE || DB_NAME;

  if (!host || !user || !database) {
    throw new Error(
      "Missing required database environment variables. Need either MYSQL_URL/DATABASE_URL or DB_HOST/MYSQLHOST, DB_USER/MYSQLUSER, and DB_NAME/MYSQLDATABASE"
    );
  }

  console.log(`Connecting to MySQL at ${host}:${port}/${database}`);
  pool = mysql.createPool({
    host,
    port: Number(port),
    user,
    password,
    database,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
  });
}

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
