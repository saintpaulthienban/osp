// src/features/hoc-van/pages/EducationFormPage.jsx

import React, { useState, useEffect } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Form,
  Button,
  Alert,
  Spinner,
} from "react-bootstrap";
import { useNavigate, useParams, Link } from "react-router-dom";
import {
  FaGraduationCap,
  FaSave,
  FaArrowLeft,
  FaPaperclip,
} from "react-icons/fa";
import { toast } from "react-toastify";
import { educationService, sisterService, lookupService } from "@services";
import Breadcrumb from "@components/common/Breadcrumb";
import MultiFileUpload from "@components/forms/MultiFileUpload";
import DatePicker from "@components/forms/DatePicker";
import SearchableSelect from "@components/forms/SearchableSelect";
import "./EducationDetailPage.css";

// Default education levels (fallback)
const defaultLevels = [
  { code: "secondary", name: "Trung học", color: "#6c757d" },
  { code: "bachelor", name: "Đại học", color: "#0d6efd" },
  { code: "master", name: "Thạc sĩ", color: "#6f42c1" },
  { code: "doctorate", name: "Tiến sĩ", color: "#dc3545" },
];

// Predefined colors for levels
const levelColors = [
  { value: "#6c757d", label: "Xám" },
  { value: "#17a2b8", label: "Xanh nhạt" },
  { value: "#20c997", label: "Xanh ngọc" },
  { value: "#fd7e14", label: "Cam" },
  { value: "#0d6efd", label: "Xanh dương" },
  { value: "#6f42c1", label: "Tím" },
  { value: "#dc3545", label: "Đỏ" },
  { value: "#ffc107", label: "Vàng" },
  { value: "#198754", label: "Xanh lá" },
  { value: "#adb5bd", label: "Bạc" },
];

// Chuẩn hóa danh sách nữ tu, loại bỏ trùng lặp
const normalizeSisters = (rawList = []) => {
  const map = new Map();
  rawList.forEach((sister) => {
    if (!sister || !sister.id || map.has(sister.id)) return;
    map.set(sister.id, {
      id: sister.id,
      code: sister.code,
      displayName:
        sister.religious_name || sister.birth_name || sister.full_name || "",
    });
  });
  return Array.from(map.values()).sort((a, b) =>
    (a.displayName || "").localeCompare(b.displayName || "", "vi")
  );
};

// Trích xuất danh sách từ response API
const extractSisterItems = (payload) => {
  if (!payload) return [];
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload.items)) return payload.items;
  if (Array.isArray(payload.data)) return payload.data;
  return [];
};

const defaultFormState = {
  sister_id: "",
  level: "bachelor",
  major: "",
  institution: "",
  start_date: "",
  end_date: "",
  graduation_year: "",
  status: "dang_hoc",
  gpa: "",
  thesis_title: "",
  notes: "",
};

const normalizeDateInput = (value) => {
  if (!value) return "";
  if (typeof value === "string") {
    return value.length >= 10 ? value.slice(0, 10) : value;
  }
  try {
    return new Date(value).toISOString().slice(0, 10);
  } catch (error) {
    return "";
  }
};

const parseDocumentsValue = (docs) => {
  if (!docs) return [];
  if (Array.isArray(docs)) return docs;
  if (typeof docs === "string") {
    try {
      const parsed = JSON.parse(docs);
      return Array.isArray(parsed) ? parsed : [];
    } catch (error) {
      return [];
    }
  }
  return [];
};

