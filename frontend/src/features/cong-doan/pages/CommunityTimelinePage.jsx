// src/features/cong-doan/pages/CommunityTimelinePage.jsx
// Timeline theo cộng đoàn - hiển thị lịch sử bổ nhiệm, thay đổi trong cộng đoàn

import React, { useState, useEffect } from "react";
import { Container, Row, Col, Button } from "react-bootstrap";
import { useParams, useNavigate } from "react-router-dom";
import { communityService } from "@services";
import { formatDate, resolveMediaUrl } from "@utils";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import SearchableSelect from "@components/forms/SearchableSelect";
import "@components/common/Timeline/Timeline.css";

// Role configurations
const roleConfig = {
  superior: {
    label: "Bề trên",
    icon: "fas fa-crown",
    className: "level-doctorate",
  },
  assistant: {
    label: "Phó Bề trên",
    icon: "fas fa-user-tie",
    className: "level-masters",
  },
  councilor: {
    label: "Cố vấn",
    icon: "fas fa-users",
    className: "level-university",
  },
  treasurer: {
    label: "Thủ quỹ",
    icon: "fas fa-coins",
    className: "type-mission",
  },
  secretary: {
    label: "Thư ký",
    icon: "fas fa-pen",
    className: "type-education",
  },
  member: {
    label: "Thành viên",
    icon: "fas fa-user",
    className: "type-community",
  },
};

const getRoleConfig = (role) => {
  return (
    roleConfig[role] || {
      label: role || "Thành viên",
      icon: "fas fa-home",
      className: "type-community",
    }
  );
};

const formatCommunityLabel = (community) =>
  `${community.name || ""}${
    community.diocese ? ` (${community.diocese})` : ""
  }`;

