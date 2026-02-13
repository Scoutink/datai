-- =============================================================
-- DATAI Papers Module - RBAC SQL Patch
-- Date: 2026-02-13
-- Purpose: Add pages, actions, and roleClaims for Papers module
-- Run in phpMyAdmin in the correct order
-- =============================================================

SET @createdBy = '99365f7c-9b0e-4af3-bfdd-8944e5c41b96';
SET @now = NOW();

-- =============================================================
-- Step 1: Insert Pages
-- =============================================================

-- All Papers page
INSERT INTO `pages` (`id`, `name`, `order`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'a1b2c3d4-0001-4000-a000-000000000001', 'All Papers', 10, @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `pages` WHERE `id` = 'a1b2c3d4-0001-4000-a000-000000000001');

-- My Papers page
INSERT INTO `pages` (`id`, `name`, `order`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'a1b2c3d4-0002-4000-a000-000000000002', 'My Papers', 11, @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `pages` WHERE `id` = 'a1b2c3d4-0002-4000-a000-000000000002');

-- =============================================================
-- Step 2: Insert Actions for "All Papers" page
-- =============================================================

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0001-4000-b000-000000000001', 'View Papers', 1, 'a1b2c3d4-0001-4000-a000-000000000001', 'ALL_PAPERS_VIEW_PAPERS', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'ALL_PAPERS_VIEW_PAPERS');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0002-4000-b000-000000000002', 'Create Paper', 2, 'a1b2c3d4-0001-4000-a000-000000000001', 'ALL_PAPERS_CREATE_PAPER', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'ALL_PAPERS_CREATE_PAPER');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0003-4000-b000-000000000003', 'Edit Paper', 3, 'a1b2c3d4-0001-4000-a000-000000000001', 'ALL_PAPERS_EDIT_PAPER', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'ALL_PAPERS_EDIT_PAPER');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0004-4000-b000-000000000004', 'Delete Paper', 4, 'a1b2c3d4-0001-4000-a000-000000000001', 'ALL_PAPERS_DELETE_PAPER', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'ALL_PAPERS_DELETE_PAPER');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0005-4000-b000-000000000005', 'View Permission', 5, 'a1b2c3d4-0001-4000-a000-000000000001', 'PAPER_PERMISSION_VIEW', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'PAPER_PERMISSION_VIEW');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0006-4000-b000-000000000006', 'Manage Permission', 6, 'a1b2c3d4-0001-4000-a000-000000000001', 'PAPER_PERMISSION_MANAGE', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'PAPER_PERMISSION_MANAGE');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0007-4000-b000-000000000007', 'View History', 7, 'a1b2c3d4-0001-4000-a000-000000000001', 'PAPER_HISTORY_VIEW', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'PAPER_HISTORY_VIEW');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0008-4000-b000-000000000008', 'Restore Version', 8, 'a1b2c3d4-0001-4000-a000-000000000001', 'PAPER_HISTORY_RESTORE', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'PAPER_HISTORY_RESTORE');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0009-4000-b000-000000000009', 'View Audit Trail', 9, 'a1b2c3d4-0001-4000-a000-000000000001', 'PAPER_AUDIT_VIEW', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'PAPER_AUDIT_VIEW');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0010-4000-b000-000000000010', 'Manage Share Link', 10, 'a1b2c3d4-0001-4000-a000-000000000001', 'PAPER_SHARE_MANAGE', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'PAPER_SHARE_MANAGE');

-- =============================================================
-- Step 3: Insert Actions for "My Papers" page
-- =============================================================

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0011-4000-b000-000000000011', 'View Papers', 1, 'a1b2c3d4-0002-4000-a000-000000000002', 'MY_PAPERS_VIEW_PAPERS', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'MY_PAPERS_VIEW_PAPERS');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0012-4000-b000-000000000012', 'Create Paper', 2, 'a1b2c3d4-0002-4000-a000-000000000002', 'MY_PAPERS_CREATE_PAPER', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'MY_PAPERS_CREATE_PAPER');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0013-4000-b000-000000000013', 'Edit Paper', 3, 'a1b2c3d4-0002-4000-a000-000000000002', 'MY_PAPERS_EDIT_PAPER', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'MY_PAPERS_EDIT_PAPER');

INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`)
SELECT 'b1b2c3d4-0014-4000-b000-000000000014', 'Delete Paper', 4, 'a1b2c3d4-0002-4000-a000-000000000002', 'MY_PAPERS_DELETE_PAPER', @createdBy, @createdBy, NULL, 0, @now, @now, NULL
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `actions` WHERE `code` = 'MY_PAPERS_DELETE_PAPER');

-- =============================================================
-- Step 4: Grant all Paper actions to ALL existing roles
-- roleClaims table has: id, roleId, actionId, claimType
-- claimType stores the claim code string (matching actions.code)
-- =============================================================

-- ALL_PAPERS_VIEW_PAPERS
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0001-4000-b000-000000000001', r.`id`, 'ALL_PAPERS_VIEW_PAPERS'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'ALL_PAPERS_VIEW_PAPERS'
);

-- ALL_PAPERS_CREATE_PAPER
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0002-4000-b000-000000000002', r.`id`, 'ALL_PAPERS_CREATE_PAPER'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'ALL_PAPERS_CREATE_PAPER'
);

-- ALL_PAPERS_EDIT_PAPER
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0003-4000-b000-000000000003', r.`id`, 'ALL_PAPERS_EDIT_PAPER'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'ALL_PAPERS_EDIT_PAPER'
);

-- ALL_PAPERS_DELETE_PAPER
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0004-4000-b000-000000000004', r.`id`, 'ALL_PAPERS_DELETE_PAPER'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'ALL_PAPERS_DELETE_PAPER'
);

-- PAPER_PERMISSION_VIEW
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0005-4000-b000-000000000005', r.`id`, 'PAPER_PERMISSION_VIEW'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'PAPER_PERMISSION_VIEW'
);

-- PAPER_PERMISSION_MANAGE
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0006-4000-b000-000000000006', r.`id`, 'PAPER_PERMISSION_MANAGE'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'PAPER_PERMISSION_MANAGE'
);

-- PAPER_HISTORY_VIEW
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0007-4000-b000-000000000007', r.`id`, 'PAPER_HISTORY_VIEW'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'PAPER_HISTORY_VIEW'
);

-- PAPER_HISTORY_RESTORE
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0008-4000-b000-000000000008', r.`id`, 'PAPER_HISTORY_RESTORE'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'PAPER_HISTORY_RESTORE'
);

-- PAPER_AUDIT_VIEW
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0009-4000-b000-000000000009', r.`id`, 'PAPER_AUDIT_VIEW'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'PAPER_AUDIT_VIEW'
);

-- PAPER_SHARE_MANAGE
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0010-4000-b000-000000000010', r.`id`, 'PAPER_SHARE_MANAGE'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'PAPER_SHARE_MANAGE'
);

-- MY_PAPERS_VIEW_PAPERS
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0011-4000-b000-000000000011', r.`id`, 'MY_PAPERS_VIEW_PAPERS'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'MY_PAPERS_VIEW_PAPERS'
);

-- MY_PAPERS_CREATE_PAPER
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0012-4000-b000-000000000012', r.`id`, 'MY_PAPERS_CREATE_PAPER'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'MY_PAPERS_CREATE_PAPER'
);

-- MY_PAPERS_EDIT_PAPER
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0013-4000-b000-000000000013', r.`id`, 'MY_PAPERS_EDIT_PAPER'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'MY_PAPERS_EDIT_PAPER'
);

-- MY_PAPERS_DELETE_PAPER
INSERT INTO `roleClaims` (`id`, `actionId`, `roleId`, `claimType`)
SELECT UUID(), 'b1b2c3d4-0014-4000-b000-000000000014', r.`id`, 'MY_PAPERS_DELETE_PAPER'
FROM `roles` r
WHERE NOT EXISTS (
    SELECT 1 FROM `roleClaims` rc WHERE rc.`roleId` = r.`id` AND rc.`claimType` = 'MY_PAPERS_DELETE_PAPER'
);

-- =============================================================
-- IMPORTANT: After running this SQL, users MUST LOG OUT and
-- LOG BACK IN for the new claims to take effect in their JWT.
-- =============================================================

-- Verification queries (uncomment to run):
-- SELECT * FROM `pages` WHERE `name` LIKE '%Paper%';
-- SELECT * FROM `actions` WHERE `code` LIKE '%PAPER%';
-- SELECT * FROM `roleClaims` WHERE `claimType` LIKE '%PAPER%';
