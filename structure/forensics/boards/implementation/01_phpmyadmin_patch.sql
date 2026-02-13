-- DATAI Boards implementation patch (manual phpMyAdmin execution)
-- Safe/idempotent style for existing production databases.

START TRANSACTION;

-- ============================================
-- 1) Milestone tables (for /api/boards/{id}/milestones)
-- ============================================
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
  PRIMARY KEY (`id`),
  KEY `boardmilestones_boardid_idx` (`boardId`),
  KEY `boardmilestones_createdby_idx` (`createdBy`),
  KEY `boardmilestones_modifiedby_idx` (`modifiedBy`),
  CONSTRAINT `boardmilestones_boardid_fk` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE,
  CONSTRAINT `boardmilestones_createdby_fk` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `boardmilestones_modifiedby_fk` FOREIGN KEY (`modifiedBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `boardCardMilestones` (
  `cardId` char(36) NOT NULL,
  `milestoneId` char(36) NOT NULL,
  PRIMARY KEY (`cardId`, `milestoneId`),
  CONSTRAINT `boardcardmilestones_cardid_fk` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE,
  CONSTRAINT `boardcardmilestones_milestoneid_fk` FOREIGN KEY (`milestoneId`) REFERENCES `boardMilestones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 2) Boards RBAC page/actions/claims
-- ============================================
SET @adminRoleId := (SELECT id FROM roles WHERE name = 'Admin' LIMIT 1);
SET @now := NOW();

-- Boards page
INSERT INTO pages (`id`, `name`, `order`, `createdBy`, `modifiedBy`, `isDeleted`, `createdDate`, `modifiedDate`)
VALUES ('8e44d175-f17d-4544-acf7-b88bcf2ff001', 'Boards', 99, @adminRoleId, @adminRoleId, 0, @now, @now)
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`),
  `order` = VALUES(`order`),
  `modifiedBy` = VALUES(`modifiedBy`),
  `isDeleted` = 0,
  `modifiedDate` = @now;

-- Boards actions
INSERT INTO actions (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `isDeleted`, `createdDate`, `modifiedDate`)
VALUES
('53b1c8e4-46af-43ed-b4e9-c05f56ef57ab', 'View Boards', 1, '8e44d175-f17d-4544-acf7-b88bcf2ff001', 'BOARDS_VIEW_BOARDS', @adminRoleId, @adminRoleId, 0, @now, @now),
('0815f423-6882-4d37-8fb2-a78e34b0e7f6', 'Create Board', 2, '8e44d175-f17d-4544-acf7-b88bcf2ff001', 'BOARDS_CREATE_BOARD', @adminRoleId, @adminRoleId, 0, @now, @now),
('2f2a2d4f-c9f6-4b36-b95b-fe54d2391f18', 'Edit Board', 3, '8e44d175-f17d-4544-acf7-b88bcf2ff001', 'BOARDS_EDIT_BOARD', @adminRoleId, @adminRoleId, 0, @now, @now),
('bc7e0b5b-90d8-4e3f-b76d-575a72744d37', 'Delete Board', 4, '8e44d175-f17d-4544-acf7-b88bcf2ff001', 'BOARDS_DELETE_BOARD', @adminRoleId, @adminRoleId, 0, @now, @now),
('dfbf13ac-811f-4e36-a04c-a95cc267b8d7', 'Manage Cards', 5, '8e44d175-f17d-4544-acf7-b88bcf2ff001', 'BOARDS_MANAGE_CARDS', @adminRoleId, @adminRoleId, 0, @now, @now)
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`),
  `order` = VALUES(`order`),
  `pageId` = VALUES(`pageId`),
  `code` = VALUES(`code`),
  `modifiedBy` = VALUES(`modifiedBy`),
  `isDeleted` = 0,
  `modifiedDate` = @now;

-- Admin role claims (insert only if missing)
INSERT INTO roleClaims (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), a.id, @adminRoleId, a.code
FROM actions a
WHERE a.id IN (
  '53b1c8e4-46af-43ed-b4e9-c05f56ef57ab',
  '0815f423-6882-4d37-8fb2-a78e34b0e7f6',
  '2f2a2d4f-c9f6-4b36-b95b-fe54d2391f18',
  'bc7e0b5b-90d8-4e3f-b76d-575a72744d37',
  'dfbf13ac-811f-4e36-a04c-a95cc267b8d7'
)
AND @adminRoleId IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM roleClaims rc
  WHERE rc.roleId = @adminRoleId
    AND rc.claimType = a.code
);

COMMIT;
