// src/services/dashboardService.js

import api from "./api";

const dashboardService = {
  /**
   * Get dashboard statistics
   */
  getStats: async () => {
    try {
      const response = await api.get("/dashboard/stats");
      return response;
    } catch (error) {
      return {
        success: false,
        error:
          error.response?.data?.message || "Lỗi khi tải thống kê dashboard",
      };
    }
  },

  /**
   * Get recent activities
   */
  getRecentActivities: async (limit = 10) => {
    try {
      const response = await api.get("/dashboard/activities", {
        params: { limit },
      });
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải hoạt động gần đây",
      };
    }
  },

  /**
   * Get recent posts
   */
  getRecentPosts: async (limit = 5) => {
    try {
      const response = await api.get("/dashboard/posts", {
        params: { limit },
      });
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải bài đăng gần đây",
      };
    }
  },

  /**
   * Get quick stats
   */
  getQuickStats: async () => {
    try {
      const response = await api.get("/dashboard/quick-stats");
      return response;
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải thống kê nhanh",
      };
    }
  },
};

export default dashboardService;
