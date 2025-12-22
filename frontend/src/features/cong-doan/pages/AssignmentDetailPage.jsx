// src/features/cong-doan/pages/AssignmentDetailPage.jsx

import React, { useState, useEffect } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Button,
  Badge,
  ListGroup,
} from "react-bootstrap";
import { useParams, useNavigate } from "react-router-dom";
import { communityService, sisterService } from "@services";
import { formatDate, calculateDuration } from "@utils";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "./AssignmentPage.css";

// Role config
const roleConfig = {
  superior: { label: "Bề trên", icon: "fa-crown", className: "role-leader" },
  leader: { label: "Bề trên", icon: "fa-crown", className: "role-leader" },
  assistant: {
    label: "Phó bề trên",
    icon: "fa-user-tie",
    className: "role-vice-leader",
  },
  vice_superior: {
    label: "Phó bề trên",
    icon: "fa-user-tie",
    className: "role-vice-leader",
  },
  vice_leader: {
    label: "Phó bề trên",
    icon: "fa-user-tie",
    className: "role-vice-leader",
  },
  deputy: {
    label: "Phó bề trên",
    icon: "fa-user-tie",
    className: "role-vice-leader",
  },
  secretary: {
    label: "Thư ký",
    icon: "fa-file-alt",
    className: "role-secretary",
  },
  treasurer: {
    label: "Thủ quỹ",
    icon: "fa-coins",
    className: "role-treasurer",
  },
};

// Stage labels
const stageLabels = {
  inquiry: "Tìm hiểu",
  postulant: "Thỉnh sinh",
  aspirant: "Tiền tập",
  novice: "Tập viện",
  temporary_vows: "Khấn tạm",
  perpetual_vows: "Khấn trọn",
};

const AssignmentDetailPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [assignment, setAssignment] = useState(null);
  const [sister, setSister] = useState(null);
  const [community, setCommunity] = useState(null);

  useEffect(() => {
    fetchAssignmentDetail();
  }, [id]);

  const fetchAssignmentDetail = async () => {
    try {
      setLoading(true);

      // Parse id to get community_id and assignment_id
      const parts = id.split("-");
      let communityId, assignmentId;

      console.log("Fetching assignment with id:", id);
      console.log("Parts:", parts);

      if (parts.length === 2) {
        communityId = parseInt(parts[0]);
        assignmentId = parseInt(parts[1]);
        console.log(
          "Parsed communityId:",
          communityId,
          "assignmentId:",
          assignmentId
        );
      } else {
        assignmentId = parseInt(id);
        console.log("Single ID mode, assignmentId:", assignmentId);
        // Need to find community_id from assignments
        const allCommunities = await communityService.getList({ limit: 100 });
        for (const comm of allCommunities.data) {
          const response = await communityService.getAssignmentHistory(comm.id);
          const assignments = response?.data?.assignments || [];
          const found = assignments.find((a) => a.id === assignmentId);
          if (found) {
            communityId = comm.id;
            setAssignment({ ...found, community_id: communityId });
            setCommunity(comm);

            // Fetch sister info
            if (found.sister_id) {
              const sisterRes = await sisterService.getById(found.sister_id);
              if (sisterRes?.data) {
                setSister(sisterRes.data);
              }
            }
            setLoading(false);
            return;
          }
        }
        console.log("Assignment not found in any community");
        setLoading(false);
        return;
      }

      // Fetch assignment history (includes community info)
      const response = await communityService.getAssignmentHistory(communityId);
      const assignments = response?.data?.assignments || [];
      const foundAssignment = assignments.find((a) => a.id === assignmentId);

      if (foundAssignment) {
        setAssignment({ ...foundAssignment, community_id: communityId });

        // Set community from assignment history response
        if (response?.data?.community) {
          setCommunity(response.data.community);
        }

        // Fetch sister info
        if (foundAssignment.sister_id) {
          const sisterRes = await sisterService.getById(
            foundAssignment.sister_id
          );
          if (sisterRes?.data) {
            setSister(sisterRes.data);
          }
        }
      }
    } catch (error) {
      console.error("Error fetching assignment detail:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleEdit = () => {
    navigate(`/cong-doan/assignments/${id}/edit`);
  };

  const handleDelete = async () => {
    if (window.confirm("Bạn có chắc chắn muốn xóa bổ nhiệm này?")) {
      try {
        await communityService.removeMember(
          assignment.community_id,
          assignment.id
        );
        navigate("/cong-doan/assignments");
      } catch (error) {
        console.error("Error deleting assignment:", error);
      }
    }
  };

  const handleViewSister = () => {
    if (sister?.id) {
      navigate(`/nu-tu/${sister.id}`);
    }
  };

  const handleViewCommunity = () => {
    if (community?.id) {
      navigate(`/cong-doan/${community.id}`);
    }
  };

  const getRoleConfig = (role) => {
    return roleConfig[role] || { label: role, icon: "fa-user", className: "" };
  };

  const getRoleBadgeColor = (roleCode) => {
    const colors = {
      leader: "#d63031",
      superior: "#d63031",
      vice_leader: "#2d3436",
      vice_superior: "#2d3436",
      deputy: "#2d3436",
      assistant: "#2d3436",
      secretary: "#6c5ce7",
      treasurer: "#e84393",
      member: "#0984e3",
    };
    return colors[roleCode] || "#6c757d";
  };

  const getAssignmentStatus = () => {
    if (!assignment?.end_date)
      return { label: "Đang hoạt động", className: "status-active" };
    const endDate = new Date(assignment.end_date);
    const today = new Date();
    if (endDate > today)
      return { label: "Đang hoạt động", className: "status-active" };
    return { label: "Đã kết thúc", className: "status-completed" };
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

  if (!assignment) {
    return (
      <Container className="py-4">
        <div className="text-center">
          <h3>Không tìm thấy thông tin bổ nhiệm</h3>
          <Button
            variant="primary"
            onClick={() => navigate("/cong-doan/assignments")}
          >
            Quay lại danh sách
          </Button>
        </div>
      </Container>
    );
  }

  const roleInfo = getRoleConfig(assignment.role);
  const statusInfo = getAssignmentStatus();
  const duration = calculateDuration(
    assignment.start_date,
    assignment.end_date
  );

  return (
    <Container fluid className="py-4">
      {/* Breadcrumb */}
      <Breadcrumb
        title="Chi tiết Bổ Nhiệm"
        items={[
          { label: "Quản lý Cộng Đoàn", link: "/cong-doan" },
          { label: "Quản lý Bổ Nhiệm", link: "/cong-doan/assignments" },
          { label: "Chi tiết" },
        ]}
      />

      {/* Header Actions */}
      <div className="d-flex justify-content-end align-items-center mb-4">
        <div className="d-flex gap-2">
          <Button variant="success" onClick={handleEdit}>
            <i className="fas fa-edit me-2"></i>
            Chỉnh sửa
          </Button>
          <Button variant="danger" onClick={handleDelete}>
            <i className="fas fa-trash me-2"></i>
            Xóa
          </Button>
          <Button
            variant="secondary"
            onClick={() => navigate("/cong-doan/assignments")}
          >
            <i className="fas fa-arrow-left me-2"></i>
            Quay lại
          </Button>
        </div>
      </div>

      <Row className="g-4">
        {/* Left Column - Assignment Info */}
        <Col lg={8}>
          <Card className="health-info-card mb-4">
            <Card.Header>
              <i className="fas fa-briefcase"></i>
              <span>Thông tin Bổ Nhiệm</span>
            </Card.Header>
            <Card.Body>
              <Row className="g-4">
                {/* Role Badge */}
                <Col xs={12}>
                  <div className="stage-badge-large">
                    <Badge
                      style={{
                        backgroundColor: getRoleBadgeColor(assignment.role),
                      }}
                      className="p-3 fs-6"
                    >
                      <i className={`fas ${roleInfo.icon} me-2`}></i>
                      {roleInfo.label}
                    </Badge>
                    <Badge
                      bg={
                        statusInfo.className === "status-active"
                          ? "success"
                          : "secondary"
                      }
                      className="p-3 fs-6 ms-2"
                    >
                      {statusInfo.label}
                    </Badge>
                  </div>
                </Col>

                {/* Community */}
                <Col md={6}>
                  <InfoItem
                    icon="fas fa-home"
                    iconColor="success"
                    label="Cộng đoàn"
                    value={community?.name || assignment.community_name || "—"}
                  />
                </Col>

                {/* Decision Number */}
                <Col md={6}>
                  <InfoItem
                    icon="fas fa-file-signature"
                    iconColor="info"
                    label="Số quyết định"
                    value={assignment.decision_number || "—"}
                  />
                </Col>

                {/* Start Date */}
                <Col md={6}>
                  <InfoItem
                    icon="fas fa-calendar-alt"
                    iconColor="primary"
                    label="Ngày bắt đầu"
                    value={formatDate(
                      assignment.start_date || assignment.joined_date
                    )}
                  />
                </Col>

                {/* End Date */}
                <Col md={6}>
                  <InfoItem
                    icon="fas fa-calendar-check"
                    iconColor="warning"
                    label="Ngày kết thúc"
                    value={
                      assignment.end_date
                        ? formatDate(assignment.end_date)
                        : "—"
                    }
                  />
                </Col>

                {/* Duration */}
                <Col md={6}>
                  <InfoItem
                    icon="fas fa-clock"
                    iconColor="secondary"
                    label="Thời gian"
                    value={duration}
                  />
                </Col>

                {/* Notes */}
                {assignment.notes && (
                  <Col xs={12}>
                    <div className="notes-section">
                      <h6 className="mb-2">
                        <i className="fas fa-sticky-note text-warning me-2"></i>
                        Ghi chú
                      </h6>
                      <div className="notes-content">{assignment.notes}</div>
                    </div>
                  </Col>
                )}
              </Row>
            </Card.Body>
          </Card>

          {/* Documents */}
          <Card className="health-info-card">
            <Card.Header className="documents-header">
              <i className="fas fa-file-alt"></i>
              <span>
                Tài liệu đính kèm
                {assignment.documents &&
                  assignment.documents.length > 0 &&
                  ` (${assignment.documents.length})`}
              </span>
            </Card.Header>
            <Card.Body>
              {assignment.documents && assignment.documents.length > 0 ? (
                <ListGroup variant="flush">
                  {assignment.documents.map((doc, index) => (
                    <ListGroup.Item key={index} className="px-0">
                      <div className="d-flex justify-content-between align-items-center">
                        <div className="d-flex align-items-center">
                          <i className="fas fa-file-pdf text-danger me-3 fs-4"></i>
                          <div>
                            <div className="fw-semibold">{doc.name}</div>
                            <small className="text-muted">
                              {doc.size && `${(doc.size / 1024).toFixed(2)} KB`}
                              {doc.uploaded_at &&
                                ` • ${formatDate(doc.uploaded_at)}`}
                            </small>
                          </div>
                        </div>
                        <div className="d-flex gap-2">
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
                        </div>
                      </div>
                    </ListGroup.Item>
                  ))}
                </ListGroup>
              ) : assignment.decision_file_url ? (
                <ListGroup variant="flush">
                  <ListGroup.Item className="px-0">
                    <div className="d-flex justify-content-between align-items-center">
                      <div className="d-flex align-items-center">
                        <i className="fas fa-file-pdf text-danger me-3 fs-4"></i>
                        <div>
                          <div className="fw-semibold">Quyết định bổ nhiệm</div>
                          <small className="text-muted">File đính kèm</small>
                        </div>
                      </div>
                      <div className="d-flex gap-2">
                        <Button
                          variant="outline-primary"
                          size="sm"
                          href={`${
                            import.meta.env.VITE_API_URL ||
                            "http://localhost:5000"
                          }${assignment.decision_file_url}`}
                          target="_blank"
                          title="Xem"
                        >
                          <i className="fas fa-eye"></i>
                        </Button>
                        <Button
                          variant="outline-success"
                          size="sm"
                          href={`${
                            import.meta.env.VITE_API_URL ||
                            "http://localhost:5000"
                          }${assignment.decision_file_url}`}
                          download
                          title="Tải xuống"
                        >
                          <i className="fas fa-download"></i>
                        </Button>
                      </div>
                    </div>
                  </ListGroup.Item>
                </ListGroup>
              ) : (
                <div className="text-center text-muted py-4">
                  <i className="fas fa-folder-open fa-3x mb-3 opacity-50"></i>
                  <p className="mb-0">Chưa có tài liệu đính kèm</p>
                </div>
              )}
            </Card.Body>
          </Card>
        </Col>

        {/* Right Column - Sister Info */}
        <Col lg={4}>
          <Card className="health-info-card mb-4">
            <Card.Header>
              <i className="fas fa-user"></i>
              <span>Thông tin Nữ Tu</span>
            </Card.Header>
            <Card.Body>
              <div className="text-center mb-3">
                <div className="sister-avatar-medium mx-auto mb-3">
                  {sister?.avatar_url ? (
                    <img src={sister.avatar_url} alt={sister.birth_name} />
                  ) : (
                    <div className="avatar-placeholder">
                      <i className="fas fa-user"></i>
                    </div>
                  )}
                </div>
                {sister?.saint_name && (
                  <h5 className="text-primary mb-1">{sister.saint_name}</h5>
                )}
                <h6 className="mb-1">{sister?.birth_name || "—"}</h6>
                <p className="text-muted mb-0">{sister?.code || ""}</p>
              </div>

              <div className="sister-info-list">
                <div className="info-row">
                  <i className="fas fa-route text-info"></i>
                  <div>
                    <small className="text-muted">Giai đoạn</small>
                    <div>
                      {stageLabels[sister?.current_stage] || "Chưa xác định"}
                    </div>
                  </div>
                </div>

                <div className="info-row">
                  <i className="fas fa-birthday-cake text-primary"></i>
                  <div>
                    <small className="text-muted">Ngày sinh</small>
                    <div>
                      {sister?.date_of_birth
                        ? formatDate(sister.date_of_birth)
                        : "—"}
                    </div>
                  </div>
                </div>

                <div className="info-row">
                  <i className="fas fa-phone text-success"></i>
                  <div>
                    <small className="text-muted">Điện thoại</small>
                    <div>{sister?.phone || "—"}</div>
                  </div>
                </div>

                <div className="info-row">
                  <i className="fas fa-envelope text-warning"></i>
                  <div>
                    <small className="text-muted">Email</small>
                    <div>{sister?.email || "—"}</div>
                  </div>
                </div>
              </div>

              {sister?.id && (
                <Button
                  variant="primary"
                  className="w-100 mt-3"
                  onClick={handleViewSister}
                >
                  <i className="fas fa-user me-2"></i>
                  Xem hồ sơ đầy đủ
                </Button>
              )}
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

// Helper Component
const InfoItem = ({ icon, iconColor, label, value }) => (
  <div className="info-item-box">
    <div className={`info-icon bg-${iconColor} bg-opacity-10`}>
      <i className={`${icon} text-${iconColor}`}></i>
    </div>
    <div className="info-content">
      <small className="text-muted d-block mb-1">{label}</small>
      <div className="fw-semibold">{value}</div>
    </div>
  </div>
);

export default AssignmentDetailPage;
