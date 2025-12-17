// backend/src/routes/postRoutes.js

const express = require("express");
const multer = require("multer");
const path = require("path");
const fs = require("fs");
const postController = require("../controllers/postController");
const { authenticateToken, checkPermission } = require("../middlewares/auth");

const router = express.Router();

// Setup multer for file uploads
const uploadDir = path.join(__dirname, "../uploads/posts");
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, uniqueSuffix + "-" + file.originalname);
  },
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = [
    "application/pdf",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/vnd.ms-excel",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "application/vnd.ms-powerpoint",
    "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    "image/jpeg",
    "image/png",
    "image/gif",
  ];

  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error("Loại file không được hỗ trợ"), false);
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB
  },
});

// Apply authentication to all routes
router.use(authenticateToken);

// Routes
router.get("/", checkPermission("posts.view"), postController.getPosts);
router.get("/:id", checkPermission("posts.view"), postController.getPostById);
router.post(
  "/",
  checkPermission("posts.create"),
  upload.array("files", 10),
  postController.createPost
);
router.put(
  "/:id",
  checkPermission("posts.update"),
  upload.array("files", 10),
  postController.updatePost
);
router.delete(
  "/:id",
  checkPermission("posts.delete"),
  postController.deletePost
);
router.post("/:id/view", postController.incrementViewCount);
router.post(
  "/:id/toggle-pin",
  checkPermission("posts.update"),
  postController.togglePin
);

module.exports = router;
