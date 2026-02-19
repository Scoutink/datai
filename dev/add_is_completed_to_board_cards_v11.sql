-- Add missing isCompleted column to boardCards table
-- This column is required for calculating milestone progress.

ALTER TABLE `boardCards` ADD COLUMN `isCompleted` tinyint(1) NOT NULL DEFAULT '0' AFTER `isArchived`;
