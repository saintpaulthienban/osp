const db = require("../src/config/database");

async function checkVocationPermissions() {
  try {
    // Check permissions with vocation in name
    const [vocationPerms] = await db.query(
      "SELECT id, name, module FROM permissions WHERE name LIKE '%vocation%'"
    );
    console.log('Permissions with "vocation" in name:', vocationPerms);

    // Check permissions with journey-related module names
    const [journeyPerms] = await db.query(
      "SELECT id, name, module FROM permissions WHERE module LIKE '%hành%' OR module LIKE '%journey%' OR module LIKE '%ơn gọi%'"
    );
    console.log("\nPermissions with journey-related module:", journeyPerms);

    // List all unique modules
    const [modules] = await db.query(
      "SELECT DISTINCT module FROM permissions ORDER BY module"
    );
    console.log(
      "\nAll modules:",
      modules.map((m) => m.module)
    );

    // Check admin's permissions
    const [adminPerms] = await db.query(`
      SELECT p.name, p.module 
      FROM user_permissions up 
      JOIN permissions p ON up.permission_id = p.id 
      JOIN users u ON up.user_id = u.id 
      WHERE u.username = 'admin' AND p.name LIKE '%vocation%'
    `);
    console.log("\nAdmin vocation permissions:", adminPerms);

    process.exit(0);
  } catch (error) {
    console.error("Error:", error);
    process.exit(1);
  }
}

checkVocationPermissions();