const EducationFormPage = () => {
  const navigate = useNavigate();
  const { id, sisterId } = useParams();
  const isEdit = Boolean(id);

  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState({ type: "", text: "" });
  const [sisters, setSisters] = useState([]);
  const [documents, setDocuments] = useState([]);

  // Education levels management
  const [levels, setLevels] = useState(defaultLevels);
  const [showAddLevelModal, setShowAddLevelModal] = useState(false);
  const [newLevelName, setNewLevelName] = useState("");
  const [newLevelColor, setNewLevelColor] = useState("#0d6efd");
  const [addingLevel, setAddingLevel] = useState(false);

  const [formData, setFormData] = useState({
    ...defaultFormState,
    sister_id: sisterId || "",
  });

  useEffect(() => {
    fetchSisters();
    fetchEducationLevels();
    if (isEdit) {
      fetchEducation();
    }
  }, [id]);

  const fetchEducationLevels = async () => {
    try {
      const response = await lookupService.getEducationLevels();
      if (response && response.data && response.data.length > 0) {
        setLevels(response.data);
      }
    } catch (error) {
      console.error("Error fetching education levels:", error);
      // Use default levels if API fails
      setLevels(defaultLevels);
    }
  };

  const handleAddLevel = async () => {
    if (!newLevelName.trim()) {
      toast.error("Vui lòng nhập tên trình độ");
      return;
    }

    try {
      setAddingLevel(true);
      const response = await lookupService.createEducationLevel({
        name: newLevelName.trim(),
        display_order: levels.length + 1,
        color: newLevelColor,
      });

      if (response && response.data) {
        await fetchEducationLevels();
        setNewLevelName("");
        setNewLevelColor("#0d6efd");
        setShowAddLevelModal(false);
        toast.success("Đã thêm trình độ mới thành công!");
      }
    } catch (error) {
      console.error("Error adding level:", error);
      toast.error("Không thể thêm trình độ mới");
    } finally {
      setAddingLevel(false);
    }
  };

  const handleDeleteLevel = async (levelCode) => {
    const level = levels.find((l) => l.code === levelCode);
    if (!level) return;

    if (
      !window.confirm(`Bạn có chắc chắn muốn xóa trình độ "${level.name}"?`)
    ) {
      return;
    }

    try {
      const response = await lookupService.deleteEducationLevel(level.id);
      if (response && response.success) {
        await fetchEducationLevels();
        // Reset level selection if deleted level was selected
        if (formData.level === level.code) {
          setFormData((prev) => ({ ...prev, level: "bachelor" }));
        }
        toast.success("Đã xóa trình độ thành công!");
      }
    } catch (error) {
      console.error("Error deleting level:", error);
      const errorMessage =
        error?.response?.data?.message || "Không thể xóa trình độ";
      toast.error(errorMessage);
    }
  };

  const fetchSisters = async () => {
    try {
      const response = await sisterService.getList({
        limit: 1000,
        status: "all",
      });
      const list = normalizeSisters(
        extractSisterItems(response?.data) || extractSisterItems(response)
      );
      setSisters(list);
    } catch (error) {
      console.error("Error fetching sisters:", error);
      setMessage({ type: "danger", text: "Không thể tải danh sách nữ tu" });
    }
  };

  const fetchEducation = async () => {
    setLoading(true);
    try {
      const response = await educationService.getById(id);
      if (response.success) {
        const data = response.data || {};
        setFormData({
          ...defaultFormState,
          ...data,
          sister_id: data.sister_id ? String(data.sister_id) : "",
          start_date: normalizeDateInput(data.start_date),
          end_date: normalizeDateInput(data.end_date),
          graduation_year: data.graduation_year
            ? String(data.graduation_year)
            : "",
        });
        setDocuments(parseDocumentsValue(data.documents));
      }
    } catch (error) {
      console.error("Error fetching education:", error);
      setMessage({ type: "danger", text: "Lỗi khi tải thông tin học vấn" });
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    setMessage({ type: "", text: "" });

    try {
      // Chuẩn bị payload với đúng định dạng backend yêu cầu
      const payload = {
        sister_id: parseInt(formData.sister_id, 10),
        level: formData.level,
        major: formData.major || null,
        institution: formData.institution || null,
        start_date: formData.start_date || null,
        end_date: formData.end_date || null,
        graduation_year: formData.graduation_year
          ? parseInt(formData.graduation_year, 10)
          : null,
        status: formData.status || "dang_hoc",
        gpa: formData.gpa || null,
        thesis_title: formData.thesis_title || null,
        notes: formData.notes || null,
        documents: documents.length > 0 ? JSON.stringify(documents) : null,
      };

      let result;
      if (isEdit) {
        result = await educationService.update(id, payload);
      } else {
        result = await educationService.create(payload);
      }

      if (result.success) {
        const successMsg = isEdit
          ? "Đã cập nhật học vấn thành công!"
          : "Đã thêm học vấn thành công!";
        toast.success(successMsg);
        setMessage({ type: "success", text: successMsg });
        setTimeout(() => {
          if (sisterId) {
            navigate(`/nu-tu/${sisterId}/hoc-van`);
          } else {
            navigate("/hoc-van");
          }
        }, 1500);
      } else {
        const errorMsg = result.error || "Không thể lưu thông tin học vấn";
        toast.error(errorMsg);
        setMessage({ type: "danger", text: errorMsg });
      }
    } catch (error) {
      const errorMsg =
        error?.response?.data?.message || "Lỗi khi lưu thông tin học vấn";
      toast.error(errorMsg);
      setMessage({ type: "danger", text: errorMsg });
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <Container fluid className="py-4 text-center">
        <Spinner animation="border" variant="primary" />
        <p className="mt-2">Đang tải...</p>
      </Container>
    );
  }

  return (
    <Container fluid className="py-4">
      <Breadcrumb
        title={isEdit ? "Chỉnh sửa Học vấn" : "Thêm Học vấn mới"}
        items={[
          { label: "Học vấn", link: "/hoc-van" },
          { label: isEdit ? "Chỉnh sửa" : "Thêm mới" },
        ]}
      />

      <div className="mb-4">
        <Link
          to={sisterId ? `/nu-tu/${sisterId}/hoc-van` : "/hoc-van"}
          className="btn btn-outline-secondary"
        >
          <FaArrowLeft className="me-2" />
          Quay lại
        </Link>
      </div>

      <Row>
        <Col lg={8}>
          <Card className="health-info-card">
            <Card.Header>
              <FaGraduationCap className="me-2" />
              <span>Thông tin Học vấn</span>
            </Card.Header>
            <Card.Body>
              {message.text && (
                <Alert
                  variant={message.type}
                  dismissible
                  onClose={() => setMessage({ type: "", text: "" })}
                >
                  {message.text}
                </Alert>
              )}

              <Form onSubmit={handleSubmit}>
                <Row>
                  <Col md={6}>
                    <SearchableSelect
                      label="Nữ tu"
                      name="sister_id"
                      value={formData.sister_id}
                      onChange={handleChange}
                      required
                      disabled={Boolean(sisterId) || isEdit}
                      placeholder="Nhập tên để tìm..."
                      maxDisplayItems={5}
                      options={sisters.map((sister) => ({
                        value: sister.id,
                        label:
                          sister.displayName +
                          (sister.code ? ` (${sister.code})` : ""),
                      }))}
                    />
                  </Col>
                  <Col md={6}>
                    <Form.Group className="mb-3">
                      <Form.Label>Trình độ *</Form.Label>
                      <div className="d-flex align-items-center gap-2">
                        <Form.Select
                          name="level"
                          value={formData.level}
                          onChange={handleChange}
                          required
                          style={{ flex: 1 }}
                        >
                          {levels.map((level) => (
                            <option key={level.code} value={level.code}>
                              {level.name}
                            </option>
                          ))}
                        </Form.Select>
                        <Button
                          variant="outline-success"
                          size="sm"
                          onClick={() => setShowAddLevelModal(true)}
                          title="Thêm trình độ mới"
                          style={{ flexShrink: 0 }}
                        >
                          <i className="fas fa-plus"></i>
                        </Button>
                        {formData.level && (
                          <Button
                            variant="outline-danger"
                            size="sm"
                            onClick={() => handleDeleteLevel(formData.level)}
                            title="Xóa trình độ đã chọn"
                            style={{ flexShrink: 0 }}
                          >
                            <i className="fas fa-minus"></i>
                          </Button>
                        )}
                      </div>
                    </Form.Group>
                  </Col>
                </Row>

                <Form.Group className="mb-3">
                  <Form.Label>Trường / Cơ sở đào tạo</Form.Label>
                  <Form.Control
                    type="text"
                    name="institution"
                    value={formData.institution}
                    onChange={handleChange}
                    placeholder="Nhập tên trường hoặc cơ sở đào tạo"
                    required
                  />
                </Form.Group>

                <Form.Group className="mb-3">
                  <Form.Label>Ngành học / Chuyên ngành *</Form.Label>
                  <Form.Control
                    type="text"
                    name="major"
                    value={formData.major}
                    onChange={handleChange}
                    placeholder="Nhập ngành học hoặc chuyên ngành"
                    required
                  />
                </Form.Group>

                <Row>
                  <Col md={6}>
                    <DatePicker
                      label="Ngày bắt đầu"
                      name="start_date"
                      value={formData.start_date}
                      onChange={(value) =>
                        setFormData((prev) => ({ ...prev, start_date: value }))
                      }
                      className="mb-3"
                    />
                  </Col>
                  <Col md={6}>
                    <DatePicker
                      label="Ngày kết thúc"
                      name="end_date"
                      value={formData.end_date}
                      onChange={(value) =>
                        setFormData((prev) => ({ ...prev, end_date: value }))
                      }
                      className="mb-3"
                    />
                  </Col>
                </Row>

                <Row>
                  <Col md={4}>
                    <Form.Group className="mb-3">
                      <Form.Label>Năm tốt nghiệp</Form.Label>
                      <Form.Control
                        type="number"
                        name="graduation_year"
                        value={formData.graduation_year}
                        onChange={handleChange}
                        placeholder="VD: 2024"
                        min="1950"
                        max={new Date().getFullYear() + 10}
                      />
                    </Form.Group>
                  </Col>
                  <Col md={4}>
                    <Form.Group className="mb-3">
                      <Form.Label>Trạng thái</Form.Label>
                      <Form.Select
                        name="status"
                        value={formData.status}
                        onChange={handleChange}
                      >
                        <option value="dang_hoc">Đang học</option>
                        <option value="da_tot_nghiep">Đã tốt nghiệp</option>
                        <option value="tam_nghi">Tạm nghỉ</option>
                        <option value="da_nghi">Đã nghỉ</option>
                      </Form.Select>
                    </Form.Group>
                  </Col>
                  <Col md={4}>
                    <Form.Group className="mb-3">
                      <Form.Label>Điểm trung bình (GPA)</Form.Label>
                      <Form.Control
                        type="text"
                        name="gpa"
                        value={formData.gpa}
                        onChange={handleChange}
                        placeholder="VD: 3.5/4.0"
                      />
                    </Form.Group>
                  </Col>
                </Row>

                <Form.Group className="mb-3">
                  <Form.Label>Tên luận văn / Đề tài</Form.Label>
                  <Form.Control
                    type="text"
                    name="thesis_title"
                    value={formData.thesis_title}
                    onChange={handleChange}
                    placeholder="Nhập tên luận văn hoặc đề tài nghiên cứu (nếu có)"
                  />
                </Form.Group>

                <Form.Group className="mb-3">
                  <Form.Label>Ghi chú</Form.Label>
                  <Form.Control
                    as="textarea"
                    rows={3}
                    name="notes"
                    value={formData.notes}
                    onChange={handleChange}
                    placeholder="Ghi chú thêm..."
                  />
                </Form.Group>

                <Card className="health-info-card">
                  <Card.Header className="documents-header">
                    <FaPaperclip className="me-2" />
                    <span>Tài liệu đính kèm</span>
                  </Card.Header>
                  <Card.Body>
                    <MultiFileUpload
                      value={documents}
                      onChange={setDocuments}
                      accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                      maxFiles={5}
                      maxSize={10 * 1024 * 1024}
                    />
                    <small className="text-muted d-block mt-2">
                      Hỗ trợ: PDF, Word, hình ảnh (tối đa 5 file, mỗi file ≤
                      10MB)
                    </small>
                  </Card.Body>
                </Card>

                <div className="d-flex justify-content-end gap-2">
                  <Link
                    to={sisterId ? `/nu-tu/${sisterId}/hoc-van` : "/hoc-van"}
                    className="btn btn-secondary"
                  >
                    Hủy
                  </Link>
                  <Button type="submit" variant="primary" disabled={saving}>
                    {saving ? (
                      <>
                        <Spinner size="sm" className="me-2" />
                        Đang lưu...
                      </>
                    ) : (
                      <>
                        <FaSave className="me-2" />
                        {isEdit ? "Cập nhật" : "Lưu"}
                      </>
                    )}
                  </Button>
                </div>
              </Form>
            </Card.Body>
          </Card>
        </Col>

        <Col lg={4}>
          <Card className="health-info-card">
            <Card.Header className="system-header">
              <FaGraduationCap className="me-2" />
              <span>Hướng dẫn</span>
            </Card.Header>
            <Card.Body>
              <ul className="mb-0">
                <li className="mb-2">Các trường có dấu (*) là bắt buộc</li>
                <li className="mb-2">Chọn đúng loại bằng cấp tương ứng</li>
                <li className="mb-2">
                  Điền đầy đủ thông tin trường học và ngành học
                </li>
                <li className="mb-2">
                  Cập nhật trạng thái khi hoàn thành khóa học
                </li>
                <li>Có thể bổ sung thông tin luận văn và GPA sau</li>
              </ul>
            </Card.Body>
          </Card>
        </Col>
      </Row>

      {/* Add Level Modal */}
      {showAddLevelModal && (
        <div
          className="modal show d-block"
          style={{ backgroundColor: "rgba(0,0,0,0.5)", zIndex: 1060 }}
        >
          <div className="modal-dialog modal-dialog-centered">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">
                  <i className="fas fa-plus-circle me-2"></i>
                  Thêm trình độ mới
                </h5>
                <button
                  type="button"
                  className="btn-close"
                  onClick={() => setShowAddLevelModal(false)}
                ></button>
              </div>
              <div className="modal-body">
                <Form.Group className="mb-3">
                  <Form.Label>
                    Tên trình độ <span className="text-danger">*</span>
                  </Form.Label>
                  <Form.Control
                    type="text"
                    placeholder="Ví dụ: Sau đại học"
                    value={newLevelName}
                    onChange={(e) => setNewLevelName(e.target.value)}
                  />
                </Form.Group>
                <Form.Group className="mb-3">
                  <Form.Label>
                    Màu trình độ <span className="text-danger">*</span>
                  </Form.Label>
                  <div className="d-flex flex-wrap gap-2">
                    {levelColors.map((color) => (
                      <div
                        key={color.value}
                        onClick={() => setNewLevelColor(color.value)}
                        style={{
                          width: "36px",
                          height: "36px",
                          backgroundColor: color.value,
                          borderRadius: "6px",
                          cursor: "pointer",
                          border:
                            newLevelColor === color.value
                              ? "3px solid #000"
                              : "2px solid #dee2e6",
                          display: "flex",
                          alignItems: "center",
                          justifyContent: "center",
                        }}
                        title={color.label}
                      >
                        {newLevelColor === color.value && (
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
                        backgroundColor: newLevelColor,
                        color: "#fff",
                        padding: "0.5rem 1rem",
                        fontSize: "0.875rem",
                      }}
                    >
                      {newLevelName || "Tên trình độ"}
                    </span>
                  </div>
                </Form.Group>
              </div>
              <div className="modal-footer">
                <Button
                  variant="secondary"
                  onClick={() => setShowAddLevelModal(false)}
                  disabled={addingLevel}
                >
                  Hủy
                </Button>
                <Button
                  variant="primary"
                  onClick={handleAddLevel}
                  disabled={addingLevel || !newLevelName.trim()}
                >
                  {addingLevel ? (
                    <>
                      <span className="spinner-border spinner-border-sm me-2"></span>
                      Đang thêm...
                    </>
                  ) : (
                    <>
                      <i className="fas fa-plus me-2"></i>
                      Thêm trình độ
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

export default EducationFormPage;
