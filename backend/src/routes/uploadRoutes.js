const express = require("express");
const router = express.Router();
const { uploadDocuments } = require("../middlewares/upload");
const { authenticateToken } = require("../middlewares/auth");
const { uploadToFirebase } = require("../controllers/uploadController");

// Upload multiple documents
router.post(
  "/documents",
  authenticateToken,
  uploadDocuments,
  async (req, res) => {
    try {
      if (!req.files || req.files.length === 0) {
        return res.status(400).json({ message: "No files uploaded" });
      }

      // Upload tất cả files lên Firebase
      const uploadPromises = req.files.map(file => uploadToFirebase(file));
      const results = await Promise.all(uploadPromises);

      const uploadedFiles = results.map((result, index) => ({
        id: Date.now() + index,
        name: result.originalName,
        size: req.files[index].size,
        type: req.files[index].mimetype,
        url: result.url,
        uploadedAt: new Date().toISOString(),
      }));

      return res.status(200).json({
        success: true,
        files: uploadedFiles,
      });
    } catch (error) {
      console.error("Upload error:", error.message);
      return res.status(500).json({ message: "Failed to upload files" });
    }
  }
);

module.exports = router;
