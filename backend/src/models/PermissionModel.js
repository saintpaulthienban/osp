// src/models/PermissionModel.js

const BaseModel = require("./BaseModel");

class PermissionModel extends BaseModel {
  constructor() {
    super("permissions");
  }

  /**
   * Get all permissions grouped by module
   */
  async getAllGroupedByModule() {
    const query = `
      SELECT * FROM ${this.table}
      ORDER BY module, name
    `;
    const permissions = await this.executeQuery(query);

    // Group by module
    const grouped = {};
    permissions.forEach((perm) => {
      if (!grouped[perm.module]) {
        grouped[perm.module] = [];
      }
      grouped[perm.module].push(perm);
    });

    return grouped;
  }

  /**
   * Get permission by code
   */
  async getByCode(code) {
    return this.findOne({ code });
  }

  /**
   * Get permissions by codes
   */
  async getByCodes(codes) {
    if (!codes || codes.length === 0) return [];
    const placeholders = codes.map(() => "?").join(",");
    const query = `SELECT * FROM ${this.table} WHERE code IN (${placeholders})`;
    return this.executeQuery(query, codes);
  }

  /**
   * Get permissions by module
   */
  async getByModule(module) {
    return this.find({ module });
  }
}

module.exports = new PermissionModel();
