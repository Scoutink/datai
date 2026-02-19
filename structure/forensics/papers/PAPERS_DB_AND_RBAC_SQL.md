# Papers DB and RBAC SQL Design

> This file defines a safe baseline SQL patch set for phpMyAdmin execution order.
> Adjust FK names if naming conflicts exist in your DB.

## Step 1 — Core papers tables
```sql
-- Step 1.1 papers main table
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
  `location` varchar(50) NOT NULL DEFAULT 'local',
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
  KEY `papers_search_name_idx` (`name`),
  KEY `papers_isdeleted_idx` (`isDeleted`),
  CONSTRAINT `papers_categoryid_fk` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`),
  CONSTRAINT `papers_clientid_fk` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`),
  CONSTRAINT `papers_statusid_fk` FOREIGN KEY (`statusId`) REFERENCES `documentStatus` (`id`),
  CONSTRAINT `papers_createdby_fk` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 1.2 paper meta tags
CREATE TABLE IF NOT EXISTS `paperMetaDatas` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `metatag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `papermetadatas_paperid_idx` (`paperId`),
  CONSTRAINT `papermetadatas_paperid_fk` FOREIGN KEY (`paperId`) REFERENCES `papers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## Step 2 — ACL/permissions tables
```sql
-- Step 2.1 role permissions
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
  KEY `paperrolepermissions_roleid_idx` (`roleId`),
  CONSTRAINT `paperrolepermissions_paperid_fk` FOREIGN KEY (`paperId`) REFERENCES `papers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `paperrolepermissions_roleid_fk` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 2.2 user permissions
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
  KEY `paperuserpermissions_userid_idx` (`userId`),
  CONSTRAINT `paperuserpermissions_paperid_fk` FOREIGN KEY (`paperId`) REFERENCES `papers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `paperuserpermissions_userid_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## Step 3 — Versions, comments, audits, share links, tokens
```sql
CREATE TABLE IF NOT EXISTS `paperVersions` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `contentJson` longtext NOT NULL,
  `contentHtmlSanitized` longtext NOT NULL,
  `contentText` longtext DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `paperversions_paperid_idx` (`paperId`),
  CONSTRAINT `paperversions_paperid_fk` FOREIGN KEY (`paperId`) REFERENCES `papers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `paperComments` (
  `id` char(36) NOT NULL,
  `paperId` char(36) NOT NULL,
  `comment` longtext NOT NULL,
  `createdBy` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `papercomments_paperid_idx` (`paperId`),
  CONSTRAINT `papercomments_paperid_fk` FOREIGN KEY (`paperId`) REFERENCES `papers` (`id`) ON DELETE CASCADE
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
  KEY `paperaudittrails_paperid_idx` (`paperId`),
  CONSTRAINT `paperaudittrails_paperid_fk` FOREIGN KEY (`paperId`) REFERENCES `papers` (`id`) ON DELETE CASCADE
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
  KEY `papershareablelink_paperid_idx` (`paperId`),
  CONSTRAINT `papershareablelink_paperid_fk` FOREIGN KEY (`paperId`) REFERENCES `papers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## Step 4 — RBAC seeds (pages/actions/roleClaims)
Use `pages` + `actions` + `roleClaims` exactly like Documents/Boards seeder style.

Recommended `pages.name`: `Papers`

Minimum action codes to insert:
- `ALL_PAPERS_VIEW_PAPERS`, `ALL_PAPERS_CREATE_PAPER`, `ALL_PAPERS_EDIT_PAPER`, `ALL_PAPERS_DELETE_PAPER`, `ALL_PAPERS_ARCHIVE_PAPER`, `ALL_PAPERS_VIEW_DETAIL`
- `ALL_PAPERS_MANAGE_COMMENT`, `ALL_PAPERS_SHARE_PAPER`, `ALL_PAPERS_MANAGE_SHARABLE_LINK`, `ALL_PAPERS_VIEW_VERSION_HISTORY`, `ALL_PAPERS_RESTORE_VERSION`, `ALL_PAPERS_DOWNLOAD_PAPER`
- `ASSIGNED_PAPERS_VIEW_PAPERS`, `ASSIGNED_PAPERS_VIEW_DETAIL`, `ASSIGNED_PAPERS_EDIT_PAPER`, `ASSIGNED_PAPERS_MANAGE_COMMENT`, `ASSIGNED_PAPERS_SHARE_PAPER`

## Step 5 — Rollback note
If this patch is applied in production and causes dependency conflicts, rollback is not safely trivial due to FK relationships.
Recommended rollback: restore pre-change DB backup.
