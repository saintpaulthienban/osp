// src/services/notificationService.js

import api from "./api";

const notificationService = {
  /**
   * Get all notifications for current user
   * @param {object} params - Query parameters
   * @returns {Promise}
   */
  getAll: async (params = {}) => {
    try {
      const queryParams = new URLSearchParams();
      if (params.limit) queryParams.append("limit", params.limit);
      if (params.unreadOnly)
        queryParams.append("unreadOnly", params.unreadOnly);

      const response = await api.get(
        `/notifications?${queryParams.toString()}`
      );
      return {
        success: true,
        data: response.data?.data || [],
        unreadCount: response.data?.unreadCount || 0,
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải thông báo",
      };
    }
  },

  /**
   * Get unread notification count
   * @returns {Promise}
   */
  getUnreadCount: async () => {
    try {
      const response = await api.get("/notifications/unread-count");
      return {
        success: true,
        count: response.data?.count || 0,
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi đếm thông báo",
      };
    }
  },

  /**
   * Mark notification as read
   * @param {number} id - Notification ID
   * @returns {Promise}
   */
  markAsRead: async (id) => {
    try {
      const response = await api.put(`/notifications/${id}/read`);
      return {
        success: response.data?.success || true,
        message: response.data?.message,
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi đánh dấu đã đọc",
      };
    }
  },

  /**
   * Mark all notifications as read
   * @returns {Promise}
   */
  markAllAsRead: async () => {
    try {
      const response = await api.put("/notifications/read-all");
      return {
        success: response.data?.success || true,
        message: response.data?.message,
      };
    } catch (error) {
      return {
        success: false,
        error:
          error.response?.data?.message || "Lỗi khi đánh dấu tất cả đã đọc",
      };
    }
  },

  /**
   * Delete a notification
   * @param {number} id - Notification ID
   * @returns {Promise}
   */
  delete: async (id) => {
    try {
      const response = await api.delete(`/notifications/${id}`);
      return {
        success: response.data?.success || true,
        message: response.data?.message,
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi xóa thông báo",
      };
    }
  },

  /**
   * Delete all notifications
   * @returns {Promise}
   */
  deleteAll: async () => {
    try {
      const response = await api.delete("/notifications");
      return {
        success: response.data?.success || true,
        message: response.data?.message,
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi xóa tất cả thông báo",
      };
    }
  },

  /**
   * Create a notification (admin only)
   * @param {object} data - Notification data
   * @returns {Promise}
   */
  create: async (data) => {
    try {
      const response = await api.post("/notifications", data);
      return {
        success: response.data?.success || true,
        data: response.data?.data,
        message: response.data?.message,
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tạo thông báo",
      };
    }
  },

  /**
   * Broadcast notification to multiple users (admin only)
   * @param {object} data - { user_ids, type, title, message, link }
   * @returns {Promise}
   */
  broadcast: async (data) => {
    try {
      const response = await api.post("/notifications/broadcast", data);
      return {
        success: response.data?.success || true,
        message: response.data?.message,
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi gửi thông báo",
      };
    }
  },
};

export default notificationService;
