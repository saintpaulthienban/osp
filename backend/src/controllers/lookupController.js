// src/controllers/lookupController.js
const JourneyStageModel = require("../models/JourneyStageModel");
const SisterStatusModel = require("../models/SisterStatusModel");
const VocationJourneyModel = require("../models/VocationJourneyModel");
const CommunityRoleModel = require("../models/CommunityRoleModel");
const EducationLevelModel = require("../models/EducationLevelModel");

// ============ Journey Stages ============

const getJourneyStages = async (req, res) => {
  try {
    const stages = await JourneyStageModel.getActiveStages();
    return res.status(200).json({
      success: true,
      data: stages,
    });
  } catch (error) {
    console.error("getJourneyStages error:", error.message);
    return res.status(500).json({ message: "Failed to fetch journey stages" });
  }
};

const getAllJourneyStages = async (req, res) => {
  try {
    const stages = await JourneyStageModel.getAll();
    return res.status(200).json({
      success: true,
      data: stages,
    });
  } catch (error) {
    console.error("getAllJourneyStages error:", error.message);
    return res.status(500).json({ message: "Failed to fetch journey stages" });
  }
};

const createJourneyStage = async (req, res) => {
  try {
    const { name, description, display_order, color } = req.body;

    if (!name) {
      return res.status(400).json({ message: "Name is required" });
    }

    // Auto-generate code from Vietnamese name
    const vietnameseMap = {
      à: "a",
      á: "a",
      ả: "a",
      ã: "a",
      ạ: "a",
      ă: "a",
      ằ: "a",
      ắ: "a",
      ẳ: "a",
      ẵ: "a",
      ặ: "a",
      â: "a",
      ầ: "a",
      ấ: "a",
      ẩ: "a",
      ẫ: "a",
      ậ: "a",
      đ: "d",
      è: "e",
      é: "e",
      ẻ: "e",
      ẽ: "e",
      ẹ: "e",
      ê: "e",
      ề: "e",
      ế: "e",
      ể: "e",
      ễ: "e",
      ệ: "e",
      ì: "i",
      í: "i",
      ỉ: "i",
      ĩ: "i",
      ị: "i",
      ò: "o",
      ó: "o",
      ỏ: "o",
      õ: "o",
      ọ: "o",
      ô: "o",
      ồ: "o",
      ố: "o",
      ổ: "o",
      ỗ: "o",
      ộ: "o",
      ơ: "o",
      ờ: "o",
      ớ: "o",
      ở: "o",
      ỡ: "o",
      ợ: "o",
      ù: "u",
      ú: "u",
      ủ: "u",
      ũ: "u",
      ụ: "u",
      ư: "u",
      ừ: "u",
      ứ: "u",
      ử: "u",
      ữ: "u",
      ự: "u",
      ỳ: "y",
      ý: "y",
      ỷ: "y",
      ỹ: "y",
      ỵ: "y",
    };

    // Convert Vietnamese to ASCII
    let code = name.toLowerCase();
    for (const [vietnamese, ascii] of Object.entries(vietnameseMap)) {
      code = code.replace(new RegExp(vietnamese, "g"), ascii);
    }
    // Replace special characters and spaces with underscores
    code = code.replace(/[^a-z0-9]+/g, "_").replace(/^_+|_+$/g, "");

    // Check if code already exists and add suffix if needed
    let finalCode = code;
    let counter = 1;
    while (await JourneyStageModel.findByCode(finalCode)) {
      finalCode = `${code}_${counter}`;
      counter++;
    }

    const stage = await JourneyStageModel.create({
      code: finalCode,
      name,
      description,
      display_order: display_order || 0,
      color: color || "#6c757d",
      is_active: true,
    });

    return res.status(201).json({
      success: true,
      data: stage,
    });
  } catch (error) {
    console.error("createJourneyStage error:", error.message);
    return res.status(500).json({ message: "Failed to create journey stage" });
  }
};

const updateJourneyStage = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await JourneyStageModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Journey stage not found" });
    }

    const updated = await JourneyStageModel.update(id, req.body);
    return res.status(200).json({
      success: true,
      data: updated,
    });
  } catch (error) {
    console.error("updateJourneyStage error:", error.message);
    return res.status(500).json({ message: "Failed to update journey stage" });
  }
};

