# Papers Module — Definitive Specification (Editor.js, production-grade from day one)

**Stack:** Laravel (API) + Angular (SPA) + MySQL  
**Editor:** Editor.js + required tools + Undo + Drag/Drop  
**Canonical content:** Editor.js Clean Data JSON  
**Derived content:** Sanitized HTML + Plain Text + Exported PDF (optional but included for parity)

---

## 0) High-level objective

Implement a **Papers** content type that behaves like the existing **Documents** module (list, permissions, versions, audit, shareable links, deep search, etc.) but with **authored content** instead of uploaded files.

### 0.1 Non-negotiable standards
- **No CDN** for editor or plugins: all installed via **NPM** and bundled into Angular build.
- **No raw HTML storage** without sanitization: sanitize server-side before persisting.
- **No SSRF** vulnerabilities: URL-based fetching must implement strict protections.
- **No “v1/v2”** split: deliver complete and correct behavior from first release.

---

## 1) Functional scope and parity map

### 1.1 Must-have parity with Documents
Papers must support:

1) **All Papers list**
- pagination, sorting, filtering, search
- per-row actions menu (claim-gated)
- bulk operations where Documents supports them (e.g., bulk share permissions)

2) **Assigned Papers list**
- list papers accessible via per-paper permissions (user/role, time-bound)

3) **Paper details view**
- Overview/meta
- Permissions (role/user, allow-download, time-bound)
- Versions (create snapshot, restore)
- Comments
- Audit trail
- Shareable link (create/update/delete, password, expiry, allow-download)
- Deep search toggle (index/unindex)
- Reminders (if documents have reminders)
- Export (PDF generation and download)
- Optional watermark/signature for exported PDF if Documents supports watermark/signature

4) **Security**
- RBAC claims + per-item permissions must both apply.
- Shareable links must not bypass internal permission model unless explicitly allowed by share link.

### 1.2 Paper-specific differences from Documents
- Documents store a file, Papers store editor JSON.
- “Download” becomes download/export of **PDF** (or HTML) derived from content.
- Image/file assets embedded in editor must be stored under paper-owned storage paths.

---

## 2) Editor.js tooling spec (frontend)

### 2.1 Required NPM packages

**Core**
- `@editorjs/editorjs`

**Block tools**
- `@editorjs/paragraph`
- `@editorjs/header`
- `@editorjs/list`
- `@editorjs/checklist`
- `@editorjs/table`
- `@editorjs/quote`
- `@editorjs/delimiter`
- `@editorjs/code`
- `@editorjs/warning`
- `@editorjs/embed`
- `@editorjs/image`
- `@editorjs/link`

**Inline tools**
- `@editorjs/inline-code`
- `@editorjs/marker`
- `@editorjs/underline` (if available in your dependency set; if not, replace with a maintained inline tool)

**UX extensions**
- `editorjs-undo`
- `editorjs-drag-drop`

> Undo must be initialized in `onReady`, and if loading initial content, call `undo.initialize(initialData)` (or equivalent) to avoid broken undo stack.

### 2.2 Editor.js configuration (must match tool contracts)

