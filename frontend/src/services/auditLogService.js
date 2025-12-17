// src/services/auditLogService.js

import api from "./api";

const auditLogService = {
  /**
   * Get all audit logs with pagination and filters
   * @param {object} params - Query parameters
   * @returns {Promise}
   */
  getAll: async (params = {}) => {
    try {
      const queryParams = new URLSearchParams();

      if (params.page) queryParams.append("page", params.page);
      if (params.limit) queryParams.append("limit", params.limit);
      if (params.action) queryParams.append("action", params.action);
      if (params.user) queryParams.append("user", params.user);
      if (params.table) queryParams.append("table", params.table);
      if (params.startDate) queryParams.append("startDate", params.startDate);
      if (params.endDate) queryParams.append("endDate", params.endDate);

      const response = await api.get(`/audit-logs?${queryParams.toString()}`);
      return {
        success: true,
        data: response.data.data || [],
        meta: response.data.meta || {},
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải nhật ký hoạt động",
      };
    }
  },

  /**
   * Get audit logs by user ID
   * @param {number} userId
   * @param {object} params - Query parameters
   * @returns {Promise}
   */
  getByUser: async (userId, params = {}) => {
    try {
      const queryParams = new URLSearchParams();
      if (params.page) queryParams.append("page", params.page);
      if (params.limit) queryParams.append("limit", params.limit);

      const response = await api.get(
        `/audit-logs/user/${userId}?${queryParams.toString()}`
      );
      return {
        success: true,
        data: response.data.data || [],
        meta: response.data.meta || {},
      };
    } catch (error) {
      return {
        success: false,
        error:
          error.response?.data?.message || "Lỗi khi tải nhật ký người dùng",
      };
    }
  },

  /**
   * Get audit logs by table name
   * @param {string} tableName
   * @param {object} params - Query parameters
   * @returns {Promise}
   */
  getByTable: async (tableName, params = {}) => {
    try {
      const queryParams = new URLSearchParams();
      if (params.page) queryParams.append("page", params.page);
      if (params.limit) queryParams.append("limit", params.limit);

      const response = await api.get(
        `/audit-logs/table/${tableName}?${queryParams.toString()}`
      );
      return {
        success: true,
        data: response.data.data || [],
        meta: response.data.meta || {},
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải nhật ký bảng",
      };
    }
  },

  /**
   * Get audit logs by table and record ID
   * @param {string} tableName
   * @param {number} recordId
   * @param {object} params - Query parameters
   * @returns {Promise}
   */
  getByRecord: async (tableName, recordId, params = {}) => {
    try {
      const queryParams = new URLSearchParams();
      if (params.page) queryParams.append("page", params.page);
      if (params.limit) queryParams.append("limit", params.limit);

      const response = await api.get(
        `/audit-logs/table/${tableName}/record/${recordId}?${queryParams.toString()}`
      );
      return {
        success: true,
        data: response.data.data || [],
        meta: response.data.meta || {},
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || "Lỗi khi tải nhật ký bản ghi",
      };
    }
  },
};

export default auditLogService;
