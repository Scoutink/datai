# Sharing Links Flow

## Link creation/update (authenticated)
1. UI loads existing link per document via `DocumentService.getDocumentShareableLink(id)`.
2. Link save/update posts to `DocumentSharebaleLinkController@createOrUpdate`.
3. Repository behavior (`DocumentShareableLinkRepository`):
   - One link per document (update existing if found).
   - Generates `linkCode` once (`base64_encode(uuid)`) for new records.
   - Stores password base64-encoded when provided.
   - Normalizes `linkExpiryTime` to minute precision.

## Public link resolution
Public endpoints (no JWT) include:
- `GET /api/document-sharable-link/{code}/info` → expiry/password metadata.
- `GET /api/document-sharable-link/{code}/document` → linked document info.
- `POST /api/document-sharable-link/{code}/readText` → text extraction with optional password.
- `GET /api/document-sharable-link/{code}/download` → file download.
- `GET /api/document-sharable-link/{code}/token` → office viewer token flow.

## Password + expiry checks
- Expiry is computed in repository using current time vs `linkExpiryTime`.
- Download/read paths validate password by decoding stored base64 and matching request password.
- Missing link or invalid password returns error responses (`404`/`401` depending endpoint path).

## Authorization model
- Management operations (CRUD over links) are claim-protected API routes.
- Public consumer endpoints rely on possession of link code plus optional password/expiry validation.
