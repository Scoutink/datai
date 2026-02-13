-- Step 1: Papers tables
CREATE TABLE IF NOT EXISTS `papers` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `contentJson` longtext NOT NULL,
  `contentHtmlSanitized` longtext NOT NULL,
  `contentText` longtext DEFAULT NULL,
  `wordCount` int NOT NULL DEFAULT 0,
  `readingTimeMinutes` int NOT NULL DEFAULT 0,
  `categoryId` char(36) NOT NULL,
  `clientId` char(36) DEFAULT NULL,
  `statusId` char(36) DEFAULT NULL,
  `retentionPeriod` int DEFAULT NULL,
  `retentionAction` int DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` char(36) NOT NULL,
  `deletedBy` char(36) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `papers_categoryid_idx` (`categoryId`),
  KEY `papers_clientid_idx` (`clientId`),
  KEY `papers_statusid_idx` (`statusId`),
  KEY `papers_createdby_idx` (`createdBy`),
  KEY `papers_isdeleted_idx` (`isDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperMetaDatas` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `metatag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `papermetadatas_paperid_idx` (`paperId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperRolePermissions` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `roleId` char(36) NOT NULL,
  `isAllowDownload` tinyint(1) NOT NULL DEFAULT 0,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `paperrolepermissions_paperid_idx` (`paperId`),
  KEY `paperrolepermissions_roleid_idx` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperUserPermissions` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `isAllowDownload` tinyint(1) NOT NULL DEFAULT 0,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `paperuserpermissions_paperid_idx` (`paperId`),
  KEY `paperuserpermissions_userid_idx` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperVersions` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `contentJson` longtext NOT NULL,
  `contentHtmlSanitized` longtext NOT NULL,
  `contentText` longtext DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `paperversions_paperid_idx` (`paperId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperComments` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `comment` longtext NOT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` char(36) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `papercomments_paperid_idx` (`paperId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperAuditTrails` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `operationName` varchar(255) NOT NULL,
  `assignToRoleId` char(36) DEFAULT NULL,
  `assignToUserId` char(36) DEFAULT NULL,
  `createdBy` char(36) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `paperaudittrails_paperid_idx` (`paperId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperShareableLink` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `isAllowDownload` tinyint(1) NOT NULL DEFAULT 0,
  `expiryDate` datetime DEFAULT NULL,
  `createdBy` char(36) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `papershareablelink_code_unique` (`code`),
  KEY `papershareablelink_paperid_idx` (`paperId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 2: add foreign keys if missing manually as needed (host-specific constraints can vary).

-- Step 3: RBAC page + actions for Papers
SET @adminRoleId := (SELECT id FROM roles WHERE name = 'Admin' LIMIT 1);
SET @actorUserId := COALESCE((SELECT userId FROM userRoles WHERE roleId = @adminRoleId LIMIT 1), (SELECT id FROM users LIMIT 1));
SET @now := NOW();

-- If @actorUserId is NULL, stop and create at least one user first.


INSERT INTO pages (`id`, `name`, `order`, `createdBy`, `modifiedBy`, `isDeleted`, `createdDate`, `modifiedDate`)
VALUES ('5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'Papers', 100, @actorUserId, @actorUserId, 0, @now, @now)
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `order`=VALUES(`order`), `modifiedBy`=COALESCE(VALUES(`modifiedBy`), @actorUserId), `isDeleted`=0, `modifiedDate`=@now;

INSERT INTO actions (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `isDeleted`, `createdDate`, `modifiedDate`) VALUES
('8f6f8bd6-c355-4fd0-8b5f-21bdb0d96363', 'All Papers View', 1, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_VIEW_PAPERS', @actorUserId, @actorUserId, 0, @now, @now),
('f8f4caef-5018-4f00-a31c-ab09a70fe85c', 'All Papers Create', 2, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_CREATE_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('8fac6d7f-b6ad-462f-bf2d-1ef7426e96df', 'All Papers Edit', 3, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_EDIT_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('05d3b031-5d30-4f71-b7e6-586101ad7f90', 'All Papers Delete', 4, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_DELETE_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('2f2f188f-f1ed-43dd-9cca-4e1384cc4f77', 'All Papers Archive', 5, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_ARCHIVE_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('105952c5-f91d-4de7-a8a1-f8628bcf4d52', 'All Papers Detail', 6, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_VIEW_DETAIL', @actorUserId, @actorUserId, 0, @now, @now),
('31fcf6f0-f6c8-4495-8fc6-7566de8023f8', 'All Papers Comment', 7, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_MANAGE_COMMENT', @actorUserId, @actorUserId, 0, @now, @now),
('ce05f408-cd3b-4736-b65f-5383fab8ae89', 'All Papers Share Link', 8, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_MANAGE_SHARABLE_LINK', @actorUserId, @actorUserId, 0, @now, @now),
('e01e10f6-1c30-40cc-9d6b-f0eb1a9ed137', 'All Papers Restore Version', 9, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ALL_PAPERS_RESTORE_VERSION', @actorUserId, @actorUserId, 0, @now, @now),
('2b8c9725-5d19-4747-bf58-2347eb24ec43', 'Assigned Papers View', 10, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_VIEW_PAPERS', @actorUserId, @actorUserId, 0, @now, @now),
('8ec20f6f-4f45-4a7d-90ad-201f1c5f4d90', 'Assigned Papers Create', 11, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_CREATE_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('8b539f0e-1596-4ee3-a61b-fd230ea796d3', 'Assigned Papers Edit', 12, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_EDIT_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('cd1af019-c3dd-46b8-84e2-4872ec1e19e0', 'Assigned Papers Delete', 13, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_DELETE_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('220de3b7-7af0-4f62-8af7-b69abf53aa64', 'Assigned Papers Archive', 14, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_ARCHIVE_PAPER', @actorUserId, @actorUserId, 0, @now, @now),
('7bb7ceb6-05e2-4053-bb70-95ca5eca9ecc', 'Assigned Papers Detail', 15, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_VIEW_DETAIL', @actorUserId, @actorUserId, 0, @now, @now),
('d708119a-d6ed-485a-a1af-592f88ec58e6', 'Assigned Papers Comment', 16, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_MANAGE_COMMENT', @actorUserId, @actorUserId, 0, @now, @now),
('7f94fa13-763c-4f66-9d9a-e459830bf64b', 'Assigned Papers Share Link', 17, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_MANAGE_SHARABLE_LINK', @actorUserId, @actorUserId, 0, @now, @now),
('58d59555-4c7d-4a2f-95f4-4cbf0c0df3df', 'Assigned Papers Restore Version', 18, '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b', 'ASSIGNED_PAPERS_RESTORE_VERSION', @actorUserId, @actorUserId, 0, @now, @now)
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `order`=VALUES(`order`), `pageId`=VALUES(`pageId`), `code`=VALUES(`code`), `modifiedBy`=COALESCE(VALUES(`modifiedBy`), @actorUserId), `isDeleted`=0, `modifiedDate`=@now;

-- Step 4: admin role claims (missing only)
INSERT INTO roleClaims (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), a.id, @adminRoleId, a.code
FROM actions a
WHERE a.pageId = '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b'
AND @adminRoleId IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM roleClaims rc
  WHERE rc.roleId = @adminRoleId AND rc.claimType = a.code
);
