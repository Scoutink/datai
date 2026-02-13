# Papers Module — Task Implementation Plan (Chronological, micro-detailed, execute-only)

**Rule:** Follow steps in order. Do not jump ahead.  
**Goal:** Implement Papers fully and bug-free with Editor.js + tool endpoints + DB + RBAC + Angular UI + deployment.

---

## Phase 0 — Setup and baseline verification (no code changes yet)

### 0.1 Create a working branch
- `git checkout -b feature/papers-module`

### 0.2 Identify the Documents “golden pattern”
Locate the Documents module source in your repo and record:
- Route definitions for documents in `routes/api.php`
- Controllers for documents: CRUD, permissions, versions, comments, shareable links, tokens, deep search, watermark, signature (if present)
- Repository interface + implementation classes for documents
- Angular documents module folder (routes, list component, details tabs, services, data source)

Deliverable (write in notes file, no commit yet):
- A mapping list “Documents feature → file → class → method → endpoint → table(s)”.
This prevents silent divergence and missed parity features.

### 0.3 Confirm platform conventions (DB + naming)
- Confirm if IDs are UUID strings or BIGINT.
- Confirm soft-delete pattern (`deleted_at` vs `isDeleted` flags).
- Confirm pagination header names used by Documents list endpoints (`totalCount`, etc).
- Confirm RBAC seeder version and format.

Deliverable:
- A short “platform conventions checklist” saved into dev notes.

---

## Phase 1 — Backend dependencies (composer) + PHP extensions

### 1.1 Ensure PHP extension requirements
`SQKHOR/editorjs-html` requires `ext-gd` (and PHP >= 7.4).  
On server (or local), ensure `gd` is enabled:
- Ubuntu/Debian: `sudo apt-get install php-gd`
- Restart PHP-FPM / Apache after enabling.

### 1.2 Install composer packages
In project root:
- `composer require sqkhor/editorjs-html`
- `composer require mews/purifier`

### 1.3 Publish Purifier config
- `php artisan vendor:publish --provider="Mews\Purifier\PurifierServiceProvider"`

Deliverable:
- `config/purifier.php` exists and committed.

Commit:
- `git add composer.json composer.lock config/purifier.php`
- `git commit -m "Add Papers dependencies: editorjs-html + purifier"`

---

## Phase 2 — Database migrations (create tables)

### 2.1 Create migrations in correct order
Create migration files (names can follow your repo’s timestamp naming):

1) `create_papers_table`
2) `create_paper_meta_datas_table`
3) `create_paper_versions_table`
4) `create_paper_comments_table`
5) `create_paper_audit_trails_table`
6) `create_paper_role_permissions_table`
7) `create_paper_user_permissions_table`
8) `create_paper_shareable_links_table`
9) `create_paper_tokens_table`
10) `create_paper_assets_table`

Rules:
- Use the same ID type used everywhere else (UUID if platform uses UUID).
- Use same created/modified/deleted fields pattern as Documents.
- Add foreign keys matching existing user/role/category/client/status tables.

### 2.2 Run migrations locally
- `php artisan migrate`

### 2.3 Verify schema
In DB:
- verify tables exist
- verify FK constraints
- verify indexes exist

Commit:
- `git add database/migrations`
- `git commit -m "Create Papers DB schema"`

---

## Phase 3 — Backend code: Models + Repositories + Services

### 3.1 Create Eloquent models
Create models mirroring Documents style:
- `Paper`
- `PaperMetaData`
- `PaperVersion`
- `PaperComment`
- `PaperAuditTrail`
- `PaperRolePermission`
- `PaperUserPermission`
- `PaperShareableLink`
- `PaperToken`
- `PaperAsset`

Ensure:
- `$table` set correctly if pluralization differs.
- `$fillable` covers intended write fields.
- soft delete trait matches platform.

Commit after models compile:
- `git add app/Models`
- `git commit -m "Add Papers models"`

### 3.2 Create repository contracts and implementations
Create interfaces:
- `PaperRepositoryInterface` (list/count/getById/create/update/delete/archive)
- `PaperPermissionRepositoryInterface`
- `PaperVersionRepositoryInterface`
- `PaperCommentRepositoryInterface`
- `PaperShareableLinkRepositoryInterface`
- `PaperTokenRepositoryInterface`
- `PaperMetaDataRepositoryInterface`
- `PaperAssetRepositoryInterface`
- `PaperAuditRepositoryInterface`

Create implementations by copying documents equivalents and adapting:
- filtering logic
- permission joins
- metaTags joins
- pagination header logic

**Critical:** ensure `count()` uses EXACT same filters and permission gating as `list()`.

Bind in your repo’s DI provider (e.g., `RepositoryServiceProvider`):
- `$this->app->bind(PaperRepositoryInterface::class, PaperRepository::class);` etc.

Commit:
- `git add app/Repositories app/Providers`
- `git commit -m "Add Papers repositories and bindings"`

### 3.3 Create services (render/sanitize/export/ssrf)
Create `app/Services/Papers/`:

#### 3.3.1 `PaperContentRenderService`
Methods:
- `renderAndSanitize(EditorJsData $data): RenderResult`
Steps:
1) Validate JSON (must contain `blocks` array)
2) HTML:
   - `$parts = edjsHTML::parse($data);`
   - `$html = implode('', array_map(fn($p)=>"<section>$p</section>", $parts));`
3) sanitize:
   - `$safeHtml = Purifier::clean($html, 'papers');` (create a `papers` profile in purifier config)
4) text:
   - `$text = trim(html_entity_decode(strip_tags($safeHtml)));`
5) wordCount + readingTime:
   - `wordCount = count(preg_split('/\s+/', $text))` (handle empty)
   - `readingTimeMin = max(1, ceil(wordCount / 200))` or use your platform standard.

Return:
- `{ safeHtml, text, wordCount, readingTimeMin }`

#### 3.3.2 `PaperSsrfGuardService`
Methods:
- `validateUrl(string $url): void`
Checks:
- scheme must be http/https
- DNS resolve and block private/loopback/link-local/multicast ranges (include 169.254.169.254 and 127.0.0.0/8 etc.)
- block redirects to forbidden ranges
- set max timeout and max body size

#### 3.3.3 `PaperEditorAssetService`
Methods:
- `uploadImageByFile(UploadedFile $file, User $user): array`
- `uploadImageByUrl(string $url, User $user): array`
- `fetchLinkMeta(string $url): array`

Return shapes:
- Image tool: `{ "success": 1, "file": { "url": "<public-or-download-route-url>" } }`
- Link tool: `{ "success": 1, "meta": { "title": "...", "description": "...", "image": { "url": "..." } } }`

#### 3.3.4 `PaperExportService`
Method:
- `exportPdf(Paper $paper): ExportResult`
Steps:
1) use sanitized `contentHtml` only
2) render PDF (use the same PDF library already used by Documents if available; otherwise standardize on dompdf)
3) store to `storage/app/papers/exports/{paperId}.pdf`
4) update `paper.exportPdfPath` and timestamp
5) return download info

Commit:
- `git add app/Services`
- `git commit -m "Add Papers services: render/sanitize/ssrf/assets/export"`

---

## Phase 4 — Backend controllers + routes

### 4.1 Add controllers
Create controllers in the same namespace structure as Documents:

- `PaperController` (CRUD + export + index toggle)
- `PaperEditorController` (image/link endpoints)
- `PaperPermissionController`
- `PaperVersionController`
- `PaperCommentController`
- `PaperShareableLinkController`
- `PaperTokenController`
- `PaperAuditController` (or integrate into PaperController)

Each controller must:
- validate input (FormRequest recommended)
- enforce claim middleware and per-paper permission checks
- return consistent JSON response shape used in Documents

### 4.2 Add routes (authenticated)
Add routes to `routes/api.php` following Documents grouping conventions.

Create these endpoints (exact list):

**Lists**
- `GET /api/papers`
- `GET /api/papers/assigned`

**CRUD**
- `POST /api/paper`
- `GET /api/paper/{id}`
- `PUT /api/paper/{id}`
- `DELETE /api/paper/{id}`
- `DELETE /api/paper/{id}/archive`

**Versions**
- `GET /api/paper/{id}/versions`
- `POST /api/paper/{id}/versions`
- `POST /api/paper/{id}/versions/{versionId}/restore`

**Comments**
- `GET /api/paper/{id}/comments`
- `POST /api/paper/{id}/comments`
- `DELETE /api/paper/{id}/comments/{commentId}`

**Permissions**
- `GET /api/paper/{id}/permissions`
- `POST /api/paper/{id}/permissions/role`
- `POST /api/paper/{id}/permissions/user`
- `POST /api/paper/{id}/permissions/bulk`
- `DELETE /api/paper/{id}/permissions/role/{permissionId}`
- `DELETE /api/paper/{id}/permissions/user/{permissionId}`

**Shareable link (authenticated)**
- `GET /api/paper/{id}/shareable-link`
- `POST /api/paper/{id}/shareable-link`
- `DELETE /api/paper/{id}/shareable-link`

**Indexing**
- `PUT /api/paper/{id}/index`
- `DELETE /api/paper/{id}/index`
- `GET /api/papers/deep-search`

**Export**
- `POST /api/paper/{id}/export/pdf`
- `GET /api/paper/{id}/download/pdf`

**Editor endpoints**
- `POST /api/paper/editor/image/byFile`
- `POST /api/paper/editor/image/byUrl`
- `POST /api/paper/editor/link`

### 4.3 Add routes (public share link)
- `GET /api/paper/share/{code}/info`
- `POST /api/paper/share/{code}/verify`
- `GET /api/paper/share/{code}/content`
- `GET /api/paper/share/{code}/download`

Commit:
- `git add routes/api.php app/Http/Controllers`
- `git commit -m "Add Papers controllers and routes"`

---

## Phase 5 — RBAC seeding

### 5.1 Add permission seeder
Create a new seeder file versioned after your latest permissions seeder, e.g.:
- `PermissionSeederV54.php`

Seeder must:
- insert the Papers page entry
- insert action rows for each claim
- assign all to admin role by default

