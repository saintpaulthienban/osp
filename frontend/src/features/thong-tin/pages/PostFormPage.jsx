// src/features/thong-tin/pages/PostFormPage.jsx

import React, { useState, useEffect, useRef, useCallback } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Form,
  Button,
  Badge,
} from "react-bootstrap";
import { Link, useParams, useNavigate } from "react-router-dom";
import ReactQuill from "react-quill";
import "react-quill/dist/quill.snow.css";
import { postService } from "@services";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "../styles/ThongTin.css";

const CATEGORIES = [
  { value: "thong-bao", label: "📢 Thông báo" },
  { value: "su-kien", label: "🎉 Sự kiện" },
  { value: "huong-dan", label: "📖 Hướng dẫn" },
  { value: "chia-se", label: "💬 Chia sẻ" },
  { value: "khac", label: "📝 Khác" },
];

const QUILL_MODULES = {
  toolbar: [
    [{ header: [1, 2, 3, 4, 5, 6, false] }],
    [{ font: [] }],
    [{ size: ["small", false, "large", "huge"] }],
    ["bold", "italic", "underline", "strike"],
    [{ color: [] }, { background: [] }],
    [{ script: "sub" }, { script: "super" }],
    [{ list: "ordered" }, { list: "bullet" }],
    [{ indent: "-1" }, { indent: "+1" }],
    [{ align: [] }],
    ["blockquote", "code-block"],
    ["link", "image", "video"],
    ["clean"],
  ],
};

const QUILL_FORMATS = [
  "header",
  "font",
  "size",
  "bold",
  "italic",
  "underline",
  "strike",
  "color",
  "background",
  "script",
  "list",
  "bullet",
  "indent",
  "align",
  "blockquote",
  "code-block",
  "link",
  "image",
  "video",
];

const getFileIcon = (filename) => {
  if (!filename) return "fas fa-file fa-2x text-secondary";
  const ext = filename.split(".").pop().toLowerCase();
  const icons = {
    pdf: "fas fa-file-pdf fa-2x text-danger",
    doc: "fas fa-file-word fa-2x text-primary",
    docx: "fas fa-file-word fa-2x text-primary",
    xls: "fas fa-file-excel fa-2x text-success",
    xlsx: "fas fa-file-excel fa-2x text-success",
    ppt: "fas fa-file-powerpoint fa-2x text-warning",
    pptx: "fas fa-file-powerpoint fa-2x text-warning",
    jpg: "fas fa-file-image fa-2x text-info",
    jpeg: "fas fa-file-image fa-2x text-info",
    png: "fas fa-file-image fa-2x text-info",
  };
  return icons[ext] || "fas fa-file fa-2x text-secondary";
};

