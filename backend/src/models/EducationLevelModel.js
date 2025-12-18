// src/models/EducationLevelModel.js
const BaseModel = require("./BaseModel");

class EducationLevelModel extends BaseModel {
  constructor() {
    super({ tableName: "education_levels", primaryKey: "id" });
    this.allowedFields = [
      "code",
      "name",
      "description",
      "display_order",
      "color",
      "is_active",
    ];
    this.requiredFields = ["code", "name"];
  }

  async getActiveLevels() {
    const sql = `SELECT * FROM ${this.tableName} WHERE is_active = TRUE ORDER BY display_order ASC, name ASC`;
    return this.executeQuery(sql);
  }

  async findByCode(code) {
    if (!code) return null;
    const sql = `SELECT * FROM ${this.tableName} WHERE code = ? LIMIT 1`;
    const rows = await this.executeQuery(sql, [code]);
    return rows[0] || null;
  }

  async getAll() {
    const sql = `SELECT * FROM ${this.tableName} ORDER BY display_order ASC, name ASC`;
    return this.executeQuery(sql);
  }
}

module.exports = new EducationLevelModel();
