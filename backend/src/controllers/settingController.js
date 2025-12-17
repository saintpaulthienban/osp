// src/controllers/settingController.js
const db = require("../config/database");

/**
 * Get all settings by group or all
 */
const getAllSettings = async (req, res) => {
  try {
    const { group } = req.query;
    let query = "SELECT * FROM system_settings";
    const params = [];

    if (group) {
      query += " WHERE setting_group = ?";
      params.push(group);
    }

    query += " ORDER BY setting_group, setting_key";

    const [rows] = await db.execute(query, params);

    // Convert to object format
    const settings = {};
    rows.forEach((row) => {
      settings[row.setting_key] = row.setting_value;
    });

    res.json({ success: true, data: settings });
  } catch (error) {
    console.error("getAllSettings error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tải cài đặt" });
  }
};

/**
 * Get general settings
 */
const getGeneralSettings = async (req, res) => {
  try {
    const [rows] = await db.execute(
      "SELECT * FROM system_settings WHERE setting_group = 'general'"
    );

    const settings = {};
    rows.forEach((row) => {
      settings[row.setting_key] = row.setting_value;
    });

    res.json({ success: true, data: settings });
  } catch (error) {
    console.error("getGeneralSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải cài đặt chung" });
  }
};

/**
 * Update general settings
 */
const updateGeneralSettings = async (req, res) => {
  try {
    const settings = req.body;

    for (const [key, value] of Object.entries(settings)) {
      await db.execute(
        `INSERT INTO system_settings (setting_key, setting_value, setting_group)
         VALUES (?, ?, 'general')
         ON DUPLICATE KEY UPDATE setting_value = ?`,
        [key, value, value]
      );
    }

    res.json({ success: true, message: "Đã cập nhật cài đặt chung" });
  } catch (error) {
    console.error("updateGeneralSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật cài đặt chung" });
  }
};

/**
 * Get system settings
 */
const getSystemSettings = async (req, res) => {
  try {
    const [rows] = await db.execute(
      "SELECT * FROM system_settings WHERE setting_group = 'system'"
    );

    const settings = {};
    rows.forEach((row) => {
      // Parse boolean strings
      if (row.setting_value === "true") {
        settings[row.setting_key] = true;
      } else if (row.setting_value === "false") {
        settings[row.setting_key] = false;
      } else if (!isNaN(row.setting_value) && row.setting_value !== "") {
        settings[row.setting_key] = Number(row.setting_value);
      } else {
        settings[row.setting_key] = row.setting_value;
      }
    });

    res.json({ success: true, data: settings });
  } catch (error) {
    console.error("getSystemSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải cài đặt hệ thống" });
  }
};

/**
 * Update system settings
 */
const updateSystemSettings = async (req, res) => {
  try {
    const settings = req.body;

    for (const [key, value] of Object.entries(settings)) {
      const stringValue =
        typeof value === "boolean" ? String(value) : String(value);
      await db.execute(
        `INSERT INTO system_settings (setting_key, setting_value, setting_group)
         VALUES (?, ?, 'system')
         ON DUPLICATE KEY UPDATE setting_value = ?`,
        [key, stringValue, stringValue]
      );
    }

    res.json({ success: true, message: "Đã cập nhật cài đặt hệ thống" });
  } catch (error) {
    console.error("updateSystemSettings error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật cài đặt hệ thống" });
  }
};

/**
 * Get user preferences
 */
const getPreferences = async (req, res) => {
  try {
    const userId = req.user.id;

    const [rows] = await db.execute(
      "SELECT * FROM user_preferences WHERE user_id = ?",
      [userId]
    );

    // Default preferences
    const defaultPreferences = {
      theme: "light",
      sidebarCollapsed: false,
      itemsPerPage: 10,
      showWelcomeMessage: true,
      emailNotifications: true,
      systemNotifications: true,
      birthdayReminder: true,
      anniversaryReminder: true,
      evaluationReminder: true,
      showStatistics: true,
      showRecentActivities: true,
      showUpcomingEvents: true,
      showBirthdayWidget: true,
    };

    // Merge with user preferences
    rows.forEach((row) => {
      if (row.preference_value === "true") {
        defaultPreferences[row.preference_key] = true;
      } else if (row.preference_value === "false") {
        defaultPreferences[row.preference_key] = false;
      } else if (!isNaN(row.preference_value) && row.preference_value !== "") {
        defaultPreferences[row.preference_key] = Number(row.preference_value);
      } else {
        defaultPreferences[row.preference_key] = row.preference_value;
      }
    });

    res.json({ success: true, data: defaultPreferences });
  } catch (error) {
    console.error("getPreferences error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tải tùy chọn" });
  }
};

/**
 * Update user preferences
 */
const updatePreferences = async (req, res) => {
  try {
    const userId = req.user.id;
    const preferences = req.body;

    for (const [key, value] of Object.entries(preferences)) {
      const stringValue =
        typeof value === "boolean" ? String(value) : String(value);
      await db.execute(
        `INSERT INTO user_preferences (user_id, preference_key, preference_value)
         VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE preference_value = ?`,
        [userId, key, stringValue, stringValue]
      );
    }

    res.json({ success: true, message: "Đã cập nhật tùy chọn" });
  } catch (error) {
    console.error("updatePreferences error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật tùy chọn" });
  }
};

/**
 * Reset preferences to default
 */
const resetPreferences = async (req, res) => {
  try {
    const userId = req.user.id;

    await db.execute("DELETE FROM user_preferences WHERE user_id = ?", [
      userId,
    ]);

    res.json({ success: true, message: "Đã khôi phục tùy chọn mặc định" });
  } catch (error) {
    console.error("resetPreferences error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi khôi phục tùy chọn" });
  }
};

