// services/auditLogFormatter.js
// Service để định dạng audit log thành tiếng Việt tự nhiên

const openaiService = require("./openaiService");

// Cache cho tên cộng đoàn
let communityCache = {};
let communityCacheExpiry = 0;

class AuditLogFormatter {
  constructor() {
    // Mapping action types sang tiếng Việt
    this.actionMap = {
      create: "Tạo mới",
      insert: "Thêm",
      add: "Thêm",
      update: "Cập nhật",
      edit: "Chỉnh sửa",
      delete: "Xóa",
      remove: "Xóa",
      login: "Đăng nhập",
      logout: "Đăng xuất",
      view: "Xem",
      export: "Xuất",
      import: "Nhập",
      approve: "Phê duyệt",
      reject: "Từ chối",
      assign: "Phân công",
      transfer: "Chuyển",
      complete: "Hoàn thành",
      cancel: "Hủy",
    };

    // Mapping table names sang tiếng Việt
    this.tableMap = {
      sisters: { name: "nữ tu", article: "Nữ tu" },
      communities: { name: "cộng đoàn", article: "Cộng đoàn" },
      users: { name: "người dùng", article: "Người dùng" },
      posts: { name: "bài đăng", article: "Bài đăng" },
      vocation_journey: {
        name: "hành trình ơn gọi",
        article: "Hành trình ơn gọi",
      },
      health_records: { name: "hồ sơ sức khỏe", article: "Hồ sơ sức khỏe" },
      missions: { name: "sứ vụ", article: "Sứ vụ" },
      education: { name: "học vấn", article: "Học vấn" },
      evaluations: { name: "đánh giá", article: "Đánh giá" },
      departures: { name: "nghỉ phép/vắng mặt", article: "Nghỉ phép" },
      audit_logs: { name: "nhật ký hệ thống", article: "Nhật ký" },
      permissions: { name: "quyền hạn", article: "Quyền hạn" },
      settings: { name: "cài đặt", article: "Cài đặt" },
      notifications: { name: "thông báo", article: "Thông báo" },
      assignments: { name: "phân công", article: "Phân công" },
      user_communities: {
        name: "liên kết cộng đoàn",
        article: "Liên kết cộng đoàn",
      },
    };

    // Mapping field names sang tiếng Việt
    this.fieldMap = {
      // Thông tin cơ bản
      name: "tên",
      full_name: "họ tên",
      birth_name: "họ tên khai sinh",
      saint_name: "tên thánh",
      christian_name: "tên thánh",
      birth_date: "ngày sinh",
      date_of_birth: "ngày sinh",
      age: "tuổi",
      birthplace: "nơi sinh",
      place_of_birth: "nơi sinh",
      phone: "số điện thoại",
      email: "email",
      address: "địa chỉ",
      permanent_address: "địa chỉ thường trú",
      current_address: "địa chỉ hiện tại",
      status: "trạng thái",

      // Sisters
      entry_date: "ngày vào dòng",
      current_stage: "giai đoạn hiện tại",
      current_community_id: "cộng đoàn hiện tại",
      baptism_date: "ngày rửa tội",
      confirmation_date: "ngày thêm sức",
      first_communion_date: "ngày rước lễ lần đầu",
      first_vows_date: "ngày khấn lần đầu",
      perpetual_vows_date: "ngày khấn trọn",
      father_name: "tên cha",
      mother_name: "tên mẹ",
      father_occupation: "nghề nghiệp cha",
      mother_occupation: "nghề nghiệp mẹ",
      siblings_count: "số anh chị em",
      family_address: "địa chỉ gia đình",
      family_religion: "tôn giáo gia đình",
      emergency_contact_name: "người liên hệ khẩn cấp",
      emergency_contact_phone: "SĐT liên hệ khẩn cấp",
      id_card: "số CMND/CCCD",
      id_card_date: "ngày cấp CMND",
      id_card_place: "nơi cấp CMND",
      nationality: "quốc tịch",
      code: "mã số",
      photo_url: "ảnh đại diện",

      // Communities
      community_name: "tên cộng đoàn",
      superior_id: "bề trên",
      location: "địa điểm",

      // Education
      degree: "bằng cấp",
      institution: "trường/cơ sở",
      major: "ngành học",
      start_date: "ngày bắt đầu",
      end_date: "ngày kết thúc",
      graduation_date: "ngày tốt nghiệp",

      // Health
      diagnosis: "chẩn đoán",
      treatment: "điều trị",
      doctor: "bác sĩ",
      hospital: "bệnh viện",
      notes: "ghi chú",

      // Mission
      position: "chức vụ",
      role: "vai trò",
      description: "mô tả",
      community_id: "cộng đoàn",

      // Evaluations
      score: "điểm số",
      rating: "xếp loại",
      comments: "nhận xét",
      evaluator_id: "người đánh giá",
      sister_id: "nữ tu",

      // Journey stages
      stage: "giai đoạn",
      stage_name: "tên giai đoạn",

      // User
      username: "tên đăng nhập",
      password: "mật khẩu",

      // Posts
      title: "tiêu đề",
      category: "danh mục",
      content: "nội dung",
      summary: "tóm tắt",
      is_pinned: "ghim",
      is_important: "quan trọng",

      // Others
      ip_address: "địa chỉ IP",
      user_agent: "trình duyệt",
    };

    // Mapping vocation stages
    this.stageMap = {
      inquiry: "Tìm hiểu",
      pre_postulancy: "Tiền tập viện",
      postulancy: "Tập viện",
      novitiate: "Nhà tập",
      temporary_vows: "Khấn tạm",
      perpetual_vows: "Khấn trọn",
    };
  }

