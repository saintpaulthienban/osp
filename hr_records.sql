-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2025 at 03:20 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hr_records`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `record_id` bigint(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `old_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_value`)),
  `new_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_value`)),
  `ip_address` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `description`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(1, 1, 'UPDATE', 'sisters', 19, NULL, '{\"id\":19,\"code\":\"SR019\",\"saint_name\":\"Rita\",\"birth_name\":\"Lương Thị Oanh\",\"date_of_birth\":\"2006-12-07T17:00:00.000Z\",\"place_of_birth\":\"Kon Tum\",\"permanent_address\":null,\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":\"Lương Văn Đức\",\"father_occupation\":null,\"mother_name\":\"H\'Bơr Thị Liên\",\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":\"Công giáo\",\"baptism_date\":\"2007-01-05T17:00:00.000Z\",\"baptism_place\":\"Nhà thờ Kon Tum\",\"confirmation_date\":\"2017-06-10T17:00:00.000Z\",\"first_communion_date\":\"2013-05-25T17:00:00.000Z\",\"phone\":\"0909912345\",\"email\":\"sr.rita.oanh@saintpaul.vn\",\"emergency_contact_name\":\"Lương Văn Tâm (anh trai)\",\"emergency_contact_phone\":\"0900987654\",\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":null,\"created_at\":\"2025-12-20T02:44:35.000Z\",\"updated_at\":null,\"documents\":null}', '{\"id\":19,\"code\":\"SR019\",\"saint_name\":\"Rita\",\"birth_name\":\"Lương Thị Oanh\",\"date_of_birth\":\"2006-12-06T17:00:00.000Z\",\"place_of_birth\":\"Kon Tum\",\"permanent_address\":\"Tây Ninh\",\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":\"Lương Văn Đức\",\"father_occupation\":null,\"mother_name\":\"H\'Bơr Thị Liên\",\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":\"Công giáo\",\"baptism_date\":\"2007-01-04T17:00:00.000Z\",\"baptism_place\":\"Nhà thờ Kon Tum\",\"confirmation_date\":\"2017-06-09T17:00:00.000Z\",\"first_communion_date\":\"2013-05-24T17:00:00.000Z\",\"phone\":\"0909912345\",\"email\":\"sr.rita.oanh@saintpaul.vn\",\"emergency_contact_name\":\"Lương Văn Tâm (anh trai)\",\"emergency_contact_phone\":\"0900987654\",\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":null,\"created_at\":\"2025-12-20T02:44:35.000Z\",\"updated_at\":\"2025-12-20T03:52:46.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-20 03:52:46'),
(2, 1, 'update', 'sisters', 1, NULL, '{\"full_name\":\"Nguyễn Thị Mai\",\"christian_name\":\"Maria\",\"current_stage\":\"postulancy\",\"phone\":\"0901234567\"}', '{\"full_name\":\"Nguyễn Thị Mai\",\"christian_name\":\"Maria\",\"current_stage\":\"novitiate\",\"phone\":\"0909876543\"}', NULL, '2025-12-20 00:17:10'),
(3, 1, 'create', 'sisters', 2, NULL, NULL, '{\"full_name\":\"Trần Thị Lan\",\"christian_name\":\"Teresa\",\"date_of_birth\":\"1998-05-15\",\"current_stage\":\"inquiry\",\"status\":\"active\"}', NULL, '2025-12-19 20:12:10'),
(4, 1, 'update', 'health_records', 1, NULL, '{\"diagnosis\":\"Đau đầu nhẹ\",\"status\":\"pending\"}', '{\"diagnosis\":\"Đau đầu nhẹ - Đã khám\",\"status\":\"completed\",\"treatment\":\"Paracetamol 500mg\"}', NULL, '2025-12-20 03:36:10'),
(5, 1, 'update', 'communities', 1, NULL, '{\"name\":\"Cộng đoàn Nhà Mẹ\",\"address\":\"123 Đường ABC\"}', '{\"name\":\"Cộng đoàn Nhà Mẹ Thiện Bản\",\"address\":\"456 Đường XYZ, Quận 1\"}', NULL, '2025-12-19 08:33:10'),
(6, 1, 'delete', 'posts', 10, NULL, '{\"title\":\"Thông báo cũ\",\"category\":\"thong-bao\",\"status\":\"published\"}', NULL, NULL, '2025-12-19 16:31:10'),
(7, 1, 'login', 'users', 1, NULL, NULL, '{\"ip_address\":\"192.168.1.100\",\"user_agent\":\"Chrome/120.0\"}', NULL, '2025-12-19 19:16:10'),
(8, 1, 'update', 'education', 1, NULL, '{\"degree\":\"Cử nhân\",\"institution\":\"Đại học A\",\"status\":\"studying\"}', '{\"degree\":\"Cử nhân\",\"institution\":\"Đại học A\",\"status\":\"graduated\",\"graduation_date\":\"2024-06-15\"}', NULL, '2025-12-19 22:53:10'),
(9, 1, 'create', 'missions', 15, NULL, NULL, '{\"position\":\"Giáo viên\",\"community_id\":2,\"description\":\"Dạy học tại trường mầm non\",\"start_date\":\"2024-01-15\"}', NULL, '2025-12-19 05:52:10'),
(10, 1, 'update', 'vocation_journey', 5, NULL, '{\"stage\":\"temporary_vows\",\"notes\":\"Hoàn thành khấn tạm lần 1\"}', '{\"stage\":\"perpetual_vows\",\"notes\":\"Hoàn thành khấn trọn\",\"end_date\":\"2024-12-08\"}', NULL, '2025-12-19 23:59:10'),
(11, 1, 'create', 'evaluations', 20, NULL, NULL, '{\"sister_id\":3,\"score\":85,\"rating\":\"Tốt\",\"comments\":\"Tiến bộ rõ rệt trong việc học tập và phục vụ\"}', NULL, '2025-12-19 15:47:10'),
(12, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 13:54:21'),
(13, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 13:55:19'),
(14, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 13:56:19'),
(15, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 13:57:19'),
(16, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 13:58:19'),
(17, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 13:59:19'),
(18, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:00:19'),
(19, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:01:19'),
(20, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:02:19'),
(21, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:03:19'),
(22, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:04:19'),
(23, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:04:50'),
(24, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:05:21'),
(25, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:05:51'),
(26, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:07:19'),
(27, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:08:19'),
(28, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:09:19'),
(29, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:10:19'),
(30, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:11:19'),
(31, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:12:19'),
(32, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:13:19'),
(33, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:14:19'),
(34, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:15:19'),
(35, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:16:19'),
(36, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:17:19'),
(37, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:18:19'),
(38, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:19:19'),
(39, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:20:19'),
(40, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:21:19'),
(41, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:22:19'),
(42, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:23:19'),
(43, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:24:19'),
(44, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:25:19'),
(45, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:26:19'),
(46, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:27:19'),
(47, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:28:19'),
(48, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:29:19'),
(49, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:30:19'),
(50, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:31:19'),
(51, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:32:19'),
(52, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:33:19'),
(53, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:34:19'),
(54, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:35:19'),
(55, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:36:19'),
(56, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:37:19'),
(57, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:38:19'),
(58, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:39:19'),
(59, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:40:19'),
(60, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:41:19'),
(61, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:42:19'),
(62, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:43:19'),
(63, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:44:02'),
(64, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:44:21'),
(65, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:44:51'),
(66, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:46:19'),
(67, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:47:19'),
(68, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:48:19'),
(69, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:49:19'),
(70, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:50:19'),
(71, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:51:19'),
(72, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:52:19'),
(73, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:53:19'),
(74, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:53:51'),
(75, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:55:19'),
(76, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:56:19'),
(77, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:57:19'),
(78, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:58:19'),
(79, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 14:59:19'),
(80, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:00:19'),
(81, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:01:19'),
(82, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:02:19'),
(83, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:03:19'),
(84, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:04:19'),
(85, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:04:51'),
(86, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:05:21'),
(87, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:05:51'),
(88, 1, 'UPDATE', 'missions', 40, NULL, '{\"id\":40,\"sister_id\":10,\"field\":\"social\",\"specific_role\":\"Phụ trách Caritas\",\"organization\":null,\"address\":null,\"start_date\":\"2024-06-30T17:00:00.000Z\",\"end_date\":null,\"notes\":\"Tư vấn và hỗ trợ tâm lý\"}', '{\"id\":40,\"sister_id\":10,\"field\":\"Giáo dục\",\"specific_role\":\"Phụ trách Caritas\",\"organization\":null,\"address\":null,\"start_date\":\"2024-06-29T17:00:00.000Z\",\"end_date\":null,\"notes\":\"Tư vấn và hỗ trợ tâm lý\"}', '127.0.0.1', '2025-12-20 15:06:57'),
(89, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:07:19'),
(90, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:08:19'),
(91, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:09:19'),
(92, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:10:19'),
(93, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:11:19'),
(94, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:12:19'),
(95, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:13:19'),
(96, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:14:19'),
(97, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:15:19'),
(98, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:16:19'),
(99, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:17:19'),
(100, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:18:19'),
(101, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:19:19'),
(102, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:20:19'),
(103, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:21:19'),
(104, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:22:19'),
(105, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:23:19'),
(106, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:24:19'),
(107, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:25:19'),
(108, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:26:19'),
(109, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:27:19'),
(110, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:28:19'),
(111, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:29:19'),
(112, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:30:19'),
(113, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:31:19'),
(114, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:32:19'),
(115, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:49:26'),
(116, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:50:19'),
(117, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/stats\",\"path\":\"/api/stats\"}', '127.0.0.1', '2025-12-20 15:51:14'),
(118, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-20 15:51:19');

-- --------------------------------------------------------

--
-- Table structure for table `backups`
--

CREATE TABLE `backups` (
  `id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) DEFAULT 0,
  `backup_type` enum('manual','auto') DEFAULT 'manual',
  `status` enum('completed','failed','in_progress') DEFAULT 'completed',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `backups`
--

