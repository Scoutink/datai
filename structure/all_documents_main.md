# Datai — Documents Module Forensic Architecture (Definitive v2)
*(Repository → List/Filters → Menu Actions → Add Form → Details Tabs → Wrap-up)*

This document is the **authoritative forensic mapping** of the existing “Documents” feature set, intended to give “as if we coded it” mastery for:
- Backend API & repository behavior
- Frontend routing + UI behavior
- Full menu action mapping (claims → component → service → endpoint → DB effect)
- Add Document form mapping (every field → payload → backend)
- Assigned vs All documents differences
- Known gaps & what remains to reach complete mastery

---

# 1) Entry Points (Frontend Routes)

## 1.1 All Documents (Admin/Global Listing)
**Deployed URL example:** `https://<domain>/documents`  
**Angular module:** `app/document`

### Routing (Angular)
File: `app\document\document-routing.module.ts`
- `path: ''` → `DocumentListComponent`
- Claim enforced by route metadata: `ALL_DOCUMENTS_VIEW_DOCUMENTS`
- Guard: `AuthGuard`

So:
- `/documents` → All Documents list (global list)

---

## 1.2 Assigned Documents (“My”/Permission-based listing)
**This is NOT inside `app/document`.**  
It is implemented under `app/document-library`.

### Where it is mounted
File: `app\app-routing.module.ts`
- The `DocumentLibraryModule` is loaded at root `path: ''` under `LayoutComponent`
- Meaning the default “home” route is the assigned-document listing.

### DocumentLibrary routing
File: `app\document-library\document-library-routing.module.ts`
- `path: ''` → `DocumentLibraryListComponent` (Assigned documents list)
- `path: 'add'` → `AddDocumentComponent`
  - Claim: `ASSIGNED_DOCUMENTS_CREATE_DOCUMENT`
  - Guard: `AuthGuard`

So:
- `/` (home page inside app shell) → Assigned documents list  
- `/add` (under that module base) → Add document (assigned document context)

> Note: You still ALSO have `/documents/add` (global add) from the Document module.

---

## 1.3 Document Details Page
File: `app\app-routing.module.ts`
Route:
- `path: 'document-details/:id'`
- Loads `DocumentDetailsComponent` (standalone)
- Claim list includes:
  - `ALL_DOCUMENTS_VIEW_DETAIL`
  - `ASSIGNED_DOCUMENTS_VIEW_DETAIL`

So:
- `/document-details/<id>` → the details tabs page.

---

## 1.4 Public Share Link Preview
File: `app\app-routing.module.ts`
Route:
- `path: 'preview/:code'`
- Loads a preview component for shareable link access flow
- Uses backend shareable link endpoints (see later)

---

# 2) Backend Entry Points (Laravel Routes)

Source: `routes.md` (Laravel routing file)

Key document routes (simplified):

## 2.1 Listing
- `GET /documents` → `DocumentController@getDocuments`
  - Middleware: `hasToken:ALL_DOCUMENTS_VIEW_DOCUMENTS`
- `GET /document/assignedDocuments` → `DocumentController@assignedDocuments`

## 2.2 CRUD
- `POST /document` → `DocumentController@saveDocument`
  - Middleware includes: `ALL_DOCUMENTS_CREATE_DOCUMENT, ASSIGNED_DOCUMENTS_CREATE_DOCUMENT, BULK_DOCUMENT_UPLOAD`
- `GET /document/{id}` → `DocumentController@getDocumentbyId`
- `PUT /document/{id}` → `DocumentController@updateDocument`
- `DELETE /document/{id}` → `DocumentController@deleteDocument`
- `DELETE /document/{id}/archive` → `DocumentController@archiveDocument`

## 2.3 Download / Read
- `GET /document/{id}/download/{isVersion}`
- `GET /document/{id}/readText/{isVersion}`

## 2.4 Meta Tags
- `GET /document/{id}/getMetatag`

## 2.5 Versioning
- `GET /documentversion/{documentId}`
- `POST /documentversion`
- `POST /documentversion/{id}/restore/{versionId}`

## 2.6 Comments
- `GET /documentComment/{documentId}`
- `POST /documentComment`
- `DELETE /documentComment/{id}`

