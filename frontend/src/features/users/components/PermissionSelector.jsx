// frontend/src/features/users/components/PermissionSelector.jsx

import React, { useState, useEffect } from "react";
import {
  Card,
  Form,
  Accordion,
  Badge,
  Button,
  Row,
  Col,
  Alert,
  Spinner,
} from "react-bootstrap";
import permissionService from "@services/permissionService";
import "./PermissionSelector.css";

const PermissionSelector = ({ value = [], onChange }) => {
  const [permissions, setPermissions] = useState([]);
  const [permissionGroups, setPermissionGroups] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [selectedPermissions, setSelectedPermissions] = useState(value);

  useEffect(() => {
    loadPermissions();
  }, []);

  useEffect(() => {
    setSelectedPermissions(value);
  }, [value]);

  const loadPermissions = async () => {
    try {
      setLoading(true);
      const [permsRes, groupsRes] = await Promise.all([
        permissionService.getAll(),
        permissionService.getGroups(),
      ]);

      if (permsRes.success) {
        setPermissions(permsRes.data);
      }

      if (groupsRes.success) {
        setPermissionGroups(groupsRes.data);
      }
    } catch (err) {
      console.error("Load permissions error:", err);
      setError("Không thể tải danh sách quyền");
    } finally {
      setLoading(false);
    }
  };

  const handlePermissionToggle = (permissionId) => {
    const newSelected = selectedPermissions.includes(permissionId)
      ? selectedPermissions.filter((id) => id !== permissionId)
      : [...selectedPermissions, permissionId];

    setSelectedPermissions(newSelected);
    onChange(newSelected);
  };

  const handleSelectAllModule = (modulePermissions, checked) => {
    const moduleIds = modulePermissions.map((p) => p.id);

    const newSelected = checked
      ? [...new Set([...selectedPermissions, ...moduleIds])]
      : selectedPermissions.filter((id) => !moduleIds.includes(id));

    setSelectedPermissions(newSelected);
    onChange(newSelected);
  };

  const handleSelectGroup = async (groupId) => {
    try {
      const response = await permissionService.getGroupPermissions(groupId);
      if (response.success) {
        const groupPermIds = response.data.map((p) => p.id);
        const newSelected = [
          ...new Set([...selectedPermissions, ...groupPermIds]),
        ];
        setSelectedPermissions(newSelected);
        onChange(newSelected);
      }
    } catch (error) {
      console.error("Select group error:", error);
    }
  };

  const handleSelectAll = () => {
    const allIds = permissions.map((p) => p.id);
    setSelectedPermissions(allIds);
    onChange(allIds);
  };

  const handleDeselectAll = () => {
    setSelectedPermissions([]);
    onChange([]);
  };

  if (loading) {
    return (
      <Card>
        <Card.Body className="text-center py-5">
          <Spinner animation="border" variant="primary" />
          <p className="mt-3 text-muted">Đang tải danh sách quyền...</p>
        </Card.Body>
      </Card>
    );
  }

  if (error) {
    return (
      <Alert variant="danger">
        <i className="fas fa-exclamation-triangle me-2"></i>
        {error}
      </Alert>
    );
  }

  // Group permissions by module
  const permissionsByModule = permissions.reduce((acc, perm) => {
    const module = perm.module || "Khác";
    if (!acc[module]) acc[module] = [];
    acc[module].push(perm);
    return acc;
  }, {});

  const hasAllModulePermissions = (modulePerms) => {
    return modulePerms.every((p) => selectedPermissions.includes(p.id));
  };

  const hasSomeModulePermissions = (modulePerms) => {
    return modulePerms.some((p) => selectedPermissions.includes(p.id));
  };

  return (
    <>
      {/* Permission Groups (Quick Select) */}
      {permissionGroups.length > 0 && (
        <Card className="mb-3">
          <Card.Header className="bg-white">
            <h6 className="mb-0">
              <i className="fas fa-layer-group me-2"></i>
              Chọn nhanh theo nhóm
            </h6>
          </Card.Header>
          <Card.Body>
            <div className="d-flex flex-wrap gap-2">
              {permissionGroups.map((group) => (
                <Button
                  key={group.id}
                  variant="outline-primary"
                  size="sm"
                  onClick={() => handleSelectGroup(group.id)}
                >
                  <i className={`fas fa-${group.icon} me-1`}></i>
                  {group.name}
                  <Badge bg="secondary" className="ms-2">
                    {group.permission_count}
                  </Badge>
                </Button>
              ))}
            </div>
          </Card.Body>
        </Card>
      )}

      {/* Permissions */}
      <Card className="permission-selector">
        <Card.Header className="bg-white d-flex justify-content-between align-items-center">
          <div>
            <h6 className="mb-0">
              <i className="fas fa-shield-alt me-2"></i>
              Phân quyền chi tiết
            </h6>
            <small className="text-muted">
              Chọn các quyền cụ thể cho người dùng
            </small>
          </div>
          <div className="d-flex gap-2">
            <Badge bg="primary">
              {selectedPermissions.length}/{permissions.length}
            </Badge>
            <Button
              variant="outline-primary"
              size="sm"
              onClick={handleSelectAll}
            >
              Chọn tất cả
            </Button>
            <Button
              variant="outline-secondary"
              size="sm"
              onClick={handleDeselectAll}
            >
              Bỏ chọn tất cả
            </Button>
          </div>
        </Card.Header>

        <Card.Body className="p-0">
          <Accordion defaultActiveKey="0">
            {Object.entries(permissionsByModule).map(
              ([module, modulePerms], index) => {
                const allSelected = hasAllModulePermissions(modulePerms);
                const someSelected = hasSomeModulePermissions(modulePerms);

                return (
                  <Accordion.Item key={module} eventKey={String(index)}>
                    <Accordion.Header>
                      <div className="d-flex align-items-center w-100">
                        <Form.Check
                          type="checkbox"
                          checked={allSelected}
                          ref={(input) => {
                            if (input) {
                              input.indeterminate =
                                !allSelected && someSelected;
                            }
                          }}
                          onChange={(e) => {
                            e.stopPropagation();
                            handleSelectAllModule(
                              modulePerms,
                              e.target.checked
                            );
                          }}
                          onClick={(e) => e.stopPropagation()}
                          className="me-3"
                        />
                        <i
                          className={`fas fa-${
                            modulePerms[0]?.icon || "folder"
                          } me-2`}
                        ></i>
                        <strong>{module}</strong>
                        <Badge bg="secondary" className="ms-auto me-2">
                          {
                            modulePerms.filter((p) =>
                              selectedPermissions.includes(p.id)
                            ).length
                          }
                          /{modulePerms.length}
                        </Badge>
                      </div>
                    </Accordion.Header>
                    <Accordion.Body>
                      <Row>
                        {modulePerms.map((permission) => (
                          <Col key={permission.id} md={6} className="mb-2">
                            <Form.Check
                              type="checkbox"
                              id={`perm-${permission.id}`}
                              label={
                                <span>
                                  <i
                                    className={`fas fa-${permission.icon} me-2 text-muted`}
                                  ></i>
                                  {permission.name}
                                </span>
                              }
                              checked={selectedPermissions.includes(
                                permission.id
                              )}
                              onChange={() =>
                                handlePermissionToggle(permission.id)
                              }
                            />
                          </Col>
                        ))}
                      </Row>
                    </Accordion.Body>
                  </Accordion.Item>
                );
              }
            )}
          </Accordion>
        </Card.Body>
      </Card>
    </>
  );
};

export default PermissionSelector;
