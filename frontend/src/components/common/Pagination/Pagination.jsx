// src/components/common/Pagination/Pagination.jsx

import React from "react";
import { Pagination as BootstrapPagination } from "react-bootstrap";
import "./Pagination.css";

const Pagination = ({
  currentPage = 1,
  totalPages = 1,
  onPageChange,
  maxVisible = 5,
  showFirstLast = true,
  showPrevNext = true,
  size = "md",
  className = "",
}) => {
  if (totalPages <= 1) return null;

  const handlePageChange = (page) => {
    if (page >= 1 && page <= totalPages && page !== currentPage) {
      onPageChange(page);
    }
  };

  const getPageNumbers = () => {
    const pages = [];
    let startPage = Math.max(1, currentPage - Math.floor(maxVisible / 2));
    let endPage = Math.min(totalPages, startPage + maxVisible - 1);

    if (endPage - startPage + 1 < maxVisible) {
      startPage = Math.max(1, endPage - maxVisible + 1);
    }

    for (let i = startPage; i <= endPage; i++) {
      pages.push(i);
    }

    return pages;
  };

  const pages = getPageNumbers();

  return (
    <div
      className={`d-flex justify-content-between align-items-center py-3 px-3 ${className}`}
    >
      <small className="text-muted">
        Trang {currentPage} / {totalPages}
      </small>
      <BootstrapPagination size={size} className="mb-0">
        {/* First Page */}
        {showFirstLast && (
          <BootstrapPagination.First
            onClick={() => handlePageChange(1)}
            disabled={currentPage === 1}
          />
        )}

        {/* Previous Page */}
        {showPrevNext && (
          <BootstrapPagination.Prev
            onClick={() => handlePageChange(currentPage - 1)}
            disabled={currentPage === 1}
          />
        )}

        {/* Page Numbers */}
        {pages.map((page, index) => (
          <BootstrapPagination.Item
            key={index}
            active={page === currentPage}
            onClick={() => handlePageChange(page)}
          >
            {page}
          </BootstrapPagination.Item>
        ))}

        {/* Next Page */}
        {showPrevNext && (
          <BootstrapPagination.Next
            onClick={() => handlePageChange(currentPage + 1)}
            disabled={currentPage === totalPages}
          />
        )}

        {/* Last Page */}
        {showFirstLast && (
          <BootstrapPagination.Last
            onClick={() => handlePageChange(totalPages)}
            disabled={currentPage === totalPages}
          />
        )}
      </BootstrapPagination>
      <div style={{ width: "100px" }}></div>
    </div>
  );
};

export default Pagination;
