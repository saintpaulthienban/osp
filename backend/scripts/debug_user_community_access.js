/**
 * Script to debug community access for a user
 */

const db = require("../config/database");

async function debugUserCommunityAccess(username) {
  try {
    console.log("=".repeat(60));
    console.log(`Debugging Community Access for: ${username}`);
    console.log("=".repeat(60));

    // Get user info
    const [users] = await db.execute(
      "SELECT id, username, email, full_name, is_admin, is_super_admin FROM users WHERE username = ?",
      [username]
    );

    if (users.length === 0) {
      console.log(`❌ User "${username}" not found!`);
      await db.end();
      return;
    }

    const user = users[0];
    console.log("\n1. User Information:");
    console.log(`   ID: ${user.id}`);
    console.log(`   Username: ${user.username}`);
    console.log(`   Full Name: ${user.full_name || 'N/A'}`);
    console.log(`   Email: ${user.email}`);
    console.log(`   Is Admin: ${user.is_admin ? '✅ YES' : '❌ NO'}`);
    console.log(`   Is Super Admin: ${user.is_super_admin ? '✅ YES' : '❌ NO'}`);

    // Get assigned communities
    console.log("\n2. Assigned Communities (from user_communities):");
    const [userCommunities] = await db.execute(
      `SELECT c.id, c.code, c.name, uc.is_primary 
       FROM user_communities uc
       INNER JOIN communities c ON uc.community_id = c.id
       WHERE uc.user_id = ?
       ORDER BY uc.is_primary DESC, c.name`,
      [user.id]
    );

    if (userCommunities.length === 0) {
      console.log(`   ❌ No communities assigned!`);
    } else {
      userCommunities.forEach((c, index) => {
        console.log(`   ${index + 1}. ${c.name} (ID: ${c.id}, Code: ${c.code})${c.is_primary ? ' [PRIMARY]' : ''}`);
      });
    }

    // Get all communities
    console.log("\n3. All Communities in Database:");
    const [allCommunities] = await db.execute(
      "SELECT id, code, name FROM communities ORDER BY name"
    );
    allCommunities.forEach((c, index) => {
      console.log(`   ${index + 1}. ${c.name} (ID: ${c.id}, Code: ${c.code})`);
    });

    // Simulate what the user would see
    console.log("\n4. What User Should See:");
    if (user.is_admin || user.is_super_admin) {
      console.log(`   ✅ ADMIN: Can see ALL communities (${allCommunities.length} communities)`);
      console.log(`   Community IDs: [${allCommunities.map(c => c.id).join(', ')}]`);
    } else if (userCommunities.length > 0) {
      console.log(`   👤 NON-ADMIN: Can only see assigned communities (${userCommunities.length} communities)`);
      console.log(`   Community IDs: [${userCommunities.map(c => c.id).join(', ')}]`);
    } else {
      console.log(`   ⚠️  NON-ADMIN with NO communities: Will see NOTHING`);
      console.log(`   Community IDs: []`);
    }

    // Get sisters in accessible communities
    console.log("\n5. Sisters in Accessible Communities:");
    const accessibleCommunityIds = user.is_admin || user.is_super_admin
      ? allCommunities.map(c => c.id)
      : userCommunities.map(c => c.id);

    if (accessibleCommunityIds.length === 0) {
      console.log(`   ❌ No accessible communities, will see 0 sisters`);
    } else {
      const placeholders = accessibleCommunityIds.map(() => '?').join(',');
      const [sisters] = await db.execute(
        `SELECT s.id, s.code, s.saint_name, c.name as community_name, c.id as community_id
         FROM sisters s
         INNER JOIN community_assignments ca ON s.id = ca.sister_id
           AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())
         INNER JOIN communities c ON ca.community_id = c.id
         WHERE s.status = 'active' AND ca.community_id IN (${placeholders})
         ORDER BY c.name, s.saint_name`,
        accessibleCommunityIds
      );

      console.log(`   Total sisters visible: ${sisters.length}`);
      
      // Group by community
      const byCommunity = {};
      sisters.forEach(s => {
        if (!byCommunity[s.community_name]) {
          byCommunity[s.community_name] = [];
        }
        byCommunity[s.community_name].push(s);
      });

      Object.keys(byCommunity).forEach(communityName => {
        console.log(`\n   📍 ${communityName}:`);
        byCommunity[communityName].forEach((s, index) => {
          console.log(`      ${index + 1}. ${s.saint_name || 'N/A'} (${s.code})`);
        });
      });
    }

    // Check for orphan sisters (not in any community_assignment)
    console.log("\n6. Orphan Sisters (not in any active community_assignment):");
    const [orphanSisters] = await db.execute(
      `SELECT s.id, s.code, s.saint_name, s.current_community_id
       FROM sisters s
       LEFT JOIN community_assignments ca ON s.id = ca.sister_id
         AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())
       WHERE s.status = 'active' AND ca.id IS NULL`
    );

    if (orphanSisters.length > 0) {
      console.log(`   ⚠️  Found ${orphanSisters.length} orphan sisters:`);
      orphanSisters.forEach((s, index) => {
        console.log(`      ${index + 1}. ${s.saint_name || 'N/A'} (${s.code}) - current_community_id: ${s.current_community_id || 'NULL'}`);
      });
      console.log(`\n   💡 These sisters won't appear in ANY user's list until assigned to a community!`);
    } else {
      console.log(`   ✅ No orphan sisters found`);
    }

    console.log("\n" + "=".repeat(60));
    console.log("Debugging complete!");
    console.log("=".repeat(60));

  } catch (error) {
    console.error("Error during debugging:", error);
  } finally {
    await db.end();
  }
}

// Get username from command line or use default
const username = process.argv[2] || "admin";
debugUserCommunityAccess(username);
