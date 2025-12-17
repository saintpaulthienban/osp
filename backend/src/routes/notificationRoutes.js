// src/routes/notificationRoutes.js
const express = require("express");
const notificationController = require("../controllers/notificationController");
const { authenticateToken, authorize } = require("../middlewares/auth");

const router = express.Router();

// All routes require authentication
router.use(authenticateToken);

// User routes
router.get("/", notificationController.getNotifications);
router.get("/unread-count", notificationController.getUnreadCount);
router.put("/:id/read", notificationController.markAsRead);
router.put("/read-all", notificationController.markAllAsRead);
router.delete("/:id", notificationController.deleteNotification);
router.delete("/", notificationController.deleteAllNotifications);

// Admin routes - for creating notifications
router.post(
  "/",
  authorize("admin", "superior_general"),
  notificationController.createNotification
);
router.post(
  "/broadcast",
  authorize("admin", "superior_general"),
  notificationController.broadcastNotification
);

module.exports = router;
