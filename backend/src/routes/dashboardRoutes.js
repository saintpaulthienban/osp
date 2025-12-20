// backend/src/routes/dashboardRoutes.js

const express = require("express");
const router = express.Router();
const dashboardController = require("../controllers/dashboardController");
const { authenticateToken } = require("../middlewares/auth");

// All dashboard routes require authentication
router.use(authenticateToken);

// GET /api/dashboard/stats - Get dashboard statistics
router.get("/stats", dashboardController.getDashboardStats);

// GET /api/dashboard/activities - Get recent activities
router.get("/activities", dashboardController.getRecentActivities);

// GET /api/dashboard/activities/:id - Get activity detail
router.get("/activities/:id", dashboardController.getActivityDetail);

// GET /api/dashboard/posts - Get recent posts
router.get("/posts", dashboardController.getRecentPosts);

// GET /api/dashboard/quick-stats - Get quick stats for cards
router.get("/quick-stats", dashboardController.getQuickStats);

module.exports = router;
