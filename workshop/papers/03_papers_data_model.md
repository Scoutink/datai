# Papers Data Model

## Core tables used by Papers
- `papers`
  - core fields: `id`, `name`, `contentType`, `contentJson`, `contentHtmlSanitized`, `contentText`, `wordCount`, `readingTimeMinutes`, category/client/status, retention and audit columns.
- `paperVersions`
  - version snapshots per paper including content and derived fields.
- `paperComments`
- `paperAuditTrails`
- `paperUserPermissions`
- `paperRolePermissions`
- `paperShareableLinks`
- `paperTokens`
- `paperAssets`

## Univer state storage
- Primary state is persisted in `papers.contentJson` (longText JSON string).
- On updates, repository also syncs relational sheet tables from JSON via `SheetDataService::syncFromUniverJson`.

## Sheet relational tables
- `sheetColumns` (schema/config)
- `sheetRows` (row data JSON)
- `sheetRowCells` (typed/indexed cell values)

## Ownership/permissions/share-link relation
- Ownership derives from `papers.createdBy`.
- Access can be owner or explicit user/role permission rows with optional time-bound window.
- Share links are modeled in `paperShareableLinks` (`code`, password hash, expiry, allow-download).

## Evidence files
- Models: `app/Models/Papers.php`, `app/Models/PaperVersions.php`, `app/Models/PaperShareableLinks.php`, `app/Models/PaperUserPermissions.php`, `app/Models/PaperRolePermissions.php`, `app/Models/SheetColumns.php`, `app/Models/SheetRows.php`, `app/Models/SheetRowCells.php`.
- Migrations: `database/migrations/2026_02_13_000000_create_papers_system_tables.php`, `2026_02_14_000001_add_content_type_to_papers_table.php`, `2026_02_14_000002_create_sheets_core_tables.php`.
- Runtime snapshot confirmation: `dev/h5p-debug/datai.sql` contains the same papers/sheet table families in active DB.
