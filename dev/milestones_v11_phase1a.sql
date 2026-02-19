-- Phase 1A: Milestones Database Migration
-- Purpose: Support board-level milestones and multi-milestone card association.

CREATE TABLE `boardMilestones` (
  `id` char(36) NOT NULL,
  `boardId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(50) DEFAULT '#0079bf',
  `createdBy` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedBy` char(36) DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `boardCardMilestones` (
  `cardId` char(36) NOT NULL,
  `milestoneId` char(36) NOT NULL,
  PRIMARY KEY (`cardId`,`milestoneId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
