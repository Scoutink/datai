# DATAI Forensics Pack Index

DATAI is a Laravel + Angular compliance/document execution platform where access is controlled by JWT claims and row-level document permission tables, with strong emphasis on versioning, audit logging, workflow state, and operational retention automation.

## Docs
- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [C4.md](./C4.md)
- [DB_DICTIONARY.md](./DB_DICTIONARY.md)
- [DB_ERD_NOTES.md](./DB_ERD_NOTES.md)
- [BACKEND_MAP.md](./BACKEND_MAP.md)
- [FRONTEND_MAP.md](./FRONTEND_MAP.md)
- [DOCUMENTS_DEEP_DIVE.md](./DOCUMENTS_DEEP_DIVE.md)
- [RUNBOOK_BUILD_DEPLOY.md](./RUNBOOK_BUILD_DEPLOY.md)
- [RUNBOOK_RBAC.md](./RUNBOOK_RBAC.md)
- [RUNBOOK_DB.md](./RUNBOOK_DB.md)
- [QUALITY_GATES.md](./QUALITY_GATES.md)
- [CONFLICTS_REPORT.md](./CONFLICTS_REPORT.md)

## Where-to-change quick map
- Document list/actions -> backend `routes/api.php`, `DocumentController`, `DocumentRepository`; frontend `document/*`, `document-library/*`; DB `documents` + permission/version/comment/audit tables.
- RBAC changes -> backend `HasToken`, `AuthController`, `routes/api.php`; frontend `AuthGuard`, `has-claim.directive`; DB `actions`, `roleClaims`, `userClaims`, `userRoles`.
- Workflow changes -> backend workflow controllers/repositories; frontend `workflows/*`; DB `workflows`, `workflowSteps`, `workflowTransitions`, `documentWorkflow`, `workflowLogs`.