#### 2.2.1 Image tool config
Image tool requires endpoints for `byFile` and optionally `byUrl`, and expects backend response JSON:
```json
{ "success": 1, "file": { "url": "https://..." } }
The tool sends multipart/form-data with field name matching field config (default image).

2.2.2 Link tool config
Link tool requires an endpoint and expects backend response JSON:

{
  "success": 1,
  "meta": {
    "title": "...",
    "description": "...",
    "image": { "url": "https://..." }
  }
}
2.3 Required editor wrapper behavior (Angular)
Create a PaperEditorComponent that:

mounts Editor.js into a DIV with a stable id

supports create and edit modes

supports read-only mode for details preview

exposes save(): Promise<EditorJsData> returning JSON

destroys editor instance on component destroy

Initialize Undo and DragDrop inside onReady:

const undo = new Undo({ editor }); undo.initialize(initialData);

new DragDrop(editor);

3) Backend content pipeline (Laravel)
3.1 Canonical + derived fields (always maintained)
For each Paper save (create/update/restore):

Validate incoming JSON.

Persist JSON as canonical content.

Convert JSON → HTML server-side.

Sanitize HTML.

Derive plain text for indexing/search.

Compute word count and reading time.

(Optional) Generate/refresh exported PDF.

3.2 JSON → HTML parsing library (server-side)
Use sqkhor/editorjs-html:

Install: composer require sqkhor/editorjs-html

Requires: PHP >= 7.4 and ext-gd enabled.

Parsing approach:

edjsHTML::parse($editorjs_data) returns an array of per-block HTML fragments.

Join into a single HTML string.

3.3 Sanitization library (server-side)
Use mews/purifier:

Install: composer require mews/purifier

Publish config: php artisan vendor:publish --provider="Mews\Purifier\PurifierServiceProvider"

Sanitize rules:

Configure allowlist of tags and attributes used by Editor.js blocks.

Disallow all on* handlers and javascript: URLs.

For <a> require rel="noopener noreferrer" for external links.

3.4 SSRF protection (for link preview and URL-based image import)
Endpoints that fetch remote URLs must:

allow only http and https

resolve DNS and block private/multicast/loopback/link-local ranges

block cloud metadata targets (e.g., 169.254.169.254)

enforce timeouts and max response sizes

disallow redirects to forbidden IP ranges

Implementation must follow OWASP SSRF guidance, including minimum deny-list ranges if an allow-list approach is not feasible.

4) Database schema (MySQL)
4.1 Naming and conventions
Use the same id type and naming conventions used by your platform (UUIDs and camelCase columns if that is your norm).

Soft delete style must match your platform (isDeleted + deletedBy + deleted_at, or only deleted_at). Use the existing Documents pattern.

4.2 Tables (required)
4.2.1 papers
Core entity.

Columns (minimum):

id (UUID, PK)

name (varchar 255, required)

description (text, nullable)

categoryId (UUID, FK → categories.id, nullable if documents allow)

clientId (UUID, FK → clients.id, nullable if documents allow)

statusId (UUID, FK → documentStatus.id or your status table, nullable/required like documents)

contentJson (LONGTEXT, nullable)

contentHtml (LONGTEXT, nullable) sanitized

contentText (LONGTEXT, nullable) plain text

wordCount (int, default 0)

readingTimeMin (int, default 0)

exportPdfPath (varchar 1024, nullable) (storage path, not public URL)

exportPdfUpdatedAt (datetime, nullable)

isIndexed (tinyint/bool, default 0)

Standard audit columns matching platform:

createdBy, createdDate, modifiedBy, modifiedDate

isDeleted, deletedBy, deleted_at (or platform equivalent)

Indexes:

(categoryId), (clientId), (statusId)

(createdBy), (modifiedBy)

(isDeleted, deleted_at)

Optional fulltext: (name, contentText) if used by your search strategy.

4.2.2 paperMetaDatas
id UUID PK

paperId UUID FK → papers.id

metatag varchar 255

standard audit/soft-delete fields

Indexes:

(paperId)

(metatag) (if meta filtering is frequent)

4.2.3 paperVersions
Snapshot records.

id UUID PK

paperId UUID FK

versionNo int

name, description snapshots

contentJson, contentHtml, contentText

wordCount, readingTimeMin

exportPdfPath nullable

created metadata + soft delete

Indexes:

(paperId, versionNo) unique

4.2.4 paperComments
id UUID PK

paperId UUID FK

comment text

author + createdDate + soft delete fields

Indexes:

(paperId, createdDate)

4.2.5 paperAuditTrails
id UUID PK

paperId UUID FK

operationName varchar 128

optional metaJson LONGTEXT nullable (store context like share link code, permission changes)

created metadata + soft delete fields

Indexes:

(paperId, createdDate)

4.2.6 paperRolePermissions
id UUID PK

paperId UUID FK

roleId UUID FK

isAllowDownload bool

isTimeBound bool

startDate, endDate datetime nullable

created metadata + soft delete

Indexes:

(paperId, roleId)

(roleId)

4.2.7 paperUserPermissions
id UUID PK

paperId UUID FK

userId UUID FK

isAllowDownload, isTimeBound, startDate, endDate

created metadata + soft delete

Indexes:

(paperId, userId)

(userId)

4.2.8 paperShareableLinks
id UUID PK

paperId UUID FK

code varchar 64 unique

hasPassword bool

passwordHash varchar 255 nullable

expiresAt datetime nullable

isAllowDownload bool

created metadata + soft delete

Indexes:

(paperId)

(code) unique

4.2.9 paperTokens
id UUID PK

paperId UUID FK

token varchar 128 unique

expiresAt datetime nullable

created metadata + soft delete

Indexes:

(paperId)

(token) unique

4.2.10 paperAssets (Editor-owned assets)
Store embedded assets (images, files) uploaded via editor tools.

id UUID PK

paperId UUID FK

type enum('image','file')

storageDisk varchar 32 (e.g., 'local' or 's3')

path varchar 1024 (storage path)

originalName varchar 255

mime varchar 128

size bigint

createdBy, createdDate

soft delete fields

Indexes:

(paperId, type)

This table is required so Papers remain self-contained, and so you can later clean up assets when papers are deleted/archived.

5) Backend APIs (Laravel routes + contracts)
5.1 Authentication and authorization layers
Every authenticated API must enforce:

RBAC claim via middleware (route-level claim enforcement).

Per-paper permission checks for Assigned Papers flows and share/download actions.

Public shareable link endpoints:

must validate share code + expiry + password (if required)

must respect share link allow-download flag

5.2 Endpoints list (mandatory)
5.2.1 Lists
GET /api/papers

Query params: skip, pageSize, orderBy, name, categoryId, clientId, statusId, metaTags, createdFrom, createdTo, isIndexed, isArchived

Response: array rows

Response headers must match existing Documents pagination strategy (e.g., totalCount, pageSize, skip).

GET /api/papers/assigned

Same query params, but must return only papers permitted via user/role permissions.

5.2.2 CRUD
POST /api/paper

Body:

name (required)

description, categoryId, clientId, statusId

contentJson (Editor.js JSON object or string)

metaTags (array of strings) optional

Server must:

validate JSON

render+sanitize HTML

extract text

create audit entry "CREATE"

Returns created Paper DTO.

GET /api/paper/{id}

Returns full Paper details:

meta + permissions summary + counts (commentsCount, versionsCount)

contentJson (for edit) + contentHtml (for view) + contentText optional

share link info if exists

PUT /api/paper/{id}

Same fields as create

Server must:

create a new version snapshot BEFORE applying update (if content changed)

render+sanitize HTML

audit "UPDATE"

Returns updated Paper DTO.

DELETE /api/paper/{id}

soft delete

audit "DELETE"

DELETE /api/paper/{id}/archive

archive (if platform differentiates)

audit "ARCHIVE"

5.2.3 Versions
GET /api/paper/{id}/versions

POST /api/paper/{id}/versions (create snapshot explicitly; optionally used on demand)

POST /api/paper/{id}/versions/{versionId}/restore

Replace current content with version content

Audit "RESTORE_VERSION"

5.2.4 Comments
GET /api/paper/{id}/comments

POST /api/paper/{id}/comments

DELETE /api/paper/{id}/comments/{commentId}

5.2.5 Permissions
GET /api/paper/{id}/permissions (return both role and user permissions)

POST /api/paper/{id}/permissions/role

POST /api/paper/{id}/permissions/user

POST /api/paper/{id}/permissions/bulk (optional but keep parity if documents have it)

DELETE /api/paper/{id}/permissions/role/{permissionId}

DELETE /api/paper/{id}/permissions/user/{permissionId}

5.2.6 Shareable link
GET /api/paper/{id}/shareable-link

POST /api/paper/{id}/shareable-link (create/update)

DELETE /api/paper/{id}/shareable-link

Public:

GET /api/paper/share/{code}/info (returns title/expiry/hasPassword flags)

POST /api/paper/share/{code}/verify (password verification)

GET /api/paper/share/{code}/content (returns sanitized HTML or a view model)

GET /api/paper/share/{code}/download (returns PDF download if allow-download)

5.2.7 Deep search
PUT /api/paper/{id}/index (enable indexing)

DELETE /api/paper/{id}/index (disable indexing)

GET /api/papers/deep-search (search endpoint or list of indexed items, depending on your existing deep search implementation)

5.2.8 Export PDF
POST /api/paper/{id}/export/pdf

generates PDF and stores exportPdfPath

audit "EXPORT_PDF"

GET /api/paper/{id}/download/pdf

returns PDF response with proper headers

enforce allow-download via permissions + shareable link rules

audit "DOWNLOAD_PDF"

5.2.9 Editor tool endpoints
POST /api/paper/editor/image/byFile (multipart/form-data)

expects file in field image (default)

returns { success: 1, file: { url: "..." } }

POST /api/paper/editor/image/byUrl (json body { url: "https://..." })

SSRF protected

returns same success format

POST /api/paper/editor/link (json body { url: "https://..." })

SSRF protected

returns { success: 1, meta: { title, description, image: { url } } }

6) RBAC claims (must be seeded)
6.1 Claims (minimum)
Create claim codes following existing naming conventions (adjust prefix to match platform).

All Papers

ALL_PAPERS_VIEW_PAPERS

ALL_PAPERS_CREATE_PAPER

ALL_PAPERS_EDIT_PAPER

ALL_PAPERS_DELETE_PAPER

ALL_PAPERS_ARCHIVE_PAPER

ALL_PAPERS_VIEW_DETAIL

ALL_PAPERS_MANAGE_PERMISSION

ALL_PAPERS_MANAGE_VERSIONS

ALL_PAPERS_MANAGE_COMMENTS

ALL_PAPERS_VIEW_AUDIT

ALL_PAPERS_MANAGE_SHAREABLE_LINK

ALL_PAPERS_EXPORT_PDF

ALL_PAPERS_DOWNLOAD_PDF

ALL_PAPERS_DEEP_SEARCH

Assigned Papers

mirror as ASSIGNED_PAPERS_* for assigned flows

6.2 Seeding
Add a new permission seeder file versioned after the latest seeder used by the platform, and:

create a new pages entry (Papers)

create actions entries (one per claim)

create default roleClaims (admin role gets all)

7) Frontend (Angular) structure and deployment
7.1 Angular module structure (required)
Create PapersModule with:

Routes:

/papers

/papers/assigned

/papers/add

/papers/:id/edit

/papers/:id/details

Components:

paper-list

paper-assigned-list

paper-add-edit

paper-details + sub-tab components

paper-editor (Editor.js wrapper)

7.2 Service layer
Create PaperService (API calls) and PaperDataSource (list) mirroring Documents.

7.3 Editor component integration
Use PaperEditorComponent as a child component inside add/edit forms.

Save flow:

editorData = await paperEditor.save()

POST/PUT to backend with contentJson: editorData

backend returns updated DTO; UI refreshes.

7.4 Build & deploy (must be documented for devops)
Backend

composer install --no-dev --optimize-autoloader

php artisan migrate --force

php artisan db:seed --class=<YourPapersPermissionSeeder> --force

php artisan optimize:clear

Frontend
From Angular root (as configured in your repo):

npm ci

npm run build

Ensure build artifacts are deployed to the same directory used by your platform for Angular assets.

Clear browser cache / bump asset version if your platform caches Angular bundles.

Filesystem
Ensure storage is writable and linked:

php artisan storage:link (only if platform uses public symlink)

Ensure storage/app/papers/... directories exist and writable:

storage/app/papers/exports

storage/app/papers/assets/images

storage/app/papers/assets/files

8) Acceptance tests (must pass)
8.1 Editor acceptance
Create a Paper with multiple blocks (header/list/table/code/quote/warning)

Drag-drop reorder works

Undo/redo works

Images upload and persist

Link previews fetch and display

Reload preserves content exactly

8.2 Governance acceptance
Permissions:

user without claim cannot access list

user with claim but without per-paper permission cannot access assigned-only papers

allow-download is enforced on PDF download

time-bound permission expires as expected

Versions:

update creates a version snapshot

restore works

Shareable link:

expiry enforced

password enforced

public content view shows sanitized HTML

download respects allow-download

Audit:

create, update, delete/archive, export, download, permission changes logged.

9) Implementation references (URLs for developer)
Editor.js base concepts (JSON output, API pluggable): https://editorjs.io/base-concepts

Image Tool docs (endpoints + backend response format): https://github.com/editor-js/image

Link Tool docs (backend response format): https://www.npmjs.com/package/@editorjs/link/v/2.4.2

Undo plugin usage: https://www.npmjs.com/package/editorjs-undo

Drag-drop plugin usage: https://github.com/kommitters/editorjs-drag-drop

Editor.js HTML parser (PHP): https://packagist.org/packages/sqkhor/editorjs-html

Laravel Purifier: https://github.com/mewebstudio/Purifier

OWASP SSRF prevention: https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html