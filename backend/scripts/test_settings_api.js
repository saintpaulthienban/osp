// scripts/test_settings_api.js
const http = require("http");

const BASE_URL = "http://localhost:5000";

// Admin token - cần lấy từ login
let authToken = "";

const makeRequest = (method, path, data = null) => {
  return new Promise((resolve, reject) => {
    const url = new URL(path, BASE_URL);
    const options = {
      hostname: url.hostname,
      port: url.port,
      path: url.pathname + url.search,
      method: method,
      headers: {
        "Content-Type": "application/json",
        Authorization: authToken ? `Bearer ${authToken}` : "",
      },
    };

    const req = http.request(options, (res) => {
      let data = "";
      res.on("data", (chunk) => (data += chunk));
      res.on("end", () => {
        try {
          resolve({ status: res.statusCode, data: JSON.parse(data) });
        } catch {
          resolve({ status: res.statusCode, data });
        }
      });
    });

    req.on("error", reject);
    if (data) req.write(JSON.stringify(data));
    req.end();
  });
};

const login = async () => {
  console.log("🔐 Đăng nhập...");
  const result = await makeRequest("POST", "/api/auth/login", {
    username: "admin",
    password: "123456",
  });

  if (result.status === 200 && (result.data.token || result.data.data?.token)) {
    authToken = result.data.token || result.data.data?.token;
    console.log("✅ Đăng nhập thành công!");
    return true;
  }
  console.log("❌ Đăng nhập thất bại:", result.data);
  return false;
};

const testGeneralSettings = async () => {
  console.log("\n📋 Test General Settings...");

  // Get
  let result = await makeRequest("GET", "/api/settings/general");
  console.log("GET /api/settings/general:", result.status);
  if (result.status === 200) {
    console.log(
      "   Settings:",
      Object.keys(result.data.data || result.data)
        .slice(0, 5)
        .join(", ")
    );
  }

  // Update
  result = await makeRequest("PUT", "/api/settings/general", {
    siteName: "Hệ Thống Quản Lý Hội Dòng OSP - Updated",
  });
  console.log(
    "PUT /api/settings/general:",
    result.status,
    result.data?.message || ""
  );
};

const testSystemSettings = async () => {
  console.log("\n🔧 Test System Settings...");

  // Get
  let result = await makeRequest("GET", "/api/settings/system");
  console.log("GET /api/settings/system:", result.status);
  if (result.status === 200) {
    console.log(
      "   Settings:",
      Object.keys(result.data.data || result.data)
        .slice(0, 5)
        .join(", ")
    );
  }

  // Test email
  result = await makeRequest("POST", "/api/settings/test-email");
  console.log(
    "POST /api/settings/test-email:",
    result.status,
    result.data?.message || ""
  );

  // Clear cache
  result = await makeRequest("POST", "/api/settings/clear-cache");
  console.log(
    "POST /api/settings/clear-cache:",
    result.status,
    result.data?.message || ""
  );
};

const testPreferences = async () => {
  console.log("\n👤 Test User Preferences...");

  // Get
  let result = await makeRequest("GET", "/api/settings/preferences");
  console.log("GET /api/settings/preferences:", result.status);
  if (result.status === 200) {
    console.log(
      "   Preferences:",
      Object.keys(result.data.data || result.data)
        .slice(0, 5)
        .join(", ")
    );
  }

  // Update
  result = await makeRequest("PUT", "/api/settings/preferences", {
    theme: "light",
    itemsPerPage: 10,
  });
  console.log(
    "PUT /api/settings/preferences:",
    result.status,
    result.data?.message || ""
  );

  // Reset
  result = await makeRequest("POST", "/api/settings/preferences/reset");
  console.log(
    "POST /api/settings/preferences/reset:",
    result.status,
    result.data?.message || ""
  );
};

const testBackups = async () => {
  console.log("\n💾 Test Backups...");

  // Get list
  let result = await makeRequest("GET", "/api/settings/backups");
  console.log("GET /api/settings/backups:", result.status);
  console.log(
    "   Backups count:",
    (result.data?.data || result.data || []).length
  );

  // Create backup
  result = await makeRequest("POST", "/api/settings/backups");
  console.log(
    "POST /api/settings/backups:",
    result.status,
    result.data?.message || ""
  );

  // Get storage info
  result = await makeRequest("GET", "/api/settings/storage-info");
  console.log("GET /api/settings/storage-info:", result.status);
  if (result.status === 200) {
    const data = result.data.data || result.data;
    console.log("   Used:", data.used, "Total:", data.total);
  }
};

const testAuditLogs = async () => {
  console.log("\n📜 Test Audit Logs...");

  let result = await makeRequest("GET", "/api/audit-logs?limit=5");
  console.log("GET /api/audit-logs:", result.status);
  if (result.status === 200) {
    console.log("   Total logs:", result.data.meta?.total || 0);
    console.log("   First 5 logs:");
    (result.data.data || []).slice(0, 3).forEach((log, i) => {
      console.log(
        `   ${i + 1}. [${log.action}] ${log.table_name} by ${
          log.username || log.user_id
        }`
      );
    });
  }
};

const run = async () => {
  console.log("🚀 Testing Settings API...\n");

  const loggedIn = await login();
  if (!loggedIn) {
    console.log("\n❌ Cannot continue without authentication");
    return;
  }

  await testGeneralSettings();
  await testSystemSettings();
  await testPreferences();
  await testBackups();
  await testAuditLogs();

  console.log("\n✅ All tests completed!");
};

run().catch(console.error);
