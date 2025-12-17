// Test PostModel
const PostModel = require("../src/models/PostModel");

async function test() {
  try {
    console.log("Testing PostModel.getPosts...");
    const result = await PostModel.getPosts({ page: 1, limit: 10 });
    console.log("Result:", JSON.stringify(result, null, 2));

    console.log("\nTesting PostModel.getPinnedPosts...");
    const pinned = await PostModel.getPinnedPosts();
    console.log("Pinned:", JSON.stringify(pinned, null, 2));

    process.exit(0);
  } catch (e) {
    console.error("Error:", e);
    process.exit(1);
  }
}

test();