  /**
   * Dịch action sang tiếng Việt
   */
  translateAction(action) {
    if (!action) return "Thao tác";
    const lowerAction = action.toLowerCase();

    for (const [key, value] of Object.entries(this.actionMap)) {
      if (lowerAction.includes(key)) {
        return value;
      }
    }

    // Nếu action đã là tiếng Việt
    if (
      action.includes("ạo") ||
      action.includes("ập") ||
      action.includes("óa")
    ) {
      return action;
    }

    return action;
  }

  /**
   * Dịch table name sang tiếng Việt
   */
  translateTable(tableName) {
    if (!tableName) return { name: "dữ liệu", article: "Dữ liệu" };
    return this.tableMap[tableName] || { name: tableName, article: tableName };
  }

  /**
   * Dịch field name sang tiếng Việt
   */
  translateField(fieldName) {
    if (!fieldName) return fieldName;
    return this.fieldMap[fieldName] || fieldName.replace(/_/g, " ");
  }

  /**
   * Lấy tên cộng đoàn từ ID (với cache)
   */
  async getCommunityName(communityId) {
    if (!communityId) return null;
    
    const now = Date.now();
    
    // Nếu cache hết hạn (5 phút), reset cache
    if (now > communityCacheExpiry) {
      communityCache = {};
      communityCacheExpiry = now + 5 * 60 * 1000;
    }
    
    // Nếu đã có trong cache
    if (communityCache[communityId]) {
      return communityCache[communityId];
    }
    
    // Lookup từ database
    try {
      const BaseModel = require("../models/BaseModel");
      const rows = await BaseModel.prototype.executeQuery(
        "SELECT name FROM communities WHERE id = ?",
        [communityId]
      );
      
      if (rows && rows.length > 0 && rows[0].name) {
        communityCache[communityId] = rows[0].name;
        return rows[0].name;
      }
    } catch (error) {
      console.error("Error fetching community name:", error.message);
    }
    
    return null;
  }

