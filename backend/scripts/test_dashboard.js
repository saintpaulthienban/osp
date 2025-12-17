// backend/scripts/test_dashboard.js
const SisterModel = require("../src/models/SisterModel");
const CommunityModel = require("../src/models/CommunityModel");
const PostModel = require("../src/models/PostModel");
const AuditLogModel = require("../src/models/AuditLogModel");

(async () => {
  try {
    console.log("Testing Dashboard queries...\n");

    // Test 1: Total sisters
    const [totalSisters] = await SisterModel.executeQuery(
      "SELECT COUNT(*) as total FROM sisters"
    );
    console.log("✓ Total sisters:", totalSisters?.total || 0);

    // Test 2: Active sisters
    const [activeSisters] = await SisterModel.executeQuery(
      "SELECT COUNT(*) as total FROM sisters WHERE status = 'active'"
    );
    console.log("✓ Active sisters:", activeSisters?.total || 0);

    // Test 3: Total communities
    const [totalCommunities] = await CommunityModel.executeQuery(
      "SELECT COUNT(*) as total FROM communities"
    );
    console.log("✓ Total communities:", totalCommunities?.total || 0);

    // Test 4: Average age
    const [avgAge] = await SisterModel.executeQuery(
      `SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()))) as avg_age 
       FROM sisters WHERE status = 'active' AND date_of_birth IS NOT NULL`
    );
    console.log("✓ Average age:", avgAge?.avg_age || "N/A");

    // Test 5: Recent posts
    const posts = await PostModel.executeQuery(
      `SELECT id, title, category FROM posts WHERE status = 'published' AND deleted_at IS NULL ORDER BY created_at DESC LIMIT 5`
    );
    console.log("✓ Recent posts:", posts.length);

    // Test 6: Audit logs
    const logs = await AuditLogModel.executeQuery(
      `SELECT id, action, table_name FROM audit_logs ORDER BY created_at DESC LIMIT 5`
    );
    console.log("✓ Recent audit logs:", logs.length);

    console.log("\n✅ All dashboard queries working!");

    // Print summary
    console.log("\n--- Dashboard Summary ---");
    console.log(
      JSON.stringify(
        {
          totalSisters: totalSisters?.total || 0,
          activeSisters: activeSisters?.total || 0,
          totalCommunities: totalCommunities?.total || 0,
          averageAge: avgAge?.avg_age || 0,
          recentPosts: posts.length,
          recentLogs: logs.length,
        },
        null,
        2
      )
    );

    process.exit(0);
  } catch (error) {
    console.error("❌ Error:", error.message);
    process.exit(1);
  }
})();