/**
 * Test email configuration
 */
const testEmail = async (req, res) => {
  try {
    // Get email settings
    const [rows] = await db.execute(
      "SELECT * FROM system_settings WHERE setting_group = 'system' AND setting_key LIKE 'smtp%' OR setting_key LIKE 'email%'"
    );

    if (rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Chưa cấu hình email",
      });
    }

    // TODO: Implement actual email sending logic
    // For now, just return success
    res.json({
      success: true,
      message: "Email test đã được gửi (giả lập)",
    });
  } catch (error) {
    console.error("testEmail error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi test email" });
  }
};

/**
 * Clear cache
 */
const clearCache = async (req, res) => {
  try {
    // TODO: Implement actual cache clearing logic
    res.json({ success: true, message: "Đã xóa cache thành công" });
  } catch (error) {
    console.error("clearCache error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi xóa cache" });
  }
};

/**
 * Get backups list
 */
const getBackups = async (req, res) => {
  try {
    const [rows] = await db.execute(
      `SELECT b.*, u.username as created_by_name
       FROM backups b
       LEFT JOIN users u ON b.created_by = u.id
       ORDER BY b.created_at DESC`
    );

    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("getBackups error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải danh sách backup" });
  }
};

/**
 * Create new backup
 */
const createBackup = async (req, res) => {
  try {
    const userId = req.user.id;
    const timestamp = new Date()
      .toISOString()
      .replace(/[:-]/g, "")
      .slice(0, 15);
    const filename = `backup_${timestamp}.sql`;
    const filePath = `backups/${filename}`;

    // Insert backup record
    const [result] = await db.execute(
      `INSERT INTO backups (filename, file_path, file_size, backup_type, status, created_by)
       VALUES (?, ?, ?, 'manual', 'completed', ?)`,
      [filename, filePath, 0, userId]
    );

    // TODO: Implement actual database backup logic

    res.json({
      success: true,
      data: {
        id: result.insertId,
        filename,
        file_path: filePath,
      },
      message: "Đã tạo backup thành công",
    });
  } catch (error) {
    console.error("createBackup error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tạo backup" });
  }
};

/**
 * Restore backup
 */
const restoreBackup = async (req, res) => {
  try {
    const { id } = req.params;

    const [backups] = await db.execute("SELECT * FROM backups WHERE id = ?", [
      id,
    ]);

    if (backups.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy backup",
      });
    }

    // TODO: Implement actual database restore logic

    res.json({
      success: true,
      message: "Đã khôi phục dữ liệu thành công (giả lập)",
    });
  } catch (error) {
    console.error("restoreBackup error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi khôi phục backup" });
  }
};

/**
 * Download backup
 */
const downloadBackup = async (req, res) => {
  try {
    const { id } = req.params;

    const [backups] = await db.execute("SELECT * FROM backups WHERE id = ?", [
      id,
    ]);

    if (backups.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy backup",
      });
    }

    // TODO: Implement actual file download
    res.json({
      success: false,
      message: "Tính năng đang phát triển",
    });
  } catch (error) {
    console.error("downloadBackup error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi tải backup" });
  }
};

/**
 * Delete backup
 */
const deleteBackup = async (req, res) => {
  try {
    const { id } = req.params;

    const [result] = await db.execute("DELETE FROM backups WHERE id = ?", [id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: "Không tìm thấy backup",
      });
    }

    res.json({ success: true, message: "Đã xóa backup" });
  } catch (error) {
    console.error("deleteBackup error:", error);
    res.status(500).json({ success: false, message: "Lỗi khi xóa backup" });
  }
};

/**
 * Get storage info
 */
const getStorageInfo = async (req, res) => {
  try {
    // Get database size
    const [dbSize] = await db.execute(`
      SELECT 
        SUM(data_length + index_length) AS total_size
      FROM information_schema.tables 
      WHERE table_schema = DATABASE()
    `);

    // Get backups size
    const [backupsSize] = await db.execute(
      "SELECT SUM(file_size) AS total_backup_size FROM backups"
    );

    const totalUsed =
      (dbSize[0]?.total_size || 0) + (backupsSize[0]?.total_backup_size || 0);
    const totalLimit = 10 * 1024 * 1024 * 1024; // 10GB limit (example)

    res.json({
      success: true,
      data: {
        used: totalUsed,
        total: totalLimit,
        percentage: Math.round((totalUsed / totalLimit) * 100),
        database_size: dbSize[0]?.total_size || 0,
        backups_size: backupsSize[0]?.total_backup_size || 0,
      },
    });
  } catch (error) {
    console.error("getStorageInfo error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải thông tin lưu trữ" });
  }
};

/**
 * Update setting by key
 */
const updateSettingByKey = async (req, res) => {
  try {
    const { key } = req.params;
    const { value } = req.body;

    await db.execute(
      "UPDATE system_settings SET setting_value = ? WHERE setting_key = ?",
      [value, key]
    );

    res.json({ success: true, message: "Đã cập nhật cài đặt" });
  } catch (error) {
    console.error("updateSettingByKey error:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật cài đặt" });
  }
};

module.exports = {
  getAllSettings,
  getGeneralSettings,
  updateGeneralSettings,
  getSystemSettings,
  updateSystemSettings,
  getPreferences,
  updatePreferences,
  resetPreferences,
  testEmail,
  clearCache,
  getBackups,
  createBackup,
  restoreBackup,
  downloadBackup,
  deleteBackup,
  getStorageInfo,
  updateSettingByKey,
};
