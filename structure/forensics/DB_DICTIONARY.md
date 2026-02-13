# DB Dictionary (forensic, code-first)

Generated from `structure/database/datai_light.sql` and `structure/database/datai_with_data.sql`.

## `actions`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, order, pageId, code, createdBy, modifiedBy, deletedBy ...
- Foreign keys: ADD CONSTRAINT `actions_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`)
- Indexes: KEY `actions_pageid_foreign` (`pageId`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `aiPromptTemplates`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, description, promptInput, modifiedDate, deleted_at
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `allowFileExtensions`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, fileType, extensions
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardActivities`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, cardId, userId, type, content, attachmentId, createdDate
- Foreign keys: ADD CONSTRAINT `boardcardactivities_attachment_foreign` FOREIGN KEY (`attachmentId`) REFERENCES `documents` (`id`) ON DELETE SET NULL; ADD CONSTRAINT `boardcardactivities_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `boardcardactivities_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
- Indexes: KEY `boardcardactivities_cardid_foreign` (`cardId`); KEY `boardcardactivities_userid_foreign` (`userId`); KEY `boardcardactivities_attachment_foreign` (`attachmentId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardAssignees`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, cardId, userId, createdDate
- Foreign keys: ADD CONSTRAINT `boardcardassignees_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `boardcardassignees_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
- Indexes: UNIQUE KEY `card_user_unique` (`cardId`,`userId`); KEY `boardcardassignees_userid_foreign` (`userId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardAttachments`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, cardId, documentId, createdDate
- Foreign keys: ADD CONSTRAINT `fk_boardCardAttachments_cardId` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `fk_boardCardAttachments_documentId` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`) ON DELETE CASCADE
- Indexes: KEY `fk_boardCardAttachments_cardId` (`cardId`); KEY `fk_boardCardAttachments_documentId` (`documentId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardChecklistItems`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, checklistId, name, isCompleted, position, createdDate
- Foreign keys: ADD CONSTRAINT `boardcardchecklistitems_checklistid_foreign` FOREIGN KEY (`checklistId`) REFERENCES `boardCardChecklists` (`id`) ON DELETE CASCADE
- Indexes: KEY `boardcardchecklistitems_checklistid_foreign` (`checklistId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardChecklists`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, cardId, name, createdDate
- Foreign keys: ADD CONSTRAINT `boardcardchecklists_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE
- Indexes: KEY `boardcardchecklists_cardid_foreign` (`cardId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardFollowers`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, cardId, userId, createdDate
- Foreign keys: ADD CONSTRAINT `boardcardfollowers_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `boardcardfollowers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
- Indexes: UNIQUE KEY `card_follower_unique` (`cardId`,`userId`); KEY `boardcardfollowers_userid_foreign` (`userId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardLabels`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, cardId, labelId
- Foreign keys: ADD CONSTRAINT `boardcardlabels_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `boardcardlabels_labelid_foreign` FOREIGN KEY (`labelId`) REFERENCES `boardLabels` (`id`) ON DELETE CASCADE
- Indexes: UNIQUE KEY `card_label_unique` (`cardId`,`labelId`); KEY `boardcardlabels_labelid_foreign` (`labelId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardMilestones`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`cardId`,`milestoneId`)
- Important columns: cardId, milestoneId
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCardTags`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, cardId, tagId
- Foreign keys: ADD CONSTRAINT `boardcardtags_cardid_foreign` FOREIGN KEY (`cardId`) REFERENCES `boardCards` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `boardcardtags_tagid_foreign` FOREIGN KEY (`tagId`) REFERENCES `boardTags` (`id`) ON DELETE CASCADE
- Indexes: UNIQUE KEY `card_tag_unique` (`cardId`,`tagId`); KEY `boardcardtags_tagid_foreign` (`tagId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardCards`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, columnId, boardId, title, description, htmlDescription, position, priority ...
- Foreign keys: ADD CONSTRAINT `boardcards_approverid_foreign` FOREIGN KEY (`approverId`) REFERENCES `users` (`id`) ON DELETE SET NULL; ADD CONSTRAINT `boardcards_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `boardcards_columnid_foreign` FOREIGN KEY (`columnId`) REFERENCES `boardColumns` (`id`) ON DELETE CASCADE; ADD CONSTRAINT `boardcards_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`) ON DELETE SET NULL; ADD CONSTRAINT `boardcards_executorid_foreign` FOREIGN KEY (`executorId`) REFERENCES `users` (`id`) ON DELETE SET NULL; ADD CONSTRAINT `boardcards_parentcardid_foreign` FOREIGN KEY (`parentCardId`) REFERENCES `boardCards` (`id`) ON DELETE SET NULL; ADD CONSTRAINT `boardcards_supervisorid_foreign` FOREIGN KEY (`supervisorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
- Indexes: KEY `boardcards_columnid_foreign` (`columnId`); KEY `boardcards_boardid_foreign` (`boardId`); KEY `boardcards_documentid_foreign` (`documentId`); KEY `boardcards_executorid_foreign` (`executorId`); KEY `boardcards_approverid_foreign` (`approverId`); KEY `boardcards_supervisorid_foreign` (`supervisorId`); KEY `boardcards_parentcardid_foreign` (`parentCardId`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardColumns`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, boardId, name, position, color, wipLimit, createdBy, modifiedBy ...
- Foreign keys: ADD CONSTRAINT `boardcolumns_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE
- Indexes: KEY `boardcolumns_boardid_foreign` (`boardId`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardLabels`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, boardId, name, color, createdDate
- Foreign keys: ADD CONSTRAINT `boardlabels_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE
- Indexes: KEY `boardlabels_boardid_foreign` (`boardId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardMilestones`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, boardId, name, color, createdBy, createdDate, modifiedBy, modifiedDate ...
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boardTags`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, boardId, name, color, createdDate
- Foreign keys: ADD CONSTRAINT `boardtags_boardid_foreign` FOREIGN KEY (`boardId`) REFERENCES `boards` (`id`) ON DELETE CASCADE
- Indexes: KEY `boardtags_boardid_foreign` (`boardId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `boards`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, description, isPublic, backgroundColor, createdBy, modifiedBy, deletedBy ...
- Foreign keys: ADD CONSTRAINT `boards_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`) ON DELETE CASCADE
- Indexes: KEY `boards_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `categories`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, description, parentId, hierarchyPath, isDeleted, createdBy, modifiedBy ...
- Foreign keys: ADD CONSTRAINT `categories_parentid_foreign` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE CASCADE
- Indexes: KEY `categories_parentid_foreign` (`parentId`); KEY `idx_categories_hierarchy_path` (`hierarchyPath`(768)) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `clients`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, companyName, contactPerson, email, phoneNumber, address, createdBy, modifiedBy ...
- Foreign keys: ADD CONSTRAINT `clients_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
- Indexes: KEY `clients_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `companyProfile`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, title, logoUrl, bannerUrl, createdBy, modifiedBy, deletedBy, isDeleted ...
- Foreign keys: ADD CONSTRAINT `companyprofile_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
- Indexes: KEY `companyprofile_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `cronJobLogs`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, jobName, status, output, executionTime, startedAt, endedAt
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `dailyReminders`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, reminderId, dayOfWeek, isActive
- Foreign keys: ADD CONSTRAINT `dailyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
- Indexes: KEY `dailyreminders_reminderid_foreign` (`reminderId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentAuditTrails`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, operationName, assignToUserId, assignToRoleId, createdBy, modifiedBy, deletedBy ...
- Foreign keys: ADD CONSTRAINT `documentaudittrails_assigntoroleid_foreign` FOREIGN KEY (`assignToRoleId`) REFERENCES `roles` (`id`); ADD CONSTRAINT `documentaudittrails_assigntouserid_foreign` FOREIGN KEY (`assignToUserId`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentaudittrails_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentaudittrails_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
- Indexes: KEY `documentaudittrails_documentid_foreign` (`documentId`); KEY `documentaudittrails_assigntouserid_foreign` (`assignToUserId`); KEY `documentaudittrails_assigntoroleid_foreign` (`assignToRoleId`); KEY `documentaudittrails_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `documentComments`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, comment, createdBy, modifiedBy, deletedBy, isDeleted, createdDate ...
- Foreign keys: ADD CONSTRAINT `documentcomments_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentcomments_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
- Indexes: KEY `documentcomments_documentid_foreign` (`documentId`); KEY `documentcomments_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentMetaDatas`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, metatag, createdBy, modifiedBy, deletedBy, isDeleted, createdDate ...
- Foreign keys: ADD CONSTRAINT `documentmetadatas_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
- Indexes: KEY `documentmetadatas_documentid_foreign` (`documentId`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentRolePermissions`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, roleId, startDate, endDate, isTimeBound, isAllowDownload, createdBy ...
- Foreign keys: ADD CONSTRAINT `documentrolepermissions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentrolepermissions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`); ADD CONSTRAINT `documentrolepermissions_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`)
- Indexes: KEY `documentrolepermissions_documentid_foreign` (`documentId`); KEY `documentrolepermissions_roleid_foreign` (`roleId`); KEY `documentrolepermissions_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentShareableLink`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, linkExpiryTime, password, linkCode, isAllowDownload, createdBy, modifiedBy ...
- Foreign keys: ADD CONSTRAINT `documentshareablelink_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentshareablelink_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
- Indexes: KEY `documentshareablelink_documentid_foreign` (`documentId`); KEY `documentshareablelink_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentSignatures`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, createdBy, signatureUrl, createdDate
- Foreign keys: ADD CONSTRAINT `documentsignatures_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentsignatures_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
- Indexes: KEY `documentsignatures_documentid_foreign` (`documentId`); KEY `documentsignatures_createdby_foreign` (`createdBy`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentStatus`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, description, colorCode, createdBy, modifiedBy, deletedBy, isDeleted ...
- Foreign keys: ADD CONSTRAINT `documentstatus_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
- Indexes: KEY `documentstatus_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentTokens`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, createdDate, documentId, token
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentUserPermissions`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, userId, startDate, endDate, isTimeBound, isAllowDownload, createdBy ...
- Foreign keys: ADD CONSTRAINT `documentuserpermissions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentuserpermissions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`); ADD CONSTRAINT `documentuserpermissions_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
- Indexes: KEY `documentuserpermissions_documentid_foreign` (`documentId`); KEY `documentuserpermissions_userid_foreign` (`userId`); KEY `documentuserpermissions_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `documentVersions`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, url, createdBy, modifiedBy, deletedBy, isDeleted, createdDate ...
- Foreign keys: ADD CONSTRAINT `documentversions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentversions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`); ADD CONSTRAINT `documentversions_signbyid_foreign` FOREIGN KEY (`signById`) REFERENCES `users` (`id`)
- Indexes: KEY `documentversions_documentid_foreign` (`documentId`); KEY `documentversions_createdby_foreign` (`createdBy`); KEY `documentversions_signbyid_foreign` (`signById`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documentWorkflow`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentId, workflowId, currentStepId, status, createdBy, deletedBy, isDeleted ...
- Foreign keys: ADD CONSTRAINT `documentworkflow_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documentworkflow_currentstepid_foreign` FOREIGN KEY (`currentStepId`) REFERENCES `workflowSteps` (`id`); ADD CONSTRAINT `documentworkflow_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`); ADD CONSTRAINT `documentworkflow_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`)
- Indexes: KEY `documentworkflow_createdby_foreign` (`createdBy`); KEY `documentworkflow_documentid_foreign` (`documentId`); KEY `documentworkflow_workflowid_foreign` (`workflowId`); KEY `documentworkflow_currentstepid_foreign` (`currentStepId`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `documents`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, categoryId, name, description, url, createdDate, createdBy, modifiedDate ...
- Foreign keys: ADD CONSTRAINT `documents_categoryid_foreign` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`); ADD CONSTRAINT `documents_clientid_foreign` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`); ADD CONSTRAINT `documents_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `documents_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentWorkflow` (`id`); ADD CONSTRAINT `documents_signbyid_foreign` FOREIGN KEY (`signById`) REFERENCES `users` (`id`); ADD CONSTRAINT `documents_statusid_foreign` FOREIGN KEY (`statusId`) REFERENCES `documentStatus` (`id`)
- Indexes: KEY `documents_categoryid_foreign` (`categoryId`); KEY `documents_createdby_foreign` (`createdBy`); KEY `documents_clientid_foreign` (`clientId`); KEY `documents_statusid_foreign` (`statusId`); KEY `documents_documentworkflowid_foreign` (`documentWorkflowId`); KEY `documents_signbyid_foreign` (`signById`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `emailLogAttachments`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, emailLogId, path, name
- Foreign keys: ADD CONSTRAINT `emaillogattachments_emaillogid_foreign` FOREIGN KEY (`emailLogId`) REFERENCES `emailLogs` (`id`)
- Indexes: KEY `emaillogattachments_emaillogid_foreign` (`emailLogId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `emailLogs`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, senderEmail, recipientEmail, subject, body, status, errorMessage, sentAt
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `emailSMTPSettings`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, host, userName, password, port, isDefault, fromName, encryption ...
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `fileRequestDocuments`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, url, fileRequestId, fileRequestDocumentStatus, approvedRejectedDate, approvalOrRejectedById, reason ...
- Foreign keys: ADD CONSTRAINT `filerequestdocuments_approvalorrejectedbyid_foreign` FOREIGN KEY (`approvalOrRejectedById`) REFERENCES `users` (`id`); ADD CONSTRAINT `filerequestdocuments_filerequestid_foreign` FOREIGN KEY (`fileRequestId`) REFERENCES `fileRequests` (`id`)
- Indexes: KEY `filerequestdocuments_filerequestid_foreign` (`fileRequestId`); KEY `filerequestdocuments_approvalorrejectedbyid_foreign` (`approvalOrRejectedById`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `fileRequests`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, subject, email, password, maxDocument, sizeInMb, allowExtension, fileRequestStatus ...
- Foreign keys: ADD CONSTRAINT `filerequests_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
- Indexes: KEY `filerequests_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `halfYearlyReminders`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, reminderId, day, month, quarter
- Foreign keys: ADD CONSTRAINT `halfyearlyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
- Indexes: KEY `halfyearlyreminders_reminderid_foreign` (`reminderId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `languages`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, code, name, imageUrl, createdBy, modifiedBy, order, deletedBy ...
- Foreign keys: ADD CONSTRAINT `languages_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
- Indexes: KEY `languages_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `loginAudits`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, userName, loginTime, remoteIP, status, provider, latitude, longitude
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `migrations`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, migration, batch
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `openaiDocuments`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, prompt, model, language, maximumLength, creativity, toneOfVoice, response ...
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `pageHelper`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, code, name, description
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 3 INSERT statement(s) in `datai_with_data.sql`.

## `pages`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, order, createdBy, modifiedBy, deletedBy, isDeleted, createdDate ...
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `quarterlyReminders`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, reminderId, day, month, quarter
- Foreign keys: ADD CONSTRAINT `quarterlyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
- Indexes: KEY `quarterlyreminders_reminderid_foreign` (`reminderId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `reminderNotifications`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, reminderId, subject, description, fetchDateTime, isDeleted, isEmailNotification
- Foreign keys: ADD CONSTRAINT `remindernotifications_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
- Indexes: KEY `remindernotifications_reminderid_foreign` (`reminderId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `reminderSchedulers`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, duration, isActive, frequency, createdDate, documentId, userId, isRead ...
- Foreign keys: ADD CONSTRAINT `reminderschedulers_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`); ADD CONSTRAINT `reminderschedulers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
- Indexes: KEY `reminderschedulers_documentid_foreign` (`documentId`); KEY `reminderschedulers_userid_foreign` (`userId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `reminderUsers`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, reminderId, userId
- Foreign keys: ADD CONSTRAINT `reminderusers_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`); ADD CONSTRAINT `reminderusers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
- Indexes: KEY `reminderusers_reminderid_foreign` (`reminderId`); KEY `reminderusers_userid_foreign` (`userId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `reminders`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, subject, message, frequency, startDate, endDate, dayOfWeek, isRepeated ...
- Foreign keys: ADD CONSTRAINT `reminders_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `reminders_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
- Indexes: KEY `reminders_documentid_foreign` (`documentId`); KEY `reminders_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `roleClaims`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, actionId, roleId, claimType, claimValue
- Foreign keys: ADD CONSTRAINT `roleclaims_actionid_foreign` FOREIGN KEY (`actionId`) REFERENCES `actions` (`id`); ADD CONSTRAINT `roleclaims_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`)
- Indexes: KEY `roleclaims_actionid_foreign` (`actionId`); KEY `roleclaims_roleid_foreign` (`roleId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `roles`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, isDeleted, name, createdBy, modifiedBy, deletedBy, createdDate, modifiedDate ...
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `seed_history`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, seeder_class, created_at, updated_at
- Foreign keys: None declared in schema dump
- Indexes: UNIQUE KEY `seed_history_seeder_class_unique` (`seeder_class`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `sendEmails`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, subject, message, fromEmail, documentId, isSend, email, createdBy ...
- Foreign keys: ADD CONSTRAINT `sendemails_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `sendemails_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
- Indexes: KEY `sendemails_documentid_foreign` (`documentId`); KEY `sendemails_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `userClaims`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, actionId, userId, claimType, claimValue
- Foreign keys: ADD CONSTRAINT `userclaims_actionid_foreign` FOREIGN KEY (`actionId`) REFERENCES `actions` (`id`); ADD CONSTRAINT `userclaims_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
- Indexes: KEY `userclaims_actionid_foreign` (`actionId`); KEY `userclaims_userid_foreign` (`userId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `userNotifications`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, userId, message, isRead, documentId, createdDate, modifiedDate, notificationType ...
- Foreign keys: ADD CONSTRAINT `usernotifications_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`); ADD CONSTRAINT `usernotifications_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentWorkflow` (`id`); ADD CONSTRAINT `usernotifications_filerequestid_foreign` FOREIGN KEY (`fileRequestId`) REFERENCES `fileRequests` (`id`); ADD CONSTRAINT `usernotifications_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
- Indexes: KEY `usernotifications_userid_foreign` (`userId`); KEY `usernotifications_documentid_foreign` (`documentId`); KEY `usernotifications_documentworkflowid_foreign` (`documentWorkflowId`); KEY `usernotifications_filerequestid_foreign` (`fileRequestId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `userRoles`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, userId, roleId
- Foreign keys: ADD CONSTRAINT `userroles_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`); ADD CONSTRAINT `userroles_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
- Indexes: KEY `userroles_userid_foreign` (`userId`); KEY `userroles_roleid_foreign` (`roleId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `users`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, firstName, lastName, isDeleted, userName, normalizedUserName, email, normalizedEmail ...
- Foreign keys: None declared in schema dump
- Indexes: No secondary indexes declared 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 1 INSERT statement(s) in `datai_with_data.sql`.

## `workflowLogs`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, documentWorkflowId, transitionId, comment, type, createdBy, deletedBy, isDeleted ...
- Foreign keys: ADD CONSTRAINT `workflowlogs_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `workflowlogs_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentWorkflow` (`id`); ADD CONSTRAINT `workflowlogs_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowTransitions` (`id`)
- Indexes: KEY `workflowlogs_documentworkflowid_foreign` (`documentWorkflowId`); KEY `workflowlogs_transitionid_foreign` (`transitionId`); KEY `workflowlogs_createdby_foreign` (`createdBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `workflowSteps`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, workflowId, name
- Foreign keys: ADD CONSTRAINT `workflowsteps_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`)
- Indexes: KEY `workflowsteps_workflowid_foreign` (`workflowId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `workflowTransitionRoles`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, roleId, transitionId
- Foreign keys: ADD CONSTRAINT `workflowtransitionroles_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`); ADD CONSTRAINT `workflowtransitionroles_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowTransitions` (`id`)
- Indexes: KEY `workflowtransitionroles_roleid_foreign` (`roleId`); KEY `workflowtransitionroles_transitionid_foreign` (`transitionId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `workflowTransitionUsers`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, userId, transitionId
- Foreign keys: ADD CONSTRAINT `workflowtransitionusers_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowTransitions` (`id`); ADD CONSTRAINT `workflowtransitionusers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
- Indexes: KEY `workflowtransitionusers_userid_foreign` (`userId`); KEY `workflowtransitionusers_transitionid_foreign` (`transitionId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `workflowTransitions`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, workflowId, fromStepId, toStepId, name, color, orderNo, isFirstTransaction
- Foreign keys: ADD CONSTRAINT `workflowtransitions_fromstepid_foreign` FOREIGN KEY (`fromStepId`) REFERENCES `workflowSteps` (`id`); ADD CONSTRAINT `workflowtransitions_tostepid_foreign` FOREIGN KEY (`toStepId`) REFERENCES `workflowSteps` (`id`); ADD CONSTRAINT `workflowtransitions_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`)
- Indexes: KEY `workflowtransitions_workflowid_foreign` (`workflowId`); KEY `workflowtransitions_fromstepid_foreign` (`fromStepId`); KEY `workflowtransitions_tostepid_foreign` (`toStepId`) 
- Soft-delete convention: no `deleted_at` column
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.

## `workflows`
- Purpose: **UNVERIFIED** (infer from code paths).
- Primary key: PRIMARY KEY (`id`)
- Important columns: id, name, description, createdBy, isWorkflowSetup, modifiedBy, deletedBy, isDeleted ...
- Foreign keys: ADD CONSTRAINT `workflows_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`); ADD CONSTRAINT `workflows_modifiedby_foreign` FOREIGN KEY (`modifiedBy`) REFERENCES `users` (`id`)
- Indexes: KEY `workflows_createdby_foreign` (`createdBy`); KEY `workflows_modifiedby_foreign` (`modifiedBy`) 
- Soft-delete convention: `deleted_at` present
- Sample data presence: 0 INSERT statement(s) in `datai_with_data.sql`.
## Core tables shortlist (platform skeleton)
- `users`, `roles`, `userRoles`, `actions`, `roleClaims`, `userClaims`
- `documents`, `documentRolePermissions`, `documentUserPermissions`, `documentVersions`, `documentAuditTrails`
- `workflows`, `workflowSteps`, `workflowTransitions`, `documentWorkflow`
- `companyProfile`

## Table -> Laravel model(s) -> repository usage (key mappings)
- `documents` -> `app/Models/Documents.php` -> `app/Repositories/Implementation/DocumentRepository.php`, `ArchiveDocumentRepository.php`, `ExpireDocumentRepository.php`, `BoardRepository.php`.
- `documentVersions` -> `app/Models/DocumentVersions.php` -> `DocumentVersionsRepository.php`, `DocumentRepository.php`.
- `documentUserPermissions` -> `app/Models/DocumentUserPermissions.php` -> `DocumentPermissionRepository.php`, `DocumentRepository.php`.
- `documentRolePermissions` -> `app/Models/DocumentRolePermissions.php` -> `DocumentPermissionRepository.php`, `DocumentRepository.php`.
- `documentComments` -> `app/Models/DocumentComments.php` -> `DocumentCommentRepository.php`, `DocumentRepository.php`.
- `documentAuditTrails` -> `app/Models/DocumentAuditTrails.php` -> `DocumentAuditTrailRepository.php`.
- `roleClaims` -> `app/Models/RoleClaims.php` -> role/user security logic in `AuthController.php` and repositories.
- `userClaims` -> `app/Models/UserClaims.php` -> `UserClaimRepository.php`, `AuthController.php`.
- `userRoles` -> `app/Models/UserRoles.php` -> `UserRoleRepository.php`, `RoleUsersRepository.php`, `AuthController.php`.
- `workflows` -> `app/Models/Workflow.php` -> `WorkflowRepository.php`.
- `documentWorkflow` -> `app/Models/DocumentWorkflow.php` -> `DocumentWorkflowRepository.php`.
