# Database Map (from migrations/models + snapshot validation)

> Scope intentionally excludes H5P/interactive and Papers behavior details.

## Core identity + authorization tables
- `users` (`app/Models/Users.php`): login principals, JWT subject model.
- `roles` (`app/Models/Roles.php`): role definitions.
- `userRoles` (`app/Models/UserRoles.php`): user↔role assignments.
- `roleClaims` (`app/Models/RoleClaims.php`): claim strings inherited via role.
- `userClaims` (`app/Models/UserClaims.php`): direct per-user claims.

## Document domain tables
- `documents` (`app/Models/Documents.php`): primary document record (metadata, status, workflow pointers, retention, signing fields).
- `documentMetaDatas` (`app/Models/DocumentMetaDatas.php`): key-value metadata tags.
- `documentVersions` (`app/Models/DocumentVersions.php`): versioned file history.
- `documentUserPermissions` / `documentRolePermissions`: row-level document access bindings.
- `documentAuditTrails`: operational history.
- `documentComments`: comment threads on documents.
- `documentTokens`: temporary view/download tokenization.
- `documentShareableLink`: external share links with code/password/expiry.
- `documentStatus`: configurable status catalog.

## AI document tables
- `openaiDocuments` (`app/Models/OpenAIDocuments.php`): generated prompt/response history.
- `aiPromptTemplate` (`app/Models/AIPromptTemplates.php`): reusable prompting templates.

## Workflow tables
- `workflows` (`app/Models/Workflow.php`): workflow definitions.
- `workflowSteps` (`app/Models/WorkflowStep.php`): workflow node states.
- `workflowTransitions` (`app/Models/WorkflowTransition.php`): allowed state transitions.
- `workflowTransitionRoles` / `workflowTransitionUsers`: transition-level assignee authorization.
- `documentWorkflow` (`app/Models/DocumentWorkflow.php`): workflow instances tied to documents.
- `workflowLogs` (`app/Models/WorkflowLog.php`): execution logs.

## Reminder and notification tables
- `reminders` (`app/Models/Reminders.php`): reminder definitions linked to document.
- `reminderUsers`: recipients.
- `dailyReminders`, `quarterlyReminders`, `halfYearlyReminders`: cadence detail tables.
- `reminderNotifications`, `reminderSchedulers`: notification execution/scheduling.
- `userNotifications`: user-facing notification feed.

## Sharing + related collaboration tables
- `documentShareableLink`: share URL records.
- `fileRequests`, `fileRequestDocuments`: inbound sharing/collection flows.

## Relationship highlights
- `documents` belongs to category/client/status/user and has many metadata/comments/versions/permissions/reminders/audits.
- `documentWorkflow` belongs to one document + one workflow and references current step.
- `roles` and `users` connect through `userRoles`, then claim resolution merges `roleClaims` + `userClaims`.
- `reminders` cascade to reminder detail tables on delete (model hook).

## Snapshot verification note
- `dev/h5p-debug/datai.sql` was used only to confirm active table/column presence for non-H5P areas (e.g., `documents`, `workflows`, `roles`, `roleClaims`, `userClaims`, `reminders`).