const deleteJourneyStage = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await JourneyStageModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Journey stage not found" });
    }

    // Check if stage is being used in vocation_journey table
    const usageCount = await VocationJourneyModel.executeQuery(
      "SELECT COUNT(*) as count FROM vocation_journey WHERE stage = ?",
      [existing.code]
    );

    if (usageCount[0].count > 0) {
      return res.status(400).json({
        message: `Không thể xóa giai đoạn này vì đang được sử dụng bởi ${usageCount[0].count} hành trình ơn gọi`,
        usageCount: usageCount[0].count,
      });
    }

    // Hard delete if not used
    await JourneyStageModel.delete(id);
    return res.status(200).json({
      success: true,
      message: "Đã xóa giai đoạn thành công",
    });
  } catch (error) {
    console.error("deleteJourneyStage error:", error.message);
    return res.status(500).json({ message: "Failed to delete journey stage" });
  }
};

// ============ Sister Statuses ============

const getSisterStatuses = async (req, res) => {
  try {
    const statuses = await SisterStatusModel.getActiveStatuses();
    return res.status(200).json({
      success: true,
      data: statuses,
    });
  } catch (error) {
    console.error("getSisterStatuses error:", error.message);
    return res.status(500).json({ message: "Failed to fetch sister statuses" });
  }
};

const getAllSisterStatuses = async (req, res) => {
  try {
    const statuses = await SisterStatusModel.getAll();
    return res.status(200).json({
      success: true,
      data: statuses,
    });
  } catch (error) {
    console.error("getAllSisterStatuses error:", error.message);
    return res.status(500).json({ message: "Failed to fetch sister statuses" });
  }
};

const createSisterStatus = async (req, res) => {
  try {
    const { code, name, description, display_order, color } = req.body;

    if (!code || !name) {
      return res.status(400).json({ message: "Code and name are required" });
    }

    // Check if code already exists
    const existing = await SisterStatusModel.findByCode(code);
    if (existing) {
      return res.status(400).json({ message: "Code already exists" });
    }

    const status = await SisterStatusModel.create({
      code,
      name,
      description,
      display_order: display_order || 0,
      color: color || "#6c757d",
      is_active: true,
    });

    return res.status(201).json({
      success: true,
      data: status,
    });
  } catch (error) {
    console.error("createSisterStatus error:", error.message);
    return res.status(500).json({ message: "Failed to create sister status" });
  }
};

const updateSisterStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await SisterStatusModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Sister status not found" });
    }

    const updated = await SisterStatusModel.update(id, req.body);
    return res.status(200).json({
      success: true,
      data: updated,
    });
  } catch (error) {
    console.error("updateSisterStatus error:", error.message);
    return res.status(500).json({ message: "Failed to update sister status" });
  }
};

const deleteSisterStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await SisterStatusModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Sister status not found" });
    }

    // Soft delete by setting is_active to false
    await SisterStatusModel.update(id, { is_active: false });
    return res.status(200).json({
      success: true,
      message: "Sister status deactivated",
    });
  } catch (error) {
    console.error("deleteSisterStatus error:", error.message);
    return res.status(500).json({ message: "Failed to delete sister status" });
  }
};

// ============ User Roles ============

const getUserRoles = async (req, res) => {
  try {
    const roles = [
      { value: "admin", label: "Quản trị viên" },
      { value: "superior_general", label: "Bề trên Tổng Quyền" },
      { value: "superior_provincial", label: "Bề trên Tỉnh Dòng" },
      { value: "superior_community", label: "Bề trên Cộng đoàn" },
      { value: "secretary", label: "Thư ký" },
      { value: "viewer", label: "Người xem" },
    ];

    return res.status(200).json({
      success: true,
      data: roles,
    });
  } catch (error) {
    console.error("getUserRoles error:", error.message);
    return res.status(500).json({ message: "Failed to fetch user roles" });
  }
};

// ============ Community Roles ============

const getCommunityRoles = async (req, res) => {
  try {
    const roles = await CommunityRoleModel.getActiveRoles();
    return res.status(200).json({
      success: true,
      data: roles,
    });
  } catch (error) {
    console.error("getCommunityRoles error:", error.message);
    return res.status(500).json({ message: "Failed to fetch community roles" });
  }
};

const getAllCommunityRoles = async (req, res) => {
  try {
    const roles = await CommunityRoleModel.getAll();
    return res.status(200).json({
      success: true,
      data: roles,
    });
  } catch (error) {
    console.error("getAllCommunityRoles error:", error.message);
    return res.status(500).json({ message: "Failed to fetch community roles" });
  }
};

