-- Migration: Add hierarchyPath to categories table
ALTER TABLE `categories` ADD COLUMN `hierarchyPath` VARCHAR(1000) DEFAULT NULL AFTER `parentId`;
CREATE INDEX `idx_categories_hierarchy_path` ON `categories` (`hierarchyPath`);

-- Note: hierarchyPath will be populated by the application logic during the next update/create cycle 
-- or via a one-time maintenance script.
