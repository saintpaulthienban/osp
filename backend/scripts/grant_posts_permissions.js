// Script to grant posts permissions to admin users
const db = require("../src/config/database");

async function run() {
  try {
    console.log("🔍 Finding posts permissions...");
    const [perms] = await db.query(
      "SELECT id, name FROM permissions WHERE module = ?",
      ["posts"]
    );
    console.log("Posts permissions:", perms);

    console.log("\n🔍 Finding admin users...");
    const [admins] = await db.query(
      "SELECT id, username FROM users WHERE is_admin = 1"
    );
    console.log("Admin users:", admins);

    console.log("\n🔑 Granting permissions...");
    for (const user of admins) {
      for (const perm of perms) {
        await db.query(
          "INSERT IGNORE INTO user_permissions (user_id, permission_id, granted_by) VALUES (?, ?, ?)",
          [user.id, perm.id, user.id]
        );
        console.log(`  ✅ Granted ${perm.name} to ${user.username}`);
      }
    }

    console.log("\n✅ Done!");
    process.exit(0);
  } catch (e) {
    console.error("❌ Error:", e);
    process.exit(1);
  }
}

run();