  /**
   * Format giá trị cho hiển thị
   */
  formatValue(value, fieldName) {
    if (value === null || value === undefined || value === "") return "trống";

    // Format dates
    if (
      fieldName &&
      (fieldName.includes("date") || fieldName.includes("_at"))
    ) {
      try {
        const date = new Date(value);
        if (!isNaN(date.getTime())) {
          return date.toLocaleDateString("vi-VN", {
            day: "2-digit",
            month: "2-digit",
            year: "numeric",
          });
        }
      } catch (e) {
        // ignore
      }
    }

    // Format stage names
    if (fieldName === "current_stage" || fieldName === "stage") {
      return this.stageMap[value] || value;
    }

    // Format boolean
    if (typeof value === "boolean") {
      return value ? "Có" : "Không";
    }

    // Format status
    if (fieldName === "status") {
      const statusMap = {
        active: "Đang hoạt động",
        inactive: "Không hoạt động",
        pending: "Chờ xử lý",
        approved: "Đã phê duyệt",
        rejected: "Đã từ chối",
        completed: "Hoàn thành",
      };
      return statusMap[value] || value;
    }

    return String(value);
  }

  /**
   * Tạo message tiếng Việt cơ bản (không cần AI)
   */
  formatBasicMessage(activity, entityName = null) {
    const action = this.translateAction(activity.action);
    const table = this.translateTable(activity.table_name);

    // Nếu có tên entity cụ thể
    if (entityName) {
      return `${action} ${table.name} "${entityName}"`;
    }

    return `${action} ${table.name}`;
  }

  /**
   * Phân tích sự thay đổi giữa old_value và new_value
   */
  async parseChanges(oldValue, newValue) {
    const changes = [];

    const oldObj = this.parseJsonValue(oldValue);
    const newObj = this.parseJsonValue(newValue);

    if (!oldObj && !newObj) return changes;

    // Lấy tất cả các keys
    const allKeys = new Set([
      ...Object.keys(oldObj || {}),
      ...Object.keys(newObj || {}),
    ]);

    for (const key of allKeys) {
      const oldVal = oldObj?.[key];
      const newVal = newObj?.[key];

      // Skip system fields
      if (["id", "created_at", "updated_at", "password"].includes(key)) {
        continue;
      }

      // Kiểm tra có thay đổi không
      if (JSON.stringify(oldVal) !== JSON.stringify(newVal)) {
        let oldValueFormatted = this.formatValue(oldVal, key);
        let newValueFormatted = this.formatValue(newVal, key);
        
        // Special handling for community_id fields - lookup community name
        if (key === "community_id" || key === "current_community_id") {
          if (oldVal) {
            const oldCommunityName = await this.getCommunityName(oldVal);
            if (oldCommunityName) {
              oldValueFormatted = oldCommunityName;
            }
          }
          if (newVal) {
            const newCommunityName = await this.getCommunityName(newVal);
            if (newCommunityName) {
              newValueFormatted = newCommunityName;
            }
          }
        }
        
        changes.push({
          field: key,
          fieldVi: this.translateField(key),
          oldValue: oldVal,
          newValue: newVal,
          oldValueFormatted,
          newValueFormatted,
        });
      }
    }

    return changes;
  }

  /**
   * Parse JSON value an toàn
   */
  parseJsonValue(value) {
    if (!value) return null;
    if (typeof value === "object") return value;
    try {
      return JSON.parse(value);
    } catch (e) {
      return null;
    }
  }

  /**
   * Tạo mô tả chi tiết các thay đổi bằng tiếng Việt
   */
  formatChangesDescription(changes) {
    if (!changes || changes.length === 0) {
      return "Không có chi tiết thay đổi";
    }

    const descriptions = changes.map((change) => {
      if (change.oldValue === null || change.oldValue === undefined) {
        return `Thêm ${change.fieldVi}: "${change.newValueFormatted}"`;
      }
      if (change.newValue === null || change.newValue === undefined) {
        return `Xóa ${change.fieldVi} (giá trị cũ: "${change.oldValueFormatted}")`;
      }
      return `Đổi ${change.fieldVi} từ "${change.oldValueFormatted}" thành "${change.newValueFormatted}"`;
    });

    return descriptions.join("; ");
  }

