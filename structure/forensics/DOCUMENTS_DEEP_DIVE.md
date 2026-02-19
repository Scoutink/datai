# Documents Deep Dive (Golden Reference)

## Feature inventory
- List pages:
  - All documents: `/documents` (`DocumentListComponent`).
  - Assigned/my documents: `/document-library` (`DocumentLibraryListComponent`).
- Filters: name/description, meta-tags, category, storage, date, client, status.
- Pagination: server-side (`totalCount/pageSize/skip` headers).
- Row actions (claim-gated): edit, share permissions, sharable link, sign, AI summary, start workflow, view details/download, watermark, upload new version, version history, comments, reminders, email, archive, delete.
- Upload pipeline: multipart upload via `DocumentService.addDocument()` to `/api/document` (or `/api/ai/documents` when html content exists).
- Storage paths: document files under `documents/<uuid>.<ext>`; location controlled by `location` field (`local`/`s3`).

## DB tables involved
`documents`, `documentMetaDatas`, `documentRolePermissions`, `documentUserPermissions`, `documentVersions`, `documentComments`, `documentAuditTrails`, `documentShareableLink`, `documentTokens`, `documentWorkflow`, plus lookup tables (`categories`, `clients`, `documentStatus`, `users`, `roles`).

## Backend endpoint wiring by feature
- All list: `GET /api/documents` -> `DocumentController@getDocuments` -> `DocumentRepository@getDocuments/getDocumentsCount`.
- Assigned list: `GET /api/document/assignedDocuments` -> `DocumentController@assignedDocuments` -> `DocumentRepository@assignedDocuments/assignedDocumentsCount`.
- Create upload: `POST /api/document` -> `DocumentController@saveDocument` -> `DocumentRepository@saveDocument`.
- Edit: `PUT /api/document/{id}` -> `DocumentController@updateDocument` -> `DocumentRepository@updateDocument`.
- Delete: `DELETE /api/document/{id}` -> `DocumentController@deleteDocument` -> `DocumentRepository@deleteDocument`.
- Archive: `DELETE /api/document/{id}/archive` -> `DocumentController@archiveDocument` -> `DocumentRepository@archiveDocument`.
- Comments: `GET/POST/DELETE /api/documentComment*` -> `DocumentCommentController` -> `DocumentCommentRepository`.
- Permissions: `GET /api/DocumentRolePermission/{id}`, `POST /api/documentRolePermission`, `POST /api/documentUserPermission`, delete endpoints -> `DocumentPermissionController` -> `DocumentPermissionRepository`.
- Versioning: `GET /api/documentversion/{documentId}`, `POST /api/documentversion`, restore endpoint -> `DocumentVersionController` -> `DocumentVersionsRepository`.
- Share links: admin routes in auth group + public read/download/token routes -> `DocumentSharebaleLinkController`, `DocumentController`, `DocumentTokenController`.
- Deep search: `/api/documents/deep-search*` -> `DocumentController` -> `DocumentRepository` indexing methods.
- Watermark: `POST /api/document-watermark` -> `DocumentWatermarkController@watermarkDocument`.

## Frontend wiring by feature
- List + row actions: `document-list.component.ts/html` and `document-library-list.component.ts/html`.
- API facade: `document.service.ts` and `document-library.service.ts`.
- Dialogs/components:
  - Permission: `document-permission/*`
  - Share link: `sharable-link/*`
  - Version history/upload: `document-version-history/*`, `document-upload-new-version/*`
  - Comments/reminder/email/workflow/signature/watermark: corresponding feature components.

## Claims required (samples)
- All-doc page/actions: `ALL_DOCUMENTS_VIEW_DOCUMENTS`, `ALL_DOCUMENTS_CREATE_DOCUMENT`, `ALL_DOCUMENTS_EDIT_DOCUMENT`, `ALL_DOCUMENTS_SHARE_DOCUMENT`, `ALL_DOCUMENTS_MANAGE_SHARABLE_LINK`, `ALL_DOCUMENTS_VIEW_DETAIL`, etc.
- Assigned variants: `ASSIGNED_DOCUMENTS_*`.
- Cross features: `DEEP_SEARCH_*`, `ALL_DOC_ADD_SIGNATURE`, `ALL_DOC_WATERMARK`, `ALL_DOC_GENERATE_SUMMARY`.

## Reusable module primitives
1. Route claim middleware + Angular route claim guard parity.
2. List endpoint + count endpoint + pagination headers.
3. Row action architecture via dedicated endpoints and dialogs.
4. Audit log writes on every critical mutation.
5. Role/user ACL join tables for row-level permissioning.

## UNVERIFIED items
- Exact ACL SQL logic for every claim combination in assigned/all queries should be regression-tested with seeded roles/users.
- Exact storage naming rules for all upload variants (AI generated vs standard upload) should be confirmed with runtime tests.
