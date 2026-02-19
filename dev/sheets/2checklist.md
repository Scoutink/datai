# Notion-Light Sheets Module — Migration-by-Migration Implementation Checklist (Laravel + MySQL + Jspreadsheet)

This is the ordered, copy/paste checklist to implement the `sheet.md` plan end-to-end.
It assumes a self-contained module with services as the only place for business logic.

---

## Phase 0 — Module wiring (do once)

- [ ] Create module folders (if not already):
  - `app/Modules/Sheets/{Controllers/Ui,Controllers/Api,Services,Models,Policies,Requests,Jobs,Support,Database/migrations,resources/views/components}`
- [ ] Add a `SheetsServiceProvider` that:
  - `loadRoutesFrom(__DIR__.'/routes.php')`
  - `loadViewsFrom(__DIR__.'/resources/views', 'sheets')`
  - `loadMigrationsFrom(__DIR__.'/Database/migrations')`
- [ ] Ensure your platform bootstraps module providers (however you do it today).

---

## Phase 1 — Database migrations (run in this exact order)

> Convention: put migrations in `app/Modules/Sheets/Database/migrations/`

### M1) `create_sheets_table`
Command:
- `php artisan make:migration create_sheets_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheets`:
  - `id` (bigint PK)
  - `workspace_id` (nullable string/bigint) — opaque to module
  - `name` (string)
  - `settings` (json) — includes `locked`, `default_view_id`, etc.
  - `timestamps`, `softDeletes`
- [ ] Add index: `workspace_id` (if you’ll query by workspace often)

After migration:
- [ ] Run: `php artisan migrate`

---

### M2) `create_sheet_columns_table`
Command:
- `php artisan make:migration create_sheet_columns_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheet_columns`:
  - `id` (bigint PK)
  - `sheet_id` (FK → sheets)
  - `name` (string)
  - `type` (string)  // text, number, bool, date, select, multi_select, relation, rollup, formula
  - `sort_order` (int)
  - `settings` (json) // per-type config (relation/rollup/select/etc)
  - `is_required` (bool default false)
  - `timestamps`, `softDeletes`
- [ ] Indexes:
  - `(sheet_id, sort_order)`
  - `(sheet_id, type)`
- [ ] FK rule:
  - `sheet_id` → `sheets.id` (recommend `cascadeOnDelete()` for hard deletes)

After migration:
- [ ] `php artisan migrate`

---

### M3) `create_sheet_rows_table`
Command:
- `php artisan make:migration create_sheet_rows_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheet_rows`:
  - `id` (bigint PK)
  - `sheet_id` (FK → sheets)
  - `data` (json) — sparse map `{column_id: value}`
  - `version` (int default 1) — optimistic locking
  - `timestamps`, `softDeletes`
- [ ] Indexes:
  - `(sheet_id, id)` (pagination)
  - `(sheet_id, updated_at)` (recent ordering)
- [ ] FK:
  - `sheet_id` → `sheets.id` (cascade for hard deletes)

After migration:
- [ ] `php artisan migrate`

---

### M4) `create_sheet_row_cells_table` (typed index table for filtering/sorting)
Command:
- `php artisan make:migration create_sheet_row_cells_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheet_row_cells`:
  - `id` (bigint PK)
  - `row_id` (FK → sheet_rows)
  - `sheet_id` (FK → sheets) (denormalized)
  - `column_id` (FK → sheet_columns)
  - `value_text` (text nullable)
  - `value_number` (decimal nullable)
  - `value_date` (datetime/date nullable)
  - `value_bool` (tinyint nullable)
  - `value_json` (json nullable) // multi_select arrays etc.
  - `timestamps` (optional; if you want)
- [ ] Constraints / indexes:
  - Unique `(row_id, column_id)`
  - Index `(sheet_id, column_id, value_number)`
  - Index `(sheet_id, column_id, value_date)`
  - Index `(sheet_id, column_id, value_bool)`
  - Index `(sheet_id, column_id, value_text(191))`
