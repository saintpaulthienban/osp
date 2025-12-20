// src/routes/settingRoutes.js
const express = require("express");
const multer = require("multer");
const settingController = require("../controllers/settingController");
const { authenticateToken, authorize } = require("../middlewares/auth");

const router = express.Router();

// Configure multer for file upload (memory storage)
const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 50 * 1024 * 1024, // 50MB max file size
  },
  fileFilter: (req, file, cb) => {
    if (
      file.mimetype === "application/sql" ||
      file.mimetype === "text/plain" ||
      file.originalname.endsWith(".sql")
    ) {
      cb(null, true);
    } else {
      cb(new Error("Chỉ chấp nhận file SQL (.sql)"), false);
    }
  },
});

// All routes require authentication
router.use(authenticateToken);

// General settings - admin only
router.get(
  "/general",
  authorize("admin", "superior_general"),
  settingController.getGeneralSettings
);
router.put(
  "/general",
  authorize("admin", "superior_general"),
  settingController.updateGeneralSettings
);

// System settings - admin only
router.get(
  "/system",
  authorize("admin", "superior_general"),
  settingController.getSystemSettings
);
router.put(
  "/system",
  authorize("admin", "superior_general"),
  settingController.updateSystemSettings
);

// User preferences - any authenticated user
router.get("/preferences", settingController.getPreferences);
router.put("/preferences", settingController.updatePreferences);
router.post("/preferences/reset", settingController.resetPreferences);

// Email and cache - admin only
router.post(
  "/test-email",
  authorize("admin", "superior_general"),
  settingController.testEmail
);
router.post(
  "/clear-cache",
  authorize("admin", "superior_general"),
  settingController.clearCache
);

// Backups - admin only
router.get(
  "/backups",
  authorize("admin", "superior_general"),
  settingController.getBackups
);
router.post(
  "/backups",
  authorize("admin", "superior_general"),
  settingController.createBackup
);
router.post(
  "/backups/restore-file",
  authorize("admin", "superior_general"),
  upload.single("backup"),
  settingController.restoreFromFile
);
router.post(
  "/backups/:id/restore",
  authorize("admin", "superior_general"),
  settingController.restoreBackup
);
router.get(
  "/backups/:id/download",
  authorize("admin", "superior_general"),
  settingController.downloadBackup
);
router.delete(
  "/backups/:id",
  authorize("admin", "superior_general"),
  settingController.deleteBackup
);

// Storage info - admin only
router.get(
  "/storage-info",
  authorize("admin", "superior_general"),
  settingController.getStorageInfo
);

// Get all settings / Update by key - admin only
router.get(
  "/",
  authorize("admin", "superior_general"),
  settingController.getAllSettings
);
router.put(
  "/:key",
  authorize("admin", "superior_general"),
  settingController.updateSettingByKey
);

module.exports = router;