### 5.2 Run seeder locally
- `php artisan db:seed --class=PermissionSeederV54`

### 5.3 Verify claims in JWT/session
- login again
- verify UI shows Papers menu for admin

Commit:
- `git add database/seeders`
- `git commit -m "Seed Papers RBAC claims"`

---

## Phase 6 — Frontend dependencies (NPM) + editor integration (Angular)

### 6.1 Install NPM dependencies
From Angular root (the same folder where package.json exists):
- `npm i @editorjs/editorjs @editorjs/paragraph @editorjs/header @editorjs/list @editorjs/checklist @editorjs/table @editorjs/quote @editorjs/delimiter @editorjs/code @editorjs/warning @editorjs/embed @editorjs/image @editorjs/link @editorjs/inline-code @editorjs/marker @editorjs/underline editorjs-undo editorjs-drag-drop`

If your project uses `npm ci` in production, ensure these appear in package-lock.json.

Commit:
- `git add resources/frontend/angular/package.json resources/frontend/angular/package-lock.json`
- `git commit -m "Add Editor.js dependencies for Papers"`

### 6.2 Implement `PaperEditorComponent`
Create:
- `paper-editor.component.ts/html/scss`

Must:
- mount editor
- support initial data
- implement `save()` returning JSON
- initialize Undo + DragDrop in `onReady`
- pass tool endpoints:
  - image byFile `/api/paper/editor/image/byFile`
  - image byUrl `/api/paper/editor/image/byUrl`
  - link endpoint `/api/paper/editor/link`

### 6.3 Implement Papers module UI
Create module and routes:
- `/papers`
- `/papers/assigned`
- `/papers/add`
- `/papers/:id/edit`
- `/papers/:id/details`

Implement:
- list component + datasource
- add/edit form (includes PaperEditorComponent)
- details view with tabs:
  - overview, permissions, versions, comments, audit, shareable link, export, deep search, reminders (if applicable)

### 6.4 Implement `PaperService`
Endpoints must match backend.

Commit:
- `git add resources/frontend/angular/src/app/...`
- `git commit -m "Implement Papers Angular module + Editor integration"`

---

## Phase 7 — Build and deploy (local + production procedure)

### 7.1 Local build smoke test
Backend:
- `php artisan migrate`
- `php artisan db:seed --class=PermissionSeederV54`
- `php artisan optimize:clear`

Frontend:
- `cd resources/frontend/angular`
- `npm ci`
- `npm run build`

Verify:
- Angular bundles updated
- Papers menu shows
- Create/edit paper works
- Image upload works
- Link preview works
- Export PDF works

### 7.2 Production deployment steps
1) Pull code
2) Backend:
   - `composer install --no-dev --optimize-autoloader`
   - `php artisan migrate --force`
   - `php artisan db:seed --class=PermissionSeederV54 --force`
   - `php artisan optimize:clear`
3) Frontend:
   - `cd resources/frontend/angular`
   - `npm ci`
   - `npm run build`
   - ensure build output is in the directory used by the platform to serve Angular assets
4) Ensure storage folders exist and writable:
   - `storage/app/papers/exports`
   - `storage/app/papers/assets/images`
   - `storage/app/papers/assets/files`

---

## Phase 8 — Mandatory QA checklist (do not mark done unless all pass)

1) Create Paper with multiple blocks (header/list/table/code/quote/warning)
2) Drag-drop reorder blocks
3) Undo/redo
4) Upload image (byFile)
5) Add link preview (fetch meta)
6) Save and reload; content persists
7) Update content; version snapshot created
8) Restore old version; content reverts and audit logs
9) Export PDF; download works and respects allow-download
10) Shareable link:
    - create with password + expiry
    - incognito open and verify password requirement
    - download allowed only if allow-download enabled
11) Permission enforcement:
    - remove paper permission from a user and verify access denied
12) Security:
    - attempt to inject script tags in content; ensure sanitized output renders safely
    - attempt URL fetch to a private IP; ensure SSRF blocked

---

## Phase 9 — Final engineering review (must complete before merge)

- Filters + count parity: count endpoint cannot diverge from list logic.
- Claims + per-paper permissions: both applied on all relevant actions.
- Editor tool contracts: response formats match required shape.
- Sanitization is server-side and persisted; UI never trusts raw HTML from client.
- SSRF protections implemented for both link fetch and URL import.
- Storage cleanup plan: deleting a paper should clean orphaned assets (or a scheduled cleanup job exists).

---

## Implementation references (URLs for developer)
- Editor.js base concepts: https://editorjs.io/base-concepts
- Image Tool docs: https://github.com/editor-js/image
- Link Tool backend response format: https://www.npmjs.com/package/@editorjs/link/v/2.4.2
- editorjs-undo: https://www.npmjs.com/package/editorjs-undo
- editorjs-drag-drop: https://github.com/kommitters/editorjs-drag-drop
- sqkhor/editorjs-html: https://packagist.org/packages/sqkhor/editorjs-html
- mews/purifier: https://github.com/mewebstudio/Purifier
- OWASP SSRF: https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html