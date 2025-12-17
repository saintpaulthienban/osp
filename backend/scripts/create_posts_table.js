// backend/scripts/create_posts_table.js

const fs = require("fs");
const path = require("path");
require("dotenv").config({ path: path.resolve(__dirname, "../.env") });

const db = require("../src/config/database");

async function createPostsTable() {
  try {
    console.log("Creating posts table...");

    // Read SQL file
    const sqlPath = path.join(
      __dirname,
      "../src/migrations/create_posts_table.sql"
    );
    const sql = fs.readFileSync(sqlPath, "utf8");

    // Split by semicolons and execute each statement
    const statements = sql
      .split(";")
      .map((s) => s.trim())
      .filter((s) => s.length > 0 && !s.startsWith("--"));

    for (const statement of statements) {
      try {
        await db.query(statement);
        console.log("✓ Executed:", statement.substring(0, 50) + "...");
      } catch (error) {
        if (error.code === "ER_DUP_ENTRY") {
          console.log(
            "⚠ Skipped (duplicate):",
            statement.substring(0, 50) + "..."
          );
        } else if (error.code === "ER_TABLE_EXISTS_ERROR") {
          console.log("⚠ Table already exists");
        } else {
          console.error("✗ Error:", error.message);
        }
      }
    }

    console.log("\n✅ Posts table created successfully!");
    process.exit(0);
  } catch (error) {
    console.error("Error creating posts table:", error.message);
    process.exit(1);
  }
}

createPostsTable();
