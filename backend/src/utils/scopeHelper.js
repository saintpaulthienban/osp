// Helper functions to apply data scope filters to queries
// This ensures users only see data they have permission to access

/**
 * Apply scope filter to query builder or WHERE conditions
 *
 * @param {Object} scope - The user's data scope from req.userScope
 * @param {string} tableName - Main table name (e.g., 'sisters', 'communities')
 * @param {string} options - Additional options
 * @returns {Object} - { where: string, params: array }
 */
function applyScopeFilter(scope, tableName = "sisters", options = {}) {
  // Default options
  const opts = {
    communityJoinTable: "community_assignments", // Table that links to communities
    communityJoinColumn: "sister_id", // Column that joins to main table
    communityIdColumn: "community_id", // Column with community ID
    communityIdField: null, // Direct field for community ID (e.g., "s.current_community_id")
    currentOnly: true, // Only current assignments (end_date IS NULL)
    useJoin: true, // Whether to use JOIN or direct field
    ...options,
  };

  // Case 1: User can see all data
  if (scope.type === "all") {
    return {
      whereClause: "", // No filter needed
      params: [],
      needsJoin: false,
    };
  }

  // Case 2: User can only see data from assigned communities
  if (scope.type === "community") {
    if (!scope.community_ids || scope.community_ids.length === 0) {
      // User has no communities assigned - return impossible condition
      return {
        whereClause: "1 = 0", // Returns no results
        params: [],
        needsJoin: false,
      };
    }

    // Build IN clause
    const placeholders = scope.community_ids.map(() => "?").join(",");

    // Option 1: Use direct field (e.g., s.current_community_id)
    if (opts.communityIdField && opts.useJoin === false) {
      return {
        whereClause: `${opts.communityIdField} IN (${placeholders})`,
        params: scope.community_ids,
        needsJoin: false,
      };
    }

    // Option 2: Use JOIN with community_assignments
    const currentCondition = opts.currentOnly ? " AND end_date IS NULL" : "";

    return {
      whereClause: `${opts.communityIdColumn} IN (${placeholders})${currentCondition}`,
      params: scope.community_ids,
      needsJoin: true,
      joinTable: opts.communityJoinTable,
      joinColumn: opts.communityJoinColumn,
    };
  }

  // Case 3: User can only see their own data
  if (scope.type === "own") {
    // This is rarely used for sisters/communities
    // More common for user management
    return {
      whereClause: `${tableName}.created_by = ?`,
      params: [scope.user_id],
      needsJoin: false,
    };
  }

  // Default: return impossible condition
  return {
    whereClause: "1 = 0",
    params: [],
    needsJoin: false,
  };
}

/**
 * Build a query with scope filter applied
 *
 * @param {Object} scope - The user's data scope
 * @param {string} baseQuery - Base SELECT query
 * @param {Array} baseParams - Base query parameters
 * @param {Object} options - Scope filter options
 * @returns {Object} - { query: string, params: array }
 */
function buildScopedQuery(scope, baseQuery, baseParams = [], options = {}) {
  const filter = applyScopeFilter(scope, options.tableName, options);

  let query = baseQuery;
  let params = [...baseParams];

  // Add JOIN if needed
  if (filter.needsJoin) {
    const tableName = options.tableName || "sisters";
    const joinTable = filter.joinTable;
    const joinColumn = filter.joinColumn;

    // Check if query already has JOIN to avoid duplicate
    if (!query.toLowerCase().includes(`join ${joinTable}`)) {
      query = query.replace(
        /FROM\s+(\w+)/i,
        `FROM $1 INNER JOIN ${joinTable} ON ${tableName}.id = ${joinTable}.${joinColumn}`
      );
    }
  }

  // Add WHERE clause
  if (filter.whereClause) {
    if (query.toLowerCase().includes("where")) {
      // Append to existing WHERE
      query = query.replace(/WHERE/i, `WHERE (${filter.whereClause}) AND`);
    } else {
      // Add new WHERE before ORDER BY or GROUP BY or LIMIT
      query = query.replace(
        /(ORDER BY|GROUP BY|LIMIT)/i,
        `WHERE ${filter.whereClause} $1`
      );
      // If no ORDER BY, GROUP BY, LIMIT, add at the end
      if (!/(ORDER BY|GROUP BY|LIMIT)/i.test(query)) {
        query += ` WHERE ${filter.whereClause}`;
      }
    }

    // Add filter parameters at the beginning
    params = [...filter.params, ...params];
  }

  return { query, params };
}

/**
 * Apply scope filter for aggregate queries (COUNT, SUM, etc.)
 *
 * @param {Object} scope - The user's data scope
 * @param {Object} options - Filter options
 * @returns {string} - WHERE clause for aggregate query
 */
function getScopeWhereClause(scope, options = {}) {
  const filter = applyScopeFilter(scope, options.tableName, options);
  return filter.whereClause || "1=1";
}

/**
 * Get SQL parameters for scope filter
 *
 * @param {Object} scope - The user's data scope
 * @param {Object} options - Filter options
 * @returns {Array} - Parameters array
 */
function getScopeParams(scope, options = {}) {
  const filter = applyScopeFilter(scope, options.tableName, options);
  return filter.params;
}

/**
 * Check if user has access to specific data
 * Used for detail views and updates
 *
 * @param {Object} scope - The user's data scope
 * @param {number} itemId - ID of the item to check
 * @param {string} tableName - Table name
 * @param {Function} getCommunitiesCallback - Function to get item's communities
 * @returns {Promise<boolean>} - True if user has access
 */
async function checkScopeAccess(
  scope,
  itemId,
  tableName,
  getCommunitiesCallback
) {
  // All scope always has access
  if (scope.type === "all") {
    return true;
  }

  // Community scope - check if item belongs to user's communities
  if (scope.type === "community") {
    if (!scope.community_ids || scope.community_ids.length === 0) {
      return false;
    }

    const itemCommunities = await getCommunitiesCallback(itemId);
    return itemCommunities.some((cid) =>
      scope.community_ids.includes(Number(cid))
    );
  }

  // Own scope - check if item created by user
  if (scope.type === "own") {
    const db = require("../config/database");
    const [rows] = await db.query(
      `SELECT created_by FROM ${tableName} WHERE id = ?`,
      [itemId]
    );
    return rows[0]?.created_by === scope.user_id;
  }

  return false;
}

module.exports = {
  applyScopeFilter,
  buildScopedQuery,
  getScopeWhereClause,
  getScopeParams,
  checkScopeAccess,
};