const createCommunityRole = async (req, res) => {
  try {
    const { name, description, display_order, color } = req.body;

    if (!name) {
      return res.status(400).json({ message: "Name is required" });
    }

    // Auto-generate code from Vietnamese name
    const vietnameseMap = {
      à: "a",
      á: "a",
      ả: "a",
      ã: "a",
      ạ: "a",
      ă: "a",
      ằ: "a",
      ắ: "a",
      ẳ: "a",
      ẵ: "a",
      ặ: "a",
      â: "a",
      ầ: "a",
      ấ: "a",
      ẩ: "a",
      ẫ: "a",
      ậ: "a",
      đ: "d",
      è: "e",
      é: "e",
      ẻ: "e",
      ẽ: "e",
      ẹ: "e",
      ê: "e",
      ề: "e",
      ế: "e",
      ể: "e",
      ễ: "e",
      ệ: "e",
      ì: "i",
      í: "i",
      ỉ: "i",
      ĩ: "i",
      ị: "i",
      ò: "o",
      ó: "o",
      ỏ: "o",
      õ: "o",
      ọ: "o",
      ô: "o",
      ồ: "o",
      ố: "o",
      ổ: "o",
      ỗ: "o",
      ộ: "o",
      ơ: "o",
      ờ: "o",
      ớ: "o",
      ở: "o",
      ỡ: "o",
      ợ: "o",
      ù: "u",
      ú: "u",
      ủ: "u",
      ũ: "u",
      ụ: "u",
      ư: "u",
      ừ: "u",
      ứ: "u",
      ử: "u",
      ữ: "u",
      ự: "u",
      ỳ: "y",
      ý: "y",
      ỷ: "y",
      ỹ: "y",
      ỵ: "y",
    };

    // Convert Vietnamese to ASCII
    let code = name.toLowerCase();
    for (const [vietnamese, ascii] of Object.entries(vietnameseMap)) {
      code = code.replace(new RegExp(vietnamese, "g"), ascii);
    }
    // Replace special characters and spaces with underscores
    code = code.replace(/[^a-z0-9]+/g, "_").replace(/^_+|_+$/g, "");

    // Check if code already exists and add suffix if needed
    let finalCode = code;
    let counter = 1;
    while (await CommunityRoleModel.findByCode(finalCode)) {
      finalCode = `${code}_${counter}`;
      counter++;
    }

    const role = await CommunityRoleModel.create({
      code: finalCode,
      name,
      description,
      display_order: display_order || 0,
      color: color || "#6c757d",
      is_default: false,
      is_active: true,
    });

    return res.status(201).json({
      success: true,
      data: role,
    });
  } catch (error) {
    console.error("createCommunityRole error:", error.message);
    return res.status(500).json({ message: "Failed to create community role" });
  }
};

const updateCommunityRole = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await CommunityRoleModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Community role not found" });
    }

    // Prevent updating default roles' code
    if (
      existing.is_default &&
      req.body.code &&
      req.body.code !== existing.code
    ) {
      return res
        .status(400)
        .json({ message: "Không thể thay đổi mã của chức vụ mặc định" });
    }

    const updated = await CommunityRoleModel.update(id, req.body);
    return res.status(200).json({
      success: true,
      data: updated,
    });
  } catch (error) {
    console.error("updateCommunityRole error:", error.message);
    return res.status(500).json({ message: "Failed to update community role" });
  }
};

const deleteCommunityRole = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await CommunityRoleModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Community role not found" });
    }

    // Prevent deleting default roles
    if (existing.is_default) {
      return res.status(400).json({
        message: "Không thể xóa chức vụ mặc định",
      });
    }

    // Check if role is being used in community_members table
    const usageCount = await CommunityRoleModel.executeQuery(
      "SELECT COUNT(*) as count FROM community_members WHERE role = ?",
      [existing.code]
    );

    if (usageCount[0].count > 0) {
      return res.status(400).json({
        message: `Không thể xóa chức vụ này vì đang được sử dụng bởi ${usageCount[0].count} bổ nhiệm`,
        usageCount: usageCount[0].count,
      });
    }

    // Hard delete if not used
    await CommunityRoleModel.delete(id);
    return res.status(200).json({
      success: true,
      message: "Đã xóa chức vụ thành công",
    });
  } catch (error) {
    console.error("deleteCommunityRole error:", error.message);
    return res.status(500).json({ message: "Failed to delete community role" });
  }
};

// ============ Education Levels ============

const getEducationLevels = async (req, res) => {
  try {
    const levels = await EducationLevelModel.getActiveLevels();
    return res.status(200).json({
      success: true,
      data: levels,
    });
  } catch (error) {
    console.error("getEducationLevels error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to fetch education levels" });
  }
};

const getAllEducationLevels = async (req, res) => {
  try {
    const levels = await EducationLevelModel.getAll();
    return res.status(200).json({
      success: true,
      data: levels,
    });
  } catch (error) {
    console.error("getAllEducationLevels error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to fetch education levels" });
  }
};

