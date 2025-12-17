const express = require("express");
const permissionController = require("../controllers/permissionController");
const { authenticateToken } = require("../middlewares/auth");

const router = express.Router();

router.use(authenticateToken);

// Get all permissions grouped by module
router.get("/", permissionController.getAllPermissions);

// Get permissions by module
router.get("/module/:module", permissionController.getPermissionsByModule);

// Get current user's permissions
router.get("/me", permissionController.getMyPermissions);

// Check if current user has a specific permission
router.get("/check/:code", permissionController.checkPermission);

// Check if current user has any of the specified permissions
router.post("/check-any", permissionController.checkAnyPermission);

// Check if current user has all of the specified permissions
router.post("/check-all", permissionController.checkAllPermissions);

module.exports = router;