  /**
   * Tạo message tiếng Việt tự nhiên với AI (nếu có)
   */
  async formatWithAI(activity, changes, entityName = null) {
    try {
      // Kiểm tra AI có sẵn không
      if (!openaiService.isConfigured()) {
        return this.formatBasicMessage(activity, entityName);
      }

      const action = this.translateAction(activity.action);
      const table = this.translateTable(activity.table_name);

      // Tạo prompt cho AI
      const prompt = `Hãy tạo một câu mô tả ngắn gọn (1-2 câu) bằng tiếng Việt tự nhiên cho hoạt động sau:
      
Hành động: ${action}
Đối tượng: ${table.name}${entityName ? ` (${entityName})` : ""}
Người thực hiện: ${activity.user_name || "Hệ thống"}
${
  changes.length > 0
    ? `Thay đổi: ${this.formatChangesDescription(changes)}`
    : ""
}

Yêu cầu:
- Viết ngắn gọn, tự nhiên như người Việt nói
- Không cần đề cập đến thời gian
- Sử dụng từ ngữ phù hợp với môi trường tôn giáo
- Chỉ trả về câu mô tả, không giải thích thêm`;

      const response = await openaiService.chat(prompt);

      if (response.success && response.message) {
        return response.message.trim();
      }

      return this.formatBasicMessage(activity, entityName);
    } catch (error) {
      console.error("AI formatting error:", error.message);
      return this.formatBasicMessage(activity, entityName);
    }
  }

  /**
   * Format đầy đủ một audit log entry
   */
  async formatActivity(activity, useAI = false) {
    const changes = await this.parseChanges(activity.old_value, activity.new_value);

    // Lấy tên entity từ new_value hoặc old_value
    let entityName = null;
    const data =
      this.parseJsonValue(activity.new_value) ||
      this.parseJsonValue(activity.old_value);

    if (data) {
      // Ưu tiên các trường tên phổ biến
      entityName =
        data.birth_name ||
        data.saint_name ||
        data.full_name ||
        data.christian_name ||
        data.name ||
        data.community_name ||
        data.title ||
        null;
    }

    // Tạo message
    let message;
    if (useAI) {
      message = await this.formatWithAI(activity, changes, entityName);
    } else {
      message = this.formatBasicMessage(activity, entityName);
    }

    // Xác định type và icon
    let type = "info";
    let icon = "fas fa-info-circle";
    const action = activity.action?.toLowerCase() || "";

    if (
      action.includes("create") ||
      action.includes("thêm") ||
      action.includes("tạo")
    ) {
      type = "success";
      icon = "fas fa-plus-circle";
    } else if (
      action.includes("update") ||
      action.includes("cập nhật") ||
      action.includes("sửa")
    ) {
      type = "primary";
      icon = "fas fa-edit";
    } else if (action.includes("delete") || action.includes("xóa")) {
      type = "danger";
      icon = "fas fa-trash";
    } else if (action.includes("login") || action.includes("đăng nhập")) {
      type = "info";
      icon = "fas fa-sign-in-alt";
    } else if (action.includes("logout") || action.includes("đăng xuất")) {
      type = "warning";
      icon = "fas fa-sign-out-alt";
    }

    return {
      id: activity.id,
      type,
      icon,
      message,
      messageSimple: this.formatBasicMessage(activity, entityName),
      user: activity.user_name || "Hệ thống",
      userEmail: activity.user_email,
      timestamp: activity.created_at,
      tableType: activity.table_name,
      tableTypeVi: this.translateTable(activity.table_name).name,
      recordId: activity.record_id,
      action: activity.action,
      actionVi: this.translateAction(activity.action),
      entityName,
      changes,
      changesDescription: this.formatChangesDescription(changes),
      oldValue: this.parseJsonValue(activity.old_value),
      newValue: this.parseJsonValue(activity.new_value),
    };
  }

  /**
   * Format nhiều activities cùng lúc
   */
  async formatActivities(activities, useAI = false) {
    const formatted = [];

    for (const activity of activities) {
      const result = await this.formatActivity(activity, useAI);
      formatted.push(result);
    }

    return formatted;
  }
}

module.exports = new AuditLogFormatter();
