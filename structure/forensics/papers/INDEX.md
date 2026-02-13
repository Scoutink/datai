# Papers Module Forensics Pack (Implementation-Ready)

This folder is the execution-ready guide to build **Papers** as a first-class module in DATAI with full parity to **All Documents** patterns (RBAC, row permissions, versions, comments, audit, share links, deep search, reminders, exports), plus Papers-specific Editor.js architecture and security hardening.

## Documents in this pack
- [PAPERS_MODULE_MASTER_PLAN.md](./PAPERS_MODULE_MASTER_PLAN.md)
- [PAPERS_DB_AND_RBAC_SQL.md](./PAPERS_DB_AND_RBAC_SQL.md)
- [PAPERS_BACKEND_FRONTEND_WIRING.md](./PAPERS_BACKEND_FRONTEND_WIRING.md)
- [PAPERS_QA_DEPLOY_RUNBOOK.md](./PAPERS_QA_DEPLOY_RUNBOOK.md)
- [REFERENCE_MAP.md](./REFERENCE_MAP.md)

## Quick start order
1. Read `PAPERS_MODULE_MASTER_PLAN.md` (scope, parity and architecture decisions).
2. Apply DB model + RBAC from `PAPERS_DB_AND_RBAC_SQL.md`.
3. Implement wiring file-by-file using `PAPERS_BACKEND_FRONTEND_WIRING.md`.
4. Validate and deploy using `PAPERS_QA_DEPLOY_RUNBOOK.md`.

- [implementation/INDEX.md](./implementation/INDEX.md)
- [implementation/01_phpmyadmin_patch.sql](./implementation/01_phpmyadmin_patch.sql)
