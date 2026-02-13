# Backend Forensics Map

## Entry points
- HTTP bootstrap: `public/index.php` -> Laravel bootstrap (standard Laravel 11).
- API registration: `routes/api.php`.
- Web + SPA fallback: `routes/web.php` with `AngularController@index`.
- Middleware chain: `app/Http/Kernel.php` (`auth`, `hasToken`, `boardsAuth` etc.).

## Auth/JWT handling
- Login/refresh in `app/Http/Controllers/AuthController.php`.
- Claims built by querying `userRoles`->`roleClaims` plus `userClaims`; merged/deduped/sorted and embedded via `Auth::claims([...])`.
- Required custom payload keys: `claims`, `email`, `userId`, `licensekey`, `purchasecode`.
- Claim validation: `app/Http/Middleware/HasToken.php` reads token payload and requires at least one passed claim.

## Route map (major groups)
- Public auth/recovery: `auth/login`, forgot/reset password, share/file-request public APIs.
- Protected common: dropdowns, profile updates, token refresh, notifications.
- Documents: `/documents`, `/document/*`, `/documentversion/*`, `/documentComment/*`, `/document-sharable-link/*`, `/document-watermark`.
- Admin/security modules: users, roles, user claims, role users.
- Workflow module: `/workflow*`, `/documentWorkflow*`, `/workflow-logs`.
- Ops/logs: `/email-logs`, `/cron-job-logs`, retention-setting routes.
- Boards: `/boards`, `/cards`, columns/tags/labels/checklists/milestones.

## Route->controller->repository patterns
- Document list: `GET /documents` -> `DocumentController@getDocuments` -> `DocumentRepository@getDocuments/getDocumentsCount` -> `Documents` + joins.
- Assigned list: `GET /document/assignedDocuments` -> `DocumentController@assignedDocuments` -> `DocumentRepository@assignedDocuments/assignedDocumentsCount`.
- Permission save: `POST /documentRolePermission` -> `DocumentPermissionController@addDocumentRolePermission` -> `DocumentPermissionRepository`.
- Version restore: `POST /documentversion/{id}/restore/{versionId}` -> `DocumentVersionController@restoreDocumentVersion` -> `DocumentVersionsRepository@restoreDocumentVersion`.

## Claim middleware requirements
Claims are attached through many `Route::middleware('hasToken:...')` groups in `routes/api.php`; canonical strings include `ALL_DOCUMENTS_*`, `ASSIGNED_DOCUMENTS_*`, `WORKFLOW_*`, `BOARDS_*`, `SETTING_*`, `LOGS_*`, etc.

## Shared infrastructure
- File storage: `Storage::disk($location)` with `location` column (`local`/`s3`) in document flows.
- PDF tooling: `barryvdh/dompdf`, `setasign/fpdi/fpdf`, and `PdfWatermarkService` for watermark/signature transforms.
- Audit logging:
  - explicit write endpoint `/documentAuditTrail`.
  - repository/controller writes during operations (archive/sign/watermark/delete etc.).
- Schedulers/cron: `app/Console/Kernel.php` orchestrates reminders, sends email, retention cleanup.
- Pagination contract: document endpoints return headers `totalCount/pageSize/skip`; Angular data sources consume these exactly.