## 2.7 Share / Permissions
- `GET /DocumentRolePermission/{id}` → list permissions (roles+users merged result)
- `POST /documentRolePermission`
- `POST /documentUserPermission`
- `POST /documentRolePermission/multiple` → bulk share
- `DELETE /documentUserPermission/{id}`
- `DELETE /documentRolePermission/{id}`
- `GET /document/{id}/isDownloadFlag`
- `GET /documentPermission/{id}/check` → check access

## 2.8 Shareable link admin endpoints
- `GET /document-sharable-link/{id}`
- `POST /document-sharable-link`
- `DELETE /document-sharable-link/{id}`
- plus public flows:
  - `/document-sharable-link/{code}/info`
  - `/document-sharable-link/{code}/check/{password}`
  - `/document-sharable-link/{code}/document`
  - `/document-sharable-link/{code}/download?...`
  - `/document-sharable-link/{code}/token`

## 2.9 Deep Search Indexing
- `GET /documents/deep-search`
- `POST /documents/deep-search/{id}`
- `DELETE /documents/deep-search/{id}`

## 2.10 Workflow
- `POST /documentWorkflow`
- `POST /documentWorkflow/{id}/cancel`
- `POST /documentWorkflow/performNextTransition`
- `GET /documentWorkflow` (list)
- `GET /documentWorkflow/{id}/visualWorkflow`

## 2.11 AI Summary (Correct endpoint)
- `POST /ai/summarize-document` → `AISummaryController@summarize`

## 2.12 Signature & Watermark
- `POST /document-signature` → `DocumentSignatureController@signDocument`
- `POST /document-watermark` → `DocumentWatermarkController@watermarkDocument`

---

# 3) Repository Filtering Logic (Backend Forensics)

## 3.1 All Documents: `DocumentRepository::getDocuments($attributes)`
Backend file (in aggregated backend code): `DocumentRepository`

### SELECT fields (high-value output)
Includes:
- document identity + display fields
- joins: categories, users, clients, status, workflow
- derived fields:
  - `signByUserName`
  - `commentCount`
  - `versionCount`
  - `isWorkflowCompleted`

### Sorting logic
Sort only mapped keys:
- `categoryName` → `categories.name`
- `name` → `documents.name`
- `createdDate` → `documents.createdDate`
- `createdBy` → `users.firstName`
- `location` → `documents.location`
- `companyName` → `clients.companyName`
- `statusName` → `documentStatus.name`

### Filters applied (All documents)
- Category filter includes children:
  - `categoryId = X OR categories.parentId = X`
- Client filter:
  - `clientId = X`
- Status filter:
  - `statusId = X`
- Name search (matches name OR description):
  - `documents.name LIKE %term% OR documents.description LIKE %term%`
- Storage filter:
  - `documents.location = local|s3`
- Meta tags filter:
  - `EXISTS documentMetaDatas WHERE metatag LIKE %term%`
- Created date day window (UTC):
  - `whereBetween(documents.createdDate, startUTC..endUTC)`

### Pagination
- `skip($attributes->skip)->take($attributes->pageSize)->get()`

### Count query
`DocumentRepository::getDocumentsCount($attributes)`
Same filters (incl createDateString logic) to return correct `totalCount` header.

> **Important:** All-documents listing does **NOT** apply user/role permission filtering.  
> Access is enforced primarily by **claim tokens** (`ALL_DOCUMENTS_VIEW_DOCUMENTS`) rather than data-level ACL filtering.

---

## 3.2 Assigned Documents: `DocumentRepository::assignedDocuments($attributes)`

### Key behavior
Assigned documents are defined by existence of active permission records:
- `documentUserPermissions` OR `documentRolePermissions`

Where role membership is derived from:
- `UserRoles::select(roleId)->where(userId = currentUser)`

### Permission time-bound logic (critical)
For a permission record to qualify:

**If not time-bound**
- `isTimeBound = 0` → always valid

**If time-bound**
- `isTimeBound = 1` AND:
  - `startDate <= todayStartOfDay`
  - `endDate >= todayEndOfDay`

This logic is applied separately for:
- user permission exists
- OR role permission exists

### Assigned docs filters supported
After permission gating, it supports:
- categoryId (with child categories)
- name search (name or description)
- statusId
- location
- clientId
- metaTags

### Extra computed fields
Adds:
- `maxUserPermissionEndDate`
- `maxRolePermissionEndDate`
(via subqueries)

### Count query
`assignedDocumentsCount($attributes)`
Same filters but without heavy selects.

---

# 4) All Documents List Page (Frontend Forensics)

