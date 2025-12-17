const mysql = require("mysql2/promise");
require("dotenv").config();

(async () => {
  const c = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  const [perms] = await c.execute(
    "SELECT name, module FROM permissions ORDER BY module, name"
  );
  console.log("\nPermissions in DB:");
  perms.forEach((p) => console.log(`  ${p.module}: ${p.name}`));

  console.log("\n\nChecking routes requirements:");
  const routePerms = [
    "sisters.view_list",
    "sisters.view_detail",
    "sisters.create",
    "sisters.edit",
    "sisters.delete",
    "users.view",
    "users.create",
    "users.edit",
    "users.delete",
  ];

  for (const rp of routePerms) {
    const exists = perms.find((p) => p.name === rp);
    console.log(`  ${rp}: ${exists ? "✅ EXISTS" : "❌ MISSING"}`);
  }

  await c.end();
})();
