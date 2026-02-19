# DATAI Architecture Forensics

## Context and goals
DATAI is a Laravel + Angular workspace platform for controlled document/compliance execution: upload/manage documents, assign permissions, run workflows, reminders, logs, and board tasks, with JWT claim-based access checks end-to-end.

## Key quality goals
- Security: JWT + claim middleware (`hasToken:*`) and UI claim guards.
- Auditability: document operations persisted in `documentAuditTrails` and login/email/cron logs.
- Consistency: repository pattern + shared pagination headers (`totalCount`, `pageSize`, `skip`).
- Scalability: storage abstraction (`local`/`s3`), queued-like scheduled commands for cleanup/reminders.

## Architecture constraints
- Backend: Laravel 11 + `php-open-source-saver/jwt-auth`.
- Frontend: Angular app in `resources/frontend/angular`.
- DB: MySQL/MariaDB dump, UUID-like `char(36)` keys.
- Access model: roleClaims + userClaims merged into JWT at login.

## Building blocks
- HTTP: `routes/api.php` -> Controllers -> Repositories -> Eloquent Models.
- DI bindings: `app/Providers/RepositoryServiceProvider.php`.
- Middleware: `auth` + `hasToken` (`app/Http/Middleware/HasToken.php`).
- Frontend layers: route modules, feature services, list data sources, claim directive.

## Runtime view (key flows)
1. Login: `AuthController@login` validates credentials, collects `roleClaims` + `userClaims`, mints JWT with `claims` payload.
2. Document list: Angular `DocumentService.getDocuments()` -> `/api/documents` -> `DocumentController@getDocuments` -> `DocumentRepository@getDocuments/getDocumentsCount` -> headers set.
3. Row action examples:
   - watermark: `/api/document-watermark` -> `DocumentWatermarkController@watermarkDocument` -> `DocumentVersions` snapshot + file rewrite.
   - share link: `/api/document-sharable-link` -> `DocumentSharebaleLinkController` + public consume routes.

## Deployment view
- Angular SPA catch-all served by Laravel blade (`AngularController@index`, `routes/web.php`).
- Angular production build target points to `public/assets/angular` with `baseHref=/assets/angular/browser/`.
- Storage disks: `local`, `public`, `s3` from `config/filesystems.php`.
- Schedulers in `app/Console/Kernel.php` run reminder, email, archive, and log retention commands.

## Cross-cutting concepts
- RBAC: backend middleware + frontend `AuthGuard`/`*hasClaim`.
- Row ACL: document permission tables (`documentRolePermissions`, `documentUserPermissions`), assigned document listing.
- Audit logs: document audits, workflow logs, login/email/cron logs.
- Versioning: `documentVersions` on upload/sign/watermark restore flows.
- Share links/tokens: `documentShareableLink`, `documentTokens`, public endpoints.
- Export/search/indexing: deep search routes and indexing actions are present; search backend uses Scout/TNTSearch dependency.

## Risks / tech debt
- Some sensitive routes are not wrapped in `hasToken` (e.g., `/document/{id}`, assigned list) and rely on repository checks; re-verify authorization coverage.
- Claim strings are duplicated across route defs and templates (drift risk).
- Large `routes/api.php` monolith raises merge/conflict complexity.
- **UNVERIFIED**: queue workers (no explicit queue config usage found yet).

## Glossary
- Claim: string permission in JWT payload.
- Assigned documents: row-filtered document scope for users.
- Deep search: document indexing/search feature.
- Workflow instance: runtime state in `documentWorkflow`.