## 4.1 Component & Data Source
- Component: `app\document\document-list\document-list.component.ts`
- DataSource: `app\document\document-list\document-datasource.ts`
- Service: `app\document\document.service.ts`

### Initial resource defaults
- `pageSize = 10`
- `orderBy = 'createdDate desc'`

### Request path
- DataSource calls `DocumentService.getDocuments(resource)`
- `GET /documents` with HttpParams:
  - fields, orderBy, createDateString, pageSize, skip, searchQuery, categoryId, name, metaTags, id, location, clientId, statusId

### Filters exposed in UI (confirmed in HTML)
File: `app\document\document-list\document-list.component.html`

Filters map to `DocumentResource`:
- Search box → `documentResource.name`
- Meta tags box → `documentResource.metaTags`
- Category dropdown → `categoryId`
- Storage dropdown → `location`
- Created date picker → `createDateString = ISO string`
- Client dropdown → `clientId`
- Status dropdown → `statusId`

Each filter resets:
- `skip = 0`
- `paginator.pageIndex = 0`
then reloads `dataSource.loadDocuments(...)`.

### Bulk selection behavior
- Column `select`
- If selected rows exist, shows bulk share button:
  - Claim: `ALL_DOCUMENTS_SHARE_DOCUMENT`
  - Opens `DocumentPermissionMultipleComponent`

---

# 5) Documents Menu Forensic Mapping (All Documents)

Source: `app\document\document-list\document-list.component.html`

Each item is gated by `*hasClaim` and calls a TS handler.

Below is a **complete mapping** for the All Documents menu.

## 5.1 Menu Items (All Docs)

| UI Label | Claim | TS Handler | Service/Component | Backend Endpoint(s) | DB Impact |
|---|---|---|---|---|---|
| Edit | `ALL_DOCUMENTS_EDIT_DOCUMENT` | `editDocument(document)` | opens `DocumentEditComponent` dialog | `PUT /document/{id}` | updates `documents` |
| Share | `ALL_DOCUMENTS_SHARE_DOCUMENT` | `manageDocumentPermission(document)` | opens `DocumentPermissionListComponent` | `GET /DocumentRolePermission/{id}` + add/remove endpoints | insert/delete in `documentUserPermissions` / `documentRolePermissions` |
| Get Shareable Link | `ALL_DOCUMENTS_MANAGE_SHARABLE_LINK` | `onCreateShareableLink(document)` | opens `SharableLinkComponent` | `GET/POST/DELETE /document-sharable-link/...` | writes `documentShareableLinks` |
| Document Signature | `ASSIGN_ADD_SIGNATURE` | `signDocument(document)` | opens `DocumentSignatureComponent` | `POST /document-signature` | writes signature table + modifies PDF output flow |
| AI Powered Summary | `ALL_DOC_GENERATE_SUMMARY` | `generateSummary(document)` | opens `AiDocumentSummaryComponent` | `POST /ai/summarize-document` | no DB unless saved elsewhere |
| Start Workflow | `ALL_DOCUMENTS_START_WORKFLOW` | `manageWorkflowInstance(document)` | opens workflow dialog | `POST /documentWorkflow` etc | writes workflow tables |
| Add Watermark | `ALL_DOC_WATERMARK` | `watermarkDocument(document)` | opens `DocumentWatermarkComponent` | `POST /document-watermark` | watermark operation output |
| Details | `ALL_DOCUMENTS_VIEW_DETAIL` | Router link | `/document-details/:id` | `GET /document/{id}` + tabs endpoints | none (reads + tab loads) |
| Upload New Version | `ALL_DOCUMENTS_UPLOAD_NEW_VERSION` | `uploadNewVersion(document)` | dialog `DocumentUploadNewVersionComponent` | `POST /documentversion` | insert in `documentVersions` |
| Version History | `ALL_DOCUMENTS_VIEW_VERSION_HISTORY` | `onVersionHistoryClick(document)` | opens versions dialog | `GET /documentversion/{id}` | reads `documentVersions` |
| Comment | `ALL_DOCUMENTS_MANAGE_COMMENT` | `addComment(document)` | opens `DocumentCommentComponent` | `GET/POST/DELETE /documentComment/...` | reads/writes `documentComments` |
| Add Reminder | `ALL_DOCUMENTS_ADD_REMINDER` | `addReminder(document)` | opens `DocumentReminderComponent` | `POST /reminder/document` | writes reminders tables |
| Send Email | `ALL_DOCUMENTS_SEND_EMAIL` | `sendEmail(document)` | opens `SendEmailComponent` | `POST /email` | logs in email logs |
| Add Indexing | `DEEP_SEARCH_ADD_INDEXING` | `addIndexing(document)` | confirm dialog then service call | `POST /documents/deep-search/{id}` | sets `documents.isIndexed=1` and creates index |
| Remove Indexing | `DEEP_SEARCH_REMOVE_INDEXING` | `removeIndexing(document)` | confirm dialog then service call | `DELETE /documents/deep-search/{id}` | sets `documents.isIndexed=0` and deletes index |
| Archive | `ALL_DOCUMENTS_ARCHIVE_DOCUMENT` | `archiveDocument(document)` | confirm dialog then service | `DELETE /document/{id}/archive` | moves record into archive flow |
| Delete | `ALL_DOCUMENTS_DELETE_DOCUMENT` | `deleteDocument(document)` | confirm dialog then service | `DELETE /document/{id}` | deletion (or archive repo delete) |

