// src/features/cong-doan/pages/AssignmentFormPage.jsx

import React, { useState, useEffect } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Button,
  Form,
  Alert,
  Badge,
} from "react-bootstrap";
import { useParams, useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import {
  communityService,
  sisterService,
  lookupService,
  uploadService,
} from "@services";
import SearchableSelect from "@components/forms/SearchableSelect";
import DatePicker from "@components/forms/DatePicker";
import FileUpload from "@components/forms/FileUpload";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "./AssignmentPage.css";

const AssignmentFormPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const isEditMode = !!id;

  const [loading, setLoading] = useState(isEditMode);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");
  const [sisters, setSisters] = useState([]);
  const [communities, setCommunities] = useState([]);
  const [roles, setRoles] = useState([]);
  const [assignmentData, setAssignmentData] = useState(null);
  const [showAddRoleModal, setShowAddRoleModal] = useState(false);
  const [newRoleName, setNewRoleName] = useState("");
  const [newRoleColor, setNewRoleColor] = useState("#0984e3");
  const [addingRole, setAddingRole] = useState(false);

  // Predefined colors for roles
  const roleColors = [
    { value: "#d63031", label: "Đỏ" },
    { value: "#2d3436", label: "Đen" },
    { value: "#6c5ce7", label: "Tím" },
    { value: "#e84393", label: "Hồng" },
    { value: "#0984e3", label: "Xanh dương" },
    { value: "#00b894", label: "Xanh lá" },
    { value: "#fdcb6e", label: "Vàng" },
    { value: "#e17055", label: "Cam" },
    { value: "#636e72", label: "Xám" },
    { value: "#00cec9", label: "Ngọc" },
  ];

  const [formData, setFormData] = useState({
    sister_id: "",
    community_id: "",
    role: "superior",
    start_date: "",
    end_date: "",
    decision_number: "",
    notes: "",
    documents: [],
  });

  useEffect(() => {
    fetchInitialData();
    if (isEditMode) {
      fetchAssignmentData();
    }
  }, [id]);

  const fetchInitialData = async () => {
    try {
      const [sistersRes, communitiesRes] = await Promise.all([
        sisterService.getList({ limit: 1000 }),
        communityService.getList({ limit: 100 }),
      ]);

      if (sistersRes?.data) {
        setSisters(sistersRes.data);
      }
      if (communitiesRes?.data) {
        setCommunities(communitiesRes.data);
      }

      await fetchCommunityRoles();
    } catch (err) {
      console.error("Error fetching initial data:", err);
      setError("Không thể tải dữ liệu");
    }
  };

  const fetchCommunityRoles = async () => {
    try {
      const response = await lookupService.getCommunityRoles();
      if (response && response.data && response.data.length > 0) {
        setRoles(response.data);
      }
    } catch (error) {
      console.error("Error fetching community roles:", error);
      setError("Không thể tải danh sách chức vụ");
    }
  };

  const fetchAssignmentData = async () => {
    try {
      setLoading(true);
      // Parse id to get community_id and assignment_id
      // Format: "communityId-assignmentId" or just "assignmentId"
      const parts = id.split("-");
      let communityId, assignmentId;

      if (parts.length === 2) {
        communityId = parseInt(parts[0]);
        assignmentId = parseInt(parts[1]);
      } else {
        assignmentId = parseInt(id);
        // Need to find community_id from assignments
        const allCommunities = await communityService.getList({ limit: 100 });
        for (const community of allCommunities.data) {
          const response = await communityService.getAssignmentHistory(
            community.id
          );
          const assignments = response?.data?.assignments || [];
          const found = assignments.find((a) => a.id === assignmentId);
          if (found) {
            communityId = community.id;
            setAssignmentData({ ...found, community_id: communityId });
            setFormData({
              sister_id: found.sister_id,
              community_id: communityId,
              role: found.role || "superior",
              start_date: found.start_date?.split("T")[0] || "",
              // Ignore invalid end_date (before 1900)
              end_date:
                found.end_date && new Date(found.end_date).getFullYear() >= 1900
                  ? found.end_date.split("T")[0]
                  : "",
              decision_number: found.decision_number || "",
              notes: found.notes || "",
              documents: found.documents || [],
            });
            break;
          }
        }
        setLoading(false);
        return;
      }

      const response = await communityService.getAssignmentHistory(communityId);
      const assignments = response?.data?.assignments || [];
      const assignment = assignments.find((a) => a.id === assignmentId);

      if (assignment) {
        setAssignmentData({ ...assignment, community_id: communityId });
        setFormData({
          sister_id: assignment.sister_id,
          community_id: communityId,
          role: assignment.role || "superior",
          start_date: assignment.start_date?.split("T")[0] || "",
          // Ignore invalid end_date (before 1900)
          end_date:
            assignment.end_date &&
            new Date(assignment.end_date).getFullYear() >= 1900
              ? assignment.end_date.split("T")[0]
              : "",
          decision_number: assignment.decision_number || "",
          notes: assignment.notes || "",
          documents: assignment.documents || [],
        });
      } else {
        setError("Không tìm thấy bổ nhiệm");
      }
    } catch (err) {
      console.error("Error fetching assignment data:", err);
      setError("Không thể tải thông tin bổ nhiệm");
    } finally {
      setLoading(false);
    }
  };

  const handleAddRole = async () => {
    if (!newRoleName.trim()) {
      toast.error("Vui lòng nhập tên chức vụ");
      return;
    }

    try {
      setAddingRole(true);
      const response = await lookupService.createCommunityRole({
        name: newRoleName.trim(),
        display_order: roles.length + 1,
        color: newRoleColor,
      });

      if (response && response.data) {
        await fetchCommunityRoles();
        setNewRoleName("");
        setNewRoleColor("#0984e3");
        setShowAddRoleModal(false);
        toast.success("Đã thêm chức vụ mới thành công!");
      }
    } catch (error) {
      console.error("Error adding role:", error);
      toast.error("Không thể thêm chức vụ mới");
    } finally {
      setAddingRole(false);
    }
  };

  const handleDeleteRole = async () => {
    if (!formData.role) return;

    const role = roles.find((r) => r.code === formData.role);
    if (!role) return;

    if (!window.confirm(`Bạn có chắc chắn muốn xóa chức vụ "${role.name}"?`)) {
      return;
    }

    try {
      const response = await lookupService.deleteCommunityRole(role.id);
      if (response && response.success) {
        await fetchCommunityRoles();
        setFormData((prev) => ({ ...prev, role: "superior" }));
        toast.success("Đã xóa chức vụ thành công!");
      }
    } catch (error) {
      console.error("Error deleting role:", error);
      toast.error("Không thể xóa chức vụ");
    }
  };

  const handleFormChange = (field, value) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
  };

  const handleAddDocument = async (event) => {
    const files = event.target?.value;
    if (!files || files.length === 0) return;

    try {
      // Upload files to server
      const result = await uploadService.uploadDocuments(files);
      if (result.success && result.files) {
        // Convert uploaded files to document objects
        const newDocs = result.files.map((file) => ({
          url: file.url,
          name: file.originalName || file.name,
          size: file.size,
          uploaded_at: new Date().toISOString(),
        }));

        setFormData((prev) => ({
          ...prev,
          documents: [...prev.documents, ...newDocs],
        }));
        toast.success(`Đã tải lên ${newDocs.length} tệp thành công`);
      } else {
        toast.error(result.error || "Không thể tải tệp lên");
      }
    } catch (error) {
      console.error("Error uploading documents:", error);
      toast.error("Có lỗi xảy ra khi tải tệp lên");
    }
  };

  const handleRemoveDocument = (index) => {
    const newDocuments = formData.documents.filter((_, i) => i !== index);
    setFormData((prev) => ({ ...prev, documents: newDocuments }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!formData.sister_id || !formData.community_id) {
      toast.error("Vui lòng chọn nữ tu và cộng đoàn");
      return;
    }

    if (!formData.start_date) {
      toast.error("Vui lòng nhập ngày bắt đầu");
      return;
    }

    // Validate end_date > start_date
    if (formData.end_date && formData.start_date) {
      const startDate = new Date(formData.start_date);
      const endDate = new Date(formData.end_date);
      if (endDate <= startDate) {
        toast.error("Ngày kết thúc phải lớn hơn ngày bắt đầu");
        return;
      }
    }

    // Validate end_date <= today
    if (formData.end_date) {
      const end = new Date(formData.end_date);
      const today = new Date();
      today.setHours(0, 0, 0, 0); // Reset time to start of day
      end.setHours(0, 0, 0, 0);

      if (end > today) {
        toast.error("Ngày kết thúc không được lớn hơn ngày hôm nay");
        return;
      }
    }

    try {
      setSubmitting(true);

      const submitData = new FormData();
      submitData.append("role", formData.role);
      submitData.append("start_date", formData.start_date || "");
      // Special handling for end_date: send null if empty (for editing mode to clear date)
      if (formData.end_date) {
        submitData.append("end_date", formData.end_date);
      } else if (isEditMode) {
        submitData.append("end_date", ""); // Send empty string to clear in edit mode
      }
      submitData.append("decision_number", formData.decision_number || "");
      submitData.append("notes", formData.notes || "");

      if (!isEditMode) {
        submitData.append("sister_id", formData.sister_id);
      }

      // Append documents array as JSON string
      if (formData.documents && formData.documents.length > 0) {
        submitData.append("documents", JSON.stringify(formData.documents));
      }

      if (isEditMode && assignmentData) {
        await communityService.updateMemberRole(
          formData.community_id,
          assignmentData.id,
          submitData
        );
        toast.success("Đã cập nhật bổ nhiệm thành công");
      } else {
        await communityService.addMember(formData.community_id, submitData);
        toast.success("Đã thêm bổ nhiệm thành công");
      }

      navigate("/cong-doan/assignments");
    } catch (err) {
      console.error("Error saving assignment:", err);
      toast.error("Có lỗi xảy ra khi lưu bổ nhiệm");
    } finally {
      setSubmitting(false);
    }
  };

  const handleCancel = () => {
    navigate("/cong-doan/assignments");
  };

  if (loading) {
    return (
      <div
        className="d-flex justify-content-center align-items-center"
        style={{ minHeight: "60vh" }}
      >
        <LoadingSpinner size="large" />
      </div>
    );
  }

  return (
    <Container fluid className="py-4">
      {/* Breadcrumb */}
      <Breadcrumb
        title={isEditMode ? "Chỉnh sửa Bổ Nhiệm" : "Thêm Bổ Nhiệm Mới"}
        items={[
          { label: "Quản lý Cộng Đoàn", link: "/cong-doan" },
          { label: "Quản lý Bổ Nhiệm", link: "/cong-doan/assignments" },
          { label: isEditMode ? "Chỉnh sửa" : "Thêm mới" },
        ]}
      />

      {/* Error Alert */}
      {error && (
        <Alert variant="danger" dismissible onClose={() => setError("")}>
          <i className="fas fa-exclamation-circle me-2"></i>
          {error}
        </Alert>
      )}

      <Form onSubmit={handleSubmit}>
        <Row className="g-4">
          <Col lg={8}>
            <Card className="health-info-card">
              <Card.Header>
                <i className="fas fa-info-circle"></i>
                <span>Thông tin bổ nhiệm</span>
              </Card.Header>
              <Card.Body>
                <Row className="g-3">
                  <Col md={6}>
                    <SearchableSelect
                      label={
                        <>
                          <i className="fas fa-user text-primary me-1"></i>Nữ Tu
                        </>
                      }
                      name="sister_id"
                      value={formData.sister_id}
                      onChange={(e) =>
                        handleFormChange("sister_id", e.target.value)
                      }
                      disabled={isEditMode}
                      required
                      placeholder="Nhập tên để tìm nữ tu..."
                      maxDisplayItems={5}
                      options={(sisters || []).map((s) => {
                        const saintName = s.saint_name || "";
                        const birthName = s.birth_name || "";
                        const code = s.code || "";

                        let label = "";
                        if (saintName && birthName) {
                          label = `${saintName} - ${birthName}`;
                        } else if (birthName) {
                          label = birthName;
                        } else if (saintName) {
                          label = saintName;
                        } else {
                          label = `Nữ tu #${s.id}`;
                        }

                        if (code) {
                          label += ` (${code})`;
                        }

                        return {
                          value: s.id,
                          label: label,
                        };
                      })}
                    />
                  </Col>

                  <Col md={6}>
                    <SearchableSelect
                      label={
                        <>
                          <i className="fas fa-home text-primary me-1"></i>Cộng
                          Đoàn
                        </>
                      }
                      name="community_id"
                      value={formData.community_id}
                      onChange={(e) =>
                        handleFormChange("community_id", e.target.value)
                      }
                      disabled={isEditMode}
                      required
                      placeholder="Nhập tên để tìm cộng đoàn..."
                      maxDisplayItems={5}
                      options={(communities || []).map((c) => ({
                        value: c.id,
                        label: c.name || `Cộng đoàn #${c.id}`,
                      }))}
                    />
                  </Col>

                  <Col md={6}>
                    <Form.Label>
                      <i className="fas fa-user-tag text-primary me-1"></i>
                      Chức Vụ <span className="text-danger">*</span>
                    </Form.Label>
                    <div className="d-flex align-items-center gap-2">
                      <Form.Select
                        value={formData.role}
                        onChange={(e) =>
                          handleFormChange("role", e.target.value)
                        }
                        required
                        style={{ flex: 1 }}
                      >
                        {roles.map((role) => (
                          <option key={role.code} value={role.code}>
                            {role.name}
                          </option>
                        ))}
                      </Form.Select>
                      <Button
                        variant="outline-success"
                        size="sm"
                        onClick={() => setShowAddRoleModal(true)}
                        title="Thêm chức vụ mới"
                        style={{ flexShrink: 0 }}
                      >
                        <i className="fas fa-plus"></i>
                      </Button>
                      {formData.role && (
                        <Button
                          variant="outline-danger"
                          size="sm"
                          onClick={handleDeleteRole}
                          title="Xóa chức vụ đã chọn"
                          style={{ flexShrink: 0 }}
                        >
                          <i className="fas fa-minus"></i>
                        </Button>
                      )}
                    </div>
                  </Col>

                  <Col md={6}>
                    <DatePicker
                      label={
                        <>
                          <i className="fas fa-calendar-alt text-primary me-1"></i>
                          Ngày Bắt Đầu
                        </>
                      }
                      name="start_date"
                      value={formData.start_date}
                      onChange={(value) =>
                        handleFormChange("start_date", value)
                      }
                      required
                      placeholder="dd/mm/yyyy"
                    />
                  </Col>

                  <Col md={6}>
                    <DatePicker
                      label={
                        <>
                          <i className="fas fa-calendar-check text-primary me-1"></i>
                          Ngày Kết Thúc
                        </>
                      }
                      name="end_date"
                      value={formData.end_date}
                      onChange={(value) => handleFormChange("end_date", value)}
                      placeholder="dd/mm/yyyy"
                      hint="Để trống nếu đang trong nhiệm kỳ này"
                    />
                  </Col>

                  <Col md={6}>
                    <Form.Label>
                      <i className="fas fa-file-alt text-primary me-1"></i>
                      Quyết Định Bổ Nhiệm
                    </Form.Label>
                    <Form.Control
                      type="text"
                      placeholder="Số quyết định..."
                      value={formData.decision_number}
                      onChange={(e) =>
                        handleFormChange("decision_number", e.target.value)
                      }
                    />
                  </Col>

                  <Col md={12}>
                    <Form.Label>
                      <i className="fas fa-comment-alt text-primary me-1"></i>
                      Ghi Chú
                    </Form.Label>
                    <Form.Control
                      as="textarea"
                      rows={3}
                      placeholder="Nhập ghi chú..."
                      value={formData.notes}
                      onChange={(e) =>
                        handleFormChange("notes", e.target.value)
                      }
                    />
                  </Col>
                </Row>
              </Card.Body>
            </Card>
          </Col>

          {/* Documents */}
          <Col lg={4}>
            <Card className="health-info-card">
              <Card.Header className="documents-header">
                <i className="fas fa-file-alt"></i>
                <span>Tài liệu đính kèm</span>
              </Card.Header>
              <Card.Body>
                <FileUpload
                  label="Tải lên tài liệu"
                  accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                  maxSize={10 * 1024 * 1024}
                  onChange={handleAddDocument}
                  multiple
                />

                {formData.documents && formData.documents.length > 0 && (
                  <div className="mt-3">
                    <h6 className="mb-2">
                      Danh sách tài liệu ({formData.documents.length}):
                    </h6>
                    <div className="document-list">
                      {formData.documents.map((doc, index) => (
                        <div
                          key={index}
                          className="document-item d-flex align-items-center justify-content-between p-2 border rounded mb-2"
                        >
                          <div className="d-flex align-items-center flex-grow-1 me-2">
                            <i className="fas fa-file-pdf text-danger me-2"></i>
                            <div className="text-truncate">
                              <div
                                className="fw-medium text-truncate"
                                style={{ maxWidth: "180px" }}
                              >
                                {doc.name}
                              </div>
                              {doc.size && (
                                <small className="text-muted">
                                  {(doc.size / 1024).toFixed(2)} KB
                                </small>
                              )}
                            </div>
                          </div>
                          <div className="d-flex gap-1">
                            {doc.url && (
                              <>
                                <Button
                                  variant="outline-primary"
                                  size="sm"
                                  href={doc.url}
                                  target="_blank"
                                  title="Xem"
                                >
                                  <i className="fas fa-eye"></i>
                                </Button>
                                <Button
                                  variant="outline-success"
                                  size="sm"
                                  href={doc.url}
                                  download={doc.name}
                                  title="Tải xuống"
                                >
                                  <i className="fas fa-download"></i>
                                </Button>
                              </>
                            )}
                            <Button
                              variant="outline-danger"
                              size="sm"
                              onClick={() => handleRemoveDocument(index)}
                              title="Xóa"
                            >
                              <i className="fas fa-times"></i>
                            </Button>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </Card.Body>
            </Card>

            {/* Action Buttons */}
            <Card className="health-info-card mt-4">
              <Card.Header className="system-header">
                <i className="fas fa-check-circle"></i>
                <span>Thao tác</span>
              </Card.Header>
              <Card.Body>
                <div className="d-grid gap-2">
                  <Button
                    type="submit"
                    variant="primary"
                    size="lg"
                    disabled={submitting}
                  >
                    {submitting ? (
                      <>
                        <span className="spinner-border spinner-border-sm me-2"></span>
                        Đang lưu...
                      </>
                    ) : (
                      <>
                        <i className="fas fa-save me-2"></i>
                        {isEditMode ? "Cập nhật" : "Tạo mới"}
                      </>
                    )}
                  </Button>
                  <Button
                    type="button"
                    variant="secondary"
                    size="lg"
                    onClick={handleCancel}
                    disabled={submitting}
                  >
                    <i className="fas fa-times me-2"></i>
                    Hủy
                  </Button>
                </div>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Form>

      {/* Add Role Modal */}
      {showAddRoleModal && (
        <div
          className="modal show d-block"
          style={{ backgroundColor: "rgba(0,0,0,0.5)", zIndex: 1060 }}
        >
          <div className="modal-dialog modal-dialog-centered">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">
                  <i className="fas fa-plus-circle me-2"></i>
                  Thêm chức vụ mới
                </h5>
                <button
                  type="button"
                  className="btn-close"
                  onClick={() => setShowAddRoleModal(false)}
                ></button>
              </div>
              <div className="modal-body">
                <Form.Group className="mb-3">
                  <Form.Label>
                    Tên chức vụ <span className="text-danger">*</span>
                  </Form.Label>
                  <Form.Control
                    type="text"
                    placeholder="Ví dụ: Điều phối viên"
                    value={newRoleName}
                    onChange={(e) => setNewRoleName(e.target.value)}
                  />
                </Form.Group>
                <Form.Group className="mb-3">
                  <Form.Label>
                    Màu chức vụ <span className="text-danger">*</span>
                  </Form.Label>
                  <div className="d-flex flex-wrap gap-2">
                    {roleColors.map((color) => (
                      <div
                        key={color.value}
                        onClick={() => setNewRoleColor(color.value)}
                        style={{
                          width: "36px",
                          height: "36px",
                          backgroundColor: color.value,
                          borderRadius: "6px",
                          cursor: "pointer",
                          border:
                            newRoleColor === color.value
                              ? "3px solid #000"
                              : "2px solid #dee2e6",
                          display: "flex",
                          alignItems: "center",
                          justifyContent: "center",
                        }}
                        title={color.label}
                      >
                        {newRoleColor === color.value && (
                          <i className="fas fa-check text-white"></i>
                        )}
                      </div>
                    ))}
                  </div>
                  <div className="mt-2">
                    <small className="text-muted">Xem trước: </small>
                    <span
                      className="badge"
                      style={{
                        backgroundColor: newRoleColor,
                        color: "#fff",
                        padding: "0.5rem 1rem",
                        fontSize: "0.875rem",
                      }}
                    >
                      {newRoleName || "Tên chức vụ"}
                    </span>
                  </div>
                </Form.Group>
              </div>
              <div className="modal-footer">
                <Button
                  variant="secondary"
                  onClick={() => setShowAddRoleModal(false)}
                  disabled={addingRole}
                >
                  Hủy
                </Button>
                <Button
                  variant="primary"
                  onClick={handleAddRole}
                  disabled={addingRole || !newRoleName.trim()}
                >
                  {addingRole ? (
                    <>
                      <span className="spinner-border spinner-border-sm me-2"></span>
                      Đang thêm...
                    </>
                  ) : (
                    <>
                      <i className="fas fa-plus me-2"></i>
                      Thêm chức vụ
                    </>
                  )}
                </Button>
              </div>
            </div>
          </div>
        </div>
      )}
    </Container>
  );
};

export default AssignmentFormPage;
