-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 11, 2026 at 06:56 PM
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

DROP TABLE IF EXISTS `actions`;
CREATE TABLE IF NOT EXISTS `actions` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `actions_pageid_foreign` (`pageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aiPromptTemplates`
--

DROP TABLE IF EXISTS `aiPromptTemplates`;
CREATE TABLE IF NOT EXISTS `aiPromptTemplates` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `promptInput` varchar(255) NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `allowFileExtensions`
--

DROP TABLE IF EXISTS `allowFileExtensions`;
CREATE TABLE IF NOT EXISTS `allowFileExtensions` (
  `id` char(36) NOT NULL,
  `fileType` tinyint(4) NOT NULL,
  `extensions` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardActivities`
--

DROP TABLE IF EXISTS `boardCardActivities`;
CREATE TABLE IF NOT EXISTS `boardCardActivities` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `type` enum('comment','note','attachment_link','system_log') DEFAULT 'comment',
  `content` longtext NOT NULL,
  `attachmentId` char(36) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `boardcardactivities_cardid_foreign` (`cardId`),
  KEY `boardcardactivities_userid_foreign` (`userId`),
  KEY `boardcardactivities_attachment_foreign` (`attachmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardAssignees`
--

DROP TABLE IF EXISTS `boardCardAssignees`;
CREATE TABLE IF NOT EXISTS `boardCardAssignees` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_user_unique` (`cardId`,`userId`),
  KEY `boardcardassignees_userid_foreign` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardAttachments`
--

DROP TABLE IF EXISTS `boardCardAttachments`;
CREATE TABLE IF NOT EXISTS `boardCardAttachments` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_boardCardAttachments_cardId` (`cardId`),
  KEY `fk_boardCardAttachments_documentId` (`documentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardChecklistItems`
--

DROP TABLE IF EXISTS `boardCardChecklistItems`;
CREATE TABLE IF NOT EXISTS `boardCardChecklistItems` (
  `id` char(36) NOT NULL,
  `checklistId` char(36) NOT NULL,
  `name` text NOT NULL,
  `isCompleted` tinyint(1) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `boardcardchecklistitems_checklistid_foreign` (`checklistId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardChecklists`
--

DROP TABLE IF EXISTS `boardCardChecklists`;
CREATE TABLE IF NOT EXISTS `boardCardChecklists` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `boardcardchecklists_cardid_foreign` (`cardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardFollowers`
--

DROP TABLE IF EXISTS `boardCardFollowers`;
CREATE TABLE IF NOT EXISTS `boardCardFollowers` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_follower_unique` (`cardId`,`userId`),
  KEY `boardcardfollowers_userid_foreign` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardLabels`
--

DROP TABLE IF EXISTS `boardCardLabels`;
CREATE TABLE IF NOT EXISTS `boardCardLabels` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `labelId` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_label_unique` (`cardId`,`labelId`),
  KEY `boardcardlabels_labelid_foreign` (`labelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardMilestones`
--

DROP TABLE IF EXISTS `boardCardMilestones`;
CREATE TABLE IF NOT EXISTS `boardCardMilestones` (
  `cardId` char(36) NOT NULL,
  `milestoneId` char(36) NOT NULL,
  PRIMARY KEY (`cardId`,`milestoneId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCards`
--

DROP TABLE IF EXISTS `boardCards`;
CREATE TABLE IF NOT EXISTS `boardCards` (
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
  `isCompleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `boardcards_columnid_foreign` (`columnId`),
  KEY `boardcards_boardid_foreign` (`boardId`),
  KEY `boardcards_documentid_foreign` (`documentId`),
  KEY `boardcards_executorid_foreign` (`executorId`),
  KEY `boardcards_approverid_foreign` (`approverId`),
  KEY `boardcards_supervisorid_foreign` (`supervisorId`),
  KEY `boardcards_parentcardid_foreign` (`parentCardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardCardTags`
--

DROP TABLE IF EXISTS `boardCardTags`;
CREATE TABLE IF NOT EXISTS `boardCardTags` (
  `id` char(36) NOT NULL,
  `cardId` char(36) NOT NULL,
  `tagId` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_tag_unique` (`cardId`,`tagId`),
  KEY `boardcardtags_tagid_foreign` (`tagId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardColumns`
--

DROP TABLE IF EXISTS `boardColumns`;
CREATE TABLE IF NOT EXISTS `boardColumns` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boardcolumns_boardid_foreign` (`boardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardLabels`
--

DROP TABLE IF EXISTS `boardLabels`;
CREATE TABLE IF NOT EXISTS `boardLabels` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL DEFAULT '#61bd4f',
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `boardlabels_boardid_foreign` (`boardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardMilestones`
--

DROP TABLE IF EXISTS `boardMilestones`;
CREATE TABLE IF NOT EXISTS `boardMilestones` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(50) DEFAULT '#0079bf',
  `createdBy` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedBy` char(36) DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boards`
--

DROP TABLE IF EXISTS `boards`;
CREATE TABLE IF NOT EXISTS `boards` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boards_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boardTags`
--

DROP TABLE IF EXISTS `boardTags`;
CREATE TABLE IF NOT EXISTS `boardTags` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL DEFAULT '#61bd4f',
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `boardtags_boardid_foreign` (`boardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parentid_foreign` (`parentId`),
  KEY `idx_categories_hierarchy_path` (`hierarchyPath`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companyProfile`
--

DROP TABLE IF EXISTS `companyProfile`;
CREATE TABLE IF NOT EXISTS `companyProfile` (
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
  `loginAuditRetentionPeriod` int(11) DEFAULT 30,
  PRIMARY KEY (`id`),
  KEY `companyprofile_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cronJobLogs`
--

DROP TABLE IF EXISTS `cronJobLogs`;
CREATE TABLE IF NOT EXISTS `cronJobLogs` (
  `id` char(36) NOT NULL,
  `jobName` varchar(255) NOT NULL,
  `status` enum('success','failed') NOT NULL DEFAULT 'success',
  `output` text DEFAULT NULL,
  `executionTime` int(11) DEFAULT NULL,
  `startedAt` timestamp NULL DEFAULT NULL,
  `endedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dailyReminders`
--

DROP TABLE IF EXISTS `dailyReminders`;
CREATE TABLE IF NOT EXISTS `dailyReminders` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `dayOfWeek` int(11) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dailyreminders_reminderid_foreign` (`reminderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentAuditTrails`
--

DROP TABLE IF EXISTS `documentAuditTrails`;
CREATE TABLE IF NOT EXISTS `documentAuditTrails` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentaudittrails_documentid_foreign` (`documentId`),
  KEY `documentaudittrails_assigntouserid_foreign` (`assignToUserId`),
  KEY `documentaudittrails_assigntoroleid_foreign` (`assignToRoleId`),
  KEY `documentaudittrails_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentComments`
--

DROP TABLE IF EXISTS `documentComments`;
CREATE TABLE IF NOT EXISTS `documentComments` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentcomments_documentid_foreign` (`documentId`),
  KEY `documentcomments_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentMetaDatas`
--

DROP TABLE IF EXISTS `documentMetaDatas`;
CREATE TABLE IF NOT EXISTS `documentMetaDatas` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `metatag` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentmetadatas_documentid_foreign` (`documentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentRolePermissions`
--

DROP TABLE IF EXISTS `documentRolePermissions`;
CREATE TABLE IF NOT EXISTS `documentRolePermissions` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentrolepermissions_documentid_foreign` (`documentId`),
  KEY `documentrolepermissions_roleid_foreign` (`roleId`),
  KEY `documentrolepermissions_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
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
  `expiredDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_categoryid_foreign` (`categoryId`),
  KEY `documents_createdby_foreign` (`createdBy`),
  KEY `documents_clientid_foreign` (`clientId`),
  KEY `documents_statusid_foreign` (`statusId`),
  KEY `documents_documentworkflowid_foreign` (`documentWorkflowId`),
  KEY `documents_signbyid_foreign` (`signById`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentShareableLink`
--

DROP TABLE IF EXISTS `documentShareableLink`;
CREATE TABLE IF NOT EXISTS `documentShareableLink` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentshareablelink_documentid_foreign` (`documentId`),
  KEY `documentshareablelink_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentSignatures`
--

DROP TABLE IF EXISTS `documentSignatures`;
CREATE TABLE IF NOT EXISTS `documentSignatures` (
  `id` char(36) NOT NULL,
  `documentId` char(36) NOT NULL,
  `createdBy` char(36) NOT NULL,
  `signatureUrl` varchar(255) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `documentsignatures_documentid_foreign` (`documentId`),
  KEY `documentsignatures_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentStatus`
--

DROP TABLE IF EXISTS `documentStatus`;
CREATE TABLE IF NOT EXISTS `documentStatus` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentstatus_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentTokens`
--

DROP TABLE IF EXISTS `documentTokens`;
CREATE TABLE IF NOT EXISTS `documentTokens` (
  `id` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `documentId` char(36) NOT NULL,
  `token` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentUserPermissions`
--

DROP TABLE IF EXISTS `documentUserPermissions`;
CREATE TABLE IF NOT EXISTS `documentUserPermissions` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentuserpermissions_documentid_foreign` (`documentId`),
  KEY `documentuserpermissions_userid_foreign` (`userId`),
  KEY `documentuserpermissions_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentVersions`
--

DROP TABLE IF EXISTS `documentVersions`;
CREATE TABLE IF NOT EXISTS `documentVersions` (
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
  `signDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentversions_documentid_foreign` (`documentId`),
  KEY `documentversions_createdby_foreign` (`createdBy`),
  KEY `documentversions_signbyid_foreign` (`signById`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentWorkflow`
--

DROP TABLE IF EXISTS `documentWorkflow`;
CREATE TABLE IF NOT EXISTS `documentWorkflow` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentworkflow_createdby_foreign` (`createdBy`),
  KEY `documentworkflow_documentid_foreign` (`documentId`),
  KEY `documentworkflow_workflowid_foreign` (`workflowId`),
  KEY `documentworkflow_currentstepid_foreign` (`currentStepId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailLogAttachments`
--

DROP TABLE IF EXISTS `emailLogAttachments`;
CREATE TABLE IF NOT EXISTS `emailLogAttachments` (
  `id` char(36) NOT NULL,
  `emailLogId` char(36) NOT NULL,
  `path` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `emaillogattachments_emaillogid_foreign` (`emailLogId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailLogs`
--

DROP TABLE IF EXISTS `emailLogs`;
CREATE TABLE IF NOT EXISTS `emailLogs` (
  `id` char(36) NOT NULL,
  `senderEmail` varchar(255) NOT NULL,
  `recipientEmail` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `status` enum('sent','failed') NOT NULL DEFAULT 'sent',
  `errorMessage` text DEFAULT NULL,
  `sentAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailSMTPSettings`
--

DROP TABLE IF EXISTS `emailSMTPSettings`;
CREATE TABLE IF NOT EXISTS `emailSMTPSettings` (
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
  `fromEmail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fileRequestDocuments`
--

DROP TABLE IF EXISTS `fileRequestDocuments`;
CREATE TABLE IF NOT EXISTS `fileRequestDocuments` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `fileRequestId` char(36) NOT NULL,
  `fileRequestDocumentStatus` tinyint(4) NOT NULL DEFAULT 0,
  `approvedRejectedDate` datetime DEFAULT NULL,
  `approvalOrRejectedById` char(36) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filerequestdocuments_filerequestid_foreign` (`fileRequestId`),
  KEY `filerequestdocuments_approvalorrejectedbyid_foreign` (`approvalOrRejectedById`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fileRequests`
--

DROP TABLE IF EXISTS `fileRequests`;
CREATE TABLE IF NOT EXISTS `fileRequests` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `filerequests_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `halfYearlyReminders`
--

DROP TABLE IF EXISTS `halfYearlyReminders`;
CREATE TABLE IF NOT EXISTS `halfYearlyReminders` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `day` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `quarter` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `halfyearlyreminders_reminderid_foreign` (`reminderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
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
  `isRTL` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `languages_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loginAudits`
--

DROP TABLE IF EXISTS `loginAudits`;
CREATE TABLE IF NOT EXISTS `loginAudits` (
  `id` char(36) NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `loginTime` varchar(255) NOT NULL,
  `remoteIP` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openaiDocuments`
--

DROP TABLE IF EXISTS `openaiDocuments`;
CREATE TABLE IF NOT EXISTS `openaiDocuments` (
  `id` char(36) NOT NULL,
  `prompt` text NOT NULL,
  `model` text NOT NULL,
  `language` text DEFAULT NULL,
  `maximumLength` int(11) DEFAULT NULL,
  `creativity` decimal(18,2) DEFAULT NULL,
  `toneOfVoice` text DEFAULT NULL,
  `response` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pageHelper`
--

DROP TABLE IF EXISTS `pageHelper`;
CREATE TABLE IF NOT EXISTS `pageHelper` (
  `id` char(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `createdBy` varchar(255) DEFAULT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quarterlyReminders`
--

DROP TABLE IF EXISTS `quarterlyReminders`;
CREATE TABLE IF NOT EXISTS `quarterlyReminders` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `day` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `quarter` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quarterlyreminders_reminderid_foreign` (`reminderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminderNotifications`
--

DROP TABLE IF EXISTS `reminderNotifications`;
CREATE TABLE IF NOT EXISTS `reminderNotifications` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fetchDateTime` datetime NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `isEmailNotification` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `remindernotifications_reminderid_foreign` (`reminderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
CREATE TABLE IF NOT EXISTS `reminders` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminders_documentid_foreign` (`documentId`),
  KEY `reminders_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminderSchedulers`
--

DROP TABLE IF EXISTS `reminderSchedulers`;
CREATE TABLE IF NOT EXISTS `reminderSchedulers` (
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
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminderschedulers_documentid_foreign` (`documentId`),
  KEY `reminderschedulers_userid_foreign` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminderUsers`
--

DROP TABLE IF EXISTS `reminderUsers`;
CREATE TABLE IF NOT EXISTS `reminderUsers` (
  `id` char(36) NOT NULL,
  `reminderId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reminderusers_reminderid_foreign` (`reminderId`),
  KEY `reminderusers_userid_foreign` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roleClaims`
--

DROP TABLE IF EXISTS `roleClaims`;
CREATE TABLE IF NOT EXISTS `roleClaims` (
  `id` char(36) NOT NULL,
  `actionId` char(36) NOT NULL,
  `roleId` char(36) NOT NULL,
  `claimType` varchar(255) DEFAULT NULL,
  `claimValue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleclaims_actionid_foreign` (`actionId`),
  KEY `roleclaims_roleid_foreign` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seed_history`
--

DROP TABLE IF EXISTS `seed_history`;
CREATE TABLE IF NOT EXISTS `seed_history` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seeder_class` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seed_history_seeder_class_unique` (`seeder_class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sendEmails`
--

DROP TABLE IF EXISTS `sendEmails`;
CREATE TABLE IF NOT EXISTS `sendEmails` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sendemails_documentid_foreign` (`documentId`),
  KEY `sendemails_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userClaims`
--

DROP TABLE IF EXISTS `userClaims`;
CREATE TABLE IF NOT EXISTS `userClaims` (
  `id` char(36) NOT NULL,
  `actionId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `claimType` varchar(255) DEFAULT NULL,
  `claimValue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userclaims_actionid_foreign` (`actionId`),
  KEY `userclaims_userid_foreign` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userNotifications`
--

DROP TABLE IF EXISTS `userNotifications`;
CREATE TABLE IF NOT EXISTS `userNotifications` (
  `id` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `isRead` tinyint(1) NOT NULL,
  `documentId` char(36) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `notificationType` int(11) NOT NULL DEFAULT 0,
  `documentWorkflowId` char(36) DEFAULT NULL,
  `fileRequestId` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usernotifications_userid_foreign` (`userId`),
  KEY `usernotifications_documentid_foreign` (`documentId`),
  KEY `usernotifications_documentworkflowid_foreign` (`documentWorkflowId`),
  KEY `usernotifications_filerequestid_foreign` (`fileRequestId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userRoles`
--

DROP TABLE IF EXISTS `userRoles`;
CREATE TABLE IF NOT EXISTS `userRoles` (
  `id` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `roleId` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userroles_userid_foreign` (`userId`),
  KEY `userroles_roleid_foreign` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
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
  `isSystemUser` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowLogs`
--

DROP TABLE IF EXISTS `workflowLogs`;
CREATE TABLE IF NOT EXISTS `workflowLogs` (
  `id` char(36) NOT NULL,
  `documentWorkflowId` char(36) NOT NULL,
  `transitionId` char(36) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `type` enum('Transition','Initiated','Cancelled') NOT NULL DEFAULT 'Transition',
  `createdBy` char(36) NOT NULL,
  `deletedBy` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowlogs_documentworkflowid_foreign` (`documentWorkflowId`),
  KEY `workflowlogs_transitionid_foreign` (`transitionId`),
  KEY `workflowlogs_createdby_foreign` (`createdBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflows`
--

DROP TABLE IF EXISTS `workflows`;
CREATE TABLE IF NOT EXISTS `workflows` (
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflows_createdby_foreign` (`createdBy`),
  KEY `workflows_modifiedby_foreign` (`modifiedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowSteps`
--

DROP TABLE IF EXISTS `workflowSteps`;
CREATE TABLE IF NOT EXISTS `workflowSteps` (
  `id` char(36) NOT NULL,
  `workflowId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowsteps_workflowid_foreign` (`workflowId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowTransitionRoles`
--

DROP TABLE IF EXISTS `workflowTransitionRoles`;
CREATE TABLE IF NOT EXISTS `workflowTransitionRoles` (
  `id` char(36) NOT NULL,
  `roleId` char(36) NOT NULL,
  `transitionId` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowtransitionroles_roleid_foreign` (`roleId`),
  KEY `workflowtransitionroles_transitionid_foreign` (`transitionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowTransitions`
--

DROP TABLE IF EXISTS `workflowTransitions`;
CREATE TABLE IF NOT EXISTS `workflowTransitions` (
  `id` char(36) NOT NULL,
  `workflowId` char(36) NOT NULL,
  `fromStepId` char(36) NOT NULL,
  `toStepId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `orderNo` int(11) NOT NULL,
  `isFirstTransaction` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `workflowtransitions_workflowid_foreign` (`workflowId`),
  KEY `workflowtransitions_fromstepid_foreign` (`fromStepId`),
  KEY `workflowtransitions_tostepid_foreign` (`toStepId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflowTransitionUsers`
--

DROP TABLE IF EXISTS `workflowTransitionUsers`;
CREATE TABLE IF NOT EXISTS `workflowTransitionUsers` (
  `id` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `transitionId` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowtransitionusers_userid_foreign` (`userId`),
  KEY `workflowtransitionusers_transitionid_foreign` (`transitionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