### Confirmed implementation details (menu actions)
- **Download** is NOT in the menu, but exists as a button/handler:
  - Handler: `downloadDocument(documentInfo)`
  - Uses `CommonService.downloadDocument(documentView)`
  - Endpoint:
    - normal: `GET /document/{id}/download/{isVersion}`
    - share preview: `GET /document-sharable-link/{code}/download?password=...`
    - file request: `GET /file-request-document/{id}/download`

- Audit trail on download:
  - Calls `CommonService.addDocumentAuditTrail({documentId, operationName:"Download"})`
  - Endpoint: `POST /documentAuditTrail`

---

# 6) Assigned Documents Menu Mapping (Document Library)

Source: `app\document-library\document-library-list\document-library-list.component.html`

Menu is largely identical, but claims are the ASSIGNED variants.

Example differences:
- Edit: `ASSIGNED_DOCUMENTS_EDIT_DOCUMENT`
- Share: `ASSIGNED_DOCUMENTS_SHARE_DOCUMENT`
- Details: `ASSIGNED_DOCUMENTS_VIEW_DETAIL`
- Start workflow: `ASSIGNED_DOCUMENTS_START_WORKFLOW`
- Summary claim differs:
  - Assigned: `ASSIGNED_DOC_GENERATE_SUMMARY`
  - All docs: `ALL_DOC_GENERATE_SUMMARY`

Assigned list calls:
- Angular service `DocumentLibraryService.getDocuments()`
- Endpoint: `GET /document/assignedDocuments`

---

# 7) Add Document Form Forensic Mapping (All Docs Add)

## 7.1 Container + Presentation split
- Container: `app\document\document-manage\document-manage.component.ts`
- Presentation: `app\document\document-manage-presentation\document-manage-presentation.component.ts/.html`

Submit flow:
1) Presentation builds `DocumentInfo`
2) Emits `(onSaveDocument)`
3) Container calls `DocumentService.addDocument(document)`
4) On success: adds audit trail “Created”
5) Navigates to `/documents`

### Audit trail logic (confirmed)
File: `document-manage.component.ts`
- After success:
  - `CommonService.addDocumentAuditTrail({documentId, operationName:"Created"})`
  - then route to `/documents`

---

## 7.2 Form controls (exact)
File: `document-manage-presentation.component.ts`

Form group:
- `name` *(required)*
- `description`
- `categoryId` *(required)*
- `url` *(required)* → used as “file is required” validator field
- `extension` *(required)* → used as “allowed file type” validator gate
- `documentMetaTags` (FormArray)
- `selectedRoles`
- `selectedUsers`
- `location`
- `clientId`
- `statusId`
- `retentionPeriod`
- `retentionAction`
- `rolePermissionForm`:
  - `isTimeBound`
  - `startDate`
  - `endDate`
  - `isAllowDownload`
- `userPermissionForm`:
  - same fields

### Important behavior: file validation
- The file input is required via `url` control.
- File type validation is enforced via `extension` control:
  - invalid extension → `extension` stays empty → triggers `DOCUMENT_TYPE_IS_NOT_ALLOWED`

Allowed extensions come from:
- `commonService.allowFileExtension$` (loaded via API from allow-file-extension table)

---

