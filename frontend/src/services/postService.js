// src/services/postService.js
// Backend returns: { success: true, data: {...} }
// API interceptor returns response.data, so we get the backend response directly

import api from "./api";

const postService = {
  /**
   * Get list of posts with pagination and filters
   */
  getPosts: async (params = {}) => {
    try {
      const response = await api.get("/posts", { params });
      // response = { success: true, data: { posts, pinnedPosts, total, totalPages, currentPage } }
      return response;
    } catch (error) {
      return {
        success: false,
        error:
          error.response?.data?.message || "Lỗi khi tải danh sách bài đăng",
      };
    }
  },

  /**
   * Get single post by ID
   */
  getPostById: async (id) => {
    try {
      const response = await api.get(`/posts/${id}`);
      // response = { success: true, data: post }
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải bài đăng",
      };
    }
  },

  /**
   * Create new post
   */
  createPost: async (data) => {
    try {
      const response = await api.post("/posts", data, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tạo bài đăng",
      };
    }
  },

  /**
   * Update existing post
   */
  updatePost: async (id, data) => {
    try {
      const response = await api.put(`/posts/${id}`, data, {
        headers:
          data instanceof FormData
            ? { "Content-Type": "multipart/form-data" }
            : undefined,
      });
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi cập nhật bài đăng",
      };
    }
  },

  /**
   * Delete post
   */
  deletePost: async (id) => {
    try {
      const response = await api.delete(`/posts/${id}`);
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi xóa bài đăng",
      };
    }
  },

  /**
   * Increment view count
   */
  incrementViewCount: async (id) => {
    try {
      const response = await api.post(`/posts/${id}/view`);
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi cập nhật lượt xem",
      };
    }
  },

  /**
   * Toggle pin status
   */
  togglePin: async (id) => {
    try {
      const response = await api.post(`/posts/${id}/toggle-pin`);
      return response;
    } catch (error) {
      return {
        success: false,
        error:
          error.response?.data?.message || "Lỗi khi thay đổi trạng thái ghim",
      };
    }
  },
};

export default postService;
