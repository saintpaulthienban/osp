-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2025 at 05:47 PM
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
  `old_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_value`)),
  `new_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_value`)),
  `ip_address` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(1, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":null,\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:44:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:49:42.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 15:49:42'),
(2, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 15:49:42'),
(3, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 15:49:42'),
(4, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:49:42.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:49:42.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 15:50:12'),
(5, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 15:50:12'),
(6, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 15:50:12'),
(7, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:49:42.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:49:42.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 15:57:42'),
(8, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 15:57:42'),
(9, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 15:57:42'),
(10, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:49:42.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T15:44:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:49:42.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 15:58:15'),
(11, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 15:58:15'),
(12, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 15:58:15'),
(13, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 15:59:50'),
(14, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 15:59:50'),
(15, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:01:59.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:01:59.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:01:59.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:01:59.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:02:39'),
(16, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:02:39'),
(17, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:02:39'),
(18, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 16:02:50'),
(19, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 16:02:50'),
(20, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:12:28'),
(21, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:12:28'),
(22, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:12:28'),
(23, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 16:12:36'),
(24, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 16:12:36'),
(25, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:12:47'),
(26, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,73,74,75,76,77,78,79,80,81,82,83,84,34,35,36,33,72,71]}', '::1', '2025-12-14 16:12:47'),
(27, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:12:47'),
(28, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 16:12:50'),
(29, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-14 16:12:50'),
(30, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:13:04'),
(31, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:13:04'),
(32, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:13:04'),
(33, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:13:29'),
(34, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:13:29'),
(35, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:13:29'),
(36, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:13:59'),
(37, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,12,14,13,11,52,51]}', '::1', '2025-12-14 16:13:59'),
(38, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:14:00'),
(39, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:14:34'),
(40, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:14:34'),
(41, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:14:34'),
(42, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:15:23'),
(43, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,82,83,84,81]}', '::1', '2025-12-14 16:15:23'),
(44, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:15:23'),
(45, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:15:40'),
(46, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,27,24,26,25,23,58,57,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:15:40'),
(47, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:15:40'),
(48, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:22:18'),
(49, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:22:18'),
(50, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:22:18'),
(51, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:22:38'),
(52, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:22:38'),
(53, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:22:38'),
(54, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:12:13.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:12:13.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:23:33'),
(55, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:23:33'),
(56, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[1,2,3,4,5,6]}', '::1', '2025-12-14 16:23:33'),
(57, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:27:00'),
(58, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:27:00'),
(59, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,4,1]}', '::1', '2025-12-14 16:27:00'),
(60, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:27:18'),
(61, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:27:18'),
(62, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,4,1]}', '::1', '2025-12-14 16:27:18'),
(63, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:27:38'),
(64, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:27:38'),
(65, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,4,1]}', '::1', '2025-12-14 16:27:38'),
(66, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:27:59'),
(67, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:27:59'),
(68, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,4,1]}', '::1', '2025-12-14 16:27:59'),
(69, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:28:10'),
(70, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:28:10'),
(71, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:28:10'),
(72, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:28:24'),
(73, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:28:24'),
(74, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:28:24'),
(75, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:31:50'),
(76, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:31:50'),
(77, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:31:50'),
(78, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:32:09'),
(79, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:32:09'),
(80, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:32:09'),
(81, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:34:31'),
(82, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:34:31'),
(83, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:34:31'),
(84, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:34:42'),
(85, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:34:42'),
(86, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:34:42'),
(87, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:37:10'),
(88, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:37:10'),
(89, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:37:10'),
(90, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:37:19'),
(91, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:37:19'),
(92, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:37:19'),
(93, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:42:05'),
(94, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:42:05'),
(95, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:42:05'),
(96, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:42:14'),
(97, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:42:14'),
(98, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:42:14'),
(99, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:42:30'),
(100, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:42:30'),
(101, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:42:30'),
(102, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:43:12'),
(103, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:43:12'),
(104, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:43:12'),
(105, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:43:29'),
(106, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49]}', '::1', '2025-12-14 16:43:29'),
(107, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:43:29'),
(108, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:43:55'),
(109, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,81,82,83,84,78,80,79,77]}', '::1', '2025-12-14 16:43:55'),
(110, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:43:55'),
(111, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:26:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:26:37.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:44:14'),
(112, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,10,7,9,8,6,50,49,12,14,13,11,52,51]}', '::1', '2025-12-14 16:44:14'),
(113, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[]}', '::1', '2025-12-14 16:44:14'),
(114, 1, 'UPDATE', 'users', 5, '{\"id\":5,\"username\":\"user_dn\",\"email\":\"user_dn@osp.vn\",\"full_name\":\"Người dùng Đà Nẵng\",\"phone\":null,\"avatar\":null,\"last_login\":null,\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":5,\"username\":\"user_dn\",\"email\":\"user_dn@osp.vn\",\"full_name\":\"Người dùng Đà Nẵng\",\"phone\":null,\"avatar\":\"\",\"last_login\":null,\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:44:52.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '::1', '2025-12-14 16:44:52'),
(115, 1, 'UPDATE_PERMISSIONS', 'users', 5, NULL, '{\"permissionIds\":[1,15,23,10,7,9,8,6,50,49,32,29,31,30,28,60,59,12,14,13,11,52,51,78,80,79,77,20,22,21,19,56,55]}', '::1', '2025-12-14 16:44:52'),
(116, 1, 'ASSIGN_COMMUNITIES', 'users', 5, NULL, '{\"community_ids\":[4]}', '::1', '2025-12-14 16:44:52'),
(117, 1, 'UPDATE', 'users', 5, '{\"id\":5,\"username\":\"user_dn\",\"email\":\"user_dn@osp.vn\",\"full_name\":\"Người dùng Đà Nẵng\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:45:16.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:45:16.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":5,\"username\":\"user_dn\",\"email\":\"user_dn@osp.vn\",\"full_name\":\"Người dùng Đà Nẵng\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:45:16.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:45:16.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '::1', '2025-12-14 16:46:22'),
(118, 1, 'UPDATE_PERMISSIONS', 'users', 5, NULL, '{\"permissionIds\":[6,7,8,9,10,11,12,13,14,19,20,21,22,23,28,29,30,31,32,49,50,51,52,55,56,59,60,77,78,79,80,34,35,36,33,72,71,46,45,44,43,74,76,75,73,42,66,38,40,39,64,41,70,65,67,63,37,69,62,61,68,2,4,3,5,1,48,47,82,84,83,81,16,18,17,15,54,53]}', '::1', '2025-12-14 16:46:22'),
(119, 1, 'ASSIGN_COMMUNITIES', 'users', 5, NULL, '{\"community_ids\":[4]}', '::1', '2025-12-14 16:46:22'),
(120, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:46:50.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:46:50.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:46:50.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:46:50.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-14 16:47:01'),
(121, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:47:01'),
(122, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[1,2,3,4,5,6]}', '::1', '2025-12-14 16:47:01'),
(123, 1, 'UPDATE', 'users', 5, '{\"id\":5,\"username\":\"user_dn\",\"email\":\"user_dn@osp.vn\",\"full_name\":\"Người dùng Đà Nẵng\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:46:31.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:46:31.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":5,\"username\":\"user_dn\",\"email\":\"user_dn@osp.vn\",\"full_name\":\"Người dùng Đà Nẵng\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-14T16:46:31.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T16:46:31.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '::1', '2025-12-14 16:47:19'),
(124, 1, 'UPDATE_PERMISSIONS', 'users', 5, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}', '::1', '2025-12-14 16:47:19'),
(125, 1, 'ASSIGN_COMMUNITIES', 'users', 5, NULL, '{\"community_ids\":[4,5]}', '::1', '2025-12-14 16:47:19'),
(126, 1, 'UPDATE', 'vocation_journey', 10, '{\"id\":10,\"sister_id\":10,\"stage\":\"temporary_vows\",\"start_date\":\"2021-08-14T17:00:00.000Z\",\"end_date\":null,\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":4,\"supervisor_id\":null,\"notes\":null}', '{\"id\":10,\"sister_id\":10,\"stage\":\"temporary_vows\",\"start_date\":\"2021-08-13T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":null}', '::1', '2025-12-14 16:54:57'),
(127, 1, 'UPDATE', 'vocation_journey', 10, '{\"id\":10,\"sister_id\":10,\"stage\":\"temporary_vows\",\"start_date\":\"2021-08-13T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":null}', '{\"id\":10,\"sister_id\":10,\"stage\":\"temporary_vows\",\"start_date\":\"2021-08-12T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":2,\"supervisor_id\":null,\"notes\":null}', '::1', '2025-12-14 16:55:13'),
(128, 1, 'CREATE', 'communities', 7, NULL, '{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null}', '::1', '2025-12-15 12:36:24');
INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(129, 1, 'UPDATE', 'communities', 6, '{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null}', '{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:24:39.000Z\",\"history\":\"<p>xin chào</p>\"}', '::1', '2025-12-15 13:24:39'),
(130, 1, 'UPDATE', 'communities', 6, '{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:24:39.000Z\",\"history\":\"<p>xin chào</p>\"}', '{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:25:46.000Z\",\"history\":\"<p><br></p>\"}', '::1', '2025-12-15 13:25:46'),
(131, 1, 'UPDATE', 'communities', 6, '{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:25:46.000Z\",\"history\":\"<p><br></p>\"}', '{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:26:59.000Z\",\"history\":null}', '::1', '2025-12-15 13:26:59'),
(132, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-15 13:32:23'),
(133, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-15 13:32:23'),
(134, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/sisters?quick_range=this_year\",\"path\":\"/api/reports/sisters?quick_range=this_year\"}', '::1', '2025-12-15 13:32:32'),
(135, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/sisters?quick_range=this_year\",\"path\":\"/api/reports/sisters?quick_range=this_year\"}', '::ffff:127.0.0.1', '2025-12-15 13:32:32'),
(136, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/health?quick_range=this_year\",\"path\":\"/api/reports/health?quick_range=this_year\"}', '::1', '2025-12-15 13:32:34'),
(137, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/health?quick_range=this_year\",\"path\":\"/api/reports/health?quick_range=this_year\"}', '::ffff:127.0.0.1', '2025-12-15 13:32:34'),
(138, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/journey?quick_range=this_year\",\"path\":\"/api/reports/journey?quick_range=this_year\"}', '::1', '2025-12-15 13:32:34'),
(139, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/journey?quick_range=this_year\",\"path\":\"/api/reports/journey?quick_range=this_year\"}', '::ffff:127.0.0.1', '2025-12-15 13:32:34'),
(140, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-15 13:32:36'),
(141, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::ffff:127.0.0.1', '2025-12-15 13:32:36'),
(142, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-15 13:32:43'),
(143, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-15 13:32:43'),
(144, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-15 13:33:54'),
(145, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/statistics?start_date=&end_date=&quick_range=this_year\",\"path\":\"/api/reports/statistics?start_date=&end_date=&quick_range=this_year\"}', '::1', '2025-12-15 13:33:54'),
(146, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/journey/export/excel?quick_range=this_year\",\"path\":\"/api/reports/journey/export/excel?quick_range=this_year\"}', '::1', '2025-12-15 14:18:55'),
(147, 1, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/reports/journey/export/pdf?quick_range=this_year\",\"path\":\"/api/reports/journey/export/pdf?quick_range=this_year\"}', '::1', '2025-12-15 14:18:56'),
(148, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 15:37:02'),
(149, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,168]}', '::1', '2025-12-15 15:37:02'),
(150, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,4,1]}', '::1', '2025-12-15 15:37:02'),
(151, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 15:37:42'),
(152, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,168,170,172,171,169]}', '::1', '2025-12-15 15:37:43'),
(153, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[7,1,2,3,4,5,6]}', '::1', '2025-12-15 15:37:43'),
(154, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/general\",\"path\":\"/api/settings/general\"}', '::1', '2025-12-15 16:00:55'),
(155, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/general\",\"path\":\"/api/settings/general\"}', '::1', '2025-12-15 16:00:55'),
(156, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/system\",\"path\":\"/api/settings/system\"}', '::1', '2025-12-15 16:00:57'),
(157, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/system\",\"path\":\"/api/settings/system\"}', '::1', '2025-12-15 16:00:57'),
(158, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 16:25:41'),
(159, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,168,169,170,171,172]}', '::1', '2025-12-15 16:25:41'),
(160, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 16:25:41'),
(161, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 16:39:39'),
(162, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,168,169,170,171,172,427,428,429,430]}', '::1', '2025-12-15 16:39:40'),
(163, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 16:39:40'),
(164, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 16:39:59'),
(165, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,98,99,100,101,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,168,169,170,171,172,427,428,429,430,95,96,97,90,91,93,94]}', '::1', '2025-12-15 16:39:59'),
(166, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 16:39:59'),
(167, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T15:22:33.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T15:22:33.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 16:40:23'),
(168, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,90,91,93,94,95,96,97,98,99,100,101,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,168,169,170,171,172,427,428,429,430,107,108,105,109]}', '::1', '2025-12-15 16:40:23'),
(169, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 16:40:23'),
(170, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/general\",\"path\":\"/api/settings/general\"}', '::1', '2025-12-15 16:45:33'),
(171, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/general\",\"path\":\"/api/settings/general\"}', '::1', '2025-12-15 16:45:33'),
(172, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/system\",\"path\":\"/api/settings/system\"}', '::1', '2025-12-15 16:45:35'),
(173, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/system\",\"path\":\"/api/settings/system\"}', '::1', '2025-12-15 16:45:35'),
(174, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/system\",\"path\":\"/api/settings/system\"}', '::1', '2025-12-15 16:45:51'),
(175, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/system\",\"path\":\"/api/settings/system\"}', '::1', '2025-12-15 16:45:51'),
(176, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/backups\",\"path\":\"/api/settings/backups\"}', '::1', '2025-12-15 16:45:56'),
(177, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/storage-info\",\"path\":\"/api/settings/storage-info\"}', '::1', '2025-12-15 16:45:56'),
(178, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/backups\",\"path\":\"/api/settings/backups\"}', '::1', '2025-12-15 16:45:56'),
(179, NULL, 'error', 'system', NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/settings/storage-info\",\"path\":\"/api/settings/storage-info\"}', '::1', '2025-12-15 16:45:56'),
(180, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 17:07:53'),
(181, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,168,169,170,171,172,427,428,429,430,10,7,9,8,86,85,6,50,49,12,14,13,11,52,51]}', '::1', '2025-12-15 17:07:53'),
(182, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 17:07:53'),
(183, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 17:19:08'),
(184, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,168,169,170,171,172,427,428,429,430]}', '::1', '2025-12-15 17:19:08'),
(185, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 17:19:08'),
(186, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 17:19:27'),
(187, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,168,169,170,171,172]}', '::1', '2025-12-15 17:19:28'),
(188, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 17:19:28'),
(189, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 17:19:42'),
(190, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,168]}', '::1', '2025-12-15 17:19:42'),
(191, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 17:19:42'),
(192, 1, 'UPDATE', 'users', 1, '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '{\"id\":1,\"username\":\"admin\",\"email\":\"admin@osp.vn\",\"full_name\":\"Quản trị viên\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-15T16:58:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T16:58:35.000Z\",\"is_admin\":1,\"data_scope\":\"all\",\"is_super_admin\":1}', '::1', '2025-12-15 17:20:06'),
(193, 1, 'UPDATE_PERMISSIONS', 'users', 1, NULL, '{\"permissionIds\":[6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,168,427,429,430,428,170,172,171,169,2,4,3,5,1,48,47,95,96,97,90,91,93,94]}', '::1', '2025-12-15 17:20:06'),
(194, 1, 'ASSIGN_COMMUNITIES', 'users', 1, NULL, '{\"community_ids\":[6,5,2,3,7,4,1]}', '::1', '2025-12-15 17:20:06'),
(195, 1, 'UPDATE', 'sisters', 2, '{\"id\":2,\"code\":\"SR002\",\"saint_name\":\"Anna\",\"birth_name\":\"Trần Thị Hoa\",\"date_of_birth\":\"1990-07-21T17:00:00.000Z\",\"place_of_birth\":\"Đà Nẵng\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"SR002\",\"saint_name\":\"Anna\",\"birth_name\":\"Trần Thị Hoa\",\"date_of_birth\":\"1990-07-20T17:00:00.000Z\",\"place_of_birth\":\"Đà Nẵng\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-16T12:25:59.000Z\",\"documents\":null}', '::1', '2025-12-16 12:25:59'),
(196, 1, 'UPDATE', 'sisters', 2, '{\"id\":2,\"code\":\"SR002\",\"saint_name\":\"Anna\",\"birth_name\":\"Trần Thị Hoa\",\"date_of_birth\":\"1990-07-20T17:00:00.000Z\",\"place_of_birth\":\"Đà Nẵng\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-16T12:25:59.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"SR002\",\"saint_name\":\"Anna\",\"birth_name\":\"Trần Thị Hoa\",\"date_of_birth\":\"1990-07-20T17:00:00.000Z\",\"place_of_birth\":\"Đà Nẵng\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":\"/uploads/photos/1765887959737-zyz7nr.jpg\",\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-16T12:25:59.000Z\",\"documents\":null}', '::1', '2025-12-16 12:25:59'),
(197, 1, 'UPDATE', 'missions', 2, '{\"id\":2,\"sister_id\":2,\"field\":\"education\",\"specific_role\":\"Giáo viên Tiểu học\",\"start_date\":\"2016-08-31T17:00:00.000Z\",\"end_date\":null,\"notes\":null}', '{\"id\":2,\"sister_id\":2,\"field\":\"\",\"specific_role\":\"Giáo viên Tiểu học\",\"start_date\":\"2016-08-30T17:00:00.000Z\",\"end_date\":null,\"notes\":\"\"}', '::1', '2025-12-16 13:44:27'),
(198, 1, 'UPDATE', 'missions', 2, '{\"id\":2,\"sister_id\":2,\"field\":\"\",\"specific_role\":\"Giáo viên Tiểu học\",\"start_date\":\"2016-08-30T17:00:00.000Z\",\"end_date\":null,\"notes\":\"\"}', '{\"id\":2,\"sister_id\":2,\"field\":\"\",\"specific_role\":\"Giáo viên Tiểu học\",\"start_date\":\"2016-08-29T17:00:00.000Z\",\"end_date\":null,\"notes\":\"\"}', '::1', '2025-12-16 13:44:35'),
(199, 1, 'UPDATE', 'missions', 2, '{\"id\":2,\"sister_id\":2,\"field\":\"\",\"specific_role\":\"Giáo viên Tiểu học\",\"start_date\":\"2016-08-29T17:00:00.000Z\",\"end_date\":null,\"notes\":\"\"}', '{\"id\":2,\"sister_id\":2,\"field\":\"\",\"specific_role\":\"Giáo viên Tiểu học\",\"start_date\":\"2016-08-28T17:00:00.000Z\",\"end_date\":null,\"notes\":\"\"}', '::1', '2025-12-16 13:45:12');

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
(17, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'sức khỏe của chị thế nào?', 'Rất tiếc, tôi không có thông tin cụ thể về tình trạng sức khỏe của chị Hồ Thị Yến. Nếu bạn có thắc mắc khác hoặc cần thông tin về các vấn đề khác liên quan đến nữ tu hoặc cộng đoàn, hãy cho tôi biết! 📚', '{\"text\":\"📋 Thông tin hệ thống:\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.\",\"data\":{\"totalSisters\":15,\"totalCommunities\":7},\"sources\":[]}', '{\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'health_info', 1303, 0.000221, NULL, NULL, '2025-12-16 13:11:16', '2025-12-16 13:11:16');

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
(1, 'MH', 'Nhà Mẹ - Thủ Đức', '123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM', '028-1234567', 'nhame@osp.vn', NULL, 'active', NULL, '2025-12-14 15:27:02', NULL, NULL),
(2, 'SG01', 'Cộng đoàn Sài Gòn 1', '456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM', '028-2345678', 'sg01@osp.vn', NULL, 'active', NULL, '2025-12-14 15:27:02', NULL, NULL),
(3, 'SG02', 'Cộng đoàn Sài Gòn 2', '789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM', '028-3456789', 'sg02@osp.vn', NULL, 'active', NULL, '2025-12-14 15:27:02', NULL, NULL),
(4, 'DN01', 'Cộng đoàn Đà Nẵng', '12 Đường Trần Phú, Hải Châu, Đà Nẵng', '0236-123456', 'dn01@osp.vn', NULL, 'active', NULL, '2025-12-14 15:27:02', NULL, NULL),
(5, 'HN01', 'Cộng đoàn Hà Nội', '34 Đường Hoàng Diệu, Ba Đình, Hà Nội', '024-1234567', 'hn01@osp.vn', NULL, 'active', NULL, '2025-12-14 15:27:02', NULL, NULL),
(6, 'CT01', 'Cộng đoàn Cần Thơ', '56 Đường 30/4, Ninh Kiều, Cần Thơ', '0292-123456', 'ct01@osp.vn', NULL, 'active', NULL, '2025-12-14 15:27:02', '2025-12-15 13:26:59', NULL),
(7, 'CD001', 'Cộng Đoàn Đà Lạt', '12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng', '0987654321', 'dalat@gmail.com', '2015-08-12', 'active', '', '2025-12-15 12:36:24', NULL, NULL);

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
(1, 1, 1, 'superior', '2020-01-01', NULL, NULL, NULL, NULL, NULL),
(2, 2, 1, 'deputy', '2020-01-01', NULL, NULL, NULL, NULL, NULL),
(3, 3, 1, 'member', '2021-06-01', NULL, NULL, NULL, NULL, NULL),
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
(1, 1, 'master', 'Thần học', 'Học viện Công giáo Việt Nam', NULL, NULL, NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(2, 2, 'bachelor', 'Sư phạm', 'Đại học Sư phạm TP.HCM', NULL, NULL, NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(3, 4, 'master', 'Quản trị giáo dục', 'Đại học Giáo dục - ĐHQG Hà Nội', NULL, NULL, NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(4, 7, 'bachelor', 'Điều dưỡng', 'Đại học Y Dược TP.HCM', NULL, NULL, NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(5, 9, 'doctorate', 'Triết học', 'Đại học Gregorian, Roma', NULL, NULL, NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL),
(6, 11, 'bachelor', 'Truyền thông', 'Đại học KHXH&NV TP.HCM', NULL, NULL, NULL, NULL, 'dang_hoc', NULL, NULL, NULL, NULL);

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
(1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-H1', 1, 8, 9, 8, 9, 9, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(2, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-H1', 1, 7, 8, 8, 8, 8, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(3, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-H1', 1, 8, 8, 7, 8, 9, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(4, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-H1', 1, 9, 9, 9, 9, 9, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL);

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
(1, 1, 'good', NULL, NULL, '2024-06-15', NULL, 'Bệnh viện Thống Nhất', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(2, 2, 'good', NULL, NULL, '2024-06-15', NULL, 'Bệnh viện Thống Nhất', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(3, 3, 'average', 'Cao huyết áp nhẹ', NULL, '2024-05-20', NULL, 'Bệnh viện Chợ Rẫy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(4, 5, 'good', NULL, NULL, '2024-07-01', NULL, 'Bệnh viện Đà Nẵng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(5, 7, 'weak', 'Tiểu đường type 2', NULL, '2024-04-10', NULL, 'Bệnh viện 115', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL),
(6, 10, 'good', NULL, NULL, '2024-08-05', NULL, 'Bệnh viện Bạch Mai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-14 15:27:02', NULL);

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
(1, 1, 'education', 'Hiệu trưởng trường Mầm non', NULL, NULL, '2018-09-01', NULL, NULL),
(2, 2, '', 'Giáo viên Tiểu học', NULL, NULL, '2016-08-29', NULL, ''),
(3, 4, 'education', 'Quản lý trường THCS', NULL, NULL, '2015-09-01', NULL, NULL),
(4, 7, 'healthcare', 'Điều dưỡng trưởng', NULL, NULL, '2019-01-01', NULL, NULL),
(5, 9, 'pastoral', 'Huấn luyện viên', NULL, NULL, '2017-01-01', NULL, NULL),
(6, 11, 'media', 'Biên tập viên', NULL, NULL, '2023-01-01', NULL, NULL),
(7, 13, 'social', 'Nhân viên xã hội', NULL, NULL, '2024-01-01', NULL, NULL);

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

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `is_read`, `created_at`, `read_at`) VALUES
(1, 1, 'info', 'Chào mừng!', 'Chào mừng bạn đến với hệ thống quản lý Hội Dòng OSP', '/dashboard', 0, '2025-12-15 17:06:44', NULL),
(2, 1, 'warning', 'Nhắc nhở', 'Có 3 hồ sơ nữ tu cần được cập nhật thông tin', '/nu-tu', 0, '2025-12-15 17:06:44', NULL),
(3, 1, 'success', 'Báo cáo hoàn thành', 'Báo cáo thống kê tháng 12 đã được tạo thành công', '/bao-cao', 0, '2025-12-15 17:06:44', NULL),
(4, 1, 'birthday', 'Sinh nhật', 'Hôm nay là sinh nhật của Sr. Maria Nguyễn', '/nu-tu/1', 0, '2025-12-15 17:06:44', NULL),
(5, 1, 'reminder', 'Đánh giá định kỳ', '5 nữ tu cần được đánh giá trong tháng này', '/danh-gia', 0, '2025-12-15 17:06:44', NULL),
(6, 1, 'info', 'Chào mừng!', 'Chào mừng bạn đến với hệ thống quản lý Hội Dòng OSP', '/dashboard', 0, '2025-12-15 17:06:48', NULL),
(7, 1, 'warning', 'Nhắc nhở', 'Có 3 hồ sơ nữ tu cần được cập nhật thông tin', '/nu-tu', 0, '2025-12-15 17:06:48', NULL),
(8, 1, 'success', 'Báo cáo hoàn thành', 'Báo cáo thống kê tháng 12 đã được tạo thành công', '/bao-cao', 0, '2025-12-15 17:06:48', NULL),
(9, 1, 'birthday', 'Sinh nhật', 'Hôm nay là sinh nhật của Sr. Maria Nguyễn', '/nu-tu/1', 0, '2025-12-15 17:06:48', NULL),
(10, 1, 'reminder', 'Đánh giá định kỳ', '5 nữ tu cần được đánh giá trong tháng này', '/danh-gia', 0, '2025-12-15 17:06:48', NULL);

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
(1, 'SR001', 'Maria', 'Nguyễn Thị Mai', '1985-03-15', 'TP.HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'perpetual_vows', 1, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(2, 'SR002', 'Anna', 'Trần Thị Hoa', '1990-07-21', 'Đà Nẵng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '/uploads/photos/1765887959737-zyz7nr.jpg', 'active', 'perpetual_vows', 1, 1, '2025-12-14 15:27:02', '2025-12-16 12:25:59', NULL),
(3, 'SR003', 'Teresa', 'Lê Thị Lan', '1988-11-08', 'Hà Nội', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'temporary_vows', 1, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(4, 'SR004', 'Rosa', 'Phạm Thị Cúc', '1992-05-30', 'Cần Thơ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'perpetual_vows', 2, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(5, 'SR005', 'Clara', 'Hoàng Thị Đào', '1987-09-12', 'Huế', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'temporary_vows', 2, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(6, 'SR006', 'Agnes', 'Vũ Thị Hồng', '1995-01-25', 'Hải Phòng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'novice', 2, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(7, 'SR007', 'Monica', 'Đặng Thị Tuyết', '1993-04-18', 'Bình Dương', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'perpetual_vows', 3, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(8, 'SR008', 'Lucia', 'Bùi Thị Nga', '1989-08-05', 'Đồng Nai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'temporary_vows', 3, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(9, 'SR009', 'Catherine', 'Ngô Thị Linh', '1991-12-10', 'Vũng Tàu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'perpetual_vows', 4, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(10, 'SR010', 'Theresa', 'Đinh Thị Phương', '1986-06-28', 'Nha Trang', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'temporary_vows', 4, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(11, 'SR011', 'Bernadette', 'Lý Thị Thảo', '1994-02-14', 'Đà Lạt', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'novice', 5, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(12, 'SR012', 'Josephine', 'Hồ Thị Yến', '1988-10-03', 'Quảng Nam', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'temporary_vows', 5, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(13, 'SR013', 'Magdalene', 'Cao Thị Xuân', '1996-07-17', 'Bắc Ninh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'postulant', 6, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(14, 'SR014', 'Veronica', 'Tạ Thị Thu', '1990-03-25', 'Nam Định', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'temporary_vows', 6, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL),
(15, 'SR015', 'Elizabeth', 'Dương Thị Hạnh', '1985-11-20', 'Thanh Hóa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'perpetual_vows', 6, 1, '2025-12-14 15:27:02', '2025-12-14 15:27:02', NULL);

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
(1, 'admin', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'admin@osp.vn', 'Quản trị viên', NULL, '', '2025-12-16 19:24:49', 1, '2025-12-14 15:27:02', '2025-12-16 12:24:49', 1, 'all', 1),
(2, 'superior', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'superior@osp.vn', 'Bề trên Tổng quyền', NULL, NULL, NULL, 1, '2025-12-14 15:27:02', NULL, 0, 'all', 0),
(3, 'secretary', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'secretary@osp.vn', 'Thư ký', NULL, NULL, NULL, 1, '2025-12-14 15:27:02', NULL, 0, 'all', 0),
(4, 'user_sg', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'user_sg@osp.vn', 'Người dùng Sài Gòn', NULL, NULL, NULL, 1, '2025-12-14 15:27:02', NULL, 0, 'community', 0),
(5, 'user_dn', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'user_dn@osp.vn', 'Người dùng Đà Nẵng', NULL, '', '2025-12-14 23:47:36', 1, '2025-12-14 15:27:02', '2025-12-14 16:47:36', 0, 'community', 0),
(6, 'user_hn', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'user_hn@osp.vn', 'Người dùng Hà Nội', NULL, NULL, NULL, 1, '2025-12-14 15:27:02', NULL, 0, 'community', 0);

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
(114, 1, 6, 0, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06', NULL),
(115, 1, 5, 0, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06', NULL),
(116, 1, 2, 0, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06', NULL),
(117, 1, 3, 0, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06', NULL),
(118, 1, 7, 0, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06', NULL),
(119, 1, 4, 0, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06', NULL),
(120, 1, 1, 0, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06', NULL);

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
(4761, 1, 6, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4762, 1, 7, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4763, 1, 8, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4764, 1, 9, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4765, 1, 10, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4766, 1, 11, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4767, 1, 12, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4768, 1, 13, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4769, 1, 14, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4770, 1, 15, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4771, 1, 16, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4772, 1, 17, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4773, 1, 18, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4774, 1, 19, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4775, 1, 20, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4776, 1, 21, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4777, 1, 22, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4778, 1, 23, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4779, 1, 24, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4780, 1, 25, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4781, 1, 26, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4782, 1, 27, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4783, 1, 28, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4784, 1, 29, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4785, 1, 30, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4786, 1, 31, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4787, 1, 32, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4788, 1, 33, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4789, 1, 34, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4790, 1, 35, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4791, 1, 36, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4792, 1, 37, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4793, 1, 38, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4794, 1, 39, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4795, 1, 40, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4796, 1, 41, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4797, 1, 42, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4798, 1, 49, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4799, 1, 50, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4800, 1, 51, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4801, 1, 52, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4802, 1, 53, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4803, 1, 54, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4804, 1, 55, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4805, 1, 56, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4806, 1, 57, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4807, 1, 58, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4808, 1, 59, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4809, 1, 60, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4810, 1, 61, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4811, 1, 62, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4812, 1, 63, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4813, 1, 64, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4814, 1, 65, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4815, 1, 66, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4816, 1, 67, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4817, 1, 68, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4818, 1, 69, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4819, 1, 70, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4820, 1, 71, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4821, 1, 72, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4822, 1, 73, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4823, 1, 74, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4824, 1, 75, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4825, 1, 76, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4826, 1, 77, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4827, 1, 78, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4828, 1, 79, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4829, 1, 80, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4830, 1, 81, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4831, 1, 82, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4832, 1, 83, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4833, 1, 84, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4834, 1, 85, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4835, 1, 86, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4836, 1, 98, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4837, 1, 99, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4838, 1, 100, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4839, 1, 101, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4840, 1, 105, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4841, 1, 107, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4842, 1, 108, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4843, 1, 109, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4844, 1, 112, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4845, 1, 116, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4846, 1, 118, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4847, 1, 121, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4848, 1, 123, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4849, 1, 124, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4850, 1, 125, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4851, 1, 126, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4852, 1, 127, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4853, 1, 128, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4854, 1, 131, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4855, 1, 133, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4856, 1, 134, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4857, 1, 135, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4858, 1, 136, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4859, 1, 137, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4860, 1, 138, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4861, 1, 139, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4862, 1, 140, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4863, 1, 141, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4864, 1, 142, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4865, 1, 143, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4866, 1, 144, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4867, 1, 145, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4868, 1, 146, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4869, 1, 147, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4870, 1, 148, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4871, 1, 162, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4872, 1, 163, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4873, 1, 168, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4874, 1, 427, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4875, 1, 429, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4876, 1, 430, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4877, 1, 428, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4878, 1, 170, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4879, 1, 172, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4880, 1, 171, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4881, 1, 169, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4882, 1, 2, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4883, 1, 4, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4884, 1, 3, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4885, 1, 5, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4886, 1, 1, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4887, 1, 48, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4888, 1, 47, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4889, 1, 95, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4890, 1, 96, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4891, 1, 97, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4892, 1, 90, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4893, 1, 91, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4894, 1, 93, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06'),
(4895, 1, 94, 1, '2025-12-15 17:20:06', '2025-12-15 17:20:06');

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
(1, 1, 'perpetual_vows', '2010-08-15', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(2, 2, 'perpetual_vows', '2015-08-15', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(3, 3, 'temporary_vows', '2020-08-15', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(4, 4, 'perpetual_vows', '2012-08-15', NULL, NULL, NULL, NULL, 2, NULL, NULL),
(5, 5, 'temporary_vows', '2021-08-15', NULL, NULL, NULL, NULL, 2, NULL, NULL),
(6, 6, 'novice', '2023-02-01', NULL, NULL, NULL, NULL, 2, NULL, NULL),
(7, 7, 'perpetual_vows', '2014-08-15', NULL, NULL, NULL, NULL, 3, NULL, NULL),
(8, 8, 'temporary_vows', '2022-08-15', NULL, NULL, NULL, NULL, 3, NULL, NULL),
(9, 9, 'perpetual_vows', '2013-08-15', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(10, 10, 'temporary_vows', '2021-08-13', '0000-00-00', NULL, NULL, NULL, 2, NULL, NULL),
(11, 11, 'novice', '2023-06-01', NULL, NULL, NULL, NULL, 5, NULL, NULL),
(12, 12, 'temporary_vows', '2019-08-15', NULL, NULL, NULL, NULL, 5, NULL, NULL),
(13, 13, 'postulant', '2024-01-15', NULL, NULL, NULL, NULL, 6, NULL, NULL),
(14, 14, 'temporary_vows', '2020-08-15', NULL, NULL, NULL, NULL, 6, NULL, NULL),
(15, 15, 'perpetual_vows', '2011-08-15', NULL, NULL, NULL, NULL, 6, NULL, NULL);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- AUTO_INCREMENT for table `backups`
--
ALTER TABLE `backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
-- AUTO_INCREMENT for table `departure_records`
--
ALTER TABLE `departure_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `evaluations`
--
ALTER TABLE `evaluations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `health_records`
--
ALTER TABLE `health_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `journey_stages`
--
ALTER TABLE `journey_stages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `missions`
--
ALTER TABLE `missions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_communities`
--
ALTER TABLE `user_communities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4896;

--
-- AUTO_INCREMENT for table `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `vocation_journey`
--
ALTER TABLE `vocation_journey`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
