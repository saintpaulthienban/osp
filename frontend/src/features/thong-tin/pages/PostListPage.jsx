// src/features/thong-tin/pages/PostListPage.jsx

import React, { useState, useEffect } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Form,
  InputGroup,
  Button,
  Badge,
  Dropdown,
  Pagination,
} from "react-bootstrap";
import { Link, useNavigate } from "react-router-dom";
import { postService } from "@services";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "../styles/ThongTin.css";

const CATEGORIES = [
  { value: "", label: "Tất cả danh mục", icon: "" },
  { value: "thong-bao", label: "📢 Thông báo", badge: "info" },
  { value: "su-kien", label: "🎉 Sự kiện", badge: "success" },
  { value: "huong-dan", label: "📖 Hướng dẫn", badge: "primary" },
  { value: "chia-se", label: "💬 Chia sẻ", badge: "secondary" },
  { value: "khac", label: "📝 Khác", badge: "dark" },
];

const getCategoryBadge = (category) => {
  const cat = CATEGORIES.find((c) => c.value === category);
  return cat ? cat.badge : "secondary";
};

const getCategoryLabel = (category) => {
  const cat = CATEGORIES.find((c) => c.value === category);
  return cat ? cat.label.replace(/^[^\s]+\s/, "") : category;
};

const formatDate = (dateString) => {
  if (!dateString) return "";
  const date = new Date(dateString);
  return date.toLocaleDateString("vi-VN", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
};

const PostListPage = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [posts, setPosts] = useState([]);
  const [pinnedPosts, setPinnedPosts] = useState([]);
  const [pagination, setPagination] = useState({
    page: 1,
    limit: 6,
    total: 0,
    totalPages: 0,
  });
  const [filters, setFilters] = useState({
    search: "",
    category: "",
    status: "",
    sortBy: "newest",
  });

  useEffect(() => {
    fetchPosts();
  }, [pagination.page, filters]);

  const fetchPosts = async () => {
    try {
      setLoading(true);
      const response = await postService.getPosts({
        page: pagination.page,
        limit: pagination.limit,
        ...filters,
      });

      if (response.success) {
        setPosts(response.data.posts || []);
        setPinnedPosts(response.data.pinnedPosts || []);
        setPagination((prev) => ({
          ...prev,
          total: response.data.total || 0,
          totalPages: response.data.totalPages || 1,
        }));
      }
    } catch (error) {
      console.error("Error fetching posts:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (field, value) => {
    setFilters((prev) => ({ ...prev, [field]: value }));
    setPagination((prev) => ({ ...prev, page: 1 }));
  };

  const handleTogglePin = async (postId, isPinned) => {
    try {
      await postService.updatePost(postId, { is_pinned: !isPinned });
      fetchPosts();
    } catch (error) {
      console.error("Error toggling pin:", error);
    }
  };

  const handleDelete = async (postId) => {
    if (window.confirm("Bạn có chắc muốn xóa bài đăng này?")) {
      try {
        await postService.deletePost(postId);
        fetchPosts();
      } catch (error) {
        console.error("Error deleting post:", error);
      }
    }
  };

  const renderPostCard = (post, isPinned = false) => (
    <Card
      className={`post-card ${isPinned ? "pinned" : ""}`}
      key={post.id}
      onClick={() => navigate(`/thong-tin/${post.id}`)}
      style={{ cursor: "pointer" }}
    >
      <Card.Body>
        <div className="d-flex justify-content-between align-items-start mb-3">
          <div>
            {isPinned && (
              <Badge bg="warning" text="dark" className="me-2">
                <i className="fas fa-thumbtack"></i> Ghim
              </Badge>
            )}
            <Badge bg={getCategoryBadge(post.category)}>
              {getCategoryLabel(post.category)}
            </Badge>
            {post.is_important === 1 && (
              <Badge bg="danger" className="ms-1">
                <i className="fas fa-exclamation-circle"></i> Quan trọng
              </Badge>
            )}
          </div>
          <Dropdown
            className="post-dropdown"
            onClick={(e) => e.stopPropagation()}
          >
            <Dropdown.Toggle
              variant="link"
              className="text-muted p-0"
              id={`dropdown-${post.id}`}
            >
              <i className="fas fa-ellipsis-v"></i>
            </Dropdown.Toggle>
            <Dropdown.Menu align="end">
              <Dropdown.Item
                onClick={() => handleTogglePin(post.id, post.is_pinned)}
              >
                <i className="fas fa-thumbtack me-2"></i>
                {post.is_pinned ? "Bỏ ghim" : "Ghim bài"}
              </Dropdown.Item>
              <Dropdown.Item
                onClick={() => navigate(`/thong-tin/${post.id}/edit`)}
              >
                <i className="fas fa-edit me-2"></i>Chỉnh sửa
              </Dropdown.Item>
              <Dropdown.Divider />
              <Dropdown.Item
                className="text-danger"
                onClick={() => handleDelete(post.id)}
              >
                <i className="fas fa-trash me-2"></i>Xóa
              </Dropdown.Item>
            </Dropdown.Menu>
          </Dropdown>
        </div>

        <h5 className="card-title">{post.title}</h5>
        <p className="card-text">
          {post.summary || post.content?.substring(0, 150)}...
        </p>

        <div className="d-flex justify-content-between align-items-center mt-3">
          <div className="post-meta">
            <img
              src={`https://ui-avatars.com/api/?name=${encodeURIComponent(
                post.author_name || "User"
              )}&background=042954&color=fff`}
              alt="Avatar"
              className="rounded-circle me-2"
              width="32"
              height="32"
            />
            <small className="text-muted">
              <strong>{post.author_name}</strong>
              <br />
              <i className="far fa-clock me-1"></i>
              {formatDate(post.created_at)}
            </small>
          </div>
        </div>
      </Card.Body>
    </Card>
  );

  if (loading && posts.length === 0) {
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
    <Container fluid className="py-4 thong-tin-page">
      <Breadcrumb title="Thông tin" items={[{ label: "Thông tin" }]} />

      {/* Search & Filter */}
      <div className="search-card">
        <Row className="g-3">
          <Col md={5}>
            <InputGroup>
              <InputGroup.Text>
                <i className="fas fa-search"></i>
              </InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Tìm kiếm theo tiêu đề, nội dung..."
                value={filters.search}
                onChange={(e) => handleFilterChange("search", e.target.value)}
              />
            </InputGroup>
          </Col>
          <Col md={3}>
            <Form.Select
              value={filters.category}
              onChange={(e) => handleFilterChange("category", e.target.value)}
            >
              {CATEGORIES.map((cat) => (
                <option key={cat.value} value={cat.value}>
                  {cat.label}
                </option>
              ))}
            </Form.Select>
          </Col>
          <Col md={2}>
            <Form.Select
              value={filters.status}
              onChange={(e) => handleFilterChange("status", e.target.value)}
            >
              <option value="">Tất cả</option>
              <option value="pinned">Bài ghim</option>
              <option value="important">Quan trọng</option>
            </Form.Select>
          </Col>
          <Col md={2}>
            <Form.Select
              value={filters.sortBy}
              onChange={(e) => handleFilterChange("sortBy", e.target.value)}
            >
              <option value="newest">Mới nhất</option>
              <option value="oldest">Cũ nhất</option>
              <option value="views">Xem nhiều nhất</option>
            </Form.Select>
          </Col>
        </Row>
      </div>

      {/* Pinned Posts */}
      {pinnedPosts.length > 0 && (
        <div className="mb-4">
          <div className="section-header">
            <i className="fas fa-thumbtack text-warning"></i>
            <h5>Bài đăng ghim</h5>
          </div>
          <Row className="g-4">
            {pinnedPosts.map((post) => (
              <Col xs={12} key={post.id}>
                {renderPostCard(post, true)}
              </Col>
            ))}
          </Row>
        </div>
      )}

      {/* Regular Posts */}
      <div>
        <div className="section-header d-flex justify-content-between align-items-center">
          <div className="d-flex align-items-center">
            <i className="fas fa-list text-primary"></i>
            <h5 className="mb-0 ms-2">Tất cả bài đăng</h5>
          </div>
          <Link to="/thong-tin/tao-moi" className="btn btn-create btn-sm">
            <i className="fas fa-plus me-2"></i>
            Tạo bài đăng mới
          </Link>
        </div>

        {posts.length === 0 ? (
          <div className="empty-state">
            <i className="fas fa-inbox fa-5x"></i>
            <h5>Chưa có bài đăng nào</h5>
            <p>Hãy tạo bài đăng đầu tiên của bạn</p>
            <Link to="/thong-tin/tao-moi" className="btn btn-create">
              <i className="fas fa-plus me-2"></i>Tạo bài đăng
            </Link>
          </div>
        ) : (
          <>
            <Row className="g-4">
              {posts.map((post) => (
                <Col md={6} lg={4} key={post.id}>
                  {renderPostCard(post)}
                </Col>
              ))}
            </Row>

            {/* Pagination */}
            {pagination.totalPages > 1 && (
              <Pagination className="justify-content-center mt-4">
                <Pagination.Prev
                  disabled={pagination.page === 1}
                  onClick={() =>
                    setPagination((prev) => ({ ...prev, page: prev.page - 1 }))
                  }
                >
                  <i className="fas fa-chevron-left"></i>
                </Pagination.Prev>

                {[...Array(pagination.totalPages)].map((_, index) => (
                  <Pagination.Item
                    key={index + 1}
                    active={pagination.page === index + 1}
                    onClick={() =>
                      setPagination((prev) => ({ ...prev, page: index + 1 }))
                    }
                  >
                    {index + 1}
                  </Pagination.Item>
                ))}

                <Pagination.Next
                  disabled={pagination.page === pagination.totalPages}
                  onClick={() =>
                    setPagination((prev) => ({ ...prev, page: prev.page + 1 }))
                  }
                >
                  <i className="fas fa-chevron-right"></i>
                </Pagination.Next>
              </Pagination>
            )}
          </>
        )}
      </div>
    </Container>
  );
};

export default PostListPage;
