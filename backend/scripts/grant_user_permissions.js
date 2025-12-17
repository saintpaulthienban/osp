const mysql = require("mysql2/promise");
require("dotenv").config();

async function grantUserPermissions() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hoidong_osp",
  });

  try {
    // Find admin user
    const [admins] = await connection.execute(
      "SELECT id, username FROM users WHERE is_admin = 1 OR is_super_admin = 1 LIMIT 5"
    );
    console.log("Admin users found:", admins);

    if (admins.length === 0) {
      console.log("No admin users found!");
      return;
    }

    // Get user-related permissions
    const [permissions] = await connection.execute(
      `SELECT id, name FROM permissions WHERE name LIKE 'users_%' OR name LIKE 'permissions_%'`
    );
    console.log("User permissions available:", permissions);

    // Grant permissions to each admin
    for (const admin of admins) {
      for (const perm of permissions) {
        await connection.execute(
          "INSERT IGNORE INTO user_permissions (user_id, permission_id) VALUES (?, ?)",
          [admin.id, perm.id]
        );
      }
      console.log("Granted permissions to:", admin.username);
    }

    // Verify
    const [granted] = await connection.execute(
      `SELECT u.username, p.name FROM user_permissions up 
       JOIN users u ON up.user_id = u.id 
       JOIN permissions p ON up.permission_id = p.id 
       WHERE p.name LIKE 'users_%' OR p.name LIKE 'permissions_%'`
    );
    console.log("Granted user permissions:", granted);
  } finally {
    await connection.end();
  }
}

grantUserPermissions().catch(console.error);
