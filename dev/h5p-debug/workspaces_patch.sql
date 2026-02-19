-- Workspaces module schema patch (phpMyAdmin-safe)
-- Fix for MySQL errno 150: enforce same charset/collation as existing UUID tables.

CREATE TABLE `workspaceNodes` (
  `id` char(36) NOT NULL,
  `nodeType` varchar(40) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `workspaceRootId` char(36) DEFAULT NULL,
  `parentId` char(36) DEFAULT NULL,
  `sortIndex` int NOT NULL DEFAULT 0,
  `contentKind` varchar(20) DEFAULT NULL,
  `contentRef` char(36) DEFAULT NULL,
  `createdBy` char(36) NOT NULL,
  `modifiedBy` varchar(255) DEFAULT NULL,
  `deletedBy` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workspaceNodes_tree_idx` (`workspaceRootId`,`parentId`,`sortIndex`),
  KEY `workspaceNodes_content_idx` (`contentKind`,`contentRef`),
  CONSTRAINT `workspacenodes_createdby_fk` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `workspacenodes_parent_fk` FOREIGN KEY (`parentId`) REFERENCES `workspaceNodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `workspacenodes_root_fk` FOREIGN KEY (`workspaceRootId`) REFERENCES `workspaceNodes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `workspaceNodeFavorites` (
  `id` char(36) NOT NULL,
  `nodeId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `workspace_fav_unique` (`nodeId`,`userId`),
  CONSTRAINT `workspace_fav_node_fk` FOREIGN KEY (`nodeId`) REFERENCES `workspaceNodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `workspace_fav_user_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `workspaceNodeRecents` (
  `id` char(36) NOT NULL,
  `nodeId` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `openedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `workspace_recent_unique` (`nodeId`,`userId`),
  CONSTRAINT `workspace_recent_node_fk` FOREIGN KEY (`nodeId`) REFERENCES `workspaceNodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `workspace_recent_user_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
