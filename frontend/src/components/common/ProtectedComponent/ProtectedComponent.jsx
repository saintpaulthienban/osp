// frontend/src/components/common/ProtectedComponent/ProtectedComponent.jsx

import React from "react";
import { useAuth } from "@context/AuthContext";

/**
 * Component wrapper that protects content based on user permissions
 * @param {string|string[]} permission - Required permission(s) to view content
 * @param {string} fallback - Optional fallback content when permission denied
 * @param {boolean} requireAll - If true, requires all permissions (default: false - requires any)
 */
const ProtectedComponent = ({
  children,
  permission,
  permissions = [],
  fallback = null,
  requireAll = false,
}) => {
  const { user, hasPermission } = useAuth();

  // If no permission check required, render children
  if (!permission && permissions.length === 0) {
    return <>{children}</>;
  }

  // Check single permission
  if (permission && !Array.isArray(permission)) {
    if (!hasPermission(permission)) {
      return fallback;
    }
    return <>{children}</>;
  }

  // Check multiple permissions
  const permsToCheck = Array.isArray(permission) ? permission : permissions;

  if (requireAll) {
    // Require ALL permissions
    const hasAllPermissions = permsToCheck.every((perm) => hasPermission(perm));
    if (!hasAllPermissions) {
      return fallback;
    }
  } else {
    // Require ANY permission
    const hasAnyPermission = permsToCheck.some((perm) => hasPermission(perm));
    if (!hasAnyPermission) {
      return fallback;
    }
  }

  return <>{children}</>;
};

export default ProtectedComponent;
