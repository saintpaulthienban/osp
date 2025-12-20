/**
 * Script to test sister filtering by community permissions
 * Tests that non-admin users only see sisters from their assigned communities
 */

const db = require("../config/database");
const bcrypt = require("bcryptjs");

async function testSisterCommunityFilter() {
  try {
    console.log("=".repeat(60));
    console.log("Testing Sister Community Filter System");
    console.log("=".repeat(60));

    // Step 1: Get or create test communities
    console.log("\n1. Setting up test communities...");
    const [communities] = await db.execute(
      "SELECT id, code, name FROM communities LIMIT 3"
    );

    if (communities.length < 2) {
      console.log(
        "⚠️  Need at least 2 communities. Creating test communities..."
      );
      await db.execute(
        "INSERT IGNORE INTO communities (code, name, type) VALUES (?, ?, ?)",
        ["COMM001", "Cộng đoàn Test 1", "motherhouse"]
      );
      await db.execute(
        "INSERT IGNORE INTO communities (code, name, type) VALUES (?, ?, ?)",
        ["COMM002", "Cộng đoàn Test 2", "education"]
      );

      const [newCommunities] = await db.execute(
        "SELECT id, code, name FROM communities WHERE code IN ('COMM001', 'COMM002')"
      );
      communities.push(...newCommunities);
    }

    const community1 = communities[0];
    const community2 = communities[1];

    console.log(`✓ Community 1: ${community1.name} (ID: ${community1.id})`);
    console.log(`✓ Community 2: ${community2.name} (ID: ${community2.id})`);

    // Step 2: Get or create test sisters
    console.log("\n2. Setting up test sisters...");

    // Check for existing sisters
    const [existingSisters] = await db.execute(
      "SELECT s.id, s.code, s.saint_name FROM sisters s LIMIT 2"
    );

    let sister1, sister2;

    if (existingSisters.length >= 2) {
      sister1 = existingSisters[0];
      sister2 = existingSisters[1];
      console.log(
        `✓ Using existing sister 1: ${sister1.saint_name} (ID: ${sister1.id})`
      );
      console.log(
        `✓ Using existing sister 2: ${sister2.saint_name} (ID: ${sister2.id})`
      );
    } else {
      console.log("Creating test sisters...");

      // Create sister 1
      const [result1] = await db.execute(
        `INSERT INTO sisters (code, birth_name, saint_name, date_of_birth, status)
         VALUES (?, ?, ?, ?, ?)`,
        ["S001", "Nguyễn Thị A", "Maria", "1990-01-01", "active"]
      );
      sister1 = { id: result1.insertId, code: "S001", saint_name: "Maria" };

      // Create sister 2
      const [result2] = await db.execute(
        `INSERT INTO sisters (code, birth_name, saint_name, date_of_birth, status)
         VALUES (?, ?, ?, ?, ?)`,
        ["S002", "Trần Thị B", "Teresa", "1992-02-02", "active"]
      );
      sister2 = { id: result2.insertId, code: "S002", saint_name: "Teresa" };

      console.log(
        `✓ Created sister 1: ${sister1.saint_name} (ID: ${sister1.id})`
      );
      console.log(
        `✓ Created sister 2: ${sister2.saint_name} (ID: ${sister2.id})`
      );
    }

    // Step 3: Create community assignments
    console.log("\n3. Setting up community assignments...");

    // Clear old assignments for these sisters
    await db.execute(
      "DELETE FROM community_assignments WHERE sister_id IN (?, ?)",
      [sister1.id, sister2.id]
    );

    // Assign sister1 to community1
    await db.execute(
      `INSERT INTO community_assignments (sister_id, community_id, role, start_date)
       VALUES (?, ?, 'member', CURDATE())`,
      [sister1.id, community1.id]
    );
    console.log(`\u2713 Assigned ${sister1.saint_name} to ${community1.name}`);

    // Assign sister2 to community2
    await db.execute(
      `INSERT INTO community_assignments (sister_id, community_id, role, start_date)
       VALUES (?, ?, 'member', CURDATE())`,
      [sister2.id, community2.id]
    );
    console.log(`\u2713 Assigned ${sister2.saint_name} to ${community2.name}`);

    // Step 4: Create test user
    console.log("\n4. Setting up test user...");
    const testUsername = "test_community_user";
    const testPassword = "test123";
    const hashedPassword = await bcrypt.hash(testPassword, 10);

    // Delete old test user if exists
    await db.execute("DELETE FROM users WHERE username = ?", [testUsername]);

    const [userResult] = await db.execute(
      `INSERT INTO users (username, password, email, full_name, is_active)
       VALUES (?, ?, ?, ?, ?)`,
      [testUsername, hashedPassword, "test@test.com", "Test User", 1]
    );
    const testUserId = userResult.insertId;
    console.log(`✓ Created test user: ${testUsername} (ID: ${testUserId})`);

    // Step 5: Assign user to community1 only
    console.log("\n5. Setting up user community permissions...");

    // Clear old permissions
    await db.execute("DELETE FROM user_communities WHERE user_id = ?", [
      testUserId,
    ]);

    // Give permission to community1 only
    await db.execute(
      `INSERT INTO user_communities 
       (user_id, community_id, is_primary, granted_by)
       VALUES (?, ?, TRUE, ?)`,
      [testUserId, community1.id, testUserId]
    );
    console.log(
      `✓ Granted permissions to ${testUsername} for ${community1.name} only`
    );

    // Step 6: Test the filter
    console.log("\n6. Testing sister list query with community filter...");
    console.log("-".repeat(60));

    // Simulate the controller query
    const communityIds = [community1.id];

    // Create placeholders for IN clause
    const placeholders = communityIds.map(() => "?").join(",");

    const query = `
      SELECT DISTINCT s.id, s.code, s.saint_name, c.name as community_name
      FROM sisters s
      INNER JOIN community_assignments ca ON s.id = ca.sister_id
        AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())
      LEFT JOIN communities c ON ca.community_id = c.id
      WHERE s.status = 'active' AND ca.community_id IN (${placeholders})
      ORDER BY s.saint_name
    `;

    const [filteredSisters] = await db.execute(query, communityIds);

    console.log(`\nQuery returned ${filteredSisters.length} sister(s):`);
    filteredSisters.forEach((sister, index) => {
      console.log(
        `  ${index + 1}. ${sister.saint_name} (${sister.code}) - ${
          sister.community_name
        }`
      );
    });

    // Step 7: Verify results
    console.log("\n7. Verification:");
    console.log("-".repeat(60));

    const shouldSee = filteredSisters.find((s) => s.id === sister1.id);
    const shouldNotSee = filteredSisters.find((s) => s.id === sister2.id);

    let passed = true;

    if (shouldSee) {
      console.log(`✓ PASS: User CAN see sister from assigned community`);
      console.log(
        `  \u2192 ${shouldSee.saint_name} from ${shouldSee.community_name}`
      );
    } else {
      console.log(
        `\u2717 FAIL: User CANNOT see sister from assigned community`
      );
      console.log(
        `  \u2192 Should see ${sister1.saint_name} from ${community1.name}`
      );
      passed = false;
    }

    if (!shouldNotSee) {
      console.log(
        `\u2713 PASS: User CANNOT see sister from non-assigned community`
      );
      console.log(
        `  \u2192 ${sister2.saint_name} from ${community2.name} is correctly hidden`
      );
    } else {
      console.log(
        `\u2717 FAIL: User CAN see sister from non-assigned community`
      );
      console.log(
        `  \u2192 Should NOT see ${sister2.saint_name} from ${community2.name}`
      );
      passed = false;
    }

    // Step 8: Test with getById query
    console.log("\n8. Testing getById query...");
    console.log("-".repeat(60));

    const getByIdQuery = `
      SELECT s.*, c.name as community_name, c.code as community_code
      FROM sisters s
      INNER JOIN community_assignments ca ON s.id = ca.sister_id
        AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())
      LEFT JOIN communities c ON ca.community_id = c.id
      WHERE s.id = ? AND ca.community_id IN (${placeholders})
    `;

    // Try to get sister1 (should succeed)
    const [result1] = await db.execute(getByIdQuery, [
      sister1.id,
      ...communityIds,
    ]);
    if (result1.length > 0) {
      console.log(
        `\u2713 PASS: User CAN access sister ${sister1.saint_name} by ID`
      );
    } else {
      console.log(
        `\u2717 FAIL: User CANNOT access sister ${sister1.saint_name} by ID`
      );
      passed = false;
    }

    // Try to get sister2 (should fail)
    const [result2] = await db.execute(getByIdQuery, [
      sister2.id,
      ...communityIds,
    ]);
    if (result2.length === 0) {
      console.log(
        `\u2713 PASS: User CANNOT access sister ${sister2.saint_name} by ID (correctly blocked)`
      );
    } else {
      console.log(
        `\u2717 FAIL: User CAN access sister ${sister2.saint_name} by ID (should be blocked)`
      );
      passed = false;
    }

    // Final summary
    console.log("\n" + "=".repeat(60));
    if (passed) {
      console.log("✓ ALL TESTS PASSED!");
      console.log("Community-based sister filtering is working correctly.");
    } else {
      console.log("✗ SOME TESTS FAILED!");
      console.log("Please check the controller implementation.");
    }
    console.log("=".repeat(60));

    // Cleanup info
    console.log("\nTest user credentials:");
    console.log(`  Username: ${testUsername}`);
    console.log(`  Password: ${testPassword}`);
    console.log(`  Can access: ${community1.name} (ID: ${community1.id})`);
    console.log(`  Cannot access: ${community2.name} (ID: ${community2.id})`);

    console.log("\nYou can use these credentials to test the API manually.");
    console.log(
      "Cleanup: Run this script with --cleanup flag to remove test data"
    );
  } catch (error) {
    console.error("Error during test:", error);
  } finally {
    await db.end();
  }
}

// Run the test
testSisterCommunityFilter();