- [ ] FKs:
  - `row_id` → `sheet_rows.id` (cascade for hard deletes)
  - `sheet_id` → `sheets.id`
  - `column_id` → `sheet_columns.id`

After migration:
- [ ] `php artisan migrate`

---

### M5) `create_sheet_relation_edges_table`
Command:
- `php artisan make:migration create_sheet_relation_edges_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheet_relation_edges`:
  - `id` (bigint PK)
  - `relation_column_id` (FK → sheet_columns) // the “relation property”
  - `row_id` (FK → sheet_rows) // source row
  - `related_row_id` (FK → sheet_rows) // target row
  - `timestamps`
- [ ] Constraints / indexes:
  - Unique `(relation_column_id, row_id, related_row_id)`
  - Index `(relation_column_id, row_id)`
  - Index `(related_row_id)` (reverse lookup)
- [ ] FKs: cascade for hard deletes

After migration:
- [ ] `php artisan migrate`

---

### M6) `create_sheet_views_table`
Command:
- `php artisan make:migration create_sheet_views_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheet_views`:
  - `id` (bigint PK)
  - `sheet_id` (FK → sheets)
  - `name` (string)
  - `type` (string) // table now; later kanban/calendar/list
  - `config` (json) // visible columns, filters, sort, row height, etc.
  - `sort_order` (int)
  - `timestamps`
- [ ] Indexes:
  - `(sheet_id, sort_order)`
- [ ] FK:
  - `sheet_id` → `sheets.id` (cascade for hard deletes)

After migration:
- [ ] `php artisan migrate`

---

### M7) `create_sheet_rollup_cache_table` (recommended; can be disabled early)
Command:
- `php artisan make:migration create_sheet_rollup_cache_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheet_rollup_cache`:
  - `id` (bigint PK)
  - `row_id` (FK → sheet_rows)
  - `column_id` (FK → sheet_columns) // rollup column
  - `value_text` (nullable)
  - `value_number` (nullable)
  - `value_date` (nullable)
  - `value_json` (nullable)
  - `computed_at` (timestamp nullable)
  - `timestamps` (optional)
- [ ] Unique `(row_id, column_id)`
- [ ] Index `(column_id)`

After migration:
- [ ] `php artisan migrate`

---

### M8) `create_sheet_audit_logs_table`
Command:
- `php artisan make:migration create_sheet_audit_logs_table --path=app/Modules/Sheets/Database/migrations`

Checklist:
- [ ] Create `sheet_audit_logs`:
  - `id` (bigint PK)
  - `sheet_id` (FK → sheets)
  - `actor_id` (nullable bigint/string) // platform user id (opaque)
  - `action` (string) // e.g. sheet.create, row.update, relation.add
  - `meta` (json) // diffs, payloads
  - `timestamps`
- [ ] Indexes:
  - `(sheet_id, created_at)`
  - `(actor_id, created_at)` (optional)
- [ ] FK:
  - `sheet_id` → `sheets.id`

After migration:
- [ ] `php artisan migrate`

---

## Phase 2 — Post-migration build tasks (in the same order)

### After M1–M3 (core CRUD)

- [ ] Create Eloquent models:
  - `Sheet` (`settings` cast to array)
  - `SheetColumn` (`settings` cast to array)
  - `SheetRow` (`data` cast to array)
- [ ] Add relationships:
  - `Sheet->columns()`, `Sheet->rows()`
  - `SheetRow->sheet()`
- [ ] Create services (no controller logic):
  - `SheetSchemaService` (create sheet, add/update/delete column)
  - `SheetDataService` (create/update/delete row, optimistic locking)
