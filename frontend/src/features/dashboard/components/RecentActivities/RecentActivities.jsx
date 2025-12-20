// src/features/dashboard/components/RecentActivities/RecentActivities.jsx

import React, { useState } from "react";
import {
  Card,
  ListGroup,
  Modal,
  Button,
  Badge,
  Spinner,
  Table,
} from "react-bootstrap";
import { formatRelativeTime } from "@utils";
import dashboardService from "@services/dashboardService";

const RecentActivities = ({ activities = [] }) => {
  const [showModal, setShowModal] = useState(false);
  const [selectedActivity, setSelectedActivity] = useState(null);
  const [loading, setLoading] = useState(false);

  // If no activities from props, show placeholder
  const displayActivities = activities.length > 0 ? activities : [];

  // Handle click on activity item
  const handleActivityClick = async (activity) => {
    setSelectedActivity(activity);
    setShowModal(true);

    // Optionally fetch more details with AI
    if (activity.id && !activity.changes?.length) {
      setLoading(true);
      try {
        const response = await dashboardService.getActivityDetail(
          activity.id,
          true
        );
        if (response.success && response.data) {
          setSelectedActivity(response.data);
        }
      } catch (error) {
        console.error("Error fetching activity detail:", error);
      } finally {
        setLoading(false);
      }
    }
  };

  // Format date for display
  const formatDate = (date) => {
    if (!date) return "N/A";
    return new Date(date).toLocaleString("vi-VN", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  // Get badge variant based on action type
  const getBadgeVariant = (type) => {
    const variants = {
      success: "success",
      primary: "primary",
      danger: "danger",
      warning: "warning",
      info: "info",
    };
    return variants[type] || "secondary";
  };

  return (
    <>
      <Card className="h-100">
        <Card.Header className="bg-white border-bottom">
          <h5 className="mb-0">
            <i className="fas fa-history me-2"></i>
            Hoạt động gần đây
          </h5>
        </Card.Header>
        <Card.Body className="p-0">
          {displayActivities.length === 0 ? (
            <div className="text-center py-5 text-muted">
              <i className="fas fa-clock fa-3x mb-3 opacity-50"></i>
              <p className="mb-0">Chưa có hoạt động nào</p>
            </div>
          ) : (
            <div style={{ maxHeight: "500px", overflowY: "auto" }}>
              <ListGroup variant="flush">
                {displayActivities.map((activity) => (
                  <ListGroup.Item
                    key={activity.id}
                    className="border-0 border-bottom activity-item"
                    action
                    onClick={() => handleActivityClick(activity)}
                    style={{ cursor: "pointer" }}
                  >
                    <div className="d-flex align-items-start">
                      <div
                        className={`activity-icon bg-${activity.type} bg-opacity-10 text-${activity.type} me-3`}
                        style={{
                          width: "40px",
                          height: "40px",
                          borderRadius: "10px",
                          display: "flex",
                          alignItems: "center",
                          justifyContent: "center",
                          flexShrink: 0,
                        }}
                      >
                        <i className={activity.icon}></i>
                      </div>
                      <div className="flex-grow-1">
                        <p className="mb-1 fw-medium">{activity.message}</p>
                        <div className="d-flex align-items-center gap-2">
                          <small className="text-muted">
                            <i className="fas fa-user me-1"></i>
                            {activity.user}
                          </small>
                          <small className="text-muted">•</small>
                          <small className="text-muted">
                            <i className="fas fa-clock me-1"></i>
                            {formatRelativeTime(new Date(activity.timestamp))}
                          </small>
                          {activity.tableTypeVi && (
                            <>
                              <small className="text-muted">•</small>
                              <Badge
                                bg={getBadgeVariant(activity.type)}
                                className="fw-normal"
                                style={{ fontSize: "0.7rem" }}
                              >
                                {activity.tableTypeVi}
                              </Badge>
                            </>
                          )}
                        </div>
                      </div>
                      <div className="ms-2 text-muted">
                        <i className="fas fa-chevron-right"></i>
                      </div>
                    </div>
                  </ListGroup.Item>
                ))}
              </ListGroup>
            </div>
          )}
        </Card.Body>
      </Card>

      {/* Activity Detail Modal */}
      <Modal
        show={showModal}
        onHide={() => setShowModal(false)}
        size="lg"
        centered
      >
        <Modal.Header closeButton className="bg-light">
          <Modal.Title>
            <i className="fas fa-info-circle me-2 text-primary"></i>
            Chi tiết hoạt động
          </Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {loading ? (
            <div className="text-center py-5">
              <Spinner animation="border" variant="primary" />
              <p className="mt-3 text-muted">Đang tải chi tiết...</p>
            </div>
          ) : selectedActivity ? (
            <div>
              {/* Activity Summary */}
              <div className="mb-4 p-3 bg-light rounded">
                <div className="d-flex align-items-center mb-3">
                  <div
                    className={`bg-${selectedActivity.type} bg-opacity-10 text-${selectedActivity.type} me-3`}
                    style={{
                      width: "50px",
                      height: "50px",
                      borderRadius: "12px",
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center",
                    }}
                  >
                    <i className={`${selectedActivity.icon} fa-lg`}></i>
                  </div>
                  <div>
                    <h5 className="mb-1">{selectedActivity.message}</h5>
                    <div className="text-muted small">
                      <span className="me-3">
                        <i className="fas fa-user me-1"></i>
                        {selectedActivity.user}
                      </span>
                      <span className="me-3">
                        <i className="fas fa-calendar me-1"></i>
                        {formatDate(selectedActivity.timestamp)}
                      </span>
                      {selectedActivity.tableTypeVi && (
                        <Badge bg={getBadgeVariant(selectedActivity.type)}>
                          {selectedActivity.tableTypeVi}
                        </Badge>
                      )}
                    </div>
                  </div>
                </div>

                {/* Action and Entity Info */}
                <div className="row mt-3">
                  <div className="col-md-6">
                    <small className="text-muted d-block mb-1">Hành động</small>
                    <span className="fw-medium">
                      {selectedActivity.actionVi || selectedActivity.action}
                    </span>
                  </div>
                  <div className="col-md-6">
                    <small className="text-muted d-block mb-1">Đối tượng</small>
                    <span className="fw-medium">
                      {selectedActivity.entityName ||
                        `ID: ${selectedActivity.recordId || "N/A"}`}
                    </span>
                  </div>
                </div>
              </div>

              {/* Changes Detail */}
              {selectedActivity.changes &&
              selectedActivity.changes.length > 0 ? (
                <div className="mb-3">
                  <h6 className="mb-3">
                    <i className="fas fa-exchange-alt me-2 text-primary"></i>
                    Chi tiết thay đổi
                  </h6>
                  <Table striped bordered hover size="sm" responsive>
                    <thead className="table-light">
                      <tr>
                        <th style={{ width: "30%" }}>Trường</th>
                        <th style={{ width: "35%" }}>Giá trị cũ</th>
                        <th style={{ width: "35%" }}>Giá trị mới</th>
                      </tr>
                    </thead>
                    <tbody>
                      {selectedActivity.changes.map((change, index) => (
                        <tr key={index}>
                          <td className="fw-medium">{change.fieldVi}</td>
                          <td>
                            {change.oldValueFormatted !== "trống" ? (
                              <span className="text-danger">
                                {change.oldValueFormatted}
                              </span>
                            ) : (
                              <span className="text-muted fst-italic">
                                (trống)
                              </span>
                            )}
                          </td>
                          <td>
                            {change.newValueFormatted !== "trống" ? (
                              <span className="text-success">
                                {change.newValueFormatted}
                              </span>
                            ) : (
                              <span className="text-muted fst-italic">
                                (trống)
                              </span>
                            )}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </Table>
                </div>
              ) : (
                <div className="text-center py-3 text-muted bg-light rounded">
                  <i className="fas fa-info-circle me-2"></i>
                  Không có chi tiết thay đổi cho hoạt động này
                </div>
              )}

              {/* Changes Description (Natural Language) */}
              {selectedActivity.changesDescription &&
                selectedActivity.changesDescription !==
                  "Không có chi tiết thay đổi" && (
                  <div className="mt-3 p-3 bg-info bg-opacity-10 rounded">
                    <h6 className="mb-2 text-info">
                      <i className="fas fa-comment-alt me-2"></i>
                      Mô tả
                    </h6>
                    <p className="mb-0">
                      {selectedActivity.changesDescription}
                    </p>
                  </div>
                )}
            </div>
          ) : (
            <div className="text-center py-5 text-muted">
              <i className="fas fa-exclamation-circle fa-3x mb-3"></i>
              <p>Không có dữ liệu</p>
            </div>
          )}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowModal(false)}>
            <i className="fas fa-times me-2"></i>
            Đóng
          </Button>
        </Modal.Footer>
      </Modal>

      <style>{`
        .activity-item:hover {
          background-color: rgba(0, 123, 255, 0.05);
        }
        .activity-item:hover .fa-chevron-right {
          color: var(--bs-primary) !important;
        }
      `}</style>
    </>
  );
};

export default RecentActivities;
