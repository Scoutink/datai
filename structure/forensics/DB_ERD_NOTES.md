# DB ERD Notes

## Entity groups
- Identity & RBAC: `users`, `roles`, `userRoles`, `actions`, `roleClaims`, `userClaims`, `pages`.
- Documents core: `documents`, `documentMetaDatas`, `documentVersions`, `documentComments`, `documentAuditTrails`, `documentTokens`, `documentShareableLink`, `documentStatus`.
- Document permissions: `documentRolePermissions`, `documentUserPermissions`.
- Workflow: `workflows`, `workflowSteps`, `workflowTransitions`, `workflowTransitionRoles`, `workflowTransitionUsers`, `documentWorkflow`, `workflowLogs`.
- Reminders/notifications: `reminders`, schedule tables, `reminderUsers`, `reminderNotifications`, `userNotifications`.
- Ops/admin: `companyProfile`, logs tables, language/settings tables.
- Boards: board/card/column/tag/label/checklist/activity tables.

## Ownership boundaries
- Hard multi-tenant workspace/company key is **UNVERIFIED** (no obvious `workspaceId`/`companyId` ubiquitous FK in all tables).
- De-facto scoping appears to be permission-based (document ACL + claims) and client association via `documents.clientId`.

## Permission table patterns
- Role-based grants: `documentRolePermissions` with `startDate`, `endDate`, `isAllowDownload`.
- User-based grants: `documentUserPermissions` with same temporal/download flags.
- JWT claim grants: `roleClaims` + `userClaims` using `claimType`.
