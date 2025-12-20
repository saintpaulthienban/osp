const db = require("../config/database");

(async () => {
  try {
    const [cols] = await db.execute("DESCRIBE sisters");
    console.log("Sisters table columns:");
    cols.forEach((c) => console.log(`  ${c.Field} (${c.Type})`));
    await db.end();
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
})();
