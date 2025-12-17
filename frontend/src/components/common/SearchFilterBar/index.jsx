import React from "react";
import { Row, Col, Form, Button } from "react-bootstrap";
import PropTypes from "prop-types";

const SearchFilterBar = ({
  searchValue,
  onSearchChange,
  searchPlaceholder = "Tìm kiếm...",
  onReset,
  children,
}) => {
  return (
    <Row className="g-3 mb-4">
      <Col md={8}>
        <Form.Control
          type="text"
          placeholder={searchPlaceholder}
          value={searchValue}
          onChange={(e) => onSearchChange(e.target.value)}
        />
      </Col>
      {onReset && (
        <Col md={4}>
          <Button variant="outline-secondary" onClick={onReset}>
            <i className="fas fa-redo me-2"></i>
            Đặt lại
          </Button>
        </Col>
      )}
      {children}
    </Row>
  );
};

SearchFilterBar.propTypes = {
  searchValue: PropTypes.string.isRequired,
  onSearchChange: PropTypes.func.isRequired,
  searchPlaceholder: PropTypes.string,
  onReset: PropTypes.func,
  children: PropTypes.node,
};

export default SearchFilterBar;
