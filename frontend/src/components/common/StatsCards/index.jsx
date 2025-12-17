import React from "react";
import { Row, Col, Card } from "react-bootstrap";
import PropTypes from "prop-types";

const StatsCards = ({ stats }) => {
  return (
    <Row className="g-3 mb-4">
      {stats.map((stat, index) => (
        <Col key={index} xs={6} md={3}>
          <Card className="stat-card">
            <Card.Body>
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <small className="text-muted">{stat.label}</small>
                  <h4 className="mb-0">{stat.value}</h4>
                </div>
                <div className={`stat-icon bg-${stat.color}`}>
                  <i className={stat.icon}></i>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
      ))}
    </Row>
  );
};

StatsCards.propTypes = {
  stats: PropTypes.arrayOf(
    PropTypes.shape({
      label: PropTypes.string.isRequired,
      value: PropTypes.oneOfType([PropTypes.string, PropTypes.number])
        .isRequired,
      icon: PropTypes.string.isRequired,
      color: PropTypes.string.isRequired,
    })
  ).isRequired,
};

export default StatsCards;