const createEducationLevel = async (req, res) => {
  try {
    const { name, description, display_order, color } = req.body;

    if (!name) {
      return res.status(400).json({ message: "Name is required" });
    }

    // Auto-generate code from name
    // Convert Vietnamese to ASCII, lowercase, and replace spaces with underscores
    const vietnameseMap = {
      à: "a",
      á: "a",
      ả: "a",
      ã: "a",
      ạ: "a",
      ă: "a",
      ằ: "a",
      ắ: "a",
      ẳ: "a",
      ẵ: "a",
      ặ: "a",
      â: "a",
      ầ: "a",
      ấ: "a",
      ẩ: "a",
      ẫ: "a",
      ậ: "a",
      đ: "d",
      è: "e",
      é: "e",
      ẻ: "e",
      ẽ: "e",
      ẹ: "e",
      ê: "e",
      ề: "e",
      ế: "e",
      ể: "e",
      ễ: "e",
      ệ: "e",
      ì: "i",
      í: "i",
      ỉ: "i",
      ĩ: "i",
      ị: "i",
      ò: "o",
      ó: "o",
      ỏ: "o",
      õ: "o",
      ọ: "o",
      ô: "o",
      ồ: "o",
      ố: "o",
      ổ: "o",
      ỗ: "o",
      ộ: "o",
      ơ: "o",
      ờ: "o",
      ớ: "o",
      ở: "o",
      ỡ: "o",
      ợ: "o",
      ù: "u",
      ú: "u",
      ủ: "u",
      ũ: "u",
      ụ: "u",
      ư: "u",
      ừ: "u",
      ứ: "u",
      ử: "u",
      ữ: "u",
      ự: "u",
      ỳ: "y",
      ý: "y",
      ỷ: "y",
      ỹ: "y",
      ỵ: "y",
    };

    let code = name.toLowerCase();
    // Replace Vietnamese characters
    for (const [viet, latin] of Object.entries(vietnameseMap)) {
      code = code.replace(new RegExp(viet, "g"), latin);
    }
    // Replace spaces and special characters with underscore
    code = code.replace(/[^a-z0-9]+/g, "_").replace(/^_+|_+$/g, "");

    // Check if code already exists, if so add number suffix
    let finalCode = code;
    let counter = 1;
    while (await EducationLevelModel.findByCode(finalCode)) {
      finalCode = `${code}_${counter}`;
      counter++;
    }

    const level = await EducationLevelModel.create({
      code: finalCode,
      name,
      description,
      display_order: display_order || 0,
      color: color || "#6c757d",
      is_active: true,
    });

    return res.status(201).json({
      success: true,
      data: level,
    });
  } catch (error) {
    console.error("createEducationLevel error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to create education level" });
  }
};

const updateEducationLevel = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await EducationLevelModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Education level not found" });
    }

    const updated = await EducationLevelModel.update(id, req.body);
    return res.status(200).json({
      success: true,
      data: updated,
    });
  } catch (error) {
    console.error("updateEducationLevel error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to update education level" });
  }
};

const deleteEducationLevel = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await EducationLevelModel.findById(id);

    if (!existing) {
      return res.status(404).json({ message: "Education level not found" });
    }

    // Check if level is being used in education table
    const usageCount = await EducationLevelModel.executeQuery(
      "SELECT COUNT(*) as count FROM education WHERE level = ?",
      [existing.code]
    );

    if (usageCount[0].count > 0) {
      return res.status(400).json({
        message: `Không thể xóa trình độ này vì đang được sử dụng bởi ${usageCount[0].count} hồ sơ học vấn`,
        usageCount: usageCount[0].count,
      });
    }

    // Hard delete if not used
    await EducationLevelModel.delete(id);
    return res.status(200).json({
      success: true,
      message: "Đã xóa trình độ thành công",
    });
  } catch (error) {
    console.error("deleteEducationLevel error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to delete education level" });
  }
};

module.exports = {
  getJourneyStages,
  getAllJourneyStages,
  createJourneyStage,
  updateJourneyStage,
  deleteJourneyStage,
  getSisterStatuses,
  getAllSisterStatuses,
  createSisterStatus,
  updateSisterStatus,
  deleteSisterStatus,
  getUserRoles,
  getCommunityRoles,
  getAllCommunityRoles,
  createCommunityRole,
  updateCommunityRole,
  deleteCommunityRole,
  getEducationLevels,
  getAllEducationLevels,
  createEducationLevel,
  updateEducationLevel,
  deleteEducationLevel,
};
