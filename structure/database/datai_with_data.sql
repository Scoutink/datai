-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 12, 2026 at 04:25 PM
-- Server version: 10.6.23-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `datai`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE `actions` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `pageId` char(36) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) DEFAULT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `actions`
--

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('0478e8b6-7d52-4c26-99e1-657a1c703e8b', 'DELETE_FILE_REQUEST', 4, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_DELETE_FILE_REQUEST', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('07ad64e9-9a43-40d0-a205-2adb81e238b1', 'Storage Settings', 2, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_STORAGE_SETTINGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('086ce19f-5f1b-42ec-98ac-dea2d92901a3', 'Archive Document', 1, 'c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'EXPIRED_DOCUMENTS_ARCHIVE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', 'Edit User', 3, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_EDIT_USER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('0f70cc17-26a9-43b1-922e-01fefb248d3c', 'VIEW_WORKFLOW_LIST', 1, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_VIEW_WORKFLOW_SETTINGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('165505b2-ad31-42c7-aafe-f66f291cb5a9', 'Manage Comment', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_MANAGE_COMMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', 'Delete Role', 4, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_DELETE_ROLE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('18d07817-4b47-4c84-b21f-abe05da5e1ba', 'Archive Document', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_ARCHIVE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('1ae728c8-58df-4e9f-b284-132dc3c8ff89', 'REJECT_FILE_REQUEST', 6, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_REJECT_FILE_REQUEST', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', 'View Document Audit Trail', 1, '2396f81c-f8b5-49ac-88d1-94ed57333f49', 'DOCUMENT_AUDIT_TRAIL_VIEW_DOCUMENT_AUDIT_TRAIL', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('1d768490-d67d-40b6-b610-22b17cc7ce2d', 'Add Indexing', 2, '0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'DEEP_SEARCH_ADD_INDEXING', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('1e5fc904-5f70-4b07-8914-242703da5702', 'View Email Logs', 3, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGS_VIEW_EMAIL_LOGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('229150ef-9007-4c62-9276-13dd18294370', 'Restore Version', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_RESTORE_VERSION', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('229ad778-c7d3-4f5f-ab52-24b537c39514', 'Delete Document', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_DELETE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('239035d5-cd44-475f-bbc5-9ef51768d389', 'Create Document', 2, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_CREATE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('260d1089-46c7-4f53-83e6-f80b9b3fb823', 'Archive Document', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_ARCHIVE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('26e383c9-7f7f-4ed0-b78d-a2941f5b4fe7', 'Add Reminder', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_ADD_REMINDER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('2e71e9d6-2302-44d8-b0f6-747b98d89125', 'UPDATE_FILE_REQUEST', 3, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_UPDATE_FILE_REQUEST', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('2ea6ba08-eb36-4e34-92d9-f1984c908b31', 'Share Document', 6, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_SHARE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('2f264576-2d7f-44a2-beeb-97c53847ad70', 'Update Email Log Settings', 5, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'EMAIL_LOG_SET_RETENTION_PERIOD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('31ba8e74-8fa0-4c34-82ac-950e73a4c18e', 'Activate Document', 1, 'c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'EXPIRED_DOCUMENTS_ACTIVATE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('31cb6438-7d4a-4385-8a34-b4e8f6096a48', 'View Users', 1, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_VIEW_USERS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('322c388d-0ab4-4617-9bee-a8c79906e738', 'Update Archive Document Settings', 4, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_SET_RETENTION_PERIOD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('324192f0-a319-4228-ba06-f1ce10189822', 'Update Login Audit Settings', 7, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGIN_AUDIT_SET_RETENTION_PERIOD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('374d74aa-a580-4928-848d-f7553db39914', 'Delete User', 4, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_DELETE_USER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('37db8a21-e552-466d-bcf4-f90f5e4e1008', 'VIEW_DETAIL', 9, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_VIEW_DETAIL', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('391c1739-1045-4dd4-9705-4a960479f0a0', 'Upload New Version', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_UPLOAD_NEW_VERSION', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('3ccaf408-8864-4815-a3e0-50632d90bcb6', 'Edit Reminder', 3, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_EDIT_REMINDER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('3da78b4d-d263-4b13-8e81-7aa164a3688c', 'Add Reminder', 5, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_ADD_REMINDER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('4071ed2e-56fb-4c5a-887d-8a175cac8d71', 'Restore Document', 4, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_RESTORE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('41f65d07-9023-4cfb-9c7c-0e3247a012e0', 'Manage SMTP Settings', 1, '2e3c07a4-fcac-4303-ae47-0d0f796403c9', 'EMAIL_MANAGE_SMTP_SETTINGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('44ecbcaf-6d4a-4fc2-911c-e96be65bffb2', 'Manage Comment', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_MANAGE_COMMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('4cce3cb4-5179-4fc7-b59c-7b15afc747f7', 'MANAGE_CLIENTS', 1, '34328287-3a37-4c70-ac61-b291c3ef5ade', 'CLIENTS_MANAGE_CLIENTS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('4f0e8a83-8a01-415e-88f5-c204369290de', 'Deep Search', 1, '0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'DEEP_SEARCH_DEEP_SEARCH', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('538c081b-2e14-4f0d-bc34-5f26ad2f77cf', 'Delete Email Log', 4, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGS_DELETE_EMAIL_LOG', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('57216dcd-1a1c-4f94-a33d-83a5af2d7a46', 'View Roles', 1, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_VIEW_ROLES', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('57f0b2ef-eeba-44a6-bd88-458003f013ef', 'Upload New Version', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_UPLOAD_NEW_VERSION', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('595a769d-f7ef-45f3-9f9e-60c58c5e1542', 'Send Email', 8, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_SEND_EMAIL', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', 'Delete Reminder', 4, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_DELETE_REMINDER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('5f24c3d8-94d8-4e57-adb3-bef3e000e7d0', 'View Expired Documents', 1, 'c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'EXPIRED_DOCUMENTS_VIEW_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('5f7c13fd-3c5d-4e69-9e21-a263924d273b', 'Change PDF Signature Settings', 6, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_CHANGE_PDF_SETTINGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('61de0ba3-f41f-4ca8-9af6-ec8dc456c16b', 'CREATE_FILE_REQUEST', 2, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_CREATE_FILE_REQUEST', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('63355376-2650-4949-9580-fc8c888353f0', 'Manage Open AI API Key', 2, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_MANAGE_OPEN_AI_API_KEY', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('63ed1277-1db5-4cf7-8404-3e3426cb4bc5', 'View Documents', 1, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_VIEW_DOCUMENTS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('6719a065-8a4a-4350-8582-bfc41ce283fb', 'Download Document', 7, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_DOWNLOAD_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('6b0fe007-1b92-4568-a4b7-6d105eb5c48c', 'PERFORM_TRANSITION', 1, '5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'WORKFLOW_ALL_PERFORM_TRANSITION', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('6bc0458e-22f5-4975-b387-4d6a4fb35201', 'Create Reminder', 2, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_CREATE_REMINDER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('6f2717fc-edef-4537-916d-2d527251a5c1', 'View Reminders', 1, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_VIEW_REMINDERS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('707c447d-5e0b-454a-abdf-550d8923eabc', 'START_WORKFLOW', 7, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_START_WORKFLOW', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('72ca5c91-b415-4997-a234-b4d71ba03253', 'Manage Languages', 1, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTING_MANAGE_LANGUAGE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('72ce114a-d299-4d7d-aeee-598167a4fabc', 'Generate AI Powered Summary', 5, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOC_GENERATE_SUMMARY', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('7562978b-155a-4fb1-bc3f-6153f62ed565', 'VIEW_FILE_REQUEST', 1, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_VIEW_FILE_REQUEST', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('78d881d1-1da5-42d9-a97b-a6ad71e27ebc', 'Add Watermark', 15, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOC_WATERMARK', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('79ce78a8-0716-4850-a40b-cdc36f3579e4', 'VIEW_WORKFLOW_LOGS', 1, 'b2c3d4e5-6f7g-8h9i-0j1k-2l3m4n5o6p7q', 'WORKFLOW_VIEW_WORKFLOW_LOGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('7ba630ca-a9d3-42ee-99c8-766e2231fec1', 'View Dashboard', 1, '42e44f15-8e33-423a-ad7f-17edc23d6dd3', 'DASHBOARD_VIEW_DASHBOARD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('86ce1382-a2b1-48ed-ae81-c9908d00cf3b', 'Create User', 2, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_CREATE_USER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('8b63ccd0-616a-4b97-8af6-aa49066a0a9e', 'Generate AI Powered Summary', 6, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOC_GENERATE_SUMMARY', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8d7e1668-ab2d-4aa5-b8d1-0358906d6995', 'VIEW_DETAIL', 9, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_VIEW_DETAIL', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8e3fbe21-0225-44e2-a537-bb50ddffb95c', 'MANAGE_ALLOW_FILE_EXTENSIONS', 4, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_MANAGE_ALLOW_FILE_EXTENSIONS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('92596605-e49a-4ab6-8a39-60116eba8abe', 'Delete Document', 6, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_DELETE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('96865813-77f0-40cf-968d-8b9c023d810e', 'ADD_WORKFLOW', 2, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_ADD_WORKFLOW', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('9a086704-b7c2-4dff-9088-dde29ad259ef', 'Remove Indexing', 3, '0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'DEEP_SEARCH_REMOVE_INDEXING', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('9ac0f6f5-0731-49d9-a7b9-6fbd92291241', 'Update Cron Job Log Settings', 6, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'CRON_JOB_LOG_SET_RETENTION_PERIOD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'START_WORKFLOW', 7, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_START_WORKFLOW', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a57b1ad5-8fbc-429b-b776-fbb468e5c6a4', 'Manage Company Profile', 2, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTING_MANAGE_PROFILE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('a5b485ac-8c7b-4a4f-a62d-6f839d77e91f', 'View Version History', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_VIEW_VERSION_HISTORY', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('a737284a-e43b-481d-9fdd-07e1680ffe11', 'Edit Document', 2, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_EDIT_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('a74e0f79-bc3c-4582-a2ea-008d568e6a8b', 'View Cron Job Logs', 2, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGS_VIEW_CRON_JOBS_LOGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a8dd972d-e758-4571-8d39-c6fec74b361b', 'Edit Document', 3, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_EDIT_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('aa712002-aa9a-4656-9835-34278487a848', 'Add Signature', 5, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGN_ADD_SIGNATURE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('ac6d6fbc-6348-4149-9c0c-154ab79d1166', 'Share Document', 3, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_SHARE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('b0f2a1c4-3d8e-4b5c-9f6d-7a0e5f3b8c1d', 'DELETE_AI_GENERATED_DOCUMENTS', 3, '637f010e-3397-41a9-903a-21d54db5e49a', 'DELETE_AI_GENERATED_DOCUMENTS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('b1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'VIEW_BOARDS', 1, 'b0a1d2e3-f4g5-h6i7-j8k9-l0m1n2o3p4q5', 'BOARDS_VIEW_BOARDS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 16:37:57', '2026-02-07 16:37:57', NULL),
('b1c5f8d2-3e4f-4b0a-9c6d-7e8f9a0b1c2d', 'UPDATE_WORKFLOW', 3, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_UPDATE_WORKFLOW', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('b2a3b4c5-d6e7-f8g9-h0i1-j2k3l4m5n6o7', 'CREATE_BOARD', 2, 'b0a1d2e3-f4g5-h6i7-j8k9-l0m1n2o3p4q5', 'BOARDS_CREATE_BOARD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 16:37:57', '2026-02-07 16:37:57', NULL),
('b36cf0a4-ad53-4938-aac5-fb7fbfc2cfcf', 'Restore Version', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_RESTORE_VERSION', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('b3a4b5c6-d7e8-f9g0-h1i2-j3k4l5m6n7o8', 'EDIT_BOARD', 3, 'b0a1d2e3-f4g5-h6i7-j8k9-l0m1n2o3p4q5', 'BOARDS_EDIT_BOARD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 16:37:57', '2026-02-07 16:37:57', NULL),
('b4a5b6c7-d8e9-f0g1-h2i3-j4k5l6m7n8o9', 'DELETE_BOARD', 4, 'b0a1d2e3-f4g5-h6i7-j8k9-l0m1n2o3p4q5', 'BOARDS_DELETE_BOARD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 16:37:57', '2026-02-07 16:37:57', NULL),
('b4d722d6-755c-4be4-8f0d-2283c9394e18', 'APPROVE_FILE_REQUEST', 5, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_APPROVE_FILE_REQUEST', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('b5a6b7c8-d9e0-f1g2-h3i4-j5k6l7m8n9o0', 'MANAGE_CARDS', 5, 'b0a1d2e3-f4g5-h6i7-j8k9-l0m1n2o3p4q5', 'BOARDS_MANAGE_CARDS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 16:37:57', '2026-02-07 16:37:57', NULL),
('bc515aea-ef66-4d8d-9cdb-47477cb74145', 'MANAGE_AI_PROMPT_TEMPLATES', 4, '637f010e-3397-41a9-903a-21d54db5e49a', 'MANAGE_AI_PROMPT_TEMPLATES', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('bf3ec13f-1e81-40f3-ad7a-05523608e85c', 'Manage Google Gemini API', 4, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_MANAGE_GEMINI_API_KEY', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('c04a1094-f289-4de7-b788-9f21ee3fe32a', 'Send Email', 5, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_SEND_EMAIL', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('c18e4105-e9d7-4c5d-b396-a2854bcb8e21', 'View Version History', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_VIEW_VERSION_HISTORY', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('c288b5d3-419d-4dc0-9e5a-083194016d2c', 'Edit Role', 3, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_EDIT_ROLE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('c2d3e4f5-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'DELETE_WORKFLOW', 4, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_DELETE_WORKFLOW', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('c6e2e9f8-1ee4-4c1d-abd1-721ff604c8b8', 'Add Reminder', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_ADD_REMINDER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('cb988c3a-7487-4366-9521-c0c5adf9b5a6', 'BULK_DOCUMENT_UPLOAD', 1, '8384e302-eaf1-4a0b-b293-a921b1e9e36a', 'BULK_DOCUMENT_UPLOAD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('cd46a3a4-ede5-4941-a49b-3df7eaa46428', 'Manage Document Category', 1, '5a5f7cf8-21a6-434a-9330-db91b17d867c', 'DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('d4d724fc-fd38-49c4-85bc-73937b219e20', 'Reset Password', 5, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_RESET_PASSWORD', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('d57ff519-1448-4336-8d76-98d43a9ada2c', 'CANCEL_WORKFLOW', 1, '5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'WORKFLOW_ALL_CANCEL_WORKFLOW', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d9067d75-e3b9-4d2d-8f82-567ad5f2b9ca', 'View Documents', 1, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_VIEW_DOCUMENTS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('db8825b1-ee4e-49f6-9a08-b0210ed53fd4', 'Create Role', 2, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_CREATE_ROLE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('dba2e7bf-6bac-4620-a9e6-d4eaa2c8480f', 'Manage Page Helper', 1, 'cfa38ae7-b5ba-4881-9199-d2914d7fd58e', 'PAGE_HELPER_MANAGE_PAGE_HELPER', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('e017d419-8080-4b2d-ac89-4e966182a12f', 'MANAGE_DOCUMENT_STATUS', 1, '8740dd7a-7bca-442f-b50f-6cdf0fcaf7bd', 'MANAGE_DOCUMENT_STATUS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e3fcd910-3f9b-4035-9bbb-312c5b599d52', 'GENERATE_AI_DOCUMENTS', 1, '637f010e-3397-41a9-903a-21d54db5e49a', 'GENERATE_AI_DOCUMENTS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e506ec48-b99a-45b4-9ec9-6451bc67477b', 'Assign Permission', 7, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_ASSIGN_PERMISSION', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('e9ff854b-23f7-46c2-9029-efba3d8587b5', 'Manage Sharable Link', 7, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_MANAGE_SHARABLE_LINK', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('ef979f76-027c-4b20-9330-5c81a3dc5869', 'Add Watermark', 15, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOC_WATERMARK', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', 'c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('f165f5a2-fe26-490a-91bc-08a736096fed', 'VIEW_ALL_WORKFLOW', 1, '5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'WORKFLOW_VIEW_ALL_WORKFLOWS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('f4d8a768-151d-4ec9-a8e3-41216afe0ec0', 'Delete Document', 4, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_DELETE_DOCUMENTS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('f508f793-5d4c-4e03-889c-2c62b6cf484f', 'VIEW_MY_WORKFLOW', 1, '655f0bcd-676d-49fc-ba30-24c39c853e16', 'WORKFLOW_VIEW_MY_WORKFLOWS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('f5829228-ea73-4389-8aee-e2dc8ef6934a', 'Add Signature', 5, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOC_ADD_SIGNATURE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('f9ec1096-b798-4623-bbf8-4f5d4fe775e9', 'Manage Sharable Link', 10, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_MANAGE_SHARABLE_LINK', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('fa5b07a4-e8c4-40e2-b5cf-f1a562087783', 'VIEW_AI_GENERATED_DOCUMENTS', 2, '637f010e-3397-41a9-903a-21d54db5e49a', 'VIEW_AI_GENERATED_DOCUMENTS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('fa91ffd9-61ee-4bb1-bf86-6a593cdc7be9', 'Create Document', 1, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_CREATE_DOCUMENT', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('fbe77c07-3058-4dbe-9d56-8c75dc879460', 'Assign User Role', 6, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_ASSIGN_USER_ROLE', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', 'View Login Audit Logs', 1, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGIN_AUDIT_VIEW_LOGIN_AUDIT_LOGS', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `aiPromptTemplates`
--

CREATE TABLE `aiPromptTemplates` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `promptInput` varchar(255) NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `aiPromptTemplates`
--

INSERT INTO `aiPromptTemplates` (`id`, `name`, `description`, `promptInput`, `modifiedDate`, `deleted_at`) VALUES
('0e832c07-8a82-4a5b-b415-cc4b466a9056', 'Generate tags and keywords for youtube video', 'Generate tags and keywords for youtube video', 'Generate tags and keywords about **title** for youtube video.', '2025-04-24 08:06:48', NULL),
('18849032-284e-4ea5-adaf-35ee52e4ddc4', 'Generate testimonial', 'Generate testimonial', 'Generate testimonial for **subject**. Include details about how it helped you and what you like best about it.', '2025-04-24 07:57:12', NULL),
('1a4e4a31-f197-4e6f-a58a-e599f216f6ce', 'Generate blog post conclusion', 'Generate blog post conclusion', 'Write blog post conclusion about title: **title**. And the description is **description**.', '2025-04-24 08:03:29', NULL),
('20804416-cb1b-4016-840d-6f6d625ac210', 'Write Problem Agitate Solution', 'Write Problem Agitate Solution', 'Write Problem-Agitate-Solution copy for the **description**.', '2025-04-24 07:57:56', NULL),
('30d72e36-1ef7-4ba9-8a8d-db119c013157', 'Generate Google ads headline for product.', 'Generate Google ads headline for product.', 'Write Google ads headline product name: **product name**. Description is **description**. Audience is **audience**.', '2025-04-24 08:47:44', NULL),
('3b28ed3a-88e3-4d04-8537-039202c28977', 'Write me blog section', 'Write me blog section', 'Write me blog section about **description**.', '2025-04-24 07:58:20', NULL),
('3bbe9346-2d34-4f43-8510-ab0f2b290459', 'Generate Instagram post caption', 'Generate Instagram post caption', 'Write Instagram post caption about **title**.', '2025-04-24 08:07:26', NULL),
('3bc3216e-f5c2-4e93-ae40-50100b166f65', 'Post Generator', 'Generator Post using Open AI.', 'Write a post about **description**.', '2025-04-23 13:51:27', NULL),
('6e80ce92-ebad-4fbe-a466-d26273695fc7', 'Article Generator', 'Instantly create unique articles on any topic. Boost engagement, improve SEO, and save time.', 'Generate article about **article title**', '2025-04-23 13:36:00', NULL),
('783724b2-f4ed-473b-af76-6952724aa880', 'Generate instagram hastags.', 'Generate instagram hastags.', 'Write instagram hastags for **keywords**.', '2025-04-24 08:07:57', NULL),
('8650d81b-2cf3-4fa3-9123-7426bbbd4d94', 'Write product description for Product name', 'Write product description for Product name', 'Write product description for **product name**.', '2025-04-24 07:55:55', NULL),
('8985b3bb-c69d-4d3b-a8bc-6baecef2c358', 'Generate google ads description for product.', 'Generate google ads description for product.', 'Write google ads description product name: **product name**. Description is **description**. Audience is **audience**.', '2025-04-24 08:49:24', NULL),
('8a361cde-138b-4fcd-950b-8e759983a3ac', 'Grammar Correction', 'Grammar Correction', 'Correct the grammar. Text is **description**.', '2025-04-24 08:55:42', NULL),
('8c288cf3-1ff0-4d40-a98c-2744b954e54f', 'Generate pros & cons', 'Generate pros & cons', 'Generate pros & cons about title:  **title**. Description is **description**.', '2025-04-24 08:50:36', NULL),
('8c94a143-a07e-4c9d-947c-6a1168c68647', 'Email Generator', 'Email Generator', 'Write email about title: **subject**, description: **description**.', '2025-04-24 08:51:56', NULL),
('913a8628-b4f2-41e2-a1aa-f44331afcf00', 'Newsletter Generator', 'Newsletter Generator', 'generate newsletter template about product title: **title**, reason: **subject** description: **description**.', '2025-04-24 08:53:00', NULL),
('98511559-7b1a-42f6-b924-2430a1bdfd5a', 'Generate Facebook ads title', 'Generate Facebook ads title', 'Write Facebook ads title about title: **title**. And description is **description**.', '2025-04-24 08:46:58', NULL),
('a72ce7d0-720f-48ac-b7f7-7ab25d73a72c', 'Summarize Text', 'Summarize Text', 'Summarize the following text: **text**.', '2025-04-23 13:57:10', NULL),
('b9e114c7-a2f1-4777-b43a-e36b1e146dbc', 'FAQ Generator', 'FAQ Generator', 'Answer like faq about subject: **title** Description is **description**.', '2025-04-24 08:51:34', NULL),
('c1804540-d86a-48c6-a321-05f13630f262', 'Generate website meta description', 'Generate website meta description', 'Generate website meta description site name: **title** Description is **description**.', '2025-04-24 08:51:04', NULL),
('ca26c30b-e537-4c9f-a4b9-ec4cc7b95a1b', 'Rewrite content', 'Rewrite content', 'Rewrite content:  **contents**.', '2025-04-24 08:49:45', NULL),
('d35d6c5d-9146-464e-bfa9-196f9db0b251', 'Generate one paragraph', 'Generate one paragraph', 'Generate one paragraph about:  **description**. Keywords are **keywords**.', '2025-04-24 08:50:11', NULL),
('d8d81df2-2859-4c6d-99aa-eb6dabb9cc01', 'Post Title Generator', 'Generator a Post Title from Post Description.', 'Generate Post title about **description**', '2025-04-23 13:55:24', NULL),
('ddf9b4d8-1ffc-4582-92f7-6e4adc667c95', 'Generate  company social media post', 'Generate  company social media post', 'Write in company social media post, company name: **company name**. About: **description**.', '2025-04-24 08:44:33', NULL),
('e884ec96-547c-4f81-99e9-40eed842f8b5', 'Generate youtube video description', 'Generate youtube video description', 'write youtube video description about **title**.', '2025-04-24 08:05:13', NULL),
('ea82c689-ad2a-4b54-b11b-4545af7a236d', 'Generate YouTube video titles', 'Generate YouTube video titles', 'Craft captivating, attention-grabbing video titles about **description** for YouTube rankings.', '2025-04-24 08:06:08', NULL),
('f3431223-1eba-4f47-b1f5-8a990a3022af', 'Email Answer Generator', 'Email Answer Generator', 'answer this email content: **description**.', '2025-04-24 08:52:18', NULL),
('f7057b73-0db5-4fe6-bc5e-44cb9e1b35e4', 'Generate blog post introduction', 'Generate blog post introduction', 'Write blog post intro about title: **title**. And the description is **description**.', '2025-04-24 08:02:27', NULL),
('fd71e2b4-427f-40d9-8ab3-b616fc0cf09b', 'Generate Facebook ads text', 'Generate Facebook ads text', 'Write facebook ads text about title: **title**. And the description is **description**.', '2025-04-24 08:04:16', NULL),
('fe9b5264-64a2-4772-a033-00088cf11d07', 'Generate blog post idea', 'Generate blog post idea', 'Write blog post article ideas about **description**.', '2025-04-24 08:01:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `allowFileExtensions`
--

CREATE TABLE `allowFileExtensions` (
  `id` char(36) NOT NULL,
  `fileType` tinyint(4) NOT NULL,
  `extensions` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `allowFileExtensions`
--

INSERT INTO `allowFileExtensions` (`id`, `fileType`, `extensions`) VALUES
('0c0be0a9-0a4e-4f05-8742-3a5d6d74acf0', 2, 'png,jpg,jpge,gif,bmp,tiff,tif,svg,webp,ico,heif,heic,avif,apng,jfif,pjpeg,pjp,svgz,wmf,emf,djv,djvu,eps,ps,ai,indd,idml,psd,tga,dds'),
('13a28d05-d6be-4e6b-87fe-b784642e2a95', 3, 'txt'),
('3257c50c-a128-4c98-8809-cc2564b7db2a', 1, 'pdf'),
('64dac07d-9072-4661-b537-053a09d42d6e', 0, 'doc,docx,ppt,pptx,xls,xlsx,csv'),
('9eaf6b33-0cef-45a4-bf92-7c525e2ed536', 4, '3gp,aa,aac,aax,act,aiff,alac,amr,ape,au,awb,dss,dvf,flac,gsm,iklx,ivs,m4a,m4b,m4p,mmf,mp3,mpc,msv,nmf,ogg,oga,mogg,opus,org,ra,rm,raw,rf64,sln,tta,voc,vox,wav,wma,wv'),
('ab5db62f-1fc7-49ed-895f-6ac4be6db33a', 6, 'zip'),
('cb1612ef-8e3c-4823-af2b-469f4b0010b8', 5, 'webm,flv,vob,ogv,ogg,drc,avi,mts,m2ts,wmv,yuv,viv,mp4,m4p,3pg,f4v,f4a');

-- --------------------------------------------------------

--
-- Table structure for table `boardCardActivities`
--

CREATE TABLE `boardCardActivities` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `type` enum('comment','note','attachment_link','system_log') DEFAULT 'comment',
  `content` longtext NOT NULL,
  `attachmentId` char(36) DEFAULT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardCardActivities`
--

INSERT INTO `boardCardActivities` (`id`, `cardId`, `userId`, `type`, `content`, `attachmentId`, `createdDate`) VALUES
('0d478ea2-af94-4bb9-9462-4c478bd7c73e', '28288849-880a-4ff5-a134-ea2660f6c6d1', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<p>,.</p>', NULL, '2026-02-08 15:51:54'),
('68cc8916-76f8-4c3a-8338-5a8baa3a75c8', '32fc9297-4af0-455f-942c-05dea988431e', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<p>hi</p>', NULL, '2026-02-08 00:31:57'),
('774c281d-0c26-4ba4-bb13-2b1ce15fa193', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<p>dqewwtwtwttw</p>', NULL, '2026-02-08 15:49:32'),
('c7bd1c50-e4d1-4541-b6d4-3467431b5420', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<figure class=\"media\"><oembed url=\"https://youtu.be/P9dX_ek_6yY?si=zvSKVVU0fL7F7XiB\"></oembed></figure>', NULL, '2026-02-08 01:31:31'),
('c7f0a212-e908-4f95-a55c-27c597513d98', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<p>jaöjfo</p>', NULL, '2026-02-08 01:31:40'),
('c883f730-d668-4eb3-8223-92023ab15da9', '32fc9297-4af0-455f-942c-05dea988431e', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<figure class=\"media\"><oembed url=\"https://youtu.be/P9dX_ek_6yY?si=DKF937yxfYehxSBv\"></oembed></figure>', NULL, '2026-02-08 00:36:04'),
('cd81d314-5619-43d4-8dc5-440ea5aead8c', '32fc9297-4af0-455f-942c-05dea988431e', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<p><a href=\"www.bixma.com\">test link</a></p>', NULL, '2026-02-08 00:36:55'),
('cdb0d0f3-432d-43be-a38b-efbedde85ebc', '32fc9297-4af0-455f-942c-05dea988431e', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<p>kbjlökn</p>', NULL, '2026-02-08 01:18:25'),
('f90e8c16-b383-428a-91f3-155b84a1ec3c', '32fc9297-4af0-455f-942c-05dea988431e', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'comment', '<figure class=\"table\"><table><tbody><tr><td>hjokäpkä</td><td>&nbsp;</td><td>äämä</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table></figure>', NULL, '2026-02-08 00:33:45');

-- --------------------------------------------------------

--
-- Table structure for table `boardCardAssignees`
--

CREATE TABLE `boardCardAssignees` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardAttachments`
--

CREATE TABLE `boardCardAttachments` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardCardAttachments`
--

INSERT INTO `boardCardAttachments` (`id`, `cardId`, `documentId`, `createdDate`) VALUES
('054ce4c9-46fa-471d-9932-ea40988bc36c', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '9a1a18f3-ee0b-4ab9-8a32-bf742a65664f', '2026-02-08 15:58:40'),
('6b86a604-28dc-48f3-9943-5369c661aad1', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '8f22164c-f9a7-4756-b623-5044643233c3', '2026-02-08 15:49:21'),
('c503b480-d0d5-4128-95cb-99c0e02108ba', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '4c6633d5-3680-43df-b5a8-b83274bb8382', '2026-02-08 15:56:33');

-- --------------------------------------------------------

--
-- Table structure for table `boardCardChecklistItems`
--

CREATE TABLE `boardCardChecklistItems` (
  `id` char(36) NOT NULL,
  `checklistId` char(36) NOT NULL,
  `name` text NOT NULL,
  `isCompleted` tinyint(1) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardCardChecklistItems`
--

INSERT INTO `boardCardChecklistItems` (`id`, `checklistId`, `name`, `isCompleted`, `position`, `createdDate`) VALUES
('34c50db1-06bf-4df7-8062-cdc3489b79b7', '0ca50e6d-4f90-4edb-beb9-7d0e10092477', 'it1', 0, 0, '2026-02-08 15:49:55'),
('9fe589a6-bcf9-4f1f-8bed-a504fd088370', '0ca50e6d-4f90-4edb-beb9-7d0e10092477', 'it3', 1, 2, '2026-02-08 15:50:05'),
('a867ac19-2255-4480-b882-433aac4b8113', '0ca50e6d-4f90-4edb-beb9-7d0e10092477', 'it2', 1, 1, '2026-02-08 15:50:00'),
('f90a484b-6cec-4355-9b84-a2abbddd7fd4', '0ca50e6d-4f90-4edb-beb9-7d0e10092477', '1t4', 0, 3, '2026-02-08 15:50:46');

-- --------------------------------------------------------

--
-- Table structure for table `boardCardChecklists`
--

CREATE TABLE `boardCardChecklists` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardCardChecklists`
--

INSERT INTO `boardCardChecklists` (`id`, `cardId`, `name`, `createdDate`) VALUES
('0ca50e6d-4f90-4edb-beb9-7d0e10092477', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', 'Checklist', '2026-02-08 15:49:46');

-- --------------------------------------------------------

--
-- Table structure for table `boardCardFollowers`
--

CREATE TABLE `boardCardFollowers` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardLabels`
--

CREATE TABLE `boardCardLabels` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `labelId` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardCardLabels`
--

INSERT INTO `boardCardLabels` (`id`, `cardId`, `labelId`) VALUES
('0068d633-71f6-4350-a657-87d700033613', '28288849-880a-4ff5-a134-ea2660f6c6d1', '4f2541d9-dc2e-497c-a573-aed14d4a0298'),
('85c10757-1a84-4894-810c-1f11b2825ff4', '610289c9-27a8-4271-8503-32b7f36dc8c5', '571a09a9-dbc8-4c73-bcb0-08eb749766a7'),
('4c02e150-7710-44a6-8637-fa059949af67', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '44c2a1a5-06cd-4516-9a15-beea1bc69942'),
('d25f1a11-d655-4168-b76e-39339ab6bff0', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', 'dedd928f-7b9b-441a-ad58-937683dbf766');

-- --------------------------------------------------------

--
-- Table structure for table `boardCardMilestones`
--

CREATE TABLE `boardCardMilestones` (
  `cardId` char(36) NOT NULL,
  `milestoneId` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `boardCardMilestones`
--

INSERT INTO `boardCardMilestones` (`cardId`, `milestoneId`) VALUES
('4093aa71-fba5-4d3c-82a0-9777280e13bf', 'e5f5bc46-d22f-4525-852d-a0f516035e19');

-- --------------------------------------------------------

--
-- Table structure for table `boardCards`
--

CREATE TABLE `boardCards` (
  `id` char(36) NOT NULL,
  `columnId` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `htmlDescription` longtext DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `dueDate` datetime DEFAULT NULL,
  `documentId` char(36) DEFAULT NULL,
  `coverColor` varchar(50) DEFAULT NULL,
  `isArchived` tinyint(1) NOT NULL DEFAULT 0,
  `executorId` char(36) DEFAULT NULL,
  `approverId` char(36) DEFAULT NULL,
  `supervisorId` char(36) DEFAULT NULL,
  `parentCardId` char(36) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isCompleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardCards`
--

INSERT INTO `boardCards` (`id`, `columnId`, `boardId`, `title`, `description`, `htmlDescription`, `position`, `priority`, `dueDate`, `documentId`, `coverColor`, `isArchived`, `executorId`, `approverId`, `supervisorId`, `parentCardId`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`, `isCompleted`) VALUES
('0c87357a-a1ae-427d-a9af-abdeb7bc2ba9', '8ef6926a-aa85-4458-80ef-a5ab5d11c6e2', '62433794-90d5-4019-8322-4e990f41f3f9', 'test-card', NULL, NULL, 0, 'medium', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 1, '2026-02-07 19:24:08', '2026-02-07 19:50:34', '2026-02-07 18:50:34', 0),
('28288849-880a-4ff5-a134-ea2660f6c6d1', 'a37628e2-c8b2-4289-895c-0e6ffcfc1c12', 'd333a928-a6f1-445f-9435-759979a00466', 'cft', '<p>bhgyb</p>', NULL, 1, 'medium', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 1, '2026-02-08 15:50:58', '2026-02-08 15:52:24', '2026-02-08 15:52:24', 0),
('32fc9297-4af0-455f-942c-05dea988431e', '8ef6926a-aa85-4458-80ef-a5ab5d11c6e2', '62433794-90d5-4019-8322-4e990f41f3f9', 'testato', '<p>hipfqjåfqfåqk</p>', NULL, 0, 'low', NULL, '8f22164c-f9a7-4756-b623-5044643233c3', NULL, 0, NULL, NULL, NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 00:31:48', '2026-02-08 01:19:21', NULL, 0),
('4093aa71-fba5-4d3c-82a0-9777280e13bf', '48aca11b-8a60-4804-94ca-5121e584ee37', '5468bec6-10a7-4688-a220-3d81a6b83141', 'rywe', NULL, NULL, 0, 'medium', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 11:40:21', '2026-02-10 11:57:53', NULL, 1),
('610289c9-27a8-4271-8503-32b7f36dc8c5', 'bab81ed0-4594-49f4-a2c2-a5c2feab8141', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'card1', NULL, NULL, 0, 'medium', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 10:57:03', '2026-02-10 10:57:03', NULL, 0),
('db9fc161-a2d5-4fb6-98f2-173157b24b83', 'a37628e2-c8b2-4289-895c-0e6ffcfc1c12', 'd333a928-a6f1-445f-9435-759979a00466', 'testology', '<p>hehehehehehe</p>', NULL, 0, 'low', NULL, '8f22164c-f9a7-4756-b623-5044643233c3', NULL, 0, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 01:23:41', '2026-02-08 15:52:36', NULL, 0),
('df3424a5-e44c-4647-b4a1-4fa21ff9d15b', '8ef6926a-aa85-4458-80ef-a5ab5d11c6e2', '62433794-90d5-4019-8322-4e990f41f3f9', 'testico', NULL, NULL, 0, 'medium', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 1, '2026-02-07 19:50:43', '2026-02-07 19:51:04', '2026-02-07 18:51:04', 0);

-- --------------------------------------------------------

--
-- Table structure for table `boardCardTags`
--

CREATE TABLE `boardCardTags` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `tagId` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardCardTags`
--

INSERT INTO `boardCardTags` (`id`, `cardId`, `tagId`) VALUES
('dbfc4d22-9ba0-41e6-9bef-ceb3beeb5eb9', '28288849-880a-4ff5-a134-ea2660f6c6d1', '70e79d6e-0241-4464-82a9-71cd93eee0bf'),
('a1eb25f7-eba9-4d4c-82b6-61b5f3ce1f95', '610289c9-27a8-4271-8503-32b7f36dc8c5', 'bfd38659-8dee-4945-a355-48576a9edfdd'),
('40264b14-ef36-476d-87d2-72e0963f4709', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '4566ac2e-4a61-446e-a595-674a712d2635'),
('7d18fd7d-18f4-413e-b186-6cc78fc2f234', 'db9fc161-a2d5-4fb6-98f2-173157b24b83', '70e79d6e-0241-4464-82a9-71cd93eee0bf');

-- --------------------------------------------------------

--
-- Table structure for table `boardColumns`
--

CREATE TABLE `boardColumns` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `color` varchar(50) DEFAULT '#e2e4e6',
  `wipLimit` int(11) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardColumns`
--

INSERT INTO `boardColumns` (`id`, `boardId`, `name`, `position`, `color`, `wipLimit`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('15ffe26b-a846-41e2-9e01-88c88f4aad7c', '2c902fac-93a2-4012-a627-00276b06c326', 'testo', 3, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:47:20', '2026-02-07 18:47:20', NULL),
('17403251-c112-4e75-a396-1cf08abb30e5', '62433794-90d5-4019-8322-4e990f41f3f9', 'In Progress', 1, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:48:04', '2026-02-07 18:48:04', NULL),
('1dae6894-6210-4f2b-94bb-a8f55449d43a', '5468bec6-10a7-4688-a220-3d81a6b83141', 'In Progress', 1, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 11:39:12', '2026-02-10 11:39:12', NULL),
('1f82d390-0b5f-45ca-9a39-5dae4baeb29e', 'd333a928-a6f1-445f-9435-759979a00466', 'testu', 4, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 14:43:09', '2026-02-08 14:43:09', NULL),
('3e302811-2f2d-4bff-b6a9-328360e549fb', 'd333a928-a6f1-445f-9435-759979a00466', 'To Do', 0, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 01:23:25', '2026-02-08 01:23:25', NULL),
('48aca11b-8a60-4804-94ca-5121e584ee37', '5468bec6-10a7-4688-a220-3d81a6b83141', 'To Do', 0, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 11:39:12', '2026-02-10 11:39:12', NULL),
('69e921f0-5e02-42f9-9206-0f58e93c3540', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Done', 2, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 11:39:12', '2026-02-10 11:39:12', NULL),
('706cdfb1-cc66-4f54-a37b-1efd065845c4', '2c902fac-93a2-4012-a627-00276b06c326', 'In Progress', 1, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:22:12', '2026-02-07 18:22:12', NULL),
('718101bc-8272-4358-bedc-4ada6b998c72', 'd333a928-a6f1-445f-9435-759979a00466', 'In Progress', 1, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 01:23:25', '2026-02-08 01:23:25', NULL),
('7546f953-b1d9-4bf9-8e9a-804f2ab126df', 'd333a928-a6f1-445f-9435-759979a00466', 'Done', 2, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 01:23:25', '2026-02-08 01:23:25', NULL),
('80b101de-ba72-4219-b274-30b348bc8de1', '2c902fac-93a2-4012-a627-00276b06c326', 'Done', 2, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:22:12', '2026-02-07 18:22:12', NULL),
('8ef6926a-aa85-4458-80ef-a5ab5d11c6e2', '62433794-90d5-4019-8322-4e990f41f3f9', 'To Do', 0, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:48:04', '2026-02-07 18:48:04', NULL),
('95ff51c5-c4f7-4914-b80e-73871c7a6776', '2c902fac-93a2-4012-a627-00276b06c326', 'To Do', 0, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:22:12', '2026-02-07 18:22:12', NULL),
('a37628e2-c8b2-4289-895c-0e6ffcfc1c12', 'd333a928-a6f1-445f-9435-759979a00466', 'test', 3, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 01:23:33', '2026-02-08 01:23:33', NULL),
('bab81ed0-4594-49f4-a2c2-a5c2feab8141', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'To Do', 0, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 10:56:46', '2026-02-10 10:56:46', NULL),
('de41844f-590c-493f-ada1-75ec9db90507', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Done', 2, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 10:56:46', '2026-02-10 10:56:46', NULL),
('e23bc643-eb82-4588-8e94-22b33bdf2dc6', '62433794-90d5-4019-8322-4e990f41f3f9', 'Done', 2, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:48:04', '2026-02-07 18:48:04', NULL),
('f4632ee2-4bf6-4628-a6c0-c182696ee6eb', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'In Progress', 1, '#e2e4e6', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 10:56:46', '2026-02-10 10:56:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `boardLabels`
--

CREATE TABLE `boardLabels` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL DEFAULT '#61bd4f',
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardLabels`
--

INSERT INTO `boardLabels` (`id`, `boardId`, `name`, `color`, `createdDate`) VALUES
('0ec46558-8772-43c8-8a8a-06352d324e90', '2c902fac-93a2-4012-a627-00276b06c326', 'Review', '#f2d600', '2026-02-07 18:22:12'),
('13214d4e-55fd-45c7-b07a-4b72f88fa966', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Priority', '#eb5a46', '2026-02-10 10:56:46'),
('1445f115-eab3-48ec-95bf-98dcb7c11e2e', '62433794-90d5-4019-8322-4e990f41f3f9', 'Bug', '#c377e0', '2026-02-07 18:48:04'),
('15e2d04f-fe4f-4c37-8da7-f3d2fbb9d5db', '2c902fac-93a2-4012-a627-00276b06c326', 'Feature', '#61bd4f', '2026-02-07 18:22:12'),
('1ba76b77-bb9a-4f6d-bfb0-7c02e483d37f', '2c902fac-93a2-4012-a627-00276b06c326', 'Priority', '#eb5a46', '2026-02-07 18:22:12'),
('33de3073-f4f1-44da-8c82-0263f88ffe78', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Bug', '#c377e0', '2026-02-10 11:39:12'),
('44c2a1a5-06cd-4516-9a15-beea1bc69942', 'd333a928-a6f1-445f-9435-759979a00466', 'Review', '#f2d600', '2026-02-08 01:23:25'),
('48529b1f-f7fe-4c03-9fe8-45fb0275f99c', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Feature', '#61bd4f', '2026-02-10 11:39:12'),
('4f2541d9-dc2e-497c-a573-aed14d4a0298', 'd333a928-a6f1-445f-9435-759979a00466', 'Bug', '#c377e0', '2026-02-08 01:23:25'),
('571a09a9-dbc8-4c73-bcb0-08eb749766a7', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Bug', '#c377e0', '2026-02-10 10:56:46'),
('592c0fd4-9c57-4794-a97c-4abda5a9c741', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Review', '#f2d600', '2026-02-10 11:39:12'),
('8514b0dd-8430-4919-b243-9a22cc798c4b', '62433794-90d5-4019-8322-4e990f41f3f9', 'Priority', '#eb5a46', '2026-02-07 18:48:04'),
('855880d2-9ebc-49cd-b0bf-b038f9eb8cb5', 'd333a928-a6f1-445f-9435-759979a00466', 'Priority', '#eb5a46', '2026-02-08 01:23:25'),
('87c113dc-78db-440f-a2ca-c605f55b61d1', '2c902fac-93a2-4012-a627-00276b06c326', 'Bug', '#c377e0', '2026-02-07 18:22:12'),
('a57e93ed-3432-4619-bd8c-5da499792857', '62433794-90d5-4019-8322-4e990f41f3f9', 'Feature', '#61bd4f', '2026-02-07 18:48:04'),
('cbb9b1f3-6f4b-46c0-a969-2ebbc14b8a9d', '62433794-90d5-4019-8322-4e990f41f3f9', 'Review', '#f2d600', '2026-02-07 18:48:04'),
('cdc8ee8a-711d-4ed2-b7ce-fd186da19284', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Priority', '#eb5a46', '2026-02-10 11:39:12'),
('d5858d3d-9dd7-4ea9-ac9c-af492a637933', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Review', '#f2d600', '2026-02-10 10:56:46'),
('dedd928f-7b9b-441a-ad58-937683dbf766', 'd333a928-a6f1-445f-9435-759979a00466', 'testo', '#230ae6', '2026-02-08 14:40:58'),
('f324bfa3-2691-4ffb-9bab-76ba154c1654', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Feature', '#61bd4f', '2026-02-10 10:56:46'),
('f640f01f-ab2d-4e72-b940-71b14357dffc', 'd333a928-a6f1-445f-9435-759979a00466', 'Feature', '#61bd4f', '2026-02-08 01:23:25');

-- --------------------------------------------------------

--
-- Table structure for table `boardMilestones`
--

CREATE TABLE `boardMilestones` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(50) DEFAULT '#0079bf',
  `createdBy` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedBy` char(36) DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `boardMilestones`
--

INSERT INTO `boardMilestones` (`id`, `boardId`, `name`, `color`, `createdBy`, `createdDate`, `modifiedBy`, `modifiedDate`, `isDeleted`) VALUES
('15818752-c4ae-47be-abe3-e4e1ed6bde50', '5468bec6-10a7-4688-a220-3d81a6b83141', 'mile2', '#bd0094', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-10 11:40:57', NULL, '2026-02-10 11:40:57', 0),
('e5f5bc46-d22f-4525-852d-a0f516035e19', '5468bec6-10a7-4688-a220-3d81a6b83141', 'mile1', '#0079bf', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-10 11:40:43', NULL, '2026-02-10 11:40:43', 0);

-- --------------------------------------------------------

--
-- Table structure for table `boards`
--

CREATE TABLE `boards` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  `backgroundColor` varchar(50) DEFAULT '#f4f5f7',
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boards`
--

INSERT INTO `boards` (`id`, `name`, `description`, `isPublic`, `backgroundColor`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'mile', NULL, 0, '#f4f5f7', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 10:56:46', '2026-02-10 10:56:46', NULL),
('2c902fac-93a2-4012-a627-00276b06c326', 'testico', 'huhpi', 0, '#f4f5f7', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:22:12', '2026-02-07 18:22:12', NULL),
('5468bec6-10a7-4688-a220-3d81a6b83141', 'df', NULL, 0, '#cd5a91', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-10 11:39:12', '2026-02-10 11:39:12', NULL),
('62433794-90d5-4019-8322-4e990f41f3f9', 'second', 'blue', 0, '#0079bf', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 18:48:04', '2026-02-07 18:48:04', NULL),
('d333a928-a6f1-445f-9435-759979a00466', 'news', 'oiu', 0, '#d29034', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-08 01:23:25', '2026-02-08 01:23:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `boardTags`
--

CREATE TABLE `boardTags` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL DEFAULT '#61bd4f',
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `boardTags`
--

INSERT INTO `boardTags` (`id`, `boardId`, `name`, `color`, `createdDate`) VALUES
('0810690f-5581-47b0-a248-1b0bc74c3957', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Frontend', '#61bd4f', '2026-02-10 10:56:46'),
('08c772b1-f06f-44a6-be99-a4eefdb23064', '5468bec6-10a7-4688-a220-3d81a6b83141', 'High Priority', '#eb5a46', '2026-02-10 11:39:12'),
('1045c448-fd7c-47b0-910e-1ff8b502847b', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Design', '#0079bf', '2026-02-10 10:56:46'),
('4566ac2e-4a61-446e-a595-674a712d2635', 'd333a928-a6f1-445f-9435-759979a00466', 'tag1', '#0079bf', '2026-02-08 14:42:02'),
('48e72c15-2534-4f0b-b526-f28deb474d1c', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Frontend', '#61bd4f', '2026-02-10 11:39:12'),
('559be7d9-902c-4074-8e5c-c640f23b0249', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Backend', '#ff9f1a', '2026-02-10 11:39:12'),
('70e79d6e-0241-4464-82a9-71cd93eee0bf', 'd333a928-a6f1-445f-9435-759979a00466', 'tag2', '#0079bf', '2026-02-08 14:42:17'),
('a76085ec-7c8f-4d18-bea9-7e0638e8e1e1', '5468bec6-10a7-4688-a220-3d81a6b83141', 'Design', '#0079bf', '2026-02-10 11:39:12'),
('bfd38659-8dee-4945-a355-48576a9edfdd', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'Backend', '#ff9f1a', '2026-02-10 10:56:46'),
('f9aeb5ca-7d60-411d-9768-ea0bb5aa0db8', '27470ff6-aa6b-42c7-b7c3-eeaf71280737', 'High Priority', '#eb5a46', '2026-02-10 10:56:46');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `parentId` char(36) DEFAULT NULL,
  `hierarchyPath` varchar(1000) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `parentId`, `hierarchyPath`, `isDeleted`, `createdBy`, `modifiedBy`, `deletedBy`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('72e64f97-b33b-4c53-9c60-ddd10502271c', 'sub1', NULL, '75a49477-2035-407f-a9f0-997bb4e6bed5', NULL, 0, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, '2026-02-09 14:12:29', '2026-02-09 14:12:29', NULL),
('75a49477-2035-407f-a9f0-997bb4e6bed5', 'test', NULL, NULL, NULL, 0, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, '2026-02-08 00:41:16', '2026-02-08 00:41:16', NULL),
('8fdc512a-32fe-45d0-830c-3536ce54c4fd', 'hgi', NULL, '75a49477-2035-407f-a9f0-997bb4e6bed5', '/8fdc512a-32fe-45d0-830c-3536ce54c4fd', 0, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, '2026-02-11 10:31:22', '2026-02-11 10:31:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` char(36) NOT NULL,
  `companyName` varchar(255) NOT NULL,
  `contactPerson` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companyProfile`
--

CREATE TABLE `companyProfile` (
  `id` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `logoUrl` varchar(255) DEFAULT NULL,
  `bannerUrl` varchar(255) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `location` varchar(255) DEFAULT 'local',
  `smallLogoUrl` varchar(255) DEFAULT NULL,
  `licenseKey` varchar(255) DEFAULT NULL,
  `purchaseCode` varchar(255) DEFAULT NULL,
  `archiveDocumentRetensionPeriod` int(11) DEFAULT NULL,
  `allowPdfSignature` tinyint(1) NOT NULL DEFAULT 1,
  `emailLogRetentionPeriod` int(11) DEFAULT 30,
  `cronJobLogRetentionPeriod` int(11) DEFAULT 30,
  `loginAuditRetentionPeriod` int(11) DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companyProfile`
--

INSERT INTO `companyProfile` (`id`, `title`, `logoUrl`, `bannerUrl`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`, `location`, `smallLogoUrl`, `licenseKey`, `purchaseCode`, `archiveDocumentRetensionPeriod`, `allowPdfSignature`, `emailLogRetentionPeriod`, `cronJobLogRetentionPeriod`, `loginAuditRetentionPeriod`) VALUES
('688040f2-21de-4f9f-9ca4-5601cc147121', 'Document Management System', '', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', '', 0, '2026-02-07 13:04:23', '2026-02-07 13:04:59', NULL, 'local', NULL, 'ZGF0YWkuY29ycHJvcmF0ZS5jb218N0pab1dnM3hGajQ2WTFTdTdnSTlRakVrcEJ3UkdJcGZWanJyQ1FTTiUyYkxnJTNk', '4f9bdf40-ea22-489f-9677-db51784d33fc', NULL, 1, 30, 30, 30);

-- --------------------------------------------------------

--
-- Table structure for table `cronJobLogs`
--

CREATE TABLE `cronJobLogs` (
  `id` char(36) NOT NULL,
  `jobName` varchar(255) NOT NULL,
  `status` enum('success','failed') NOT NULL DEFAULT 'success',
  `output` text DEFAULT NULL,
  `executionTime` int(11) DEFAULT NULL,
  `startedAt` timestamp NULL DEFAULT NULL,
  `endedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dailyReminders`
--

CREATE TABLE `dailyReminders` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `dayOfWeek` int(11) NOT NULL,
  `isActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentAuditTrails`
--

CREATE TABLE `documentAuditTrails` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `operationName` varchar(255) NOT NULL,
  `assignToUserId` char(36) DEFAULT NULL,
  `assignToRoleId` char(36) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documentAuditTrails`
--

INSERT INTO `documentAuditTrails` (`id`, `documentId`, `operationName`, `assignToUserId`, `assignToRoleId`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('0565c9d2-9131-4637-99fb-4d729cf1eb5c', '9a1a18f3-ee0b-4ab9-8a32-bf742a65664f', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:18:02', '2026-02-09 12:18:02', NULL),
('1d8b4fcf-031e-4884-8051-8deeb4dc18cb', '1ff5dcca-3a8b-4d8a-a708-52837955de29', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 16:01:48', '2026-02-08 16:01:48', NULL),
('22abc40d-617a-4234-9388-e50c3aabc31e', '4e92daa0-56b0-47ce-a1c6-f4420267ba26', 'Deleted', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-11 13:06:56', '2026-02-11 13:06:56', NULL),
('22e989ac-af53-47b0-b4d1-bf446ffce8cf', '1ff5dcca-3a8b-4d8a-a708-52837955de29', 'Deleted', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:18:22', '2026-02-09 12:18:22', NULL),
('279cf105-163b-40c4-87db-c62d0e666e78', '1bc7c768-0d4a-46a7-9a72-111087c84f92', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-11 13:07:37', '2026-02-11 13:07:37', NULL),
('2a183fba-00c2-4398-a11d-fbdd8f1efa0e', '1ff5dcca-3a8b-4d8a-a708-52837955de29', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:17:03', '2026-02-09 12:17:03', NULL),
('303ccd80-ce0b-4ce1-9d97-b23eb296d0ab', '1adddab4-1360-4441-a315-c4a6a893cefb', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:17:13', '2026-02-09 12:17:13', NULL),
('31bd17c5-9f7f-4f2c-8087-834f001937ca', '9a1a18f3-ee0b-4ab9-8a32-bf742a65664f', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:58:24', '2026-02-08 15:58:24', NULL),
('38f73bf1-c526-43cc-8453-aa72b2d059bb', '4e92daa0-56b0-47ce-a1c6-f4420267ba26', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:20:04', '2026-02-09 12:20:04', NULL),
('3b2cedd5-b243-4295-bda7-b95bcd8734d7', '4e92daa0-56b0-47ce-a1c6-f4420267ba26', 'Modified', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 14:13:03', '2026-02-09 14:13:03', NULL),
('3bc68baa-d193-48c8-a455-04a329981c11', '9ff8daf5-c567-4540-a0ac-50f58f1bee33', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:55:36', '2026-02-08 15:55:36', NULL),
('3d8645ad-735c-40f7-9520-0126ea942b6b', '8f22164c-f9a7-4756-b623-5044643233c3', 'Add_Permission', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 00:41:20', '2026-02-08 00:41:20', NULL),
('41552ac3-6084-4351-9ecd-11668e8740e4', '8f22164c-f9a7-4756-b623-5044643233c3', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 00:41:23', '2026-02-08 00:41:23', NULL),
('55fc929d-f34a-42a4-a3f6-ecdeb953cd7e', '4c6633d5-3680-43df-b5a8-b83274bb8382', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:56:40', '2026-02-08 15:56:40', NULL),
('57793762-88a3-4944-8612-145b39fa63c6', '4e92daa0-56b0-47ce-a1c6-f4420267ba26', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 14:13:16', '2026-02-09 14:13:16', NULL),
('6362fbfa-549d-4a10-a628-28482b68b30b', '1adddab4-1360-4441-a315-c4a6a893cefb', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:59:21', '2026-02-08 15:59:21', NULL),
('65580ac8-43ac-4f50-afec-0549f52c5d69', '4e92daa0-56b0-47ce-a1c6-f4420267ba26', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:19:31', '2026-02-09 12:19:31', NULL),
('67a5f5d3-8851-4fad-bbd4-910a753bc616', '4c6633d5-3680-43df-b5a8-b83274bb8382', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:17:22', '2026-02-09 12:17:22', NULL),
('6c05b2fb-572d-4a40-957f-94ad767dbc12', '9ff8daf5-c567-4540-a0ac-50f58f1bee33', 'Deleted', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:55:52', '2026-02-08 15:55:52', NULL),
('76ca66bc-34fe-4153-8321-e94011334ed1', '1adddab4-1360-4441-a315-c4a6a893cefb', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:59:19', '2026-02-08 15:59:19', NULL),
('82e6ee80-9849-40b9-93a1-2f7c4f48980a', '8f22164c-f9a7-4756-b623-5044643233c3', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:53:54', '2026-02-08 15:53:54', NULL),
('8beaa2e3-8d73-4c55-93eb-582f0cb87c00', '9ff8daf5-c567-4540-a0ac-50f58f1bee33', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:55:32', '2026-02-08 15:55:32', NULL),
('9603bc4e-d0ac-40d7-ad5b-c2ea8f94893d', '4c6633d5-3680-43df-b5a8-b83274bb8382', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:56:19', '2026-02-08 15:56:19', NULL),
('9fc57207-8e16-4eeb-973b-f0843a6757c5', '4c6633d5-3680-43df-b5a8-b83274bb8382', 'Deleted', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:18:33', '2026-02-09 12:18:33', NULL),
('af056f5d-a20b-4905-9ce5-9f401b59f89d', '9a1a18f3-ee0b-4ab9-8a32-bf742a65664f', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:58:45', '2026-02-08 15:58:45', NULL),
('b799908e-c09e-4c2c-8bb5-e96ee102167c', '1ff5dcca-3a8b-4d8a-a708-52837955de29', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 16:01:50', '2026-02-08 16:01:50', NULL),
('bdd458ec-d094-4eea-942a-67ff51a0ceb9', '1adddab4-1360-4441-a315-c4a6a893cefb', 'Deleted', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:18:25', '2026-02-09 12:18:25', NULL),
('c40a7b16-6e3f-423f-91a7-a8623e9a84ba', '8f22164c-f9a7-4756-b623-5044643233c3', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:53:44', '2026-02-08 15:53:44', NULL),
('c8d8b88f-1c28-437d-a852-8b09eb33dad3', '8f22164c-f9a7-4756-b623-5044643233c3', 'Deleted', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:56:00', '2026-02-08 15:56:00', NULL),
('c9161d5f-044a-4100-970c-2be4c19e4651', '9a1a18f3-ee0b-4ab9-8a32-bf742a65664f', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 15:58:22', '2026-02-08 15:58:22', NULL),
('d08e18a3-f6e5-43eb-8995-f50bbe209779', '8f22164c-f9a7-4756-b623-5044643233c3', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 00:41:20', '2026-02-08 00:41:20', NULL),
('d7451f19-6eba-45f1-8f19-75fa1d654ad5', '4e92daa0-56b0-47ce-a1c6-f4420267ba26', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-11 13:06:29', '2026-02-11 13:06:29', NULL),
('dade7669-de8c-436f-8855-1edeed3201ef', '8f22164c-f9a7-4756-b623-5044643233c3', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-08 00:41:20', '2026-02-08 00:41:20', NULL),
('eb49a77f-40f8-4e4f-b9c5-e867e75b17a1', '9a1a18f3-ee0b-4ab9-8a32-bf742a65664f', 'Deleted', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:18:29', '2026-02-09 12:18:29', NULL),
('ecad45c3-f612-417e-831a-b6614e6bf8b2', '1bc7c768-0d4a-46a7-9a72-111087c84f92', 'Read', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-11 13:19:16', '2026-02-11 13:19:16', NULL),
('f48e8158-b2fe-448a-a784-55aa3515fe75', '4e92daa0-56b0-47ce-a1c6-f4420267ba26', 'Created', NULL, NULL, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-09 12:19:27', '2026-02-09 12:19:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `documentComments`
--

CREATE TABLE `documentComments` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentMetaDatas`
--

CREATE TABLE `documentMetaDatas` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `metatag` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentRolePermissions`
--

CREATE TABLE `documentRolePermissions` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `roleId` char(36) NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `isTimeBound` tinyint(1) NOT NULL,
  `isAllowDownload` tinyint(1) NOT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` char(36) NOT NULL,
  `categoryId` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `location` varchar(255) DEFAULT 'local',
  `isPermanentDelete` tinyint(1) DEFAULT 0,
  `isIndexed` tinyint(1) DEFAULT 0,
  `clientId` char(36) DEFAULT NULL,
  `statusId` char(36) DEFAULT NULL,
  `documentWorkflowId` char(36) DEFAULT NULL,
  `retentionPeriod` int(11) DEFAULT NULL,
  `retentionAction` int(11) DEFAULT NULL,
  `signById` char(36) DEFAULT NULL,
  `signDate` datetime DEFAULT NULL,
  `isExpired` tinyint(1) NOT NULL DEFAULT 0,
  `expiredDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `categoryId`, `name`, `description`, `url`, `createdDate`, `createdBy`, `modifiedDate`, `modifiedBy`, `isDeleted`, `deletedBy`, `deleted_at`, `location`, `isPermanentDelete`, `isIndexed`, `clientId`, `statusId`, `documentWorkflowId`, `retentionPeriod`, `retentionAction`, `signById`, `signDate`, `isExpired`, `expiredDate`) VALUES
('1adddab4-1360-4441-a315-c4a6a893cefb', '75a49477-2035-407f-a9f0-997bb4e6bed5', 'sample_import_filled_corrected.csv', NULL, 'documents/3c9af473-5637-4447-bbbf-f79f74122957.csv', '2026-02-08 15:59:19', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:25', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:25', 'local', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
('1bc7c768-0d4a-46a7-9a72-111087c84f92', '8fdc512a-32fe-45d0-830c-3536ce54c4fd', 'template.PNG', NULL, 'documents/46bd916b-4949-46e7-b114-b08ffa763e83.PNG', '2026-02-11 13:07:37', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-11 13:07:37', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
('1ff5dcca-3a8b-4d8a-a708-52837955de29', '75a49477-2035-407f-a9f0-997bb4e6bed5', 'Planning - Beleid.xlsx', NULL, 'documents/c81e80f5-e6bf-4eb7-8360-1f94f004c11f.xlsx', '2026-02-08 16:01:45', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:21', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:21', 'local', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
('4c6633d5-3680-43df-b5a8-b83274bb8382', '75a49477-2035-407f-a9f0-997bb4e6bed5', 'Invoice_WE4185014.pdf', NULL, 'documents/0eaa6bc3-d867-41ba-b6f7-a7739f0c2d4a.pdf', '2026-02-08 15:56:18', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:33', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:33', 'local', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
('4e92daa0-56b0-47ce-a1c6-f4420267ba26', '72e64f97-b33b-4c53-9c60-ddd10502271c', 'boardsample.PNG', NULL, 'documents/8f5a06c9-e6b4-43b9-80c3-244114a48a17.PNG', '2026-02-09 12:19:27', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-11 13:06:55', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-11 13:06:55', 'local', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
('8f22164c-f9a7-4756-b623-5044643233c3', '75a49477-2035-407f-a9f0-997bb4e6bed5', 'test.txt', NULL, 'documents/a16fca3e-9fc0-4a35-9165-c58e2b9e6231.txt', '2026-02-08 00:41:20', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-08 15:56:00', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-08 15:56:00', 'local', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
('9a1a18f3-ee0b-4ab9-8a32-bf742a65664f', '75a49477-2035-407f-a9f0-997bb4e6bed5', 'ransome.PNG', NULL, 'documents/9a7cfd4a-8262-4d97-bae3-b95f3b2d308f.PNG', '2026-02-08 15:58:21', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:29', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-09 12:18:29', 'local', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
('9ff8daf5-c567-4540-a0ac-50f58f1bee33', '75a49477-2035-407f-a9f0-997bb4e6bed5', 'Invoice_WE4185014.pdf', NULL, 'documents/26ab8ee0-e66e-4c85-9679-fdf96769feab.pdf', '2026-02-08 15:55:32', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-08 15:55:51', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '2026-02-08 15:55:51', 'local', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `documentShareableLink`
--

CREATE TABLE `documentShareableLink` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `linkExpiryTime` datetime DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `linkCode` varchar(255) DEFAULT NULL,
  `isAllowDownload` tinyint(1) NOT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentSignatures`
--

CREATE TABLE `documentSignatures` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `createdBy` char(36) NOT NULL,
  `signatureUrl` varchar(255) NOT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentStatus`
--

CREATE TABLE `documentStatus` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `colorCode` varchar(255) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentTokens`
--

CREATE TABLE `documentTokens` (
  `id` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `documentId` char(36) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentUserPermissions`
--

CREATE TABLE `documentUserPermissions` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `isTimeBound` tinyint(1) NOT NULL,
  `isAllowDownload` tinyint(1) NOT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documentUserPermissions`
--

INSERT INTO `documentUserPermissions` (`id`, `documentId`, `userId`, `startDate`, `endDate`, `isTimeBound`, `isAllowDownload`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('52714640-7c57-4cc5-96af-06486937fd09', '1bc7c768-0d4a-46a7-9a72-111087c84f92', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 0, '2026-02-11 13:07:37', '2026-02-11 13:07:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `documentVersions`
--

CREATE TABLE `documentVersions` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `location` varchar(255) DEFAULT 'local',
  `signById` char(36) DEFAULT NULL,
  `signDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentWorkflow`
--

CREATE TABLE `documentWorkflow` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `workflowId` char(36) NOT NULL,
  `currentStepId` char(36) NOT NULL,
  `status` enum('Initiated','InProgress','Completed','Cancelled') NOT NULL DEFAULT 'Initiated',
  `createdBy` char(36) NOT NULL,
  `deletedBy` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailLogAttachments`
--

CREATE TABLE `emailLogAttachments` (
  `id` char(36) NOT NULL,
  `emailLogId` char(36) NOT NULL,
  `path` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailLogs`
--

CREATE TABLE `emailLogs` (
  `id` char(36) NOT NULL,
  `senderEmail` varchar(255) NOT NULL,
  `recipientEmail` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `status` enum('sent','failed') NOT NULL DEFAULT 'sent',
  `errorMessage` text DEFAULT NULL,
  `sentAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailSMTPSettings`
--

CREATE TABLE `emailSMTPSettings` (
  `id` char(36) NOT NULL,
  `host` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `isDefault` tinyint(1) NOT NULL,
  `fromName` varchar(255) DEFAULT NULL,
  `encryption` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `fromEmail` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fileRequestDocuments`
--

CREATE TABLE `fileRequestDocuments` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `fileRequestId` char(36) NOT NULL,
  `fileRequestDocumentStatus` tinyint(4) NOT NULL DEFAULT 0,
  `approvedRejectedDate` datetime DEFAULT NULL,
  `approvalOrRejectedById` char(36) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fileRequests`
--

CREATE TABLE `fileRequests` (
  `id` char(36) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `maxDocument` int(11) DEFAULT NULL,
  `sizeInMb` int(11) DEFAULT NULL,
  `allowExtension` varchar(255) NOT NULL,
  `fileRequestStatus` tinyint(4) NOT NULL DEFAULT 0,
  `linkExpiryTime` datetime DEFAULT NULL,
  `isLinkExpired` tinyint(1) NOT NULL DEFAULT 0,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `halfYearlyReminders`
--

CREATE TABLE `halfYearlyReminders` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `day` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `quarter` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` char(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `order` int(11) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isRTL` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `code`, `name`, `imageUrl`, `createdBy`, `modifiedBy`, `order`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`, `isRTL`) VALUES
('04906ab8-15b0-11ee-83f2-d85ed3312c1f', 'ru', 'Russian', 'images/flags/russia.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 5, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
('10ac83d1-15b0-11ee-83f2-d85ed3312c1f', 'ja', 'Japanese', 'images/flags/japan.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 6, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
('1d9a6233-15b0-11ee-83f2-d85ed3312c1f', 'fr', 'French', 'images/flags/france.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 7, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
('9ed7278c-c7e7-4c91-9a83-83833603eb47', 'ko', 'Korean ', 'images/flags/south-korea.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 8, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
('df8a9fe2-15af-11ee-83f2-d85ed3312c1f', 'en', 'English', 'images/flags/united-states.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 1, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
('ef46fe64-15af-11ee-83f2-d85ed3312c1f', 'cn', 'Chinese', 'images/flags/china.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 2, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
('f8041d27-15af-11ee-83f2-d85ed3312c1f', 'es', 'Spanish', 'images/flags/france.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 3, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
('fe78a067-15af-11ee-83f2-d85ed3312c1f', 'ar', 'Arabic', 'images/flags/saudi-arabia.svg', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '', 4, '', 0, '0000-00-00 00:00:00', '2026-02-07 13:04:03', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `loginAudits`
--

CREATE TABLE `loginAudits` (
  `id` char(36) NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `loginTime` varchar(255) NOT NULL,
  `remoteIP` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loginAudits`
--

INSERT INTO `loginAudits` (`id`, `userName`, `loginTime`, `remoteIP`, `status`, `provider`, `latitude`, `longitude`) VALUES
('05085c99-971f-44e6-b903-007ead2d194b', 'vpersonmail@gmail.com', '2026-02-07 17:45:46', '188.150.226.92', 'Success', NULL, NULL, NULL),
('0ddc68a5-6f23-4a0e-99d5-52d23c3ca87d', 'vpersonmail@gmail.com', '2026-02-07 13:05:11', '188.150.226.92', 'Success', NULL, NULL, NULL),
('1a59c339-baf3-4016-9ad7-80db4c4649e6', 'vpersonmail@gmail.com', '2026-02-07 18:09:02', '188.150.226.92', 'Success', NULL, NULL, NULL),
('1b6cdf39-fa22-4ab6-a0b1-7411537a1294', 'vpersonmail@gmail.com', '2026-02-12 10:22:32', '188.150.243.59', 'Success', NULL, NULL, NULL),
('1ff50f5b-70d6-4b04-9c1d-8359dd60f85a', 'vpersonmail@gmail.com', '2026-02-08 00:37:17', '188.150.226.92', 'Success', NULL, NULL, NULL),
('249de9dc-51f4-4a2d-97dd-0029bda88e73', 'vpersonmail@gmail.com', '2026-02-08 01:05:41', '188.150.226.92', 'Success', NULL, NULL, NULL),
('26922847-3f12-4f85-a2f1-6de5dd5ef11d', 'vpersonmail@gmail.com', '2026-02-08 01:17:32', '188.150.226.92', 'Success', NULL, NULL, NULL),
('29bdf541-d765-4894-86f6-8c6ebb344f1a', 'vpersonmail@gmail.com', '2026-02-07 18:21:58', '188.150.226.92', 'Success', NULL, NULL, NULL),
('2bb73a0f-451d-4ebd-ae52-aa08ce11b0d0', 'vpersonmail@gmail.com', '2026-02-10 12:06:03', '188.150.226.92', 'Success', NULL, NULL, NULL),
('359e1547-f6c5-43c2-89c9-2eaa0a8ba69c', 'vpersonmail@gmail.com', '2026-02-09 12:16:39', '188.150.226.92', 'Success', NULL, NULL, NULL),
('369e643d-1e0d-4fd8-9cdb-fb451fa97f59', 'vpersonmail@gmail.com', '2026-02-10 10:56:37', '188.150.226.92', 'Success', NULL, NULL, NULL),
('39f915fa-d9f5-4b3f-a1e1-2aad2697c31e', 'vpersonmail@gmail.com', '2026-02-08 14:40:15', '188.150.226.92', 'Success', NULL, NULL, NULL),
('3c1da9b1-ceb1-4843-8f5c-945a8af61a47', 'vpersonmail@gmail.com', '2026-02-12 03:45:48', '188.150.243.59', 'Success', NULL, NULL, NULL),
('48763109-dcc2-47c6-bda4-4e6f0eda7fd0', 'vpersonmail@gmail.com', '2026-02-11 12:35:22', '188.150.243.59', 'Success', NULL, NULL, NULL),
('5d49c6cb-e10d-451b-8013-ac904b570639', 'vpersonmail@gmail.com', '2026-02-10 11:38:53', '188.150.226.92', 'Success', NULL, NULL, NULL),
('6df703a6-4665-4f16-b88d-567305417561', 'vpersonmail@gmail.com', '2026-02-10 11:48:34', '188.150.226.92', 'Success', NULL, NULL, NULL),
('6fab9658-1194-4f93-ac2c-33d7bd492694', 'vpersonmail@gmail.com', '2026-02-08 00:31:29', '188.150.226.92', 'Success', NULL, NULL, NULL),
('702a2346-9691-4da2-8ef7-f87cc4b27978', 'vpersonmail@gmail.com', '2026-02-11 12:32:34', '188.150.243.59', 'Success', NULL, NULL, NULL),
('722a405a-dd82-4d82-b878-2864c1b5ce85', 'vpersonmail@gmail.com', '2026-02-11 11:19:47', '188.150.243.59', 'Success', NULL, NULL, NULL),
('725c0ae2-e637-4563-b95c-f765003915e3', 'vpersonmail@gmail.com', '2026-02-11 10:22:45', '188.150.243.59', 'Success', NULL, NULL, NULL),
('78c2ac3b-5ada-487a-872c-5afd706b4d00', 'vpersonmail@gmail.com', '2026-02-07 17:46:08', '188.150.226.92', 'Success', NULL, NULL, NULL),
('7b779389-6e66-497c-891d-14617df3172f', 'vpersonmail@gmail.com', '2026-02-07 18:46:57', '188.150.226.92', 'Success', NULL, NULL, NULL),
('7ea2c2fd-590f-4c7d-8412-8b32cbee3338', 'vpersonmail@gmail.com', '2026-02-10 11:57:13', '188.150.226.92', 'Success', NULL, NULL, NULL),
('8978e76a-a1ae-4d55-a000-aa98647e21a9', 'vpersonmail@gmail.com', '2026-02-07 19:49:49', '188.150.226.92', 'Success', NULL, NULL, NULL),
('9bcdcddb-ed1c-43b0-8169-d53612d52a33', 'vpersonmail@gmail.com', '2026-02-07 17:58:32', '188.150.226.92', 'Success', NULL, NULL, NULL),
('9cf713c2-5773-4d82-a8b3-35a2584e9ca6', 'vpersonmail@gmail.com', '2026-02-08 18:12:43', '188.150.226.92', 'Success', NULL, NULL, NULL),
('9d79c2f0-e2e9-4240-836d-c73c6e767fea', 'vpersonmail@gmail.com', '2026-02-10 10:56:06', '188.150.226.92', 'Success', NULL, NULL, NULL),
('a618421c-7c66-4130-b7a1-a64ef6263ea7', 'vpersonmail@gmail.com', '2026-02-08 15:48:54', '188.150.226.92', 'Success', NULL, NULL, NULL),
('aecf277c-94ec-4112-9f07-d4afaf380336', 'vpersonmail@gmail.com', '2026-02-07 16:44:01', '188.150.226.92', 'Success', NULL, NULL, NULL),
('afb9d7f2-d733-47b6-9374-a422c11dd0ec', 'vpersonmail@gmail.com', '2026-02-09 12:19:55', '188.150.226.92', 'Success', NULL, NULL, NULL),
('b18c7b84-c915-4512-909d-dfa5f8e5cd3f', 'vpersonmail@gmail.com', '2026-02-08 01:33:35', '188.150.226.92', 'Success', NULL, NULL, NULL),
('c237053b-c90d-4683-a55c-e99b072a905f', 'vpersonmail@gmail.com', '2026-02-12 08:36:33', '188.150.243.59', 'Success', NULL, NULL, NULL),
('ce27a2fb-b297-4ee4-a6a3-983899cad33d', 'vpersonmail@gmail.com', '2026-02-07 19:23:43', '188.150.226.92', 'Success', NULL, NULL, NULL),
('cecf4ddd-80c0-47b1-99eb-95052d78102e', 'vpersonmail@gmail.com', '2026-02-08 01:33:05', '188.150.226.92', 'Success', NULL, NULL, NULL),
('da5689b7-f6a2-46dd-a6f6-0c1f02823143', 'vpersonmail@gmail.com', '2026-02-09 14:11:54', '188.150.226.92', 'Success', NULL, NULL, NULL),
('dd99dbb0-4a22-4c60-8c02-1f2ff9000404', 'vpersonmail@gmail.com', '2026-02-10 12:06:18', '188.150.226.92', 'Success', NULL, NULL, NULL),
('ebdf5f03-8da0-4442-af48-13d7a9155d2d', 'vpersonmail@gmail.com', '2026-02-10 11:38:03', '188.150.226.92', 'Success', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2022_12_07_080139_create_users_table', 1),
(2, '2022_12_07_101203_create_roles_table', 1),
(3, '2022_12_08_055649_create_user_roles_table', 1),
(4, '2022_12_08_064517_create_categories_table', 1),
(5, '2023_01_06_103543_create_pages_table', 1),
(6, '2023_01_06_103807_create_actions_table', 1),
(7, '2023_01_07_084251_create_role_claims_table', 1),
(8, '2023_01_07_102537_create_user_claims_table', 1),
(9, '2023_01_23_062456_create_email_s_m_t_p_settings_table', 1),
(10, '2023_01_23_082532_create_documents_table', 1),
(11, '2023_01_25_091840_create_document_meta_datas_table', 1),
(12, '2023_01_26_105856_create_document_versions_table', 1),
(13, '2023_01_26_112250_create_document_role_permissions_table', 1),
(14, '2023_01_26_112318_create_document_user_permissions_table', 1),
(15, '2023_01_28_075359_create_document_comments_table', 1),
(16, '2023_01_31_063051_create_document_audit_trails_table', 1),
(17, '2023_02_07_112502_create_login_audits_table', 1),
(18, '2023_02_08_080324_create_reminders_table', 1),
(19, '2023_02_13_063925_create_reminder_users_table', 1),
(20, '2023_02_13_064215_create_half_yearly_reminders_table', 1),
(21, '2023_02_13_064719_create_quarterly_reminders_table', 1),
(22, '2023_02_13_064914_create_daily_reminders_table', 1),
(23, '2023_02_18_071307_create_reminder_notifications_table', 1),
(24, '2023_02_18_073159_create_user_notifications_table', 1),
(25, '2023_02_18_092637_create_send_emails_table', 1),
(26, '2023_02_18_101836_create_reminder_schedulers_table', 1),
(27, '2023_03_04_073617_create_document_tokens_table', 1),
(28, '2023_07_18_175356_add_encryption_to_email_s_m_t_p_settings_table', 1),
(29, '2023_07_19_084757_create_languages_table', 1),
(30, '2023_07_19_162944_create_company_profile_table', 1),
(31, '2023_12_16_103345_add_location_to_documents_table', 1),
(32, '2023_12_16_103702_add_location_to_document_versions_table', 1),
(33, '2023_12_27_110008_add_location_to_companyprofile_table', 1),
(34, '2024_03_28_044727_add__is_permanent_delete_to__document_table', 1),
(35, '2024_04_05_121019_add__is_r_t_l_to__language_table', 1),
(36, '2024_05_08_113442_add_reset_password_code_users_table', 1),
(37, '2024_07_30_060655_create_document_shareable_link', 1),
(38, '2024_10_19_095904_add_is_indexed_to_documents_table', 1),
(39, '2024_10_22_115740_create_page_helper_table', 1),
(40, '2025_02_28_071020_create_file_requests_table', 1),
(41, '2025_02_28_071225_create_file_request_documents_table', 1),
(42, '2025_02_28_095855_create_allow_file_extensions_table', 1),
(43, '2025_03_11_115518_create_clients_table', 1),
(44, '2025_03_25_084930_add_client_column_to_document_table', 1),
(45, '2025_03_25_090623_add_from_email_column_to_emailsmtp_table', 1),
(46, '2025_04_22_081450_create_ai_prompt_template_table', 1),
(47, '2025_04_22_131011_create_openai_documents_table', 1),
(48, '2025_04_28_061655_create_document_status_table', 1),
(49, '2025_04_28_062430_create__add_document_status_column_to_document_table', 1),
(50, '2025_05_13_092603_add_small_logo_image_to_company_profile_table', 1),
(51, '2025_05_15_125857_create_workflow_tables', 1),
(52, '2025_06_14_090123_add_license_to_company_profile_table', 1),
(53, '2025_06_25_110856_version_5_1', 1),
(54, '2025_09_19_268904_version_5_2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `openaiDocuments`
--

CREATE TABLE `openaiDocuments` (
  `id` char(36) NOT NULL,
  `prompt` text NOT NULL,
  `model` text NOT NULL,
  `language` text DEFAULT NULL,
  `maximumLength` int(11) DEFAULT NULL,
  `creativity` decimal(18,2) DEFAULT NULL,
  `toneOfVoice` text DEFAULT NULL,
  `response` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pageHelper`
--

CREATE TABLE `pageHelper` (
  `id` char(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pageHelper`
--

INSERT INTO `pageHelper` (`id`, `code`, `name`, `description`) VALUES
('0cc83192-f05b-4c97-ab20-f7f3b5ba16d0', 'REMINDERS', 'Reminders', '<p>The <strong>\"Reminders\"</strong> page is the central hub for managing reminders within CMR DMS, where users can create, view, and manage reminders or notifications related to documents or other activities. Reminders can be set to repeat at regular intervals and can be associated with a specific document for efficient tracking of tasks and activities.</p><h3>Main components:</h3><ol><li><strong>\"Add Reminder\" Button</strong>:<ul><li>Allows users to create a new reminder.</li><li>Upon clicking, it opens a form where details such as subject, message, frequency, associated document, and reminder date can be entered.</li></ul></li><li><strong>Reminders Table</strong>:<ul><li>Displays all created reminders in a tabular format.</li><li>Each entry includes:<ul><li>Start date</li><li>End date</li><li>Reminder subject</li><li>Associated message</li><li>Recurrence frequency</li><li>Associated document (if applicable)</li></ul></li></ul></li></ol><h3>\"Add Reminder\" Form:</h3><p>When users click on the <strong>\"Add Reminder\"</strong> button, a form opens with the following fields:</p><ul><li><strong>Subject</strong>: The title or topic of the reminder (e.g., \"Document Review\").</li><li><strong>Message</strong>: Additional details about the reminder (e.g., \"Review the document by X date\").</li><li><strong>Repeat Reminder</strong>: Sets the recurrence frequency, with options such as:<ul><li>Daily</li><li>Weekly</li><li>Monthly</li><li>Semi-annually</li></ul></li><li><strong>Send Email</strong>: An option to send an email notification when the reminder is activated.</li><li><strong>Select Users</strong>: Allows selecting users to whom the reminder will be sent. It can be customized for specific teams or individuals.</li><li><strong>Reminder Date</strong>: The date and time when the reminder will be activated and sent.</li></ul><h3>How to add a new reminder:</h3><ol><li>Navigate to the <strong>\"Reminders\"</strong> page.</li><li>Click the <strong>\"Add Reminder\"</strong> button.</li><li>Fill in the form fields with the necessary information.</li><li>After entering all the details, click <strong>\"Save\"</strong> or <strong>\"Add\"</strong> to save the reminder in the system.</li></ol><h3>\"Add Reminder\" Functionality in the \"Manage Reminders\" section:</h3><p>This is the dedicated place for creating and managing notifications related to events or tasks. The <strong>\"Add Reminder\"</strong> functionality offers full customization, and reminders can be sent to selected users.</p><ul><li><strong>Subject</strong>: Enter a descriptive title for the reminder.</li><li><strong>Message</strong>: Add a clear and concise message to detail the purpose of the reminder.</li><li><strong>Repeat Reminder</strong>: Set whether the reminder will be repeated periodically (daily, weekly, etc.).</li><li><strong>Send Email</strong>: If this option is checked, the reminder will also be sent as an email.</li><li><strong>Select Users</strong>: Select users from the system\'s list to whom the reminder will be sent.</li><li><strong>Reminder Date</strong>: Set the date and time for the reminder to be triggered.</li></ul>'),
('0d3afaea-1984-41f9-a826-fa5b0a9ccad3', 'BULK_DOCUMENT_UPLOADS', 'Document Bulk Upload', '<h3><strong>Bulk Document Uploads</strong></h3><p>Easily upload multiple documents to your system with the following steps:</p><p><strong>1.Category</strong></p><ul><li><strong>Select Category</strong>: Choose a category where your documents will be stored. This helps organize your uploads.</li></ul><p><strong>2.Document Status</strong></p><ul><li>Define the status of each document (e.g., Draft, Final, Archived). This ensures clarity and organization.</li></ul><p><strong>3.Storage</strong></p><ul><li>Select the storage location for your documents:<ul><li><strong>Local</strong>: Save documents to the local storage system.</li></ul></li></ul><p><strong>4.Assign By Roles</strong></p><ul><li><strong>5.Roles</strong>: Assign specific roles to the documents. For example: Manager, Editor, or Viewer.</li><li>This determines which roles have access to the uploaded documents.</li></ul><p><strong>6.Assign By Users</strong></p><ul><li><strong>7.Users</strong>: Assign individual users who can access these documents.</li><li>Select from a list of users in your system.</li></ul><p><strong>8.Document Upload</strong></p><ul><li>Select multiple files to upload from your device.</li><li>Ensure the file extensions are in the allowed list.</li><li>Optionally, rename files before uploading to keep them organized.</li></ul><p><strong>9.Finalize Upload</strong></p><ul><li>After filling out all the required fields, upload the documents.</li><li>The system will automatically assign the selected roles and users to each uploaded file.</li></ul>'),
('0fae65e2-091d-469b-8a2a-9bb363ba8290', 'DOCUMENTS_AUDIT_TRAIL', 'Document audit history', '<p><strong>General Description:</strong></p><p>The \"Document Audit History\" page provides a detailed view of all actions performed on documents within the DMS. It allows administrators and users with appropriate permissions to monitor and review document-related activities, ensuring transparency and information security.</p><p><strong>Main Components:</strong></p><p><strong>Search Boxes:</strong></p><ul><li><strong>By Document Name:</strong> Allows users to search for a specific document by entering its name or other details.</li><li><strong>By Meta Tag:</strong> Users can enter meta tags to filter and search for specific document-related activities.</li><li><strong>By User:</strong> Enables filtering activities based on the user who performed the operation.</li></ul><p><strong>List of Audited Documents:</strong></p><p>Displays all actions taken on documents in a tabular format.</p><p>Each entry includes details of the action, such as the date, document name, Category, operation performed, who performed the operation, to which user, and to which role the operation was directed.</p><p>Users can click on an entry to view additional details or access the associated document.</p><p><strong>List Sorting:</strong></p><p>Users can sort the list by any of the available columns, such as \"Date,\" \"Name,\" \"Category Name,\" \"Operation,\" \"Performed by,\" \"Directed to User,\" and \"Directed to Role.\"</p><p>This feature makes it easier to organize and analyze information based on specific criteria.</p><p><strong>How to Search the Audit History:</strong></p><ul><li>Enter your search criteria in the corresponding search box (document name, meta tag, or user).</li><li>The search results will be displayed in the audited documents list.</li></ul><p><strong>How to Sort the List:</strong></p><ul><li>Click on the column title by which you want to sort the list (e.g., \"Date\" or \"Name\").</li><li>The list will automatically reorder based on the selected criterion.</li></ul>'),
('25ccccd4-bd60-4f8b-8bc1-c49eca98fb49', 'EMAIL_SMTP_SETTINGS', 'SMTP Email Settings', '<p>The <strong>\"Email SMTP Settings\"</strong> page within CMR DMS allows administrators to configure and manage the SMTP settings for sending emails. This ensures that emails sent from the system are correctly and efficiently delivered to recipients.</p><p><strong>Key Components:</strong></p><ul><li><p><strong>SMTP Settings Table:</strong> Displays all configured SMTP settings in a tabular format.</p><p>Each entry in the table includes details such as the username, host, port, and whether that configuration is set as the default.</p></li><li><p><strong>\"Add Settings\" Button:</strong> Allows administrators to add a new SMTP configuration.</p><p>Clicking the button opens a form where details like username, host, port, and the option to set it as the default configuration can be entered.</p></li></ul><p><strong>\"Add Settings\" Form:</strong></p><p>This form opens when administrators click the \"Add Settings\" button and includes the following fields:</p><ul><li><strong>Username:</strong> The username required for authentication on the SMTP server.</li><li><strong>Host:</strong> The SMTP server address.</li><li><strong>Port:</strong> The port on which the SMTP server listens.</li><li><strong>Is Default:</strong> A checkbox that allows setting this configuration as the default for sending emails.</li></ul><p><strong>How to Add a New SMTP Configuration:</strong></p><ol><li>Click the \"Add Settings\" button.</li><li>The \"Add Settings\" form will open, where you can enter the SMTP configuration details.</li><li>Fill in the necessary fields and select the desired options.</li><li>After completing the details, click \"Save\" or \"Add\" to add the configuration to the system.</li></ol>'),
('2b728c10-c0b3-451e-8d08-2be1e3f6d5b3', 'USERS', 'Users', '<p><strong>The \"Users\" page is the central hub for managing all registered users in CMR DMS. Here, administrators can add, edit, or delete users, as well as manage permissions and reset passwords. Each user has associated details such as first name, last name, mobile phone number, and email address.</strong></p><p><strong>Main Components:</strong></p><ul><li><p><strong>\"Add User\" Button:</strong> Allows administrators to create a new user in the system.</p><p>Opens a form where details such as first name, last name, mobile phone number, email address, password, and password confirmation can be entered.</p></li><li><p><strong>List of Existing Users:</strong> Displays all registered users in the system in a tabular format.</p><p>Each entry includes the user’s email address, first name, last name, and mobile phone number.</p><p>Next to each user, there is an action menu represented by three vertical dots.</p></li><li><p><strong>Action Menu for Each User:</strong> This menu opens by clicking on the three vertical dots next to each user.</p><p>Includes the options:</p><ul><li><strong>Edit:</strong> Allows modification of the user’s details.</li><li><strong>Delete:</strong> Removes the user from the system. This action may require confirmation to prevent accidental deletions.</li><li><strong>Permissions:</strong> Opens a window or form where administrators can set or modify the user’s permissions.</li><li><strong>Reset Password:</strong> Allows administrators to initiate a password reset process for the selected user.</li></ul></li></ul><p><strong>How to Add a New User:</strong></p><ol><li>Click on the \"Add User\" button.</li><li>A form will open where you can enter the user’s details: first name, last name, mobile phone number, email address, password, and password confirmation.</li><li>After completing the details, click \"Save\" or \"Add\" to add the user to the system.</li></ol>'),
('2dd28c72-3ed4-4f75-b23b-63cadcaa3982', 'ALL_DOCUMENTS', 'All Documents', '<p>The <strong>\"All Documents\"</strong> page provides a complete overview of all documents uploaded in the DMS. It is the ideal place to search, view, manage, and distribute all available documents in the system.</p><p><strong>Main Components:</strong></p><ul><li><strong>\"Add Document\" Button:</strong> Allows any user with appropriate permissions to upload a new document into the system.<ul><li>Opens a form or a pop-up window where files can be selected and uploaded.</li></ul></li><li><strong>Search Box (by name):</strong> Allows users to search for a specific document by entering its name or other details.</li><li><strong>Search Box (by meta tags):</strong> Users can enter Meta tags to filter and search for specific documents.</li><li><strong>Category Dropdown:</strong> A dropdown menu that allows users to filter documents by Category.</li><li><strong>Storage Dropdown: </strong>The application lets users store documents in various storage options, such as AWS S3 and local storage. Users can easily search for documents by selecting the desired storage option from a dropdown menu.</li><li><strong>Search Box (by creation date):</strong> Allows users to search for documents based on their creation date.</li><li><strong>List of All Uploaded Files:</strong> Displays all documents available in the system.<ul><li>Each entry includes document details such as name, creation date, Category, status and storage.</li></ul></li><li><strong>Document Actions Menu:</strong> Alongside each document in the list, users will find an actions menu allowing them to perform various operations on the document:<ul><li><strong>Edit:</strong> Modify the document details, such as its name or description.</li><li><strong>Share:</strong> Share the document with other users or roles within the system.</li><li><strong>Get Shareable Link:</strong> Users can generate a shareable link to allow anonymous users to access documents. They can also protect the link with a password and set an expiration period, ensuring the link remains active only for the selected duration. Additionally, the link includes an option for recipients to download the shared document.</li><li><strong>View:</strong> Open the document for viewing.</li><li><strong>Upload a New Version:</strong> Add a new version of the document.</li><li><strong>Version History:</strong> Users can view all previous versions of a document, with the ability to restore any earlier version as needed. Each version can also be downloaded for offline access or review.</li><li><strong>Comment:</strong> Add or view comments on the document.</li><li><strong>Add Reminder:</strong> Set a reminder for the document.</li><li><strong>Send as Email:</strong> Send the document as an attachment via email.</li><li><strong>Delete:</strong> Remove the document from the system.</li></ul></li></ul><p><strong>Document Sharing:</strong></p><p>Users can select one, multiple, or all documents from the list and use the sharing option to distribute the selected documents to other users. This feature facilitates the mass distribution of documents to specific users or groups.</p>'),
('350137e8-91d3-4e53-a621-1fae3fb680eb', 'FILE_REQUEST_UPLOADED_DOCUMENTS', 'File Request Documents', '<h2>File Request Uploaded Documents</h2><p>The <strong>File Request Uploaded Documents</strong> feature allows you to manage the documents submitted through your file request link. You can review, approve, or reject uploaded files and provide feedback or reasons for rejection.</p><h2>Key Features:</h2><p><strong>1.View Uploaded Documents</strong>:</p><ul><li>Access all documents submitted via the file request link.</li><li>See details such as:<ul><li>File Name</li><li>Upload Date</li><li>Document Status</li><li>Reason</li></ul></li></ul><p><strong>2.Approve Documents</strong>:</p><ul><li>Mark documents as <strong>Approved</strong> if they meet your requirements.</li><li>Approved documents will be saved and marked as finalized.</li></ul><p><strong>3.Reject Documents</strong>:</p><ul><li>Reject documents that do not meet the criteria or need corrections.</li><li>When rejecting a document:<ul><li>Add a <strong>Comment</strong> to explain the reason for rejection.</li><li>This ensures users understand what needs to be corrected or resubmitted.</li></ul></li></ul><p><strong>4.Document Preview</strong>:</p><ul><li>View uploaded documents directly before approving or rejecting them.</li><li>Supports previewing common file types such as PDF, DOCX, JPG, and PNG.</li></ul><p><strong>5.Status Tracking</strong>:</p><ul><li>Each document will have a status indicator:<ul><li><strong>Pending</strong>: Awaiting review.</li><li><strong>Approved</strong>: Accepted and finalized.</li><li><strong>Rejected</strong>: Requires resubmission with a reason provided.</li></ul></li></ul><h2>How It Works:</h2><h3>1. Viewing Uploaded Documents:</h3><ul><li>Go to the <strong>File Request Uploaded Documents</strong> page.</li><li>Select the relevant file request from the list.</li><li>All submitted documents for that request will be displayed.</li></ul><h3>2. Approving Documents:</h3><ul><li>Click on the document you want to approve.</li><li>Review the document using the preview feature.</li><li>If the document meets your requirements, click <strong>Approve</strong>.</li><li>The status will change to <strong>Approved</strong>.</li></ul><h3>3. Rejecting Documents:</h3><ul><li>Click on the document you want to reject.</li><li>Use the preview feature to review the document.</li><li>If the document does not meet the requirements:<ul><li>Click <strong>Reject</strong>.</li><li>Enter a <strong>Reason for Rejection</strong> in the comment box (e.g., Incorrect file format or Incomplete information).</li><li>Save the rejection and notify the user to resubmit.</li></ul></li></ul><h3>4. Adding Comments for Rejected Documents:</h3><ul><li>When rejecting a document, always provide a clear and actionable comment.</li><li>Examples of comments:<ul><li>Please upload a file in PDF format.</li><li>The document is missing required signatures.</li><li>File size exceeds the maximum limit; please compress and reupload.</li></ul></li></ul><h2>Benefits:</h2><ul><li><strong>Efficient Review</strong>: Quickly review and take action on uploaded documents.</li><li><strong>Clear Communication</strong>: Provide feedback for rejected documents, ensuring users know what to fix.</li><li><strong>Organized Workflow</strong>: Keep track of document statuses with easy-to-use status indicators.</li></ul><p>This feature ensures a smooth and transparent document review process for both you and the users.</p>'),
('3af375cf-1456-4ca8-8ca0-c1bb3859107c', 'EMAIL_LOGS', 'Email Logs', '<p><strong>Email Logs</strong> in a <strong>Document management system</strong> help monitor and track all email communications sent through the system. This feature ensures transparency, enables debugging in case of errors, and provides a history of email activity for auditing purposes.</p><hr><h3><strong>Key Features of Email Logs</strong></h3><ol><li><p><strong>Basic Email Details</strong></p><ul><li><p><strong>Email ID</strong>: A unique identifier for each email sent.</p></li><li><p><strong>Timestamp</strong>: Date and time the email was sent.</p></li><li><p><strong>Sender Email Address</strong>: The email address from which the email was sent (e.g., <a href=\"mailto:support@yourbusiness.com\">support@</a><a href=\"yourbusiness.com\" target=\"_blank\">yourbusiness.com</a>).</p></li><li><p><strong>Recipient Email Address</strong>: The email address of the recipient.</p></li></ul></li><li><p><strong>Email Content Details</strong></p><ul><li><p><strong>Subject</strong>: The subject line of the email.</p></li><li><p><strong>Body</strong>: A preview or complete content of the email.</p></li><li><p><strong>Attachments</strong>: Details of any files attached to the email (e.g., invoices, purchase orders).</p></li></ul></li><li><p><strong>Delivery Status</strong></p><ul><li><p><strong>Status</strong>: The status of the email (e.g., Sent, Failed, Queued, Delivered, Opened, Bounced).</p></li><li><p><strong>Error Details</strong>: If the email failed, the error message or code explaining why (e.g., invalid recipient address, server timeout).</p></li></ul></li></ol><hr><h3><strong>How to Implement Email Logs in a Document management System</strong></h3><ol><li><p><strong>Email Sending Service Integration</strong></p><ul><li><p>Integrate with an SMTP server, third-party email service (e.g., SendGrid, Mailgun), or a built-in email module.</p></li></ul></li><li><p><strong>Database for Logging</strong></p><ul><li><p>Store email logs in a dedicated database table with all relevant fields (email ID, recipient, status, etc.).</p></li></ul></li><li><p><strong>UI for Logs</strong></p><ul><li><p>Design a user-friendly interface to view, filter, and export email logs.</p></li></ul></li><li><p><strong>Error Handling</strong></p><ul><li><p>Implement robust error-catching mechanisms to record and display reasons for failures.</p></li></ul></li><li><p><strong>Automated Notifications</strong></p><ul><li><p>Set up automatic alerts for critical email delivery issues.</p></li></ul></li></ol><hr><p></p>'),
('3e0fe36d-cde5-4bd9-b65d-cfaeadcffce3', 'COMPANY_PROFILE', 'Company Profile', '<p>Here’s a detailed description of the functionality for managing the company profile, focusing on the company name, logo, and banner logo on the login screen.</p><h3> </h3><h4>Overview</h4><p>The Company Profile feature allows users to customize the branding of the application by entering the company name and uploading logos. This customization will reflect on the login screen, enhancing the professional appearance and brand identity of the application.</p><h4>Features</h4><ol><li><h4><strong>Company Name</strong></h4><ul><li><strong>Input Field:</strong><ul><li>Users can enter the name of the company in a text input field.</li><li><strong>Validation:</strong><ul><li>The field will have validation to ensure the name is not empty and meets any specified length requirements (e.g., minimum 2 characters, maximum 50 characters).</li><li><strong>Browser Title Setting:</strong></li><li>Upon saving the company name, the application will dynamically set the browser title to match the company name, improving brand visibility in browser tabs.</li></ul></li></ul></li></ul></li><li><h4><strong>logo Upload</strong></h4><ul><li><strong>Upload Button:</strong><ul><li>Users can upload a company logo that will be displayed in the header of the login page.</li><li><strong>File Requirements:</strong><ul><li>Supported file formats: PNG, JPG, JPEG (with size limits, e.g., up to 2 MB).</li><li>Recommended dimensions for optimal display (e.g., width: 200px, height: 100px).</li></ul></li></ul></li><li><strong>Preview:</strong><ul><li>After uploading, a preview of the logo will be displayed to confirm the upload.</li></ul></li></ul></li><li><h4><strong>Banner logo Upload</strong></h4><ul><li><strong>Upload Button:</strong><ul><li>Users can upload a banner logo that will appear prominently on the login screen.</li><li><strong>File Requirements:</strong><ul><li>Supported file formats: PNG, JPG, JPEG (with size limits, e.g., up to 3 MB).</li><li>Recommended dimensions for optimal display (e.g., width: 1200px, height: 300px).</li></ul></li></ul></li><li><strong>Preview:</strong><ul><li>A preview of the banner logo will be displayed after the upload for confirmation.</li></ul></li></ul></li><li><h4><strong>User Interaction Flow</strong></h4><ul><li><h4><strong>Navigating to the Company Profile:</strong></h4><ul><li>Users can access the company profile settings from the application’s settings menu or administration panel.</li></ul></li><li><strong>Editing Company Profile:</strong><ul><li>Users enter the company name, upload the logo, and the banner logo.</li><li>A \"Save Changes\" button will be available to apply the modifications.</li></ul></li><li><strong>Saving Changes:</strong><ul><li>Upon clicking \"Save Changes,\" the uploaded logos and company name will be saved and reflected on the login screen.</li><li>Confirmation messages will be displayed to indicate successful updates.</li></ul></li></ul></li><li><strong>Display on Login Screen</strong><ul><li><strong>Header Display:</strong><ul><li>The company logo will be displayed in the header at the top of the login page, maintaining a consistent branding experience.</li></ul></li><li><strong>Banner Display:</strong><ul><li>The banner logo will be displayed prominently below the header, enhancing the visual appeal of the login interface.</li></ul></li></ul></li></ol><h3>Summary</h3><p>The Company Profile functionality allows for a customizable branding experience, enabling users to set their company name and logos that will be visible on the login screen. This feature enhances user engagement and presents a professional image right from the login phase of the application.</p>'),
('45c53b1a-a865-4c22-b56a-9f5e6cf83528', 'CLIENTS', 'Clients', '<p>The <strong>Clients</strong> section helps you manage and view all your clients in one place. Here’s what you can do:</p><p><strong>1.Clients List</strong></p><ul><li>A list of all your clients is displayed with the following details:</li></ul><p><strong>Action</strong>: Options to edit or delete client information.</p><p><strong>Company/Person Name</strong>: The name of the company or individual client.</p><p><strong>Contact Person</strong>: The primary contact person for the client.</p><p><strong>Email</strong>: The email address of the client for communication.</p><p><strong>Mobile Number</strong>: The mobile number of the client for easy contact.</p><p><strong>2.Add Client</strong></p><ul><li>Click the <strong>Add Client</strong> button to create a new client.</li><li>Fill in details like the company or person name, contact person, email, and mobile number.</li><li>Save the new client, and it will be added to the clients list.</li></ul>'),
('4792e9a6-10f0-4a5a-9294-1eb4d663d72f', 'ARCHIVED_DOCUMENTS', 'Archived Documents', 'The Archived Documents feature allows users to securely store and organize documents that are no longer actively used but need to be retained for future reference or compliance purposes. Archiving helps declutter the active workspace by moving older documents to a dedicated archive, while still keeping them easily accessible when needed.'),
('49612137-bc17-4b60-b905-3c48734500bd', 'AI_DOCUMENT_GENERATOR', 'AI Document Generator', '<h2>🧠 Using the AI Document Generator</h2><h3>Step-by-Step Instructions</h3><h4>🖊️ 1. <strong>Enter a Prompt</strong></h4><p>Navigate to the section where document creation is available. You will see a prompt input field labeled <strong>\"Generate with AI\"</strong> or similar.</p><blockquote><p>Example Prompt:<br>“Write a GDPR privacy policy for a small e-commerce company.”</p></blockquote><h4>▶️ 2. <strong>Click ‘Generate’</strong></h4><p>Click the <strong>\"Generate\"</strong> or <strong>\"Submit\"</strong> button next to the prompt box. This sends your request to the backend, which calls OpenAI.</p><h4>🔄 3. <strong>Real-Time Streaming</strong></h4><p>You’ll begin to see content populate inside the rich text editor <strong>(CKEditor)</strong> live — no need to refresh or wait for a full response. The AI streams back sentences as it composes.</p><blockquote><p>💡 This process typically starts in 1–2 seconds and streams text smoothly in real-time.</p></blockquote><h4>✍️ 4. <strong>Edit the Content</strong></h4><p>Once the document is generated, you can:</p><ul><li>Edit directly inside the CKEditor</li><li>Apply formatting (headings, lists, links, etc.)</li><li>Save the document into the system or export as needed</li></ul><h2>🧰 Advanced Features</h2><ul><li>✅ <strong>Real-Time Streaming</strong>: Watch content appear as it’s generated.</li><li>🔒 <strong>Secure Access</strong>: Only authenticated users can access the API using Bearer tokens.</li><li>💾 <strong>Auto Save</strong>: Generated content is automatically stored along with the original prompt.</li><li>📝 <strong>Markdown to HTML</strong>: The system parses markdown and renders it as rich text in the editor.</li></ul><h2>❗ Common Issues &amp; Troubleshooting</h2><figure class=\"table\"><table><thead><tr><th>Issue</th><th>Cause</th><th>Solution</th></tr></thead><tbody><tr><td>⚠️ Nothing is generated</td><td>Blank prompt or network error</td><td>Make sure you entered a valid prompt and are connected to the internet</td></tr><tr><td>🔒 419 Error</td><td>Missing CSRF token or unauthorized call</td><td>Ensure you\'re logged in and the request includes a valid Bearer token</td></tr><tr><td>❌ API Failed</td><td>OpenAI error or rate limit</td><td>Try again in a few minutes or check logs for API key issues</td></tr></tbody></table></figure><h2>📈 Best Practices</h2><ul><li>Use clear and specific prompts to get better results.</li><li>Include document type or target audience in your prompt.<ul><li>✅ “Create an employee NDA agreement for a startup in plain language.”</li></ul></li><li>Edit the AI-generated content before final submission for accuracy.</li></ul><h2>🛡️ Security Notes</h2><ul><li>Your prompt and result are stored securely in the system.</li><li>OpenAI credentials are never exposed to the client.</li><li>Only authenticated users can trigger the AI generation feature.</li></ul><h2>📞 Need Help?</h2><p>If you encounter issues:</p><ul><li>Contact Support via the Help Center</li><li>Check your browser console (F12) for error messages</li><li>Ensure your token is active and valid</li></ul><p>Would you like this delivered as a downloadable <strong>PDF</strong> or <strong>Markdown</strong> file for sharing? I can generate one for you right away.</p>'),
('509dfdb8-8e5c-4370-8427-f6a9c2c78007', 'ROLE_USER', 'Role users', '<p><strong>The \"User with Role\" page is dedicated to assigning specific roles to users within the DMS. It allows administrators to associate users with particular roles using an intuitive \"drag and drop\" system. Users can be moved from the general user list to the \"Users with Role\" list, thereby assigning them the selected role.</strong></p><h3><strong>Main Components:</strong></h3><ul><li><strong>Title \"User with Role\":</strong> Indicates the purpose and functionality of the page.</li><li><strong>Department:</strong> Displays the currently selected department, in this case, \"Approvals.\"<ul><li>There may be an option to change the department if needed.</li></ul></li><li><strong>Select Role:</strong> A dropdown menu or selection box where administrators can choose the role they wish to assign to users.<ul><li>Once a role is selected, users can be moved into the \"Users with Role\" list to assign them that role.</li></ul></li><li><strong>Note:</strong> A short instruction explaining how to use the page, indicating that users can be moved from the \"All Users\" list to the \"Users with Role\" list to assign them a role.</li><li><strong>\"All Users\" and \"Users with Role\" Lists:</strong><ul><li><strong>\"All Users\":</strong> Displays a complete list of all registered users in the CMR DMS.</li><li><strong>\"Users with Role\":</strong> Displays the users who have been assigned the selected role.</li><li>Users can be moved between these lists using the \"drag and drop\" functionality.</li></ul></li></ul><h3><strong>How to Assign a Role to a User:</strong></h3><ol><li>Select the desired role from the \"Select Role\" box.</li><li>Locate the desired user in the \"All Users\" list.</li><li>Using the mouse or a touch device, drag the user from the \"All Users\" list and drop them into the \"Users with Role\" list.</li><li>The selected user will now be associated with the chosen role and will appear in the \"Users with Role\" list.</li></ol>'),
('5475c0fb-5a9e-44e1-b628-6757d6865d2a', 'MANAGE_ALLOW_FILE_EXTENSION', 'Manage File Extensions', '<p><strong>Manage Allowed File Extensions</strong></p><p>This functionality allows users to control which file types are permitted for upload in the application. Users can easily configure allowed file extensions by selecting the desired file types and specifying their extensions in a provided configuration interface. Here\'s how it works:</p><ol><li><strong>Select File Types</strong>: Users can choose from a predefined list of file types (e.g., images, documents, videos) or manually add custom types.</li><li><strong>Add Extensions</strong>: For each file type, users can specify the associated file extensions (e.g., .jpg, .pdf, .mp4).</li><li><strong>Apply Changes</strong>: Once configured, the application will enforce these rules, ensuring only the specified file types can be uploaded.</li><li><strong>Easy Management</strong>: Users can modify, add, or remove allowed extensions anytime, making the system flexible and easy to update.</li></ol><p>This functionality simplifies file type management and ensures compliance with application requirements or security policies.</p>'),
('5c66b992-8ec0-4d61-ab1e-1f5d40186403', 'DEEP_SEARCH', 'Deep Search', '<p>The <strong>Deep Search</strong> feature in the document management system enables users to perform powerful searches within the content of various file formats such as PDFs, Word documents, text files, and Excel spreadsheets.</p><p>Key functionalities include:</p><p>- <strong>Content-Based Search</strong>: The system scans the actual content within supported file formats (PDF, Word, Text, Excel), allowing users to search for keywords, phrases, or data inside the documents, not just file names or metadata.<br>&nbsp;<br>- <strong>Multi-Format Support</strong>: Deep search works seamlessly across different file formats, ensuring users can locate relevant information regardless of the document type.<br>&nbsp;<br>- <strong>Top 10 Search Results</strong>: The search returns the most relevant top 10 results based on the query, helping users quickly access the most pertinent documents or information.<br>&nbsp;<br>- <strong>Fast and Efficient</strong>: Optimized for speed, the deep search functionality delivers results promptly, even when searching across large document libraries.</p><p>This feature enhances productivity by allowing users to find specific content within documents, saving time and improving access to critical information.</p><p><strong>Note:</strong></p><p>You will receive up to 10 results for each search. The search is not case-sensitive, so searching for \"Report\" and \"report\" will return the same results. Common words like \"and,\"\"the,\" and \"is\" are ignored to improve search efficiency. The search also matches variations of words, so searching for \"run\" will include results for \"running\" and \"runs.\" Supported file types include Word documents, PDFs, Notepad files, and Excel spreadsheets.</p>'),
('5d15d912-674b-47af-ade8-35013e4c95c4', 'DOCUMENT_COMMENTS', 'Comments', '<ul><li><strong>Allows users to add comments to the document.</strong></li><li>Other users can view and respond to comments, facilitating discussion and collaboration on the document.</li></ul>'),
('5d7ba1b1-a380-4e4d-8cb0-56159a6ee0d3', 'ASSIGNED_DOCUMENTS', 'Assigned documents', '<p>The <strong>\"Assigned Documents\"</strong> page is the central hub for managing documents allocated to a specific user. Here, users can view all the documents assigned to them, search for specific documents, and perform various actions on each document.</p><h3>Main Components:</h3><ul><li><strong>\"Add Document\" Button</strong>: Allows users to upload a new document to the system.<ul><li>Opens a form or pop-up window where files can be selected and uploaded.</li></ul></li><li><strong>My Reminders</strong>: Displays a list of all the reminders set by the user.<ul><li>Users can view, edit, or delete reminders.</li></ul></li><li><strong>Search Box (by name or document)</strong>: Allows users to search for a specific document by entering its name or other document details.</li><li><strong>Search Box (by meta tags)</strong>: Users can enter meta tags to filter and search for specific documents.</li><li><strong>Category Selection Dropdown</strong>: A dropdown menu that allows users to filter documents based on their Category.</li><li><strong>Status Selection Dropdown</strong>: A dropdown menu that allows users to filter documents based on their status.</li><li><strong>List of files allocated to the user</strong>: Displays the documents assigned to the user in allocation order.<ul><li>Each entry includes columns for \"Action,\" \"Name,\" \"Status,\" \"Category Name,\" \"Creation Date,\" \"Expiration Date,\" and \"Created By.\"</li></ul></li><li>Next to each document, there is a menu with options such as \"edit,\" \"share,\" \"view,\" \"upload a version,\" \"version history,\" \"comment,\" and \"add reminder.\"</li></ul><h3>How to Add a New Document:</h3><ol><li>Click the <strong>\"Add Document\"</strong> button.</li><li>A form or pop-up window will open.</li><li>Select and upload the desired file, then fill in the necessary details.</li><li>Click <strong>\"Save\"</strong> or <strong>\"Add\"</strong> to upload the document to the system.</li></ol><h3>How to Search for a Document:</h3><ol><li>Enter the document\'s name or details in the appropriate search box.</li><li>The search results will be displayed in the document list.</li></ol><h3>How to Perform Actions on a Document:</h3><p><strong>Document Action Menu Overview</strong>:<br>The action menu offers users various options for managing and interacting with the assigned documents. Each action is designed to provide specific functionalities, allowing users to work efficiently with their documents.</p><h4>Available Options:</h4><ul><li><strong>Edit</strong>: Allows users to modify the document\'s details, such as its name, description, or meta tags.<ul><li>After making changes, users can save the updates.</li></ul></li><li><strong>Share</strong>: Provides the option to share the document with other users or roles in the system.<ul><li>Users can set specific permissions, such as view or edit, for those with whom the document is shared.</li></ul></li><li><strong>View</strong>: Opens the document in a new window or an embedded viewer, allowing users to view the document\'s content without downloading it.</li><li><strong>Upload a Version</strong>: Allows users to upload an updated version of the document.<ul><li>The original document remains in the system, and the new version is added as an update.</li></ul></li><li><strong>Version History</strong>: Displays all previous versions of the document.<ul><li>Users can view, or download any of the previous versions if the administrator allows the user to download document permission.</li></ul></li><li><strong>Comment</strong>: Allows users to add comments to the document.<ul><li>Other users can view and respond to comments, facilitating discussion and collaboration on the document.</li></ul></li><li><strong>Add Reminder</strong>: Sets a reminder for an event or action related to the document.<ul><li>Users can receive notifications or emails when the reminder date approaches.</li></ul></li></ul>'),
('5d858491-f9db-4aef-959f-5af9d7f3b7bd', 'MANAGE_ROLE', 'Manage Role', '<ul><li>Allows administrators or users with appropriate permissions to create a new role in the system.</li><li>Opens a form or a pop-up window where permissions and role details can be defined.</li><li>Enter the role name and select the appropriate permissions from the available list.</li><li>Click <strong>\"Save\"</strong> or <strong>\"Add\"</strong> to add the role to the system with the specified permissions.</li></ul><p> </p><p><br> </p>'),
('647244ec-b5b2-4fbf-9c93-6133cb252a40', 'MANAGE_CLIENT', 'Manage Client', '<p>The <strong>Manage Client</strong> feature makes it easy to add new clients or edit existing client details. Here’s how you can use it:</p><h4><strong>Add New Client</strong></h4><p>1.Click the <strong>Add Client</strong> button.</p><p>2.A form will appear where you can enter the following details:</p><p><strong>Company/Person Name</strong>: Enter the name of the company or individual client.</p><p><strong>Contact Person</strong>: Provide the name of the main contact person.</p><p><strong>Email</strong>: Enter the client’s email address.</p><p><strong>Mobile Number</strong>: Add the client’s mobile number for quick contact.</p><p>3.Once all the details are filled in, click the <strong>Save</strong> button to add the new client to the list.</p><p>4.The newly added client will now appear in the <strong>Clients List</strong>.</p><h4><strong>Edit Existing Client</strong></h4><p>1.In the <strong>Clients List</strong>, locate the client whose details you want to edit.</p><p>2.Click the <strong>Edit</strong> button in the <strong>Action</strong> column.</p><p>3.A form will open, pre-filled with the client’s existing details.</p><p>4.Update any necessary fields, such as:</p><p>Correcting the email address or phone number.</p><p>Changing the contact person or company name.</p><p>5.After making the changes, click the <strong>Save</strong> button to update the client’s information.</p><p>6.The changes will reflect immediately in the <strong>Clients List</strong>.</p>'),
('647f1663-df23-45b0-872e-f6da5b609abb', 'LANGUAGES', 'Languages', '<p>The <strong>Multiple Language Support</strong> feature in the document management system enables users to interact with the platform and manage documents in various languages, providing flexibility for global teams or multilingual users.</p><p>Key functionalities include:</p><p>- <strong>Multi-Language Interface</strong>: The system’s interface can be viewed and navigated in multiple languages, ensuring ease of use for users across different regions.<br>&nbsp;<br>- <strong>Add New Languages</strong> Administrators have the ability to easily add support for additional languages, expanding the system\'s accessibility to more users worldwide.<br>&nbsp;<br>- <strong>Update Existing Languages</strong>: Existing language options can be updated to reflect changes in translations, regional language standards, or preferences, ensuring that the system stays relevant and user-friendly in all supported languages.<br>&nbsp;<br>- <strong>Delete Unused Languages</strong>: Administrators can remove language options that are no longer needed, streamlining the user interface and preventing unnecessary clutter.</p><p>This feature ensures the document management system can cater to a diverse, global audience while providing the flexibility to manage language options as needed.</p>'),
('66e6f68d-d051-4cc1-9b26-e3fcac4d6e6b', 'WORKFLOW_LOGS', 'Workflow Logs', '<ul><li><h3>Workflow List Page Overview</h3></li><li>The <strong>Workflow List Page</strong> provides a complete overview of all workflows, displaying their statuses and details to help users manage and monitor workflows effectively. It combines visual graphs and detailed information to ensure clarity and usability.</li><li><h4><strong>Key Features</strong></h4></li><li><strong>Comprehensive Workflow Display</strong>:<ul><li>All workflows are listed on this page, categorized by their statuses:<ul><li><strong>Completed</strong>: Workflows that have been fully executed.</li><li><strong>Initiated</strong>: Newly started workflows awaiting progress.</li><li><strong>In Progress</strong>: Ongoing workflows with steps and transitions in process.</li><li><strong>Cancelled</strong>: Workflows that were terminated before completion.</li></ul></li></ul></li><li><strong>Workflow Details in Graphical View</strong>:<ul><li>Workflows are visually represented using graphs, showcasing:<ul><li>The structure of steps and transitions.</li><li><strong>Completed Transitions</strong>: Clearly highlighted.</li><li><strong>Pending Transitions</strong>: Distinctly marked.</li></ul></li><li>This graphical format allows users to quickly understand the workflow’s progress and flow.</li></ul></li><li><strong>Workflow Information Table</strong>:<ul><li>Each workflow is accompanied by a table containing detailed information:<ul><li><strong>Workflow Name</strong>: Unique name of the workflow.</li><li><strong>Workflow Status</strong>: Current status of the workflow (Completed, Initiated, In Progress, Cancelled).</li><li><strong>Initiated By</strong>: The user who initiated the workflow.</li><li><strong>Document Name</strong>: The associated document, if applicable.</li><li><strong>Workflow Step</strong>: The current step(s) in the workflow.</li><li><strong>Workflow Step Status</strong>: Status of each step (Completed, Pending).</li><li><strong>Performed By</strong>: The user or team responsible for a specific step.</li><li><strong>Transition Status</strong>: Indicates the progress of transitions (Completed or Pending).</li></ul></li></ul></li><li><strong>Interactive Details</strong>:<ul><li>Users can click on workflow steps or transitions in the graph or table to access:<ul><li>Detailed descriptions.</li><li>Status history.</li><li>Timestamps and related actions.</li></ul></li></ul></li><li><h3>Benefits</h3></li><li>The <strong>Workflow List Page</strong> provides a holistic view of all workflows, their statuses, and detailed progress information. This ensures users can:</li><li>Track and manage all workflows efficiently.</li><li>Monitor progress visually and in detail.</li><li>Quickly identify completed, pending, or cancelled workflows.</li><li>This page is an essential tool for streamlining workflow operations and ensuring process transparency.</li></ul>'),
('762a5894-0c49-48d8-9e0c-e5062a4c3322', 'SEND_EMAIL', 'Send mail', '<ul><li><strong>How to Send a Document as an Email Attachment:</strong></li><li><strong>Select the email field</strong>: Navigate to the section where you can compose an email and select the field for entering the recipient\'s email address.</li><li><strong>Enter the email address</strong>: Type the recipient\'s email address in the provided field.</li><li><strong>Subject field</strong>: Enter a relevant subject for your email.</li><li><strong>Email content</strong>: Write the body of your email, providing any necessary context or information.</li><li><strong>Attach the document</strong>: Find the option to \"Attach\" or \"Upload\" a document, then select the file you wish to send.</li><li><strong>Send the email</strong>: After attaching the document and ensuring the recipient, subject, and content are correct, click the \"Send\" button to deliver the email with the attached document.</li></ul>');
INSERT INTO `pageHelper` (`id`, `code`, `name`, `description`) VALUES
('8c1e5b05-0d7e-45cc-973d-423b2e10c5fd', 'SHARE_DOCUMENT', 'Share Document', '<h4>Overview</h4><p>The <strong>Share Document</strong> feature allows users to assign access permissions to specific documents for individual users or user roles, with the ability to manage these permissions effectively. Users can also remove existing permissions, enhancing collaboration and control over document access.</p><h4>Features</h4><ol><li><strong>Assign By Users and Assign By Roles</strong><ul><li><strong>Buttons:</strong><ul><li>Two separate buttons are available at the Top of the share document section:<ul><li><strong>Assign By Users:</strong> Opens a dialog for selecting individual users to share the document with.</li><li><strong>Assign By Roles:</strong> Opens a dialog for selecting user roles to share the document with.</li></ul></li></ul></li><li><strong>User/Roles List:</strong><ul><li>Below the buttons, a list displays users or roles who currently have document permissions, including details such as:</li><li>Delete Button( Allow to delete existing permission to user or role)<ul><li>User/Role Name</li><li>Type (User/Role)</li><li>Allow Download(if applicable)</li><li>Email(if applicable)</li><li>Start Date (if applicable)</li><li>End Date (if applicable)</li><li> </li><li><strong>Delete Button:</strong> A delete button next to each user/role in the list, allowing for easy removal of permissions.</li></ul></li></ul></li></ul></li><li><strong>Dialog for Selection</strong><ul><li><strong>Dialog Features:</strong><ul><li>Upon clicking either <strong>Assign By Users</strong> or <strong>Assign By Roles</strong>, a dialog opens with the following features:<ul><li><strong>User/Role Selection:</strong><ul><li>A multi-select dropdown list allows users to select multiple users or roles for sharing the document.</li></ul></li><li><strong>Additional Options:</strong><ul><li><strong>Share Duration:</strong> Users can specify a time period for which the document will be accessible (e.g., start date and end date). </li><li><strong>Allow Download:</strong> A checkbox option that allows users to enable or disable downloading of the document.</li><li><strong>Allow Email Notification:</strong>A checkbox option that, when checked, sends an email notification to the selected users/roles.<ul><li>If this option is selected, SMTP configuration must be set up in the application. If SMTP is not configured, an error message will display informing the user of the missing configuration.</li></ul></li></ul></li></ul></li></ul></li></ul></li><li><strong>Saving Shared Document Permissions</strong><ul><li><strong>Save Button:</strong><ul><li>A <strong>Save</strong> button within the dialog allows users to save the selected permissions.</li></ul></li><li><strong>Reflection of Changes:</strong><ul><li>Upon saving, the data is updated, and the list at the bottom of the main interface reflects the newly shared document permissions, showing:<ul><li>User/Role Name</li><li>Type (User/Role)</li><li>Allow Download(if applicable)</li><li>Email(if applicable)</li><li>Start Date (if applicable)</li><li>End Date (if applicable)</li><li>Whether download and email notification options are enabled</li></ul></li></ul></li></ul></li><li><strong>Removing Shared Permissions</strong><ul><li><strong>Delete Button Functionality:</strong><ul><li>Users can click the <strong>Delete</strong> button next to any user or role in the existing shared permissions list.</li><li><strong>Confirmation Dialog:</strong> A confirmation prompt appears to ensure that users intend to remove the selected permission. Users must confirm the action to proceed.</li></ul></li><li><strong>Updating the List:</strong><ul><li>Once confirmed, the shared permission for the selected user or role is removed from the list, and the list updates immediately to reflect this change.</li></ul></li></ul></li><li><strong>User Interaction Flow</strong><ul><li><strong>Navigating to Share Document:</strong><ul><li>Users access the <strong>Share Document</strong> section within the application.</li></ul></li><li><strong>Assigning Permissions:</strong><ul><li>Users click on <strong>Assign By Users</strong> or <strong>Assign By Roles</strong> to open the respective dialog.</li><li>They select the appropriate users or roles, configure additional options, and click <strong>Save</strong>.</li></ul></li><li><strong>Removing Permissions:</strong><ul><li>Users can remove permissions by clicking the <strong>Delete</strong> button next to an entry in the shared permissions list and confirming the action.</li></ul></li><li><strong>Reviewing Shared Permissions:</strong><ul><li>The updated list displays the current permissions, allowing users to verify and manage document sharing effectively.</li></ul></li></ul></li></ol><h3>Summary</h3><p>The <strong>Share Document</strong> functionality provides a structured interface for assigning and managing document permissions to individual users or roles, with added flexibility to remove existing permissions. This feature enhances document collaboration and control while ensuring users can efficiently manage access. The inclusion of SMTP configuration checks for email notifications adds robustness to the communication aspect of the document-sharing process.</p>'),
('8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'DOCUMENT_SIGNATURE', 'DOCUMENT_SIGNATURE', '<p><strong>Document Signature Functionality</strong></p><p>The <strong>Document Signature</strong> feature allows users to digitally sign documents with ease. This functionality is designed to make the process simple, secure, and efficient, eliminating the need for printing and manual signatures.</p><h3>How It Works:</h3><ol><li><strong>Initiating the Signature Process:</strong><ul><li>Users can click on the <strong>\"Document Signature\"</strong> button for any document.</li><li>A <strong>popup window</strong> opens, providing options to add a signature.</li></ul></li><li><strong>Applying the Signature:</strong><ul><li>Users can <strong>draw</strong> their signature using a touchscreen or mouse.</li><li>Alternatively, they can <strong>type</strong> their name and choose from various font styles to create a professional-looking signature.</li><li>The signature can be placed anywhere on the document by dragging it to the desired location.</li></ul></li><li><strong>Additional Functionalities:</strong><ul><li><strong>PDF Signature Integration:</strong> Users can directly sign PDFs without converting file formats.</li><li>The <strong>Company Profile</strong> section allows users to include their company details, such as &nbsp;in the PDF signature.</li></ul></li></ol><h3>Key Features:</h3><ul><li><strong>Interactive and User-Friendly:</strong> The popup makes it easy to apply signatures in just a few clicks.</li><li><strong>Professional Branding:</strong> Integrate company details with your signature for added authenticity.</li><li><strong>Secure Signing:</strong> Digital signatures are encrypted to ensure document integrity.</li><li><strong>Flexibility:</strong> Customize the signature and include additional annotations like dates or initials.</li></ul><h3>Benefits:</h3><ul><li><strong>Streamlined Workflow:</strong> Quickly sign and finalize documents without printing or scanning.</li><li><strong>Enhanced Professionalism:</strong> Signatures with company branding make documents look polished and credible.</li><li><strong>Secure and Reliable:</strong> All signed documents are protected with advanced encryption to ensure they remain tamper-proof.</li></ul><p>With the <strong>Document Signature</strong> feature, signing documents becomes fast, professional, and secure, offering users the flexibility and tools they need to manage their documents seamlessly.</p>'),
('955ec3bf-5ec3-40be-b998-542a28e93369', 'CURRENT_WORKFLOWS', ' Current Workflows', '<ul><li><h3>Current Workflow Page Overview</h3></li><li>The <strong>Current Workflow Page</strong> provides users with a personalized view of workflows they have rights to manage or view. This page displays only the workflows associated with the user, ensuring they can easily track and manage their tasks.</li><li><h4><strong>Key Features</strong></h4></li><li><strong>User-Specific Workflow Display</strong>:<ul><li>This page shows <strong>only the workflows</strong> that the user has permission to access and manage.</li><li>The workflows are categorized based on their statuses:<ul><li><strong>Completed</strong>: Workflows that the user has finished or completed steps for.</li><li><strong>Initiated</strong>: Workflows the user has started but are awaiting further progress.</li><li><strong>In Progress</strong>: Workflows where the user is actively involved in ongoing steps.</li><li><strong>Cancelled</strong>: Workflows the user has been part of that were cancelled before completion.</li></ul></li></ul></li><li><strong>Workflow Details in Graphical View</strong>:<ul><li>The workflows are represented graphically to show:<ul><li>The flow of steps and transitions.</li><li><strong>Completed Transitions</strong>: Clearly marked for easy recognition.</li><li><strong>Pending Transitions</strong>: Distinctly highlighted to indicate remaining tasks.</li></ul></li></ul></li><li><strong>Workflow Information Table</strong>:<ul><li>For each workflow, users can view detailed information, including:<ul><li><strong>Workflow Name</strong>: Unique name of the workflow.</li><li><strong>Workflow Status</strong>: Current status (Completed, Initiated, In Progress, Cancelled).</li><li><strong>Initiated By</strong>: The user who initiated the workflow.</li><li><strong>Document Name</strong>: Associated document, if applicable.</li><li><strong>Workflow Step</strong>: The current step(s) the user is involved in.</li><li><strong>Workflow Step Status</strong>: Status of each step (Completed, Pending).</li><li><strong>Performed By</strong>: User(s) responsible for the steps.</li><li><strong>Transition Status</strong>: Whether transitions are completed or pending.</li></ul></li></ul></li><li><strong>Interactive Details</strong>:<ul><li>Users can click on any step or transition to access:<ul><li>Detailed information about that step/transition.</li><li>History and status of the action.</li><li>Relevant timestamps and actions taken.</li></ul></li></ul></li><li><h3>Benefits</h3></li><li>The <strong>Current Workflow Page</strong> is designed for users to have a focused, user-specific view of workflows they have rights to manage. This ensures:</li><li><strong>Personalized Workflow Management</strong>: Only workflows the user is authorized to access are shown.</li><li><strong>Efficient Tracking</strong>: Users can easily track progress of workflows they’re involved in.</li><li><strong>Clear Visibility</strong>: Understanding of the workflow status, transitions, and who is performing each step.</li><li>This page provides a secure and streamlined experience for users to manage their assigned workflows effectively.</li></ul>'),
('99955bd2-fed3-4951-bce7-d0717118e065', 'WORKFLOWS', 'All Workflows', '<ul><li><h3>Workflow List Page Overview</h3></li><li>The <strong>Workflow List Page</strong> provides a complete overview of all workflows, displaying their statuses and details to help users manage and monitor workflows effectively. It combines visual graphs and detailed information to ensure clarity and usability.</li><li><h4><strong>Key Features</strong></h4></li><li><strong>Comprehensive Workflow Display</strong>:<ul><li>All workflows are listed on this page, categorized by their statuses:<ul><li><strong>Completed</strong>: Workflows that have been fully executed.</li><li><strong>Initiated</strong>: Newly started workflows awaiting progress.</li><li><strong>In Progress</strong>: Ongoing workflows with steps and transitions in process.</li><li><strong>Cancelled</strong>: Workflows that were terminated before completion.</li></ul></li></ul></li><li><strong>Workflow Details in Graphical View</strong>:<ul><li>Workflows are visually represented using graphs, showcasing:<ul><li>The structure of steps and transitions.</li><li><strong>Completed Transitions</strong>: Clearly highlighted.</li><li><strong>Pending Transitions</strong>: Distinctly marked.</li></ul></li><li>This graphical format allows users to quickly understand the workflow’s progress and flow.</li></ul></li><li><strong>Workflow Information Table</strong>:<ul><li>Each workflow is accompanied by a table containing detailed information:<ul><li><strong>Workflow Name</strong>: Unique name of the workflow.</li><li><strong>Workflow Status</strong>: Current status of the workflow (Completed, Initiated, In Progress, Cancelled).</li><li><strong>Initiated By</strong>: The user who initiated the workflow.</li><li><strong>Document Name</strong>: The associated document, if applicable.</li><li><strong>Workflow Step</strong>: The current step(s) in the workflow.</li><li><strong>Workflow Step Status</strong>: Status of each step (Completed, Pending).</li><li><strong>Performed By</strong>: The user or team responsible for a specific step.</li><li><strong>Transition Status</strong>: Indicates the progress of transitions (Completed or Pending).</li></ul></li></ul></li><li><strong>Interactive Details</strong>:<ul><li>Users can click on workflow steps or transitions in the graph or table to access:<ul><li>Detailed descriptions.</li><li>Status history.</li><li>Timestamps and related actions.</li></ul></li></ul></li><li><h3>Benefits</h3></li><li>The <strong>Workflow List Page</strong> provides a holistic view of all workflows, their statuses, and detailed progress information. This ensures users can:</li><li>Track and manage all workflows efficiently.</li><li>Monitor progress visually and in detail.</li><li>Quickly identify completed, pending, or cancelled workflows.</li><li>This page is an essential tool for streamlining workflow operations and ensuring process transparency.</li></ul>'),
('a1c28412-9590-4cdb-b7a0-1687e890ad5d', 'ADD_REMINDER', 'Add reminder', '<p><strong>The \"Add Reminder\" functionality in the \"Manage Reminders\" section allows users to create reminders or notifications related to specific events or tasks. These reminders can be customized according to the user \'s needs and can be sent to specific other users.</strong></p><p><strong>Components and Features:</strong></p><ul><li><strong>Subject:</strong> This field allows the user to enter a title or theme for the reminder. This will be the main subject of the notification.</li><li><strong>Message:</strong> Here, users can add additional details or information related to the reminder. This can be a descriptive message or specific instructions.</li><li><strong>Repeat Reminder:</strong> This option allows setting the frequency with which the reminder will be repeated, such as daily, weekly, or monthly.</li><li><strong>Send Email:</strong> If this option is enabled, the reminder will also be sent as an email to the selected users.</li><li><strong>Select Users:</strong> This field allows the selection of users to whom the reminder will be sent. Users can be selected individually or in groups.</li><li><strong>Reminder Date:</strong> This is the time at which the reminder will be activated and sent to the selected users.</li></ul><p><strong>How to Add a New Reminder:</strong></p><ul><li>; to the \"Manage Reminders\" section.</li><li>Click the \"Add Reminder\" button.</li><li>Fill in all required fields with the desired information.</li><li>After entering all the details, click \"Save\" or \"Confirm\" to add the reminder to the system.</li></ul>'),
('a3664127-34f1-494c-84c5-fc3f307a9d11', 'USER_PAGE_PERMISSION_TO', 'User Page Permission To', '<ul><li>Enable the ability to assign specific permissions to users that are not tied to their assigned roles. This gives admins the flexibility to grant access to particular features for individual users.</li><li>Click <strong>\"Save\"</strong> or <strong>\"Add\"</strong> to assign the user to the system with the specified permissions.</li></ul>'),
('ab28cf5c-0d89-4a52-a87b-359106897cba', 'MANAGE_EMAIL_SMTP_SETTING', 'Manage Email SMTP Setting', '<p>The <strong>\"Email SMTP Settings\"</strong> page within CMR DMS allows administrators to configure and manage the SMTP settings for sending emails. This ensures that emails sent from the system are correctly and efficiently delivered to recipients.</p><p><strong>Key Components:</strong></p><ul><li><p><strong>SMTP Settings Table:</strong> Displays all configured SMTP settings in a tabular format.</p><p>Each entry in the table includes details such as the username, host, port, and whether that configuration is set as the default.</p></li><li><p><strong>\"Add Settings\" Button:</strong> Allows administrators to add a new SMTP configuration.</p><p>Clicking the button opens a form where details like username, host, port, and the option to set it as the default configuration can be entered.</p></li></ul><p><strong>\"Add Settings\" Form:</strong></p><p>This form opens when administrators click the \"Add Settings\" button and includes the following fields:</p><ul><li><strong>Username:</strong> The username required for authentication on the SMTP server.</li><li><strong>Host:</strong> The SMTP server address.</li><li><strong>Port:</strong> The port on which the SMTP server listens.</li><li><strong>Is Default:</strong> A checkbox that allows setting this configuration as the default for sending emails.</li></ul><p><strong>How to Add a New SMTP Configuration:</strong></p><ol><li>Click the \"Add Settings\" button.</li><li>The \"Add Settings\" form will open, where you can enter the SMTP configuration details.</li><li>Fill in the necessary fields and select the desired options.</li><li>After completing the details, click \"Save\" or \"Add\" to add the configuration to the system.</li></ol>'),
('ad952065-0b4f-4712-ba70-43e0c3152c3c', 'CRON_JOB_LOGS', 'Cron Job Logs', '<h2>📋 <strong>Cron Job Logs – User Guide</strong></h2><p>The <strong>Cron Job Logs</strong> page provides a detailed overview of all automated background tasks scheduled and executed by the system. These tasks help maintain, notify, and manage document workflows, reminders, and data retention policies without manual effort. This guide explains each job and its purpose to help users understand the system’s automation process.</p><h3>🔄 <strong>List of Scheduled Cron Jobs</strong></h3><h4>📅 <strong>Custom Date Reminder</strong></h4><p>Sends reminders based on user-defined custom dates set for documents or events. Ideal for special dates that don’t follow standard reminder frequencies.</p><h4>🗓️ <strong>Daily Notification Handler</strong></h4><p>Processes and sends out daily notifications to users, keeping them informed about document activities, pending actions, or scheduled events.</p><h4>🧹 <strong>Delete Archive Document By Retention Date</strong></h4><p>Automatically deletes archived documents that have exceeded their configured retention period to comply with data retention policies.</p><h4>🧾 <strong>Delete Email, Audit and Cron Job Logs</strong></h4><p>Cleans up old logs including email history, audit trails, and cron job executions after a defined period to ensure system performance and storage optimization.</p><h4>🗃️ <strong>Delete or Archive or Expire Document By Retention Date</strong></h4><p>Manages documents based on their retention configuration—automatically <strong>deleting</strong>, <strong>archiving</strong>, or <strong>expiring</strong> them as per rules defined in the retention settings.</p><h4>📆 <strong>Half Yearly Reminder</strong></h4><p>Sends notifications every six months to remind users of document reviews, renewals, or other periodic tasks.</p><h4>📅 <strong>Monthly Reminder</strong></h4><p>Sends monthly email reminders to assigned users or groups to take action on documents that require periodic attention.</p><h4>🗓️ <strong>Quarterly Reminder</strong></h4><p>Triggers every three months to notify users of scheduled document-related tasks or to prompt reviews.</p><h4>🛎️ <strong>Notification Scheduler</strong></h4><p>Central handler that coordinates all scheduled notifications (daily, weekly, etc.) to ensure they are sent at the right time with the right content.</p><h4>📤 <strong>Send Email</strong></h4><p>Responsible for sending emails queued by other jobs (like reminders or notifications). Ensures reliable and trackable delivery of communication from the system.</p><h4>📆 <strong>Weekly Reminder</strong></h4><p>Sends weekly emails about document actions, expiring records, or general reminders to keep users updated.</p><h4>🗓️ <strong>Yearly Reminder</strong></h4><p>Annual notifications for documents that require yearly reviews, renewals, or actions—commonly used for compliance or regulatory tasks.</p><h3>✅ <strong>Usage Tips</strong></h3><ul><li><strong>Monitor Execution</strong>: Check if each cron job is executing successfully or failing. Failures may require admin attention.</li><li><strong>Filter Logs</strong>: Use available filters to find logs by job name, status, or date.</li><li><strong>Audit Trail</strong>: This page acts as an audit trail for system automation—valuable for compliance reviews and troubleshooting.</li><li><strong>Retention Settings</strong>: Ensure retention rules are properly configured, as they directly influence deletion and archival jobs.</li></ul>'),
('b1c70caf-ce26-4dff-8f8a-aed4c8eab097', 'PAGE_HELPERS', 'Page Helpers', '<p>Users can manage the pages within the application using a user-friendly interface that displays a list of available pages. Each entry in the list includes options to <strong>Edit</strong> or <strong>View</strong> the corresponding page\'s details.</p><h4>Features</h4><ol><li><h4><strong>List of Pages</strong></h4><ul><li>Users can see a comprehensive list of all pages in the application, each with the following details:<ul><li><strong>Unique Code:</strong> A non-editable code for each page.</li><li><strong>Editable Name:</strong> An editable field that allows users to change the page name.</li><li><strong>Page Info Content:</strong> A section that displays the functionality description of each page.</li><li> </li></ul></li></ul></li><li><h4><strong>Edit Feature</strong></h4><ul><li><strong>Edit Button:</strong><ul><li>When a user clicks the <strong>Edit</strong> button next to a page, they are directed to an editable form.</li><li>Users can modify the page name and update the page info content to reflect any changes or improvements.</li><li><strong>Validation:</strong><ul><li>The form includes validation checks to ensure that the new name is unique and meets any defined requirements (e.g., length, special characters).</li></ul></li><li><strong>Save Changes:</strong><ul><li>Users can save the changes, which are then reflected in the list of pages and will persist across sessions.</li><li> </li></ul></li></ul></li></ul></li><li><h4><strong>View Feature</strong></h4><ul><li><strong>View Button:</strong><ul><li>Clicking the <strong>View</strong> button opens a dialog box displaying a preview of the page info content.</li><li>This preview includes  current page name, and detailed functionality description.</li><li><strong>Modal Dialog:</strong><ul><li>The dialog box is modal, meaning users cannot interact with the rest of the application until they close the dialog.</li><li>Users can close the dialog by clicking an \"X\" button or a \"Close\" button.</li></ul></li></ul></li></ul></li><li> <ul><li><h4><strong>Navigating to the Page List:</strong></h4><ul><li>Users can easily navigate to the page list through the main navigation menu.</li></ul></li><li><strong>Editing a Page:</strong><ul><li>Users select the <strong>Edit</strong> button next to the desired page, modify the name and content, and click <strong>Save</strong> to apply the changes.</li></ul></li><li><strong>Viewing a Page:</strong><ul><li>Users can click the <strong>View</strong> button to open the dialog box, review the details, and close the dialog when finished.</li></ul></li></ul></li></ol><h3>Summary</h3><p>This functionality empowers users to effectively manage page names and content within the application, ensuring that information is accurate and up-to-date. The combination of edit and view features enhances the user experience by allowing for quick modifications and easy access to page details.</p>'),
('b3dc6a76-6bd3-46ec-956c-eccef2df3eec', 'EXPIRED_DOCUMENTS', 'Expired Documents', '<p><strong>Expired Documents</strong> in a <strong>Document Management System</strong> automatically track and highlight files that have passed their defined expiration time. This helps maintain compliance, improves organization, and supports timely document lifecycle management.</p><h3>Key Features:</h3><ul><li><strong>Automated Tracking:</strong> The system automatically identifies and marks documents as expired based on predefined criteria.</li><li><strong>Notifications:</strong> Users receive alerts for expired documents, ensuring timely review and action.</li><li><strong>Reporting:</strong> Generate reports on expired documents for compliance and auditing purposes.</li></ul><h3>Benefits:</h3><ul><li><strong>Improved Compliance:</strong> Stay compliant with regulations by managing document lifecycles effectively.</li><li><strong>Enhanced Organization:</strong> Keep your document repository tidy by regularly reviewing and archiving expired files.</li><li><strong>Increased Efficiency:</strong> Reduce the risk of using outdated documents in critical processes.</li></ul>'),
('b99e45c1-9d9f-4b0e-80f0-906c7c830394', 'STORAGE_SETTINGS', 'Storage Settings', '<p><strong>Document Storage Settings</strong>:<br>Users can configure various storage options, including AWS S3 with specific fields required for each storage type. Additionally, there is a default option available for storing files on a local server. This local server setting cannot be deleted, ensuring a reliable and consistent storage option for users.</p><ol><li><strong>Enable Encryption</strong>: When selected, this option ensures that files are stored in encrypted form within the chosen storage.</li><li><strong>Set as Default</strong>: If this option is set to \"true,\" the storage becomes the default selection in the dropdown on the document add page.</li></ol><p>Upon saving the storage settings, the system attempts to upload a dummy file to verify the configuration. If the upload is successful, the settings are saved; otherwise, an error message prompts the user to adjust the field values.</p><ul><li><h4><strong>Add a new Storage Setting to the system.</strong></h4></li><li><strong>It includes the following fields:</strong></li><li><strong>Storage Type: </strong>AWS</li><li><strong>Access Key:</strong></li><li><strong>Secret Key:</strong></li><li><strong>Bucket Name:</strong></li><li><strong>Enable Encryption: </strong>When selected, this option ensures that files are stored in encrypted form within the chosen storage.</li><li><strong>Is Default:</strong> &nbsp;If this option is set to \"true,\" the storage becomes the default selection in the dropdown on the document add page.</li><li>&nbsp;</li><li><h4><strong>Edit Storage Setting to the system.</strong></h4></li><li>Users can edit existing storage settings from the storage settings list, which includes an edit button on the left side of each row. When the edit button is clicked, the row opens in edit mode, allowing users to modify the following fields: name, \"Is Default,\" and \"Enable Encryption.\" This provides users with the flexibility to update their storage configurations as needed.</li></ul><h4>CREATE AWS S3 ACCOUNT:</h4><p><a href=\"https://aws.amazon.com/free/?gclid=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE&amp;trk=b8b87cd7-09b8-4229-a529-91943319b8f5&amp;sc_channel=ps&amp;ef_id=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE:G:s&amp;s_kwcid=AL!4422!3!536324516040!e!!g!!aws%20s3%20account!11539706604!115473954714&amp;all-free-tier.sort-by=item.additionalFields.SortRank&amp;all-free-tier.sort-order=asc&amp;awsf.Free%20Tier%20Types=*all&amp;awsf.Free%20Tier%20Categories=*all\">https://aws.amazon.com/free/?gclid=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE&amp;trk=b8b87cd7-09b8-4229-a529-91943319b8f5&amp;sc_channel=ps&amp;ef_id=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE:G:s&amp;s_kwcid=AL!4422!3!536324516040!e!!g!!aws%20s3%20account!11539706604!115473954714&amp;all-free-tier.sort-by=item.additionalFields.SortRank&amp;all-free-tier.sort-order=asc&amp;awsf.Free%20Tier%20Types=*all&amp;awsf.Free%20Tier%20Categories=*all</a></p>'),
('c557fae0-ce8f-4b5d-99f1-70d293872340', 'WATERMARK_DOCUMENT', 'Add Watermark', '<h2><strong>Document Watermark</strong></h2><p>The Document Watermark feature allows users to protect and brand their documents by automatically applying text-based watermarks to PDF files. This ensures content security, prevents unauthorized use, and maintains a clear document history with versioning and audit tracking.</p><h2><strong>How It Works</strong></h2><h3><strong>1. Adding a Watermark</strong></h3><p>Users can open any document and click on the <strong>\"Add Watermark\"</strong> option.</p><p>A popup window appears, allowing the user to:</p><ul><li>Enter the desired watermark text (e.g., <i>“Confidential”</i>, <i>“Draft”</i>, <i>“Approved by John Doe”</i>, etc.).</li></ul><h3><strong>2. Automatic PDF Processing</strong></h3><p>Once the user confirms:</p><ul><li>The system automatically applies the watermark to the PDF file.</li><li>The watermark appears diagonally or in the chosen position across all pages.</li><li>A <strong>new version</strong> of the document is generated with the applied watermark.</li></ul><h3><strong>3. Audit &amp; Version Control</strong></h3><p>Every watermark action is logged in the system:</p><ul><li>Who added the watermark</li><li>The watermark text used</li><li>Date and time of the action</li><li>Version created after watermarking</li></ul><p>This ensures full traceability and compliance for document workflows.</p><h2><strong>Key Features</strong></h2><h3><strong>Easy and Intuitive</strong></h3><p>The popup interface makes it simple for users to enter watermark text and preview watermark options.</p><h3><strong>Automatic Placement</strong></h3><p>The system positions the watermark professionally across the PDF without requiring manual alignment.</p><h3><strong>Versioning Support</strong></h3><p>Each watermarked PDF is stored as a new version of the document, preserving the original and maintaining a history of all updates.</p><h3><strong>Audit Trail</strong></h3><p>Detailed logs capture all watermark activities for transparency and compliance.</p><h3><strong>Branding &amp; Security</strong></h3><p>Watermarks help prevent unauthorized distribution and clearly identify a document’s status or ownership.</p><h2><strong>Benefits</strong></h2><h3><strong>Improved Document Security</strong></h3><p>Watermarks discourage misuse, copying, and sharing of sensitive documents.</p><h3><strong>Professional Output</strong></h3><p>Automatically formatted watermarks make documents look clean, consistent, and ready for internal or external use.</p><h3><strong>Clear Document History</strong></h3><p>Versioning and audit logs ensure teams always know <strong>what was changed</strong>, <strong>when</strong>, and <strong>by whom</strong>.</p>'),
('cc0366a6-f40b-4f58-a07f-68dd041ca1f3', 'ARCHIVE_DOCUMENT_RETENTION_PERIOD', 'Archive Document Retention Period', '<p><strong>What is it?</strong><br>Archive Retention Period allows you to automatically move documents to the <strong>delete</strong> after a selected number of days.</p><p><strong>Retention Options:</strong><br>You can choose to automatically delete documents after:</p><p>30 days</p><p>60 days</p><p>90 days</p><p>180 days</p><p>365 days</p><p><strong>How it works:</strong><br>Once this setting is enabled:</p><p>The system will monitor the age of each document.</p><p>When a document reaches the selected retention period (e.g., 30 days), it will be <strong>automatically deleted</strong>.</p><p><i>Enabling this feature helps keep your workspace organized by removing old documents automatically.</i></p>'),
('d0e88580-71d2-4d74-b1ac-b9f34aec6818', 'DOCUMENT_CATEGORIES', 'Document Categories', '<p><strong>The \"Document Categories\" page serves as a centralized hub for managing and organizing Categories, which essentially represent the departments that work with the files. It offers a hierarchical structure, allowing the creation of main Categories and subCategories.</strong></p><h4><strong>Main Components:</strong></h4><p><strong>\"Add New Document Category\" Button:</strong></p><ul><li>Allows administrators or users with appropriate permissions to create a new Category or department.</li><li>Opens a form or a pop-up window where details like the Category name and description can be entered.</li></ul><p><strong>List of Existing Categories:</strong></p><ul><li>Displays all the Categories or departments created within the system.</li><li>Each entry includes the Category name and associated action options.</li></ul><p><strong>Action Menu for Each Category:</strong></p><ul><li>Next to each Category, users will find action options that allow them to manage the Category:<ul><li><strong>Edit:</strong> Enables modification of the Category\'s details, such as the name or description.</li><li><strong>Delete:</strong> Removes the Category from the system. This action may require confirmation to prevent accidental deletions.</li></ul></li></ul><p><strong>Double Arrow Button \">>\":</strong></p><ul><li>Located next to each main Category.</li><li>When clicked, it reveals the subCategories associated with the main Category.</li><li>Allows users to view and manage subCategories in a hierarchical manner.</li></ul><h4><strong>How to Add a New Category:</strong></h4><ol><li>Click on the \"Add New Document Category\" button.</li><li>A form or pop-up window will open.</li><li>Enter the Category name and description.</li><li>Click \"Save\" or \"Add\" to add the Category to the system.</li></ol><h4><strong>How to View SubCategories:</strong></h4><ol><li>Locate the main Category in the list.</li><li>Click on the double arrow button \">>\" next to the Category name.</li><li>The associated subCategories will be displayed beneath the main Category.</li></ol>'),
('d1ee0a7e-7962-46f5-a784-8be66fb58b51', 'AI_DOCUMENTS', 'AI Document Lists', '<h3>Overview</h3><p>This section allows you to view documents generated using OpenAI\'s AI. For each document, you can explore the original prompt that was used to generate the content, along with the full AI-generated output. This helps you understand how prompts shape responses and lets you track your creative or work process.</p><h3>🔍 How to Use</h3><h4>1. <strong>Accessing the Document List</strong></h4><ul><li>Navigate to the <strong>Generated Documents</strong> section from the main menu.</li><li>You’ll see a list of all documents generated by AI, including titles and creation dates.</li></ul><h4>2. <strong>Viewing a Document</strong></h4><ul><li>Click on any document in the list to open it.</li><li>You’ll see:<ul><li><strong>Prompt</strong> – The exact input (question or instruction) used to generate the document.</li><li><strong>Output</strong> – The AI-generated text based on the prompt.</li></ul></li></ul><h4>3. <strong>Understanding the Prompt-Output Pair</strong></h4><ul><li>Use this feature to:<ul><li>Learn how different prompts lead to different styles or content.</li><li>Refine your own prompt-writing skills.</li><li>Review previous outputs for reuse or inspiration.</li></ul></li></ul>'),
('d2abfc80-7dfb-49b6-bccf-44d75844f098', 'MANAGE_FILE_REQUEST', 'Manage File Request', '<h2>File Request Functionality</h2><p>The <strong>File Request</strong> feature simplifies document collection by allowing you to generate unique links, share them with users, and review uploaded documents. Here\'s how it works:</p><h2>Key Features:</h2><p><strong>1.Generate Link</strong>:</p><ul><li>Create a unique link for a file request.</li><li>Share this link with users to allow them to upload the required documents.</li></ul><p><strong>2.Upload Documents</strong>:</p><p>Users can upload documents directly via the link you provide.</p><p>You can set the following parameters when creating a request:</p><p><strong>Maximum File Size Upload</strong>: Specify the largest file size allowed per upload.</p><p><strong>Maximum Document Upload</strong>: Limit the number of documents a user can upload.</p><ul><li><strong>Allowed File Extensions</strong>: Restrict uploads to specific file types (e.g., PDF, DOCX, JPG).</li></ul><p><strong>3.Review and Manage Requests</strong>:</p><ul><li>View all submissions on the <strong>File Request List</strong> page.</li><li>Approve or reject uploaded documents as necessary.</li></ul><p><strong>4.Request Data List</strong>:<br>Each file request includes the following details:</p><ul><li><strong>Subject</strong>: The purpose or title of the request.</li><li><strong>Email</strong>: The email address associated with the request.</li><li><strong>Maximum File Size Upload</strong>: The size limit for uploaded files.</li><li><strong>Maximum Document Upload</strong>: The number of documents users can upload.</li><li><strong>Allowed File Extensions</strong>: The types of files users can upload.</li><li><strong>Status</strong>: The current status of the request (e.g., Pending, Approved, Rejected).</li><li><strong>Created By</strong>: The user who created the request.</li><li><strong>Created Date</strong>: The date the request was created.</li><li><strong>Link Expiration</strong>: The date the link will no longer be valid.</li></ul><p><strong>5.Manage Requests</strong>:<br>For each file request, you can:</p><ul><li><strong>Edit</strong>: Update the details of the request, such as file size, document limits, or expiration date.</li><li><strong>Delete</strong>: Remove the request entirely.</li><li><strong>Copy Link</strong>: Copy the link to share it with others.</li></ul><h2>How It Works:</h2><h3>1. Creating a File Request:</h3><ul><li>Navigate to the <strong>File Request</strong> page and click Create New Request. </li><li>Enter details like the subject, allowed file extensions, and upload limits.</li><li>Generate the link and share it with the intended user.</li></ul><h3>2. Uploading Documents:</h3><ul><li>The user clicks the link and uploads their documents according to the criteria you set.</li></ul><h3>3. Reviewing Submissions:</h3><ul><li>Go to the <strong>File Request List</strong> page to view submitted documents.</li><li>Approve or reject submissions as required.</li></ul><h3>4. Managing Links:</h3><ul><li>Use the <strong>Edit</strong> or <strong>Delete</strong> options to modify or remove requests.</li><li>Copy the link anytime for reuse or sharing.</li></ul>'),
('d6e392a9-b180-4c68-8566-6f289150a226', 'ADD_DOCUMENT', 'Manage document', '<ul><li><strong>Allows users to upload and add a new document to the system.</strong></li><li>It includes the following fields:</li><li><strong>Upload Document:</strong> An option to upload the document file.</li><li><strong>Category:</strong> The Category under which the document is classified.</li><li><strong>Name:</strong> The name of the document.</li><li><strong>Status:</strong> The status of the document (e.g., confidential or public).</li><li><strong>Description:</strong> A detailed description or additional notes related to the document.</li><li><strong>Meta Tags:</strong> Tags or keywords associated with the document for easier searching.</li></ul>'),
('d8506639-f4ec-42d8-9939-bae893abef57', 'ROLES', 'Roles', '<p><strong>The \"User Roles\" page is essential for managing and defining permissions within the CMR DMS. Roles represent predefined sets of permissions that can be assigned to users, ensuring that each user has access only to the functionalities and documents appropriate to their position and responsibilities within the organization.</strong></p><h3><strong>Main Components:</strong></h3><p><strong>\"Add Roles\" Button:</strong></p><ul><li>Allows administrators or users with appropriate permissions to create a new role in the system.</li><li>Opens a form or pop-up window where the role’s permissions and details can be defined.</li></ul><p><strong>List of Existing Roles:</strong></p><ul><li>Displays all roles created within the system in a tabular format.</li><li>Each entry includes the role name and associated action options.</li></ul><p><strong>Action Menu for Each Role:</strong></p><ul><li>Includes options for \"Edit\" and \"Delete.\"<ul><li><strong>Edit:</strong> Allows modification of the role\'s details and permissions.</li><li><strong>Delete:</strong> Removes the role from the system. This action may require confirmation to prevent accidental deletions.</li></ul></li></ul><p><strong>Role Creation Page:</strong></p><ul><li>Here, administrators can define specific permissions for each role.</li><li>Permissions can include rights such as viewing, editing, deleting, or sharing documents, managing users, defining Categories, and more.</li><li>Once permissions are set, they can be saved to create a new role or update an existing one.</li></ul><h3><strong>How to Add a New Role:</strong></h3><ol><li>Click on the \"Add Roles\" button.</li><li>A form or pop-up window will open.</li><li>Enter the role name and select the appropriate permissions from the available list.</li><li>Click \"Save\" or \"Add\" to add the role to the system with the specified permissions.</li></ol>'),
('d96ee5aa-4253-4a28-ba61-94b15b6cbfae', 'VERSION_HISTORY', 'Document versions', '<p><strong>Uploading a New Version of the Document:</strong></p><p>Allows users to upload an updated or modified version of an existing document.</p><p>It includes the following fields:</p><ul><li><strong>Upload a New Version:</strong> A dedicated section for uploading a new version of the document.</li><li><strong>Restore previous version document to current version : </strong>When a user restores a previous version as the current document, the existing current document is automatically added to the document history. The restored document then becomes the active current document, ensuring effective version control and easy tracking of changes</li><li><strong>Upload Document:</strong> An option to upload the document file. Users can select the file they want to upload, and the text \"No file chosen\" will appear until a file is selected.</li><li><strong>View Document</strong>:<br>This feature provides users with the ability to preview previous versions of a document. Users can easily access and review any earlier version, allowing for better assessment and comparison before deciding to restore or make further edits.</li></ul><p><strong>How to Upload a New Version of the Document:</strong></p><ol><li>Navigate to the \"All Documents\" page.</li><li>Select the document for which you want to upload a new version.</li><li>Click on the \"Upload a New Version\" option or a similar button.</li><li>A dedicated form will open where you can select and upload the appropriate file.</li><li>After uploading the file, click \"Save\" or \"Add\" to update the document in the system with the new version.</li></ol>'),
('dd0c9840-b7c6-4a51-b78a-e674918ff7e5', 'NOTIFICATIONS', 'Notifications', '<ul><li><strong>Document Shared Notification</strong>:<ul><li>Sends real-time notifications to users when a document is shared with them.</li><li>Notifications are sent via email and in-app, with details about the shared document, including name, category, and shared user.</li><li>For documents shared with external users, the recipient is notified with a secure link to access the document.</li></ul></li><li><strong>Reminder Notifications</strong>:<ul><li>Sends reminders to users for upcoming deadlines or actions related to documents (e.g., review deadlines or document expiration).</li><li>Users can configure reminder frequency and set specific reminders for important documents.</li><li>Reminders are delivered via both email and in-app notifications.</li></ul></li></ul><p>&nbsp;</p>'),
('dd217b6b-b332-44ef-bc09-2fb68d9b0d79', 'DOCUMENT_STATUS', 'Document Status', '<h3>Document Status</h3><p>Document status is a feature that allows you to manage the lifecycle of your documents. You can set different statuses for your documents, such as:</p><ul><li>Draft</li><li>Final</li><li>Archived</li></ul><p>This helps you keep track of the current state of each document and ensures that only the right people have access to them.</p>'),
('ec6b2368-b8fd-4101-addf-5dec7c1d1c63', 'SHAREABLE_LINK', 'Shareable Link', '<ul><li><strong>Shareable Link</strong>:<br>This feature allows users to share documents with anonymous users through a customizable link. Users have the flexibility to configure various options when creating a shareable link, including:<ul><li><strong>Start and Expiry Dates</strong>: Specify the validity period for the link, defining when it becomes active and when it expires.</li><li><strong>Password Protection</strong>: Optionally set a password to restrict access to the shared document.</li><li><strong>Download Permission</strong>: Choose whether recipients are allowed to download the document.</li></ul></li></ul><p>All options are optional, allowing users to customize the shareable link according to their preferences and requirements.</p>'),
('eccba93d-48bb-48f6-9784-14968d8843c8', 'MANAGE_USER', 'Manage User', '<p>The User Information page is designed to collect and manage your personal details. This page is essential for setting up your user profile and ensuring you have a seamless experience using our application. Below is a brief overview of the fields you willl encounter:</p><h4><strong>Fields on the User Information Page</strong></h4><ol><li><strong>First Name</strong>:<ul><li><strong>What it is</strong>: Your given name.</li><li><strong>Importance</strong>: Helps us address you properly within the application.</li></ul></li><li><strong>Last Name</strong>:<ul><li><strong>What it is</strong>: Your family name or surname.</li><li><strong>Importance</strong>: Completes your identity and is often required for official documents.</li></ul></li><li><strong>Mobile Number</strong>:<ul><li><strong>What it is</strong>: Your phone number.</li><li><strong>Importance</strong>: Used for account recovery, notifications, and two-factor authentication. It’s optional but recommended for security purposes.</li></ul></li><li><strong>Email Address</strong>:<ul><li><strong>What it is</strong>: Your electronic mail address.</li><li><strong>Importance</strong>: Serves as your primary communication channel with us. It’s required for account verification, notifications, and password recovery.</li></ul></li><li><strong>Password</strong>:<ul><li><strong>What it is</strong>: A secret word or phrase you create to secure your account.</li><li><strong>Importance</strong>: Protects your account from unauthorized access. It must be at least 6 characters long.</li></ul></li><li><strong>Confirm Password</strong>:<ul><li><strong>What it is</strong>: A second entry of your chosen password.</li><li><strong>Importance</strong>: Ensures you’ve entered your password correctly.</li></ul></li><li><strong>Role</strong>:<ul><li><strong>What it is</strong>: Your assigned position or function within the application (e.g., Admin, User, Editor).</li><li><strong>Importance</strong>: Determines your access level and permissions within the application. This field is required to define your responsibilities and capabilities.</li></ul></li></ol><h4><strong>How to Use the Page</strong></h4><ul><li><strong>Filling Out the Form</strong>:<ul><li>Enter your information in the required fields.</li><li>Ensure that your password and confirm password entries match to avoid any errors.</li></ul></li><li><strong>Submitting Your Information</strong>:<ul><li>Once you have filled in all required fields, click the \\\'submit\' button.</li><li>If any required fields are left blank or contain errors, you willl see helpful messages prompting you to correct them.</li></ul></li><li><strong>Visual Feedback</strong>:<ul><li>Fields that require your attention will be highlighted, and error messages will guide you in making the necessary corrections.</li></ul></li></ul>'),
('ee4f69f1-1ed7-4447-87d4-c43a0b0f92e0', 'UPLOAD_NEW_VERSION', 'Upload version file', '<p><strong>How to Upload a New Version of a Document:</strong></p><ol><li>Navigate to the \"All Documents\" page.</li><li>Select the document for which you want to upload a new version.</li><li>Click on the option \"Upload a New Version\" or a similar button.</li><li>A dedicated form will open, allowing you to select and upload the appropriate file.</li><li>After uploading the file, click \"Save\" or \"Add\" to update the document in the system with the new version.</li></ol>');
INSERT INTO `pageHelper` (`id`, `code`, `name`, `description`) VALUES
('f5cecacd-f0e6-45b3-8de2-348d8ec29556', 'LOGIN_AUDIT_LOGS', 'Audit logs', '<p><strong>The \"Login Audit Logs\" page serves as a centralized record for all authentication activities within CMR DMS. Here, administrators can monitor and review all login attempts, successful or failed, made by users. This provides a clear perspective on system security and user activities.</strong></p><p><strong>Main Components:</strong></p><ul><li><p><strong>Authentication Logs Table:</strong> Displays all login entries in a tabular format.</p><p>Each entry includes details such as the username, login date and time, the IP address from which the login was made, and the result (success/failure).</p></li></ul><p><strong>How to View Log Entries:</strong></p><ol><li>Navigate to the \"Login Audit Logs\" page.</li><li>Browse through the table to view all login entries.</li><li>Use the search or filter function, if available, to find specific entries.</li></ol>'),
('f6a1faa6-7245-4f9f-ad17-5478677bedfb', 'DOCUMENTS_BY_CATEGORY', 'Documents by Category', '<p>The <strong>Homepage</strong> provides an overview of the documents within the system, showcasing statistics related to the number of documents organized by Category. It is the ideal place to quickly obtain a clear view of the volume and distribution of documents in the DMS.</p><h3>Main Components:</h3><ol><li><strong>Document Statistics</strong>:<ul><li>Displays a numerical summary of all the documents in the system, organized by Category.</li><li>Each Category is accompanied by a number indicating how many documents are in that Category.</li></ul></li><li><strong>\"Document Categories\" List</strong>:<ul><li>Shows the different document Categories available in the system, such as:<ul><li>\"Professional-Scientific_and_Education\"</li><li>\"HR Policies 2021\"</li><li>\"Professional1\"</li><li>\"Initial Complaint\"</li><li>\"HR Policies 2020\"</li><li>\"Studies_and_Strategies\"</li><li>\"Administrative_and_Financial\"</li><li>\"Approvals\"</li><li>\"Jurisdiction Commission\"</li></ul></li><li>Next to each Category, the number of documents is displayed, providing a clear view of the document distribution across Categories.</li></ul></li></ol><h3>How to interpret the statistics:</h3><ol><li>Navigate to the <strong>Statistics</strong> section on the <strong>Homepage</strong>.</li><li>View the total number of documents for each Category.<ul><li>These numbers give you an idea of the volume of documents in each Category and help identify which Categories have the most or fewest documents.</li></ul></li></ol>'),
('fa5c186a-ed5d-40b0-858e-34cf03a1866f', 'PROMPT_TEMPLATE', 'AI Prompt Template', '<h2>💡 How Prompt Templates Work</h2><p>Prompt templates make it easy to create AI-generated content quickly and consistently.</p><h3>🧩 What is a Prompt Template?</h3><p>A prompt template is a ready-to-use sentence with placeholders (like **description**) that you can fill in with your own content. The AI then uses your completed prompt to generate a response.</p><h3>✨ How to Use:</h3><ol><li><p><strong>Choose a Template</strong><br>Select from a list of available prompt templates, such as:</p><blockquote><p>Answer this email content: **description**.</p></blockquote></li><li><p><strong>Fill in the Blank</strong><br>After selecting a template, the system will ask you to enter a value for each placeholder (e.g., description).<br>Example:</p><blockquote><p><i>I’m unable to attend the meeting due to a personal emergency.</i></p></blockquote></li><li><p><strong>Generate the Final Prompt</strong><br>The system will automatically replace the placeholder with your input:</p><blockquote><p>Answer this email content: I’m unable to attend the meeting due to a personal emergency.</p></blockquote></li><li><strong>Get Your Result</strong><br>The AI will process the completed prompt and generate the content for you.</li></ol>'),
('fac2acd8-1cc9-4722-a7e8-b2c297a37b7f', 'MANAGE_WORKFLOW', 'Manage Workflow', '<ul><li><h3><strong>Manage Workflow Overview</strong></h3></li><li>The <strong>Manage Workflow</strong> feature allows users to efficiently create, edit, and customize workflows as needed. This functionality is designed to ensure flexibility and control over workflow management. Here\'s how it works:</li><li><h4><strong>Creating a Workflow</strong></h4></li><li>If no workflows have been created, users can start by building a new workflow:</li><li><strong>Define Workflow Details</strong>: Provide a unique name and description for the workflow.</li><li><strong>Add Workflow Steps</strong>: Create the necessary steps that outline the workflow process.</li><li><strong>Set Workflow Transitions</strong>: Define the transitions between steps, specifying conditions or rules for movement.</li><li>Once the workflow is created, users can manage and update it as required.</li><li><h4><strong>Editing an Existing Workflow</strong></h4></li><li>For workflows that have already been created, users have the ability to make updates:</li><li><strong>Edit Workflow Name</strong>: Change the name of the workflow to reflect new requirements or corrections.</li><li><strong>Edit Workflow Step Name</strong>: Modify the names of individual steps within the workflow to ensure clarity or adjust for changes.</li><li><strong>Edit Workflow Transition Name</strong>: Update the names or rules for transitions between workflow steps as needed.</li><li><h3>Flexibility in Management</h3></li><li>The <strong>Manage Workflow</strong> feature is versatile, allowing users to either:</li><li><strong>Create a new workflow</strong> if none exist, or</li><li><strong>Edit an existing workflow</strong> to adapt to evolving needs.</li></ul>');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `createdBy` varchar(255) DEFAULT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`, `order`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('05edb281-cddb-4281-9ab3-fb90d1833c82', 'Archived Documents', 4, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('090ea443-01c7-4638-a194-ad3416a5ea7a', 'Role', 7, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'Deep Search', 4, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('2396f81c-f8b5-49ac-88d1-94ed57333f49', 'Document Audit Trail', 5, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('2e3c07a4-fcac-4303-ae47-0d0f796403c9', 'Email', 8, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('324bdc51-d71f-4f80-9f28-a30e8aae4009', 'User', 6, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('34328287-3a37-4c70-ac61-b291c3ef5ade', 'CLIENT', 10, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('42e44f15-8e33-423a-ad7f-17edc23d6dd3', 'Dashboard', 1, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST', 8, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'ALL_WORKFLOWS', 7, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('5a5f7cf8-21a6-434a-9330-db91b17d867c', 'Document Category', 4, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('637f010e-3397-41a9-903a-21d54db5e49a', 'AI_DOCUMENTS', 3, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('655f0bcd-676d-49fc-ba30-24c39c853e16', 'MY_WORKFLOWS', 9, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8384e302-eaf1-4a0b-b293-a921b1e9e36a', 'BULK_DOCUMENT_UPLOADS', 4, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_SETTINGS', 7, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8740dd7a-7bca-442f-b50f-6cdf0fcaf7bd', 'DOCUMENT_STATUS', 10, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'Settings', 9, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'Reminder', 9, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('b0a1d2e3-f4g5-h6i7-j8k9-l0m1n2o3p4q5', 'BOARDS', 100, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 16:37:57', '2026-02-07 16:37:57', NULL),
('b2c3d4e5-6f7g-8h9i-0j1k-2l3m4n5o6p7q', 'WORKFLOW_LOGS', 7, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'Expired Documents', 6, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('cfa38ae7-b5ba-4881-9199-d2914d7fd58e', 'Page Helper', 14, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'All Documents', 2, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('f042bbee-d15f-40fb-b79a-8368f2c2e287', 'Logs', 10, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:04', NULL),
('fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'Assigned Documents', 3, '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, 0, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quarterlyReminders`
--

CREATE TABLE `quarterlyReminders` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `day` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `quarter` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminderNotifications`
--

CREATE TABLE `reminderNotifications` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fetchDateTime` datetime NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `isEmailNotification` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `id` char(36) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `dayOfWeek` int(11) DEFAULT NULL,
  `isRepeated` tinyint(1) NOT NULL,
  `isEmailNotification` tinyint(1) NOT NULL,
  `documentId` char(36) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminderSchedulers`
--

CREATE TABLE `reminderSchedulers` (
  `id` char(36) NOT NULL,
  `duration` datetime NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `frequency` int(11) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `documentId` char(36) DEFAULT NULL,
  `userId` char(36) NOT NULL,
  `isRead` tinyint(1) NOT NULL,
  `isEmailNotification` tinyint(1) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminderUsers`
--

CREATE TABLE `reminderUsers` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `userId` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roleClaims`
--

CREATE TABLE `roleClaims` (
  `id` char(36) NOT NULL,
  `actionId` char(36) NOT NULL,
  `roleId` char(36) NOT NULL,
  `claimType` varchar(255) DEFAULT NULL,
  `claimValue` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roleClaims`
--

INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`, `claimValue`) VALUES
('031aa922-7cc3-4b5b-95b6-7d785dd4bc26', '1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DOCUMENT_AUDIT_TRAIL_VIEW_DOCUMENT_AUDIT_TRAIL', NULL),
('049ae753-7a66-45f6-af32-24788de24da7', '4f0e8a83-8a01-415e-88f5-c204369290de', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DEEP_SEARCH_DEEP_SEARCH', NULL),
('04ce90b6-ca30-41b2-9f52-cc92b7af3685', '2ea6ba08-eb36-4e34-92d9-f1984c908b31', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_SHARE_DOCUMENT', NULL),
('060186fd-b9d9-422f-9644-227a401feee3', '707c447d-5e0b-454a-abdf-550d8923eabc', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_START_WORKFLOW', NULL),
('0860b989-16c9-4582-8e1a-84deffed413a', '7ba630ca-a9d3-42ee-99c8-766e2231fec1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DASHBOARD_VIEW_DASHBOARD', NULL),
('0ade7b35-abe7-4e0e-abdc-53c2e67ab7ee', '1d768490-d67d-40b6-b610-22b17cc7ce2d', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DEEP_SEARCH_ADD_INDEXING', NULL),
('0cf39285-92a7-4d00-8b63-f329449861ae', 'b36cf0a4-ad53-4938-aac5-fb7fbfc2cfcf', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_RESTORE_VERSION', NULL),
('1213c3e7-b788-4f0f-aec2-651341914981', '96865813-77f0-40cf-968d-8b9c023d810e', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_ADD_WORKFLOW', NULL),
('12b00730-5a1d-4d96-9f20-e88f492af67a', 'e506ec48-b99a-45b4-9ec9-6451bc67477b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_ASSIGN_PERMISSION', NULL),
('144e0a16-b238-4f00-9946-f66c02292c85', 'a5b485ac-8c7b-4a4f-a62d-6f839d77e91f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_VIEW_VERSION_HISTORY', NULL),
('16d1d3c9-f80f-4500-bcb7-2b97c2031322', '165505b2-ad31-42c7-aafe-f66f291cb5a9', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_MANAGE_COMMENT', NULL),
('22aa8fc7-4efb-4499-b97f-612b5ed39e27', 'f5829228-ea73-4389-8aee-e2dc8ef6934a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOC_ADD_SIGNATURE', ''),
('23db8f94-7dfb-4229-b2c5-47a68cd745c2', 'fa91ffd9-61ee-4bb1-bf86-6a593cdc7be9', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ASSIGNED_DOCUMENTS_CREATE_DOCUMENT', NULL),
('27fd9902-5997-4300-ba95-8045962ef711', 'c04a1094-f289-4de7-b788-9f21ee3fe32a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_SEND_EMAIL', NULL),
('28467830-9bc9-4530-a555-5d0961e1b8d0', '92596605-e49a-4ab6-8a39-60116eba8abe', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_DELETE_DOCUMENT', NULL),
('2b429ee9-3edd-4ec7-bb5f-458ac80694b7', '8e3fbe21-0225-44e2-a537-bb50ddffb95c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_MANAGE_ALLOW_FILE_EXTENSIONS', NULL),
('39a44e9f-7483-4f00-82e0-7faf3f878b0f', 'db8825b1-ee4e-49f6-9a08-b0210ed53fd4', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_CREATE_ROLE', NULL),
('3bd0faa6-9fed-4c23-868d-55aed9b7d743', '391c1739-1045-4dd4-9705-4a960479f0a0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_UPLOAD_NEW_VERSION', NULL),
('3bed305f-bd4b-4bda-ac9e-85e2eac2c85b', '0f70cc17-26a9-43b1-922e-01fefb248d3c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_WORKFLOW_SETTINGS', NULL),
('3deb1936-7580-4a87-bfba-3f267b2eddd2', 'd57ff519-1448-4336-8d76-98d43a9ada2c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_ALL_CANCEL_WORKFLOW', NULL),
('3f986e8f-5a3e-4c7e-8153-2aca3cee44ec', 'cd46a3a4-ede5-4941-a49b-3df7eaa46428', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY', NULL),
('448ecb65-12a0-4355-b81a-72c808bb1c5f', '6719a065-8a4a-4350-8582-bfc41ce283fb', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_DOWNLOAD_DOCUMENT', NULL),
('498a17f0-f0a6-4196-b51b-d7cc2225b42c', '595a769d-f7ef-45f3-9f9e-60c58c5e1542', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_SEND_EMAIL', NULL),
('4ab6714e-77f6-4c5a-b8f3-0f55eb7fbc75', 'aa712002-aa9a-4656-9835-34278487a848', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGN_ADD_SIGNATURE', ''),
('4cd19842-ad13-4b89-b4f1-85cf8cf90d50', '72ce114a-d299-4d7d-aeee-598167a4fabc', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOC_GENERATE_SUMMARY', ''),
('50036841-ed04-4adc-a3f0-94c1aec7b563', '239035d5-cd44-475f-bbc5-9ef51768d389', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_CREATE_DOCUMENT', NULL),
('52c6b122-e702-4ec2-b1db-682dd3790165', 'fbe77c07-3058-4dbe-9d56-8c75dc879460', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_ASSIGN_USER_ROLE', NULL),
('5702eea1-9c01-4eb3-9938-1e9faf663421', '3da78b4d-d263-4b13-8e81-7aa164a3688c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_ADD_REMINDER', NULL),
('5b2554b4-fa6d-4690-ad01-2e70d0e93900', 'bf3ec13f-1e81-40f3-ad7a-05523608e85c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_MANAGE_GEMINI_API_KEY', ''),
('5be3614c-0443-11f1-b2c1-0050565f715e', 'b1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'BOARDS_VIEW_BOARDS', NULL),
('5be36770-0443-11f1-b2c1-0050565f715e', 'b2a3b4c5-d6e7-f8g9-h0i1-j2k3l4m5n6o7', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'BOARDS_CREATE_BOARD', NULL),
('5be3681b-0443-11f1-b2c1-0050565f715e', 'b3a4b5c6-d7e8-f9g0-h1i2-j3k4l5m6n7o8', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'BOARDS_EDIT_BOARD', NULL),
('5be368a5-0443-11f1-b2c1-0050565f715e', 'b4a5b6c7-d8e9-f0g1-h2i3-j4k5l6m7n8o9', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'BOARDS_DELETE_BOARD', NULL),
('5be36928-0443-11f1-b2c1-0050565f715e', 'b5a6b7c8-d9e0-f1g2-h3i4-j5k6l7m8n9o0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'BOARDS_MANAGE_CARDS', NULL),
('5f9c0bc1-5ee9-4d22-b297-85f211a7050a', '86ce1382-a2b1-48ed-ae81-c9908d00cf3b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_CREATE_USER', NULL),
('6d1de93a-6405-426b-96f9-d4625e2c7612', '6bc0458e-22f5-4975-b387-4d6a4fb35201', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_CREATE_REMINDER', NULL),
('6e2d7ef9-b619-474f-895a-a12ced7bed50', '6f2717fc-edef-4537-916d-2d527251a5c1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_VIEW_REMINDERS', NULL),
('6e3f1c5f-b661-4485-bf54-2c7de36338ee', 'e3fcd910-3f9b-4035-9bbb-312c5b599d52', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'GENERATE_AI_DOCUMENTS', NULL),
('6f2feb9f-19a5-4d21-9883-aa4ab2970a99', 'f4d8a768-151d-4ec9-a8e3-41216afe0ec0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_DELETE_DOCUMENTS', NULL),
('70328a8c-6905-46b6-a7a2-48336c470d89', 'cd46a3a4-ede5-4941-a49b-3df7eaa46428', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY', NULL),
('75686011-fc85-4342-ab9b-81db83a13def', '18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_DELETE_ROLE', NULL),
('7592bd57-ed8a-4584-902f-6107c0543991', 'd9067d75-e3b9-4d2d-8f82-567ad5f2b9ca', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_VIEW_DOCUMENTS', NULL),
('7b7e0da1-cf3c-46ce-8b81-d0121a212f1f', 'e9ff854b-23f7-46c2-9029-efba3d8587b5', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_MANAGE_SHARABLE_LINK', NULL),
('7e8ffe43-e023-4e34-83c5-88be76aa50de', '8d7e1668-ab2d-4aa5-b8d1-0358906d6995', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_VIEW_DETAIL', NULL),
('82064f47-6275-47e4-8563-10ac8067052e', 'ef979f76-027c-4b20-9330-5c81a3dc5869', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOC_WATERMARK', ''),
('8aa31871-7cc1-441a-9913-1a47739f00e9', 'c18e4105-e9d7-4c5d-b396-a2854bcb8e21', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_VIEW_VERSION_HISTORY', NULL),
('8cdd6d38-b1c2-4f08-9cd8-51543801c230', '086ce19f-5f1b-42ec-98ac-dea2d92901a3', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EXPIRED_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
('9086e9c6-9dbe-4a44-9b03-813ad83ca0a1', '324192f0-a319-4228-ba06-f1ce10189822', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGIN_AUDIT_SET_RETENTION_PERIOD', ''),
('912f6f5a-6556-4983-bc62-5ed234c593be', '322c388d-0ab4-4617-9bee-a8c79906e738', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_SET_RETENTION_PERIOD', ''),
('92c67dde-4dfc-4b15-b779-0df967ab0643', '374d74aa-a580-4928-848d-f7553db39914', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_DELETE_USER', NULL),
('938539ec-0fda-45be-8722-d15411550941', '9ac0f6f5-0731-49d9-a7b9-6fbd92291241', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'CRON_JOB_LOG_SET_RETENTION_PERIOD', ''),
('952f33ef-7136-4d84-8166-4ab88a72bcd9', '2f264576-2d7f-44a2-beeb-97c53847ad70', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EMAIL_LOG_SET_RETENTION_PERIOD', ''),
('9581aaef-d4fa-4117-b6c3-171e6c432527', '2e71e9d6-2302-44d8-b0f6-747b98d89125', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_UPDATE_FILE_REQUEST', NULL),
('96ca770c-5f0d-4a40-a316-ac8dcde35db4', 'a74e0f79-bc3c-4582-a2ea-008d568e6a8b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGS_VIEW_CRON_JOBS_LOGS', ''),
('98ee2243-5923-45ef-813b-d6e31afa9d82', '1ae728c8-58df-4e9f-b284-132dc3c8ff89', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_REJECT_FILE_REQUEST', NULL),
('9d31f2fb-dfa6-4a8e-979f-3f4a4404bfe2', '8b63ccd0-616a-4b97-8af6-aa49066a0a9e', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOC_GENERATE_SUMMARY', ''),
('9e30645e-7644-45da-b378-ff0a28601e45', '63355376-2650-4949-9580-fc8c888353f0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_MANAGE_OPEN_AI_API_KEY', NULL),
('9f15485e-6385-4cd1-b642-6e2492917f5d', 'dba2e7bf-6bac-4620-a9e6-d4eaa2c8480f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'PAGE_HELPER_MANAGE_PAGE_HELPER', NULL),
('a024b06b-6af7-444e-bdfe-cf47d4fe9b65', 'c2d3e4f5-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_DELETE_WORKFLOW', NULL),
('a2384cd5-6944-49d7-a96e-f907624415b5', '78d881d1-1da5-42d9-a97b-a6ad71e27ebc', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOC_WATERMARK', ''),
('a384f3ea-f629-4422-adef-27b9280fb783', '229150ef-9007-4c62-9276-13dd18294370', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_RESTORE_VERSION', NULL),
('a3ee0de9-34c7-45d8-92b5-1c3b982e1786', 'a57b1ad5-8fbc-429b-b776-fbb468e5c6a4', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTING_MANAGE_PROFILE', NULL),
('a549e9c7-88f5-4546-8e41-5a20b503f6cf', 'ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGIN_AUDIT_VIEW_LOGIN_AUDIT_LOGS', NULL),
('a5682511-9971-49cf-b9bd-49a3db62889b', '1e5fc904-5f70-4b07-8914-242703da5702', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGS_VIEW_EMAIL_LOGS', ''),
('a5e93cf3-ff8b-45c9-934e-9ae91a79fd8c', '44ecbcaf-6d4a-4fc2-911c-e96be65bffb2', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_MANAGE_COMMENT', NULL),
('a68ae437-9abe-47b8-95df-8e603298250e', '538c081b-2e14-4f0d-bc34-5f26ad2f77cf', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGS_DELETE_EMAIL_LOG', ''),
('a786e15c-0c8f-4aac-9578-09066b89421f', 'bc515aea-ef66-4d8d-9cdb-47477cb74145', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'MANAGE_AI_PROMPT_TEMPLATES', NULL),
('a9d25865-0fb9-4794-93ec-4e4c75d40f09', '9a086704-b7c2-4dff-9088-dde29ad259ef', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DEEP_SEARCH_REMOVE_INDEXING', NULL),
('ad7bcebe-1224-4f77-b7a3-bdc2d4433e4b', '07ad64e9-9a43-40d0-a205-2adb81e238b1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_STORAGE_SETTINGS', NULL),
('b042f7db-eb3f-4835-ad33-d5a9e0d2baa4', '260d1089-46c7-4f53-83e6-f80b9b3fb823', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
('b3784779-5e4a-4a29-acce-1bd3dd284ba6', 'c6e2e9f8-1ee4-4c1d-abd1-721ff604c8b8', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_ADD_REMINDER', NULL),
('b4de0a3b-f544-4b59-8469-7b67618fc650', 'f165f5a2-fe26-490a-91bc-08a736096fed', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_ALL_WORKFLOWS', NULL),
('b7f8d97b-a3ff-4580-ae1b-8454edacf77d', '5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_DELETE_REMINDER', NULL),
('b8d271de-2f25-41db-9f33-8b7ee730f1b6', '6b0fe007-1b92-4568-a4b7-6d105eb5c48c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_ALL_PERFORM_TRANSITION', NULL),
('b99e19d2-0ffe-42b1-aa9f-66abed4e5be3', '79ce78a8-0716-4850-a40b-cdc36f3579e4', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_WORKFLOW_LOGS', NULL),
('baa26500-deea-4338-a049-9be3bcac86e1', 'c288b5d3-419d-4dc0-9e5a-083194016d2c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_EDIT_ROLE', NULL),
('bf63242b-5bf5-453f-8ca4-eed45114ba2b', '0478e8b6-7d52-4c26-99e1-657a1c703e8b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_DELETE_FILE_REQUEST', NULL),
('bf8b1a02-5124-4dc1-8af9-9e3424a2bd12', 'f508f793-5d4c-4e03-889c-2c62b6cf484f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_MY_WORKFLOWS', NULL),
('c5785f6e-7925-456d-ba4a-6e15ee8d4ece', 'e017d419-8080-4b2d-ac89-4e966182a12f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'MANAGE_DOCUMENT_STATUS', NULL),
('c67b91f2-a750-4045-adbd-4937f81ddfd5', 'cb988c3a-7487-4366-9521-c0c5adf9b5a6', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'BULK_DOCUMENT_UPLOAD', NULL),
('c7fc23b1-6b0c-438e-85fb-3c9eb46d69b2', '31cb6438-7d4a-4385-8a34-b4e8f6096a48', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_VIEW_USERS', NULL),
('c83151c1-6b67-44a2-89ed-ed27b51d762b', 'b4d722d6-755c-4be4-8f0d-2283c9394e18', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_APPROVE_FILE_REQUEST', NULL),
('c9f42285-1f00-4069-83c4-8b0a8ece1fa9', '7ba630ca-a9d3-42ee-99c8-766e2231fec1', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'DASHBOARD_VIEW_DASHBOARD', NULL),
('ce2b767b-ba59-41d5-89e8-89f9bb6c2089', '4cce3cb4-5179-4fc7-b59c-7b15afc747f7', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'CLIENTS_MANAGE_CLIENTS', NULL),
('d22f9e74-8c87-4762-b539-aa0314605432', '41f65d07-9023-4cfb-9c7c-0e3247a012e0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EMAIL_MANAGE_SMTP_SETTINGS', NULL),
('d27f3aa5-c101-4916-aafb-869320fc2fda', '26e383c9-7f7f-4ed0-b78d-a2941f5b4fe7', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_ADD_REMINDER', NULL),
('d5402953-921b-4cdd-80ba-b291fe3962a3', '61de0ba3-f41f-4ca8-9af6-ec8dc456c16b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_CREATE_FILE_REQUEST', NULL),
('d62627bd-ed1a-41f7-9598-9440e80d31d5', 'a737284a-e43b-481d-9fdd-07e1680ffe11', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_EDIT_DOCUMENT', NULL),
('d636b083-e7f7-492c-b36e-59d845301eff', '5f7c13fd-3c5d-4e69-9e21-a263924d273b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_CHANGE_PDF_SETTINGS', ''),
('d69fde88-881e-4ee3-8311-8f9359329e90', '72ca5c91-b415-4997-a234-b4d71ba03253', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTING_MANAGE_LANGUAGE', NULL),
('d815e38f-4bef-4e0c-b1f4-44339d775d9a', 'f9ec1096-b798-4623-bbf8-4f5d4fe775e9', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_MANAGE_SHARABLE_LINK', NULL),
('d8480cea-f50a-48ef-9e9b-30f91b7155a9', '229ad778-c7d3-4f5f-ab52-24b537c39514', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_DELETE_DOCUMENT', NULL),
('daaa27bd-16a2-408f-b7e0-c8de1d49a82b', 'a8dd972d-e758-4571-8d39-c6fec74b361b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_EDIT_DOCUMENT', NULL),
('db053f33-8128-4e33-b194-9e1a624235fe', '4071ed2e-56fb-4c5a-887d-8a175cac8d71', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_RESTORE_DOCUMENT', NULL),
('db6bb700-8681-4bbf-b63c-45186cb672e1', 'b1c5f8d2-3e4f-4b0a-9c6d-7e8f9a0b1c2d', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_UPDATE_WORKFLOW', NULL),
('df2f0ef9-88be-4378-b8de-c4081c8787e3', 'ac6d6fbc-6348-4149-9c0c-154ab79d1166', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_SHARE_DOCUMENT', NULL),
('e2d29e20-a896-40a0-8b4a-2c892ce62439', '31ba8e74-8fa0-4c34-82ac-950e73a4c18e', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EXPIRED_DOCUMENTS_ACTIVATE_DOCUMENT', NULL),
('e47387aa-c31f-4fc7-a361-3784de1929ba', '37db8a21-e552-466d-bcf4-f90f5e4e1008', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_VIEW_DETAIL', NULL),
('e62a4170-43dc-478c-ab1a-b1663c8bbaa4', 'fa5b07a4-e8c4-40e2-b5cf-f1a562087783', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'VIEW_AI_GENERATED_DOCUMENTS', NULL),
('e6ae6857-c5d8-4372-999c-e3240eeccf08', '18d07817-4b47-4c84-b21f-abe05da5e1ba', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
('e7c1303d-99a4-4332-96d1-e5c15d064be7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_START_WORKFLOW', NULL),
('eb162e6c-7ec8-49d0-8d14-c924fee8eab2', '0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_EDIT_USER', NULL),
('edb0b154-bb1e-43a1-871a-f2ced36b5ea3', '7562978b-155a-4fb1-bc3f-6153f62ed565', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_VIEW_FILE_REQUEST', NULL),
('ee2b69f5-bf81-4130-a5db-f19c2c0a0172', 'd4d724fc-fd38-49c4-85bc-73937b219e20', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_RESET_PASSWORD', NULL),
('efcd9e74-9303-4855-9e14-0c6003f4142c', '3ccaf408-8864-4815-a3e0-50632d90bcb6', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_EDIT_REMINDER', NULL),
('f860ff83-e507-4764-8846-cb452563bb02', 'fa91ffd9-61ee-4bb1-bf86-6a593cdc7be9', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_CREATE_DOCUMENT', NULL),
('fa413c2f-d143-4b48-b113-742f2db296a2', '57216dcd-1a1c-4f94-a33d-83a5af2d7a46', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_VIEW_ROLES', NULL),
('fba7a269-afe7-4e98-952f-8043734f9f3b', '57f0b2ef-eeba-44a6-bd88-458003f013ef', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_UPLOAD_NEW_VERSION', NULL),
('fbda5c2e-a043-4055-895e-7fcc0e06425f', 'b0f2a1c4-3d8e-4b5c-9f6d-7a0e5f3b8c1d', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DELETE_AI_GENERATED_DOCUMENTS', NULL),
('ff8a6fab-a4ac-4cd8-a441-cae837464c73', '5f24c3d8-94d8-4e57-adb3-bef3e000e7d0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EXPIRED_DOCUMENTS_VIEW_DOCUMENT', NULL),
('ffbad8b0-3b14-4160-b3c0-60ab66811853', '63ed1277-1db5-4cf7-8404-3e3426cb4bc5', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_VIEW_DOCUMENTS', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `isDeleted`, `name`, `createdBy`, `modifiedBy`, `deletedBy`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
('f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 0, 'Super Admin', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL),
('ff635a8f-4bb3-4d70-a3ed-c7749030696c', 0, 'Employee', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', NULL, '2026-02-07 13:04:03', '2026-02-07 13:04:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `seed_history`
--

CREATE TABLE `seed_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seeder_class` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seed_history`
--

INSERT INTO `seed_history` (`id`, `seeder_class`, `created_at`, `updated_at`) VALUES
(1, 'Database\\Seeders\\RoleSeeder', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(2, 'Database\\Seeders\\PermissionSeeder', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(3, 'Database\\Seeders\\LanguageSeeder', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(4, 'Database\\Seeders\\PermissionSeederV2', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(5, 'Database\\Seeders\\PermissionSeederV21', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(6, 'Database\\Seeders\\PermissionSeederV22', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(7, 'Database\\Seeders\\PermissionSeederV23', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(8, 'Database\\Seeders\\PermissionSeederV24', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(9, 'Database\\Seeders\\PermissionSeederV30', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(10, 'Database\\Seeders\\PermissionSeederV31', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(11, 'Database\\Seeders\\PermissionSeederV40', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(12, 'Database\\Seeders\\PermissionSeederV50', '2026-02-07 12:04:03', '2026-02-07 12:04:03'),
(13, 'Database\\Seeders\\PermissionSeederV51', '2026-02-07 12:04:04', '2026-02-07 12:04:04'),
(14, 'Database\\Seeders\\PermissionSeederV52', '2026-02-07 12:04:04', '2026-02-07 12:04:04'),
(15, 'Database\\Seeders\\PermissionSeederV53', '2026-02-07 12:04:04', '2026-02-07 12:04:04');

-- --------------------------------------------------------

--
-- Table structure for table `sendEmails`
--

CREATE TABLE `sendEmails` (
  `id` char(36) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `fromEmail` varchar(255) DEFAULT NULL,
  `documentId` char(36) DEFAULT NULL,
  `isSend` tinyint(1) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userClaims`
--

CREATE TABLE `userClaims` (
  `id` char(36) NOT NULL,
  `actionId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `claimType` varchar(255) DEFAULT NULL,
  `claimValue` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userNotifications`
--

CREATE TABLE `userNotifications` (
  `id` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `isRead` tinyint(1) NOT NULL,
  `documentId` char(36) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `notificationType` int(11) NOT NULL DEFAULT 0,
  `documentWorkflowId` char(36) DEFAULT NULL,
  `fileRequestId` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userRoles`
--

CREATE TABLE `userRoles` (
  `id` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `roleId` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `userRoles`
--

INSERT INTO `userRoles` (`id`, `userId`, `roleId`) VALUES
('a2b53eb8-7e99-4c7b-8d18-00bfba10663a', '99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `normalizedUserName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `normalizedEmail` varchar(255) DEFAULT NULL,
  `emailConfirmed` tinyint(1) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `securityStamp` varchar(255) DEFAULT NULL,
  `concurrencyStamp` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `phoneNumberConfirmed` tinyint(1) NOT NULL,
  `twoFactorEnabled` tinyint(1) NOT NULL,
  `lockoutEnd` timestamp NULL DEFAULT NULL,
  `lockoutEnabled` tinyint(1) NOT NULL,
  `accessFailedCount` int(11) NOT NULL,
  `resetPasswordCode` char(36) DEFAULT NULL,
  `isSystemUser` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `isDeleted`, `userName`, `normalizedUserName`, `email`, `normalizedEmail`, `emailConfirmed`, `password`, `securityStamp`, `concurrencyStamp`, `phoneNumber`, `phoneNumberConfirmed`, `twoFactorEnabled`, `lockoutEnd`, `lockoutEnabled`, `accessFailedCount`, `resetPasswordCode`, `isSystemUser`) VALUES
('99365f7c-9b0e-4af3-bfdd-8944e5c41b96', 'Ramzi', 'Tanani', 0, 'vpersonmail@gmail.com', NULL, 'vpersonmail@gmail.com', NULL, 0, '$2y$10$dhWZp3.uqcqEzc5paRZKSO6j64QlUpKTTZxCnlst0iSYt3c9Er74C', NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, 0),
('c9a9a7a6-2c4a-4537-8a30-6b9f25ab8dc6', 'System', 'User', 0, NULL, NULL, 'system@user.com', NULL, 0, '$2y$10$EvVj2zAcwkYP2HB7NGJCAO.69MdPIlonKhYgeewvrC7OpPzpbkIAG', NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `workflowLogs`
--

CREATE TABLE `workflowLogs` (
  `id` char(36) NOT NULL,
  `documentWorkflowId` char(36) NOT NULL,
  `transitionId` char(36) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `type` enum('Transition','Initiated','Cancelled') NOT NULL DEFAULT 'Transition',
  `createdBy` char(36) NOT NULL,
  `deletedBy` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflows`
--

CREATE TABLE `workflows` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `isWorkflowSetup` tinyint(1) NOT NULL,
  `modifiedBy` char(36) NOT NULL,
  `deletedBy` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowSteps`
--

CREATE TABLE `workflowSteps` (
  `id` char(36) NOT NULL,
  `workflowId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowTransitionRoles`
--

CREATE TABLE `workflowTransitionRoles` (
  `id` char(36) NOT NULL,
  `roleId` char(36) NOT NULL,
  `transitionId` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowTransitions`
--

CREATE TABLE `workflowTransitions` (
  `id` char(36) NOT NULL,
  `workflowId` char(36) NOT NULL,
  `fromStepId` char(36) NOT NULL,
  `toStepId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `orderNo` int(11) NOT NULL,
  `isFirstTransaction` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowTransitionUsers`
--

CREATE TABLE `workflowTransitionUsers` (
  `id` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `transitionId` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `actions_pageid_foreign` (`pageId`);

--
-- Indexes for table `aiPromptTemplates`
--
ALTER TABLE `aiPromptTemplates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `allowFileExtensions`
--
ALTER TABLE `allowFileExtensions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boardCardActivities`
--
ALTER TABLE `boardCardActivities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boardcardactivities_cardid_foreign` (`cardId`),
  ADD KEY `boardcardactivities_userid_foreign` (`userId`),
  ADD KEY `boardcardactivities_attachment_foreign` (`attachmentId`);

--
-- Indexes for table `boardCardAssignees`
--
ALTER TABLE `boardCardAssignees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_user_unique` (`cardId`,`userId`),
  ADD KEY `boardcardassignees_userid_foreign` (`userId`);

--
-- Indexes for table `boardCardAttachments`
--
ALTER TABLE `boardCardAttachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_boardCardAttachments_cardId` (`cardId`),
  ADD KEY `fk_boardCardAttachments_documentId` (`documentId`);

--
-- Indexes for table `boardCardChecklistItems`
--
ALTER TABLE `boardCardChecklistItems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boardcardchecklistitems_checklistid_foreign` (`checklistId`);

--
-- Indexes for table `boardCardChecklists`
--
ALTER TABLE `boardCardChecklists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boardcardchecklists_cardid_foreign` (`cardId`);

--
-- Indexes for table `boardCardFollowers`
--
ALTER TABLE `boardCardFollowers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_follower_unique` (`cardId`,`userId`),
  ADD KEY `boardcardfollowers_userid_foreign` (`userId`);

--
-- Indexes for table `boardCardLabels`
--
ALTER TABLE `boardCardLabels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_label_unique` (`cardId`,`labelId`),
  ADD KEY `boardcardlabels_labelid_foreign` (`labelId`);

--
-- Indexes for table `boardCardMilestones`
--
ALTER TABLE `boardCardMilestones`
  ADD PRIMARY KEY (`cardId`,`milestoneId`);

--
-- Indexes for table `boardCards`
--
ALTER TABLE `boardCards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boardcards_columnid_foreign` (`columnId`),
  ADD KEY `boardcards_boardid_foreign` (`boardId`),
  ADD KEY `boardcards_documentid_foreign` (`documentId`),
  ADD KEY `boardcards_executorid_foreign` (`executorId`),
  ADD KEY `boardcards_approverid_foreign` (`approverId`),
  ADD KEY `boardcards_supervisorid_foreign` (`supervisorId`),
  ADD KEY `boardcards_parentcardid_foreign` (`parentCardId`);

--
-- Indexes for table `boardCardTags`
--
ALTER TABLE `boardCardTags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_tag_unique` (`cardId`,`tagId`),
  ADD KEY `boardcardtags_tagid_foreign` (`tagId`);

--
-- Indexes for table `boardColumns`
--
ALTER TABLE `boardColumns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boardcolumns_boardid_foreign` (`boardId`);

--
-- Indexes for table `boardLabels`
--
ALTER TABLE `boardLabels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boardlabels_boardid_foreign` (`boardId`);

--
-- Indexes for table `boardMilestones`
--
ALTER TABLE `boardMilestones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boards`
--
ALTER TABLE `boards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boards_createdby_foreign` (`createdBy`);

--
-- Indexes for table `boardTags`
--
ALTER TABLE `boardTags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boardtags_boardid_foreign` (`boardId`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parentid_foreign` (`parentId`),
  ADD KEY `idx_categories_hierarchy_path` (`hierarchyPath`(768));

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clients_createdby_foreign` (`createdBy`);

--
-- Indexes for table `companyProfile`
--
ALTER TABLE `companyProfile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `companyprofile_createdby_foreign` (`createdBy`);

--
-- Indexes for table `cronJobLogs`
--
ALTER TABLE `cronJobLogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dailyReminders`
--
ALTER TABLE `dailyReminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dailyreminders_reminderid_foreign` (`reminderId`);

--
-- Indexes for table `documentAuditTrails`
--
ALTER TABLE `documentAuditTrails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentaudittrails_documentid_foreign` (`documentId`),
  ADD KEY `documentaudittrails_assigntouserid_foreign` (`assignToUserId`),
  ADD KEY `documentaudittrails_assigntoroleid_foreign` (`assignToRoleId`),
  ADD KEY `documentaudittrails_createdby_foreign` (`createdBy`);

--
-- Indexes for table `documentComments`
--
ALTER TABLE `documentComments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentcomments_documentid_foreign` (`documentId`),
  ADD KEY `documentcomments_createdby_foreign` (`createdBy`);

--
-- Indexes for table `documentMetaDatas`
--
ALTER TABLE `documentMetaDatas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentmetadatas_documentid_foreign` (`documentId`);

--
-- Indexes for table `documentRolePermissions`
--
ALTER TABLE `documentRolePermissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentrolepermissions_documentid_foreign` (`documentId`),
  ADD KEY `documentrolepermissions_roleid_foreign` (`roleId`),
  ADD KEY `documentrolepermissions_createdby_foreign` (`createdBy`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documents_categoryid_foreign` (`categoryId`),
  ADD KEY `documents_createdby_foreign` (`createdBy`),
  ADD KEY `documents_clientid_foreign` (`clientId`),
  ADD KEY `documents_statusid_foreign` (`statusId`),
  ADD KEY `documents_documentworkflowid_foreign` (`documentWorkflowId`),
  ADD KEY `documents_signbyid_foreign` (`signById`);

--
-- Indexes for table `documentShareableLink`
--
ALTER TABLE `documentShareableLink`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentshareablelink_documentid_foreign` (`documentId`),
  ADD KEY `documentshareablelink_createdby_foreign` (`createdBy`);

--
-- Indexes for table `documentSignatures`
--
ALTER TABLE `documentSignatures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentsignatures_documentid_foreign` (`documentId`),
  ADD KEY `documentsignatures_createdby_foreign` (`createdBy`);

--
-- Indexes for table `documentStatus`
--
ALTER TABLE `documentStatus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentstatus_createdby_foreign` (`createdBy`);

--
-- Indexes for table `documentTokens`
--
ALTER TABLE `documentTokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documentUserPermissions`
--
ALTER TABLE `documentUserPermissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentuserpermissions_documentid_foreign` (`documentId`),
  ADD KEY `documentuserpermissions_userid_foreign` (`userId`),
  ADD KEY `documentuserpermissions_createdby_foreign` (`createdBy`);

--
-- Indexes for table `documentVersions`
--
ALTER TABLE `documentVersions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentversions_documentid_foreign` (`documentId`),
  ADD KEY `documentversions_createdby_foreign` (`createdBy`),
  ADD KEY `documentversions_signbyid_foreign` (`signById`);

--
-- Indexes for table `documentWorkflow`
--
ALTER TABLE `documentWorkflow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentworkflow_createdby_foreign` (`createdBy`),
  ADD KEY `documentworkflow_documentid_foreign` (`documentId`),
  ADD KEY `documentworkflow_workflowid_foreign` (`workflowId`),
  ADD KEY `documentworkflow_currentstepid_foreign` (`currentStepId`);

--
-- Indexes for table `emailLogAttachments`
--
ALTER TABLE `emailLogAttachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emaillogattachments_emaillogid_foreign` (`emailLogId`);

--
-- Indexes for table `emailLogs`
--
ALTER TABLE `emailLogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emailSMTPSettings`
--
ALTER TABLE `emailSMTPSettings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fileRequestDocuments`
--
ALTER TABLE `fileRequestDocuments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `filerequestdocuments_filerequestid_foreign` (`fileRequestId`),
  ADD KEY `filerequestdocuments_approvalorrejectedbyid_foreign` (`approvalOrRejectedById`);

--
-- Indexes for table `fileRequests`
--
ALTER TABLE `fileRequests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `filerequests_createdby_foreign` (`createdBy`);

--
-- Indexes for table `halfYearlyReminders`
--
ALTER TABLE `halfYearlyReminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `halfyearlyreminders_reminderid_foreign` (`reminderId`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `languages_createdby_foreign` (`createdBy`);

--
-- Indexes for table `loginAudits`
--
ALTER TABLE `loginAudits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `openaiDocuments`
--
ALTER TABLE `openaiDocuments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pageHelper`
--
ALTER TABLE `pageHelper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quarterlyReminders`
--
ALTER TABLE `quarterlyReminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quarterlyreminders_reminderid_foreign` (`reminderId`);

--
-- Indexes for table `reminderNotifications`
--
ALTER TABLE `reminderNotifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `remindernotifications_reminderid_foreign` (`reminderId`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reminders_documentid_foreign` (`documentId`),
  ADD KEY `reminders_createdby_foreign` (`createdBy`);

--
-- Indexes for table `reminderSchedulers`
--
ALTER TABLE `reminderSchedulers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reminderschedulers_documentid_foreign` (`documentId`),
  ADD KEY `reminderschedulers_userid_foreign` (`userId`);

--
-- Indexes for table `reminderUsers`
--
ALTER TABLE `reminderUsers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reminderusers_reminderid_foreign` (`reminderId`),
  ADD KEY `reminderusers_userid_foreign` (`userId`);

--
-- Indexes for table `roleClaims`
--
ALTER TABLE `roleClaims`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roleclaims_actionid_foreign` (`actionId`),
  ADD KEY `roleclaims_roleid_foreign` (`roleId`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seed_history`
--
ALTER TABLE `seed_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `seed_history_seeder_class_unique` (`seeder_class`);

--
-- Indexes for table `sendEmails`
--
ALTER TABLE `sendEmails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sendemails_documentid_foreign` (`documentId`),
  ADD KEY `sendemails_createdby_foreign` (`createdBy`);

--
-- Indexes for table `userClaims`
--
ALTER TABLE `userClaims`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userclaims_actionid_foreign` (`actionId`),
  ADD KEY `userclaims_userid_foreign` (`userId`);

--
-- Indexes for table `userNotifications`
--
ALTER TABLE `userNotifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usernotifications_userid_foreign` (`userId`),
  ADD KEY `usernotifications_documentid_foreign` (`documentId`),
  ADD KEY `usernotifications_documentworkflowid_foreign` (`documentWorkflowId`),
  ADD KEY `usernotifications_filerequestid_foreign` (`fileRequestId`);

--
-- Indexes for table `userRoles`
--
ALTER TABLE `userRoles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userroles_userid_foreign` (`userId`),
  ADD KEY `userroles_roleid_foreign` (`roleId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workflowLogs`
--
ALTER TABLE `workflowLogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflowlogs_documentworkflowid_foreign` (`documentWorkflowId`),
  ADD KEY `workflowlogs_transitionid_foreign` (`transitionId`),
  ADD KEY `workflowlogs_createdby_foreign` (`createdBy`);

--
-- Indexes for table `workflows`
--
ALTER TABLE `workflows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflows_createdby_foreign` (`createdBy`),
  ADD KEY `workflows_modifiedby_foreign` (`modifiedBy`);

--
-- Indexes for table `workflowSteps`
--
ALTER TABLE `workflowSteps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflowsteps_workflowid_foreign` (`workflowId`);

--
-- Indexes for table `workflowTransitionRoles`
--
ALTER TABLE `workflowTransitionRoles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflowtransitionroles_roleid_foreign` (`roleId`),
  ADD KEY `workflowtransitionroles_transitionid_foreign` (`transitionId`);

--
-- Indexes for table `workflowTransitions`
--
ALTER TABLE `workflowTransitions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflowtransitions_workflowid_foreign` (`workflowId`),
  ADD KEY `workflowtransitions_fromstepid_foreign` (`fromStepId`),
  ADD KEY `workflowtransitions_tostepid_foreign` (`toStepId`);

--
-- Indexes for table `workflowTransitionUsers`
--
ALTER TABLE `workflowTransitionUsers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflowtransitionusers_userid_foreign` (`userId`),
  ADD KEY `workflowtransitionusers_transitionid_foreign` (`transitionId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `seed_history`
--
ALTER TABLE `seed_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `actions`
--
ALTER TABLE `actions`
  ADD CONSTRAINT `actions_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`);

--
-- Constraints for table `boardCardActivities`
--
ALTER TABLE `boardCardActivities`
  ADD CONSTRAINT `boardcardactivities_attachment_foreign` FOREIGN KEY (`attachmentId`) REFERENCES `documents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `boardcardactivities_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `boardcardactivities_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardCardAssignees`
--
ALTER TABLE `boardCardAssignees`
  ADD CONSTRAINT `boardcardassignees_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `boardcardassignees_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardCardAttachments`
--
ALTER TABLE `boardCardAttachments`
  ADD CONSTRAINT `fk_boardCardAttachments_cardId` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_boardCardAttachments_documentId` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardCardChecklistItems`
--
ALTER TABLE `boardCardChecklistItems`
  ADD CONSTRAINT `boardcardchecklistitems_checklistid_foreign` FOREIGN KEY (`checklistId`) REFERENCES `boardCardChecklists` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardCardChecklists`
--
ALTER TABLE `boardCardChecklists`
  ADD CONSTRAINT `boardcardchecklists_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardCardFollowers`
--
ALTER TABLE `boardCardFollowers`
  ADD CONSTRAINT `boardcardfollowers_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `boardcardfollowers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardCardLabels`
--
ALTER TABLE `boardCardLabels`
  ADD CONSTRAINT `boardcardlabels_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `boardcardlabels_labelid_foreign` FOREIGN KEY (`labelId`) REFERENCES `boardLabels` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardCards`
--
ALTER TABLE `boardCards`
  ADD CONSTRAINT `boardcards_approverid_foreign` FOREIGN KEY (`approverId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `boardcards_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `boardcards_columnid_foreign` FOREIGN KEY (`columnId`) REFERENCES `boardColumns` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `boardcards_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `boardcards_executorid_foreign` FOREIGN KEY (`executorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `boardcards_parentcardid_foreign` FOREIGN KEY (`parentCardId`) REFERENCES `boardCards` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `boardcards_supervisorid_foreign` FOREIGN KEY (`supervisorId`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `boardCardTags`
--
ALTER TABLE `boardCardTags`
  ADD CONSTRAINT `boardcardtags_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `boardcardtags_tagid_foreign` FOREIGN KEY (`tagId`) REFERENCES `boardTags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardColumns`
--
ALTER TABLE `boardColumns`
  ADD CONSTRAINT `boardcolumns_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardLabels`
--
ALTER TABLE `boardLabels`
  ADD CONSTRAINT `boardlabels_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boards`
--
ALTER TABLE `boards`
  ADD CONSTRAINT `boards_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `boardTags`
--
ALTER TABLE `boardTags`
  ADD CONSTRAINT `boardtags_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parentid_foreign` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`);

--
-- Constraints for table `companyProfile`
--
ALTER TABLE `companyProfile`
  ADD CONSTRAINT `companyprofile_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`);

--
-- Constraints for table `dailyReminders`
--
ALTER TABLE `dailyReminders`
  ADD CONSTRAINT `dailyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`);

--
-- Constraints for table `documentAuditTrails`
--
ALTER TABLE `documentAuditTrails`
  ADD CONSTRAINT `documentaudittrails_assigntoroleid_foreign` FOREIGN KEY (`assignToRoleId`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `documentaudittrails_assigntouserid_foreign` FOREIGN KEY (`assignToUserId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentaudittrails_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentaudittrails_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`);

--
-- Constraints for table `documentComments`
--
ALTER TABLE `documentComments`
  ADD CONSTRAINT `documentcomments_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentcomments_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`);

--
-- Constraints for table `documentMetaDatas`
--
ALTER TABLE `documentMetaDatas`
  ADD CONSTRAINT `documentmetadatas_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`);

--
-- Constraints for table `documentRolePermissions`
--
ALTER TABLE `documentRolePermissions`
  ADD CONSTRAINT `documentrolepermissions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentrolepermissions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `documentrolepermissions_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`);

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_categoryid_foreign` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `documents_clientid_foreign` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `documents_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documents_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentWorkflow` (`id`),
  ADD CONSTRAINT `documents_signbyid_foreign` FOREIGN KEY (`signById`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documents_statusid_foreign` FOREIGN KEY (`statusId`) REFERENCES `documentStatus` (`id`);

--
-- Constraints for table `documentShareableLink`
--
ALTER TABLE `documentShareableLink`
  ADD CONSTRAINT `documentshareablelink_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentshareablelink_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`);

--
-- Constraints for table `documentSignatures`
--
ALTER TABLE `documentSignatures`
  ADD CONSTRAINT `documentsignatures_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentsignatures_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`);

--
-- Constraints for table `documentStatus`
--
ALTER TABLE `documentStatus`
  ADD CONSTRAINT `documentstatus_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`);

--
-- Constraints for table `documentUserPermissions`
--
ALTER TABLE `documentUserPermissions`
  ADD CONSTRAINT `documentuserpermissions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentuserpermissions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `documentuserpermissions_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `documentVersions`
--
ALTER TABLE `documentVersions`
  ADD CONSTRAINT `documentversions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentversions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `documentversions_signbyid_foreign` FOREIGN KEY (`signById`) REFERENCES `users` (`id`);

--
-- Constraints for table `documentWorkflow`
--
ALTER TABLE `documentWorkflow`
  ADD CONSTRAINT `documentworkflow_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `documentworkflow_currentstepid_foreign` FOREIGN KEY (`currentStepId`) REFERENCES `workflowSteps` (`id`),
  ADD CONSTRAINT `documentworkflow_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `documentworkflow_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`);

--
-- Constraints for table `emailLogAttachments`
--
ALTER TABLE `emailLogAttachments`
  ADD CONSTRAINT `emaillogattachments_emaillogid_foreign` FOREIGN KEY (`emailLogId`) REFERENCES `emailLogs` (`id`);

--
-- Constraints for table `fileRequestDocuments`
--
ALTER TABLE `fileRequestDocuments`
  ADD CONSTRAINT `filerequestdocuments_approvalorrejectedbyid_foreign` FOREIGN KEY (`approvalOrRejectedById`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `filerequestdocuments_filerequestid_foreign` FOREIGN KEY (`fileRequestId`) REFERENCES `fileRequests` (`id`);

--
-- Constraints for table `fileRequests`
--
ALTER TABLE `fileRequests`
  ADD CONSTRAINT `filerequests_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`);

--
-- Constraints for table `halfYearlyReminders`
--
ALTER TABLE `halfYearlyReminders`
  ADD CONSTRAINT `halfyearlyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`);

--
-- Constraints for table `languages`
--
ALTER TABLE `languages`
  ADD CONSTRAINT `languages_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`);

--
-- Constraints for table `quarterlyReminders`
--
ALTER TABLE `quarterlyReminders`
  ADD CONSTRAINT `quarterlyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`);

--
-- Constraints for table `reminderNotifications`
--
ALTER TABLE `reminderNotifications`
  ADD CONSTRAINT `remindernotifications_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`);

--
-- Constraints for table `reminders`
--
ALTER TABLE `reminders`
  ADD CONSTRAINT `reminders_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reminders_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`);

--
-- Constraints for table `reminderSchedulers`
--
ALTER TABLE `reminderSchedulers`
  ADD CONSTRAINT `reminderschedulers_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `reminderschedulers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `reminderUsers`
--
ALTER TABLE `reminderUsers`
  ADD CONSTRAINT `reminderusers_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`),
  ADD CONSTRAINT `reminderusers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `roleClaims`
--
ALTER TABLE `roleClaims`
  ADD CONSTRAINT `roleclaims_actionid_foreign` FOREIGN KEY (`actionId`) REFERENCES `actions` (`id`),
  ADD CONSTRAINT `roleclaims_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`);

--
-- Constraints for table `sendEmails`
--
ALTER TABLE `sendEmails`
  ADD CONSTRAINT `sendemails_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `sendemails_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`);

--
-- Constraints for table `userClaims`
--
ALTER TABLE `userClaims`
  ADD CONSTRAINT `userclaims_actionid_foreign` FOREIGN KEY (`actionId`) REFERENCES `actions` (`id`),
  ADD CONSTRAINT `userclaims_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `userNotifications`
--
ALTER TABLE `userNotifications`
  ADD CONSTRAINT `usernotifications_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `usernotifications_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentWorkflow` (`id`),
  ADD CONSTRAINT `usernotifications_filerequestid_foreign` FOREIGN KEY (`fileRequestId`) REFERENCES `fileRequests` (`id`),
  ADD CONSTRAINT `usernotifications_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `userRoles`
--
ALTER TABLE `userRoles`
  ADD CONSTRAINT `userroles_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `userroles_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `workflowLogs`
--
ALTER TABLE `workflowLogs`
  ADD CONSTRAINT `workflowlogs_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `workflowlogs_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentWorkflow` (`id`),
  ADD CONSTRAINT `workflowlogs_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowTransitions` (`id`);

--
-- Constraints for table `workflows`
--
ALTER TABLE `workflows`
  ADD CONSTRAINT `workflows_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `workflows_modifiedby_foreign` FOREIGN KEY (`modifiedBy`) REFERENCES `users` (`id`);

--
-- Constraints for table `workflowSteps`
--
ALTER TABLE `workflowSteps`
  ADD CONSTRAINT `workflowsteps_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`);

--
-- Constraints for table `workflowTransitionRoles`
--
ALTER TABLE `workflowTransitionRoles`
  ADD CONSTRAINT `workflowtransitionroles_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `workflowtransitionroles_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowTransitions` (`id`);

--
-- Constraints for table `workflowTransitions`
--
ALTER TABLE `workflowTransitions`
  ADD CONSTRAINT `workflowtransitions_fromstepid_foreign` FOREIGN KEY (`fromStepId`) REFERENCES `workflowSteps` (`id`),
  ADD CONSTRAINT `workflowtransitions_tostepid_foreign` FOREIGN KEY (`toStepId`) REFERENCES `workflowSteps` (`id`),
  ADD CONSTRAINT `workflowtransitions_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`);

--
-- Constraints for table `workflowTransitionUsers`
--
ALTER TABLE `workflowTransitionUsers`
  ADD CONSTRAINT `workflowtransitionusers_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowTransitions` (`id`),
  ADD CONSTRAINT `workflowtransitionusers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
