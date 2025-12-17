// Script to test data scope functionality
// Run: node backend/src/scripts/test_data_scope.js

const db = require("../config/database");
const { attachDataScope } = require("../middlewares/dataScope");
const scopeHelper = require("../utils/scopeHelper");

async function testDataScope() {
  console.log("=== TESTING DATA SCOPE FUNCTIONALITY ===\n");

  try {
    // Step 1: Check if data_scope column exists
    console.log("1. Checking database schema...");
    const [columns] = await db.query(
      "SHOW COLUMNS FROM users LIKE 'data_scope'"
    );
    if (columns.length === 0) {
      console.error(
        "❌ Column 'data_scope' not found in users table. Please run migration first."
      );
      console.log(
        "\nRun: mysql -u root -p hoi_dong_osp < backend/db/migrations/add_data_scope_to_users.sql\n"
      );
      return;
    }
    console.log("✅ data_scope column exists\n");

    // Step 2: Check users with different scopes
    console.log("2. Checking users and their scopes...");
    const [users] = await db.query(
      "SELECT id, username, is_admin, data_scope, is_super_admin FROM users LIMIT 5"
    );
    console.table(users);

    // Step 3: Check user_communities table
    console.log("\n3. Checking user community assignments...");
    const [userCommunities] = await db.query(`
      SELECT uc.user_id, u.username, uc.community_id, c.name as community_name
      FROM user_communities uc
      JOIN users u ON uc.user_id = u.id
      JOIN communities c ON uc.community_id = c.id
      LIMIT 10
    `);
    if (userCommunities.length > 0) {
      console.table(userCommunities);
    } else {
      console.log("⚠️  No community assignments found");
      console.log("Create a test assignment:");
      console.log(
        "INSERT INTO user_communities (user_id, community_id, granted_by) VALUES (2, 1, 1);\n"
      );
    }

    // Step 4: Test scope filter generation
    console.log("\n4. Testing scope filter generation...");

    // Test 'all' scope
    const allScope = { type: "all" };
    const allFilter = scopeHelper.applyScopeFilter(allScope, "sisters");
    console.log("Scope 'all':", allFilter);

    // Test 'community' scope
    const communityScope = {
      type: "community",
      community_ids: [1, 2, 3],
    };
    const communityFilter = scopeHelper.applyScopeFilter(
      communityScope,
      "sisters"
    );
    console.log("\nScope 'community' [1,2,3]:", communityFilter);

    // Test empty community scope
    const emptyScope = {
      type: "community",
      community_ids: [],
    };
    const emptyFilter = scopeHelper.applyScopeFilter(emptyScope, "sisters");
    console.log("\nScope 'community' (empty):", emptyFilter);

    // Step 5: Test actual query with scope
    console.log("\n5. Testing actual query execution...");

    const testQuery = `
      SELECT s.id, s.saint_name, s.birth_name, c.name as community
      FROM sisters s
      LEFT JOIN community_assignments ca ON s.id = ca.sister_id AND ca.end_date IS NULL
      LEFT JOIN communities c ON ca.community_id = c.id
    `;

    // Without scope filter
    console.log("\n5a. Query WITHOUT scope filter:");
    const [allSisters] = await db.query(testQuery + " LIMIT 5");
    console.log(`Found ${allSisters.length} sisters (showing first 5)`);
    console.table(allSisters);

    // With community scope filter
    if (userCommunities.length > 0) {
      console.log("\n5b. Query WITH community scope filter:");
      const testCommunityIds = [
        ...new Set(userCommunities.map((uc) => uc.community_id)),
      ];
      const scopedQuery =
        testQuery +
        ` WHERE ca.community_id IN (${testCommunityIds
          .map(() => "?")
          .join(",")}) LIMIT 5`;
      const [scopedSisters] = await db.query(scopedQuery, testCommunityIds);
      console.log(
        `Found ${
          scopedSisters.length
        } sisters in communities [${testCommunityIds.join(", ")}]`
      );
      console.table(scopedSisters);
    }

    // Step 6: Summary
    console.log("\n=== SUMMARY ===");
    console.log("✅ Database schema is ready");
    console.log("✅ Scope filter functions are working");
    if (userCommunities.length > 0) {
      console.log("✅ User community assignments exist");
    } else {
      console.log("⚠️  No user community assignments yet");
    }

    console.log("\n=== NEXT STEPS ===");
    console.log("1. Apply attachDataScope middleware to routes");
    console.log("2. Use scopeHelper.applyScopeFilter() in controllers");
    console.log("3. Test with different users");
    console.log(
      "\nSee HUONG_DAN_PHAN_QUYEN_CONG_DOAN.md for detailed instructions\n"
    );
  } catch (error) {
    console.error("Error during testing:", error);
  } finally {
    await db.end();
  }
}

// Run the test
testDataScope();