## 7.3 Field → payload mapping (exact)
In `buildDocumentObject()`:
- `categoryId` ← form
- `description` ← form
- `statusId` ← form
- `name` ← form
- `url` ← `this.fileData.fileName` (note: file itself is separately sent)
- `documentMetaDatas` ← `documentMetaTags` array value
- `fileData` ← selected file
- `extension` ← this.extension
- `location` ← companyProfile default or selection
- `clientId`
- `retentionPeriod`
- `retentionAction`

Permissions mapping:
- `selectedRoles[]` → creates `document.documentRolePermissions[]`
  - each includes roleId + values from `rolePermissionForm`
- `selectedUsers[]` → creates `document.documentUserPermissions[]`
  - each includes userId + values from `userPermissionForm`

Time-bound toggles:
- If timeBound checked → startDate/endDate become required.

---

## 7.4 Actual API submission (multipart FormData)
File: `app\document\document.service.ts`

Method: `addDocument(document: DocumentInfo)`

It builds `FormData` fields:
- `html_content` (only meaningful for AI documents)
- `uploadFile` (binary file)
- `name`
- `categoryId`
- `categoryName`
- `description`
- `location`
- `statusId`
- `clientId`
- `retentionPeriod`
- `retentionAction`
- `documentMetaDatas` JSON
- `documentRolePermissions` JSON
- `documentUserPermissions` JSON

Endpoint selection:
- If `document.html_content` exists → `POST ai/documents`
- Else → `POST document`

---

# 8) Document Details Tabs (Forensic)

Component: `app\document\document-details\document-details.component.ts/.html`

Tabs (7):
1) General
2) Permission
3) Version History
4) Comment
5) Document Audit Trail
6) Reminders
7) Workflow Logs

Lazy loading behavior:
- `loadedTabs[]` boolean array
- tab content components receive `[shouldLoad]`

General tab displays:
- categoryName
- location
- statusName
- companyName (client)
- updatedByName
- modifiedDate
- retentionPeriod (+ days)
- retentionAction
- meta tags list
- description

General tab edit button claim gate:
- `*hasClaim="['ALL_DOCUMENTS_EDIT_DOCUMENT','ASSIGNED_DOCUMENTS_EDIT_DOCUMENT']"`
- opens `DocumentEditComponent` in dialog.

---

# 9) Wrap-up: Reusable “Content Module” Patterns (No future module planning)

Documents demonstrates the platform’s standard “content module pattern”:

## 9.1 Backend pattern
- Controller exposes list/count and action endpoints
- Repository handles:
  - filtering
  - joins
  - pagination
  - permission gating (only in assignedDocuments)
- Tables used:
  - base content table (`documents`)
  - meta tags table (`documentMetaDatas`)
  - permission tables (`documentUserPermissions`, `documentRolePermissions`)
  - versioning table (`documentVersions`)
  - comments table (`documentComments`)
  - workflow tables
  - audit trail (`documentAuditTrails`)
  - shareable links (`documentShareableLinks`)

## 9.2 Frontend pattern
- Module routing sets claimType per page
- List component:
  - DataSource + Resource object
  - Filter controls map directly to resource params
- Action menu:
  - `*hasClaim` gates UI
  - handler calls service → endpoint
- Create/Manage form:
  - presentation builds domain object
  - container calls service
  - audit is added after success

---

# 10) What is STILL missing to reach “100% mastery”
These are **not blockers** for continuing, but are needed for complete debug-level mastery:

1) **Full backend implementations of these controllers/repositories** (we have routes and calls; we should also map exact DB writes and validations):
   - DocumentVersionController + repository
   - DocumentWorkflowController + repositories
   - EmailController + logs
   - ReminderController + retention/cron behaviors
   - DocumentWatermarkController + actual watermarking pipeline
   - DocumentSignatureController + PDF merge pipeline

2) **Deep Search indexer internals**
   - `DocumentIndexer` is called in repository:
     - `createDocumentIndex(...)`
     - `deleteDocumentIndex(...)`
   We have confirmation it is invoked, but not the class internals here.

3) **Archiving pipeline**
   - ArchiveDocumentRepository behavior (copy/move vs flags) needs exact mapping.

4) **Cron jobs**
   - You explicitly stated cron is missing in deployment.
   That affects:
   - reminder firing
   - retention deletions
   - archive retention behaviors
   - email log retention

5) **Permission model expansion points**
   Current ACL is:
   - route claims (“hasToken:XYZ”)
   - row-level ACL only in assignedDocuments by permissions tables
   This matters later when adding more granular “own vs global” logic or “default content” overrides.

---

# End of Definitive v2
