// src/models/UserPermissionModel.js

const BaseModel = require("./BaseModel");

class UserPermissionModel extends BaseModel {
  constructor() {
    super("user_permissions");
  }

  /**
   * Get all permissions for a user
   */
  async getUserPermissions(userId) {
    const query = `
      SELECT p.* 
      FROM permissions p
      INNER JOIN user_permissions up ON up.permission_id = p.id
      WHERE up.user_id = ?
      ORDER BY p.module, p.name
    `;
    return this.executeQuery(query, [userId]);
  }

  /**
   * Get permission codes for a user
   */
  async getUserPermissionCodes(userId) {
    const query = `
      SELECT p.name 
      FROM permissions p
      INNER JOIN user_permissions up ON up.permission_id = p.id
      WHERE up.user_id = ?
    `;
    const results = await this.executeQuery(query, [userId]);
    return results.map((r) => r.name);
  }

  /**
   * Grant permissions to user
   */
  async grantPermissions(userId, permissionIds, grantedBy) {
    if (!permissionIds || permissionIds.length === 0) return;

    const values = permissionIds.map((permId) => [userId, permId, grantedBy]);

    const query = `
      INSERT INTO ${this.table} (user_id, permission_id, granted_by)
      VALUES ?
      ON DUPLICATE KEY UPDATE granted_at = CURRENT_TIMESTAMP, granted_by = VALUES(granted_by)
    `;

    return this.executeQuery(query, [values]);
  }

  /**
   * Revoke specific permissions from user
   */
  async revokePermissions(userId, permissionIds) {
    if (!permissionIds || permissionIds.length === 0) return;

    const placeholders = permissionIds.map(() => "?").join(",");
    const query = `
      DELETE FROM ${this.table} 
      WHERE user_id = ? AND permission_id IN (${placeholders})
    `;

    return this.executeQuery(query, [userId, ...permissionIds]);
  }

  /**
   * Revoke all permissions from user
   */
  async revokeAllPermissions(userId) {
    return this.delete({ user_id: userId });
  }

  /**
   * Sync user permissions (replace all)
   */
  async syncPermissions(userId, permissionIds, grantedBy) {
    const connection = await this.pool.getConnection();
    try {
      await connection.beginTransaction();

      // Delete all existing permissions
      await connection.query(`DELETE FROM ${this.table} WHERE user_id = ?`, [
        userId,
      ]);

      // Add new permissions
      if (permissionIds && permissionIds.length > 0) {
        const values = permissionIds.map((permId) => [
          userId,
          permId,
          grantedBy,
        ]);
        await connection.query(
          `INSERT INTO ${this.table} (user_id, permission_id, granted_by) VALUES ?`,
          [values]
        );
      }

      await connection.commit();
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  /**
   * Check if user has specific permission
   */
  async hasPermission(userId, permissionCode) {
    const query = `
      SELECT COUNT(*) as count
      FROM user_permissions up
      INNER JOIN permissions p ON p.id = up.permission_id
      WHERE up.user_id = ? AND p.code = ?
    `;
    const [result] = await this.executeQuery(query, [userId, permissionCode]);
    return result.count > 0;
  }

  /**
   * Check if user has any of the specified permissions
   */
  async hasAnyPermission(userId, permissionCodes) {
    if (!permissionCodes || permissionCodes.length === 0) return false;

    const placeholders = permissionCodes.map(() => "?").join(",");
    const query = `
      SELECT COUNT(*) as count
      FROM user_permissions up
      INNER JOIN permissions p ON p.id = up.permission_id
      WHERE up.user_id = ? AND p.code IN (${placeholders})
    `;
    const [result] = await this.executeQuery(query, [
      userId,
      ...permissionCodes,
    ]);
    return result.count > 0;
  }

  /**
   * Check if user has all specified permissions
   */
  async hasAllPermissions(userId, permissionCodes) {
    if (!permissionCodes || permissionCodes.length === 0) return true;

    const placeholders = permissionCodes.map(() => "?").join(",");
    const query = `
      SELECT COUNT(*) as count
      FROM user_permissions up
      INNER JOIN permissions p ON p.id = up.permission_id
      WHERE up.user_id = ? AND p.code IN (${placeholders})
    `;
    const [result] = await this.executeQuery(query, [
      userId,
      ...permissionCodes,
    ]);
    return result.count === permissionCodes.length;
  }
}

module.exports = new UserPermissionModel();
