// backend/src/controllers/postController.js

const PostModel = require("../models/PostModel");
const path = require("path");
const fs = require("fs");

/**
 * Get all posts with pagination and filters
 */
const getPosts = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 10,
      search = "",
      category = "",
      status = "",
      sortBy = "newest",
      exclude = null,
    } = req.query;

    const result = await PostModel.getPosts({
      page: parseInt(page),
      limit: parseInt(limit),
      search,
      category,
      status,
      sortBy,
      exclude,
    });

    // Get pinned posts separately
    const pinnedPosts = await PostModel.getPinnedPosts();

    return res.status(200).json({
      success: true,
      data: {
        posts: result.posts,
        pinnedPosts,
        total: result.total,
        totalPages: result.totalPages,
        currentPage: result.currentPage,
      },
    });
  } catch (error) {
    console.error("getPosts error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải danh sách bài đăng" });
  }
};

/**
 * Get single post by ID
 */
const getPostById = async (req, res) => {
  try {
    const { id } = req.params;
    const post = await PostModel.getPostById(id);

    if (!post) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy bài đăng" });
    }

    return res.status(200).json({ success: true, data: post });
  } catch (error) {
    console.error("getPostById error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Lỗi khi tải bài đăng" });
  }
};

/**
 * Create new post
 */
const createPost = async (req, res) => {
  try {
    const { title, category, summary, content, is_pinned, is_important, tags } =
      req.body;

    // Validation
    if (!title || !category || !content) {
      return res.status(400).json({
        message: "Vui lòng điền đầy đủ tiêu đề, danh mục và nội dung",
      });
    }

    // Handle file uploads
    let attachments = [];
    if (req.files && req.files.length > 0) {
      attachments = req.files.map((file) => ({
        name: file.originalname,
        path: `/uploads/posts/${file.filename}`,
        url: `/uploads/posts/${file.filename}`,
        size: file.size,
        mimetype: file.mimetype,
      }));
    }

    const postData = {
      title,
      category,
      summary: summary || null,
      content,
      is_pinned: is_pinned === "true" || is_pinned === true ? 1 : 0,
      is_important: is_important === "true" || is_important === true ? 1 : 0,
      tags: tags
        ? typeof tags === "string"
          ? tags
          : JSON.stringify(tags)
        : null,
      attachments: attachments.length > 0 ? JSON.stringify(attachments) : null,
      author_id: req.user.id,
      view_count: 0,
      created_at: new Date(),
      updated_at: new Date(),
    };

    const result = await PostModel.create(postData);

    return res.status(201).json({
      success: true,
      message: "Tạo bài đăng thành công",
      data: { id: result.insertId },
    });
  } catch (error) {
    console.error("createPost error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Lỗi khi tạo bài đăng" });
  }
};

/**
 * Update existing post
 */
const updatePost = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      title,
      category,
      summary,
      content,
      is_pinned,
      is_important,
      tags,
      existingFiles,
    } = req.body;

    // Check if post exists
    const existingPost = await PostModel.getPostById(id);
    if (!existingPost) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy bài đăng" });
    }

    // Handle attachments
    let attachments = [];

    // Keep existing files if specified
    if (existingFiles) {
      try {
        const keepFiles =
          typeof existingFiles === "string"
            ? JSON.parse(existingFiles)
            : existingFiles;
        attachments = keepFiles;
      } catch (e) {
        console.error("Error parsing existingFiles:", e);
      }
    }

    // Add new uploads
    if (req.files && req.files.length > 0) {
      const newFiles = req.files.map((file) => ({
        name: file.originalname,
        path: `/uploads/posts/${file.filename}`,
        url: `/uploads/posts/${file.filename}`,
        size: file.size,
        mimetype: file.mimetype,
      }));
      attachments = [...attachments, ...newFiles];
    }

    const updateData = {
      updated_at: new Date(),
    };

    if (title !== undefined) updateData.title = title;
    if (category !== undefined) updateData.category = category;
    if (summary !== undefined) updateData.summary = summary;
    if (content !== undefined) updateData.content = content;
    if (is_pinned !== undefined) {
      updateData.is_pinned = is_pinned === "true" || is_pinned === true ? 1 : 0;
    }
    if (is_important !== undefined) {
      updateData.is_important =
        is_important === "true" || is_important === true ? 1 : 0;
    }
    if (tags !== undefined) {
      updateData.tags = tags
        ? typeof tags === "string"
          ? tags
          : JSON.stringify(tags)
        : null;
    }
    if (attachments.length > 0 || existingFiles !== undefined) {
      updateData.attachments =
        attachments.length > 0 ? JSON.stringify(attachments) : null;
    }

    await PostModel.update(id, updateData);

    return res.status(200).json({
      success: true,
      message: "Cập nhật bài đăng thành công",
    });
  } catch (error) {
    console.error("updatePost error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật bài đăng" });
  }
};

/**
 * Delete post (soft delete)
 */
const deletePost = async (req, res) => {
  try {
    const { id } = req.params;

    const existingPost = await PostModel.getPostById(id);
    if (!existingPost) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy bài đăng" });
    }

    await PostModel.softDelete(id);

    return res.status(200).json({
      success: true,
      message: "Xóa bài đăng thành công",
    });
  } catch (error) {
    console.error("deletePost error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Lỗi khi xóa bài đăng" });
  }
};

/**
 * Increment view count
 */
const incrementViewCount = async (req, res) => {
  try {
    const { id } = req.params;
    await PostModel.incrementViewCount(id);
    return res.status(200).json({ success: true, message: "OK" });
  } catch (error) {
    console.error("incrementViewCount error:", error.message);
    return res.status(500).json({ success: false, message: "Lỗi" });
  }
};

/**
 * Toggle pin status
 */
const togglePin = async (req, res) => {
  try {
    const { id } = req.params;
    await PostModel.togglePin(id);
    return res
      .status(200)
      .json({ success: true, message: "Cập nhật trạng thái ghim thành công" });
  } catch (error) {
    console.error("togglePin error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Lỗi khi cập nhật trạng thái ghim" });
  }
};

module.exports = {
  getPosts,
  getPostById,
  createPost,
  updatePost,
  deletePost,
  incrementViewCount,
  togglePin,
};
