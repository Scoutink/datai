# Documents Flow

## Create document
1. Angular add form calls `DocumentService.addDocument()`.
2. Service posts multipart form to:
   - `POST /api/document` for standard docs, or
   - `POST /api/ai/documents` when `html_content` is present.
3. Backend route resolves to `DocumentController@saveDocument` (standard) with claim-protected route groups.
4. Repository layer persists document + metadata + permissions + file storage reference.

## Open/view document
1. Document list loads via `DocumentService.getDocuments()` (`GET /api/documents`).
2. Viewer path obtains token via `CommonService.getDocumentToken()` (`GET /api/documentToken/{id}/token`).
3. File stream resolves through office viewer/download endpoints in `DocumentController`:
   - `/api/document/{id}/officeviewer`
   - `/api/document/{id}/download/{isVersion}`
   - `/api/document/{id}/readText/{isVersion}`

## Edit/update document
1. Edit dialogs from document list trigger `DocumentEditComponent` and call `DocumentService.updateDocument()`.
2. API call: `PUT /api/document/{id}`.
3. Related actions in same area include metadata, permission, version upload and archive/delete operations.

## Viewer components and key frontend points
- Main list + action menu: `document-library-list.component.ts/html`.
- Preview/dialog orchestration in same component using shared preview modals.
- Version history dialog: `document-version-history` component.

## Backend endpoints involved (non-exhaustive core)
- `GET /api/documents`
- `POST /api/document`
- `PUT /api/document/{id}`
- `DELETE /api/document/{id}` (delete)
- `DELETE /api/document/{id}/archive` (archive)
- `POST /api/documentversion` (new version)
- `GET /api/documentversion/{id}` (version history)
