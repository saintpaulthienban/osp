// src/features/thong-tin/pages/PostDetailPage.jsx

import React, { useState, useEffect } from "react";
import { Container, Row, Col, Card, Badge, Button } from "react-bootstrap";
import { Link, useParams, useNavigate } from "react-router-dom";
import { postService } from "@services";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "../styles/ThongTin.css";

const CATEGORIES = {
  "thong-bao": { label: "Thông báo", badge: "info" },
  "su-kien": { label: "Sự kiện", badge: "success" },
  "huong-dan": { label: "Hướng dẫn", badge: "primary" },
  "chia-se": { label: "Chia sẻ", badge: "secondary" },
  khac: { label: "Khác", badge: "dark" },
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

const getFileIcon = (filename) => {
  if (!filename) return "fas fa-file text-secondary";
  const ext = filename.split(".").pop().toLowerCase();
  const icons = {
    pdf: "fas fa-file-pdf text-danger",
    doc: "fas fa-file-word text-primary",
    docx: "fas fa-file-word text-primary",
    xls: "fas fa-file-excel text-success",
    xlsx: "fas fa-file-excel text-success",
    ppt: "fas fa-file-powerpoint text-warning",
    pptx: "fas fa-file-powerpoint text-warning",
    jpg: "fas fa-file-image text-info",
    jpeg: "fas fa-file-image text-info",
    png: "fas fa-file-image text-info",
  };
  return icons[ext] || "fas fa-file text-secondary";
};

const formatFileSize = (bytes) => {
  if (!bytes || bytes === 0) return "0 Bytes";
  const k = 1024;
  const sizes = ["Bytes", "KB", "MB", "GB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return Math.round((bytes / Math.pow(k, i)) * 100) / 100 + " " + sizes[i];
};

const PostDetailPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [post, setPost] = useState(null);

  useEffect(() => {
    fetchPost();
  }, [id]);

  const fetchPost = async () => {
    try {
      setLoading(true);
      const response = await postService.getPostById(id);
      if (response.success) {
        setPost(response.data);
        // Increment view count
        await postService.incrementViewCount(id);
      }
    } catch (error) {
      console.error("Error fetching post:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleTogglePin = async () => {
    try {
      await postService.updatePost(id, { is_pinned: !post.is_pinned });
      setPost((prev) => ({ ...prev, is_pinned: !prev.is_pinned }));
    } catch (error) {
      console.error("Error toggling pin:", error);
    }
  };

  const handleDelete = async () => {
    if (
      window.confirm(
        "Bạn có chắc muốn xóa bài đăng này? Hành động này không thể hoàn tác!"
      )
    ) {
      try {
        await postService.deletePost(id);
        navigate("/thong-tin");
      } catch (error) {
        console.error("Error deleting post:", error);
      }
    }
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

  if (!post) {
    return (
      <Container fluid className="py-4">
        <div className="text-center">
          <i className="fas fa-exclamation-triangle fa-5x text-warning mb-3"></i>
          <h4>Không tìm thấy bài đăng</h4>
          <Link to="/thong-tin" className="btn btn-primary mt-3">
            Quay lại danh sách
          </Link>
        </div>
      </Container>
    );
  }

  const category = CATEGORIES[post.category] || {
    label: post.category,
    badge: "secondary",
  };

  return (
    <Container fluid className="py-4 thong-tin-page">
      <Breadcrumb
        title="Chi tiết bài đăng"
        items={[
          { label: "Thông tin", link: "/thong-tin" },
          { label: "Chi tiết bài đăng" },
        ]}
      />

      <Row>
        <Col lg={9} className="mx-auto">
          <Card className="post-detail">
            <Card.Body>
              {/* Post Header */}
              <div className="post-header">
                <div className="d-flex justify-content-between align-items-start mb-3 flex-wrap gap-2">
                  <div>
                    {post.is_pinned === 1 && (
                      <Badge bg="warning" text="dark" className="me-2">
                        <i className="fas fa-thumbtack"></i> Ghim
                      </Badge>
                    )}
                    <Badge bg={category.badge}>{category.label}</Badge>
                    {post.is_important === 1 && (
                      <Badge bg="danger" className="ms-2">
                        <i className="fas fa-exclamation-circle"></i> Quan trọng
                      </Badge>
                    )}
                  </div>
                  <div className="action-buttons">
                    <Button
                      variant="outline"
                      className="btn-action btn-pin"
                      onClick={handleTogglePin}
                    >
                      <i className="fas fa-thumbtack me-2"></i>
                      {post.is_pinned === 1 ? "Bỏ ghim" : "Ghim"}
                    </Button>
                    <Link
                      to={`/thong-tin/${id}/edit`}
                      className="btn btn-action btn-edit"
                    >
                      <i className="fas fa-edit me-2"></i>Chỉnh sửa
                    </Link>
                    <Button
                      variant="outline"
                      className="btn-action btn-delete"
                      onClick={handleDelete}
                    >
                      <i className="fas fa-trash me-2"></i>Xóa
                    </Button>
                  </div>
                </div>

                <h1 className="post-title">{post.title}</h1>

                <div className="post-meta-detail">
                  <img
                    src={`https://ui-avatars.com/api/?name=${encodeURIComponent(
                      post.author_name || "User"
                    )}&background=667eea&color=fff`}
                    alt="Avatar"
                    className="rounded-circle me-3"
                    width="60"
                    height="60"
                  />
                  <div className="author-info">
                    <div className="author-name">{post.author_name}</div>
                    <div className="post-date">
                      <i className="far fa-clock me-1"></i>
                      Đăng ngày {formatDate(post.created_at)}
                    </div>
                  </div>
                </div>
              </div>

              {/* Post Content */}
              <div className="post-content">
                {post.summary && <p className="lead">{post.summary}</p>}

                <div
                  dangerouslySetInnerHTML={{ __html: post.content }}
                  className="post-body"
                />

                {/* Attachments */}
                {post.attachments && post.attachments.length > 0 && (
                  <div className="attachments">
                    <h5>
                      <i className="fas fa-paperclip"></i>
                      Tài liệu đính kèm
                    </h5>

                    {post.attachments.map((file, index) => (
                      <a
                        href={file.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="attachment-item"
                        key={index}
                      >
                        <div className="d-flex align-items-center">
                          <i
                            className={`${getFileIcon(file.name)} file-icon`}
                          ></i>
                          <div className="attachment-info">
                            <div className="attachment-name">{file.name}</div>
                            <div className="attachment-size">
                              {formatFileSize(file.size)}
                              {file.download_count &&
                                ` • Tải xuống: ${file.download_count} lần`}
                            </div>
                          </div>
                          <i className="fas fa-download attachment-download"></i>
                        </div>
                      </a>
                    ))}
                  </div>
                )}

                {/* Tags */}
                {post.tags && post.tags.length > 0 && (
                  <div className="post-tags">
                    <h6>
                      <i className="fas fa-tags me-2"></i>
                      Thẻ liên quan
                    </h6>
                    {post.tags.map((tag, index) => (
                      <Badge key={index} className="badge">
                        {tag}
                      </Badge>
                    ))}
                  </div>
                )}
              </div>

              {/* Post Footer */}
              <div className="post-footer">
                <div className="d-flex justify-content-between align-items-center flex-wrap gap-2">
                  <div className="update-info">
                    {post.updated_at && post.updated_at !== post.created_at && (
                      <>
                        <i className="fas fa-edit"></i>
                        Cập nhật lần cuối: {formatDate(post.updated_at)}
                      </>
                    )}
                  </div>
                  <div>
                    <Link to="/thong-tin" className="btn btn-back">
                      <i className="fas fa-arrow-left me-2"></i>
                      Quay lại danh sách
                    </Link>
                  </div>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default PostDetailPage;