INSERT INTO `backups` (`id`, `filename`, `file_path`, `file_size`, `backup_type`, `status`, `created_by`, `created_at`, `notes`) VALUES
(2, 'backup_20251215T165929.sql', 'backups/backup_20251215T165929.sql', 0, 'manual', 'completed', 1, '2025-12-15 16:59:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `chat_conversations`
--

CREATE TABLE `chat_conversations` (
  `id` int(11) NOT NULL,
  `conversation_id` varchar(36) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_message` text NOT NULL,
  `ai_response` text NOT NULL,
  `context_used` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`context_used`)),
  `entities_extracted` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`entities_extracted`)),
  `intent` varchar(50) DEFAULT NULL,
  `tokens_used` int(11) DEFAULT 0,
  `cost` decimal(10,6) DEFAULT 0.000000,
  `is_helpful` tinyint(1) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_conversations`
--

INSERT INTO `chat_conversations` (`id`, `conversation_id`, `user_id`, `user_message`, `ai_response`, `context_used`, `entities_extracted`, `intent`, `tokens_used`, `cost`, `is_helpful`, `feedback`, `created_at`, `updated_at`) VALUES
(1, '162a1c9b-5bc3-4a56-ab86-728650decb3b', 1, 'Có bao nhiêu nữ tu?', '📋 **Thông tin từ hệ thống:**\n\n👥 Thông tin chung về các nữ tu:\n\nTổng số nữ tu đang hoạt động: 15\n\nPhân bổ theo cộng đoàn:\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\n- Cộng đoàn Cần Thơ: 3 nữ tu\n- Cộng đoàn Đà Nẵng: 2 nữ tu\n- Cộng đoàn Hà Nội: 2 nữ tu\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\n- Cộng Đoàn Đà Lạt: 0 nữ tu\n', '{\"text\":\"👥 Thông tin chung về các nữ tu:\\n\\nTổng số nữ tu đang hoạt động: 15\\n\\nPhân bổ theo cộng đoàn:\\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\\n- Cộng đoàn Cần Thơ: 3 nữ tu\\n- Cộng đoàn Đà Nẵng: 2 nữ tu\\n- Cộng đoàn Hà Nội: 2 nữ tu\\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\\n- Cộng Đoàn Đà Lạt: 0 nữ tu\\n\",\"data\":{\"total\":15,\"byCommunity\":[{\"name\":\"Cộng đoàn Sài Gòn 1\",\"count\":3},{\"name\":\"Nhà Mẹ - Thủ Đức\",\"count\":3},{\"name\":\"Cộng đoàn Cần Thơ\",\"count\":3},{\"name\":\"Cộng đoàn Đà Nẵng\",\"count\":2},{\"name\":\"Cộng đoàn Hà Nội\",\"count\":2},{\"name\":\"Cộng đoàn Sài Gòn 2\",\"count\":2},{\"name\":\"Cộng Đoàn Đà Lạt\",\"count\":0}]},\"sources\":[]}', '{}', 'sister_info', 0, 0.000000, NULL, NULL, '2025-12-16 12:29:15', '2025-12-16 12:29:15'),
(2, '162a1c9b-5bc3-4a56-ab86-728650decb3b', 1, 'kể tên các nữ tu ở cộng đoàn hà nội', '📋 **Thông tin từ hệ thống:**\n\n👥 Thông tin chung về các nữ tu:\n\nTổng số nữ tu đang hoạt động: 15\n\nPhân bổ theo cộng đoàn:\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\n- Cộng đoàn Cần Thơ: 3 nữ tu\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\n- Cộng đoàn Đà Nẵng: 2 nữ tu\n- Cộng đoàn Hà Nội: 2 nữ tu\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\n- Cộng Đoàn Đà Lạt: 0 nữ tu\n', '{\"text\":\"👥 Thông tin chung về các nữ tu:\\n\\nTổng số nữ tu đang hoạt động: 15\\n\\nPhân bổ theo cộng đoàn:\\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\\n- Cộng đoàn Cần Thơ: 3 nữ tu\\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\\n- Cộng đoàn Đà Nẵng: 2 nữ tu\\n- Cộng đoàn Hà Nội: 2 nữ tu\\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\\n- Cộng Đoàn Đà Lạt: 0 nữ tu\\n\",\"data\":{\"total\":15,\"byCommunity\":[{\"name\":\"Nhà Mẹ - Thủ Đức\",\"count\":3},{\"name\":\"Cộng đoàn Cần Thơ\",\"count\":3},{\"name\":\"Cộng đoàn Sài Gòn 1\",\"count\":3},{\"name\":\"Cộng đoàn Đà Nẵng\",\"count\":2},{\"name\":\"Cộng đoàn Hà Nội\",\"count\":2},{\"name\":\"Cộng đoàn Sài Gòn 2\",\"count\":2},{\"name\":\"Cộng Đoàn Đà Lạt\",\"count\":0}]},\"sources\":[]}', '{\"community_id\":5,\"community_name\":\"Cộng đoàn Hà Nội\"}', 'sister_info', 0, 0.000000, NULL, NULL, '2025-12-16 12:29:38', '2025-12-16 12:29:38'),
(3, '162a1c9b-5bc3-4a56-ab86-728650decb3b', 1, 'công đoàn đà lạt địa chỉ', '📋 **Thông tin từ hệ thống:**\n\n🏠 Danh sách các cộng đoàn:\n\nTổng số: 7 cộng đoàn\n\n📍 Cộng đoàn Cần Thơ\n   - Mã: CT01\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\n   - Số thành viên: 3\n\n📍 Cộng đoàn Hà Nội\n   - Mã: HN01\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\n   - Số thành viên: 2\n\n📍 Cộng đoàn Sài Gòn 1\n   - Mã: SG01\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\n   - Số thành viên: 3\n\n📍 Cộng đoàn Sài Gòn 2\n   - Mã: SG02\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\n   - Số thành viên: 2\n\n📍 Cộng Đoàn Đà Lạt\n   - Mã: CD001\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\n   - Số thành viên: 0\n\n📍 Cộng đoàn Đà Nẵng\n   - Mã: DN01\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\n   - Số thành viên: 2\n\n📍 Nhà Mẹ - Thủ Đức\n   - Mã: MH\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n   - Số thành viên: 3\n\n', '{\"text\":\"🏠 Danh sách các cộng đoàn:\\n\\nTổng số: 7 cộng đoàn\\n\\n📍 Cộng đoàn Cần Thơ\\n   - Mã: CT01\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Hà Nội\\n   - Mã: HN01\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2\\n\\n📍 Cộng đoàn Sài Gòn 1\\n   - Mã: SG01\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Sài Gòn 2\\n   - Mã: SG02\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2\\n\\n📍 Cộng Đoàn Đà Lạt\\n   - Mã: CD001\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0\\n\\n📍 Cộng đoàn Đà Nẵng\\n   - Mã: DN01\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2\\n\\n📍 Nhà Mẹ - Thủ Đức\\n   - Mã: MH\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3\\n\\n\",\"data\":{\"communities\":[{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:26:59.000Z\",\"history\":null,\"member_count\":3},{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},{\"id\":3,\"code\":\"SG02\",\"name\":\"Cộng đoàn Sài Gòn 2\",\"address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\",\"phone\":\"028-3456789\",\"email\":\"sg02@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},{\"id\":4,\"code\":\"DN01\",\"name\":\"Cộng đoàn Đà Nẵng\",\"address\":\"12 Đường Trần Phú, Hải Châu, Đà Nẵng\",\"phone\":\"0236-123456\",\"email\":\"dn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":1,\"code\":\"MH\",\"name\":\"Nhà Mẹ - Thủ Đức\",\"address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\",\"phone\":\"028-1234567\",\"email\":\"nhame@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3}]},\"sources\":[]}', '{}', 'community_info', 0, 0.000000, NULL, NULL, '2025-12-16 12:30:40', '2025-12-16 12:30:40'),
(4, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'thông tin Nguyễn Thị Mai', 'Xin lỗi, nhưng hiện tại tôi không có thông tin về Nguyễn Thị Mai. Nếu bạn có câu hỏi khác hoặc cần thông tin về một chủ đề nào đó, hãy cho tôi biết! 📚😊', '{\"text\":\"Không thể truy xuất dữ liệu từ hệ thống.\",\"data\":{},\"sources\":[]}', '{\"sister_id\":1,\"sister_name\":\"Nguyễn Thị Mai\",\"saint_name\":\"Maria\",\"match_confidence\":1}', 'journey_info', 790, 0.000137, NULL, NULL, '2025-12-16 12:50:10', '2025-12-16 12:50:10'),
(5, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'cộng đoàn sài gòn có mấy người?', 'Cộng đoàn Sài Gòn có tổng cộng 5 thành viên, được chia thành hai nhóm như sau:\n\n1. **Cộng đoàn Sài Gòn 1**: 3 thành viên\n2. **Cộng đoàn Sài Gòn 2**: 2 thành viên\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết! 📍😊', '{\"text\":\"🏠 Danh sách các cộng đoàn:\\n\\nTổng số: 7 cộng đoàn\\n\\n📍 Cộng đoàn Cần Thơ\\n   - Mã: CT01\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Hà Nội\\n   - Mã: HN01\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2\\n\\n📍 Cộng đoàn Sài Gòn 1\\n   - Mã: SG01\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Sài Gòn 2\\n   - Mã: SG02\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2\\n\\n📍 Cộng Đoàn Đà Lạt\\n   - Mã: CD001\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0\\n\\n📍 Cộng đoàn Đà Nẵng\\n   - Mã: DN01\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2\\n\\n📍 Nhà Mẹ - Thủ Đức\\n   - Mã: MH\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3\\n\\n\",\"data\":{\"communities\":[{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:26:59.000Z\",\"history\":null,\"member_count\":3},{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},{\"id\":3,\"code\":\"SG02\",\"name\":\"Cộng đoàn Sài Gòn 2\",\"address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\",\"phone\":\"028-3456789\",\"email\":\"sg02@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},{\"id\":4,\"code\":\"DN01\",\"name\":\"Cộng đoàn Đà Nẵng\",\"address\":\"12 Đường Trần Phú, Hải Châu, Đà Nẵng\",\"phone\":\"0236-123456\",\"email\":\"dn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":1,\"code\":\"MH\",\"name\":\"Nhà Mẹ - Thủ Đức\",\"address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\",\"phone\":\"028-1234567\",\"email\":\"nhame@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3}]},\"sources\":[]}', '{}', 'community_info', 1268, 0.000225, NULL, NULL, '2025-12-16 12:50:58', '2025-12-16 12:50:58'),
(6, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'Cộng đoàn Sài Gòn 1 có những ai, ai làm bề trên', 'Cộng đoàn Sài Gòn 1 có 3 thành viên như sau:\n\n1. **Clara Hoàng Thị Đào** (SR005)\n2. **Rosa Phạm Thị Cúc** (SR004)\n3. **Agnes Vũ Thị Hồng** (SR006)\n\nHiện tại, tôi không có thông tin về ai là bề trên của cộng đoàn này. Nếu bạn cần thêm thông tin khác hoặc có câu hỏi nào khác, hãy cho tôi biết! 🏠😊', '{\"text\":\"🏠 Thông tin cộng đoàn Cộng đoàn Sài Gòn 1:\\n\\n- Mã: SG01\\n- Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n- Điện thoại: 028-2345678\\n- Email: sg01@osp.vn\\n- Số thành viên: 3\\n\\n👥 Danh sách thành viên:\\n1. Clara Hoàng Thị Đào (SR005)\\n2. Rosa Phạm Thị Cúc (SR004)\\n3. Agnes Vũ Thị Hồng (SR006)\\n\",\"data\":{\"community\":{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},\"members\":[{\"id\":5,\"birth_name\":\"Hoàng Thị Đào\",\"saint_name\":\"Clara\",\"code\":\"SR005\"},{\"id\":4,\"birth_name\":\"Phạm Thị Cúc\",\"saint_name\":\"Rosa\",\"code\":\"SR004\"},{\"id\":6,\"birth_name\":\"Vũ Thị Hồng\",\"saint_name\":\"Agnes\",\"code\":\"SR006\"}]},\"sources\":[]}', '{\"community_id\":2,\"community_name\":\"Cộng đoàn Sài Gòn 1\"}', 'community_info', 1136, 0.000219, NULL, NULL, '2025-12-16 12:51:22', '2025-12-16 12:51:22'),
(7, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'Clara Hoàng Thị Đào thông tin cơ bản', 'Xin lỗi, hiện tại tôi không có thông tin cơ bản về chị Clara Hoàng Thị Đào. Nếu bạn có câu hỏi khác hoặc cần thông tin về một chủ đề nào khác, hãy cho tôi biết! 📚😊', '{\"text\":\"Không thể truy xuất dữ liệu từ hệ thống.\",\"data\":{},\"sources\":[]}', '{\"sister_id\":5,\"sister_name\":\"Hoàng Thị Đào\",\"saint_name\":\"Clara\",\"match_confidence\":1}', 'journey_info', 1089, 0.000185, NULL, NULL, '2025-12-16 12:51:46', '2025-12-16 12:51:46'),
(8, 'df9dc990-d362-4cb6-b9bc-b6b7c25770db', 1, 'thông tin Nguyễn Thị Mai', 'Dưới đây là thông tin chi tiết về nữ tu Maria Nguyễn Thị Mai:\n\n👤 **Thông tin cơ bản:**\n- **Mã số:** SR001\n- **Tên thánh:** Maria\n- **Họ tên:** Nguyễn Thị Mai\n- **Ngày sinh:** 15/03/1985\n- **Nơi sinh:** TP.HCM\n- **Quốc tịch:** Việt Nam\n- **Email:** N/A\n- **Điện thoại:** N/A\n\n🏠 **Cộng đoàn hiện tại:**\n- **Tên:** Nhà Mẹ - Thủ Đức\n- **Địa chỉ:** 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n\n📍 **Hành trình ơn gọi:**\n- **Khấn trọn:** 15/08/2010 → Hiện tại\n\n✅ **Giai đoạn hiện tại:** Khấn trọn\n\n📚 **Học vấn:**\n- **Bằng cấp:** Thạc sĩ Thần học\n  - **Trường:** Học viện Công giáo Việt Nam\n\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\n\n🔄 **Lịch sử phân bổ cộng đoàn:**\n- **Nhà Mẹ - Thủ Đức:** 01/01/2020 → Hiện tại\n\nNếu bạn cần thêm thông tin nào khác, hãy cho tôi biết! 😊', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ MARIA NGUYỄN THỊ MAI**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR001\\n- Tên thánh: Maria\\n- Họ tên: Nguyễn Thị Mai\\n- Ngày sinh: 15/3/1985\\n- Nơi sinh: TP.HCM\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Nhà Mẹ - Thủ Đức\\n- Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2010 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. master: Thần học\\n   🏫 Trường: Học viện Công giáo Việt Nam\\n\\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Nhà Mẹ - Thủ Đức: 1/1/2020 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":1,\"code\":\"SR001\",\"saint_name\":\"Maria\",\"birth_name\":\"Nguyễn Thị Mai\",\"date_of_birth\":\"1985-03-14T17:00:00.000Z\",\"place_of_birth\":\"TP.HCM\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Nhà Mẹ - Thủ Đức\",\"community_address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":1,\"name\":\"Maria Nguyễn Thị Mai\"}]}', '{\"sister_id\":1,\"sister_name\":\"Nguyễn Thị Mai\",\"saint_name\":\"Maria\",\"match_confidence\":1}', 'journey_info', 1303, 0.000327, NULL, NULL, '2025-12-16 12:57:27', '2025-12-16 12:57:27'),
(9, '193de521-7acd-4141-8999-279348796743', 1, 'thông tin Nguyễn Thị Mai', 'Dưới đây là thông tin chi tiết về chị Maria Nguyễn Thị Mai:\n\n👤 **Thông tin cơ bản:**\n- **Mã số:** SR001\n- **Tên thánh:** Maria\n- **Họ tên:** Nguyễn Thị Mai\n- **Ngày sinh:** 15/03/1985\n- **Nơi sinh:** TP.HCM\n- **Quốc tịch:** Việt Nam\n- **Email:** N/A\n- **Điện thoại:** N/A\n\n🏠 **Cộng đoàn hiện tại:**\n- **Tên:** Nhà Mẹ - Thủ Đức\n- **Địa chỉ:** 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n\n📍 **Hành trình ơn gọi:**\n- **Khấn trọn:** 15/08/2010 → Hiện tại\n\n✅ **Giai đoạn hiện tại:** Khấn trọn\n\n📚 **Học vấn:**\n- **Bằng cấp:** Thạc sĩ Thần học\n- **Trường:** Học viện Công giáo Việt Nam\n\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\n\n🔄 **Lịch sử phân bổ cộng đoàn:**\n- **Nhà Mẹ - Thủ Đức:** Từ 01/01/2020 → Hiện tại\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết nhé! 😊', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ MARIA NGUYỄN THỊ MAI**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR001\\n- Tên thánh: Maria\\n- Họ tên: Nguyễn Thị Mai\\n- Ngày sinh: 15/3/1985\\n- Nơi sinh: TP.HCM\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Nhà Mẹ - Thủ Đức\\n- Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2010 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. master: Thần học\\n   🏫 Trường: Học viện Công giáo Việt Nam\\n\\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Nhà Mẹ - Thủ Đức: 1/1/2020 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":1,\"code\":\"SR001\",\"saint_name\":\"Maria\",\"birth_name\":\"Nguyễn Thị Mai\",\"date_of_birth\":\"1985-03-14T17:00:00.000Z\",\"place_of_birth\":\"TP.HCM\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Nhà Mẹ - Thủ Đức\",\"community_address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":1,\"name\":\"Maria Nguyễn Thị Mai\"}]}', '{\"sister_id\":1,\"sister_name\":\"Nguyễn Thị Mai\",\"saint_name\":\"Maria\",\"match_confidence\":1}', 'journey_info', 1304, 0.000327, NULL, NULL, '2025-12-16 12:59:51', '2025-12-16 12:59:51'),
(10, '193de521-7acd-4141-8999-279348796743', 1, 'có mấy cộng đoàn?', 'Chưa có thông tin về số lượng cộng đoàn trong hệ thống. Bạn có thể kiểm tra lại sau hoặc hỏi thông tin khác mà bạn cần nhé! 😊\n\n💡 *Bạn có thể hỏi thêm về chi tiết của từng cộng đoàn hoặc giai đoạn cụ thể.*', '{\"text\":\"Không thể truy xuất dữ liệu từ hệ thống.\",\"data\":{},\"sources\":[]}', '{}', 'statistics', 1088, 0.000178, NULL, NULL, '2025-12-16 13:00:02', '2025-12-16 13:00:02'),
(11, '193de521-7acd-4141-8999-279348796743', 1, 'Danh sách các cộng đoàn', 'Dưới đây là danh sách các cộng đoàn trong hệ thống:\n\n1. **Cộng đoàn Cần Thơ**\n   - **Mã:** CT01\n   - **Địa chỉ:** 56 Đường 30/4, Ninh Kiều, Cần Thơ\n   - **Số thành viên:** 3\n\n2. **Cộng đoàn Hà Nội**\n   - **Mã:** HN01\n   - **Địa chỉ:** 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\n   - **Số thành viên:** 2\n\n3. **Cộng đoàn Sài Gòn 1**\n   - **Mã:** SG01\n   - **Địa chỉ:** 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\n   - **Số thành viên:** 3\n\n4. **Cộng đoàn Sài Gòn 2**\n   - **Mã:** SG02\n   - **Địa chỉ:** 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\n   - **Số thành viên:** 2\n\n5. **Cộng Đoàn Đà Lạt**\n   - **Mã:** CD001\n   - **Địa chỉ:** 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\n   - **Số thành viên:** 0\n\n6. **Cộng đoàn Đà Nẵng**\n   - **Mã:** DN01\n   - **Địa chỉ:** 12 Đường Trần Phú, Hải Châu, Đà Nẵng\n   - **Số thành viên:** 2\n\n7. **Nhà Mẹ - Thủ Đức**\n   - **Mã:** MH\n   - **Địa chỉ:** 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n   - **Số thành viên:** 3\n\nNếu bạn cần thêm thông tin chi tiết về từng cộng đoàn, hãy cho tôi biết nhé! 😊', '{\"text\":\"🏠 Danh sách các cộng đoàn:\\n\\nTổng số: 7 cộng đoàn\\n\\n📍 Cộng đoàn Cần Thơ\\n   - Mã: CT01\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Hà Nội\\n   - Mã: HN01\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2\\n\\n📍 Cộng đoàn Sài Gòn 1\\n   - Mã: SG01\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Sài Gòn 2\\n   - Mã: SG02\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2\\n\\n📍 Cộng Đoàn Đà Lạt\\n   - Mã: CD001\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0\\n\\n📍 Cộng đoàn Đà Nẵng\\n   - Mã: DN01\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2\\n\\n📍 Nhà Mẹ - Thủ Đức\\n   - Mã: MH\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3\\n\\n\",\"data\":{\"communities\":[{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:26:59.000Z\",\"history\":null,\"member_count\":3},{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},{\"id\":3,\"code\":\"SG02\",\"name\":\"Cộng đoàn Sài Gòn 2\",\"address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\",\"phone\":\"028-3456789\",\"email\":\"sg02@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},{\"id\":4,\"code\":\"DN01\",\"name\":\"Cộng đoàn Đà Nẵng\",\"address\":\"12 Đường Trần Phú, Hải Châu, Đà Nẵng\",\"phone\":\"0236-123456\",\"email\":\"dn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":1,\"code\":\"MH\",\"name\":\"Nhà Mẹ - Thủ Đức\",\"address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\",\"phone\":\"028-1234567\",\"email\":\"nhame@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3}]},\"sources\":[]}', '{}', 'community_info', 1939, 0.000487, NULL, NULL, '2025-12-16 13:00:22', '2025-12-16 13:00:22'),
(12, '193de521-7acd-4141-8999-279348796743', 1, 'kể tên nữ tu ở cộng đoàn đà lạt', 'Hiện tại, cộng đoàn Đà Lạt có số thành viên là 0, do đó không có nữ tu nào đang hoạt động tại cộng đoàn này. \n\nNếu bạn cần thông tin về các cộng đoàn khác hoặc bất kỳ câu hỏi nào khác, hãy cho tôi biết nhé! 😊', '{\"text\":\"🏠 Thông tin cộng đoàn Cộng Đoàn Đà Lạt:\\n\\n- Mã: CD001\\n- Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n- Điện thoại: 0987654321\\n- Email: dalat@gmail.com\\n- Số thành viên: 0\\n\",\"data\":{\"community\":{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},\"members\":[]},\"sources\":[]}', '{\"community_id\":7,\"community_name\":\"Cộng Đoàn Đà Lạt\"}', 'community_info', 1705, 0.000282, NULL, NULL, '2025-12-16 13:01:30', '2025-12-16 13:01:30'),
(13, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'Có mấy cộng đoàn?', 'Hiện tại, có tổng cộng **7 cộng đoàn**. Dưới đây là danh sách các cộng đoàn:\n\n1. Cộng đoàn Cần Thơ\n2. Cộng đoàn Hà Nội\n3. Cộng đoàn Sài Gòn 1\n4. Cộng đoàn Sài Gòn 2\n5. Cộng Đoàn Đà Lạt\n6. Cộng đoàn Đà Nẵng\n7. Nhà Mẹ - Thủ Đức\n\n💡 *Bạn có thể hỏi thêm về chi tiết của từng cộng đoàn hoặc giai đoạn cụ thể.*', '{\"text\":\"📊 **Thông tin hệ thống:**\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\n🏠 **Danh sách 7 cộng đoàn:**\\n\\n1. **Cộng đoàn Cần Thơ** (Mã: CT01)\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3 nữ tu\\n\\n2. **Cộng đoàn Hà Nội** (Mã: HN01)\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2 nữ tu\\n\\n3. **Cộng đoàn Sài Gòn 1** (Mã: SG01)\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3 nữ tu\\n\\n4. **Cộng đoàn Sài Gòn 2** (Mã: SG02)\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2 nữ tu\\n\\n5. **Cộng Đoàn Đà Lạt** (Mã: CD001)\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0 nữ tu\\n\\n6. **Cộng đoàn Đà Nẵng** (Mã: DN01)\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2 nữ tu\\n\\n7. **Nhà Mẹ - Thủ Đức** (Mã: MH)\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3 nữ tu\\n\\n\",\"data\":{},\"sources\":[{\"type\":\"communities\",\"count\":7}]}', '{\"count_question\":true,\"age_question\":false,\"list_question\":false}', 'statistics', 1260, 0.000233, NULL, NULL, '2025-12-16 13:08:54', '2025-12-16 13:08:54'),
(14, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'Cộng đoàn Hà Nội có những ai', 'Cộng đoàn Hà Nội hiện có **2 thành viên**. Dưới đây là danh sách các thành viên:\n\n1. **Josephine Hồ Thị Yến** (Mã: SR012)\n2. **Bernadette Lý Thị Thảo** (Mã: SR011)\n\n🏠 Nếu bạn cần thêm thông tin về cộng đoàn hoặc các thành viên, hãy cho tôi biết!', '{\"text\":\"🏠 Thông tin cộng đoàn Cộng đoàn Hà Nội:\\n\\n- Mã: HN01\\n- Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n- Điện thoại: 024-1234567\\n- Email: hn01@osp.vn\\n- Số thành viên: 2\\n\\n👥 Danh sách thành viên:\\n1. Josephine Hồ Thị Yến (SR012)\\n2. Bernadette Lý Thị Thảo (SR011)\\n\",\"data\":{\"community\":{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},\"members\":[{\"id\":12,\"birth_name\":\"Hồ Thị Yến\",\"saint_name\":\"Josephine\",\"code\":\"SR012\"},{\"id\":11,\"birth_name\":\"Lý Thị Thảo\",\"saint_name\":\"Bernadette\",\"code\":\"SR011\"}]},\"sources\":[]}', '{\"community_name\":\"Cộng đoàn Hà Nội\",\"list_question\":true,\"community_id\":5,\"age_question\":false,\"count_question\":false}', 'community_info', 1065, 0.000197, NULL, NULL, '2025-12-16 13:09:16', '2025-12-16 13:09:16'),
(15, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'Hồ Thị Yến bao nhiêu tuổi, cha mẹ tên gì?', '**Hồ Thị Yến**, tên thánh là **Josephine**, sinh ngày **03/10/1988**, hiện tại chị **35 tuổi** (tính đến tháng 10 năm 2023).\n\nVề thông tin cha mẹ của chị, rất tiếc, tôi không có dữ liệu cụ thể về tên của cha mẹ chị. Nếu bạn cần thêm thông tin khác, hãy cho tôi biết! 📚', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ JOSEPHINE HỒ THỊ YẾN**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR012\\n- Tên thánh: Josephine\\n- Họ tên: Hồ Thị Yến\\n- Ngày sinh: 3/10/1988\\n- Nơi sinh: Quảng Nam\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Hà Nội\\n- Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn tạm: 15/8/2019 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn tạm\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Hà Nội: 1/1/2022 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":12,\"code\":\"SR012\",\"saint_name\":\"Josephine\",\"birth_name\":\"Hồ Thị Yến\",\"date_of_birth\":\"1988-10-02T17:00:00.000Z\",\"place_of_birth\":\"Quảng Nam\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"temporary_vows\",\"current_community_id\":5,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Hà Nội\",\"community_address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\"}},\"sources\":[{\"type\":\"sister\",\"id\":12,\"name\":\"Josephine Hồ Thị Yến\"}]}', '{\"person_name\":\"Hồ Thị Yến\",\"age_question\":true,\"sister_id\":12,\"sister_name\":\"Hồ Thị Yến\",\"saint_name\":\"Josephine\",\"match_confidence\":1,\"count_question\":true,\"list_question\":false}', 'sister_info', 1292, 0.000233, NULL, NULL, '2025-12-16 13:09:42', '2025-12-16 13:09:42'),
(16, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'tính đến hôm nay, Hồ Thị Yến, bao nhiêu tuổi?', 'Tính đến hôm nay, **Hồ Thị Yến** (tên thánh là **Josephine**), sinh ngày **03/10/1988**, hiện tại chị **35 tuổi**. Chị sẽ tròn **36 tuổi** vào ngày **03/10/2024**. 🎉\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết! 📚', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ JOSEPHINE HỒ THỊ YẾN**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR012\\n- Tên thánh: Josephine\\n- Họ tên: Hồ Thị Yến\\n- Ngày sinh: 3/10/1988\\n- Nơi sinh: Quảng Nam\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Hà Nội\\n- Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn tạm: 15/8/2019 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn tạm\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Hà Nội: 1/1/2022 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":12,\"code\":\"SR012\",\"saint_name\":\"Josephine\",\"birth_name\":\"Hồ Thị Yến\",\"date_of_birth\":\"1988-10-02T17:00:00.000Z\",\"place_of_birth\":\"Quảng Nam\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"temporary_vows\",\"current_community_id\":5,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Hà Nội\",\"community_address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\"}},\"sources\":[{\"type\":\"sister\",\"id\":12,\"name\":\"Josephine Hồ Thị Yến\"}]}', '{\"person_name\":\"Hồ Thị Yến\",\"age_question\":true,\"sister_id\":12,\"sister_name\":\"Hồ Thị Yến\",\"saint_name\":\"Josephine\",\"match_confidence\":1,\"count_question\":true,\"list_question\":false}', 'sister_info', 1399, 0.000247, NULL, NULL, '2025-12-16 13:10:35', '2025-12-16 13:10:35'),
(17, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'sức khỏe của chị thế nào?', 'Rất tiếc, tôi không có thông tin cụ thể về tình trạng sức khỏe của chị Hồ Thị Yến. Nếu bạn có thắc mắc khác hoặc cần thông tin về các vấn đề khác liên quan đến nữ tu hoặc cộng đoàn, hãy cho tôi biết! 📚', '{\"text\":\"📋 Thông tin hệ thống:\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.\",\"data\":{\"totalSisters\":15,\"totalCommunities\":7},\"sources\":[]}', '{\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'health_info', 1303, 0.000221, NULL, NULL, '2025-12-16 13:11:16', '2025-12-16 13:11:16'),
(18, '25475a46-5104-4e32-bf05-1a2e626aa8eb', 1, 'xin chào', 'Xin chào! 🙏 Tôi có thể giúp gì cho bạn hôm nay?', '{\"text\":\"📋 Thông tin hệ thống:\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.\",\"data\":{\"totalSisters\":15,\"totalCommunities\":7},\"sources\":[]}', '{\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'greeting', 805, 0.000128, NULL, NULL, '2025-12-17 13:25:46', '2025-12-17 13:25:46'),
(19, '25475a46-5104-4e32-bf05-1a2e626aa8eb', 1, 'đặng thị tuyết mấy tuổi, ở cộng đoàn nào', 'Chị Monica Đặng Thị Tuyết sinh ngày 18/04/1993, nên hiện tại chị đang 30 tuổi. 🎉\n\nChị đang ở cộng đoàn Sài Gòn 2, địa chỉ tại 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM. 🏠', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ MONICA ĐẶNG THỊ TUYẾT**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR007\\n- Tên thánh: Monica\\n- Họ tên: Đặng Thị Tuyết\\n- Ngày sinh: 18/4/1993\\n- Nơi sinh: Bình Dương\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Sài Gòn 2\\n- Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2014 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. bachelor: Điều dưỡng\\n   🏫 Trường: Đại học Y Dược TP.HCM\\n\\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Sài Gòn 2: 1/1/2021 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":7,\"code\":\"SR007\",\"saint_name\":\"Monica\",\"birth_name\":\"Đặng Thị Tuyết\",\"date_of_birth\":\"1993-04-17T17:00:00.000Z\",\"place_of_birth\":\"Bình Dương\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":3,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Sài Gòn 2\",\"community_address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":7,\"name\":\"Monica Đặng Thị Tuyết\"}]}', '{\"person_name\":\"đặng thị tuyết\",\"age_question\":true,\"sister_id\":7,\"sister_name\":\"Đặng Thị Tuyết\",\"saint_name\":\"Monica\",\"match_confidence\":1,\"count_question\":true,\"list_question\":false}', 'sister_info', 1123, 0.000200, NULL, NULL, '2025-12-17 13:26:09', '2025-12-17 13:26:09'),
(20, '6fa5aab7-dd49-45dc-8bc9-9d2e345db71f', 1, 'xin chào', 'Xin chào! 🙏 Tôi rất vui được gặp bạn. Bạn cần hỏi gì về nữ tu, hành trình ơn gọi, hoặc cộng đoàn?', '{\"text\":\"📋 Thông tin hệ thống:\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.\",\"data\":{\"totalSisters\":15,\"totalCommunities\":7},\"sources\":[]}', '{\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'greeting', 820, 0.000137, NULL, NULL, '2025-12-18 12:42:39', '2025-12-18 12:42:39'),
(21, '6fa5aab7-dd49-45dc-8bc9-9d2e345db71f', 1, 'thông tin phạm thị cúc', 'Dưới đây là thông tin chi tiết về chị Rosa Phạm Thị Cúc:\n\n👤 **Thông tin cơ bản:**\n- **Mã số:** SR004\n- **Tên thánh:** Rosa\n- **Họ tên:** Phạm Thị Cúc\n- **Ngày sinh:** 30/05/1992\n- **Nơi sinh:** Cần Thơ\n- **Quốc tịch:** Việt Nam\n- **Email:** N/A\n- **Điện thoại:** N/A\n\n🏠 **Cộng đoàn hiện tại:**\n- **Tên:** Cộng đoàn Sài Gòn 1\n- **Địa chỉ:** 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\n\n📍 **Hành trình ơn gọi:**\n- **Khấn trọn:** 15/08/2012 → Hiện tại\n\n✅ **Giai đoạn hiện tại:** Khấn trọn\n\n📚 **Học vấn:**\n- **Bằng thạc sĩ:** Quản trị giáo dục\n  - **Trường:** Đại học Giáo dục - ĐHQG Hà Nội\n\n🔄 **Lịch sử phân bổ cộng đoàn:**\n- **Cộng đoàn Sài Gòn 1:** Từ 01/09/2019 → Hiện tại\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết nhé! 😊', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ ROSA PHẠM THỊ CÚC**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR004\\n- Tên thánh: Rosa\\n- Họ tên: Phạm Thị Cúc\\n- Ngày sinh: 30/5/1992\\n- Nơi sinh: Cần Thơ\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Sài Gòn 1\\n- Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2012 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. master: Quản trị giáo dục\\n   🏫 Trường: Đại học Giáo dục - ĐHQG Hà Nội\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Sài Gòn 1: 1/9/2019 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":4,\"code\":\"SR004\",\"saint_name\":\"Rosa\",\"birth_name\":\"Phạm Thị Cúc\",\"date_of_birth\":\"1992-05-29T17:00:00.000Z\",\"place_of_birth\":\"Cần Thơ\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":2,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Sài Gòn 1\",\"community_address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":4,\"name\":\"Rosa Phạm Thị Cúc\"}]}', '{\"person_name\":\"Phạm Thị Cúc\",\"sister_id\":4,\"sister_name\":\"Phạm Thị Cúc\",\"saint_name\":\"Rosa\",\"match_confidence\":1,\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'sister_info', 1344, 0.000333, NULL, NULL, '2025-12-18 12:42:54', '2025-12-18 12:42:54');

-- --------------------------------------------------------

--
-- Table structure for table `communities`
--

CREATE TABLE `communities` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(150) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `established_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `history` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `communities`
--

INSERT INTO `communities` (`id`, `code`, `name`, `address`, `phone`, `email`, `established_date`, `status`, `description`, `created_at`, `updated_at`, `history`) VALUES
(1, 'NM001', 'Cộng Đoàn Nhà Mẹ', '123 Đường Nguyễn Văn Trỗi, Phường 8, Quận Phú Nhuận, TP. Hồ Chí Minh', '028-3844-5678', 'nhamemtp@saintpaul.vn', '1950-01-15', 'active', 'Cộng đoàn trung tâm, nơi ở của Bề trên Dòng và các nữ tu cao niên', '2025-12-20 02:40:47', NULL, NULL),
(2, 'SG001', 'Cộng Đoàn Sài Gòn', '456 Đường Lê Văn Sỹ, Phường 14, Quận 3, TP. Hồ Chí Minh', '028-3930-1234', 'saigon@saintpaul.vn', '1965-03-20', 'active', 'Cộng đoàn phục vụ tại các trường học và bệnh viện tại Sài Gòn', '2025-12-20 02:40:47', NULL, NULL),
(3, 'DL001', 'Cộng Đoàn Đà Lạt', '789 Đường 3 Tháng 2, Phường 1, Thành phố Đà Lạt, Lâm Đồng', '0263-383-5678', 'dalat@saintpaul.vn', '1970-08-10', 'active', 'Cộng đoàn tại thành phố ngàn hoa, phục vụ giáo dục và mục vụ', '2025-12-20 02:40:47', NULL, NULL),
(4, 'BL001', 'Cộng Đoàn Bảo Lộc', '321 Đường Trần Phú, Phường 1, Thành phố Bảo Lộc, Lâm Đồng', '0263-386-2345', 'baoloc@saintpaul.vn', '1975-11-05', 'active', 'Cộng đoàn phục vụ vùng nông thôn miền núi, giáo dục và y tế', '2025-12-20 02:40:47', NULL, NULL),
(5, 'NC001', 'Cộng Đoàn Núi Cúi', '654 Đường Hùng Vương, Xã Núi Cúi, Huyện Đức Trọng, Lâm Đồng', '0263-387-8901', 'nuicui@saintpaul.vn', '1980-05-25', 'active', 'Cộng đoàn vùng cao, phục vụ đồng bào dân tộc thiểu số', '2025-12-20 02:40:47', NULL, NULL),
(6, 'HN001', 'Cộng Đoàn Hà Nội', '147 Đường Láng Hạ, Phường Thành Công, Quận Ba Đình, Hà Nội', '024-3514-6789', 'hanoi@saintpaul.vn', '1990-12-08', 'active', 'Cộng đoàn tại miền Bắc, phục vụ giáo dục và mục vụ xã hội', '2025-12-20 02:40:47', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `community_assignments`
--

CREATE TABLE `community_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `community_id` int(10) UNSIGNED NOT NULL,
  `role` enum('superior','assistant','vice_superior','deputy','secretary','treasurer','member') NOT NULL DEFAULT 'member',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `decision_number` varchar(50) DEFAULT NULL,
  `decision_date` date DEFAULT NULL,
  `decision_file_url` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `community_assignments`
--

INSERT INTO `community_assignments` (`id`, `sister_id`, `community_id`, `role`, `start_date`, `end_date`, `decision_number`, `decision_date`, `decision_file_url`, `notes`) VALUES
(1, 1, 1, 'member', '2019-12-31', NULL, NULL, NULL, NULL, NULL),
(2, 2, 1, 'member', '2019-12-29', NULL, NULL, NULL, NULL, NULL),
(3, 3, 1, 'assistant', '2021-05-29', NULL, NULL, NULL, NULL, NULL),
(4, 4, 2, 'superior', '2019-09-01', NULL, NULL, NULL, NULL, NULL),
(5, 5, 2, 'member', '2020-03-01', NULL, NULL, NULL, NULL, NULL),
(6, 6, 2, 'member', '2022-01-01', NULL, NULL, NULL, NULL, NULL),
(7, 7, 3, 'superior', '2021-01-01', NULL, NULL, NULL, NULL, NULL),
(8, 8, 3, 'member', '2021-01-01', NULL, NULL, NULL, NULL, NULL),
(9, 9, 4, 'superior', '2020-06-01', NULL, NULL, NULL, NULL, NULL),
(10, 10, 4, 'member', '2020-06-01', NULL, NULL, NULL, NULL, NULL),
(11, 11, 5, 'superior', '2022-01-01', NULL, NULL, NULL, NULL, NULL),
(12, 12, 5, 'member', '2022-01-01', NULL, NULL, NULL, NULL, NULL),
(13, 13, 6, 'superior', '2021-09-01', NULL, NULL, NULL, NULL, NULL),
(14, 14, 6, 'member', '2021-09-01', NULL, NULL, NULL, NULL, NULL),
(15, 15, 6, 'member', '2023-01-01', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `community_members`
--

CREATE TABLE `community_members` (
  `id` int(11) NOT NULL,
  `community_id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `role` enum('superior','assistant','treasurer','secretary','member') NOT NULL DEFAULT 'member',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_members`
--

INSERT INTO `community_members` (`id`, `community_id`, `sister_id`, `role`, `start_date`, `end_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'superior', '2020-01-01', '2024-12-31', 'Nhiệm kỳ 2020-2024', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(2, 1, 2, 'assistant', '2020-01-01', '2024-12-31', 'Nhiệm kỳ 2020-2024', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(3, 1, 3, 'treasurer', '2018-01-01', '2022-12-31', 'Nhiệm kỳ 2018-2022', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(4, 1, 4, 'secretary', '2018-01-01', '2023-12-31', 'Nhiệm kỳ 2018-2023', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(5, 2, 1, 'superior', '2020-01-01', '2023-12-31', 'Nhiệm kỳ 2020-2023', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(6, 2, 2, 'assistant', '2018-01-01', '2022-12-31', 'Nhiệm kỳ 2018-2022', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(7, 2, 3, 'treasurer', '2015-01-01', '2020-12-31', 'Nhiệm kỳ 2015-2020', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(8, 3, 1, 'superior', '2020-01-01', '2025-12-31', 'Nhiệm kỳ 2020-2025', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(9, 3, 2, 'assistant', '2019-01-01', '2023-12-31', 'Nhiệm kỳ 2019-2023', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(10, 3, 3, 'treasurer', '2018-01-01', '2021-12-31', 'Nhiệm kỳ 2018-2021', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(11, 3, 4, 'secretary', '2015-01-01', '2019-12-31', 'Nhiệm kỳ 2015-2019', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(12, 4, 1, 'superior', '2020-01-01', '2025-12-31', 'Nhiệm kỳ 2020-2025', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(13, 4, 2, 'assistant', '2016-01-01', '2020-12-31', 'Nhiệm kỳ 2016-2020', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(14, 4, 3, 'treasurer', '2015-01-01', '2020-12-31', 'Nhiệm kỳ 2015-2020', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(15, 4, 4, 'secretary', '2020-01-01', '2024-12-31', 'Nhiệm kỳ 2020-2024', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(16, 5, 1, 'superior', '2021-01-01', '2025-12-31', 'Nhiệm kỳ 2021-2025', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(17, 5, 2, 'assistant', '2015-01-01', '2019-12-31', 'Nhiệm kỳ 2015-2019', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(18, 5, 3, 'treasurer', '2022-01-01', '2027-12-31', 'Nhiệm kỳ 2022-2027', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(19, 6, 1, 'superior', '2022-01-01', '2026-12-31', 'Nhiệm kỳ 2022-2026', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(20, 6, 2, 'assistant', '2018-01-01', '2022-12-31', 'Nhiệm kỳ 2018-2022', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(21, 6, 3, 'treasurer', '2018-01-01', '2022-12-31', 'Nhiệm kỳ 2018-2022', '2025-12-20 02:55:09', '2025-12-20 02:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `community_roles`
--

CREATE TABLE `community_roles` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_default` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_roles`
--

INSERT INTO `community_roles` (`id`, `code`, `name`, `description`, `display_order`, `color`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'superior', 'Bề trên', NULL, 1, '#d63031', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(2, 'assistant', 'Phó bề trên', NULL, 2, '#2d3436', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(3, 'secretary', 'Thư ký', NULL, 3, '#6c5ce7', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(4, 'treasurer', 'Thủ quỹ', NULL, 4, '#e84393', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(5, 'member', 'Thành viên', NULL, 5, '#0984e3', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13');

-- --------------------------------------------------------

--
-- Table structure for table `departures`
--

CREATE TABLE `departures` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(100) NOT NULL,
  `departure_date` date NOT NULL,
  `expected_return_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `destination` varchar(255) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_address` text DEFAULT NULL,
  `approved_by` int(10) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departures`
--

INSERT INTO `departures` (`id`, `sister_id`, `type`, `departure_date`, `expected_return_date`, `return_date`, `destination`, `reason`, `contact_phone`, `contact_address`, `approved_by`, `notes`, `documents`, `created_at`, `updated_at`) VALUES
(1, 1, 'Về thăm gia đình', '2020-12-11', '2020-12-15', '2020-12-14', 'Giáo phận Đà Lạt', 'Chăm sóc cha mẹ già yếu', '0867013741', 'Giáo phận Đà Lạt', 4, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:14:59', NULL),
(2, 1, 'Nghỉ dưỡng', '2021-10-14', '2021-10-15', '2021-10-15', 'Tu viện Roma', 'Nghỉ ngơi phục hồi sức khỏe', '0431028659', 'Tu viện Roma', 6, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(3, 1, 'Điều trị y tế', '2022-11-25', '2022-12-06', '2022-12-05', 'Học viện Công giáo Việt Nam', 'Phẫu thuật', '0792334954', 'Học viện Công giáo Việt Nam', 2, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(4, 1, 'Khóa tu học', '2023-08-17', '2023-08-28', '2023-08-27', 'Giáo phận Đà Lạt', 'Khóa học Kinh thánh', '0343979080', 'Giáo phận Đà Lạt', 5, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:14:59', NULL),
(5, 2, 'Học tập - Bồi dưỡng', '2020-05-19', '2020-06-04', '2020-06-04', 'Bệnh viện Chợ Rẫy', 'Khóa đào tạo kỹ năng mục vụ', '0476629383', 'Bệnh viện Chợ Rẫy', 1, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(6, 2, 'Nghỉ dưỡng', '2021-05-17', '2021-05-22', '2021-05-22', 'Cộng đoàn Bảo Lộc', 'Thư giãn tinh thần', '0601315354', 'Cộng đoàn Bảo Lộc', 1, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(7, 2, 'Khóa tu học', '2022-04-06', '2022-04-17', '2022-04-17', 'Nhà riêng (Hà Nội)', 'Khóa học Kinh thánh', '0162569012', 'Nhà riêng (Hà Nội)', 5, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:14:59', NULL),
(8, 2, 'Hoạt động mục vụ', '2023-09-08', '2023-09-11', NULL, 'Học viện Công giáo Việt Nam', 'Công tác xã hội', '0478547264', 'Học viện Công giáo Việt Nam', 5, 'Đang trong chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:14:59', NULL),
(9, 3, 'Tham dự hội nghị', '2020-03-01', '2020-03-04', '2020-03-04', 'Nhà riêng (Sài Gòn)', 'Hội nghị mục vụ', '0603310173', 'Nhà riêng (Sài Gòn)', 7, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(10, 3, 'Tham dự hội nghị', '2021-09-06', '2021-09-15', '2021-09-15', 'Nhà riêng (quê nhà)', 'Hội nghị mục vụ', '0806791050', 'Nhà riêng (quê nhà)', 4, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(11, 3, 'Điều trị y tế', '2022-08-08', '2022-08-20', '2022-08-20', 'Học viện Công giáo Việt Nam', 'Phẫu thuật', '0227058313', 'Học viện Công giáo Việt Nam', 5, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(12, 3, 'Công việc hội dòng', '2023-08-02', '2023-08-05', '2023-08-05', 'Tu viện Manila', 'Họp hội đồng hội dòng', '0547562566', 'Tu viện Manila', 6, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(13, 4, 'Công tác', '2020-01-11', '2020-01-14', '2020-01-12', 'Nhà riêng (quê nhà)', 'Làm việc tại cộng đoàn khác', '0613102668', 'Nhà riêng (quê nhà)', 1, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(14, 4, 'Công việc hội dòng', '2021-03-19', '2021-03-25', '2021-03-25', 'Nhà riêng (Hà Nội)', 'Công tác quản lý', '0520196052', 'Nhà riêng (Hà Nội)', 7, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(15, 4, 'Nghỉ dưỡng', '2022-12-16', '2022-12-23', '2022-12-23', 'Bệnh viện Chợ Rẫy', 'Nghỉ dưỡng định kỳ', '0907935512', 'Bệnh viện Chợ Rẫy', 7, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(16, 4, 'Tham gia khóa tĩnh tâm', '2023-06-24', '2023-07-01', '2023-07-01', 'Tu viện Manila', 'Khóa tĩnh tâm Ignatius', '0727724081', 'Tu viện Manila', 3, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:14:59', NULL),
(17, 5, 'Công tác', '2020-01-26', '2020-01-28', '2020-01-28', 'Tu viện Manila', 'Công tác tại giáo xứ', '0546543044', 'Tu viện Manila', 3, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(18, 5, 'Tham dự hội nghị', '2021-03-01', '2021-03-03', '2021-03-03', 'Cộng đoàn Đà Lạt', 'Đại hội đại biểu', '0684186907', 'Cộng đoàn Đà Lạt', 3, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(19, 5, 'Công việc hội dòng', '2022-07-27', '2022-08-01', '2022-08-01', 'Trung tâm Tĩnh tâm Đức Mẹ', 'Kiểm tra cộng đoàn', '0656584977', 'Trung tâm Tĩnh tâm Đức Mẹ', 7, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(20, 5, 'Học tập - Bồi dưỡng', '2023-02-19', '2023-03-04', '2023-03-05', 'Trung tâm Mục vụ Linh mục', 'Tham gia khóa học thần học', '0290405404', 'Trung tâm Mục vụ Linh mục', 6, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(21, 5, 'Điều trị y tế', '2024-03-15', '2024-04-04', '2024-04-04', 'Cộng đoàn Bảo Lộc', 'Khám và điều trị bệnh', '0221745974', 'Cộng đoàn Bảo Lộc', 4, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(22, 6, 'Học tập - Bồi dưỡng', '2020-06-25', '2020-07-24', '2020-07-24', 'Bệnh viện Đà Lạt', 'Khóa đào tạo kỹ năng mục vụ', '0906483845', 'Bệnh viện Đà Lạt', 5, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(23, 6, 'Điều trị y tế', '2021-06-28', '2021-07-08', '2021-07-08', 'Cộng đoàn Sài Gòn', 'Phẫu thuật', '0595134821', 'Cộng đoàn Sài Gòn', 2, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(24, 6, 'Điều trị y tế', '2022-12-27', '2023-01-17', '2023-01-17', 'Tu viện Roma', 'Điều trị chuyên khoa', '0600123712', 'Tu viện Roma', 7, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(25, 6, 'Tham gia khóa tĩnh tâm', '2023-04-26', '2023-05-02', '2023-05-02', 'Bệnh viện Đà Lạt', 'Tĩnh tâm hàng năm', '0480070574', 'Bệnh viện Đà Lạt', 1, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:14:59', NULL),
(26, 6, 'Tham gia khóa tĩnh tâm', '2024-12-22', '2024-12-28', NULL, 'Bệnh viện Chợ Rẫy', 'Tĩnh tâm đặc biệt', '0256679778', 'Bệnh viện Chợ Rẫy', 7, 'Đang trong chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:14:59', NULL),
(27, 7, 'Tham quan hành hương', '2020-08-19', '2020-08-20', '2020-08-20', 'Nhà riêng (Hà Nội)', 'Tham quan tu viện', '0518855261', 'Nhà riêng (Hà Nội)', 5, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:14:59', NULL),
(28, 7, 'Công tác', '2021-08-11', '2021-08-13', '2021-08-13', 'Nhà riêng (Đà Lạt)', 'Tham gia dự án xã hội', '0361589433', 'Nhà riêng (Đà Lạt)', 6, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(29, 7, 'Thăm viếng cộng đoàn khác', '2022-04-10', '2022-04-13', '2022-04-13', 'Tu viện Manila', 'Thăm viếng chị em', '0187838767', 'Tu viện Manila', 2, 'Đã hoàn thành chuyến đi vắng thăm viếng cộng đoàn khác', NULL, '2025-12-20 03:14:59', NULL),
(30, 7, 'Nghỉ dưỡng', '2023-07-25', '2023-08-01', NULL, 'Cộng đoàn Hà Nội', 'Điều dưỡng sau ốm', '0376021233', 'Cộng đoàn Hà Nội', 6, 'Đang trong chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(31, 8, 'Công việc hội dòng', '2020-11-10', '2020-11-15', '2020-11-16', 'Cộng đoàn Hà Nội', 'Công tác quản lý', '0994103130', 'Cộng đoàn Hà Nội', 6, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(32, 8, 'Công tác', '2021-01-04', '2021-01-12', '2021-01-12', 'Nhà riêng (Hà Nội)', 'Hỗ trợ công tác hội dòng', '0973121884', 'Nhà riêng (Hà Nội)', 1, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(33, 8, 'Điều trị y tế', '2022-07-23', '2022-07-30', '2022-07-30', 'Tu viện Manila', 'Điều trị chuyên khoa', '0511395502', 'Tu viện Manila', 3, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(34, 8, 'Tham dự hội nghị', '2023-04-04', '2023-04-13', NULL, 'Tu viện Manila', 'Hội nghị mục vụ', '0262239561', 'Tu viện Manila', 4, 'Đang trong chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(35, 9, 'Thăm viếng cộng đoàn khác', '2020-03-11', '2020-03-12', '2020-03-12', 'Trung tâm Mục vụ Linh mục', 'Kỷ niệm đặc biệt', '0562748061', 'Trung tâm Mục vụ Linh mục', 6, 'Đã hoàn thành chuyến đi vắng thăm viếng cộng đoàn khác', NULL, '2025-12-20 03:14:59', NULL),
(36, 9, 'Tham dự hội nghị', '2021-01-07', '2021-01-10', '2021-01-10', 'Tu viện Roma', 'Hội nghị mục vụ', '0597280596', 'Tu viện Roma', 5, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(37, 9, 'Tham dự hội nghị', '2022-07-04', '2022-07-09', '2022-07-09', 'Cộng đoàn Sài Gòn', 'Hội nghị mục vụ', '0962962783', 'Cộng đoàn Sài Gòn', 2, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(38, 9, 'Học tập - Bồi dưỡng', '2023-04-27', '2023-05-14', NULL, 'Giáo phận Sài Gòn', 'Nghiên cứu sau đại học', '0581592097', 'Giáo phận Sài Gòn', 3, 'Đang trong chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(39, 10, 'Nghỉ dưỡng', '2020-05-25', '2020-05-28', '2020-05-26', 'Bệnh viện Đà Lạt', 'Điều dưỡng sau ốm', '0978120233', 'Bệnh viện Đà Lạt', 1, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(40, 10, 'Tham gia khóa tĩnh tâm', '2021-08-09', '2021-08-23', '2021-08-23', 'Trung tâm Tĩnh tâm Đức Mẹ', 'Tĩnh tâm dòng', '0369832897', 'Trung tâm Tĩnh tâm Đức Mẹ', 7, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:15:00', NULL),
(41, 10, 'Học tập - Bồi dưỡng', '2022-12-27', '2023-01-22', NULL, 'Tu viện Manila', 'Tham gia khóa học thần học', '0219684766', 'Tu viện Manila', 7, 'Đang trong chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(42, 11, 'Tham quan hành hương', '2020-06-01', '2020-06-08', '2020-06-08', 'Học viện Công giáo Việt Nam', 'Hành hương Đức Mẹ', '0464194664', 'Học viện Công giáo Việt Nam', 4, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(43, 11, 'Tham gia khóa tĩnh tâm', '2021-06-12', '2021-06-18', '2021-06-17', 'Nhà riêng (Đà Lạt)', 'Tĩnh tâm chuẩn bị khấn', '0755905222', 'Nhà riêng (Đà Lạt)', 6, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:15:00', NULL),
(44, 11, 'Tham dự hội nghị', '2022-07-03', '2022-07-10', '2022-07-10', 'Bệnh viện Chợ Rẫy', 'Hội nghị mục vụ', '0495928825', 'Bệnh viện Chợ Rẫy', 4, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:15:00', NULL),
(45, 11, 'Tham quan hành hương', '2023-10-11', '2023-10-12', '2023-10-12', 'Tu viện Manila', 'Viếng các thánh địa', '0880101020', 'Tu viện Manila', 6, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(46, 12, 'Hoạt động mục vụ', '2020-09-20', '2020-09-25', '2020-09-25', 'Cộng đoàn Đà Lạt', 'Hoạt động Caritas', '0256441001', 'Cộng đoàn Đà Lạt', 7, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(47, 12, 'Về thăm gia đình', '2021-11-07', '2021-11-09', '2021-11-11', 'Trung tâm Mục vụ Linh mục', 'Về thăm gia đình dịp lễ', '0438743219', 'Trung tâm Mục vụ Linh mục', 7, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(48, 12, 'Học tập - Bồi dưỡng', '2022-04-20', '2022-05-03', '2022-05-03', 'Nhà riêng (quê nhà)', 'Nghiên cứu sau đại học', '0334371357', 'Nhà riêng (quê nhà)', 3, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(49, 12, 'Điều trị y tế', '2023-05-20', '2023-06-07', '2023-06-07', 'Tu viện Manila', 'Tái khám định kỳ', '0792465437', 'Tu viện Manila', 2, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:15:00', NULL),
(50, 13, 'Khóa tu học', '2020-07-27', '2020-08-08', '2020-08-08', 'Giáo phận Sài Gòn', 'Tu học về đời sống thánh hiến', '0851463169', 'Giáo phận Sài Gòn', 6, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(51, 13, 'Nghỉ dưỡng', '2021-04-08', '2021-04-13', '2021-04-13', 'Cộng đoàn Đà Lạt', 'Chăm sóc sức khỏe', '0761568201', 'Cộng đoàn Đà Lạt', 2, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(52, 13, 'Về thăm gia đình', '2022-01-06', '2022-01-13', '2022-01-13', 'Nhà riêng (quê nhà)', 'Về thăm gia đình dịp lễ', '0789752219', 'Nhà riêng (quê nhà)', 4, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(53, 14, 'Công tác', '2020-10-16', '2020-10-25', '2020-10-25', 'Bệnh viện Đà Lạt', 'Tham gia dự án xã hội', '0665607440', 'Bệnh viện Đà Lạt', 7, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:15:00', NULL),
(54, 14, 'Điều trị y tế', '2021-02-08', '2021-02-18', '2021-02-18', 'Tu viện Sài Gòn', 'Điều trị chuyên khoa', '0204387465', 'Tu viện Sài Gòn', 1, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:15:00', NULL),
(55, 14, 'Tham quan hành hương', '2022-12-21', '2022-12-26', NULL, 'Học viện Công giáo Việt Nam', 'Hành hương La Vang', '0960289520', 'Học viện Công giáo Việt Nam', 7, 'Đang trong chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(56, 15, 'Hoạt động mục vụ', '2020-08-11', '2020-08-18', '2020-08-19', 'Cộng đoàn Sài Gòn', 'Phục vụ giới trẻ', '0586996674', 'Cộng đoàn Sài Gòn', 3, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(57, 15, 'Công tác', '2021-05-09', '2021-05-13', '2021-05-13', 'Cộng đoàn Hà Nội', 'Hỗ trợ công tác giáo dục', '0197399332', 'Cộng đoàn Hà Nội', 6, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:15:00', NULL),
(58, 15, 'Học tập - Bồi dưỡng', '2022-11-02', '2022-11-20', '2022-11-20', 'Nhà riêng (quê nhà)', 'Tham gia khóa học thần học', '0652710664', 'Nhà riêng (quê nhà)', 2, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(59, 16, 'Khóa tu học', '2022-08-05', '2022-08-16', '2022-08-16', 'Cộng đoàn Sài Gòn', 'Khóa tu học mục vụ', '0179926706', 'Cộng đoàn Sài Gòn', 6, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(60, 16, 'Nghỉ dưỡng', '2023-12-07', '2023-12-10', '2023-12-10', 'Trung tâm Mục vụ Linh mục', 'Chăm sóc sức khỏe', '0253773310', 'Trung tâm Mục vụ Linh mục', 4, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(61, 16, 'Khóa tu học', '2024-08-23', '2024-09-01', '2024-09-01', 'Tu viện Roma', 'Đào tạo liên tu hội', '0711604417', 'Tu viện Roma', 5, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(62, 17, 'Về thăm gia đình', '2024-03-24', '2024-03-29', '2024-03-29', 'Cộng đoàn Bảo Lộc', 'Về thăm gia đình dịp lễ', '0945923780', 'Cộng đoàn Bảo Lộc', 4, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(63, 17, 'Tham gia khóa tĩnh tâm', '2025-02-01', '2025-02-11', '2025-02-11', 'Giáo phận Đà Lạt', 'Tĩnh tâm hàng năm', '0862474006', 'Giáo phận Đà Lạt', 2, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:15:00', NULL),
(64, 17, 'Thăm viếng cộng đoàn khác', '2026-04-14', '2026-04-18', NULL, 'Bệnh viện Chợ Rẫy', 'Hỗ trợ cộng đoàn mới', '0831277704', 'Bệnh viện Chợ Rẫy', 4, 'Đang trong chuyến đi vắng thăm viếng cộng đoàn khác', NULL, '2025-12-20 03:15:00', NULL),
(65, 18, 'Công việc hội dòng', '2025-06-11', '2025-06-14', '2025-06-14', 'Học viện Công giáo Việt Nam', 'Kiểm tra cộng đoàn', '0560527473', 'Học viện Công giáo Việt Nam', 5, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:15:00', NULL),
(66, 18, 'Khóa tu học', '2026-06-13', '2026-06-19', '2026-06-19', 'Tu viện Sài Gòn', 'Khóa tu học mục vụ', '0155257893', 'Tu viện Sài Gòn', 4, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(67, 18, 'Tham quan hành hương', '2027-09-11', '2027-09-12', '2027-09-12', 'Trung tâm Tĩnh tâm Đức Mẹ', 'Hành hương Đức Mẹ', '0655504271', 'Trung tâm Tĩnh tâm Đức Mẹ', 6, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(68, 19, 'Về thăm gia đình', '2026-03-05', '2026-03-07', '2026-03-07', 'Cộng đoàn Hà Nội', 'Về thăm gia đình dịp lễ', '0563443496', 'Cộng đoàn Hà Nội', 3, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(69, 19, 'Công việc hội dòng', '2027-12-01', '2027-12-07', '2027-12-07', 'Bệnh viện Chợ Rẫy', 'Tổ chức sự kiện', '0276824667', 'Bệnh viện Chợ Rẫy', 6, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:15:00', NULL),
(70, 19, 'Hoạt động mục vụ', '2028-01-17', '2028-01-23', '2028-01-23', 'Nhà riêng (Sài Gòn)', 'Hoạt động Caritas', '0719266391', 'Nhà riêng (Sài Gòn)', 4, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(71, 20, 'Hoạt động mục vụ', '2028-06-21', '2028-06-25', '2028-06-25', 'Tu viện Manila', 'Phục vụ mục vụ giáo xứ', '0206418659', 'Tu viện Manila', 1, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(72, 20, 'Công tác', '2029-10-09', '2029-10-17', '2029-10-17', 'Tu viện Roma', 'Hỗ trợ công tác hội dòng', '0204211244', 'Tu viện Roma', 7, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:15:00', NULL),
(73, 20, 'Về thăm gia đình', '2030-07-03', '2030-07-07', '2030-07-05', 'Bệnh viện Chợ Rẫy', 'Chăm sóc cha mẹ già yếu', '0794339211', 'Bệnh viện Chợ Rẫy', 5, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departure_records`
--

CREATE TABLE `departure_records` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `departure_date` date NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `expected_return_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `destination` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `contact_address` text DEFAULT NULL,
  `approved_by` int(10) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `stage_at_departure` enum('inquiry','postulant','aspirant','novice','temporary_vows','perpetual_vows','left') DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `support_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `level` enum('secondary','bachelor','master','doctorate') NOT NULL,
  `major` varchar(150) DEFAULT NULL,
  `institution` varchar(200) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `certificate_url` varchar(255) DEFAULT NULL,
  `graduation_year` int(11) DEFAULT NULL,
  `status` enum('dang_hoc','da_tot_nghiep','tam_nghi','da_nghi') DEFAULT 'dang_hoc',
  `gpa` varchar(20) DEFAULT NULL,
  `thesis_title` varchar(500) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `education`
--

INSERT INTO `education` (`id`, `sister_id`, `level`, `major`, `institution`, `start_date`, `end_date`, `certificate_url`, `graduation_year`, `status`, `gpa`, `thesis_title`, `notes`, `documents`) VALUES
(1, 1, 'secondary', 'Khoa học tự nhiên', 'Trường THPT Trưng Vương', '1960-09-01', '1963-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(2, 1, 'bachelor', 'Văn học', 'Đại học Công giáo Thánh Tâm', '1964-09-01', '1968-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(3, 1, 'master', 'Giáo lý - Mục vụ', 'Đại học Y Dược TP.HCM', '1970-09-01', '1972-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(4, 1, 'bachelor', 'Văn học', 'Đại học Sư phạm TP.HCM', '1974-09-01', '1978-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(5, 2, 'secondary', 'Văn - Sử', 'Trường THPT Nguyễn Thị Minh Khai', '1965-09-01', '1968-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(6, 2, 'bachelor', 'Quản trị kinh doanh', 'Đại học Thánh Tâm - Manila', '1969-09-01', '1973-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(7, 2, 'master', 'Kinh thánh học', 'Đại học Lateran - Roma', '1975-09-01', '1977-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(8, 2, 'bachelor', 'Dược học', 'Đại học Thánh Tâm - Manila', '1979-09-01', '1983-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(9, 3, 'secondary', 'Toán - Lý', 'Trường THPT Nguyễn Thị Minh Khai', '1970-09-01', '1973-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(10, 3, 'bachelor', 'Âm nhạc', 'Đại học Lateran - Roma', '1974-09-01', '1978-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(11, 3, 'master', 'Quản trị nhân lực', 'Học viện Công giáo Việt Nam', '1980-09-01', '1982-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(12, 3, 'doctorate', 'Tâm lý học', 'Đại học Lateran - Roma', '1984-09-01', '1988-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(13, 4, 'secondary', 'Khoa học xã hội', 'Trường THPT Nguyễn Thị Minh Khai', '1975-09-01', '1978-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(14, 4, 'bachelor', 'Tâm lý học', 'Đại học Sư phạm TP.HCM', '1979-09-01', '1983-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(15, 4, 'master', 'Quản trị nhân lực', 'Đại học Thánh Tâm - Manila', '1985-09-01', '1987-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(16, 4, 'master', 'Công tác xã hội', 'Đại học Y Dược TP.HCM', '1989-09-01', '1991-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(17, 5, 'secondary', 'Toán - Lý', 'Trường THPT Marie Curie', '1980-09-01', '1983-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(18, 5, 'bachelor', 'Văn học', 'Học viện Công giáo Việt Nam', '1984-09-01', '1988-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(19, 5, 'master', 'Thần học hệ thống', 'Đại học Công giáo Thánh Tâm', '1990-09-01', '1992-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(20, 5, 'doctorate', 'Thần học giáo nghĩa', 'Đại học Thánh Tâm - Manila', '1994-09-01', '1998-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(21, 6, 'secondary', 'Toán - Lý', 'Trường THPT Trưng Vương', '1985-09-01', '1988-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(22, 6, 'bachelor', 'Âm nhạc', 'Đại học Salesianum - Roma', '1989-09-01', '1993-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(23, 6, 'master', 'Quản trị giáo dục', 'Đại học Thánh Tâm - Manila', '1995-09-01', '1997-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(24, 6, 'bachelor', 'Điều dưỡng', 'Đại học Thánh Tâm Antonianum - Roma', '1999-09-01', '2003-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(25, 6, 'master', 'Quản trị nhân lực', 'Đại học Khoa học Xã hội và Nhân văn TP.HCM', '2005-09-01', '2007-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(26, 7, 'secondary', 'Văn hóa tổng hợp', 'Trường THPT Trưng Vương', '1990-09-01', '1993-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(27, 7, 'bachelor', 'Kinh thánh học', 'Học viện Công giáo Việt Nam', '1994-09-01', '1998-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(28, 7, 'master', 'Tâm lý học lâm sàng', 'Đại học Santo Tomas - Manila', '2000-09-01', '2002-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(29, 7, 'bachelor', 'Điều dưỡng', 'Đại học Thánh Tâm - Manila', '2004-09-01', '2008-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(30, 8, 'secondary', 'Văn - Sử', 'Trường THPT Nguyễn Thị Minh Khai', '1995-09-01', '1998-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(31, 8, 'bachelor', 'Quản trị kinh doanh', 'Học viện Công giáo Việt Nam', '1999-09-01', '2003-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(32, 8, 'master', 'Công tác xã hội', 'Đại học Thánh Tâm - Manila', '2005-09-01', '2007-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(33, 8, 'master', 'Thần học hệ thống', 'Đại học Santo Tomas - Manila', '2009-09-01', '2011-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(34, 9, 'secondary', 'Văn - Sử', 'Trường THPT Nguyễn Thị Minh Khai', '2000-09-01', '2003-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(35, 9, 'bachelor', 'Thần học', 'Đại học Thánh Tâm - Manila', '2004-09-01', '2008-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(36, 9, 'master', 'Quản trị nhân lực', 'Đại học Lateran - Roma', '2010-09-01', '2012-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(37, 10, 'secondary', 'Văn hóa tổng hợp', 'Trường THPT Võ Thị Sáu', '2005-09-01', '2008-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(38, 10, 'bachelor', 'Dược học', 'Đại học Y Dược TP.HCM', '2009-09-01', '2013-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(39, 10, 'master', 'Giáo lý - Mục vụ', 'Đại học Công giáo Thánh Tâm', '2015-09-01', '2017-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(40, 11, 'secondary', 'Khoa học xã hội', 'Trường THPT Trưng Vương', '2007-09-01', '2010-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(41, 11, 'bachelor', 'Giáo dục học', 'Học viện Công giáo Việt Nam', '2011-09-01', '2015-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(42, 11, 'master', 'Luật học', 'Đại học Khoa học Xã hội và Nhân văn TP.HCM', '2017-09-01', '2019-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(43, 11, 'master', 'Thần học hệ thống', 'Đại học Gregoriana - Roma', '2021-09-01', '2023-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(44, 12, 'secondary', 'Toán - Lý', 'Trường THPT Võ Thị Sáu', '2009-09-01', '2012-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(45, 12, 'bachelor', 'Quản trị kinh doanh', 'Đại học Thánh Tâm Antonianum - Roma', '2013-09-01', '2017-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(46, 12, 'master', 'Quản trị nhân lực', 'Đại học Y Dược TP.HCM', '2019-09-01', '2021-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(47, 12, 'bachelor', 'Triết học', 'Học viện Công giáo Việt Nam', '2023-09-01', '2027-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(48, 13, 'secondary', 'Khoa học tự nhiên', 'Trường THPT Trưng Vương', '2011-09-01', '2014-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(49, 13, 'bachelor', 'Tâm lý học', 'Đại học Y Dược TP.HCM', '2015-09-01', '2019-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(50, 13, 'master', 'Luật học', 'Đại học Gregoriana - Roma', '2021-09-01', '2023-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(51, 14, 'secondary', 'Văn hóa tổng hợp', 'Trường THPT Võ Thị Sáu', '2013-09-01', '2016-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(52, 14, 'bachelor', 'Văn học', 'Đại học Công giáo Thánh Tâm', '2017-09-01', '2021-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(53, 14, 'master', 'Giáo lý - Mục vụ', 'Đại học Công giáo Thánh Tâm', '2023-09-01', '2025-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(54, 15, 'secondary', 'Văn - Sử', 'Trường THPT Marie Curie', '2015-09-01', '2018-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(55, 15, 'bachelor', 'Mục vụ', 'Đại học Salesianum - Roma', '2019-09-01', '2023-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(56, 15, 'bachelor', 'Điều dưỡng', 'Đại học Y Dược TP.HCM', '2025-09-01', '2029-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(57, 16, 'secondary', 'Khoa học xã hội', 'Trường THPT Võ Thị Sáu', '2017-09-01', '2020-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(58, 16, 'bachelor', 'Dược học', 'Học viện Công giáo Việt Nam', '2021-09-01', '2025-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(59, 17, 'secondary', 'Khoa học xã hội', 'Trường THPT Gia Định', '2019-09-01', '2022-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(60, 18, 'secondary', 'Văn - Sử', 'Trường THPT Gia Định', '2020-09-01', '2023-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(61, 19, 'secondary', 'Văn - Sử', 'Trường THPT Võ Thị Sáu', '2021-09-01', '2024-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(62, 20, 'secondary', 'Văn hóa tổng hợp', 'Trường THPT Võ Thị Sáu', '2023-09-01', '2026-06-30', NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `education_levels`
--

CREATE TABLE `education_levels` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `education_levels`
--

INSERT INTO `education_levels` (`id`, `code`, `name`, `description`, `display_order`, `color`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'secondary', 'Trung học', NULL, 1, '#6c757d', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(3, 'vocational', 'Trung cấp', NULL, 3, '#20c997', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(4, 'college', 'Cao đẳng', NULL, 4, '#fd7e14', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(5, 'bachelor', 'Đại học', NULL, 5, '#0d6efd', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(6, 'master', 'Thạc sĩ', NULL, 6, '#6f42c1', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(7, 'doctorate', 'Tiến sĩ', NULL, 7, '#dc3545', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(8, 'certificate', 'Chứng chỉ', NULL, 8, '#ffc107', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(9, 'other', 'Khác', NULL, 99, '#adb5bd', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(11, 'sau_đại_học', 'sau đại học', NULL, 9, '#20c997', 1, '2025-12-18 15:28:51', '2025-12-18 15:28:51'),
(12, 'high_school', 'Phổ thông', NULL, 2, '#17a2b8', 1, '2025-12-18 16:13:12', '2025-12-18 16:13:12');

-- --------------------------------------------------------

--
-- Table structure for table `evaluations`
--

CREATE TABLE `evaluations` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `evaluation_type` varchar(50) DEFAULT NULL,
  `period` varchar(100) DEFAULT NULL,
  `evaluation_date` date DEFAULT NULL,
  `evaluator` varchar(255) DEFAULT NULL,
  `spiritual_life` tinyint(3) UNSIGNED DEFAULT NULL,
  `community_life` tinyint(3) UNSIGNED DEFAULT NULL,
  `apostolic_work` tinyint(3) UNSIGNED DEFAULT NULL,
  `personal_development` tinyint(3) UNSIGNED DEFAULT NULL,
  `overall_rating` tinyint(3) UNSIGNED DEFAULT NULL,
  `strengths` text DEFAULT NULL,
  `weaknesses` text DEFAULT NULL,
  `evaluation_period` varchar(50) NOT NULL,
  `evaluator_id` int(10) UNSIGNED DEFAULT NULL,
  `spiritual_life_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `community_life_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `mission_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `personality_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `obedience_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `general_comments` text DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluations`
--

INSERT INTO `evaluations` (`id`, `sister_id`, `evaluation_type`, `period`, `evaluation_date`, `evaluator`, `spiritual_life`, `community_life`, `apostolic_work`, `personal_development`, `overall_rating`, `strengths`, `weaknesses`, `evaluation_period`, `evaluator_id`, `spiritual_life_score`, `community_life_score`, `mission_score`, `personality_score`, `obedience_score`, `general_comments`, `recommendations`, `notes`, `documents`, `created_at`, `updated_at`) VALUES
(2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2020', NULL, 78, 77, 74, 78, 76, 'Điểm mạnh: Gương mẫu trong đời sống cầu nguyện. Đời sống đức tin vững vàng.\nĐiểm yếu: Cần nghỉ ngơi nhiều hơn.\nGhi chú: Đánh giá kỳ Năm 2020. Tổng điểm: 76/100.', 'Học hỏi thêm về công nghệ hiện đại. Tiếp tục phát huy các điểm mạnh hiện có.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2021', NULL, 81, 75, 77, 80, 78, 'Điểm mạnh: Gương mẫu trong đời sống cầu nguyện. Đời sống đức tin vững vàng. Khôn ngoan trong lời khuyên.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Năm 2021. Tổng điểm: 78/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Cân bằng giữa công việc và nghỉ ngơi.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 3/2022', NULL, 82, 88, 77, 82, 82, 'Điểm mạnh: Trưởng thành về mặt thiêng liêng. Bình an và ổn định trong tâm hồn.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Quý 3/2022. Tổng điểm: 82/100.', 'Cân bằng giữa công việc và nghỉ ngơi.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 4/2023', NULL, 74, 78, 69, 74, 73, 'Điểm mạnh: Gương mẫu trong đời sống cầu nguyện. Kinh nghiệm sống đáng quý. Là điểm tựa cho cộng đoàn.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới. Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Quý 4/2023. Tổng điểm: 73/100.', 'Cân bằng giữa công việc và nghỉ ngơi. Dành thời gian tĩnh tâm và đọc kinh sách. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(6, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Tháng 1/2024', NULL, 87, 83, 77, 81, 82, 'Điểm mạnh: Đời sống đức tin vững vàng.\nĐiểm yếu: Sức khỏe cần được chăm sóc đặc biệt.\nGhi chú: Đánh giá kỳ Tháng 1/2024. Tổng điểm: 82/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Tăng cường trao đổi, chia sẻ với cộng đoàn. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(7, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2021', NULL, 80, 77, 71, 78, 76, 'Điểm mạnh: Bình an và ổn định trong tâm hồn. Là điểm tựa cho cộng đoàn.\nĐiểm yếu: Sức khỏe cần được chăm sóc đặc biệt. Cần nghỉ ngơi nhiều hơn.\nGhi chú: Đánh giá kỳ Năm 2021. Tổng điểm: 76/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách. Tiếp tục phát huy các điểm mạnh hiện có.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(8, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2022', NULL, 84, 82, 78, 87, 82, 'Điểm mạnh: Khôn ngoan trong lời khuyên. Kinh nghiệm sống đáng quý.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Năm 2022. Tổng điểm: 82/100.', 'Tham gia thêm các khóa đào tạo chuyên môn. Tiếp tục phát huy các điểm mạnh hiện có.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(9, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2023', NULL, 82, 86, 83, 86, 84, 'Điểm mạnh: Đời sống đức tin vững vàng. Kinh nghiệm sống đáng quý. Trưởng thành về mặt thiêng liêng.\nĐiểm yếu: Cần nghỉ ngơi nhiều hơn.\nGhi chú: Đánh giá kỳ Năm 2023. Tổng điểm: 84/100.', 'Rèn luyện đức khiêm nhường và vâng lời. Dành thời gian tĩnh tâm và đọc kinh sách.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(10, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 1/2024', NULL, 84, 84, 80, 80, 82, 'Điểm mạnh: Là điểm tựa cho cộng đoàn. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Sức khỏe cần được chăm sóc đặc biệt.\nGhi chú: Đánh giá kỳ 6 tháng 1/2024. Tổng điểm: 82/100.', 'Chăm sóc sức khỏe thường xuyên. Rèn luyện đức khiêm nhường và vâng lời.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(11, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2020', NULL, 94, 89, 84, 90, 89, 'Điểm mạnh: Gương mẫu trong đời sống cầu nguyện. Là điểm tựa cho cộng đoàn.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Năm 2020. Tổng điểm: 89/100.', 'Rèn luyện đức khiêm nhường và vâng lời. Dành thời gian tĩnh tâm và đọc kinh sách.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(12, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 1/2021', NULL, 81, 76, 76, 83, 79, 'Điểm mạnh: Đời sống đức tin vững vàng. Khôn ngoan trong lời khuyên.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới. Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ 6 tháng 1/2021. Tổng điểm: 79/100.', 'Cân bằng giữa công việc và nghỉ ngơi. Rèn luyện đức khiêm nhường và vâng lời. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(13, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2022', NULL, 90, 87, 88, 93, 89, 'Điểm mạnh: Khôn ngoan trong lời khuyên. Trưởng thành về mặt thiêng liêng.\nĐiểm yếu: Cần nghỉ ngơi nhiều hơn. Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Năm 2022. Tổng điểm: 89/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(14, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 2/2023', NULL, 94, 99, 90, 95, 94, 'Điểm mạnh: Đời sống đức tin vững vàng. Gương mẫu trong đời sống cầu nguyện. Kinh nghiệm sống đáng quý.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Quý 2/2023. Tổng điểm: 94/100.', 'Rèn luyện đức khiêm nhường và vâng lời. Phát triển kỹ năng lãnh đạo. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(15, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 82, 89, 76, 80, 81, 'Điểm mạnh: Bình an và ổn định trong tâm hồn. Là điểm tựa cho cộng đoàn.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 81/100.', 'Chăm sóc sức khỏe thường xuyên. Phát triển kỹ năng lãnh đạo. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(16, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 4/2020', NULL, 93, 88, 85, 90, 89, 'Điểm mạnh: Gương mẫu trong đời sống cầu nguyện. Là điểm tựa cho cộng đoàn. Bình an và ổn định trong tâm hồn.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Quý 4/2020. Tổng điểm: 89/100.', 'Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(17, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 1/2021', NULL, 78, 75, 72, 78, 75, 'Điểm mạnh: Khôn ngoan trong lời khuyên. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Cần nghỉ ngơi nhiều hơn.\nGhi chú: Đánh giá kỳ 6 tháng 1/2021. Tổng điểm: 75/100.', 'Chăm sóc sức khỏe thường xuyên.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(18, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 2/2022', NULL, 78, 74, 69, 79, 75, 'Điểm mạnh: Là điểm tựa cho cộng đoàn. Đời sống đức tin vững vàng.\nĐiểm yếu: Cần nghỉ ngơi nhiều hơn.\nGhi chú: Đánh giá kỳ 6 tháng 2/2022. Tổng điểm: 75/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(19, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 3/2023', NULL, 87, 87, 85, 82, 85, 'Điểm mạnh: Bình an và ổn định trong tâm hồn. Đời sống đức tin vững vàng. Kinh nghiệm sống đáng quý.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Quý 3/2023. Tổng điểm: 85/100.', 'Phát triển kỹ năng lãnh đạo. Tăng cường trao đổi, chia sẻ với cộng đoàn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(20, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 81, 83, 81, 85, 82, 'Điểm mạnh: Kinh nghiệm sống đáng quý. Đời sống đức tin vững vàng.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 82/100.', 'Chăm sóc sức khỏe thường xuyên. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(21, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2021', NULL, 83, 91, 83, 89, 86, 'Điểm mạnh: Là điểm tựa cho cộng đoàn. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng. Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Năm 2021. Tổng điểm: 86/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(22, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2022', NULL, 91, 86, 88, 85, 87, 'Điểm mạnh: Là điểm tựa cho cộng đoàn. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới. Sức khỏe cần được chăm sóc đặc biệt.\nGhi chú: Đánh giá kỳ Năm 2022. Tổng điểm: 87/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Rèn luyện đức khiêm nhường và vâng lời. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(23, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 4/2023', NULL, 83, 75, 72, 81, 77, 'Điểm mạnh: Trưởng thành về mặt thiêng liêng. Kinh nghiệm sống đáng quý. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Quý 4/2023. Tổng điểm: 77/100.', 'Học hỏi thêm về công nghệ hiện đại. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(24, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 3/2024', NULL, 91, 96, 94, 91, 93, 'Điểm mạnh: Đời sống đức tin vững vàng. Gương mẫu trong đời sống cầu nguyện. Kinh nghiệm sống đáng quý.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng. Cần nghỉ ngơi nhiều hơn.\nGhi chú: Đánh giá kỳ Quý 3/2024. Tổng điểm: 93/100.', 'Tham gia các hoạt động tông đồ. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(25, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2020', NULL, 88, 92, 85, 92, 89, 'Điểm mạnh: Đời sống đức tin vững vàng. Bình an và ổn định trong tâm hồn. Khôn ngoan trong lời khuyên.\nĐiểm yếu: Sức khỏe cần được chăm sóc đặc biệt. Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Năm 2020. Tổng điểm: 89/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Chăm sóc sức khỏe thường xuyên.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(26, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2021', NULL, 76, 81, 77, 78, 78, 'Điểm mạnh: Đời sống đức tin vững vàng. Là điểm tựa cho cộng đoàn. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng.\nGhi chú: Đánh giá kỳ Năm 2021. Tổng điểm: 78/100.', 'Rèn luyện đức khiêm nhường và vâng lời. Tiếp tục phát huy các điểm mạnh hiện có. Tăng cường trao đổi, chia sẻ với cộng đoàn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(27, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2022', NULL, 93, 90, 87, 93, 90, 'Điểm mạnh: Khôn ngoan trong lời khuyên. Đời sống đức tin vững vàng. Kinh nghiệm sống đáng quý.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Năm 2022. Tổng điểm: 90/100.', 'Tham gia thêm các khóa đào tạo chuyên môn. Chăm sóc sức khỏe thường xuyên. Tăng cường trao đổi, chia sẻ với cộng đoàn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(28, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 1/2023', NULL, 97, 93, 91, 90, 92, 'Điểm mạnh: Trưởng thành về mặt thiêng liêng. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Khó khăn trong việc thích nghi với công nghệ mới.\nGhi chú: Đánh giá kỳ Quý 1/2023. Tổng điểm: 92/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(29, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 4/2024', NULL, 91, 99, 88, 93, 92, 'Điểm mạnh: Bình an và ổn định trong tâm hồn. Gương mẫu trong đời sống cầu nguyện.\nĐiểm yếu: Cần hỗ trợ trong các công việc nặng. Sức khỏe cần được chăm sóc đặc biệt.\nGhi chú: Đánh giá kỳ Quý 4/2024. Tổng điểm: 92/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Tham gia thêm các khóa đào tạo chuyên môn. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(30, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Đặc biệt 2022', NULL, 82, 85, 79, 80, 81, 'Điểm mạnh: Cân bằng giữa công việc và đời sống cầu nguyện. Gương mẫu trong đời sống tu. Kinh nghiệm trong công tác mục vụ.\nĐiểm yếu: Đôi khi quá tập trung vào công việc.\nGhi chú: Đánh giá kỳ Đặc biệt 2022. Tổng điểm: 81/100.', 'Tham gia các hoạt động tông đồ. Cân bằng giữa công việc và nghỉ ngơi.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(31, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Đặc biệt 2023', NULL, 91, 89, 94, 93, 91, 'Điểm mạnh: Sẵn sàng phục vụ và hy sinh. Hỗ trợ tích cực chị em trẻ. Gương mẫu trong đời sống tu.\nĐiểm yếu: Đôi khi quá tập trung vào công việc. Cần chia sẻ công việc với chị em khác.\nGhi chú: Đánh giá kỳ Đặc biệt 2023. Tổng điểm: 91/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(32, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 94, 94, 88, 94, 92, 'Điểm mạnh: Kinh nghiệm trong công tác mục vụ. Sẵn sàng phục vụ và hy sinh.\nĐiểm yếu: Cần chia sẻ công việc với chị em khác.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 92/100.', 'Học hỏi thêm về công nghệ hiện đại. Tăng cường trao đổi, chia sẻ với cộng đoàn. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(33, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Tháng 12/2022', NULL, 72, 74, 76, 74, 74, 'Điểm mạnh: Sẵn sàng phục vụ và hy sinh. Kinh nghiệm trong công tác mục vụ.\nĐiểm yếu: Đôi khi quá tập trung vào công việc.\nGhi chú: Đánh giá kỳ Tháng 12/2022. Tổng điểm: 74/100.', 'Học hỏi thêm về công nghệ hiện đại. Cân bằng giữa công việc và nghỉ ngơi. Chăm sóc sức khỏe thường xuyên.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(34, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 2/2023', NULL, 84, 81, 80, 88, 83, 'Điểm mạnh: Đóng góp tích cực trong các quyết định cộng đoàn. Gương mẫu trong đời sống tu.\nĐiểm yếu: Đôi khi quá tập trung vào công việc.\nGhi chú: Đánh giá kỳ 6 tháng 2/2023. Tổng điểm: 83/100.', 'Rèn luyện đức khiêm nhường và vâng lời. Chăm sóc sức khỏe thường xuyên. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(35, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 82, 87, 77, 89, 83, 'Điểm mạnh: Đóng góp tích cực trong các quyết định cộng đoàn. Hỗ trợ tích cực chị em trẻ.\nĐiểm yếu: Cần chia sẻ công việc với chị em khác. Đôi khi quá tập trung vào công việc.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 83/100.', 'Cân bằng giữa công việc và nghỉ ngơi. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(36, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2021', NULL, 83, 85, 77, 79, 81, 'Điểm mạnh: Hỗ trợ tích cực chị em trẻ. Gương mẫu trong đời sống tu. Kinh nghiệm trong công tác mục vụ.\nĐiểm yếu: Cần chia sẻ công việc với chị em khác.\nGhi chú: Đánh giá kỳ Năm 2021. Tổng điểm: 81/100.', 'Học hỏi thêm về công nghệ hiện đại. Cân bằng giữa công việc và nghỉ ngơi. Rèn luyện đức khiêm nhường và vâng lời.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(37, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2022', NULL, 96, 91, 85, 93, 91, 'Điểm mạnh: Khả năng tổ chức và lãnh đạo tốt. Đóng góp tích cực trong các quyết định cộng đoàn.\nĐiểm yếu: Cần dành thời gian nghỉ ngơi nhiều hơn. Cần chia sẻ công việc với chị em khác.\nGhi chú: Đánh giá kỳ Năm 2022. Tổng điểm: 91/100.', 'Cân bằng giữa công việc và nghỉ ngơi. Tăng cường trao đổi, chia sẻ với cộng đoàn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(38, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2023', NULL, 88, 93, 85, 87, 88, 'Điểm mạnh: Cân bằng giữa công việc và đời sống cầu nguyện. Hỗ trợ tích cực chị em trẻ.\nĐiểm yếu: Stress do áp lực công việc. Cần chia sẻ công việc với chị em khác.\nGhi chú: Đánh giá kỳ Năm 2023. Tổng điểm: 88/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Rèn luyện đức khiêm nhường và vâng lời. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(39, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 79, 83, 78, 80, 80, 'Điểm mạnh: Khả năng tổ chức và lãnh đạo tốt. Gương mẫu trong đời sống tu.\nĐiểm yếu: Cần dành thời gian nghỉ ngơi nhiều hơn. Đôi khi quá tập trung vào công việc.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 80/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Cân bằng giữa công việc và nghỉ ngơi. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(40, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 3/2022', NULL, 86, 90, 81, 90, 86, 'Điểm mạnh: Có tinh thần vâng lời và khiêm tốn. Tham gia tích cực các hoạt động cộng đoàn. Nhiệt tình, năng động trong công việc.\nĐiểm yếu: Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ Quý 3/2022. Tổng điểm: 86/100.', 'Chăm sóc sức khỏe thường xuyên. Dành thời gian tĩnh tâm và đọc kinh sách.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(41, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Đặc biệt 2023', NULL, 81, 84, 77, 86, 82, 'Điểm mạnh: Trách nhiệm với công việc được giao. Tham gia tích cực các hoạt động cộng đoàn. Đời sống cầu nguyện đều đặn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Đôi lúc thiếu kiên nhẫn.\nGhi chú: Đánh giá kỳ Đặc biệt 2023. Tổng điểm: 82/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách. Rèn luyện đức khiêm nhường và vâng lời. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(42, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Đặc biệt 2024', NULL, 88, 84, 82, 92, 86, 'Điểm mạnh: Trách nhiệm với công việc được giao. Quan hệ tốt với chị em trong cộng đoàn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc.\nGhi chú: Đánh giá kỳ Đặc biệt 2024. Tổng điểm: 86/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách. Tham gia các hoạt động tông đồ. Tăng cường trao đổi, chia sẻ với cộng đoàn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(43, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 2/2022', NULL, 83, 81, 77, 88, 82, 'Điểm mạnh: Có tinh thần vâng lời và khiêm tốn.\nĐiểm yếu: Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Quý 2/2022. Tổng điểm: 82/100.', 'Học hỏi thêm về công nghệ hiện đại. Tiếp tục phát huy các điểm mạnh hiện có.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(44, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Tháng 9/2023', NULL, 81, 85, 70, 79, 78, 'Điểm mạnh: Trách nhiệm với công việc được giao. Nhiệt tình, năng động trong công việc. Có tinh thần vâng lời và khiêm tốn.\nĐiểm yếu: Cần học cách cân bằng công việc.\nGhi chú: Đánh giá kỳ Tháng 9/2023. Tổng điểm: 78/100.', 'Tham gia thêm các khóa đào tạo chuyên môn. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(45, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 2/2024', NULL, 90, 86, 83, 85, 86, 'Điểm mạnh: Quan hệ tốt với chị em trong cộng đoàn. Ham học hỏi, sẵn sàng tiếp thu điều mới. Nhiệt tình, năng động trong công việc.\nĐiểm yếu: Cần học cách cân bằng công việc. Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ 6 tháng 2/2024. Tổng điểm: 86/100.', 'Phát triển kỹ năng lãnh đạo. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(46, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2022', NULL, 95, 95, 84, 89, 90, 'Điểm mạnh: Tham gia tích cực các hoạt động cộng đoàn. Quan hệ tốt với chị em trong cộng đoàn. Có tinh thần vâng lời và khiêm tốn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ Năm 2022. Tổng điểm: 90/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(47, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2023', NULL, 82, 88, 84, 90, 86, 'Điểm mạnh: Tham gia tích cực các hoạt động cộng đoàn. Có tinh thần vâng lời và khiêm tốn.\nĐiểm yếu: Cần học cách cân bằng công việc. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Năm 2023. Tổng điểm: 86/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Tham gia các hoạt động tông đồ.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(48, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 85, 87, 85, 86, 85, 'Điểm mạnh: Đời sống cầu nguyện đều đặn. Ham học hỏi, sẵn sàng tiếp thu điều mới.\nĐiểm yếu: Đôi lúc thiếu kiên nhẫn. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 85/100.', 'Tiếp tục phát huy các điểm mạnh hiện có.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(49, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Tháng 12/2022', NULL, 87, 84, 79, 82, 83, 'Điểm mạnh: Có tinh thần vâng lời và khiêm tốn. Đời sống cầu nguyện đều đặn.\nĐiểm yếu: Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ Tháng 12/2022. Tổng điểm: 83/100.', 'Cân bằng giữa công việc và nghỉ ngơi. Dành thời gian tĩnh tâm và đọc kinh sách.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(50, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2023', NULL, 80, 80, 80, 79, 79, 'Điểm mạnh: Quan hệ tốt với chị em trong cộng đoàn. Nhiệt tình, năng động trong công việc.\nĐiểm yếu: Cần học cách cân bằng công việc. Còn non kinh nghiệm trong công việc.\nGhi chú: Đánh giá kỳ Năm 2023. Tổng điểm: 79/100.', 'Tham gia các hoạt động tông đồ. Chăm sóc sức khỏe thường xuyên. Tiếp tục phát huy các điểm mạnh hiện có.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(51, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 82, 79, 75, 83, 79, 'Điểm mạnh: Tham gia tích cực các hoạt động cộng đoàn. Ham học hỏi, sẵn sàng tiếp thu điều mới. Quan hệ tốt với chị em trong cộng đoàn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 79/100.', 'Cân bằng giữa công việc và nghỉ ngơi. Phát triển kỹ năng lãnh đạo. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(52, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2022', NULL, 88, 90, 80, 92, 87, 'Điểm mạnh: Nhiệt tình, năng động trong công việc. Có tinh thần vâng lời và khiêm tốn.\nĐiểm yếu: Cần tăng cường kỹ năng giao tiếp. Còn non kinh nghiệm trong công việc.\nGhi chú: Đánh giá kỳ Năm 2022. Tổng điểm: 87/100.', 'Chăm sóc sức khỏe thường xuyên. Tiếp tục phát huy các điểm mạnh hiện có. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(53, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2023', NULL, 80, 81, 70, 75, 76, 'Điểm mạnh: Ham học hỏi, sẵn sàng tiếp thu điều mới. Đời sống cầu nguyện đều đặn.\nĐiểm yếu: Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ Năm 2023. Tổng điểm: 76/100.', 'Tham gia các hoạt động tông đồ. Dành thời gian tĩnh tâm và đọc kinh sách. Cân bằng giữa công việc và nghỉ ngơi.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(54, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2024', NULL, 86, 93, 86, 88, 88, 'Điểm mạnh: Quan hệ tốt với chị em trong cộng đoàn. Nhiệt tình, năng động trong công việc.\nĐiểm yếu: Cần học cách cân bằng công việc.\nGhi chú: Đánh giá kỳ Năm 2024. Tổng điểm: 88/100.', 'Rèn luyện đức khiêm nhường và vâng lời. Tham gia thêm các khóa đào tạo chuyên môn. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(55, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Tháng 12/2022', NULL, 82, 79, 75, 84, 80, 'Điểm mạnh: Ham học hỏi, sẵn sàng tiếp thu điều mới. Có tinh thần vâng lời và khiêm tốn. Nhiệt tình, năng động trong công việc.\nĐiểm yếu: Đôi lúc thiếu kiên nhẫn.\nGhi chú: Đánh giá kỳ Tháng 12/2022. Tổng điểm: 80/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Rèn luyện đức khiêm nhường và vâng lời.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(56, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 4/2023', NULL, 82, 80, 80, 86, 82, 'Điểm mạnh: Quan hệ tốt với chị em trong cộng đoàn. Tham gia tích cực các hoạt động cộng đoàn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ Quý 4/2023. Tổng điểm: 82/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Tham gia các hoạt động tông đồ. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(57, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 2/2024', NULL, 84, 88, 80, 84, 84, 'Điểm mạnh: Đời sống cầu nguyện đều đặn. Tham gia tích cực các hoạt động cộng đoàn.\nĐiểm yếu: Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ 6 tháng 2/2024. Tổng điểm: 84/100.', 'Phát triển kỹ năng lãnh đạo. Tăng cường trao đổi, chia sẻ với cộng đoàn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(58, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Đặc biệt 2022', NULL, 78, 82, 78, 76, 78, 'Điểm mạnh: Ham học hỏi, sẵn sàng tiếp thu điều mới. Có tinh thần vâng lời và khiêm tốn. Đời sống cầu nguyện đều đặn.\nĐiểm yếu: Đôi lúc thiếu kiên nhẫn. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Đặc biệt 2022. Tổng điểm: 78/100.', 'Tham gia các hoạt động tông đồ. Tiếp tục phát huy các điểm mạnh hiện có.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(59, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 2/2023', NULL, 92, 91, 88, 95, 91, 'Điểm mạnh: Quan hệ tốt với chị em trong cộng đoàn. Nhiệt tình, năng động trong công việc.\nĐiểm yếu: Cần học cách cân bằng công việc.\nGhi chú: Đánh giá kỳ Quý 2/2023. Tổng điểm: 91/100.', 'Rèn luyện đức khiêm nhường và vâng lời. Phát triển kỹ năng lãnh đạo.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(60, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 2/2024', NULL, 93, 93, 89, 94, 92, 'Điểm mạnh: Có tinh thần vâng lời và khiêm tốn. Quan hệ tốt với chị em trong cộng đoàn. Đời sống cầu nguyện đều đặn.\nĐiểm yếu: Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Quý 2/2024. Tổng điểm: 92/100.', 'Phát triển kỹ năng lãnh đạo. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(61, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 1/2024', NULL, 86, 82, 79, 88, 83, 'Điểm mạnh: Tham gia tích cực các hoạt động cộng đoàn. Nhiệt tình, năng động trong công việc.\nĐiểm yếu: Cần rèn luyện thêm về đời sống thinh lặng.\nGhi chú: Đánh giá kỳ 6 tháng 1/2024. Tổng điểm: 83/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Rèn luyện đức khiêm nhường và vâng lời.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(62, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2025', NULL, 81, 83, 77, 78, 79, 'Điểm mạnh: Nhiệt tình, năng động trong công việc. Trách nhiệm với công việc được giao. Tham gia tích cực các hoạt động cộng đoàn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Cần học cách cân bằng công việc.\nGhi chú: Đánh giá kỳ Năm 2025. Tổng điểm: 79/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Học hỏi thêm về công nghệ hiện đại. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(63, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2026', NULL, 89, 90, 84, 90, 88, 'Điểm mạnh: Quan hệ tốt với chị em trong cộng đoàn. Ham học hỏi, sẵn sàng tiếp thu điều mới.\nĐiểm yếu: Cần tăng cường kỹ năng giao tiếp. Đôi lúc thiếu kiên nhẫn.\nGhi chú: Đánh giá kỳ Năm 2026. Tổng điểm: 88/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(64, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2025', NULL, 86, 83, 78, 81, 82, 'Điểm mạnh: Nhiệt tình, năng động trong công việc. Tham gia tích cực các hoạt động cộng đoàn. Quan hệ tốt với chị em trong cộng đoàn.\nĐiểm yếu: Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Năm 2025. Tổng điểm: 82/100.', 'Tham gia thêm các khóa đào tạo chuyên môn. Dành thời gian tĩnh tâm và đọc kinh sách.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(65, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2026', NULL, 79, 88, 81, 83, 82, 'Điểm mạnh: Tham gia tích cực các hoạt động cộng đoàn. Ham học hỏi, sẵn sàng tiếp thu điều mới.\nĐiểm yếu: Cần tăng cường kỹ năng giao tiếp. Còn non kinh nghiệm trong công việc.\nGhi chú: Đánh giá kỳ Năm 2026. Tổng điểm: 82/100.', 'Phát triển kỹ năng lãnh đạo. Rèn luyện đức khiêm nhường và vâng lời. Cân bằng giữa công việc và nghỉ ngơi.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(66, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 2/2027', NULL, 82, 87, 80, 80, 82, 'Điểm mạnh: Tham gia tích cực các hoạt động cộng đoàn. Có tinh thần vâng lời và khiêm tốn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ 6 tháng 2/2027. Tổng điểm: 82/100.', 'Tăng cường trao đổi, chia sẻ với cộng đoàn. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(67, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6 tháng 2/2026', NULL, 83, 78, 72, 82, 78, 'Điểm mạnh: Ham học hỏi, sẵn sàng tiếp thu điều mới. Tham gia tích cực các hoạt động cộng đoàn.\nĐiểm yếu: Cần rèn luyện thêm về đời sống thinh lặng. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ 6 tháng 2/2026. Tổng điểm: 78/100.', 'Học hỏi thêm về công nghệ hiện đại. Tiếp tục phát huy các điểm mạnh hiện có. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(68, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quý 3/2027', NULL, 90, 88, 90, 90, 89, 'Điểm mạnh: Đời sống cầu nguyện đều đặn. Có tinh thần vâng lời và khiêm tốn. Quan hệ tốt với chị em trong cộng đoàn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Quý 3/2027. Tổng điểm: 89/100.', 'Học hỏi thêm về công nghệ hiện đại. Rèn luyện đức khiêm nhường và vâng lời. Cân bằng giữa công việc và nghỉ ngơi.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(69, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2028', NULL, 96, 94, 89, 87, 91, 'Điểm mạnh: Có tinh thần vâng lời và khiêm tốn. Ham học hỏi, sẵn sàng tiếp thu điều mới. Trách nhiệm với công việc được giao.\nĐiểm yếu: Đôi lúc thiếu kiên nhẫn. Cần học cách cân bằng công việc.\nGhi chú: Đánh giá kỳ Năm 2028. Tổng điểm: 91/100.', 'Tiếp tục phát huy các điểm mạnh hiện có. Rèn luyện đức khiêm nhường và vâng lời. Học hỏi thêm về công nghệ hiện đại.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(70, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Tháng 4/2028', NULL, 89, 93, 86, 89, 89, 'Điểm mạnh: Trách nhiệm với công việc được giao.\nĐiểm yếu: Còn non kinh nghiệm trong công việc. Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Tháng 4/2028. Tổng điểm: 89/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách. Tăng cường trao đổi, chia sẻ với cộng đoàn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(71, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2029', NULL, 80, 73, 76, 80, 77, 'Điểm mạnh: Ham học hỏi, sẵn sàng tiếp thu điều mới. Tham gia tích cực các hoạt động cộng đoàn.\nĐiểm yếu: Cần tăng cường kỹ năng giao tiếp.\nGhi chú: Đánh giá kỳ Năm 2029. Tổng điểm: 77/100.', 'Dành thời gian tĩnh tâm và đọc kinh sách. Tham gia thêm các khóa đào tạo chuyên môn.', NULL, NULL, '2025-12-20 03:17:16', NULL),
(72, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Năm 2030', NULL, 98, 91, 86, 92, 91, 'Điểm mạnh: Nhiệt tình, năng động trong công việc. Tham gia tích cực các hoạt động cộng đoàn. Đời sống cầu nguyện đều đặn.\nĐiểm yếu: Còn non kinh nghiệm trong công việc.\nGhi chú: Đánh giá kỳ Năm 2030. Tổng điểm: 91/100.', 'Tham gia các hoạt động tông đồ. Tham gia thêm các khóa đào tạo chuyên môn. Cân bằng giữa công việc và nghỉ ngơi.', NULL, NULL, '2025-12-20 03:17:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `health_records`
--

CREATE TABLE `health_records` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `general_health` varchar(50) NOT NULL DEFAULT 'good',
  `chronic_diseases` text DEFAULT NULL,
  `work_limitations` text DEFAULT NULL,
  `checkup_date` date DEFAULT NULL,
  `next_checkup_date` date DEFAULT NULL,
  `checkup_place` varchar(150) DEFAULT NULL,
  `doctor` varchar(150) DEFAULT NULL,
  `blood_pressure` varchar(20) DEFAULT NULL,
  `heart_rate` varchar(20) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `treatment` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `health_records`
--

INSERT INTO `health_records` (`id`, `sister_id`, `general_health`, `chronic_diseases`, `work_limitations`, `checkup_date`, `next_checkup_date`, `checkup_place`, `doctor`, `blood_pressure`, `heart_rate`, `weight`, `height`, `diagnosis`, `treatment`, `notes`, `documents`, `created_at`, `updated_at`) VALUES
(1, 1, 'average', NULL, 'Cần nghỉ ngơi thường xuyên', '2020-03-28', NULL, 'Bệnh viện Bình Dân', NULL, NULL, NULL, NULL, NULL, 'Tiểu đường type 2, đang kiểm soát', 'Insulin/thuốc uống, theo dõi đường huyết', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:03', NULL),
(2, 1, 'average', 'Tiểu đường type 2', 'Cần chế độ ăn đặc biệt', '2021-07-27', NULL, 'Bệnh viện Bình Dân', NULL, NULL, NULL, NULL, NULL, 'Thoái hóa khớp gối', 'Thuốc chống viêm, glucosamine', 'Khám định kỳ năm 2021. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(3, 1, 'good', 'Suy giảm thị lực, Tiểu đường type 2', 'Hạn chế thời gian làm việc', '2022-12-28', NULL, 'Phòng khám Đa khoa Sài Gòn', NULL, NULL, NULL, NULL, NULL, 'Cao huyết áp độ 1, cần dùng thuốc thường xuyên', 'Thuốc hạ huyết áp, kiểm soát định kỳ', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(4, 1, 'average', 'Hen suyễn', 'Hạn chế thời gian làm việc', '2023-03-14', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Suy giảm thị lực do tuổi già', 'Đeo kính, khám mắt 6 tháng/lần', 'Khám định kỳ năm 2023. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(5, 1, 'weak', 'Rối loạn tiền đình', 'Cần nghỉ ngơi thường xuyên', '2024-10-04', NULL, 'Bệnh viện Nhân Dân 115', NULL, NULL, NULL, NULL, NULL, 'Suy giảm trí nhớ nhẹ', 'Tập luyện trí nhớ, hoạt động xã hội', 'Khám định kỳ năm 2024. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(6, 2, 'weak', 'Hen suyễn', 'Cần chế độ ăn đặc biệt', '2020-11-18', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Tiểu đường type 2, đang kiểm soát', 'Insulin/thuốc uống, theo dõi đường huyết', 'Khám định kỳ năm 2020. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(7, 2, 'average', 'Rối loạn lipid máu', 'Cần chế độ ăn đặc biệt', '2021-05-12', NULL, 'Bệnh viện Bình Dân', NULL, NULL, NULL, NULL, NULL, 'Cao huyết áp độ 1, cần dùng thuốc thường xuyên', 'Thuốc hạ huyết áp, kiểm soát định kỳ', 'Khám định kỳ năm 2021. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(8, 2, 'weak', 'Rối loạn lipid máu, Rối loạn tiền đình', 'Cần chế độ ăn đặc biệt', '2022-02-05', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Tiểu đường type 2, đang kiểm soát', 'Insulin/thuốc uống, theo dõi đường huyết', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(9, 2, 'average', 'Loãng xương', 'Cần đeo kính khi làm việc', '2023-07-23', NULL, 'Bệnh viện Thống Nhất', NULL, NULL, NULL, NULL, NULL, 'Loãng xương ở tuổi mãn kinh', 'Canxi, vitamin D, tránh ngã', 'Khám định kỳ năm 2023. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(10, 2, 'weak', 'Loãng xương', 'Cần chế độ ăn đặc biệt', '2024-11-28', NULL, 'Bệnh viện Thống Nhất', NULL, NULL, NULL, NULL, NULL, 'Thoái hóa khớp gối', 'Thuốc chống viêm, glucosamine', 'Khám định kỳ năm 2024. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(11, 3, 'good', 'Viêm khớp dạng thấp', 'Hạn chế thời gian làm việc', '2020-05-10', NULL, 'Phòng khám Đa khoa Sài Gòn', NULL, NULL, NULL, NULL, NULL, 'Thoái hóa khớp gối', 'Thuốc chống viêm, glucosamine', 'Khám định kỳ năm 2020. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(12, 3, 'average', 'Đau dạ dày mãn tính, Hen suyễn', 'Cần nghỉ ngơi thường xuyên', '2021-01-25', NULL, 'Phòng khám Cộng đoàn', NULL, NULL, NULL, NULL, NULL, 'Suy giảm trí nhớ nhẹ', 'Tập luyện trí nhớ, hoạt động xã hội', 'Khám định kỳ năm 2021. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(13, 3, 'weak', 'Suy giảm thị lực', 'Tránh tiếp xúc bụi, khói', '2022-01-24', NULL, 'Bệnh viện Chợ Rẫy', NULL, NULL, NULL, NULL, NULL, 'Tiểu đường type 2, đang kiểm soát', 'Insulin/thuốc uống, theo dõi đường huyết', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(14, 3, 'good', 'Đau dạ dày mãn tính, Đau cột sống', 'Cần đeo kính khi làm việc', '2023-08-22', NULL, 'Bệnh viện Chợ Rẫy', NULL, NULL, NULL, NULL, NULL, 'Loãng xương ở tuổi mãn kinh', 'Canxi, vitamin D, tránh ngã', 'Khám định kỳ năm 2023. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(15, 4, 'good', 'Đau dạ dày mãn tính, Đau cột sống', 'Hạn chế công việc nặng nhọc', '2020-12-10', NULL, 'Bệnh viện Nhân Dân 115', NULL, NULL, NULL, NULL, NULL, 'Rối loạn nhịp tim nhẹ', 'Thuốc điều hòa nhịp tim, theo dõi định kỳ', 'Khám định kỳ năm 2020. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(16, 4, 'average', NULL, 'Cần chế độ ăn đặc biệt', '2021-12-13', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Loãng xương ở tuổi mãn kinh', 'Canxi, vitamin D, tránh ngã', 'Khám định kỳ năm 2021. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:03', NULL),
(17, 4, 'average', 'Hen suyễn', 'Hạn chế đi lại xa', '2022-09-18', NULL, 'Phòng khám Gia đình', NULL, NULL, NULL, NULL, NULL, 'Rối loạn nhịp tim nhẹ', 'Thuốc điều hòa nhịp tim, theo dõi định kỳ', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(18, 4, 'average', 'Cao huyết áp', 'Hạn chế công việc nặng nhọc', '2023-11-25', NULL, 'Phòng khám Gia đình', NULL, NULL, NULL, NULL, NULL, 'Rối loạn nhịp tim nhẹ', 'Thuốc điều hòa nhịp tim, theo dõi định kỳ', 'Khám định kỳ năm 2023. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(19, 5, 'good', 'Suy giảm thị lực, Rối loạn tiền đình', 'Cần nghỉ ngơi thường xuyên', '2020-03-24', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Cholesterol cao, cần điều chỉnh chế độ ăn', 'Điều chỉnh chế độ ăn, giảm mỡ động vật', 'Khám định kỳ năm 2020. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(20, 5, 'good', NULL, NULL, '2021-10-19', NULL, 'Bệnh viện Thống Nhất', NULL, NULL, NULL, NULL, NULL, 'Suy giảm thị lực do tuổi già', 'Đeo kính, khám mắt 6 tháng/lần', 'Khám định kỳ năm 2021. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:03', NULL),
(21, 5, 'good', 'Tiểu đường type 2', 'Cần chế độ ăn đặc biệt', '2022-03-02', NULL, 'Phòng khám Gia đình', NULL, NULL, NULL, NULL, NULL, 'Tiểu đường type 2, đang kiểm soát', 'Insulin/thuốc uống, theo dõi đường huyết', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(22, 5, 'average', 'Mất ngủ mãn tính, Loãng xương', 'Tránh tiếp xúc bụi, khói', '2023-11-28', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Suy giảm thị lực do tuổi già', 'Đeo kính, khám mắt 6 tháng/lần', 'Khám định kỳ năm 2023. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:03', NULL),
(23, 6, 'average', NULL, 'Tránh môi trường ồn ào', '2020-02-09', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Viêm khớp vai gáy', 'Thuốc giảm đau, xoa bóp', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:03', NULL),
(24, 6, 'good', NULL, NULL, '2022-07-03', NULL, 'Phòng khám Đa khoa Sài Gòn', NULL, NULL, NULL, NULL, NULL, 'Đau cột sống thắt lưng do lao động', 'Vật lý trị liệu, bài tập thể dục', 'Khám định kỳ năm 2022. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:03', NULL),
(25, 6, 'good', 'Loãng xương, Viêm khớp dạng thấp', 'Tránh môi trường ồn ào', '2024-04-02', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Đường huyết biên cao', 'Điều chỉnh chế độ ăn, kiểm soát cân nặng', 'Khám định kỳ năm 2024. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(26, 7, 'average', NULL, NULL, '2020-07-05', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Đau cột sống thắt lưng do lao động', 'Vật lý trị liệu, bài tập thể dục', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(27, 7, 'weak', 'Cao huyết áp', 'Cần đeo kính khi làm việc', '2021-11-08', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Huyết áp hơi cao, cần theo dõi', 'Thuốc hạ huyết áp nhẹ, tập thể dục', 'Khám định kỳ năm 2021. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(28, 7, 'average', NULL, 'Cần nghỉ ngơi thường xuyên', '2022-09-18', NULL, 'Phòng khám Đa khoa Sài Gòn', NULL, NULL, NULL, NULL, NULL, 'Đau cột sống thắt lưng do lao động', 'Vật lý trị liệu, bài tập thể dục', 'Khám định kỳ năm 2022. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(29, 7, 'good', 'Mất ngủ mãn tính', 'Hạn chế công việc nặng nhọc', '2023-03-07', NULL, 'Trung tâm Y tế Quận 1', NULL, NULL, NULL, NULL, NULL, 'Rối loạn tiêu hóa', 'Thuốc điều hòa tiêu hóa', 'Khám định kỳ năm 2023. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(30, 8, 'good', NULL, NULL, '2020-08-04', NULL, 'Bệnh viện Nhân Dân 115', NULL, NULL, NULL, NULL, NULL, 'Đau cột sống thắt lưng do lao động', 'Vật lý trị liệu, bài tập thể dục', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(31, 8, 'good', 'Rối loạn lipid máu', 'Cần chế độ ăn đặc biệt', '2022-05-14', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Rối loạn tiêu hóa', 'Thuốc điều hòa tiêu hóa', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(32, 8, 'average', 'Đau dạ dày mãn tính', 'Hạn chế công việc đòi hỏi tập trung cao', '2024-03-05', NULL, 'Phòng khám Đa khoa Sài Gòn', NULL, NULL, NULL, NULL, NULL, 'Viêm khớp vai gáy', 'Thuốc giảm đau, xoa bóp', 'Khám định kỳ năm 2024. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(33, 9, 'good', NULL, NULL, '2020-12-13', NULL, 'Trung tâm Y tế Quận 1', NULL, NULL, NULL, NULL, NULL, 'Viêm khớp vai gáy', 'Thuốc giảm đau, xoa bóp', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(34, 9, 'good', 'Viêm khớp dạng thấp', 'Hạn chế thời gian làm việc', '2022-06-05', NULL, 'Phòng khám Cộng đoàn', NULL, NULL, NULL, NULL, NULL, 'Stress và mệt mỏi mãn tính', 'Tư vấn tâm lý, nghỉ ngơi hợp lý', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(35, 9, 'good', NULL, NULL, '2024-05-17', NULL, 'Bệnh viện Nhân Dân 115', NULL, NULL, NULL, NULL, NULL, 'Rối loạn tiêu hóa', 'Thuốc điều hòa tiêu hóa', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(36, 10, 'good', NULL, NULL, '2020-02-15', NULL, 'Phòng khám Gia đình', NULL, NULL, NULL, NULL, NULL, 'Sức khỏe tốt, chỉ số bình thường', 'Bổ sung vitamin và khoáng chất', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(37, 10, 'good', 'Viêm khớp dạng thấp', 'Tránh stress cao', '2022-12-17', NULL, 'Phòng khám Gia đình', NULL, NULL, NULL, NULL, NULL, 'Stress và mệt mỏi mãn tính', 'Tư vấn tâm lý, nghỉ ngơi hợp lý', 'Khám định kỳ năm 2022. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(38, 10, 'good', 'Đau dạ dày mãn tính', 'Hạn chế đi lại xa', '2024-12-20', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Huyết áp hơi cao, cần theo dõi', 'Thuốc hạ huyết áp nhẹ, tập thể dục', 'Khám định kỳ năm 2024. Tiếp tục theo dõi và điều trị bệnh mãn tính.', NULL, '2025-12-20 03:12:04', NULL),
(39, 11, 'average', NULL, NULL, '2020-04-06', NULL, 'Phòng khám Cộng đoàn', NULL, NULL, NULL, NULL, NULL, 'Cận thị nhẹ', 'Tư vấn quản lý stress, giấc ngủ', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(40, 11, 'good', NULL, NULL, '2022-05-25', NULL, 'Phòng khám Cộng đoàn', NULL, NULL, NULL, NULL, NULL, 'Rối loạn giấc ngủ do căng thẳng', 'Thuốc giảm đau, nghỉ ngơi', 'Khám định kỳ năm 2022. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(41, 11, 'good', NULL, NULL, '2024-09-18', NULL, 'Bệnh viện Nhân Dân 115', NULL, NULL, NULL, NULL, NULL, 'Cholesterol cao, cần điều chỉnh chế độ ăn', 'Điều chỉnh chế độ ăn, giảm mỡ động vật', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(42, 12, 'good', NULL, NULL, '2020-03-08', NULL, 'Bệnh viện Thống Nhất', NULL, NULL, NULL, NULL, NULL, 'Cận thị nhẹ', 'Tư vấn quản lý stress, giấc ngủ', 'Khám định kỳ năm 2020. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(43, 12, 'good', NULL, NULL, '2022-06-02', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Viêm dạ dày do stress học tập', 'Kê đơn kính cận, khám mắt định kỳ', 'Khám định kỳ năm 2022. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(44, 12, 'good', NULL, NULL, '2024-11-19', NULL, 'Bệnh viện Đại học Y Dược', NULL, NULL, NULL, NULL, NULL, 'Viêm amidan', NULL, 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(45, 13, 'good', NULL, NULL, '2021-04-05', NULL, 'Bệnh viện Đại học Y Dược', NULL, NULL, NULL, NULL, NULL, 'Viêm dạ dày do stress học tập', 'Kê đơn kính cận, khám mắt định kỳ', 'Khám định kỳ năm 2021. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(46, 13, 'good', NULL, NULL, '2023-03-03', NULL, 'Bệnh viện Nhân Dân 115', NULL, NULL, NULL, NULL, NULL, 'Rối loạn giấc ngủ do căng thẳng', 'Thuốc giảm đau, nghỉ ngơi', 'Khám định kỳ năm 2023. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(47, 13, 'average', NULL, 'Hạn chế thời gian làm việc', '2025-12-18', NULL, 'Phòng khám Cộng đoàn', NULL, NULL, NULL, NULL, NULL, 'Rối loạn giấc ngủ do căng thẳng', 'Thuốc giảm đau, nghỉ ngơi', 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(48, 14, 'good', NULL, NULL, '2023-03-06', NULL, 'Bệnh viện Đại học Y Dược', NULL, NULL, NULL, NULL, NULL, 'Đau đầu do stress', 'Kháng sinh, thuốc giảm viêm', 'Khám định kỳ năm 2023. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(49, 14, 'good', NULL, NULL, '2024-08-20', NULL, 'Bệnh viện Thống Nhất', NULL, NULL, NULL, NULL, NULL, 'Đau đầu do stress', 'Kháng sinh, thuốc giảm viêm', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(50, 14, 'good', NULL, NULL, '2025-11-13', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Viêm amidan', NULL, 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(51, 15, 'good', NULL, NULL, '2025-11-09', NULL, 'Trung tâm Y tế Quận 1', NULL, NULL, NULL, NULL, NULL, 'Sức khỏe tốt, chỉ số bình thường', 'Bổ sung vitamin và khoáng chất', 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(52, 15, 'good', NULL, NULL, '2026-11-27', NULL, 'Phòng khám Gia đình', NULL, NULL, NULL, NULL, NULL, 'Thiếu máu nhẹ do dinh dưỡng', 'Thuốc bảo vệ dạ dày, điều chỉnh chế độ ăn', 'Khám định kỳ năm 2026. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(53, 15, 'good', NULL, NULL, '2027-03-26', NULL, 'Bệnh viện Bình Dân', NULL, NULL, NULL, NULL, NULL, 'Viêm dạ dày do stress học tập', 'Kê đơn kính cận, khám mắt định kỳ', 'Khám định kỳ năm 2027. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(54, 16, 'good', NULL, NULL, '2023-06-08', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Đau đầu do stress', 'Kháng sinh, thuốc giảm viêm', 'Khám định kỳ năm 2023. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(55, 16, 'good', NULL, NULL, '2024-10-03', NULL, 'Bệnh viện Nhân Dân 115', NULL, NULL, NULL, NULL, NULL, 'Thiếu máu nhẹ do dinh dưỡng', 'Thuốc bảo vệ dạ dày, điều chỉnh chế độ ăn', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(56, 16, 'good', NULL, NULL, '2025-03-18', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Cận thị nhẹ', 'Tư vấn quản lý stress, giấc ngủ', 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(57, 17, 'good', NULL, NULL, '2023-09-02', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Viêm dạ dày do stress học tập', 'Kê đơn kính cận, khám mắt định kỳ', 'Khám định kỳ năm 2023. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(58, 17, 'good', NULL, NULL, '2024-07-07', NULL, 'Bệnh viện Chợ Rẫy', NULL, NULL, NULL, NULL, NULL, 'Rối loạn giấc ngủ do căng thẳng', 'Thuốc giảm đau, nghỉ ngơi', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(59, 17, 'good', NULL, NULL, '2025-03-04', NULL, 'Phòng khám Gia đình', NULL, NULL, NULL, NULL, NULL, 'Đau đầu do stress', 'Kháng sinh, thuốc giảm viêm', 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(60, 18, 'good', NULL, NULL, '2023-09-13', NULL, 'Trung tâm Y tế Quận 1', NULL, NULL, NULL, NULL, NULL, 'Đau đầu do stress', 'Kháng sinh, thuốc giảm viêm', 'Khám định kỳ năm 2023. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(61, 18, 'good', NULL, NULL, '2024-08-28', NULL, 'Phòng khám Đa khoa Sài Gòn', NULL, NULL, NULL, NULL, NULL, 'Rối loạn giấc ngủ do căng thẳng', 'Thuốc giảm đau, nghỉ ngơi', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(62, 18, 'good', NULL, NULL, '2025-07-24', NULL, 'Bệnh viện Bình Dân', NULL, NULL, NULL, NULL, NULL, 'Thiếu máu nhẹ do dinh dưỡng', 'Thuốc bảo vệ dạ dày, điều chỉnh chế độ ăn', 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(63, 19, 'good', NULL, NULL, '2024-11-08', NULL, 'Bệnh viện Tâm Hòa', NULL, NULL, NULL, NULL, NULL, 'Sức khỏe tốt, chỉ số bình thường', 'Bổ sung vitamin và khoáng chất', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(64, 19, 'good', NULL, NULL, '2025-04-16', NULL, 'Bệnh viện Nhi Đồng 1', NULL, NULL, NULL, NULL, NULL, 'Thiếu máu nhẹ do dinh dưỡng', 'Thuốc bảo vệ dạ dày, điều chỉnh chế độ ăn', 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(65, 19, 'average', NULL, NULL, '2026-03-28', NULL, 'Trung tâm Y tế Quận 1', NULL, NULL, NULL, NULL, NULL, 'Cận thị nhẹ', 'Tư vấn quản lý stress, giấc ngủ', 'Khám định kỳ năm 2026. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(66, 20, 'good', NULL, NULL, '2026-12-01', NULL, 'Phòng khám Cộng đoàn', NULL, NULL, NULL, NULL, NULL, 'Viêm dạ dày do stress học tập', 'Kê đơn kính cận, khám mắt định kỳ', 'Khám định kỳ năm 2026. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(67, 20, 'good', NULL, NULL, '2025-03-03', NULL, 'Phòng khám Đa khoa Sài Gòn', NULL, NULL, NULL, NULL, NULL, 'Thiếu máu nhẹ do dinh dưỡng', 'Thuốc bảo vệ dạ dày, điều chỉnh chế độ ăn', 'Khám định kỳ năm 2025. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL),
(68, 20, 'good', NULL, NULL, '2024-08-16', NULL, 'Trung tâm Y tế Quận 1', NULL, NULL, NULL, NULL, NULL, 'Đau đầu do stress', 'Kháng sinh, thuốc giảm viêm', 'Khám định kỳ năm 2024. Khuyến cáo duy trì lối sống lành mạnh.', NULL, '2025-12-20 03:12:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `journey_stages`
--

CREATE TABLE `journey_stages` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `journey_stages`
--

INSERT INTO `journey_stages` (`id`, `code`, `name`, `description`, `display_order`, `color`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'de_tu', 'Đệ tử', NULL, 7, '#6f42c1', 1, '2025-12-18 13:30:37', '2025-12-18 13:39:24'),
(2, 'aspirant', 'Ứng sinh', NULL, 1, '#17a2b8', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(3, 'pre_aspirant', 'Tiền ứng sinh', NULL, 2, '#20c997', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(5, 'novice', 'Tập sinh viện', NULL, 4, '#ffc107', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(6, 'temporary_vows', 'Khấn tạm', NULL, 5, '#fd7e14', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(7, 'perpetual_vows', 'Khấn trọn', NULL, 6, '#dc3545', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24');

-- --------------------------------------------------------

--
-- Table structure for table `missions`
--

CREATE TABLE `missions` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(100) NOT NULL,
  `specific_role` varchar(150) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `missions`
--

INSERT INTO `missions` (`id`, `sister_id`, `field`, `specific_role`, `organization`, `address`, `start_date`, `end_date`, `notes`) VALUES
(1, 1, 'healthcare', 'Y tá', NULL, NULL, '2000-05-01', '0000-00-00', 'Quản lý phòng khám cộng đoàn'),
(2, 1, 'pastoral', 'Trợ lý Mục vụ', NULL, NULL, '2006-07-01', '2013-08-30', 'Đồng hành với giới trẻ'),
(3, 1, 'social', 'Nuôi dưỡng trẻ mồ côi', NULL, NULL, '2014-08-01', '2018-05-30', 'Quản lý nhà nuôi dưỡng'),
(4, 1, 'media', 'Videographer', NULL, NULL, '2019-04-01', '2023-01-30', 'Quản lý các kênh truyền thông'),
(5, 1, 'publishing', 'Nhà văn', NULL, NULL, '2024-08-01', '2028-10-30', 'Dịch thuật các tài liệu tôn giáo'),
(6, 2, 'education', 'Giáo viên THPT', NULL, NULL, '2000-05-01', '2005-05-30', 'Đồng hành cùng học sinh trong hành trình học tập'),
(7, 2, 'social', 'Nuôi dưỡng trẻ mồ côi', NULL, NULL, '2006-08-01', '2013-03-30', 'Phục vụ người nghèo và yếu đuối'),
(8, 2, 'media', 'Quản lý website', NULL, NULL, '2014-04-01', '2017-11-30', 'Phát triển nền tảng truyền thông'),
(9, 2, 'pastoral', 'Hướng dẫn đời sống Kitô', NULL, NULL, '2018-02-01', '2025-10-30', 'Hướng dẫn các tông đồ giáo xứ'),
(10, 3, 'pastoral', 'Phụ trách Caritas', NULL, NULL, '2000-06-01', '2006-03-30', 'Nuôi dưỡng đời sống đức tin'),
(11, 3, 'education', 'Thư viện trưởng', NULL, NULL, '2007-06-01', '2012-12-30', 'Xây dựng chương trình giáo dục toàn diện'),
(12, 3, 'healthcare', 'Dược sĩ', NULL, NULL, '2013-12-01', '2018-09-30', 'Quản lý phòng khám cộng đoàn'),
(13, 3, 'social', 'Nuôi dưỡng trẻ mồ côi', NULL, NULL, '2019-02-01', '2026-10-30', 'Tổ chức các chương trình từ thiện'),
(14, 4, 'healthcare', 'Quản lý phòng khám', NULL, NULL, '2000-08-01', '2004-04-30', 'Quản lý phòng khám cộng đoàn'),
(15, 4, 'pastoral', 'Phụ trách Ca đoàn', NULL, NULL, '2005-03-01', '2008-04-30', 'Nuôi dưỡng đời sống đức tin'),
(16, 4, 'social', 'Quản lý Trung tâm xã hội', NULL, NULL, '2009-02-01', '2015-07-30', 'Hỗ trợ trẻ em có hoàn cảnh khó khăn'),
(17, 4, 'education', 'Giáo viên Giáo lý', NULL, NULL, '2016-11-01', NULL, 'Phát triển năng khiếu học sinh'),
(18, 5, 'pastoral', 'Phụ trách Tông đồ Tin mừng', NULL, NULL, '2000-09-01', '2007-08-30', 'Nuôi dưỡng đời sống đức tin'),
(19, 5, 'social', 'Hỗ trợ người nghèo', NULL, NULL, '2008-03-01', '2013-08-30', 'Phục vụ người nghèo và yếu đuối'),
(20, 5, 'healthcare', 'Quản lý phòng khám', NULL, NULL, '2014-02-01', '2019-11-30', 'Quản lý phòng khám cộng đoàn'),
(21, 5, 'publishing', 'Quản lý phát hành', NULL, NULL, '2020-12-01', '2027-12-30', 'Viết sách và bài giảng'),
(22, 6, 'media', 'Graphic Designer', NULL, NULL, '2000-05-01', '2003-04-30', 'Thiết kế hình ảnh và video'),
(23, 6, 'publishing', 'Dịch giả', NULL, NULL, '2004-12-01', '2008-12-30', 'Quản lý nhà xuất bản'),
(24, 6, 'social', 'Tư vấn tâm lý', NULL, NULL, '2009-11-01', '2012-12-30', 'Tổ chức các chương trình từ thiện'),
(25, 6, 'education', 'Hiệu trưởng', NULL, NULL, '2013-02-01', '2016-05-30', 'Đồng hành cùng học sinh trong hành trình học tập'),
(26, 6, 'pastoral', 'Giáo lý viên', NULL, NULL, '2017-06-01', NULL, 'Nuôi dưỡng đời sống đức tin'),
(27, 7, 'healthcare', 'Chăm sóc người bệnh', NULL, NULL, '2000-02-01', '2007-08-30', 'Tư vấn và hướng dẫn sức khỏe'),
(28, 7, 'education', 'Giáo viên THPT', NULL, NULL, '2008-02-01', '2012-01-30', 'Quản lý và điều hành nhà trường'),
(29, 7, 'social', 'Quản lý Trung tâm xã hội', NULL, NULL, '2013-05-01', NULL, 'Quản lý nhà nuôi dưỡng'),
(30, 8, 'pastoral', 'Hướng dẫn đời sống Kitô', NULL, NULL, '2002-07-01', '2009-05-30', 'Tổ chức các khóa tĩnh tâm'),
(31, 8, 'publishing', 'Phụ trách xuất bản', NULL, NULL, '2010-11-01', '2015-11-30', 'Viết sách và bài giảng'),
(32, 8, 'education', 'Giáo viên Tiểu học', NULL, NULL, '2016-04-01', '2021-09-30', 'Xây dựng chương trình giáo dục toàn diện'),
(33, 8, 'healthcare', 'Tư vấn sức khỏe', NULL, NULL, '2022-08-01', NULL, 'Chăm sóc người bệnh và người già'),
(34, 9, 'social', 'Tư vấn tâm lý', NULL, NULL, '2007-02-01', '2012-10-30', 'Quản lý nhà nuôi dưỡng'),
(35, 9, 'pastoral', 'Phụ trách Caritas', NULL, NULL, '2013-12-01', '2017-07-30', 'Nuôi dưỡng đời sống đức tin'),
(36, 9, 'education', 'Phó hiệu trưởng', NULL, NULL, '2018-07-01', '2024-10-30', 'Giảng dạy và nuôi dưỡng tâm hồn học sinh'),
(37, 9, 'publishing', 'Hiệu đính viên', NULL, NULL, '2025-11-01', NULL, 'Quản lý nhà xuất bản'),
(38, 10, 'education', 'Phó hiệu trưởng', NULL, NULL, '2012-05-01', '2015-09-30', 'Quản lý và điều hành nhà trường'),
(39, 10, 'pastoral', 'Phụ trách Giới trẻ', NULL, NULL, '2016-12-01', '2023-04-30', 'Phục vụ trong các hoạt động Giáo xứ'),
(40, 10, 'Giáo dục', 'Phụ trách Caritas', NULL, NULL, '2024-06-30', NULL, 'Tư vấn và hỗ trợ tâm lý'),
(41, 11, 'pastoral', 'Hướng dẫn tĩnh tâm', NULL, NULL, '2014-02-01', '2019-03-30', 'Tổ chức các khóa tĩnh tâm'),
(42, 11, 'social', 'Phụ trách Caritas', NULL, NULL, '2020-07-01', '0000-00-00', 'Phục vụ người nghèo và yếu đuối'),
(43, 11, 'education', 'Thư viện trưởng', NULL, NULL, '2024-07-01', NULL, 'Phát triển năng khiếu học sinh'),
(44, 12, 'media', 'Content Creator', NULL, NULL, '2016-06-01', '2020-05-30', 'Sản xuất nội dung số'),
(45, 12, 'healthcare', 'Chăm sóc người bệnh', NULL, NULL, '2021-06-01', '2025-06-30', 'Quản lý phòng khám cộng đoàn'),
(46, 13, 'pastoral', 'Hướng dẫn Legio Mariae', NULL, NULL, '2018-01-01', '2024-08-30', 'Hướng dẫn các tông đồ giáo xứ'),
(47, 13, 'social', 'Hỗ trợ người nghèo', NULL, NULL, '2025-07-01', '2032-04-30', 'Hỗ trợ trẻ em có hoàn cảnh khó khăn'),
(48, 14, 'social', 'Nuôi dưỡng trẻ mồ côi', NULL, NULL, '2020-12-01', '2024-09-30', 'Tư vấn và hỗ trợ tâm lý'),
(49, 14, 'education', 'Giáo viên Âm nhạc', NULL, NULL, '2025-11-01', '2032-05-30', 'Xây dựng chương trình giáo dục toàn diện'),
(50, 15, 'education', 'Giáo viên Âm nhạc', NULL, NULL, '2022-02-01', '2026-09-30', 'Quản lý và điều hành nhà trường'),
(51, 16, 'social', 'Tư vấn tâm lý', NULL, NULL, '2024-02-01', '2027-05-30', 'Tổ chức các chương trình từ thiện'),
(52, 17, 'pastoral', 'Hướng dẫn tĩnh tâm', NULL, NULL, '2026-02-01', '2029-06-30', 'Nuôi dưỡng đời sống đức tin'),
(53, 18, 'pastoral', 'Phụ trách Ca đoàn', NULL, NULL, '2027-05-01', NULL, 'Hướng dẫn các tông đồ giáo xứ'),
(54, 19, 'media', 'Nhiếp ảnh gia', NULL, NULL, '2028-01-01', '2031-10-30', 'Truyền bá tin mừng qua mạng xã hội'),
(55, 20, 'education', 'Giáo viên Tiểu học', NULL, NULL, '2030-07-01', '2035-12-30', 'Xây dựng chương trình giáo dục toàn diện');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('info','warning','success','error','birthday','anniversary','reminder') DEFAULT 'info',
  `title` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'Tên permission (vd: users.view, sisters.create)',
  `display_name` varchar(255) NOT NULL COMMENT 'Tên hiển thị',
  `description` text DEFAULT NULL COMMENT 'Mô tả permission',
  `module` varchar(50) NOT NULL COMMENT 'Module/nhóm chức năng (users, sisters, evaluations...)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `module`, `created_at`, `updated_at`, `is_active`, `sort_order`) VALUES
(1, 'sisters.view', 'Xem danh sách nữ tu', 'Quyền xem danh sách nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(2, 'sisters.create', 'Tạo hồ sơ mới', 'Tạo hồ sơ nữ tu mới', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(3, 'sisters.edit', 'Chỉnh sửa thông tin nữ tu', 'Quyền chỉnh sửa thông tin nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(4, 'sisters.delete', 'Xóa hồ sơ', 'Xóa hồ sơ nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(5, 'sisters.export', 'Xuất dữ liệu nữ tu', 'Quyền xuất dữ liệu nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(6, 'communities.view', 'Xem danh sách cộng đoàn', 'Quyền xem danh sách cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(7, 'communities.create', 'Tạo mới', 'Tạo cộng đoàn mới', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(8, 'communities.edit', 'Chỉnh sửa cộng đoàn', 'Quyền chỉnh sửa cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(9, 'communities.delete', 'Xóa', 'Xóa cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(10, 'communities.assign', 'Phân công nữ tu vào cộng đoàn', 'Quyền phân công nữ tu vào cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(11, 'journey.view', 'Xem hành trình ơn gọi', 'Quyền xem hành trình ơn gọi', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(12, 'journey.create', 'Thêm giai đoạn ơn gọi', 'Quyền thêm giai đoạn ơn gọi', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(13, 'journey.edit', 'Chỉnh sửa hành trình', 'Quyền chỉnh sửa hành trình', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(14, 'journey.delete', 'Xóa giai đoạn', 'Quyền xóa giai đoạn', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(15, 'health.view', 'Xem hồ sơ sức khỏe', 'Quyền xem hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(16, 'health.create', 'Thêm hồ sơ sức khỏe', 'Quyền thêm hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(17, 'health.edit', 'Chỉnh sửa sức khỏe', 'Quyền chỉnh sửa sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(18, 'health.delete', 'Xóa hồ sơ sức khỏe', 'Quyền xóa hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(19, 'education.view', 'Xem học vấn', 'Xem thông tin học vấn', 'Học vấn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(20, 'education.create', 'Thêm học vấn', 'Thêm học vấn mới', 'Học vấn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(21, 'education.edit', 'Chỉnh sửa học vấn', 'Quyền chỉnh sửa học vấn', 'Học vấn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(22, 'education.delete', 'Xóa học vấn', 'Xóa học vấn', 'Học vấn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(23, 'missions.view', 'Xem sứ vụ', 'Xem thông tin sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(24, 'missions.create', 'Thêm sứ vụ', 'Thêm sứ vụ mới', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(25, 'missions.edit', 'Chỉnh sửa sứ vụ', 'Quyền chỉnh sửa sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(26, 'missions.delete', 'Xóa sứ vụ', 'Xóa sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(27, 'missions.assign', 'Phân công sứ vụ', 'Quyền phân công sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(28, 'evaluations.view', 'Xem đánh giá', 'Xem phiếu đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(29, 'evaluations.create', 'Tạo phiếu', 'Tạo phiếu đánh giá mới', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(30, 'evaluations.edit', 'Chỉnh sửa đánh giá', 'Quyền chỉnh sửa đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(31, 'evaluations.delete', 'Xóa phiếu', 'Xóa phiếu đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(32, 'evaluations.approve', 'Phê duyệt đánh giá', 'Quyền phê duyệt đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(33, 'reports.view', 'Xem báo cáo', 'Quyền xem báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(34, 'reports.create', 'Tạo báo cáo', 'Quyền tạo báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(35, 'reports.export', 'Xuất báo cáo', 'Quyền xuất báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(36, 'reports.print', 'In báo cáo', 'Quyền in báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(37, 'users.view', 'Xem danh sách người dùng', 'Quyền xem danh sách người dùng', 'Người dùng', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(38, 'users.create', 'Tạo user', 'Tạo người dùng mới', 'Người dùng', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(39, 'users.edit', 'Chỉnh sửa người dùng', 'Quyền chỉnh sửa người dùng', 'Người dùng', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(40, 'users.delete', 'Xóa user', 'Xóa người dùng', 'Người dùng', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(41, 'users.manage_permissions', 'Quản lý phân quyền', 'Quyền quản lý phân quyền', 'Người dùng', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(42, 'users.assign_communities', 'Gán cộng đoàn', 'Gán vào cộng đoàn', 'Người dùng', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(43, 'settings.view', 'Xem cài đặt', 'Quyền xem cài đặt', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(44, 'settings.edit', 'Thay đổi cài đặt', 'Quyền thay đổi cài đặt', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(45, 'settings.backup', 'Sao lưu & khôi phục', 'Quyền sao lưu & khôi phục', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(46, 'settings.audit', 'Xem nhật ký hoạt động', 'Quyền xem nhật ký hoạt động', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(47, 'sisters.view_list', 'Xem danh sách nữ tu', 'Xem danh sách nữ tu', 'Nữ tu', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(48, 'sisters.view_detail', 'Xem chi tiết hồ sơ', 'Xem chi tiết hồ sơ nữ tu', 'Nữ tu', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(49, 'communities.view_list', 'Xem danh sách', 'Xem danh sách cộng đoàn', 'Cộng đoàn', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(50, 'communities.view_detail', 'Xem chi tiết', 'Xem chi tiết cộng đoàn', 'Cộng đoàn', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(51, 'journey.view_list', 'Xem danh sách hành trình', 'Quyền xem danh sách hành trình', 'Hành trình ơn gọi', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(52, 'journey.view_detail', 'Xem chi tiết hành trình', 'Quyền xem chi tiết hành trình', 'Hành trình ơn gọi', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(53, 'health.view_list', 'Xem danh sách hồ sơ sức khỏe', 'Quyền xem danh sách hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(54, 'health.view_detail', 'Xem chi tiết hồ sơ sức khỏe', 'Quyền xem chi tiết hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(55, 'education.view_list', 'Xem danh sách học vấn', 'Quyền xem danh sách học vấn', 'Học vấn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(56, 'education.view_detail', 'Xem chi tiết học vấn', 'Quyền xem chi tiết học vấn', 'Học vấn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(57, 'missions.view_list', 'Xem danh sách sứ vụ', 'Quyền xem danh sách sứ vụ', 'Sứ vụ', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(58, 'missions.view_detail', 'Xem chi tiết sứ vụ', 'Quyền xem chi tiết sứ vụ', 'Sứ vụ', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(59, 'evaluations.view_list', 'Xem danh sách đánh giá', 'Quyền xem danh sách đánh giá', 'Đánh giá', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(60, 'evaluations.view_detail', 'Xem chi tiết đánh giá', 'Quyền xem chi tiết đánh giá', 'Đánh giá', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(61, 'users.view_list', 'Xem danh sách', 'Xem danh sách người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(62, 'users.view_detail', 'Xem chi tiết', 'Xem chi tiết người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(63, 'users.update', 'Sửa thông tin', 'Sửa thông tin người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(64, 'users.lock_unlock', 'Khóa/Mở user', 'Khóa hoặc mở khóa', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(65, 'users.reset_password', 'Reset mật khẩu', 'Reset mật khẩu', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(66, 'users.assign_permissions', 'Gán quyền', 'Gán quyền cho người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(67, 'users.revoke_permissions', 'Thu hồi quyền', 'Thu hồi quyền', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(68, 'users.view_permissions', 'Xem quyền', 'Xem quyền của user', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(69, 'users.view_activity', 'Xem lịch sử', 'Xem lịch sử hoạt động', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(70, 'users.remove_communities', 'Gỡ cộng đoàn', 'Gỡ khỏi cộng đoàn', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(71, 'reports.view_list', 'Xem danh sách báo cáo', 'Quyền xem danh sách báo cáo', 'Báo cáo', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(72, 'reports.view_detail', 'Xem chi tiết báo cáo', 'Quyền xem chi tiết báo cáo', 'Báo cáo', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(73, 'departure.view', 'Xem hồ sơ nghỉ', 'Quyền xem hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(74, 'departure.create', 'Tạo hồ sơ nghỉ', 'Quyền tạo hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(75, 'departure.edit', 'Chỉnh sửa hồ sơ nghỉ', 'Quyền chỉnh sửa hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(76, 'departure.delete', 'Xóa hồ sơ nghỉ', 'Quyền xóa hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(77, 'training.view', 'Xem thường huấn', 'Xem thông tin thường huấn', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(78, 'training.create', 'Thêm khóa học', 'Thêm khóa học mới', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(79, 'training.edit', 'Chỉnh sửa khóa đào tạo', 'Quyền chỉnh sửa khóa đào tạo', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(80, 'training.delete', 'Xóa khóa học', 'Xóa khóa học', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(81, 'community_assignment.view', 'Xem phân công cộng đoàn', 'Quyền xem phân công cộng đoàn', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(82, 'community_assignment.create', 'Tạo phân công', 'Quyền tạo phân công', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(83, 'community_assignment.edit', 'Chỉnh sửa phân công', 'Quyền chỉnh sửa phân công', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(84, 'community_assignment.delete', 'Xóa phân công', 'Quyền xóa phân công', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(85, 'communities.history_view', 'Xem lịch sử hình thành', 'Quyền xem lịch sử hình thành cộng đoàn', 'Cộng đoàn', '2025-12-15 13:32:45', '2025-12-15 13:32:45', 1, 0),
(86, 'communities.history_edit', 'Chỉnh sửa lịch sử hình thành', 'Quyền chỉnh sửa lịch sử hình thành cộng đoàn', 'Cộng đoàn', '2025-12-15 13:32:45', '2025-12-15 13:32:45', 1, 0),
(90, 'sisters.update_basic', 'Sửa thông tin cơ bản', 'Sửa thông tin cơ bản', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(91, 'sisters.update_sensitive', 'Sửa thông tin nhạy cảm', 'Sửa CMND, hộ chiếu...', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(93, 'sisters.upload_avatar', 'Upload ảnh', 'Upload ảnh chân dung', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(94, 'sisters.upload_documents', 'Upload tài liệu', 'Upload tài liệu', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(95, 'sisters.export_excel', 'Xuất Excel', 'Xuất danh sách Excel', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(96, 'sisters.export_pdf', 'Xuất PDF', 'Xuất hồ sơ PDF', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(97, 'sisters.print', 'In hồ sơ', 'In hồ sơ nữ tu', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(98, 'vocation.view', 'Xem hành trình', 'Xem hành trình ơn gọi', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(99, 'vocation.create', 'Thêm mốc', 'Thêm mốc hành trình', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(100, 'vocation.update', 'Sửa mốc', 'Sửa mốc hành trình', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(101, 'vocation.delete', 'Xóa mốc', 'Xóa mốc hành trình', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(105, 'communities.update', 'Sửa thông tin', 'Sửa thông tin cộng đoàn', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(107, 'communities.assign_sister', 'Gán nữ tu', 'Gán nữ tu vào cộng đoàn', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(108, 'communities.remove_sister', 'Gỡ nữ tu', 'Gỡ nữ tu khỏi cộng đoàn', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(109, 'communities.upload_decision', 'Upload quyết định', 'Upload quyết định bổ nhiệm', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(112, 'missions.update', 'Sửa sứ vụ', 'Sửa thông tin sứ vụ', 'missions', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(116, 'education.update', 'Sửa học vấn', 'Sửa thông tin học vấn', 'education', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(118, 'education.upload_certificate', 'Upload bằng cấp', 'Upload file bằng cấp', 'education', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(121, 'training.update', 'Sửa khóa học', 'Sửa thông tin khóa học', 'training', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(123, 'health.view_basic', 'Xem sức khỏe cơ bản', 'Xem thông tin sức khỏe cơ bản', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(124, 'health.view_full', 'Xem đầy đủ sức khỏe', 'Xem đầy đủ thông tin sức khỏe nhạy cảm', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(125, 'health.update', 'Cập nhật sức khỏe', 'Cập nhật thông tin sức khỏe', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(126, 'health.add_record', 'Thêm bản ghi', 'Thêm bản ghi khám bệnh', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(127, 'health.update_record', 'Sửa bản ghi', 'Sửa bản ghi khám bệnh', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(128, 'health.delete_record', 'Xóa bản ghi', 'Xóa bản ghi khám bệnh', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(131, 'evaluations.update', 'Sửa phiếu', 'Sửa phiếu đánh giá', 'evaluations', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(133, 'evaluations.export_pdf', 'Xuất PDF', 'Xuất phiếu PDF', 'evaluations', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(134, 'departures.view', 'Xem tu xuất', 'Xem thông tin tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(135, 'departures.create', 'Ghi nhận', 'Ghi nhận tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(136, 'departures.update', 'Sửa thông tin', 'Sửa thông tin tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(137, 'departures.delete', 'Xóa bản ghi', 'Xóa bản ghi tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(138, 'reports.view_dashboard', 'Xem dashboard', 'Xem dashboard tổng quan', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(139, 'reports.view_by_age', 'Báo cáo độ tuổi', 'Xem báo cáo theo độ tuổi', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(140, 'reports.view_by_stage', 'Báo cáo giai đoạn', 'Xem báo cáo theo giai đoạn', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(141, 'reports.view_by_community', 'Báo cáo cộng đoàn', 'Xem báo cáo theo cộng đoàn', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(142, 'reports.view_by_mission', 'Báo cáo sứ vụ', 'Xem báo cáo theo sứ vụ', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(143, 'reports.view_by_education', 'Báo cáo trình độ', 'Xem báo cáo theo trình độ', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(144, 'reports.export_excel', 'Xuất Excel', 'Xuất báo cáo Excel', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(145, 'reports.export_pdf', 'Xuất PDF', 'Xuất báo cáo PDF', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(146, 'search.basic', 'Tìm kiếm cơ bản', 'Sử dụng tìm kiếm cơ bản', 'search', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(147, 'search.advanced', 'Tìm kiếm nâng cao', 'Sử dụng tìm kiếm nâng cao', 'search', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(148, 'search.export', 'Xuất kết quả', 'Xuất kết quả tìm kiếm', 'search', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(162, 'audit.view', 'Xem audit log', 'Xem audit log hệ thống', 'audit', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(163, 'audit.export', 'Xuất audit log', 'Xuất audit log', 'audit', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(164, 'system.backup', 'Backup DB', 'Sao lưu database', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(165, 'system.restore', 'Restore DB', 'Khôi phục database', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(166, 'system.view_settings', 'Xem cấu hình', 'Xem cấu hình hệ thống', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(167, 'system.update_settings', 'Sửa cấu hình', 'Sửa cấu hình hệ thống', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(168, 'admin.full_access', 'Quyền tối cao', 'Quyền tối cao - bypass mọi kiểm tra', 'admin', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(169, 'posts.view', 'Xem bài đăng', 'Xem danh sách và chi tiết bài đăng', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(170, 'posts.create', 'Tạo bài đăng', 'Tạo bài đăng mới', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(171, 'posts.update', 'Sửa bài đăng', 'Chỉnh sửa bài đăng', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(172, 'posts.delete', 'Xóa bài đăng', 'Xóa bài đăng', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(427, 'dashboard.view', 'Xem trang chủ', 'Xem trang chủ và thống kê tổng quan', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0),
(428, 'dashboard.view_stats', 'Xem thống kê', 'Xem các số liệu thống kê', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0),
(429, 'dashboard.view_activities', 'Xem hoạt động gần đây', 'Xem lịch sử hoạt động hệ thống', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0),
(430, 'dashboard.view_posts', 'Xem bài đăng gần đây', 'Xem các bài đăng mới nhất', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` enum('thong-bao','su-kien','huong-dan','chia-se','khac') NOT NULL DEFAULT 'thong-bao',
  `summary` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `is_important` tinyint(1) DEFAULT 0,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `author_id` int(11) DEFAULT NULL,
  `view_count` int(11) DEFAULT 0,
  `status` enum('draft','published') DEFAULT 'published',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `category`, `summary`, `content`, `is_pinned`, `is_important`, `tags`, `attachments`, `author_id`, `view_count`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Thông báo quan trọng về lịch sinh hoạt tháng 12/2024', 'thong-bao', 'Kính gửi quý chị em trong Hội Dòng, Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024.', '<p>Kính gửi quý chị em trong Hội Dòng,</p><p>Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024.</p>', 0, 1, '[\"thông báo\", \"lịch sinh hoạt\"]', NULL, 1, 245, 'published', '2025-12-15 15:24:54', '2025-12-15 15:30:44', NULL),
(2, 'Mừng lễ Giáng sinh 2024', 'su-kien', 'Chương trình mừng lễ Giáng sinh sẽ được tổ chức vào ngày 24/12.', '<p>Chương trình mừng lễ Giáng sinh 2024 sẽ được tổ chức vào ngày 24/12.</p>', 0, 0, '[\"giáng sinh\", \"sự kiện\"]', NULL, 1, 189, 'published', '2025-12-15 15:24:54', '2025-12-15 15:41:05', NULL),
(3, 'Hướng dẫn sử dụng hệ thống mới', 'huong-dan', 'Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới trong hệ thống quản lý.', '<p>Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới.</p>', 0, 0, '[\"hướng dẫn\", \"hệ thống\"]', NULL, 1, 156, 'published', '2025-12-15 15:24:54', '2025-12-15 15:24:54', NULL),
(4, 'Thông báo lịch tĩnh tâm năm 2024', 'thong-bao', 'Kính gửi quý chị em, Ban tổ chức xin thông báo về lịch tĩnh tâm năm 2024.', '<p>Kính gửi quý chị em, Ban tổ chức xin thông báo về lịch tĩnh tâm năm 2024.</p>', 0, 1, '[]', '[]', 1, 320, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(5, 'Kỷ niệm 50 năm thành lập Hội Dòng', 'su-kien', 'Mừng kỷ niệm 50 năm ngày thành lập Hội Dòng Mến Thánh Giá.', '<p>Mừng kỷ niệm 50 năm ngày thành lập Hội Dòng Mến Thánh Giá.</p>', 0, 1, '[]', '[]', 1, 456, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(6, 'Hướng dẫn quy trình xin phép nghỉ', 'huong-dan', 'Quy trình và thủ tục xin phép nghỉ cho các nữ tu trong Hội Dòng.', '<p>Quy trình và thủ tục xin phép nghỉ cho các nữ tu trong Hội Dòng.</p>', 0, 0, '[]', '[]', 1, 178, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(7, 'Chia sẻ kinh nghiệm truyền giáo tại vùng cao', 'chia-se', 'Những câu chuyện cảm động từ chuyến truyền giáo tại vùng cao Tây Bắc.', '<p>Những câu chuyện cảm động từ chuyến truyền giáo tại vùng cao Tây Bắc.</p>', 0, 0, '[]', '[]', 1, 236, 'published', '2025-12-15 15:46:19', '2025-12-15 15:57:31', NULL),
(8, 'Thông báo về việc đóng quỹ hàng tháng', 'thong-bao', 'Nhắc nhở các cộng đoàn về việc đóng quỹ hàng tháng.', '<p>Nhắc nhở các cộng đoàn về việc đóng quỹ hàng tháng.</p>', 0, 0, '[]', '[]', 1, 89, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(9, 'Chương trình đào tạo Huấn luyện viên 2024', 'su-kien', 'Khóa đào tạo dành cho các Huấn luyện viên trong Hội Dòng.', '<p>Khóa đào tạo dành cho các Huấn luyện viên trong Hội Dòng.</p>', 0, 0, '[]', '[]', 1, 145, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(10, 'Cập nhật nội quy sinh hoạt cộng đoàn', 'huong-dan', 'Một số điều chỉnh trong nội quy sinh hoạt cộng đoàn.', '<p>Một số điều chỉnh trong nội quy sinh hoạt cộng đoàn.</p>', 0, 0, '[]', '[]', 1, 267, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(11, 'Lễ khấn trọn đời - Khóa 2024', 'su-kien', 'Thông tin về lễ khấn trọn đời của 5 nữ tu khóa 2024.', '<p>Thông tin về lễ khấn trọn đời của 5 nữ tu khóa 2024.</p>', 0, 1, '[]', '[]', 1, 389, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(12, 'Suy tư mùa Vọng: Chờ đợi trong hy vọng', 'chia-se', 'Bài suy tư về ý nghĩa của việc chờ đợi trong mùa Vọng.', '<p>Bài suy tư về ý nghĩa của việc chờ đợi trong mùa Vọng.</p>', 0, 0, '[]', '[]', 1, 198, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(13, 'Thông tin liên hệ các cộng đoàn', 'khac', 'Danh sách thông tin liên hệ cập nhật của các cộng đoàn.', '<p>Danh sách thông tin liên hệ cập nhật của các cộng đoàn.</p>', 0, 0, '[]', '[]', 1, 156, 'published', '2025-12-15 15:46:19', '2025-12-15 15:46:19', NULL),
(14, 'Thông báo lịch tĩnh tâm năm 2024', 'thong-bao', 'Kính gửi quý chị em, Ban tổ chức xin thông báo về lịch tĩnh tâm năm 2024.', '<p>Kính gửi quý chị em, Ban tổ chức xin thông báo về lịch tĩnh tâm năm 2024.</p>', 0, 1, '[]', '[]', 1, 322, 'published', '2025-12-15 15:46:22', '2025-12-15 16:45:19', NULL),
(15, 'Kỷ niệm 50 năm thành lập Hội Dòng', 'su-kien', 'Mừng kỷ niệm 50 năm ngày thành lập Hội Dòng Mến Thánh Giá.', '<p>Mừng kỷ niệm 50 năm ngày thành lập Hội Dòng Mến Thánh Giá.</p>', 0, 1, '[]', '[]', 1, 462, 'published', '2025-12-15 15:46:22', '2025-12-15 15:56:36', NULL),
(16, 'Hướng dẫn quy trình xin phép nghỉ', 'huong-dan', 'Quy trình và thủ tục xin phép nghỉ cho các nữ tu trong Hội Dòng.', '<p>Quy trình và thủ tục xin phép nghỉ cho các nữ tu trong Hội Dòng.</p>', 0, 0, '[]', '[]', 1, 180, 'published', '2025-12-15 15:46:22', '2025-12-15 15:57:18', NULL),
(17, 'Chia sẻ kinh nghiệm truyền giáo tại vùng cao', 'chia-se', 'Những câu chuyện cảm động từ chuyến truyền giáo tại vùng cao Tây Bắc.', '<p>Những câu chuyện cảm động từ chuyến truyền giáo tại vùng cao Tây Bắc.</p>', 0, 0, '[]', '[]', 1, 234, 'published', '2025-12-15 15:46:22', '2025-12-15 15:46:22', NULL),
(18, 'Thông báo về việc đóng quỹ hàng tháng', 'thong-bao', 'Nhắc nhở các cộng đoàn về việc đóng quỹ hàng tháng.', '<p>Nhắc nhở các cộng đoàn về việc đóng quỹ hàng tháng.</p>', 0, 0, '[]', '[]', 1, 93, 'published', '2025-12-15 15:46:22', '2025-12-15 15:58:14', NULL),
(19, 'Chương trình đào tạo Huấn luyện viên 2024', 'su-kien', 'Khóa đào tạo dành cho các Huấn luyện viên trong Hội Dòng.', '<p>Khóa đào tạo dành cho các Huấn luyện viên trong Hội Dòng.</p>', 0, 0, '[]', '[]', 1, 145, 'published', '2025-12-15 15:46:22', '2025-12-15 15:46:22', NULL),
(20, 'Cập nhật nội quy sinh hoạt cộng đoàn', 'huong-dan', 'Một số điều chỉnh trong nội quy sinh hoạt cộng đoàn.', '<p>Một số điều chỉnh trong nội quy sinh hoạt cộng đoàn.</p>', 0, 0, '[]', '[]', 1, 267, 'published', '2025-12-15 15:46:22', '2025-12-15 15:46:22', NULL),
(21, 'Lễ khấn trọn đời - Khóa 2024', 'su-kien', 'Thông tin về lễ khấn trọn đời của 5 nữ tu khóa 2024.', '<p>Thông tin về lễ khấn trọn đời của 5 nữ tu khóa 2024.</p>', 0, 1, '[]', '[]', 1, 391, 'published', '2025-12-15 15:46:22', '2025-12-15 15:49:24', NULL),
(22, 'Suy tư mùa Vọng: Chờ đợi trong hy vọng', 'chia-se', 'Bài suy tư về ý nghĩa của việc chờ đợi trong mùa Vọng.', '<p>Bài suy tư về ý nghĩa của việc chờ đợi trong mùa Vọng.</p>', 0, 0, '[]', '[]', 1, 198, 'published', '2025-12-15 15:46:22', '2025-12-15 15:46:22', NULL),
(23, 'Thông tin liên hệ các cộng đoàn', 'khac', 'Danh sách thông tin liên hệ cập nhật của các cộng đoàn.', '<p>Danh sách thông tin liên hệ cập nhật của các cộng đoàn.</p>', 0, 0, '[]', '[]', 1, 156, 'published', '2025-12-15 15:46:22', '2025-12-15 15:46:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sisters`
--

CREATE TABLE `sisters` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(30) NOT NULL,
  `saint_name` varchar(120) DEFAULT NULL,
  `birth_name` varchar(120) NOT NULL,
  `date_of_birth` date NOT NULL,
  `place_of_birth` varchar(150) DEFAULT NULL,
  `permanent_address` varchar(255) DEFAULT NULL,
  `current_address` varchar(255) DEFAULT NULL,
  `nationality` varchar(80) DEFAULT NULL,
  `id_card` varchar(20) DEFAULT NULL,
  `id_card_date` date DEFAULT NULL,
  `id_card_place` varchar(150) DEFAULT NULL,
  `father_name` varchar(120) DEFAULT NULL,
  `father_occupation` varchar(100) DEFAULT NULL,
  `mother_name` varchar(120) DEFAULT NULL,
  `mother_occupation` varchar(100) DEFAULT NULL,
  `siblings_count` int(11) DEFAULT NULL,
  `family_address` varchar(255) DEFAULT NULL,
  `family_religion` varchar(80) DEFAULT NULL,
  `baptism_date` date DEFAULT NULL,
  `baptism_place` varchar(150) DEFAULT NULL,
  `confirmation_date` date DEFAULT NULL,
  `first_communion_date` date DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `emergency_contact_name` varchar(120) DEFAULT NULL,
  `emergency_contact_phone` varchar(30) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `current_stage` varchar(50) DEFAULT NULL,
  `current_community_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON array of document files' CHECK (json_valid(`documents`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sisters`
--

INSERT INTO `sisters` (`id`, `code`, `saint_name`, `birth_name`, `date_of_birth`, `place_of_birth`, `permanent_address`, `current_address`, `nationality`, `id_card`, `id_card_date`, `id_card_place`, `father_name`, `father_occupation`, `mother_name`, `mother_occupation`, `siblings_count`, `family_address`, `family_religion`, `baptism_date`, `baptism_place`, `confirmation_date`, `first_communion_date`, `phone`, `email`, `emergency_contact_name`, `emergency_contact_phone`, `notes`, `photo_url`, `status`, `current_stage`, `current_community_id`, `created_by`, `created_at`, `updated_at`, `documents`) VALUES
(1, 'SR001', 'Maria', 'Nguyễn Thị Hoa', '1945-03-15', 'Bến Tre', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Nguyễn Văn Tâm', NULL, 'Trần Thị Lan', NULL, NULL, NULL, 'Công giáo', '1945-04-20', 'Nhà thờ Bến Tre', '1956-05-15', '1952-06-10', '0909123456', 'sr.maria.hoa@saintpaul.vn', 'Nguyễn Văn Hùng (em trai)', '0908765432', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(2, 'SR002', 'Têrêsa', 'Trần Thị Lan', '1950-07-22', 'Đà Lạt', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Trần Văn Minh', NULL, 'Lê Thị Mai', NULL, NULL, NULL, 'Công giáo', '1950-08-15', 'Nhà thờ Domaine de Marie', '1961-06-20', '1957-05-25', '0909234567', 'sr.teresa.lan@saintpaul.vn', 'Trần Thị Hương (chị gái)', '0907654321', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(3, 'SR003', 'Anna', 'Lê Thị Mai', '1955-11-10', 'Hà Nội', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Lê Văn Đức', NULL, 'Phạm Thị Nga', NULL, NULL, NULL, 'Công giáo', '1955-12-08', 'Nhà thờ Lớn Hà Nội', '1966-05-30', '1962-06-15', '0909345678', 'sr.anna.mai@saintpaul.vn', 'Lê Văn Toàn (anh trai)', '0906543210', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(4, 'SR004', 'Bernadette', 'Phạm Thị Nga', '1960-02-14', 'Huế', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Phạm Văn Thành', NULL, 'Nguyễn Thị Xuân', NULL, NULL, NULL, 'Công giáo', '1960-03-19', 'Nhà thờ Phú Cam', '1971-04-25', '1967-05-20', '0909456789', 'sr.bernadette.nga@saintpaul.vn', 'Phạm Văn Nam (em trai)', '0905432109', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(5, 'SR005', 'Cecilia', 'Võ Thị Thanh', '1965-08-30', 'Cần Thơ', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Võ Văn Lợi', NULL, 'Lý Thị Hồng', NULL, NULL, NULL, 'Công giáo', '1965-09-15', 'Nhà thờ Cần Thơ', '1976-06-10', '1972-05-28', '0909567890', 'sr.cecilia.thanh@saintpaul.vn', 'Võ Thị Lan (chị gái)', '0904321098', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(6, 'SR006', 'Monica', 'Đặng Thị Hương', '1970-05-18', 'Nha Trang', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Đặng Văn Hải', NULL, 'Hoàng Thị Bích', NULL, NULL, NULL, 'Công giáo', '1970-06-21', 'Nhà thờ Núi Nha Trang', '1981-05-15', '1977-06-12', '0909678901', 'sr.monica.huong@saintpaul.vn', 'Đặng Văn Tùng (anh trai)', '0903210987', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(7, 'SR007', 'Agatha', 'Bùi Thị Linh', '1975-12-25', 'Đà Nẵng', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Bùi Văn Phúc', NULL, 'Đinh Thị Kim', NULL, NULL, NULL, 'Công giáo', '1976-01-06', 'Nhà thờ Đà Nẵng', '1986-06-08', '1982-05-30', '0909789012', 'sr.agatha.linh@saintpaul.vn', 'Bùi Thị Mai (em gái)', '0902109876', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(8, 'SR008', 'Lucia', 'Hoàng Thị Bích', '1980-09-12', 'Vinh', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Hoàng Văn Thắng', NULL, 'Lương Thị Oanh', NULL, NULL, NULL, 'Công giáo', '1980-10-12', 'Nhà thờ Vinh', '1991-05-26', '1987-06-07', '0909890123', 'sr.lucia.bich@saintpaul.vn', 'Hoàng Văn Dũng (anh trai)', '0901098765', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(9, 'SR009', 'Catherine', 'Phan Thị Thu', '1985-04-07', 'Quy Nhơn', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Phan Văn Toàn', NULL, 'Vũ Thị Hạnh', NULL, NULL, NULL, 'Công giáo', '1985-05-05', 'Nhà thờ Quy Nhơn', '1996-06-16', '1992-05-24', '0909901234', 'sr.catherine.thu@saintpaul.vn', 'Phan Văn Hùng (em trai)', '0900987654', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(10, 'SR010', 'Agnes', 'Đinh Thị Kim', '1990-01-21', 'Vũng Tàu', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Đinh Văn Quang', NULL, 'Mai Thị Nhung', NULL, NULL, NULL, 'Công giáo', '1990-02-11', 'Nhà thờ Vũng Tàu', '2001-05-20', '1997-06-08', '0909012345', 'sr.agnes.kim@saintpaul.vn', 'Đinh Thị Hoa (chị gái)', '0909876543', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(11, 'SR011', 'Rose', 'Lý Thị Hồng', '1992-06-15', 'Long Xuyên', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Lý Văn Sơn', NULL, 'Châu Thị Tuyết', NULL, NULL, NULL, 'Công giáo', '1992-07-12', 'Nhà thờ Long Xuyên', '2003-06-15', '1999-05-30', '0909112345', 'sr.rose.hong@saintpaul.vn', 'Lý Văn Bình (anh trai)', '0908765432', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(12, 'SR012', 'Clare', 'Vũ Thị Hạnh', '1994-10-28', 'Hải Phòng', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Vũ Văn Trung', NULL, 'Dương Thị Phượng', NULL, NULL, NULL, 'Công giáo', '1994-11-20', 'Nhà thờ Hải Phòng', '2005-05-29', '2001-06-10', '0909212345', 'sr.clare.hanh@saintpaul.vn', 'Vũ Thị Linh (em gái)', '0907654321', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(13, 'SR013', 'Elizabeth', 'Dương Thị Phượng', '1996-03-08', 'Buôn Ma Thuột', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Dương Văn Hùng', NULL, 'Ksor Thị H\'Nai', NULL, NULL, NULL, 'Công giáo', '1996-04-07', 'Nhà thờ Buôn Ma Thuột', '2007-06-03', '2003-05-25', '0909312345', 'sr.elizabeth.phuong@saintpaul.vn', 'Dương Văn Tuấn (anh trai)', '0906543210', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(14, 'SR014', 'Margaret', 'Châu Thị Tuyết', '1998-08-19', 'Phan Thiết', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Châu Văn Lâm', NULL, 'Huỳnh Thị Giang', NULL, NULL, NULL, 'Công giáo', '1998-09-13', 'Nhà thờ Phan Thiết', '2009-05-31', '2005-06-12', '0909412345', 'sr.margaret.tuyet@saintpaul.vn', 'Châu Thị Ngọc (chị gái)', '0905432109', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(15, 'SR015', 'Helena', 'Mai Thị Nhung', '2000-11-03', 'Thái Bình', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Mai Văn Khải', NULL, 'Ngô Thị Vân', NULL, NULL, NULL, 'Công giáo', '2000-12-08', 'Nhà thờ Thái Bình', '2011-06-12', '2007-05-27', '0909512345', 'sr.helena.nhung@saintpaul.vn', 'Mai Văn Long (anh trai)', '0904321098', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(16, 'SR016', 'Veronica', 'Ngô Thị Vân', '2002-05-25', 'Ninh Bình', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Ngô Văn Thành', NULL, 'Đỗ Thị Yến', NULL, NULL, NULL, 'Công giáo', '2002-06-23', 'Nhà thờ Phát Diệm', '2013-05-19', '2009-06-07', '0909612345', 'sr.veronica.van@saintpaul.vn', 'Ngô Thị Thu (chị gái)', '0903210987', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(17, 'SR017', 'Josephine', 'Đỗ Thị Yến', '2004-02-14', 'Nam Định', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Đỗ Văn Hòa', NULL, 'Trịnh Thị Dung', NULL, NULL, NULL, 'Công giáo', '2004-03-19', 'Nhà thờ Nam Định', '2015-06-07', '2011-05-29', '0909712345', 'sr.josephine.yen@saintpaul.vn', 'Đỗ Văn Hải (em trai)', '0902109876', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(18, 'SR018', 'Philomena', 'Trịnh Thị Dung', '2005-09-30', 'Thanh Hóa', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Trịnh Văn Bình', NULL, 'Lương Thị Oanh', NULL, NULL, NULL, 'Công giáo', '2005-10-30', 'Nhà thờ Thanh Hóa', '2016-05-15', '2012-06-03', '0909812345', 'sr.philomena.dung@saintpaul.vn', 'Trịnh Thị Hương (chị gái)', '0901098765', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:34', NULL, NULL),
(19, 'SR019', 'Rita', 'Lương Thị Oanh', '2006-12-07', 'Kon Tum', 'Tây Ninh', NULL, 'Việt Nam', NULL, NULL, NULL, 'Lương Văn Đức', NULL, 'H\'Bơr Thị Liên', NULL, NULL, NULL, 'Công giáo', '2007-01-05', 'Nhà thờ Kon Tum', '2017-06-10', '2013-05-25', '0909912345', 'sr.rita.oanh@saintpaul.vn', 'Lương Văn Tâm (anh trai)', '0900987654', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:35', '2025-12-20 03:52:46', NULL),
(20, 'SR020', 'Lucia', 'Huỳnh Thị Giang', '2008-07-16', 'Cà Mau', NULL, NULL, 'Việt Nam', NULL, NULL, NULL, 'Huỳnh Văn Sáu', NULL, 'Võ Thị Sen', NULL, NULL, NULL, 'Công giáo', '2008-08-15', 'Nhà thờ Cà Mau', '2019-06-09', '2015-05-31', '0909012346', 'sr.lucia.giang@saintpaul.vn', 'Huỳnh Thị Mai (chị gái)', '0909876544', NULL, NULL, 'active', NULL, NULL, NULL, '2025-12-20 02:44:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sister_statuses`
--

CREATE TABLE `sister_statuses` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_group` varchar(50) DEFAULT 'general',
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `setting_group`, `description`, `created_at`, `updated_at`) VALUES
(1, 'siteName', 'Hệ Thống Quản Lý Hội Dòng OSP - Updated', 'general', 'Tên hệ thống', '2025-12-15 16:52:01', '2025-12-15 16:55:06'),
(2, 'siteDescription', 'Quản lý thông tin nữ tu và hoạt động của Hội Dòng', 'general', 'Mô tả hệ thống', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(3, 'timezone', 'Asia/Ho_Chi_Minh', 'general', 'Múi giờ', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(4, 'dateFormat', 'DD/MM/YYYY', 'general', 'Định dạng ngày', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(5, 'language', 'en', 'general', 'Ngôn ngữ', '2025-12-15 16:52:01', '2025-12-16 12:37:14'),
(6, 'congregationName', 'Dòng Nữ Tu OSP', 'general', 'Tên Hội Dòng', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(7, 'foundingDate', '', 'general', 'Ngày thành lập', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(8, 'mainAddress', '', 'general', 'Địa chỉ chính', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(9, 'phone', '', 'general', 'Số điện thoại', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(10, 'email', '', 'general', 'Email', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(11, 'website', '', 'general', 'Website', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(12, 'smtpHost', '', 'system', 'SMTP Host', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(13, 'smtpPort', '587', 'system', 'SMTP Port', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(14, 'smtpUser', '', 'system', 'SMTP User', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(15, 'smtpPassword', '', 'system', 'SMTP Password', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(16, 'smtpSecure', 'tls', 'system', 'SMTP Secure', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(17, 'emailFromName', 'Hệ Thống Quản Lý Hội Dòng', 'system', 'Email From Name', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(18, 'emailFromAddress', '', 'system', 'Email From Address', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(19, 'sessionTimeout', '60', 'system', 'Session timeout (phút)', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(20, 'minPasswordLength', '8', 'system', 'Độ dài tối thiểu mật khẩu', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(21, 'requireStrongPassword', 'true', 'system', 'Yêu cầu mật khẩu mạnh', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(22, 'maxLoginAttempts', '5', 'system', 'Số lần đăng nhập tối đa', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(23, 'lockoutDuration', '30', 'system', 'Thời gian khóa (phút)', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(24, 'enableTwoFactor', 'false', 'system', 'Bật xác thực 2 yếu tố', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(25, 'enableCache', 'true', 'system', 'Bật cache', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(26, 'cacheExpiry', '3600', 'system', 'Thời gian cache (giây)', '2025-12-15 16:52:01', '2025-12-15 16:52:01');

-- --------------------------------------------------------

--
-- Table structure for table `training_courses`
--

CREATE TABLE `training_courses` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `course_name` varchar(180) NOT NULL,
  `organizer` varchar(180) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `content` text DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(120) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `is_admin` tinyint(1) DEFAULT 0,
  `data_scope` enum('all','community','own') DEFAULT 'community' COMMENT 'Data access scope: all=see all, community=assigned communities only, own=own data only',
  `is_super_admin` tinyint(1) DEFAULT 0 COMMENT 'Super admin bypasses all permission checks'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `full_name`, `phone`, `avatar`, `last_login`, `is_active`, `created_at`, `updated_at`, `is_admin`, `data_scope`, `is_super_admin`) VALUES
(1, 'admin', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'admin@osp.vn', 'Quản trị viên', NULL, '', '2025-12-21 19:41:39', 1, '2025-12-14 15:27:02', '2025-12-21 12:41:39', 1, 'all', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_communities`
--

CREATE TABLE `user_communities` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `community_id` int(10) UNSIGNED NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0 COMMENT 'Đánh dấu cộng đoàn chính',
  `granted_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'ID admin gán',
  `granted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Gán user vào cộng đoàn - xác định phạm vi dữ liệu';

--
-- Dumping data for table `user_communities`
--

INSERT INTO `user_communities` (`id`, `user_id`, `community_id`, `is_primary`, `granted_by`, `granted_at`, `created_at`, `updated_at`) VALUES
(1, 4, 2, 1, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(2, 4, 3, 0, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(4, 6, 5, 1, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(43, 5, 4, 0, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19', NULL),
(44, 5, 5, 0, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19', NULL),
(121, 1, 6, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(122, 1, 5, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(123, 1, 2, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(124, 1, 3, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(125, 1, 7, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(126, 1, 4, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(127, 1, 1, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_permissions`
--

CREATE TABLE `user_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `granted_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'User ID của người gán quyền',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_permissions`
--

INSERT INTO `user_permissions` (`id`, `user_id`, `permission_id`, `granted_by`, `created_at`, `updated_at`) VALUES
(47, 2, 6, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(48, 2, 19, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(49, 2, 15, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(50, 2, 11, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(51, 2, 23, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(52, 2, 1, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(53, 3, 6, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(54, 3, 19, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(55, 3, 15, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(56, 3, 11, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(57, 3, 23, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(58, 3, 1, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(59, 4, 6, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(60, 4, 19, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(61, 4, 15, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(62, 4, 11, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(63, 4, 23, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(64, 4, 1, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(71, 6, 6, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(72, 6, 19, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(73, 6, 15, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(74, 6, 11, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(75, 6, 23, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(76, 6, 1, NULL, '2025-12-14 15:27:02', '2025-12-14 15:27:02'),
(3256, 5, 1, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3257, 5, 2, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3258, 5, 3, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3259, 5, 4, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3260, 5, 5, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3261, 5, 6, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3262, 5, 7, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3263, 5, 8, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3264, 5, 9, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3265, 5, 10, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3266, 5, 11, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3267, 5, 12, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3268, 5, 13, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3269, 5, 14, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3270, 5, 15, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3271, 5, 16, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3272, 5, 17, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3273, 5, 18, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3274, 5, 19, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3275, 5, 20, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3276, 5, 21, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3277, 5, 22, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3278, 5, 23, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3279, 5, 28, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3280, 5, 29, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3281, 5, 30, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3282, 5, 31, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3283, 5, 32, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3284, 5, 33, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3285, 5, 34, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3286, 5, 35, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3287, 5, 36, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3288, 5, 37, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3289, 5, 38, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3290, 5, 39, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3291, 5, 40, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3292, 5, 41, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3293, 5, 42, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3294, 5, 43, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3295, 5, 44, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3296, 5, 45, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3297, 5, 46, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3298, 5, 47, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3299, 5, 48, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3300, 5, 49, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3301, 5, 50, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3302, 5, 51, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3303, 5, 52, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3304, 5, 53, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3305, 5, 54, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3306, 5, 55, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3307, 5, 56, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3308, 5, 59, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3309, 5, 60, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3310, 5, 61, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3311, 5, 62, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3312, 5, 63, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3313, 5, 64, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3314, 5, 65, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3315, 5, 66, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3316, 5, 67, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3317, 5, 68, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3318, 5, 69, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3319, 5, 70, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3320, 5, 71, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3321, 5, 72, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3322, 5, 73, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3323, 5, 74, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3324, 5, 75, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3325, 5, 76, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3326, 5, 77, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3327, 5, 78, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3328, 5, 79, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3329, 5, 80, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3330, 5, 81, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3331, 5, 82, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3332, 5, 83, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(3333, 5, 84, 1, '2025-12-14 16:47:19', '2025-12-14 16:47:19'),
(4896, 1, 1, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4897, 1, 2, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4898, 1, 3, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4899, 1, 4, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4900, 1, 5, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4901, 1, 6, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4902, 1, 7, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4903, 1, 8, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4904, 1, 9, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4905, 1, 10, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4906, 1, 11, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4907, 1, 12, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4908, 1, 13, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4909, 1, 14, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4910, 1, 15, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4911, 1, 16, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4912, 1, 17, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4913, 1, 18, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4914, 1, 19, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4915, 1, 20, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4916, 1, 21, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4917, 1, 22, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4918, 1, 23, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4919, 1, 24, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4920, 1, 25, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4921, 1, 26, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4922, 1, 27, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4923, 1, 28, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4924, 1, 29, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4925, 1, 30, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4926, 1, 31, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4927, 1, 32, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4928, 1, 33, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4929, 1, 34, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4930, 1, 35, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4931, 1, 36, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4932, 1, 37, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4933, 1, 38, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4934, 1, 39, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4935, 1, 40, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4936, 1, 41, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4937, 1, 42, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4938, 1, 47, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4939, 1, 48, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4940, 1, 49, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4941, 1, 50, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4942, 1, 51, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4943, 1, 52, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4944, 1, 53, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4945, 1, 54, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4946, 1, 55, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4947, 1, 56, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4948, 1, 57, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4949, 1, 58, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4950, 1, 59, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4951, 1, 60, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4952, 1, 61, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4953, 1, 62, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4954, 1, 63, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4955, 1, 64, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4956, 1, 65, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4957, 1, 66, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4958, 1, 67, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4959, 1, 68, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4960, 1, 69, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4961, 1, 70, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4962, 1, 71, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4963, 1, 72, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4964, 1, 73, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4965, 1, 74, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4966, 1, 75, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4967, 1, 76, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4968, 1, 77, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4969, 1, 78, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4970, 1, 79, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4971, 1, 80, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4972, 1, 81, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4973, 1, 82, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4974, 1, 83, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4975, 1, 84, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4976, 1, 85, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4977, 1, 86, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4978, 1, 90, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4979, 1, 91, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4980, 1, 93, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4981, 1, 94, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4982, 1, 95, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4983, 1, 96, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4984, 1, 97, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4985, 1, 98, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4986, 1, 99, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4987, 1, 100, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4988, 1, 101, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4989, 1, 105, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4990, 1, 107, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4991, 1, 108, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4992, 1, 109, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4993, 1, 112, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4994, 1, 116, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4995, 1, 118, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4996, 1, 121, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4997, 1, 123, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4998, 1, 124, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4999, 1, 125, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5000, 1, 126, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5001, 1, 127, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5002, 1, 128, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5003, 1, 131, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5004, 1, 133, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5005, 1, 134, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5006, 1, 135, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5007, 1, 136, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5008, 1, 137, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5009, 1, 138, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5010, 1, 139, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5011, 1, 140, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5012, 1, 141, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5013, 1, 142, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5014, 1, 143, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5015, 1, 144, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5016, 1, 145, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5017, 1, 146, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5018, 1, 147, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5019, 1, 148, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5020, 1, 162, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5021, 1, 163, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5022, 1, 168, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5023, 1, 169, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5024, 1, 170, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5025, 1, 171, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5026, 1, 172, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5027, 1, 427, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5028, 1, 428, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5029, 1, 429, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5030, 1, 430, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5031, 1, 46, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5032, 1, 45, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5033, 1, 44, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5034, 1, 43, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5035, 1, 164, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5036, 1, 165, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5037, 1, 167, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5038, 1, 166, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19');

-- --------------------------------------------------------

--
-- Table structure for table `user_preferences`
--

CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `preference_key` varchar(100) NOT NULL,
  `preference_value` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vocation_journey`
--

CREATE TABLE `vocation_journey` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `stage` enum('inquiry','postulant','aspirant','novice','temporary_vows','perpetual_vows','left') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `superior` varchar(255) DEFAULT NULL,
  `formation_director` varchar(255) DEFAULT NULL,
  `community_id` int(10) UNSIGNED DEFAULT NULL,
  `supervisor_id` int(10) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vocation_journey`
--

INSERT INTO `vocation_journey` (`id`, `sister_id`, `stage`, `start_date`, `end_date`, `location`, `superior`, `formation_director`, `community_id`, `supervisor_id`, `notes`) VALUES
(1, 1, 'inquiry', '1968-07-01', '1969-10-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Hà Nội'),
(2, 1, 'postulant', '1969-10-01', '1970-03-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Hà Nội'),
(3, 1, 'aspirant', '1970-02-01', '1972-11-01', NULL, NULL, NULL, 3, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Đà Lạt'),
(4, 1, 'novice', '1972-01-01', '1974-12-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Hà Nội'),
(5, 1, 'temporary_vows', '1974-05-01', '1977-11-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Khấn tạm tại Cộng Đoàn Nhà Mẹ'),
(6, 1, 'perpetual_vows', '1977-07-01', NULL, NULL, NULL, NULL, 1, NULL, 'Giai đoạn Khấn trọn tại Cộng Đoàn Nhà Mẹ'),
(7, 2, 'inquiry', '1974-10-01', '1975-03-01', NULL, NULL, NULL, 4, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Bảo Lộc'),
(8, 2, 'postulant', '1975-01-01', '1976-10-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Núi Cúi'),
(9, 2, 'aspirant', '1976-09-01', '1978-01-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Nhà Mẹ'),
(10, 2, 'novice', '1978-07-01', '1980-08-01', NULL, NULL, NULL, 3, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Đà Lạt'),
(11, 2, 'temporary_vows', '1980-06-01', '1983-04-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Khấn tạm tại Cộng Đoàn Nhà Mẹ'),
(12, 2, 'perpetual_vows', '1983-09-01', NULL, NULL, NULL, NULL, 1, 1, 'Giai đoạn Khấn trọn tại Cộng Đoàn Nhà Mẹ'),
(13, 3, 'inquiry', '1973-11-01', '1974-01-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Nhà Mẹ'),
(14, 3, 'postulant', '1974-05-01', '1975-03-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Nhà Mẹ'),
(15, 3, 'aspirant', '1975-07-01', '1977-12-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Nhà Mẹ'),
(16, 3, 'novice', '1977-02-01', '1979-07-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Nhà Mẹ'),
(17, 3, 'temporary_vows', '1979-03-01', '1982-04-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Khấn tạm tại Cộng Đoàn Sài Gòn'),
(18, 3, 'perpetual_vows', '1982-09-01', NULL, NULL, NULL, NULL, 5, 1, 'Giai đoạn Khấn trọn tại Cộng Đoàn Núi Cúi'),
(19, 4, 'inquiry', '1980-04-01', '1981-04-01', NULL, NULL, NULL, 4, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Bảo Lộc'),
(20, 4, 'postulant', '1981-01-01', '1982-03-01', NULL, NULL, NULL, 4, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Bảo Lộc'),
(21, 4, 'aspirant', '1982-10-01', '1984-10-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Núi Cúi'),
(22, 4, 'novice', '1984-12-01', '1986-06-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Núi Cúi'),
(23, 4, 'temporary_vows', '1986-12-01', '1989-12-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Khấn tạm tại Cộng Đoàn Hà Nội'),
(24, 5, 'inquiry', '1985-03-01', '1986-07-01', NULL, NULL, NULL, 3, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Đà Lạt'),
(25, 5, 'postulant', '1986-11-01', '1987-01-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Nhà Mẹ'),
(26, 5, 'aspirant', '1987-10-01', '1989-07-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Hà Nội'),
(27, 5, 'novice', '1989-01-01', '1991-03-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Núi Cúi'),
(28, 5, 'temporary_vows', '1991-03-01', '1994-07-01', NULL, NULL, NULL, 4, NULL, 'Giai đoạn Khấn tạm tại Cộng Đoàn Bảo Lộc'),
(29, 6, 'inquiry', '1991-02-01', '1992-05-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Núi Cúi'),
(30, 6, 'postulant', '1992-04-01', '1993-06-01', NULL, NULL, NULL, 3, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Đà Lạt'),
(31, 6, 'aspirant', '1993-07-01', '1995-09-01', NULL, NULL, NULL, 4, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Bảo Lộc'),
(32, 6, 'novice', '1995-10-01', '1997-11-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Hà Nội'),
(33, 6, 'temporary_vows', '1997-04-01', '2000-01-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Khấn tạm tại Cộng Đoàn Núi Cúi'),
(34, 7, 'inquiry', '1993-06-01', '1994-04-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Núi Cúi'),
(35, 7, 'postulant', '1994-03-01', '1995-05-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Hà Nội'),
(36, 7, 'aspirant', '1995-06-01', '1997-04-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Sài Gòn'),
(37, 7, 'novice', '1997-09-01', '1999-02-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Nhà Mẹ'),
(38, 7, 'temporary_vows', '1999-08-01', '2002-08-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Khấn tạm tại Cộng Đoàn Sài Gòn'),
(39, 8, 'inquiry', '2003-04-01', '2004-09-01', NULL, NULL, NULL, 3, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Đà Lạt'),
(40, 8, 'postulant', '2004-02-01', '2005-05-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Hà Nội'),
(41, 8, 'aspirant', '2005-01-01', '2007-05-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Nhà Mẹ'),
(42, 8, 'novice', '2007-07-01', '2009-12-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Hà Nội'),
(43, 9, 'inquiry', '2003-02-01', '2004-02-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Hà Nội'),
(44, 9, 'postulant', '2004-07-01', '2005-02-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Sài Gòn'),
(45, 9, 'aspirant', '2005-02-01', '2007-05-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Sài Gòn'),
(46, 9, 'novice', '2007-11-01', '2009-08-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Tập sinh tại Cộng Đoàn Nhà Mẹ'),
(47, 10, 'inquiry', '2014-09-01', '2015-01-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Hà Nội'),
(48, 10, 'postulant', '2015-04-01', '2016-08-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Sài Gòn'),
(49, 10, 'aspirant', '2016-08-01', '2018-06-01', NULL, NULL, NULL, 4, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Bảo Lộc'),
(50, 10, 'novice', '2018-06-01', '2020-02-01', NULL, NULL, NULL, 3, 1, 'Giai đoạn Tập sinh tại Cộng Đoàn Đà Lạt'),
(51, 11, 'inquiry', '2014-01-01', '2015-11-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Hà Nội'),
(52, 11, 'postulant', '2015-01-01', '2016-11-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Núi Cúi'),
(53, 11, 'aspirant', '2016-01-01', '2018-08-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Nhà Mẹ'),
(54, 12, 'inquiry', '2013-04-01', '2014-11-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Hà Nội'),
(55, 12, 'postulant', '2014-07-01', '2015-10-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Nhà Mẹ'),
(56, 12, 'aspirant', '2015-03-01', '2017-05-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Nhà Mẹ'),
(57, 13, 'inquiry', '2014-08-01', '2015-01-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Núi Cúi'),
(58, 13, 'postulant', '2015-11-01', '2016-02-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Núi Cúi'),
(59, 13, 'aspirant', '2016-10-01', '2018-05-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Sài Gòn'),
(60, 14, 'inquiry', '2021-02-01', '2022-04-01', NULL, NULL, NULL, 4, 1, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Bảo Lộc'),
(61, 14, 'postulant', '2022-06-01', '2023-04-01', NULL, NULL, NULL, 6, 1, 'Giai đoạn Dự sinh tại Cộng Đoàn Hà Nội'),
(62, 14, 'aspirant', '2023-06-01', '2025-09-01', NULL, NULL, NULL, 1, 1, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Nhà Mẹ'),
(63, 15, 'inquiry', '2021-12-01', '2022-12-01', NULL, NULL, NULL, 4, 1, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Bảo Lộc'),
(64, 15, 'postulant', '2022-10-01', '2023-01-01', NULL, NULL, NULL, 3, 1, 'Giai đoạn Dự sinh tại Cộng Đoàn Đà Lạt'),
(65, 15, 'aspirant', '2023-06-01', '2025-01-01', NULL, NULL, NULL, 1, 1, 'Giai đoạn Thỉnh sinh tại Cộng Đoàn Nhà Mẹ'),
(66, 16, 'inquiry', '2026-10-01', '2027-06-01', NULL, NULL, NULL, 5, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Núi Cúi'),
(67, 16, 'postulant', '2027-07-01', '2028-12-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Sài Gòn'),
(68, 17, 'inquiry', '2026-05-01', '2027-08-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Sài Gòn'),
(69, 17, 'postulant', '2027-11-01', '2028-12-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Nhà Mẹ'),
(70, 18, 'inquiry', '2024-07-01', '2025-01-01', NULL, NULL, NULL, 6, 1, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Hà Nội'),
(71, 18, 'postulant', '2025-10-01', '2026-06-01', NULL, NULL, NULL, 4, 1, 'Giai đoạn Dự sinh tại Cộng Đoàn Bảo Lộc'),
(72, 19, 'inquiry', '2030-01-01', '2031-03-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Nhà Mẹ'),
(73, 19, 'postulant', '2031-07-01', '2032-02-01', NULL, NULL, NULL, 1, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Nhà Mẹ'),
(74, 20, 'inquiry', '2032-01-01', '2033-02-01', NULL, NULL, NULL, 6, NULL, 'Giai đoạn Tìm hiểu tại Cộng Đoàn Hà Nội'),
(75, 20, 'postulant', '2033-03-01', '2034-12-01', NULL, NULL, NULL, 2, NULL, 'Giai đoạn Dự sinh tại Cộng Đoàn Sài Gòn');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_table` (`table_name`),
  ADD KEY `idx_audit_user` (`user_id`);

--
-- Indexes for table `backups`
--
ALTER TABLE `backups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_conversation_id` (`conversation_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `communities`
--
ALTER TABLE `communities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `community_assignments`
--
ALTER TABLE `community_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_assignments_role` (`role`),
  ADD KEY `idx_assignments_sister` (`sister_id`),
  ADD KEY `idx_assignments_community` (`community_id`);

--
-- Indexes for table `community_members`
--
ALTER TABLE `community_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_community_date` (`community_id`,`start_date`,`end_date`),
  ADD KEY `idx_sister_date` (`sister_id`,`start_date`,`end_date`),
  ADD KEY `idx_role` (`role`);

--
-- Indexes for table `community_roles`
--
ALTER TABLE `community_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `departures`
--
ALTER TABLE `departures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departures_approver` (`approved_by`),
  ADD KEY `idx_departures_sister` (`sister_id`),
  ADD KEY `idx_departures_date` (`departure_date`);

--
-- Indexes for table `departure_records`
--
ALTER TABLE `departure_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departure_sister` (`sister_id`),
  ADD KEY `idx_departure_date` (`departure_date`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_education_sister` (`sister_id`),
  ADD KEY `idx_education_level` (`level`);

--
-- Indexes for table `education_levels`
--
ALTER TABLE `education_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_evaluations_sister` (`sister_id`),
  ADD KEY `fk_evaluations_evaluator` (`evaluator_id`),
  ADD KEY `idx_evaluations_period` (`evaluation_period`);

--
-- Indexes for table `health_records`
--
ALTER TABLE `health_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_health_sister` (`sister_id`);

--
-- Indexes for table `journey_stages`
--
ALTER TABLE `journey_stages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `missions`
--
ALTER TABLE `missions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_missions_field` (`field`),
  ADD KEY `idx_missions_sister` (`sister_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_is_pinned` (`is_pinned`),
  ADD KEY `idx_is_important` (`is_important`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_deleted_at` (`deleted_at`);

--
-- Indexes for table `sisters`
--
ALTER TABLE `sisters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `fk_sisters_created_by` (`created_by`),
  ADD KEY `idx_sisters_status` (`status`),
  ADD KEY `idx_sisters_dob` (`date_of_birth`),
  ADD KEY `fk_sisters_current_community` (`current_community_id`);

--
-- Indexes for table `sister_statuses`
--
ALTER TABLE `sister_statuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_setting_key` (`setting_key`),
  ADD KEY `idx_setting_group` (`setting_group`);

--
-- Indexes for table `training_courses`
--
ALTER TABLE `training_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_training_courses_sister` (`sister_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_active` (`is_active`),
  ADD KEY `idx_data_scope` (`data_scope`),
  ADD KEY `idx_super_admin` (`is_super_admin`);

--
-- Indexes for table `user_communities`
--
ALTER TABLE `user_communities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_community` (`user_id`,`community_id`),
  ADD KEY `granted_by` (`granted_by`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_community_id` (`community_id`);

--
-- Indexes for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_permission` (`user_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `granted_by` (`granted_by`);

--
-- Indexes for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_preference` (`user_id`,`preference_key`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `vocation_journey`
--
ALTER TABLE `vocation_journey`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vocation_journey_community` (`community_id`),
  ADD KEY `fk_vocation_journey_supervisor` (`supervisor_id`),
  ADD KEY `idx_vocation_stage` (`stage`),
  ADD KEY `idx_vocation_sister` (`sister_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `backups`
--
ALTER TABLE `backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `communities`
--
ALTER TABLE `communities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `community_assignments`
--
ALTER TABLE `community_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `community_members`
--
ALTER TABLE `community_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `community_roles`
--
ALTER TABLE `community_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `departures`
--
ALTER TABLE `departures`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `departure_records`
--
ALTER TABLE `departure_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `education_levels`
--
ALTER TABLE `education_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `evaluations`
--
ALTER TABLE `evaluations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `health_records`
--
ALTER TABLE `health_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `journey_stages`
--
ALTER TABLE `journey_stages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `missions`
--
ALTER TABLE `missions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=435;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `sisters`
--
ALTER TABLE `sisters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `sister_statuses`
--
ALTER TABLE `sister_statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `training_courses`
--
ALTER TABLE `training_courses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_communities`
--
ALTER TABLE `user_communities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5039;

--
-- AUTO_INCREMENT for table `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `vocation_journey`
--
ALTER TABLE `vocation_journey`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `community_assignments`
--
ALTER TABLE `community_assignments`
  ADD CONSTRAINT `fk_assignments_community` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_assignments_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `community_members`
--
ALTER TABLE `community_members`
  ADD CONSTRAINT `community_members_ibfk_1` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `community_members_ibfk_2` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `departures`
--
ALTER TABLE `departures`
  ADD CONSTRAINT `fk_departures_approver` FOREIGN KEY (`approved_by`) REFERENCES `sisters` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_departures_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `departure_records`
--
ALTER TABLE `departure_records`
  ADD CONSTRAINT `fk_departure_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `education`
--
ALTER TABLE `education`
  ADD CONSTRAINT `fk_education_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD CONSTRAINT `fk_evaluations_evaluator` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_evaluations_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `health_records`
--
ALTER TABLE `health_records`
  ADD CONSTRAINT `fk_health_records_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `missions`
--
ALTER TABLE `missions`
  ADD CONSTRAINT `fk_missions_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sisters`
--
ALTER TABLE `sisters`
  ADD CONSTRAINT `fk_sisters_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sisters_current_community` FOREIGN KEY (`current_community_id`) REFERENCES `communities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `training_courses`
--
ALTER TABLE `training_courses`
  ADD CONSTRAINT `fk_training_courses_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_communities`
--
ALTER TABLE `user_communities`
  ADD CONSTRAINT `user_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_communities_ibfk_3` FOREIGN KEY (`granted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_permissions_ibfk_3` FOREIGN KEY (`granted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `vocation_journey`
--
ALTER TABLE `vocation_journey`
  ADD CONSTRAINT `fk_vocation_journey_community` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vocation_journey_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vocation_journey_supervisor` FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
