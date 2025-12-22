import React, { useState, useEffect } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Button,
  Form,
  Badge,
  Spinner,
} from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import { communityService, sisterService, lookupService } from "@services";
import { formatDate } from "@utils";
import Breadcrumb from "@components/common/Breadcrumb";
import DataTable from "@components/tables/DataTable";
import "./AssignmentPage.css";

// Role labels and styles - Default roles (Leadership positions only)
const defaultRoles = [
  { code: "superior", name: "Bề trên", color: "#d63031" },
  { code: "assistant", name: "Phó bề trên", color: "#2d3436" },
  { code: "secretary", name: "Thư ký", color: "#6c5ce7" },
  { code: "treasurer", name: "Thủ quỹ", color: "#e84393" },
];

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

// Status labels and styles
const statusConfig = {
  active: {
    label: "Đang hoạt động",
    icon: "fa-check-circle",
    className: "status-active",
  },
  pending: {
    label: "Chờ xử lý",
    icon: "fa-clock",
    className: "status-pending",
  },
  completed: {
    label: "Đã hoàn thành",
    icon: "fa-check-double",
    className: "status-completed",
  },
  cancelled: {
    label: "Đã hủy",
    icon: "fa-times-circle",
    className: "status-cancelled",
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

const AssignmentPage = () => {
  const navigate = useNavigate();

  // State
  const [loading, setLoading] = useState(true);
  const [communities, setCommunities] = useState([]);
  const [sisters, setSisters] = useState([]);
  const [assignments, setAssignments] = useState([]);
  const [allAssignmentsData, setAllAssignmentsData] = useState([]); // Store unfiltered data
  const [searchTerm, setSearchTerm] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize] = useState(10);

  // Roles management
  const [roles, setRoles] = useState(defaultRoles);
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

  // Filters
  const [filters, setFilters] = useState({
    community_id: "",
    role: "",
    status: "",
  });

  // Stats
  const [stats, setStats] = useState({
    total: 0,
    active: 0,
    completed: 0,
  });

  // Fetch initial data
  useEffect(() => {
    fetchInitialData();
  }, []);

  // Apply filters when filters or allAssignmentsData change (client-side filtering)
  useEffect(() => {
    if (allAssignmentsData.length === 0) {
      setAssignments([]);
      return;
    }

    let filtered = allAssignmentsData;

    if (filters.community_id) {
      const communityId = parseInt(filters.community_id);
      filtered = filtered.filter((a) => a.community_id === communityId);
    }

    if (filters.role) {
      filtered = filtered.filter((a) => a.role === filters.role);
    }

    if (filters.status) {
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      if (filters.status === "active") {
        filtered = filtered.filter(
          (a) => !a.end_date || new Date(a.end_date) >= today
        );
      } else if (filters.status === "completed") {
        filtered = filtered.filter(
          (a) => a.end_date && new Date(a.end_date) < today
        );
      }
    }

    setAssignments(filtered);
    setCurrentPage(1); // Reset to page 1 when filters change
  }, [filters.community_id, filters.role, filters.status, allAssignmentsData]);

  const fetchInitialData = async () => {
    try {
      setLoading(true);
      const [communitiesRes, sistersRes] = await Promise.all([
        communityService.getList({ limit: 100 }),
        sisterService.getList({ limit: 1000 }),
      ]);

      let loadedCommunities = [];
      let loadedSisters = [];

      if (communitiesRes?.data) {
        loadedCommunities = communitiesRes.data.filter(
          (c, index, self) => index === self.findIndex((t) => t.id === c.id)
        );
        setCommunities(loadedCommunities);
      }
      if (sistersRes?.data) {
        loadedSisters = sistersRes.data.filter(
          (s, index, self) => index === self.findIndex((t) => t.id === s.id)
        );
        setSisters(loadedSisters);
      }

      // Fetch community roles
      await fetchCommunityRoles();

      // Fetch assignments after loading communities
      if (loadedCommunities.length > 0) {
        await fetchAssignmentsFromAPI(loadedCommunities);
      }
    } catch (err) {
      console.error("Error fetching initial data:", err);
      toast.error("Không thể tải dữ liệu");
    } finally {
      setLoading(false);
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
      // Use default roles if API fails
      setRoles(defaultRoles);
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

  const handleDeleteRole = async (roleCode) => {
    const role = roles.find((r) => r.code === roleCode);
    if (!role) return;

    // Check if any assignments exist with this role
    const assignmentsWithRole = allAssignmentsData.filter(
      (a) => a.role === roleCode
    );
    if (assignmentsWithRole.length > 0) {
      toast.warning(
        `Không thể xóa chức vụ "${role.name}" vì đã có ${assignmentsWithRole.length} nữ tu được bổ nhiệm`
      );
      return;
    }

    if (!window.confirm(`Bạn có chắc chắn muốn xóa chức vụ "${role.name}"?`)) {
      return;
    }

    try {
      const response = await lookupService.deleteCommunityRole(role.id);
      if (response && response.success) {
        await fetchCommunityRoles();
        toast.success("Đã xóa chức vụ thành công!");
      }
    } catch (error) {
      console.error("Error deleting role:", error);
      toast.error("Không thể xóa chức vụ");
    }
  };

  // Fetch assignments from API (no filtering here)
  const fetchAssignmentsFromAPI = async (communitiesToUse) => {
    const comms = communitiesToUse || communities;

    if (!comms || comms.length === 0) {
      console.log("Communities not loaded yet");
      return;
    }

    try {
      setLoading(true);

      const allAssignments = [];
      for (const community of comms) {
        try {
          // Use getAssignmentHistory to fetch from community_assignments table
          // This returns leadership role assignments, not regular members
          const response = await communityService.getAssignmentHistory(
            community.id
          );
          const assignments =
            response?.data?.assignments ||
            response?.assignments ||
            (Array.isArray(response?.data) ? response.data : []);
          if (assignments && Array.isArray(assignments)) {
            assignments.forEach((a) => {
              allAssignments.push({
                ...a,
                community_id: community.id,
                community_name:
                  response?.data?.community?.name || community.name,
              });
            });
          }
        } catch (err) {
          console.error(
            `Error fetching assignments for community ${community.id}:`,
            err
          );
        }
      }

      console.log("All assignments fetched:", allAssignments.length);

      // Store all data (unfiltered)
      setAllAssignmentsData(allAssignments);

      // Calculate stats from all data
      const today = new Date();
      const activeCount = allAssignments.filter(
        (a) => !a.end_date || new Date(a.end_date) > today
      ).length;
      const completedCount = allAssignments.filter(
        (a) => a.end_date && new Date(a.end_date) <= today
      ).length;

      setStats({
        total: allAssignments.length,
        active: activeCount,
        completed: completedCount,
      });
    } catch (err) {
      console.error("Error fetching assignments:", err);
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (field, value) => {
    setFilters((prev) => ({ ...prev, [field]: value }));
  };

  const resetFilters = () => {
    setFilters({ community_id: "", role: "", status: "" });
    setSearchTerm("");
    setCurrentPage(1);
  };

  const handleOpenAddModal = () => {
    navigate("/cong-doan/assignments/create");
  };

  const handleOpenEditModal = (assignment) => {
    const assignmentId = `${assignment.community_id}-${assignment.id}`;
    navigate(`/cong-doan/assignments/${assignmentId}/edit`);
  };

  const handleViewAssignment = (assignment) => {
    const assignmentId = `${assignment.community_id}-${assignment.id}`;
    navigate(`/cong-doan/assignments/${assignmentId}`);
  };

  const handleDelete = async (assignment) => {
    if (!window.confirm("Bạn có chắc chắn muốn xóa bổ nhiệm này?")) {
      return;
    }

    try {
      await communityService.removeMember(
        assignment.community_id,
        assignment.id
      );
      toast.success("Đã xóa bổ nhiệm thành công");
      fetchAssignmentsFromAPI();
    } catch (err) {
      console.error("Error deleting assignment:", err);
      toast.error("Không thể xóa bổ nhiệm");
    }
  };

  const getRoleConfig = (role) => {
    return roleConfig[role] || roleConfig.superior;
  };

  const getAssignmentStatus = (assignment) => {
    if (!assignment.end_date) return statusConfig.active;
    const endDate = new Date(assignment.end_date);
    const today = new Date();
    if (endDate > today) return statusConfig.active;
    return statusConfig.completed;
  };

  const getSisterById = (id) => {
    return sisters.find((s) => s.id === id);
  };

  const getCommunityById = (id) => {
    return communities.find((c) => c.id === id);
  };

  // Get filtered assignments based on search
  const getFilteredAssignments = () => {
    if (!searchTerm) return assignments;
    const searchLower = searchTerm.toLowerCase();
    return assignments.filter((a) => {
      const sister = sisters.find((s) => s.id === a.sister_id) || a;
      const name = sister.saint_name
        ? `${sister.saint_name} ${sister.birth_name}`
        : sister.birth_name || sister.full_name || "";
      const community = getCommunityById(a.community_id) || {
        name: a.community_name,
      };
      return (
        name.toLowerCase().includes(searchLower) ||
        (community?.name || "").toLowerCase().includes(searchLower)
      );
    });
  };

  const filteredAssignments = getFilteredAssignments();

  // Pagination calculations
  const totalPages = Math.ceil(filteredAssignments.length / pageSize);
  const startIndex = (currentPage - 1) * pageSize;
  const endIndex = startIndex + pageSize;
  const paginatedAssignments = filteredAssignments.slice(startIndex, endIndex);

  // DataTable columns
  const getRoleBadgeColor = (roleCode) => {
    // First try to find from roles state
    const role = roles.find((r) => r.code === roleCode);
    if (role && role.color) {
      return role.color;
    }
    // Fallback to hardcoded colors
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

  // Get role label from roles state
  const getRoleLabel = (roleCode) => {
    const role = roles.find((r) => r.code === roleCode);
    if (role) return role.name;
    // Fallback to roleConfig
    const config = roleConfig[roleCode];
    return config ? config.label : roleCode;
  };

  // DataTable columns
  const columns = [
    {
      key: "index",
      label: "#",
      align: "center",
      render: (row, index) => (
        <div className="text-center">{startIndex + index + 1}</div>
      ),
    },
    {
      key: "sister_name",
      label: "Nữ Tu",
      sortable: true,
      render: (row) => {
        const sister = getSisterById(row.sister_id) || row;
        return (
          <div className="text-primary fw-semibold">
            {[sister.saint_name, sister.birth_name || row.birth_name]
              .filter(Boolean)
              .join(" ") || "N/A"}
          </div>
        );
      },
    },
    {
      key: "community_name",
      label: "Cộng Đoàn",
      sortable: true,
      render: (row) => {
        const community = getCommunityById(row.community_id) || {
          name: row.community_name,
        };
        return community?.name || "N/A";
      },
    },
    {
      key: "role",
      label: "Chức Vụ",
      sortable: true,
      render: (row) => {
        return (
          <Badge
            style={{
              backgroundColor: getRoleBadgeColor(row.role),
              color: "#fff",
              fontSize: "0.75rem",
              fontWeight: 500,
            }}
          >
            {getRoleLabel(row.role)}
          </Badge>
        );
      },
    },
    {
      key: "start_date",
      label: "Ngày Bắt Đầu",
      sortable: true,
      render: (row) => formatDate(row.start_date || row.joined_date),
    },
    {
      key: "end_date",
      label: "Ngày Kết Thúc",
      sortable: true,
      render: (row) => (row.end_date ? formatDate(row.end_date) : "—"),
    },
    {
      key: "status",
      label: "Trạng Thái",
      render: (row) => {
        const statusInfo = getAssignmentStatus(row);
        return (
          <Badge
            bg={
              statusInfo.className === "status-active" ? "success" : "secondary"
            }
          >
            {statusInfo.label}
          </Badge>
        );
      },
    },
    {
      key: "actions",
      label: "Thao Tác",
      align: "center",
      className: "action-column",
      render: (row) => (
        <div className="d-flex justify-content-center">
          <Button
            variant="outline-info"
            size="sm"
            className="me-1"
            title="Xem chi tiết"
            onClick={(e) => {
              e.stopPropagation();
              handleViewAssignment(row);
            }}
          >
            <i className="fas fa-eye"></i>
          </Button>
          <Button
            variant="outline-primary"
            size="sm"
            className="me-1"
            title="Chỉnh sửa"
            onClick={(e) => {
              e.stopPropagation();
              handleOpenEditModal(row);
            }}
          >
            <i className="fas fa-edit"></i>
          </Button>
          <Button
            variant="outline-danger"
            size="sm"
            title="Xóa"
            onClick={(e) => {
              e.stopPropagation();
              handleDelete(row);
            }}
          >
            <i className="fas fa-trash"></i>
          </Button>
        </div>
      ),
    },
  ];

  if (loading && assignments.length === 0 && communities.length === 0) {
    return (
      <div
        className="d-flex justify-content-center align-items-center"
        style={{ minHeight: "60vh" }}
      >
        <Spinner animation="border" variant="primary" />
      </div>
    );
  }

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  return (
    <Container fluid className="py-4">
      {/* Breadcrumb */}
      <Breadcrumb
        title="Quản Lý Bổ Nhiệm"
        items={[
          { label: "Quản lý Cộng Đoàn", link: "/cong-doan" },
          { label: "Quản lý Bổ Nhiệm" },
        ]}
      />

      {/* Statistics Cards */}
      <Row className="g-3 mb-4">
        <Col xs={6} md={3}>
          <Card className="stat-card">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Tổng số</small>
                  <h4 className="mb-0">{stats.total}</h4>
                </div>
                <div className="stat-icon bg-primary">
                  <i className="fas fa-users"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col xs={6} md={3}>
          <Card className="stat-card">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Đang hoạt động</small>
                  <h4 className="mb-0">{stats.active}</h4>
                </div>
                <div className="stat-icon bg-success">
                  <i className="fas fa-check-circle"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col xs={6} md={3}>
          <Card className="stat-card">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Đã kết thúc</small>
                  <h4 className="mb-0">{stats.completed}</h4>
                </div>
                <div className="stat-icon bg-info">
                  <i className="fas fa-history"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col xs={6} md={3}>
          <Card className="stat-card">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">Cộng đoàn</small>
                  <h4 className="mb-0">{communities.length}</h4>
                </div>
                <div className="stat-icon bg-warning">
                  <i className="fas fa-home"></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>

      {/* Search & Filter */}
      <Row className="g-3 mb-4 filter-row">
        <Col md={4}>
          <Form.Control
            type="text"
            placeholder="Tìm kiếm theo tên nữ tu, cộng đoàn..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </Col>
        <Col md={2}>
          <Form.Select
            value={filters.community_id}
            onChange={(e) => handleFilterChange("community_id", e.target.value)}
          >
            <option value="">Tất cả cộng đoàn</option>
            {communities.map((c) => (
              <option key={`filter-community-${c.id}`} value={c.id}>
                {c.name}
              </option>
            ))}
          </Form.Select>
        </Col>
        <Col md={2}>
          <Form.Select
            value={filters.role}
            onChange={(e) => handleFilterChange("role", e.target.value)}
          >
            <option value="">Tất cả chức vụ</option>
            {roles.map((role) => (
              <option key={role.code} value={role.code}>
                {role.name}
              </option>
            ))}
          </Form.Select>
        </Col>
        <Col md={2}>
          <Form.Select
            value={filters.status}
            onChange={(e) => handleFilterChange("status", e.target.value)}
          >
            <option value="">Tất cả trạng thái</option>
            <option value="active">Đang hoạt động</option>
            <option value="completed">Đã kết thúc</option>
          </Form.Select>
        </Col>
        <Col md={2} className="d-flex gap-2">
          <Button
            variant="outline-secondary"
            className="flex-grow-1"
            onClick={resetFilters}
          >
            <i className="fas fa-redo me-1"></i>
            Đặt lại
          </Button>
          <Button variant="primary" onClick={handleOpenAddModal}>
            <i className="fas fa-plus me-1"></i>
            Thêm
          </Button>
        </Col>
      </Row>

      {/* Table */}
      <Card className="assignment-table">
        <Card.Body className="p-0">
          <DataTable
            columns={columns}
            data={paginatedAssignments}
            loading={loading}
            emptyText="Không có dữ liệu bổ nhiệm"
            emptyIcon="fas fa-users-slash"
            pagination={filteredAssignments.length > pageSize}
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={handlePageChange}
          />
        </Card.Body>
      </Card>

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

export default AssignmentPage;
