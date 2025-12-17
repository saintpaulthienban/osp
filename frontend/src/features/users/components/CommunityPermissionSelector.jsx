// frontend/src/features/users/components/CommunityPermissionSelector.jsx

import React, { useState, useEffect } from "react";
import {
  Card,
  Form,
  Table,
  Badge,
  Button,
  Alert,
  Spinner,
} from "react-bootstrap";
import communityService from "@services/communityService";
import "./CommunityPermissionSelector.css";

const CommunityPermissionSelector = ({ value = [], onChange }) => {
  const [communities, setCommunities] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [selectedCommunities, setSelectedCommunities] = useState(value);

  useEffect(() => {
    loadCommunities();
  }, []);

  useEffect(() => {
    setSelectedCommunities(value);
  }, [value]);

  const loadCommunities = async () => {
    try {
      setLoading(true);
      const response = await communityService.getAllSimple();

      if (response.success) {
        setCommunities(response.data);
      }
    } catch (err) {
      console.error("Load communities error:", err);
      setError("Không thể tải danh sách cộng đoàn");
    } finally {
      setLoading(false);
    }
  };

  const handleCommunityToggle = (communityId) => {
    const exists = selectedCommunities.find(
      (sc) => sc.community_id === communityId
    );

    let newSelected;
    if (exists) {
      newSelected = selectedCommunities.filter(
        (sc) => sc.community_id !== communityId
      );
    } else {
      newSelected = [
        ...selectedCommunities,
        {
          community_id: communityId,
          can_view: true,
          can_edit: false,
          can_manage_members: false,
        },
      ];
    }

    setSelectedCommunities(newSelected);
    onChange(newSelected);
  };

  const handlePermissionChange = (communityId, permissionKey, checked) => {
    const newSelected = selectedCommunities.map((sc) => {
      if (sc.community_id === communityId) {
        return {
          ...sc,
          [permissionKey]: checked,
        };
      }
      return sc;
    });

    setSelectedCommunities(newSelected);
    onChange(newSelected);
  };

  const handleSelectAll = (checked) => {
    if (checked) {
      const allSelected = communities.map((c) => ({
        community_id: c.id,
        can_view: true,
        can_edit: false,
        can_manage_members: false,
      }));
      setSelectedCommunities(allSelected);
      onChange(allSelected);
    } else {
      setSelectedCommunities([]);
      onChange([]);
    }
  };

  const isSelected = (communityId) => {
    return selectedCommunities.some((sc) => sc.community_id === communityId);
  };

  const getCommunityPermissions = (communityId) => {
    return (
      selectedCommunities.find((sc) => sc.community_id === communityId) || {}
    );
  };

  if (loading) {
    return (
      <Card>
        <Card.Body className="text-center py-5">
          <Spinner animation="border" variant="primary" />
          <p className="mt-3 text-muted">Đang tải danh sách cộng đoàn...</p>
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

  const allSelected =
    communities.length > 0 && selectedCommunities.length === communities.length;
  const someSelected =
    selectedCommunities.length > 0 &&
    selectedCommunities.length < communities.length;

  return (
    <Card className="community-permission-selector">
      <Card.Header className="bg-white d-flex justify-content-between align-items-center">
        <div>
          <h6 className="mb-0">
            <i className="fas fa-home me-2"></i>
            Quyền truy cập Cộng Đoàn
          </h6>
          <small className="text-muted">
            Chọn các cộng đoàn mà người dùng có thể truy cập và quản lý
          </small>
        </div>
        <Badge bg="primary">
          {selectedCommunities.length}/{communities.length} đã chọn
        </Badge>
      </Card.Header>

      <Card.Body className="p-0">
        <div className="table-responsive">
          <Table className="mb-0 community-permission-table">
            <thead className="bg-light">
              <tr>
                <th style={{ width: "40px" }}>
                  <Form.Check
                    type="checkbox"
                    checked={allSelected}
                    ref={(input) => {
                      if (input) {
                        input.indeterminate = someSelected;
                      }
                    }}
                    onChange={(e) => handleSelectAll(e.target.checked)}
                  />
                </th>
                <th>Cộng đoàn</th>
                <th className="text-center" style={{ width: "120px" }}>
                  <i className="fas fa-eye me-1"></i>
                  Xem
                </th>
                <th className="text-center" style={{ width: "120px" }}>
                  <i className="fas fa-edit me-1"></i>
                  Chỉnh sửa
                </th>
                <th className="text-center" style={{ width: "150px" }}>
                  <i className="fas fa-users-cog me-1"></i>
                  Quản lý thành viên
                </th>
              </tr>
            </thead>
            <tbody>
              {communities.length === 0 ? (
                <tr>
                  <td colSpan="5" className="text-center py-4 text-muted">
                    <i className="fas fa-inbox fa-2x mb-3 d-block"></i>
                    Chưa có cộng đoàn nào
                  </td>
                </tr>
              ) : (
                communities.map((community) => {
                  const selected = isSelected(community.id);
                  const permissions = getCommunityPermissions(community.id);

                  return (
                    <tr
                      key={community.id}
                      className={selected ? "selected" : ""}
                    >
                      <td>
                        <Form.Check
                          type="checkbox"
                          checked={selected}
                          onChange={() => handleCommunityToggle(community.id)}
                        />
                      </td>
                      <td>
                        <div className="d-flex align-items-center">
                          <div className="community-icon me-2">
                            <i className="fas fa-home"></i>
                          </div>
                          <div>
                            <div className="fw-bold">{community.name}</div>
                            <small className="text-muted">
                              <i className="fas fa-barcode me-1"></i>
                              {community.code}
                            </small>
                          </div>
                        </div>
                      </td>
                      <td className="text-center">
                        <Form.Check
                          type="checkbox"
                          checked={permissions.can_view || false}
                          onChange={(e) =>
                            handlePermissionChange(
                              community.id,
                              "can_view",
                              e.target.checked
                            )
                          }
                          disabled={!selected}
                        />
                      </td>
                      <td className="text-center">
                        <Form.Check
                          type="checkbox"
                          checked={permissions.can_edit || false}
                          onChange={(e) =>
                            handlePermissionChange(
                              community.id,
                              "can_edit",
                              e.target.checked
                            )
                          }
                          disabled={!selected}
                        />
                      </td>
                      <td className="text-center">
                        <Form.Check
                          type="checkbox"
                          checked={permissions.can_manage_members || false}
                          onChange={(e) =>
                            handlePermissionChange(
                              community.id,
                              "can_manage_members",
                              e.target.checked
                            )
                          }
                          disabled={!selected}
                        />
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </Table>
        </div>
      </Card.Body>

      {selectedCommunities.length > 0 && (
        <Card.Footer className="bg-light">
          <div className="d-flex justify-content-between align-items-center">
            <small className="text-muted">
              <i className="fas fa-info-circle me-1"></i>
              Người dùng chỉ có thể xem và quản lý nữ tu thuộc các cộng đoàn đã
              chọn
            </small>
            <Button
              variant="outline-danger"
              size="sm"
              onClick={() => handleSelectAll(false)}
            >
              <i className="fas fa-times me-1"></i>
              Bỏ chọn tất cả
            </Button>
          </div>
        </Card.Footer>
      )}
    </Card>
  );
};

export default CommunityPermissionSelector;
