# Papers Backend + Frontend Wiring Map

This is the file-by-file implementation map for a junior developer.

## 1) Backend wiring (Laravel)

## 1.1 Models (app/Models)
Create models mirroring document patterns:
- `Papers.php`
- `PaperVersions.php`
- `PaperComments.php`
- `PaperAuditTrails.php`
- `PaperRolePermissions.php`
- `PaperUserPermissions.php`
- `PaperShareableLink.php`
- `PaperMetaDatas.php`

Conventions:
- `const CREATED_AT = 'createdDate'`
- `const UPDATED_AT = 'modifiedDate'`
- `SoftDeletes` where delete lifecycle should mimic documents.
- add global scopes for `isDeleted` if module chooses same pattern.

## 1.2 Repository contracts + implementations
Add interfaces under `app/Repositories/Contracts` and implementations under `app/Repositories/Implementation`:
- `PaperRepositoryInterface` / `PaperRepository`
- `PaperPermissionRepositoryInterface` / `PaperPermissionRepository`
- `PaperVersionsRepositoryInterface` / `PaperVersionsRepository`
- `PaperCommentRepositoryInterface` / `PaperCommentRepository`
- `PaperAuditTrailRepositoryInterface` / `PaperAuditTrailRepository`
- `PaperShareableLinkRepositoryInterface` / `PaperShareableLinkRepository`

Bind them in `app/Providers/RepositoryServiceProvider.php`.

## 1.3 Controllers
Add controllers:
- `PaperController`
- `PaperPermissionController`
- `PaperVersionController`
- `PaperCommentController`
- `PaperAuditTrailController`
- `PaperShareableLinkController`
- `PaperTokenController` (if using tokenized preview/download pattern)

Controller rules:
- thin controllers,
- validation + delegate to repository/service,
- pagination headers in list endpoints.

## 1.4 Routes (`routes/api.php`)
Add route groups in existing `Route::middleware(['auth'])` section.

Required route families:
- `/papers` list and create
- `/paper/{id}` get/update/delete/archive
- `/paper/assignedPapers` assigned list
- `/paperComment/*`
- `/paperversion/*`
- `/paperAuditTrail`
- `/paperRolePermission` and `/paperUserPermission`
- `/paper-sharable-link/*` admin + public endpoints
- `/papers/deep-search*` (optional if enabled)

Claims must map one-to-one with action codes.

## 1.5 Service layer (recommended)
Add service for content processing:
- `app/Services/PaperContentService.php`
Responsibilities:
- validate editor JSON shape
- convert JSON to HTML
- sanitize HTML server-side
- derive plain text
- compute metadata (word count, reading time)

Add service for export:
- `PaperExportService` using existing PDF stack.

---

## 2) Frontend wiring (Angular)

## 2.1 Module and routes
Create feature folder e.g. `resources/frontend/angular/src/app/paper`.

Routes:
- `/papers` -> all papers list (`claimType: ALL_PAPERS_VIEW_PAPERS`)
- `/papers/add` -> manage (`ALL_PAPERS_CREATE_PAPER`)
- `/papers/edit/:id` -> manage (`ALL_PAPERS_EDIT_PAPER`)
- `/paper-library` -> assigned papers list (`ASSIGNED_PAPERS_VIEW_PAPERS`)
- `/paper-details/:id` -> details (`ALL_PAPERS_VIEW_DETAIL` or `ASSIGNED_PAPERS_VIEW_DETAIL`)

## 2.2 Services
Create `paper.service.ts` and `paper-library.service.ts` similar to document services.

Must include methods for:
- list/get/create/update/delete/archive
- comments CRUD
- permissions CRUD
- versions list + restore
- share links CRUD + public read/download access
- export/download

## 2.3 Data sources and list contracts
Use data-source pattern like Documents.
Parse pagination headers:
- `totalCount`
- `pageSize`
- `skip`

## 2.4 Editor wrapper component
Create `paper-editor.component.ts` with:
- init/destroy lifecycle,
- save method returning Editor.js output,
- read-only toggle,
- undo + drag/drop init,
- image/link tool endpoint integration.

## 2.5 Sidebar + i18n
- Add sidebar route item in `layout/sidebar/sidebar-items.ts`.
- Add translation keys in `public/assets/angular/browser/assets/i18n/*.json` and source i18n pipeline if used.

---

## 3) Feature-by-feature backend/frontend map

1. **Create Paper**
- FE: manage form + editor wrapper -> POST `/paper`
- BE: `PaperController@savePaper` -> content service -> repository create
- DB: `papers`, `paperMetaDatas`, default creator permission row, audit row

2. **List All Papers**
- FE: paper list component + datasource
- BE: `PaperController@getPapers` + count endpoint
- DB filters: papers + categories + clients + status + joins for counts

3. **List Assigned Papers**
- FE: paper-library list
- BE: assigned query with ACL where-exists logic
- DB: `paperRolePermissions` + `paperUserPermissions` + date windows

4. **Permissions**
- FE dialogs for role/user permission edits
- BE permission controller/repo
- DB: permission tables + audit writes

5. **Versions**
- FE version history dialog + restore action
- BE version save/restore endpoints
- DB: `paperVersions` + current `papers` content swap on restore

6. **Comments**
- FE comment dialog
- BE comment CRUD endpoints
- DB: `paperComments`

7. **Share links**
- FE link settings dialog
- BE admin/public endpoints
- DB: `paperShareableLink` + token checks + expiry/password checks

8. **Export/download**
- FE action button in row/details
- BE export service + response stream
- DB: audit entry for export/download

---

## 4) Security controls checklist
- Backend claim middleware on all protected paper endpoints.
- Row ACL checks for assigned detail read and all mutations.
- Server-side sanitization of rendered HTML.
- Share link enforcement: password/expiry/download flag.
- Input validation for JSON payload size and allowed block types.
