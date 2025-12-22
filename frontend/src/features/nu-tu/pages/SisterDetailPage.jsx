// src/features/nu-tu/pages/SisterDetailPage.jsx

import React, { useState, useEffect } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Button,
  Nav,
  Tab,
  Badge,
} from "react-bootstrap";
import { useParams, useNavigate } from "react-router-dom";
import {
  Document,
  Page,
  Text,
  View,
  StyleSheet,
  Font,
  pdf,
} from "@react-pdf/renderer";
import { sisterService } from "@services";
import { formatDate, calculateAge, resolveMediaUrl } from "@utils";
import { JOURNEY_STAGE_LABELS } from "@utils/constants";
import LoadingSpinner from "@components/common/Loading/LoadingSpinner";
import Breadcrumb from "@components/common/Breadcrumb";
import "./SisterDetailPage.css";

// Đăng ký Font Roboto hỗ trợ tiếng Việt
Font.register({
  family: "Roboto",
  fonts: [
    {
      src: "https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/fonts/Roboto/roboto-regular-webfont.ttf",
      fontWeight: "normal",
    },
    {
      src: "https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/fonts/Roboto/roboto-bold-webfont.ttf",
      fontWeight: "bold",
    },
  ],
});

// Styles cho PDF
const pdfStyles = StyleSheet.create({
  page: {
    flexDirection: "column",
    padding: 30,
    fontFamily: "Roboto",
    fontSize: 10,
  },
  header: {
    backgroundColor: "#34495e",
    padding: 15,
    marginBottom: 15,
    marginHorizontal: -30,
    marginTop: -30,
  },
  headerTitle: {
    color: "#ffffff",
    fontSize: 18,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 5,
  },
  headerSubtitle: {
    color: "#ffffff",
    fontSize: 12,
    textAlign: "center",
    marginBottom: 3,
  },
  headerDate: {
    color: "#ffffff",
    fontSize: 9,
    textAlign: "center",
  },
  basicInfoBox: {
    backgroundColor: "#ecf0f1",
    padding: 10,
    marginBottom: 15,
  },
  basicInfoName: {
    fontSize: 14,
    fontWeight: "bold",
    marginBottom: 3,
  },
  basicInfoText: {
    fontSize: 10,
    marginBottom: 2,
  },
  sectionTitle: {
    backgroundColor: "#2980b9",
    color: "#ffffff",
    padding: 6,
    fontSize: 11,
    fontWeight: "bold",
    marginBottom: 8,
    marginTop: 10,
  },
  row: {
    flexDirection: "row",
    marginBottom: 4,
  },
  label: {
    fontWeight: "bold",
    width: "35%",
    fontSize: 9,
  },
  value: {
    width: "65%",
    fontSize: 9,
  },
  twoColumnRow: {
    flexDirection: "row",
    marginBottom: 4,
  },
  column: {
    width: "50%",
    flexDirection: "row",
  },
  columnLabel: {
    fontWeight: "bold",
    width: "40%",
    fontSize: 9,
  },
  columnValue: {
    width: "60%",
    fontSize: 9,
  },
  table: {
    marginTop: 5,
  },
  tableHeader: {
    flexDirection: "row",
    backgroundColor: "#2980b9",
    padding: 5,
  },
  tableHeaderCell: {
    color: "#ffffff",
    fontSize: 8,
    fontWeight: "bold",
    textAlign: "center",
  },
  tableRow: {
    flexDirection: "row",
    borderBottomWidth: 1,
    borderBottomColor: "#ecf0f1",
    padding: 4,
  },
  tableRowAlt: {
    flexDirection: "row",
    borderBottomWidth: 1,
    borderBottomColor: "#ecf0f1",
    padding: 4,
    backgroundColor: "#f9f9f9",
  },
  tableCell: {
    fontSize: 8,
    textAlign: "center",
  },
  emptyText: {
    fontSize: 9,
    color: "#7f8c8d",
  },
  footer: {
    position: "absolute",
    bottom: 20,
    left: 30,
    right: 30,
    flexDirection: "row",
    justifyContent: "space-between",
    fontSize: 8,
    color: "#7f8c8d",
  },
  pageNumber: {
    textAlign: "center",
  },
});

const SisterDetailPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [sister, setSister] = useState(null);

  useEffect(() => {
    fetchSisterDetail();
  }, [id]);

  const fetchSisterDetail = async () => {
    try {
      setLoading(true);
      const response = await sisterService.getById(id);
      if (response.success) {
        setSister(response.data);
      }
    } catch (error) {
      console.error("Error fetching sister detail:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleEdit = () => {
    navigate(`/nu-tu/${id}/edit`);
  };

  const handleDelete = async () => {
    const name = sister.religious_name || sister.birth_name;
    if (window.confirm(`Bạn có chắc chắn muốn xóa ${name}?`)) {
      try {
        await sisterService.delete(id);
        navigate("/nu-tu");
      } catch (error) {
        console.error("Error deleting sister:", error);
      }
    }
  };

  // PDF Document Component
  const SisterPDFDocument = ({ sister }) => {
    const currentStage = getCurrentStage(sister.vocationJourney);
    const stageName = currentStage
      ? JOURNEY_STAGE_LABELS[currentStage.stage] || currentStage.stage
      : "Chưa xác định";
    const fullName = [sister.saint_name, sister.birth_name]
      .filter(Boolean)
      .join(" ");

    const eduLevelLabels = {
      doctorate: "Tiến sĩ",
      master: "Thạc sĩ",
      bachelor: "Cử nhân",
      college: "Cao đẳng",
      vocational: "Trung cấp",
      high_school: "THPT",
      certificate: "Chứng chỉ",
      other: "Khác",
    };

    const InfoRow = ({ label, value }) => (
      <View style={pdfStyles.row}>
        <Text style={pdfStyles.label}>{label}:</Text>
        <Text style={pdfStyles.value}>{value || "Chưa cập nhật"}</Text>
      </View>
    );

    const TwoColumnRow = ({ label1, value1, label2, value2 }) => (
      <View style={pdfStyles.twoColumnRow}>
        <View style={pdfStyles.column}>
          <Text style={pdfStyles.columnLabel}>{label1}:</Text>
          <Text style={pdfStyles.columnValue}>{value1 || "Chưa cập nhật"}</Text>
        </View>
        <View style={pdfStyles.column}>
          <Text style={pdfStyles.columnLabel}>{label2}:</Text>
          <Text style={pdfStyles.columnValue}>{value2 || "Chưa cập nhật"}</Text>
        </View>
      </View>
    );

    return (
      <Document>
        <Page size="A4" style={pdfStyles.page}>
          {/* Header */}
          <View style={pdfStyles.header}>
            <Text style={pdfStyles.headerTitle}>THÔNG TIN NỮ TU</Text>
            <Text style={pdfStyles.headerSubtitle}>
              Hội Dòng Thánh Phaolô Thiện Bản
            </Text>
            <Text style={pdfStyles.headerDate}>
              Ngày xuất: {formatDate(new Date())}
            </Text>
          </View>

          {/* Basic Info Box */}
          <View style={pdfStyles.basicInfoBox}>
            <Text style={pdfStyles.basicInfoName}>{fullName || "N/A"}</Text>
            <Text style={pdfStyles.basicInfoText}>
              Mã số: {sister.code || "N/A"}
            </Text>
            <Text style={pdfStyles.basicInfoText}>Giai đoạn: {stageName}</Text>
          </View>

          {/* Section 1: Thông tin cá nhân */}
          <Text style={pdfStyles.sectionTitle}>I. THÔNG TIN CÁ NHÂN</Text>
          <TwoColumnRow
            label1="Họ và tên"
            value1={sister.birth_name}
            label2="Tên thánh"
            value2={sister.saint_name}
          />
          <TwoColumnRow
            label1="Ngày sinh"
            value1={formatDate(sister.date_of_birth)}
            label2="Tuổi"
            value2={
              sister.date_of_birth
                ? `${calculateAge(sister.date_of_birth)} tuổi`
                : ""
            }
          />
          <TwoColumnRow
            label1="Nơi sinh"
            value1={sister.place_of_birth}
            label2="Quê quán"
            value2={sister.hometown}
          />
          <TwoColumnRow
            label1="Quốc tịch"
            value1={sister.nationality}
            label2="CMND/CCCD"
            value2={sister.id_card}
          />
          <TwoColumnRow
            label1="Điện thoại"
            value1={sister.phone}
            label2="Email"
            value2={sister.email}
          />
          <InfoRow
            label="Địa chỉ thường trú"
            value={sister.permanent_address}
          />
          <InfoRow label="Địa chỉ hiện tại" value={sister.current_address} />

          {/* Section 2: Thông tin gia đình */}
          <Text style={pdfStyles.sectionTitle}>II. THÔNG TIN GIA ĐÌNH</Text>
          <TwoColumnRow
            label1="Tên cha"
            value1={sister.father_name}
            label2="Nghề nghiệp cha"
            value2={sister.father_occupation}
          />
          <TwoColumnRow
            label1="Tên mẹ"
            value1={sister.mother_name}
            label2="Nghề nghiệp mẹ"
            value2={sister.mother_occupation}
          />
          <TwoColumnRow
            label1="Số anh chị em"
            value1={sister.siblings_count?.toString()}
            label2="Tôn giáo gia đình"
            value2={sister.family_religion}
          />
          <InfoRow label="Địa chỉ gia đình" value={sister.family_address} />
          <TwoColumnRow
            label1="Liên hệ khẩn cấp"
            value1={sister.emergency_contact_name}
            label2="SĐT khẩn cấp"
            value2={sister.emergency_contact_phone}
          />

          {/* Section 3: Bí tích */}
          <Text style={pdfStyles.sectionTitle}>III. BÍ TÍCH</Text>
          <TwoColumnRow
            label1="Ngày rửa tội"
            value1={formatDate(sister.baptism_date)}
            label2="Nơi rửa tội"
            value2={sister.baptism_place}
          />
          <TwoColumnRow
            label1="Ngày thêm sức"
            value1={formatDate(sister.confirmation_date)}
            label2="Ngày rước lễ lần đầu"
            value2={formatDate(sister.first_communion_date)}
          />

          {/* Footer */}
          <View style={pdfStyles.footer} fixed>
            <Text>Thông tin Nữ Tu - {sister.birth_name || "N/A"}</Text>
            <Text
              render={({ pageNumber, totalPages }) =>
                `Trang ${pageNumber}/${totalPages}`
              }
            />
          </View>
        </Page>

        {/* Page 2: Hành trình, Học vấn, Sứ vụ */}
        <Page size="A4" style={pdfStyles.page}>
          {/* Section 4: Hành trình ơn gọi */}
          <Text style={pdfStyles.sectionTitle}>IV. HÀNH TRÌNH ƠN GỌI</Text>
          {sister.vocationJourney && sister.vocationJourney.length > 0 ? (
            <View style={pdfStyles.table}>
              <View style={pdfStyles.tableHeader}>
                <Text style={[pdfStyles.tableHeaderCell, { width: "8%" }]}>
                  STT
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "22%" }]}>
                  Giai đoạn
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Bắt đầu
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Kết thúc
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "20%" }]}>
                  Cộng đoàn
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "20%" }]}>
                  Người hướng dẫn
                </Text>
              </View>
              {[...sister.vocationJourney]
                .sort((a, b) => new Date(a.start_date) - new Date(b.start_date))
                .map((j, index) => (
                  <View
                    key={j.id || index}
                    style={
                      index % 2 === 0
                        ? pdfStyles.tableRow
                        : pdfStyles.tableRowAlt
                    }
                  >
                    <Text style={[pdfStyles.tableCell, { width: "8%" }]}>
                      {index + 1}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "22%" }]}>
                      {JOURNEY_STAGE_LABELS[j.stage] || j.stage || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {formatDate(j.start_date) || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {j.end_date ? formatDate(j.end_date) : "—"}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "20%" }]}>
                      {j.community_name || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "20%" }]}>
                      {j.supervisor_name || ""}
                    </Text>
                  </View>
                ))}
            </View>
          ) : (
            <Text style={pdfStyles.emptyText}>
              Chưa có thông tin hành trình
            </Text>
          )}

          {/* Section 5: Học vấn */}
          <Text style={pdfStyles.sectionTitle}>V. HỌC VẤN</Text>
          {sister.education && sister.education.length > 0 ? (
            <View style={pdfStyles.table}>
              <View style={pdfStyles.tableHeader}>
                <Text style={[pdfStyles.tableHeaderCell, { width: "8%" }]}>
                  STT
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Trình độ
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "25%" }]}>
                  Trường
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "20%" }]}>
                  Ngành
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "16%" }]}>
                  Bắt đầu
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "16%" }]}>
                  Kết thúc
                </Text>
              </View>
              {[...sister.education]
                .sort((a, b) => new Date(a.start_date) - new Date(b.start_date))
                .map((e, index) => (
                  <View
                    key={e.id || index}
                    style={
                      index % 2 === 0
                        ? pdfStyles.tableRow
                        : pdfStyles.tableRowAlt
                    }
                  >
                    <Text style={[pdfStyles.tableCell, { width: "8%" }]}>
                      {index + 1}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {eduLevelLabels[e.level] || e.level || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "25%" }]}>
                      {e.institution || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "20%" }]}>
                      {e.major || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "16%" }]}>
                      {formatDate(e.start_date) || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "16%" }]}>
                      {e.end_date ? formatDate(e.end_date) : "—"}
                    </Text>
                  </View>
                ))}
            </View>
          ) : (
            <Text style={pdfStyles.emptyText}>Chưa có thông tin học vấn</Text>
          )}

          {/* Section 6: Sứ vụ */}
          <Text style={pdfStyles.sectionTitle}>VI. SỨ VỤ</Text>
          {sister.missions && sister.missions.length > 0 ? (
            <View style={pdfStyles.table}>
              <View style={pdfStyles.tableHeader}>
                <Text style={[pdfStyles.tableHeaderCell, { width: "8%" }]}>
                  STT
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "22%" }]}>
                  Chức vụ
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "25%" }]}>
                  Tổ chức
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Loại
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Bắt đầu
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Kết thúc
                </Text>
              </View>
              {[...sister.missions]
                .sort((a, b) => new Date(a.start_date) - new Date(b.start_date))
                .map((m, index) => (
                  <View
                    key={m.id || index}
                    style={
                      index % 2 === 0
                        ? pdfStyles.tableRow
                        : pdfStyles.tableRowAlt
                    }
                  >
                    <Text style={[pdfStyles.tableCell, { width: "8%" }]}>
                      {index + 1}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "22%" }]}>
                      {m.position || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "25%" }]}>
                      {m.organization || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {m.type || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {formatDate(m.start_date) || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {m.end_date ? formatDate(m.end_date) : "—"}
                    </Text>
                  </View>
                ))}
            </View>
          ) : (
            <Text style={pdfStyles.emptyText}>Chưa có thông tin sứ vụ</Text>
          )}

          {/* Footer */}
          <View style={pdfStyles.footer} fixed>
            <Text>Thông tin Nữ Tu - {sister.birth_name || "N/A"}</Text>
            <Text
              render={({ pageNumber, totalPages }) =>
                `Trang ${pageNumber}/${totalPages}`
              }
            />
          </View>
        </Page>

        {/* Page 3: Sức khỏe, Đánh giá, Ghi chú */}
        <Page size="A4" style={pdfStyles.page}>
          {/* Section 7: Sức khỏe */}
          <Text style={pdfStyles.sectionTitle}>VII. SỨC KHỎE</Text>
          {sister.health_records && sister.health_records.length > 0 ? (
            <View style={pdfStyles.table}>
              <View style={pdfStyles.tableHeader}>
                <Text style={[pdfStyles.tableHeaderCell, { width: "8%" }]}>
                  STT
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Ngày khám
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "20%" }]}>
                  Cơ sở
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "15%" }]}>
                  Tình trạng
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "22%" }]}>
                  Chẩn đoán
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "20%" }]}>
                  Bác sĩ
                </Text>
              </View>
              {[...sister.health_records]
                .sort((a, b) => new Date(b.check_date) - new Date(a.check_date))
                .slice(0, 5)
                .map((h, index) => (
                  <View
                    key={h.id || index}
                    style={
                      index % 2 === 0
                        ? pdfStyles.tableRow
                        : pdfStyles.tableRowAlt
                    }
                  >
                    <Text style={[pdfStyles.tableCell, { width: "8%" }]}>
                      {index + 1}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {formatDate(h.check_date) || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "20%" }]}>
                      {h.facility || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "15%" }]}>
                      {h.health_status || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "22%" }]}>
                      {h.diagnosis || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "20%" }]}>
                      {h.doctor || ""}
                    </Text>
                  </View>
                ))}
            </View>
          ) : (
            <Text style={pdfStyles.emptyText}>Chưa có hồ sơ sức khỏe</Text>
          )}

          {/* Section 8: Đánh giá */}
          <Text style={pdfStyles.sectionTitle}>VIII. ĐÁNH GIÁ</Text>
          {sister.evaluations && sister.evaluations.length > 0 ? (
            <View style={pdfStyles.table}>
              <View style={pdfStyles.tableHeader}>
                <Text style={[pdfStyles.tableHeaderCell, { width: "8%" }]}>
                  STT
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "25%" }]}>
                  Kỳ đánh giá
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "17%" }]}>
                  Ngày
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "30%" }]}>
                  Người đánh giá
                </Text>
                <Text style={[pdfStyles.tableHeaderCell, { width: "20%" }]}>
                  Điểm
                </Text>
              </View>
              {[...sister.evaluations]
                .sort(
                  (a, b) =>
                    new Date(b.evaluation_date || b.created_at) -
                    new Date(a.evaluation_date || a.created_at)
                )
                .slice(0, 5)
                .map((e, index) => (
                  <View
                    key={e.id || index}
                    style={
                      index % 2 === 0
                        ? pdfStyles.tableRow
                        : pdfStyles.tableRowAlt
                    }
                  >
                    <Text style={[pdfStyles.tableCell, { width: "8%" }]}>
                      {index + 1}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "25%" }]}>
                      {e.period || e.evaluation_type || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "17%" }]}>
                      {formatDate(e.evaluation_date) || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "30%" }]}>
                      {e.evaluator_name || ""}
                    </Text>
                    <Text style={[pdfStyles.tableCell, { width: "20%" }]}>
                      {e.overall_rating ? `${e.overall_rating}/100` : ""}
                    </Text>
                  </View>
                ))}
            </View>
          ) : (
            <Text style={pdfStyles.emptyText}>Chưa có đánh giá</Text>
          )}

          {/* Section 9: Ghi chú */}
          {sister.notes && (
            <>
              <Text style={pdfStyles.sectionTitle}>IX. GHI CHÚ</Text>
              <Text style={{ fontSize: 9 }}>{sister.notes}</Text>
            </>
          )}

          {/* Footer */}
          <View style={pdfStyles.footer} fixed>
            <Text>Thông tin Nữ Tu - {sister.birth_name || "N/A"}</Text>
            <Text
              render={({ pageNumber, totalPages }) =>
                `Trang ${pageNumber}/${totalPages}`
              }
            />
          </View>
        </Page>
      </Document>
    );
  };

  // Export PDF function
  const handleExportPDF = async () => {
    try {
      const blob = await pdf(<SisterPDFDocument sister={sister} />).toBlob();
      const url = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = url;
      link.download = `ThongTinNuTu_${(sister.birth_name || "NuTu").replace(
        /\s+/g,
        "_"
      )}_${new Date().toISOString().split("T")[0]}.pdf`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      URL.revokeObjectURL(url);
    } catch (error) {
      console.error("Error generating PDF:", error);
      alert("Có lỗi khi tạo file PDF. Vui lòng thử lại.");
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

  if (!sister) {
    return (
      <Container className="py-4">
        <div className="text-center">
          <h3>Không tìm thấy thông tin nữ tu</h3>
          <Button variant="primary" onClick={() => navigate("/nu-tu")}>
            Quay lại danh sách
          </Button>
        </div>
      </Container>
    );
  }

  const avatarUrl = resolveMediaUrl(sister.photo_url || sister.avatar_url);

  return (
    <Container fluid className="py-4">
      {/* Breadcrumb */}
      <Breadcrumb
        title="Thông tin Nữ Tu"
        items={[
          { label: "Quản lý Nữ Tu", link: "/nu-tu" },
          { label: sister.religious_name || sister.birth_name },
        ]}
      />

      {/* Action Buttons */}
      <div className="d-flex justify-content-end align-items-center mb-4">
        <div className="action-buttons">
          <Button variant="primary" onClick={handleExportPDF}>
            <i className="fas fa-file-pdf me-2"></i>
            Xuất PDF
          </Button>
          <Button variant="success" onClick={handleEdit}>
            <i className="fas fa-edit me-2"></i>
            Chỉnh sửa
          </Button>
          <Button variant="danger" onClick={handleDelete}>
            <i className="fas fa-trash me-2"></i>
            Xóa
          </Button>
          <Button variant="secondary" onClick={() => navigate("/nu-tu")}>
            <i className="fas fa-arrow-left me-2"></i>
            Quay lại
          </Button>
        </div>
      </div>

      <Tab.Container defaultActiveKey="basic">
        <Row className="g-4">
          {/* Left Column - Avatar & Navigation */}
          <Col lg={3}>
            {/* Avatar Card */}
            <Card className="health-info-card">
              <Card.Header className="documents-header">
                <i className="fas fa-user-circle"></i>
                <span>Hồ sơ</span>
              </Card.Header>
              <Card.Body className="text-center">
                <div className="avatar-section">
                  <div className="avatar-large">
                    {avatarUrl ? (
                      <img
                        src={avatarUrl}
                        alt={sister.religious_name || sister.birth_name}
                      />
                    ) : (
                      <div className="avatar-placeholder-large">
                        <i className="fas fa-user"></i>
                      </div>
                    )}
                  </div>

                  <div className="name-display">
                    {sister.religious_name && (
                      <div className="religious-name">
                        {sister.religious_name}
                      </div>
                    )}
                    <div className="birth-name">{sister.birth_name}</div>
                    <div className="code">
                      <i className="fas fa-id-card me-2"></i>
                      {sister.code}
                    </div>
                  </div>

                  <div className="mt-3">
                    {(() => {
                      const currentStage = getCurrentStage(
                        sister.vocationJourney
                      );
                      const stageName = currentStage
                        ? JOURNEY_STAGE_LABELS[currentStage.stage] ||
                          currentStage.stage
                        : "Chưa xác định";
                      return (
                        <Badge bg="primary" className="mb-2">
                          <i className="fas fa-route me-1"></i>
                          {stageName}
                        </Badge>
                      );
                    })()}
                  </div>
                </div>
              </Card.Body>
            </Card>

            {/* Quick Info Card */}
            <Card className="health-info-card">
              <Card.Header className="system-header">
                <i className="fas fa-info-circle"></i>
                <span>Thông tin nhanh</span>
              </Card.Header>
              <Card.Body className="p-2">
                <div className="quick-info">
                  <div className="quick-info-item">
                    <i className="fas fa-birthday-cake text-primary"></i>
                    <div className="info-content">
                      <small className="text-muted">Ngày sinh</small>
                      <div className="fw-semibold">
                        {formatDate(sister.date_of_birth)}
                      </div>
                      <small className="text-muted">
                        ({calculateAge(sister.date_of_birth)} tuổi)
                      </small>
                    </div>
                  </div>

                  <div className="quick-info-item">
                    <i className="fas fa-home text-success"></i>
                    <div className="info-content">
                      <small className="text-muted">Cộng đoàn</small>
                      <div className="fw-semibold">
                        {(() => {
                          const currentStage = getCurrentStage(
                            sister.vocationJourney
                          );
                          return (
                            currentStage?.community_name ||
                            sister.current_community_name ||
                            "-"
                          );
                        })()}
                      </div>
                    </div>
                  </div>

                  <div className="quick-info-item">
                    <i className="fas fa-phone text-info"></i>
                    <div className="info-content">
                      <small className="text-muted">Điện thoại</small>
                      <div className="fw-semibold">{sister.phone || "-"}</div>
                    </div>
                  </div>

                  <div className="quick-info-item">
                    <i className="fas fa-envelope text-warning"></i>
                    <div className="info-content">
                      <small className="text-muted">Email</small>
                      <div className="fw-semibold">{sister.email || "-"}</div>
                    </div>
                  </div>
                </div>
              </Card.Body>
            </Card>
          </Col>

          {/* Right Column - Content */}
          <Col lg={9}>
            {/* Navigation Tabs */}
            <Card className="health-info-card mb-3">
              <Card.Body className="p-2">
                <Nav variant="pills" className="nav-horizontal-tabs">
                  <Nav.Link eventKey="basic">
                    <i className="fas fa-user"></i>
                    Thông tin cơ bản
                  </Nav.Link>
                  <Nav.Link eventKey="journey">
                    <i className="fas fa-route"></i>
                    Hành trình
                  </Nav.Link>
                  <Nav.Link eventKey="education">
                    <i className="fas fa-graduation-cap"></i>
                    Học vấn
                  </Nav.Link>
                  <Nav.Link eventKey="mission">
                    <i className="fas fa-briefcase"></i>
                    Sứ vụ
                  </Nav.Link>
                  <Nav.Link eventKey="health">
                    <i className="fas fa-heartbeat"></i>
                    Sức khỏe
                  </Nav.Link>
                  <Nav.Link eventKey="evaluation">
                    <i className="fas fa-clipboard-check"></i>
                    Đánh giá
                  </Nav.Link>
                </Nav>
              </Card.Body>
            </Card>

            {/* Content Card */}
            <Card className="health-info-card">
              <Card.Header>
                <i className="fas fa-info-circle"></i>
                <span>Chi tiết thông tin</span>
              </Card.Header>
              <Card.Body>
                <Tab.Content>
                  {/* Basic Info Tab */}
                  <Tab.Pane eventKey="basic">
                    <div className="info-section">
                      <h5>
                        <i className="fas fa-user"></i>
                        Thông tin cá nhân
                      </h5>
                      <Row className="g-3">
                        <Col md={6}>
                          <InfoItem
                            label="Họ và tên khai sinh"
                            value={sister.birth_name}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Tên thánh"
                            value={sister.saint_name}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Cộng đoàn hiện tại"
                            value={(() => {
                              // Lấy cộng đoàn từ vocationJourney (giai đoạn gần nhất)
                              const currentStage = getCurrentStage(
                                sister.vocationJourney
                              );
                              return (
                                currentStage?.community_name ||
                                sister.current_community_name
                              );
                            })()}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Giai đoạn hiện tại"
                            value={(() => {
                              const currentStage = getCurrentStage(
                                sister.vocationJourney
                              );
                              return currentStage
                                ? JOURNEY_STAGE_LABELS[currentStage.stage] ||
                                    currentStage.stage
                                : "Chưa xác định";
                            })()}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="Mã số" value={sister.code} />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Ngày sinh"
                            value={formatDate(sister.date_of_birth)}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Nơi sinh"
                            value={sister.place_of_birth}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="Quê quán" value={sister.hometown} />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Quốc tịch"
                            value={sister.nationality}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="CMND/CCCD" value={sister.id_card} />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="Điện thoại" value={sister.phone} />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="Email" value={sister.email} />
                        </Col>
                        <Col md={12}>
                          <InfoItem
                            label="Địa chỉ thường trú"
                            value={sister.permanent_address}
                          />
                        </Col>
                        <Col md={12}>
                          <InfoItem
                            label="Địa chỉ hiện tại"
                            value={sister.current_address}
                          />
                        </Col>
                      </Row>
                    </div>

                    <div className="info-section">
                      <h5>
                        <i className="fas fa-users"></i>
                        Thông tin gia đình
                      </h5>
                      <Row className="g-3">
                        <Col md={6}>
                          <InfoItem
                            label="Tên cha"
                            value={sister.father_name}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Nghề nghiệp cha"
                            value={sister.father_occupation}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem label="Tên mẹ" value={sister.mother_name} />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Nghề nghiệp mẹ"
                            value={sister.mother_occupation}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Số anh chị em"
                            value={sister.siblings_count}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Tôn giáo gia đình"
                            value={sister.family_religion}
                          />
                        </Col>
                        <Col md={12}>
                          <InfoItem
                            label="Địa chỉ gia đình"
                            value={sister.family_address}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Người liên hệ khẩn cấp"
                            value={sister.emergency_contact_name}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="SĐT liên hệ khẩn cấp"
                            value={sister.emergency_contact_phone}
                          />
                        </Col>
                      </Row>
                    </div>

                    <div className="info-section">
                      <h5>
                        <i className="fas fa-church"></i>
                        Bí tích
                      </h5>
                      <Row className="g-3">
                        <Col md={6}>
                          <InfoItem
                            label="Ngày rửa tội"
                            value={formatDate(sister.baptism_date)}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Nơi rửa tội"
                            value={sister.baptism_place}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Ngày thêm sức"
                            value={formatDate(sister.confirmation_date)}
                          />
                        </Col>
                        <Col md={6}>
                          <InfoItem
                            label="Ngày rước lễ lần đầu"
                            value={formatDate(sister.first_communion_date)}
                          />
                        </Col>
                      </Row>
                    </div>

                    {/* Tài liệu đính kèm */}
                    <div className="info-section">
                      <h5>
                        <i className="fas fa-file-alt"></i>
                        Tài liệu đính kèm
                      </h5>
                      <Row className="g-3">
                        <Col md={12}>
                          {(() => {
                            // Parse documents - could be array, JSON string, or null
                            let docs = [];
                            if (Array.isArray(sister.documents)) {
                              docs = sister.documents;
                            } else if (
                              typeof sister.documents === "string" &&
                              sister.documents
                            ) {
                              try {
                                docs = JSON.parse(sister.documents);
                              } catch (e) {
                                docs = [];
                              }
                            } else if (sister.documents_url) {
                              try {
                                docs = JSON.parse(sister.documents_url);
                              } catch (e) {
                                docs = [];
                              }
                            }

                            if (docs && docs.length > 0) {
                              return (
                                <div className="document-list">
                                  {docs.map((doc, index) => (
                                    <div
                                      key={index}
                                      className="document-item d-flex align-items-center p-2 border rounded mb-2"
                                    >
                                      <i className="fas fa-file me-2 text-primary"></i>
                                      <a
                                        href={doc.url}
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        className="text-decoration-none"
                                      >
                                        {doc.name || `Tài liệu ${index + 1}`}
                                      </a>
                                      {doc.uploadedAt && (
                                        <small className="text-muted ms-auto">
                                          {formatDate(doc.uploadedAt)}
                                        </small>
                                      )}
                                    </div>
                                  ))}
                                </div>
                              );
                            }
                            return (
                              <p className="text-muted">
                                Chưa có tài liệu đính kèm
                              </p>
                            );
                          })()}
                        </Col>
                      </Row>
                    </div>

                    {/* Ghi chú */}
                    <div className="info-section">
                      <h5>
                        <i className="fas fa-sticky-note"></i>
                        Ghi chú
                      </h5>
                      <Row className="g-3">
                        <Col md={12}>
                          {sister.notes ? (
                            <div
                              className="p-3 bg-light rounded"
                              style={{ whiteSpace: "pre-wrap" }}
                            >
                              {sister.notes}
                            </div>
                          ) : (
                            <p className="text-muted">Chưa có ghi chú</p>
                          )}
                        </Col>
                      </Row>
                    </div>
                  </Tab.Pane>

                  {/* Journey Tab */}
                  <Tab.Pane eventKey="journey">
                    <div className="d-flex justify-content-between align-items-center mb-3">
                      <h5 className="mb-0">Hành trình Ơn Gọi</h5>
                      <Button
                        variant="outline-primary"
                        size="sm"
                        onClick={() => navigate(`/nu-tu/${id}/hanh-trinh`)}
                      >
                        <i className="fas fa-external-link-alt me-2"></i>
                        Xem chi tiết Timeline
                      </Button>
                    </div>
                    <div className="timeline">
                      {sister.vocationJourney &&
                      sister.vocationJourney.length > 0 ? (
                        [...sister.vocationJourney]
                          .sort(
                            (a, b) =>
                              new Date(a.start_date) - new Date(b.start_date)
                          )
                          .map((journey, index) => (
                            <div
                              key={journey.id || index}
                              className="timeline-item"
                            >
                              <div className="timeline-marker"></div>
                              <div className="timeline-content">
                                <div className="d-flex justify-content-between align-items-start mb-2">
                                  <div>
                                    <h6 className="mb-1">
                                      {JOURNEY_STAGE_LABELS[journey.stage] ||
                                        journey.stage}
                                    </h6>
                                    <small className="text-muted">
                                      {formatDate(journey.start_date)}
                                      {journey.end_date &&
                                        ` - ${formatDate(journey.end_date)}`}
                                      {!journey.end_date && " —"}
                                    </small>
                                  </div>
                                  {journey.community_name && (
                                    <Badge bg="primary">
                                      {journey.community_name}
                                    </Badge>
                                  )}
                                </div>
                                {journey.supervisor_name && (
                                  <p className="mb-1 small">
                                    <i className="fas fa-user-tie me-1"></i>
                                    Người hướng dẫn: {journey.supervisor_name}
                                  </p>
                                )}
                                {journey.notes && (
                                  <p className="mb-0 text-muted small">
                                    {journey.notes}
                                  </p>
                                )}
                              </div>
                            </div>
                          ))
                      ) : (
                        <p className="text-muted">
                          Chưa có thông tin hành trình
                        </p>
                      )}
                    </div>
                  </Tab.Pane>

                  {/* Education Tab */}
                  <Tab.Pane eventKey="education">
                    <div className="d-flex justify-content-between align-items-center mb-3">
                      <h5 className="mb-0">Học vấn</h5>
                      <Button
                        variant="outline-primary"
                        size="sm"
                        onClick={() => navigate(`/hoc-van/timeline/${id}`)}
                      >
                        <i className="fas fa-external-link-alt me-2"></i>
                        Xem chi tiết Timeline
                      </Button>
                    </div>
                    <div className="timeline">
                      {sister.education && sister.education.length > 0 ? (
                        [...sister.education]
                          .sort(
                            (a, b) =>
                              new Date(a.start_date) - new Date(b.start_date)
                          )
                          .map((edu, index) => (
                            <div
                              key={edu.id || index}
                              className="timeline-item"
                            >
                              <div className="timeline-marker"></div>
                              <div className="timeline-content">
                                <div className="d-flex justify-content-between align-items-start mb-2">
                                  <div>
                                    <h6 className="mb-1">
                                      {edu.level === "doctorate" && "Tiến sĩ"}
                                      {edu.level === "master" && "Thạc sĩ"}
                                      {edu.level === "bachelor" && "Cử nhân"}
                                      {edu.level === "associate" && "Cao đẳng"}
                                      {edu.level === "vocational" &&
                                        "Trung cấp"}
                                      {edu.level === "high_school" && "THPT"}
                                      {edu.level === "certificate" &&
                                        "Chứng chỉ"}
                                      {edu.level === "other" && "Khác"}
                                      {![
                                        "doctorate",
                                        "master",
                                        "bachelor",
                                        "associate",
                                        "vocational",
                                        "high_school",
                                        "certificate",
                                        "other",
                                      ].includes(edu.level) && edu.level}
                                    </h6>
                                    <small className="text-muted">
                                      {formatDate(edu.start_date)}
                                      {edu.end_date
                                        ? ` - ${formatDate(edu.end_date)}`
                                        : " - Hiện tại"}
                                    </small>
                                  </div>
                                  <Badge
                                    bg={
                                      edu.status === "da_tot_nghiep"
                                        ? "success"
                                        : edu.status === "dang_hoc"
                                        ? "info"
                                        : "secondary"
                                    }
                                  >
                                    {edu.status === "da_tot_nghiep" &&
                                      "Đã tốt nghiệp"}
                                    {edu.status === "dang_hoc" && "Đang học"}
                                    {edu.status === "tam_nghi" && "Tạm nghỉ"}
                                    {edu.status === "da_nghi" && "Đã nghỉ"}
                                    {![
                                      "da_tot_nghiep",
                                      "dang_hoc",
                                      "tam_nghi",
                                      "da_nghi",
                                    ].includes(edu.status) &&
                                      (edu.graduation_year || "Đang học")}
                                  </Badge>
                                </div>
                                <p className="mb-1">
                                  <i className="fas fa-university me-1"></i>
                                  {edu.institution}
                                </p>
                                {edu.major && (
                                  <p className="mb-1 small">
                                    <i className="fas fa-book me-1"></i>
                                    Chuyên ngành: {edu.major}
                                  </p>
                                )}
                                {edu.gpa && (
                                  <p className="mb-0 small text-muted">
                                    GPA: <strong>{edu.gpa}</strong>
                                  </p>
                                )}
                              </div>
                            </div>
                          ))
                      ) : (
                        <p className="text-muted">Chưa có thông tin học vấn</p>
                      )}
                    </div>
                  </Tab.Pane>

                  {/* Mission Tab */}
                  <Tab.Pane eventKey="mission">
                    <div className="d-flex justify-content-between align-items-center mb-3">
                      <h5 className="mb-0">Sứ vụ</h5>
                      <Button
                        variant="outline-primary"
                        size="sm"
                        onClick={() => navigate(`/su-vu/timeline/${id}`)}
                      >
                        <i className="fas fa-external-link-alt me-2"></i>
                        Xem chi tiết Timeline
                      </Button>
                    </div>
                    <div className="timeline">
                      {sister.missions && sister.missions.length > 0 ? (
                        [...sister.missions]
                          .sort(
                            (a, b) =>
                              new Date(a.start_date) - new Date(b.start_date)
                          )
                          .map((mission, index) => (
                            <div
                              key={mission.id || index}
                              className="timeline-item"
                            >
                              <div className="timeline-marker"></div>
                              <div className="timeline-content">
                                <div className="d-flex justify-content-between align-items-start mb-2">
                                  <div>
                                    <h6 className="mb-1">{mission.position}</h6>
                                    <small className="text-muted">
                                      {formatDate(mission.start_date)}
                                      {mission.end_date
                                        ? ` - ${formatDate(mission.end_date)}`
                                        : " —"}
                                    </small>
                                  </div>
                                  {mission.type && (
                                    <Badge bg="success">{mission.type}</Badge>
                                  )}
                                </div>
                                <p className="mb-1">
                                  <i className="fas fa-building me-1"></i>
                                  {mission.organization}
                                </p>
                                {mission.description && (
                                  <p className="mb-0 text-muted small">
                                    {mission.description}
                                  </p>
                                )}
                              </div>
                            </div>
                          ))
                      ) : (
                        <p className="text-muted">Chưa có thông tin sứ vụ</p>
                      )}
                    </div>
                  </Tab.Pane>

                  {/* Evaluation Tab */}
                  <Tab.Pane eventKey="evaluation">
                    <div className="d-flex justify-content-between align-items-center mb-3">
                      <h5 className="mb-0">Đánh giá</h5>
                      <Button
                        variant="outline-primary"
                        size="sm"
                        onClick={() => navigate(`/danh-gia/timeline/${id}`)}
                      >
                        <i className="fas fa-external-link-alt me-2"></i>
                        Xem chi tiết Timeline
                      </Button>
                    </div>
                    <div className="timeline">
                      {sister.evaluations && sister.evaluations.length > 0 ? (
                        [...sister.evaluations]
                          .sort(
                            (a, b) =>
                              new Date(b.evaluation_date || b.created_at) -
                              new Date(a.evaluation_date || a.created_at)
                          )
                          .map((evaluation, index) => (
                            <div
                              key={evaluation.id || index}
                              className="timeline-item"
                            >
                              <div className="timeline-marker"></div>
                              <div className="timeline-content">
                                <div className="d-flex justify-content-between align-items-start mb-2">
                                  <div>
                                    <h6 className="mb-1">
                                      {evaluation.period ||
                                        evaluation.evaluation_type ||
                                        "Đánh giá"}
                                    </h6>
                                    <small className="text-muted">
                                      {formatDate(evaluation.evaluation_date)}
                                    </small>
                                  </div>
                                  {evaluation.overall_rating && (
                                    <Badge
                                      bg={
                                        evaluation.overall_rating >= 90
                                          ? "success"
                                          : evaluation.overall_rating >= 75
                                          ? "info"
                                          : evaluation.overall_rating >= 60
                                          ? "warning"
                                          : "danger"
                                      }
                                    >
                                      <i className="fas fa-star me-1"></i>
                                      {evaluation.overall_rating}/100
                                    </Badge>
                                  )}
                                </div>
                                {evaluation.evaluator_name && (
                                  <p className="mb-1 small">
                                    <i className="fas fa-user-tie me-1"></i>
                                    Người đánh giá: {evaluation.evaluator_name}
                                  </p>
                                )}
                                {evaluation.strengths && (
                                  <p className="mb-1 small">
                                    <i className="fas fa-plus-circle text-success me-1"></i>
                                    {evaluation.strengths}
                                  </p>
                                )}
                                {evaluation.weaknesses && (
                                  <p className="mb-0 text-muted small">
                                    <i className="fas fa-minus-circle text-danger me-1"></i>
                                    {evaluation.weaknesses}
                                  </p>
                                )}
                              </div>
                            </div>
                          ))
                      ) : (
                        <p className="text-muted">Chưa có đánh giá</p>
                      )}
                    </div>
                  </Tab.Pane>

                  {/* Health Tab */}
                  <Tab.Pane eventKey="health">
                    <div className="d-flex justify-content-between align-items-center mb-3">
                      <h5 className="mb-0">Sức khỏe</h5>
                      <Button
                        variant="outline-primary"
                        size="sm"
                        onClick={() => navigate(`/suc-khoe/timeline/${id}`)}
                      >
                        <i className="fas fa-external-link-alt me-2"></i>
                        Xem chi tiết Timeline
                      </Button>
                    </div>
                    <div className="timeline">
                      {sister.health_records &&
                      sister.health_records.length > 0 ? (
                        [...sister.health_records]
                          .sort(
                            (a, b) =>
                              new Date(b.check_date) - new Date(a.check_date)
                          )
                          .map((record, index) => (
                            <div
                              key={record.id || index}
                              className="timeline-item"
                            >
                              <div className="timeline-marker"></div>
                              <div className="timeline-content">
                                <div className="d-flex justify-content-between align-items-start mb-2">
                                  <div>
                                    <h6 className="mb-1">
                                      Khám ngày {formatDate(record.check_date)}
                                    </h6>
                                    <small className="text-muted">
                                      {record.facility}
                                    </small>
                                  </div>
                                  <Badge
                                    bg={getHealthStatusColor(
                                      record.health_status
                                    )}
                                  >
                                    {record.health_status}
                                  </Badge>
                                </div>
                                {record.doctor && (
                                  <p className="mb-1 small">
                                    <i className="fas fa-user-md me-1"></i>
                                    Bác sĩ: {record.doctor}
                                  </p>
                                )}
                                {record.diagnosis && (
                                  <p className="mb-1 small">
                                    <strong>Chẩn đoán:</strong>{" "}
                                    {record.diagnosis}
                                  </p>
                                )}
                                {record.treatment && (
                                  <p className="mb-0 text-muted small">
                                    <strong>Điều trị:</strong>{" "}
                                    {record.treatment}
                                  </p>
                                )}
                              </div>
                            </div>
                          ))
                      ) : (
                        <p className="text-muted">Chưa có hồ sơ sức khỏe</p>
                      )}
                    </div>
                  </Tab.Pane>
                </Tab.Content>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Tab.Container>
    </Container>
  );
};

// Helper Component
const InfoItem = ({ label, value }) => (
  <div className="info-item">
    <label>{label}</label>
    <div className={`value ${!value || value === "-" ? "empty" : ""}`}>
      {value || "Chưa cập nhật"}
    </div>
  </div>
);

// Helper Functions
const getHealthStatusColor = (status) => {
  const colors = {
    excellent: "success",
    good: "info",
    fair: "warning",
    poor: "danger",
  };
  return colors[status] || "secondary";
};

// Lấy giai đoạn hiện tại từ hành trình ơn gọi (gần nhất)
const getCurrentStage = (vocationJourney) => {
  if (!vocationJourney || vocationJourney.length === 0) return null;
  // Sắp xếp theo thời gian giảm dần và lấy giai đoạn hiện tại (chưa có end_date hoặc gần nhất)
  const sorted = [...vocationJourney].sort(
    (a, b) => new Date(b.start_date) - new Date(a.start_date)
  );
  // Ưu tiên giai đoạn chưa kết thúc
  const current = sorted.find((j) => !j.end_date);
  return current || sorted[0];
};

export default SisterDetailPage;