const formatFileSize = (bytes) => {
  if (!bytes || bytes === 0) return "0 Bytes";
  const k = 1024;
  const sizes = ["Bytes", "KB", "MB", "GB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return Math.round((bytes / Math.pow(k, i)) * 100) / 100 + " " + sizes[i];
};

const PostFormPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const fileInputRef = useRef(null);
  const [loading, setLoading] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [showPreview, setShowPreview] = useState(false);

  const [formData, setFormData] = useState({
    title: "",
    category: "",
    summary: "",
    content: "",
    is_pinned: false,
    is_important: false,
  });

  const [files, setFiles] = useState([]);
  const [existingFiles, setExistingFiles] = useState([]);
  const [errors, setErrors] = useState({});

  const isEditing = Boolean(id);

  useEffect(() => {
    if (isEditing) {
      fetchPost();
    }
  }, [id]);

  const fetchPost = async () => {
    try {
      setLoading(true);
      const response = await postService.getPostById(id);
      if (response.success) {
        const post = response.data;
        setFormData({
          title: post.title || "",
          category: post.category || "",
          summary: post.summary || "",
          content: post.content || "",
          is_pinned: post.is_pinned || false,
          is_important: post.is_important || false,
        });
        setExistingFiles(post.attachments || []);
      }
    } catch (error) {
      console.error("Error fetching post:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value,
    }));
    // Clear error when field changes
    if (errors[name]) {
      setErrors((prev) => ({ ...prev, [name]: null }));
    }
  };

  const handleContentChange = (value) => {
    setFormData((prev) => ({ ...prev, content: value }));
    if (errors.content) {
      setErrors((prev) => ({ ...prev, content: null }));
    }
  };

  const handleDragOver = (e) => {
    e.preventDefault();
    e.currentTarget.classList.add("dragover");
  };

  const handleDragLeave = (e) => {
    e.preventDefault();
    e.currentTarget.classList.remove("dragover");
  };

  const handleDrop = (e) => {
    e.preventDefault();
    e.currentTarget.classList.remove("dragover");
    handleFiles(e.dataTransfer.files);
  };

  const handleFileSelect = (e) => {
    handleFiles(e.target.files);
  };

  const handleFiles = (newFiles) => {
    const validFiles = [];
    Array.from(newFiles).forEach((file) => {
      if (file.size > 10 * 1024 * 1024) {
        alert(`File "${file.name}" quá lớn. Kích thước tối đa là 10MB.`);
        return;
      }
      validFiles.push(file);
    });
    setFiles((prev) => [...prev, ...validFiles]);
  };

  const removeFile = (index) => {
    setFiles((prev) => prev.filter((_, i) => i !== index));
  };

  const removeExistingFile = (index) => {
    setExistingFiles((prev) => prev.filter((_, i) => i !== index));
  };

  const validateForm = () => {
    const newErrors = {};

    if (!formData.title.trim()) {
      newErrors.title = "Vui lòng nhập tiêu đề";
    } else if (formData.title.length > 200) {
      newErrors.title = "Tiêu đề không được quá 200 ký tự";
    }

    if (!formData.category) {
      newErrors.category = "Vui lòng chọn danh mục";
    }

    if (!formData.content || formData.content === "<p><br></p>") {
      newErrors.content = "Vui lòng nhập nội dung bài đăng";
    }

    if (formData.summary && formData.summary.length > 300) {
      newErrors.summary = "Tóm tắt không được quá 300 ký tự";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!validateForm()) {
      return;
    }

    try {
      setSubmitting(true);

      const submitData = new FormData();
      submitData.append("title", formData.title);
      submitData.append("category", formData.category);
      submitData.append("summary", formData.summary);
      submitData.append("content", formData.content);
      submitData.append("is_pinned", formData.is_pinned);
      submitData.append("is_important", formData.is_important);

      // Append new files
      files.forEach((file) => {
        submitData.append("files", file);
      });

      // Append existing files to keep
      submitData.append("existingFiles", JSON.stringify(existingFiles));

      let response;
      if (isEditing) {
        response = await postService.updatePost(id, submitData);
      } else {
        response = await postService.createPost(submitData);
      }

      if (response.success) {
        alert(
          isEditing
            ? "Bài đăng đã được cập nhật thành công!"
            : "Bài đăng đã được tạo thành công!"
        );
        navigate("/thong-tin");
      }
    } catch (error) {
      console.error("Error submitting post:", error);
      alert("Có lỗi xảy ra. Vui lòng thử lại.");
    } finally {
      setSubmitting(false);
    }
  };

  const handleSaveDraft = async () => {
    try {
      setSubmitting(true);
      const submitData = {
        ...formData,
        status: "draft",
        tags: formData.tags
          .split(",")
          .map((tag) => tag.trim())
          .filter((tag) => tag),
      };

      if (isEditing) {
        await postService.updatePost(id, submitData);
      } else {
        await postService.createPost(submitData);
      }

      alert("Đã lưu nháp!");
    } catch (error) {
      console.error("Error saving draft:", error);
    } finally {
      setSubmitting(false);
    }
  };

  const getCategoryBadge = (category) => {
    const badges = {
      "thong-bao": "info",
      "su-kien": "success",
      "huong-dan": "primary",
      "chia-se": "secondary",
      khac: "dark",
    };
    return badges[category] || "secondary";
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
    <Container fluid className="py-4 thong-tin-page">
      <Breadcrumb
        title={isEditing ? "Chỉnh sửa bài đăng" : "Tạo bài đăng mới"}
        items={[
          { label: "Thông tin", link: "/thong-tin" },
          { label: isEditing ? "Chỉnh sửa bài đăng" : "Tạo bài đăng mới" },
        ]}
      />

      <Row>
        <Col lg={10} className="mx-auto">
          <Form onSubmit={handleSubmit}>
            <Card className="form-card mb-4">
              <Card.Header>
                <h4 className="mb-0">
                  <i className="fas fa-pen-fancy me-2"></i>
                  {isEditing ? "Chỉnh sửa bài đăng" : "Tạo bài đăng mới"}
                </h4>
                <small>
                  Điền đầy đủ thông tin để {isEditing ? "cập nhật" : "tạo"} bài
                  đăng
                </small>
              </Card.Header>
              <Card.Body>
                {/* Title */}
                <Form.Group className="mb-4">
                  <Form.Label>
                    Tiêu đề bài đăng <span className="text-danger">*</span>
                  </Form.Label>
                  <Form.Control
                    type="text"
                    name="title"
                    value={formData.title}
                    onChange={handleInputChange}
                    placeholder="Nhập tiêu đề bài đăng..."
                    maxLength={200}
                    isInvalid={!!errors.title}
                    size="lg"
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.title}
                  </Form.Control.Feedback>
                  <div
                    className={`character-count ${
                      formData.title.length > 180 ? "warning" : ""
                    } ${formData.title.length >= 200 ? "danger" : ""}`}
                  >
                    {formData.title.length}/200 ký tự
                  </div>
                </Form.Group>

                {/* Category & Options */}
                <Row className="mb-4">
                  <Col md={6}>
                    <Form.Group>
                      <Form.Label>
                        Danh mục <span className="text-danger">*</span>
                      </Form.Label>
                      <Form.Select
                        name="category"
                        value={formData.category}
                        onChange={handleInputChange}
                        isInvalid={!!errors.category}
                      >
                        <option value="">-- Chọn danh mục --</option>
                        {CATEGORIES.map((cat) => (
                          <option key={cat.value} value={cat.value}>
                            {cat.label}
                          </option>
                        ))}
                      </Form.Select>
                      <Form.Control.Feedback type="invalid">
                        {errors.category}
                      </Form.Control.Feedback>
                    </Form.Group>
                  </Col>
                  <Col md={6}>
                    <Form.Label className="d-block">Tùy chọn</Form.Label>
                    <Form.Check
                      inline
                      type="checkbox"
                      id="is_pinned"
                      name="is_pinned"
                      checked={formData.is_pinned}
                      onChange={handleInputChange}
                      label={
                        <>
                          <i className="fas fa-thumbtack text-warning me-1"></i>
                          Ghim bài đăng
                        </>
                      }
                    />
                    <Form.Check
                      inline
                      type="checkbox"
                      id="is_important"
                      name="is_important"
                      checked={formData.is_important}
                      onChange={handleInputChange}
                      label={
                        <>
                          <i className="fas fa-exclamation-circle text-danger me-1"></i>
                          Quan trọng
                        </>
                      }
                    />
                  </Col>
                </Row>

                {/* Summary */}
                <Form.Group className="mb-4">
                  <Form.Label>
                    Tóm tắt ngắn{" "}
                    <i
                      className="fas fa-info-circle text-muted"
                      title="Tóm tắt sẽ hiển thị trong danh sách bài đăng"
                    ></i>
                  </Form.Label>
                  <Form.Control
                    as="textarea"
                    name="summary"
                    value={formData.summary}
                    onChange={handleInputChange}
                    rows={3}
                    placeholder="Nhập tóm tắt ngắn gọn về nội dung bài đăng..."
                    maxLength={300}
                    isInvalid={!!errors.summary}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.summary}
                  </Form.Control.Feedback>
                  <div
                    className={`character-count ${
                      formData.summary.length > 270 ? "warning" : ""
                    } ${formData.summary.length >= 300 ? "danger" : ""}`}
                  >
                    {formData.summary.length}/300 ký tự
                  </div>
                </Form.Group>

                {/* Content */}
                <Form.Group className="mb-4">
                  <Form.Label>
                    Nội dung bài đăng <span className="text-danger">*</span>
                  </Form.Label>
                  <div
                    className={`editor-container ${
                      errors.content ? "border-danger" : ""
                    }`}
                  >
                    <ReactQuill
                      theme="snow"
                      value={formData.content}
                      onChange={handleContentChange}
                      modules={QUILL_MODULES}
                      formats={QUILL_FORMATS}
                      placeholder="Nhập nội dung bài đăng của bạn tại đây..."
                    />
                  </div>
                  {errors.content && (
                    <div className="text-danger small mt-1">
                      {errors.content}
                    </div>
                  )}
                  <small className="text-muted">
                    <i className="fas fa-lightbulb me-1"></i>
                    Sử dụng thanh công cụ để định dạng văn bản, thêm hình ảnh,
                    liên kết...
                  </small>
                </Form.Group>

                {/* File Upload */}
                <Form.Group className="mb-4">
                  <Form.Label>Tài liệu đính kèm</Form.Label>
                  <div
                    className="file-upload-area"
                    onDragOver={handleDragOver}
                    onDragLeave={handleDragLeave}
                    onDrop={handleDrop}
                    onClick={() => fileInputRef.current?.click()}
                  >
                    <input
                      type="file"
                      ref={fileInputRef}
                      onChange={handleFileSelect}
                      multiple
                      hidden
                      accept=".pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.jpg,.jpeg,.png"
                    />
                    <i className="fas fa-cloud-upload-alt"></i>
                    <h5 className="mt-3">Kéo thả file vào đây</h5>
                    <p className="text-muted mb-3">hoặc</p>
                    <Button
                      variant="primary"
                      className="btn-primary-gradient"
                      onClick={(e) => {
                        e.stopPropagation();
                        fileInputRef.current?.click();
                      }}
                    >
                      <i className="fas fa-folder-open me-2"></i>
                      Chọn file từ máy tính
                    </Button>
                    <p className="text-muted mt-3 mb-0">
                      <small>
                        Hỗ trợ: PDF, Word, Excel, PowerPoint, Hình ảnh (Tối đa
                        10MB/file)
                      </small>
                    </p>
                  </div>

                  {/* Existing Files */}
                  {existingFiles.length > 0 && (
                    <div className="uploaded-files">
                      <h6 className="mt-3 mb-2">File đã tải lên:</h6>
                      {existingFiles.map((file, index) => (
                        <div className="file-item" key={`existing-${index}`}>
                          <div className="d-flex align-items-center flex-grow-1">
                            <i className={`${getFileIcon(file.name)} me-3`}></i>
                            <div>
                              <div className="fw-bold">{file.name}</div>
                              <small className="text-muted">
                                {formatFileSize(file.size)}
                              </small>
                            </div>
                          </div>
                          <button
                            type="button"
                            className="btn-remove"
                            onClick={() => removeExistingFile(index)}
                          >
                            <i className="fas fa-times"></i>
                          </button>
                        </div>
                      ))}
                    </div>
                  )}

                  {/* New Files */}
                  {files.length > 0 && (
                    <div className="uploaded-files">
                      <h6 className="mt-3 mb-2">File mới:</h6>
                      {files.map((file, index) => (
                        <div className="file-item" key={`new-${index}`}>
                          <div className="d-flex align-items-center flex-grow-1">
                            <i className={`${getFileIcon(file.name)} me-3`}></i>
                            <div>
                              <div className="fw-bold">{file.name}</div>
                              <small className="text-muted">
                                {formatFileSize(file.size)}
                              </small>
                            </div>
                          </div>
                          <button
                            type="button"
                            className="btn-remove"
                            onClick={() => removeFile(index)}
                          >
                            <i className="fas fa-times"></i>
                          </button>
                        </div>
                      ))}
                    </div>
                  )}
                </Form.Group>

                {/* Action Buttons */}
                <div className="d-flex justify-content-end align-items-center pt-3 border-top">
                  <div>
                    <Link
                      to="/thong-tin"
                      className="btn btn-outline-secondary me-2"
                    >
                      <i className="fas fa-times me-2"></i>
                      Hủy
                    </Link>
                    <Button
                      type="submit"
                      variant="primary"
                      className="btn-primary-gradient"
                      disabled={submitting}
                    >
                      {submitting ? (
                        <>
                          <span className="spinner-border spinner-border-sm me-2"></span>
                          Đang xử lý...
                        </>
                      ) : (
                        <>
                          <i className="fas fa-paper-plane me-2"></i>
                          {isEditing ? "Cập nhật" : "Đăng bài"}
                        </>
                      )}
                    </Button>
                  </div>
                </div>
              </Card.Body>
            </Card>
          </Form>
        </Col>
      </Row>
    </Container>
  );
};

export default PostFormPage;