const CommunityTimelinePage = () => {
  const { communityId } = useParams();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [community, setCommunity] = useState(null);
  const [assignments, setAssignments] = useState([]);
  const [communities, setCommunities] = useState([]);
  const [selectedCommunityId, setSelectedCommunityId] = useState(
    communityId || ""
  );

  useEffect(() => {
    const loadData = async () => {
      setLoading(true);
      try {
        await fetchCommunitiesList(false);
        if (communityId) {
          setSelectedCommunityId(communityId);
          await fetchCommunityData(communityId, false);
        }
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, [communityId]);

  const communityOptions = (communities || []).map((c) => ({
    value: c.id,
    label: formatCommunityLabel(c),
  }));

  const fetchCommunitiesList = async (withLoading = true) => {
    try {
      if (withLoading) {
        setLoading(true);
      }
      const res = await communityService.getList({ limit: 1000 });
      console.log("Communities response:", res);
      // API returns { data: [...], meta: {...} }
      if (res && res.data && Array.isArray(res.data)) {
        setCommunities(res.data);
      } else if (res && res.items) {
        setCommunities(res.items);
      } else if (res && Array.isArray(res)) {
        setCommunities(res);
      } else {
        setCommunities([]);
      }
    } catch (error) {
      console.error("Error fetching communities:", error);
    } finally {
      if (withLoading) {
        setLoading(false);
      }
    }
  };

  const fetchCommunityData = async (id, withLoading = true) => {
    try {
      if (withLoading) {
        setLoading(true);
      }

      // Get community detail
      const communityRes = await communityService.getDetail(id);
      if (communityRes) {
        setCommunity(communityRes.community || communityRes);
      }

      // Get assignment history
      const historyRes = await communityService.getAssignmentHistory(id);
      if (historyRes && historyRes.success) {
        const data = historyRes.data?.assignments || historyRes.data || [];
        // Sort by start_date descending
        const sorted = data.sort(
          (a, b) =>
            new Date(b.start_date || b.created_at) -
            new Date(a.start_date || a.created_at)
        );
        setAssignments(sorted);
        if (historyRes.data?.community) {
          setCommunity(historyRes.data.community);
        }
      }
    } catch (error) {
      console.error("Error fetching community data:", error);
    } finally {
      if (withLoading) {
        setLoading(false);
      }
    }
  };

  const handleSelectCommunity = (event) => {
    const id = event?.target?.value;
    setSelectedCommunityId(id);
    if (id) {
      fetchCommunityData(id);
    } else {
      setCommunity(null);
      setAssignments([]);
    }
  };

  const handleItemClick = (assignment) => {
    // Navigate to assignment detail page
    navigate(
      `/cong-doan/assignments/${assignment.community_id}-${assignment.id}`
    );
  };

  const calculateStats = () => {
    const total = assignments.length;
    const currentMembers = assignments.filter(
      (a) => !a.end_date || new Date(a.end_date) >= new Date()
    ).length;
    const leadershipCount = assignments.filter((a) =>
      ["superior", "assistant", "councilor"].includes(a.role)
    ).length;
    const uniqueSisters = new Set(assignments.map((a) => a.sister_id)).size;

    return [
      {
        icon: "fas fa-history",
        label: "Tổng bổ nhiệm",
        value: total,
        gradient: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
      },
      {
        icon: "fas fa-users",
        label: "Thành viên hiện tại",
        value: currentMembers,
        gradient: "linear-gradient(135deg, #56ab2f 0%, #a8e063 100%)",
      },
      {
        icon: "fas fa-crown",
        label: "Bổ nhiệm lãnh đạo",
        value: leadershipCount,
        gradient: "linear-gradient(135deg, #f39c12 0%, #e67e22 100%)",
      },
      {
        icon: "fas fa-user-friends",
        label: "Nữ tu đã qua",
        value: uniqueSisters,
        gradient: "linear-gradient(135deg, #2ad7c5 0%, #20c997 100%)",
      },
    ];
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

  // If no communityId, show community selection interface
  if (!communityId && !selectedCommunityId) {
    return (
      <div className="timeline-page">
        <Container className="mt-4">
          <div className="select-sister-card">
            <h4 className="text-center mb-4">
              <i className="fas fa-home me-2"></i>
              Timeline Cộng Đoàn
            </h4>
            <p className="text-center text-muted mb-4">
              Xem lịch sử bổ nhiệm và thay đổi trong cộng đoàn
            </p>
            <div className="mb-3">
              <SearchableSelect
                name="community_id"
                value={selectedCommunityId}
                onChange={handleSelectCommunity}
                options={communityOptions}
                placeholder="Nhập tên cộng đoàn để tìm hoặc click để chọn..."
                maxDisplayItems={8}
              />
            </div>
            <div className="text-center mt-4">
              <Button
                variant="secondary"
                onClick={() => navigate("/cong-doan")}
              >
                <i className="fas fa-arrow-left me-2"></i>
                Quay lại
              </Button>
            </div>
          </div>
        </Container>
      </div>
    );
  }

  const stats = calculateStats();

  return (
    <div className="timeline-page">
      <Container className="mt-4">
        {/* Community Info Card */}
        {community && (
          <div className="sister-info">
            <Row className="align-items-center">
              <Col md={3} className="text-center">
                <div className="sister-avatar">
                  <i className="fas fa-church"></i>
                </div>
              </Col>
              <Col md={9}>
                <h2 className="mb-3">{community.name}</h2>
                <div className="mb-3">
                  {community.address && (
                    <span className="info-badge">
                      <i className="fas fa-map-marker-alt"></i>
                      {community.address}
                    </span>
                  )}
                  {community.diocese && (
                    <span className="info-badge">
                      <i className="fas fa-church"></i>
                      Giáo phận: {community.diocese}
                    </span>
                  )}
                  {community.established_date && (
                    <span className="info-badge">
                      <i className="fas fa-calendar"></i>
                      Thành lập: {formatDate(community.established_date)}
                    </span>
                  )}
                </div>
              </Col>
            </Row>
          </div>
        )}

        {/* Stats Cards */}
        {stats.length > 0 && (
          <Row className="mb-5">
            {stats.map((stat, index) => (
              <Col md={3} className="mb-3" key={index}>
                <div className="stats-card">
                  <div
                    className="stats-icon"
                    style={{ background: stat.gradient }}
                  >
                    <i className={stat.icon}></i>
                  </div>
                  <div className="stats-value">{stat.value}</div>
                  <div className="stats-label">{stat.label}</div>
                </div>
              </Col>
            ))}
          </Row>
        )}

        {/* Timeline */}
        {assignments.length > 0 ? (
          <div className="timeline">
            {assignments.map((item, index) => {
              const config = getRoleConfig(item.role);
              const isCurrent =
                !item.end_date || new Date(item.end_date) >= new Date();
              return (
                <div
                  key={item.id || index}
                  className={`timeline-item ${config.className} clickable`}
                  onClick={() => handleItemClick(item)}
                  style={{ cursor: "pointer" }}
                >
                  <div className={`timeline-icon ${config.className}`}>
                    <i className={config.icon}></i>
                  </div>
                  <div className="timeline-content">
                    <div className="timeline-date">
                      <i className="fas fa-calendar"></i>
                      {formatDate(item.start_date)}
                      {item.end_date
                        ? ` - ${formatDate(item.end_date)}`
                        : " - Hiện tại"}
                    </div>
                    <h3 className="timeline-title">
                      {item.saint_name ||
                        item.birth_name ||
                        `Nữ tu #${item.sister_id}`}
                    </h3>
                    <span className={`timeline-stage ${config.className}`}>
                      {config.label}
                    </span>

                    {item.decision_number && (
                      <div className="timeline-info">
                        <i className="fas fa-file-alt"></i>
                        Quyết định: {item.decision_number}
                      </div>
                    )}

                    {item.notes && (
                      <p className="timeline-description mt-2">{item.notes}</p>
                    )}

                    {isCurrent && (
                      <div className="mt-2">
                        <span className="badge bg-success">
                          <i className="fas fa-check me-1"></i>
                          Hiện tại
                        </span>
                      </div>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        ) : (
          <div className="empty-timeline">
            <i className="fas fa-home"></i>
            <h4>Chưa có lịch sử bổ nhiệm</h4>
            <p>Cộng đoàn này chưa có thông tin bổ nhiệm nào được ghi nhận.</p>
          </div>
        )}

        {/* Back button and Community select */}
        <div className="d-flex justify-content-between align-items-center mt-4 mb-4">
          <Button
            variant="secondary"
            onClick={() =>
              communityId
                ? navigate(`/cong-doan/${communityId}`)
                : navigate("/cong-doan")
            }
          >
            <i className="fas fa-arrow-left me-2"></i>
            Quay lại
          </Button>

          <div style={{ width: "350px" }}>
            <SearchableSelect
              name="community_id"
              value={selectedCommunityId}
              onChange={handleSelectCommunity}
              options={communityOptions}
              placeholder="Chọn cộng đoàn khác..."
              maxDisplayItems={8}
            />
          </div>
        </div>
      </Container>
    </div>
  );
};

export default CommunityTimelinePage;
