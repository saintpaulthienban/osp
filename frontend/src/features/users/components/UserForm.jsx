// frontend/src/features/users/components/UserForm.jsx

import React, { useState, useEffect } from "react";
import {
  Modal,
  Form,
  Button,
  Row,
  Col,
  Card,
  Tabs,
  Tab,
  Alert,
  Spinner,
  Badge,
} from "react-bootstrap";
import userService from "@services/userService";
import PermissionSelector from "./PermissionSelector";
import CommunityPermissionSelector from "./CommunityPermissionSelector";

const UserForm = ({ show, onHide, user, onSuccess }) => {
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    password: "",
    full_name: "",
    phone: "",
  });
  const [selectedPermissions, setSelectedPermissions] = useState([]);
  const [communityPermissions, setCommunityPermissions] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    if (show) {
      if (user) {
        loadUserData();
      } else {
        resetForm();
      }
    }
  }, [show, user]);

  const loadUserData = async () => {
    try {
      setFormData({
        username: user.username,
        email: user.email,
        full_name: user.full_name || "",
        phone: user.phone || "",
        password: "",
      });

      // Load user's permissions
      const permsResponse = await userService.getPermissions(user.id);
      if (permsResponse.success) {
        setSelectedPermissions(permsResponse.data.map((p) => p.id));
      }

      // Load user's community permissions
      const commResponse = await userService.getCommunityPermissions(user.id);
      if (commResponse.success) {
        setCommunityPermissions(
          commResponse.data.map((c) => ({
            community_id: c.id,
            can_view: c.can_view,
            can_edit: c.can_edit,
            can_manage_members: c.can_manage_members,
          }))
        );
      }
    } catch (error) {
      console.error("Load user data error:", error);
    }
  };

  const resetForm = () => {
    setFormData({
      username: "",
      email: "",
      password: "",
      full_name: "",
      phone: "",
    });
    setSelectedPermissions([]);
    setCommunityPermissions([]);
    setError("");
  };

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    try {
      const data = {
        ...formData,
        permission_ids: selectedPermissions,
        community_permissions: communityPermissions,
      };

      let response;
      if (user) {
        // Update user
        response = await userService.update(user.id, data);

        // Update permissions
        await userService.updatePermissions(user.id, selectedPermissions);

        // Update community permissions
        await userService.updateCommunityPermissions(
          user.id,
          communityPermissions
        );
      } else {
        // Create user
        response = await userService.create(data);
      }

      if (response.success) {
        onSuccess();
        onHide();
      } else {
        setError(response.error || "Có lỗi xảy ra");
      }
    } catch (err) {
      console.error("Submit error:", err);
      setError(err.response?.data?.error || "Có lỗi xảy ra");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Modal show={show} onHide={onHide} size="xl" scrollable>
      <Modal.Header closeButton>
        <Modal.Title>
          <i className="fas fa-user-plus me-2"></i>
          {user ? "Chỉnh sửa người dùng" : "Tạo người dùng mới"}
        </Modal.Title>
      </Modal.Header>

      <Form onSubmit={handleSubmit}>
        <Modal.Body>
          {error && (
            <Alert variant="danger" dismissible onClose={() => setError("")}>
              <i className="fas fa-exclamation-circle me-2"></i>
              {error}
            </Alert>
          )}

          <Tabs defaultActiveKey="basic" className="mb-3">
            {/* Tab 1: Thông tin cơ bản */}
            <Tab
              eventKey="basic"
              title={
                <>
                  <i className="fas fa-info-circle me-2"></i>
                  Thông tin cơ bản
                </>
              }
            >
              <Card>
                <Card.Body>
                  <Row>
                    <Col md={6}>
                      <Form.Group className="mb-3">
                        <Form.Label>
                          Tên đăng nhập <span className="text-danger">*</span>
                        </Form.Label>
                        <Form.Control
                          type="text"
                          name="username"
                          value={formData.username}
                          onChange={handleChange}
                          required
                          disabled={!!user}
                        />
                      </Form.Group>
                    </Col>

                    <Col md={6}>
                      <Form.Group className="mb-3">
                        <Form.Label>
                          Email <span className="text-danger">*</span>
                        </Form.Label>
                        <Form.Control
                          type="email"
                          name="email"
                          value={formData.email}
                          onChange={handleChange}
                          required
                        />
                      </Form.Group>
                    </Col>

                    <Col md={6}>
                      <Form.Group className="mb-3">
                        <Form.Label>
                          Mật khẩu{" "}
                          {!user && <span className="text-danger">*</span>}
                        </Form.Label>
                        <Form.Control
                          type="password"
                          name="password"
                          value={formData.password}
                          onChange={handleChange}
                          required={!user}
                          placeholder={user ? "Để trống nếu không đổi" : ""}
                        />
                        {!user && (
                          <Form.Text className="text-muted">
                            Mật khẩu phải có ít nhất 6 ký tự
                          </Form.Text>
                        )}
                      </Form.Group>
                    </Col>

                    <Col md={6}>
                      <Form.Group className="mb-3">
                        <Form.Label>Họ và tên</Form.Label>
                        <Form.Control
                          type="text"
                          name="full_name"
                          value={formData.full_name}
                          onChange={handleChange}
                        />
                      </Form.Group>
                    </Col>

                    <Col md={6}>
                      <Form.Group className="mb-3">
                        <Form.Label>Số điện thoại</Form.Label>
                        <Form.Control
                          type="text"
                          name="phone"
                          value={formData.phone}
                          onChange={handleChange}
                        />
                      </Form.Group>
                    </Col>
                  </Row>
                </Card.Body>
              </Card>
            </Tab>

            {/* Tab 2: Phân quyền chức năng */}
            <Tab
              eventKey="permissions"
              title={
                <>
                  <i className="fas fa-shield-alt me-2"></i>
                  Phân quyền chức năng
                  <Badge bg="primary" className="ms-2">
                    {selectedPermissions.length}
                  </Badge>
                </>
              }
            >
              <PermissionSelector
                value={selectedPermissions}
                onChange={setSelectedPermissions}
              />
            </Tab>

            {/* Tab 3: Phân quyền cộng đoàn */}
            <Tab
              eventKey="communities"
              title={
                <>
                  <i className="fas fa-home me-2"></i>
                  Phân quyền cộng đoàn
                  <Badge bg="success" className="ms-2">
                    {communityPermissions.length}
                  </Badge>
                </>
              }
            >
              <CommunityPermissionSelector
                value={communityPermissions}
                onChange={setCommunityPermissions}
              />
            </Tab>
          </Tabs>
        </Modal.Body>

        <Modal.Footer>
          <Button variant="secondary" onClick={onHide} disabled={loading}>
            <i className="fas fa-times me-2"></i>
            Hủy
          </Button>
          <Button variant="primary" type="submit" disabled={loading}>
            {loading ? (
              <>
                <Spinner size="sm" className="me-2" />
                Đang lưu...
              </>
            ) : (
              <>
                <i className="fas fa-save me-2"></i>
                {user ? "Cập nhật" : "Tạo người dùng"}
              </>
            )}
          </Button>
        </Modal.Footer>
      </Form>
    </Modal>
  );
};

export default UserForm;