- [ ] Create API endpoints:
  - `GET /api/sheets/{sheet}` (meta + default view)
  - `GET /api/sheets/{sheet}/columns`
  - `POST /api/sheets/{sheet}/columns`
  - `PATCH /api/sheets/{sheet}/columns/{column}`
  - `DELETE /api/sheets/{sheet}/columns/{column}`
  - `GET /api/sheets/{sheet}/rows?view_id=&page=&filters=&sort=`
  - `POST /api/sheets/{sheet}/rows`
  - `PATCH /api/sheets/{sheet}/rows/{row}` (requires `version`)
  - `DELETE /api/sheets/{sheet}/rows/{row}`
- [ ] Requests:
  - `StoreSheetRequest`, `StoreColumnRequest`, `UpdateColumnRequest`
  - `StoreRowRequest`, `UpdateRowRequest` (validate required properties)

### After M4 (server-side filtering/sorting)

- [ ] Implement `SheetCellIndexService`:
  - called inside the **same DB transaction** whenever a row is saved
  - upserts `(row_id, column_id)` into `sheet_row_cells` with the correct typed value
- [ ] Update `SheetDataService` to:
  - write `sheet_rows.data`
  - update `sheet_row_cells`
  - bump `version` on update
- [ ] Update row query builder to use `sheet_row_cells` for filters/sorts/pagination.

### After M5 (relations)

- [ ] Implement `SheetRelationService`:
  - add/remove edges
  - enforce `limit: one|many`
  - support two-way via `inverse_column_id` in column settings
  - self-relations supported
- [ ] Add endpoints:
  - `GET /api/sheets/{sheet}/relation-options?column_id=&q=`
  - `POST /api/sheets/{sheet}/relations/link` (row_id, column_id, related_row_id)
  - `POST /api/sheets/{sheet}/relations/unlink` (...)
- [ ] Add relation “shown properties” support:
  - relation column setting `shown_property_ids[]`
  - API returns preview payload for linked rows (for rendering)

### After M6 (views)

- [ ] Implement `SheetViewService`:
  - CRUD views
  - apply view filters/sort/visible columns to row query
- [ ] Endpoints:
  - `GET /api/sheets/{sheet}/views`
  - `POST /api/sheets/{sheet}/views`
  - `PATCH /api/sheets/{sheet}/views/{view}`
  - `DELETE /api/sheets/{sheet}/views/{view}`

### After M7 (rollups)

- [ ] Implement `SheetRollupService`:
  - validate (relation column exists, no rollup-of-rollup)
  - compute rollups (start with compute-on-read for small sheets)
  - optional cache fill into `sheet_rollup_cache`
- [ ] Add a job:
  - `RecomputeSheetRollupsJob` triggered when:
    - relation edges change
    - target property changes on related rows
- [ ] Add endpoints:
  - `GET /api/sheets/{sheet}/rollups/recompute` (admin/dev only) or internal dispatch

### After M8 (audit logging)

- [ ] Implement `SheetAuditService`:
  - called from services (NOT controllers) for: create/update/delete sheet/column/row + relation link/unlink + view changes + lock toggles
- [ ] Add endpoint (optional):
  - `GET /api/sheets/{sheet}/audit?page=`

---

## Phase 3 — UI hookup (minimal, to prove end-to-end)

- [ ] Replace grid with **Jspreadsheet CE** in `resources/views/components/sheet-grid.blade.php`
- [ ] Implement client ↔ API mapping:
  - fetch columns + view config
  - fetch paginated rows
  - write-back on change (debounced)
  - handle optimistic locking conflicts (version mismatch → refetch row)

---

## Phase 4 — “No surprises” hardening (bugs prevention)

- [ ] Add integration tests per milestone:
  - rows CRUD + cell index updates
  - filter/sort correctness via `sheet_row_cells`
  - relation limit-one enforcement
  - two-way reflection correctness
  - rollup loop prevention
  - lock mode (data OK, schema/view blocked)
- [ ] Add background jobs for import/export later (if/when you enable Laravel Excel)

---
