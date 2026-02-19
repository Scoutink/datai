# 🧩 Jspreadsheet + Notion‑Light Sheets Module — Complete Implementation Blueprint (Laravel + MySQL)

This document replaces the previous Handsontable-based blueprint with **Jspreadsheet CE** and expands the scope to a **Notion‑light database**: relations + rollups + database settings + views, stored in **MySQL**, implemented as a **self‑contained Laravel module**.

> Key constraints (must remain true)
- The **Sheets module** must ONLY handle: sheet schemas, properties/columns, row CRUD, relations, rollups, views, import/export, rendering the grid.
- It must NOT: know about workspace tree, documents, other modules. It can store a `workspace_id` as an opaque foreign identifier if your platform passes it in.

Source baseline: previous blueprint structure and responsibilities.

---

## 0) Why Jspreadsheet CE (and what we can realistically build)

- **Jspreadsheet CE is MIT‑licensed** (no commercial license key).
- Its formula engine has tiers: **Basic is included by default**, Premium/Pro adds advanced capabilities.
- Notion‑style **Relations + Rollups** and **Database settings** are backend features we will implement in Laravel/MySQL, inspired by Notion behavior.

---

## 1) Module folder structure (Laravel)

```
app/
 ├── Modules/
 │    ├── Sheets/
 │    │    ├── Controllers/
 │    │    │    ├── Ui/
 │    │    │    └── Api/
 │    │    ├── Services/
 │    │    ├── Models/
 │    │    ├── Policies/
 │    │    ├── Requests/
 │    │    ├── Jobs/
 │    │    ├── Support/
 │    │    ├── Database/
 │    │    │    ├── migrations/
 │    │    │    └── seeders/
 │    │    ├── routes.php
 │    │    └── resources/views/
 │    │         ├── index.blade.php
 │    │         ├── show.blade.php
 │    │         ├── row.blade.php
 │    │         └── components/
 │    │              └── sheet-grid.blade.php
```

> Keep it fully self‑contained. Do not import other modules.

---

## 2) Notion‑Light Feature Scope

### 2.1 Databases (Sheets)
- Create databases (“Sheets”) and manage properties (“Columns”)
- Multiple views per database (start with **Table view**)
- Lock database: data editable, schema/views locked

### 2.2 Records (Rows)
- CRUD rows, partial updates (single cell), bulk updates
- Row “page” view (a dedicated UI page to edit properties; not a full document system)

### 2.3 Relations
Implement Notion-like relation behaviors:
- One‑way relation, optional two‑way mirrored relation
- Cardinality option: `limit=1` vs `no limit`
- Display modes for the row-page: always / hide-if-empty / always-hide
- “Shown in relation”: configure which target properties appear inline in the relation UI
- Self‑relations supported

### 2.4 Rollups
Implement Notion-like rollups:
- Rollup definition: relation → target property → calculation
- Calculations: counts/unique/empty %, numeric summaries (sum/avg/min/max/etc.), date summaries (earliest/latest/range)
- Prevent “rollup of rollup” loops
- Sortability rule (Notion: rollups sortable only when numeric)

### 2.5 Spreadsheet formulas (Jspreadsheet)
- Allow cell formulas within table view (Jspreadsheet Basic)
- Store formulas and computed values in MySQL (see storage strategy below)

> Note: Notion formulas (property-based) are different from spreadsheet formulas (cell-based). We start with spreadsheet formulas inside the grid, then optionally add Notion-style “Formula property” later.

---

## 3) Data model (MySQL) — tables, columns, indexes

### 3.1 Core tables

#### `sheets`
- `id` (PK)
- `workspace_id` (nullable string/int, *opaque to module*)
- `name` (string)
- `settings` (json) — includes `locked`, default view, etc.
- timestamps, soft deletes

Example `settings`:
```json
{
  "locked": false,
  "default_view_id": 12
}
```

#### `sheet_columns`
Represents Notion “properties”.

- `id` (PK)
- `sheet_id` (FK -> sheets)
- `name` (string)
- `type` (enum/string)
- `sort_order` (int)
- `settings` (json) — per-type config
- `is_required` (bool)
- timestamps, soft deletes

Supported `type` values (phase 1–2):
- `text`, `number`, `bool`, `date`
- `select`, `multi_select`
- `relation`
- `rollup`
- `formula` (grid formula / optional later as property formula)

#### `sheet_rows`
- `id` (PK)
- `sheet_id` (FK)
- `data` (json) — sparse map `{column_id: value}` (canonical row storage)
- `version` (int) — optimistic locking
- timestamps, soft deletes

> Baseline JSON strategy comes from your previous doc.

---

### 3.2 Indexing & filtering strategy (production‑grade)

**Problem:** server-side filtering/sorting on JSON alone can be slow and fragile across MySQL versions.

**Solution:** keep `sheet_rows.data` as canonical JSON, but maintain a typed cell index table.

#### `sheet_row_cells`
- `id` (PK)
- `row_id` (FK -> sheet_rows)
- `sheet_id` (FK -> sheets) (denormalized for fast queries)
- `column_id` (FK -> sheet_columns)
- `value_text` (text, nullable)
- `value_number` (decimal, nullable)
- `value_date` (datetime/date, nullable)
- `value_bool` (tinyint, nullable)
- `value_json` (json, nullable) (for multi-select arrays, etc.)
- indexes:
  - `(sheet_id, column_id, value_text(191))`
  - `(sheet_id, column_id, value_number)`
  - `(sheet_id, column_id, value_date)`
  - `(sheet_id, column_id, value_bool)`
  - unique `(row_id, column_id)`

**Write path:** whenever a row is created/updated, normalize each cell into `sheet_row_cells` in the same DB transaction.

This directly supports:
- pagination, server-side filtering, sorting, lazy loading (MUST list)

---

### 3.3 Relations tables

#### `sheet_relation_edges`
A normalized graph edge per link.

- `id` (PK)
- `relation_column_id` (FK -> sheet_columns) — the column defining the relation (source side)
- `row_id` (FK -> sheet_rows) — source row
- `related_row_id` (FK -> sheet_rows) — target row
- timestamps
- unique `(relation_column_id, row_id, related_row_id)`
- index `(relation_column_id, row_id)`
- index `(related_row_id)` for reverse lookups

**Two‑way relations**
- The relation column’s settings contain `inverse_column_id` (nullable).
- When adding/removing a link:
  - always mutate edges for the source `relation_column_id`
  - if `inverse_column_id` exists, also mutate the mirrored edge row in the reverse direction.

#### Relation column `settings` JSON
```json
{
  "target_sheet_id": 999,
  "inverse_column_id": 1234,
  "limit": "one" | "many",
  "shown_property_ids": [11, 22, 33],
  "page_visibility": "always" | "hide_if_empty" | "always_hide"
}
```
Notion behaviors referenced here: two-way reflection, limit-one, shown properties, page visibility.

---

### 3.4 Rollups

Rollups are a column type (`type=rollup`) and are computed, not directly editable.

#### Rollup column `settings` JSON
```json
{
  "relation_column_id": 555,
  "target_property_id": 777,
  "calculation": "count_all" | "count_values" | "count_unique" | "count_empty" | "percent_empty" |
                 "sum" | "average" | "median" | "min" | "max" | "range" |
                 "earliest_date" | "latest_date" | "date_range" |
                 "show_original" | "show_unique"
}
```

**Validation rules**
- `relation_column_id` must point to a `relation` column.
- `target_property_id` must not be a `rollup` column (no rollup-of-rollup).

#### Optional cache: `sheet_rollup_cache`
For performance once datasets grow.

- `id`
- `row_id`
- `column_id` (rollup column)
- `value_text` / `value_number` / `value_date` / `value_json`
- `computed_at`
- unique `(row_id, column_id)`

**Invalidation triggers**
- relation edges change affecting a row
- target property value changes on a related row

---

### 3.5 Views (Notion-like)

#### `sheet_views`
- `id` (PK)
- `sheet_id` (FK)
- `name`
- `type` (enum: `table` now; later `kanban`, `calendar`, `list`)
- `config` (json)
- `sort_order` (int)
- timestamps

Example `config`:
```json
{
  "visible_column_ids": [1,2,3,4],
  "filters": [{"column_id": 2, "op": "contains", "value": "Acme"}],
  "sort": [{"column_id": 4, "dir": "asc"}],
  "row_height": 28
}
```

---

### 3.6 Audit logging (MUST)

#### `sheet_audit_logs`
- `id`
- `sheet_id`
- `actor_id` (nullable; platform user id)
- `action` (enum: `sheet.create`, `column.update`, `row.update`, `relation.add`, etc.)
- `meta` (json) — include old/new diffs
- timestamps

This matches the earlier required checklist.

---

## 4) Models (Eloquent)

### `Sheet`
- casts: `settings` array
- relations: `columns()`, `rows()`, `views()`

### `SheetColumn`
- casts: `settings` array
- belongsTo `sheet`

### `SheetRow`
- casts: `data` array
- belongsTo `sheet`
- hasMany `cells()`

### `SheetRowCell`
- belongsTo `row`, `sheet`, `column`

### `SheetView`
- casts: `config` array

### `SheetRelationEdge`
- belongsTo `relationColumn`, `row`, `relatedRow`

### `SheetRollupCache` (optional)
- belongsTo `row`, `column`

### `SheetAuditLog`
- belongsTo `sheet`

---

## 5) Services layer (NO logic in controllers)

This requirement is inherited from your previous doc.

### 5.1 `SheetSchemaService`
Responsibilities:
- create/update/delete sheet
- create/update/delete columns (with validations)
- lock/unlock database (toggle `sheet.settings.locked`)
- create/update/delete views
- create relation columns + optional mirrored inverse column
- prevent breaking changes (e.g., deleting a column with dependencies unless forced)

Key methods:
- `createSheet($workspaceId, $name, $settings)`
- `addColumn(Sheet $sheet, array $payload)`
- `updateColumn(SheetColumn $column, array $payload)`
- `deleteColumn(SheetColumn $column, bool $force=false)`
- `setLocked(Sheet $sheet, bool $locked)`
- `createView(Sheet $sheet, array $payload)`
- `updateView(SheetView $view, array $payload)`

Locking rule:
- When locked: row CRUD allowed, schema/views mutations denied (enforce via policy/middleware).

### 5.2 `SheetDataService`
Responsibilities:
- create/update/delete rows
- partial cell updates (single property update)
- validate values by column type
- transactional writes + updating `sheet_row_cells`
- optimistic locking via `version`
- trigger rollup recalculations

Key methods:
- `createRow(Sheet $sheet, array $data)`
- `updateRow(SheetRow $row, array $data, int $expectedVersion)`
- `updateCell(SheetRow $row, SheetColumn $column, $value, int $expectedVersion)`
- `deleteRow(SheetRow $row)`
- `rebuildRowCells(SheetRow $row)` (internal)

### 5.3 `SheetRelationService`
Responsibilities:
- add/remove relation edges
- enforce relation cardinality (`limit=one` vs `many`)
- maintain inverse edges for two-way relations
- fetch relation options (search + pagination) with caching
- return “shown properties” previews for relation cells

Key methods:
- `link(SheetRow $row, SheetColumn $relationColumn, array $relatedRowIds)`
- `unlink(SheetRow $row, SheetColumn $relationColumn, array $relatedRowIds)`
- `searchOptions(SheetColumn $relationColumn, string $q, int $limit, ?string $cursor=null)`

### 5.4 `SheetRollupService`
Responsibilities:
- validate rollup definitions (no rollup-of-rollup)
- compute rollup values for a row on demand
- optional caching/materialization via `sheet_rollup_cache`
- invalidate caches on relation/value changes

Key methods:
- `computeForRow(SheetRow $row, array $rollupColumnIds=null)`
- `invalidateForRow(SheetRow $row, array $rollupColumnIds=null)`
- `recomputeAsync(Sheet $sheet, array $rowIds=null)` (dispatch job)

### 5.5 `SheetViewQueryService`
Responsibilities:
- apply view filters/sorts/pagination on server
- return rows + columns metadata for grid
- enforce “sort only numeric rollups” if you mirror Notion’s rule

Key methods:
- `getViewData(SheetView $view, array $params)` returning:
  - `columns[]` metadata
  - `rows[]` data
  - `cursor/pagination`
  - `aggregates` (optional)

### 5.6 `SheetImportExportService`
Responsibilities:
- CSV/XLSX export
- bulk import with mapping to columns
- chunk reading + queued processing for large files
- define relation import rules (recommended: allow ID-based import; do not rely on URLs)

Implementation note:
- Use Laravel Excel (Maatwebsite/Spartner) for import/export; it’s MIT (postcardware request).

---

## 6) Policies & permission middleware (MUST)

- `SheetPolicy`:
  - `view`, `update`, `delete`, `manageSchema`, `manageViews`, `editData`
- Enforce “locked database”:
  - `manageSchema/manageViews` => **deny if locked**
  - `editData` => allow if user has normal edit permission

This matches the earlier checklist item “permission middleware”.

---

## 7) Requests (validation)

Create FormRequest classes, e.g.:
- `CreateSheetRequest`
- `UpdateSheetRequest`
- `CreateColumnRequest`
- `UpdateColumnRequest`
- `CreateRowRequest`
- `UpdateRowRequest`
- `LinkRelationRequest`
- `CreateRollupColumnRequest`
- `UpdateViewRequest`

Validation highlights:
- Column type-specific validation (select options, relation target sheet id, rollup definition)
- Rollup-of-rollup reject
- Relation `limit=one` enforce at service level too

---

## 8) Routes (UI + API split)

Baseline routes remain, expanded:

### UI routes (Blade)
- `GET /sheets` — list
- `GET /sheets/create`
- `POST /sheets`
- `GET /sheets/{sheet}` — show (grid)
- `GET /sheets/{sheet}/rows/{row}` — row page
- `GET /sheets/{sheet}/settings` — database settings (lock, properties)

### API routes
- `GET /api/sheets/{sheet}` — sheet metadata
- `GET /api/sheets/{sheet}/columns`
- `POST /api/sheets/{sheet}/columns`
- `PATCH /api/sheets/{sheet}/columns/{column}`
- `DELETE /api/sheets/{sheet}/columns/{column}`

- `GET /api/sheets/{sheet}/views`
- `POST /api/sheets/{sheet}/views`
- `PATCH /api/sheets/{sheet}/views/{view}`
- `DELETE /api/sheets/{sheet}/views/{view}`

- `GET /api/sheets/{sheet}/rows` — view data (supports cursor/page, filters, sorts)
- `POST /api/sheets/{sheet}/rows`
- `PATCH /api/sheets/{sheet}/rows/{row}` — partial update
- `DELETE /api/sheets/{sheet}/rows/{row}`

- `GET /api/sheets/{sheet}/relations/options` — (relationColumnId, q, cursor)
- `POST /api/sheets/{sheet}/relations/link`
- `POST /api/sheets/{sheet}/relations/unlink`

- `GET /api/sheets/{sheet}/aggregates` — footer/summary (optional)

- `POST /api/sheets/{sheet}/export` — background job
- `POST /api/sheets/{sheet}/import` — background job

---

## 9) Frontend (Jspreadsheet CE integration)

This module uses Blade for demonstration, but your platform can render the component however it likes.

### 9.1 Install (NPM)
```bash
npm install jspreadsheet-ce
```
Jspreadsheet CE is MIT and published on npm.

### 9.2 Blade component: `resources/views/components/sheet-grid.blade.php`
High-level pattern:
- fetch columns + rows from API view endpoint
- map columns into Jspreadsheet config
- wire `onchange` to `PATCH` cell updates with optimistic locking
- implement lazy loading by fetching next cursor and appending rows

**Important:** the grid is “dumb”; all truth lives in your API + services.

### 9.3 Row identity mapping
Jspreadsheet works primarily with row/col indices; you must keep:
- `rowIndex -> rowId`
- `colIndex -> columnId`

Return these in API payload:
```json
{
  "columns": [{ "id": 10, "name": "Name", "type": "text", "settings": {} }, ...],
  "rows": [
    { "id": 501, "cells": ["Acme", 12, true, "2026-02-14"] },
    ...
  ],
  "cursor": "..."
}
```

### 9.4 Relation editor (Notion-like)
Jspreadsheet’s default dropdown is not enough for:
- large target DB
- remote search
- multiple select
- showing preview properties

So implement a custom cell editor:
- click relation cell → open modal
- modal calls `/api/sheets/{sheet}/relations/options?q=...&relationColumnId=...`
- selection writes back:
  - store related row IDs in row.data[columnId] as array
  - service writes `sheet_relation_edges`
  - return preview props configured by `shown_property_ids`

### 9.5 Rollups display
Rollups are **read-only** in grid:
- computed server-side and returned in `rows.cells[]`
- optionally also returned in row page view

### 9.6 Formulas (grid)
- Allow users to type formulas in cells (Jspreadsheet Basic)
- Store the formula string in `sheet_rows.data[columnId]` (e.g., `"=SUM(A1:A10)"`)
- Store displayed value in `sheet_row_cells.value_number/value_text` as needed for filtering/sorting.
- Decide one of:
  1) “Client is source of computed value” (simpler): client sends `value` and `formula`.
  2) “Server recomputes” (hard): needs a server formula engine that matches client.

Recommended for Phase 1: **client calculates, server stores** (with audit logs), plus validation/sanitization.

---

## 10) Database settings UI (Notion-inspired)

### 10.1 Lock database
- Toggle `sheet.settings.locked=true`
- Enforced by policies: schema + views blocked, data allowed

### 10.2 Edit properties panel
Requirements (from Notion “Edit properties” concept):
- search properties
- create new
- open property editor
- duplicate property
- delete property

### 10.3 Future toggles (Phase 3+)
Notion includes automations and task-focused toggles. We track them but do not implement now.

---

## 11) Production checklist (updated)

This updates your prior checklist with relations/rollups/settings, keeping the original MUST/SHOULD items.

### MUST
- ✅ pagination (cursor preferred)
- ✅ server-side filtering
- ✅ lazy loading
- ✅ row validation
- ✅ transactions
- ✅ audit logging
- ✅ background jobs for heavy ops (import/export/recompute)
- ✅ permission middleware / policies
- ✅ relation dropdown (remote search)
- ✅ relations: one-way + optional two-way, limit-one, self-relations
- ✅ rollups: definition + calculation set + loop prevention
- ✅ database lock mode

### SHOULD
- ✅ CSV/XLSX export
- ✅ bulk import
- ✅ caching relation options
- ✅ optimistic locking (row `version`)
- ✅ rollup caching/materialization
- ✅ aggregates/footer calculations
- ✅ view management UX (sort/filter presets per view)

---

## 12) Strategic build order (safe execution plan)

Keep the same “never mix steps” discipline from the original doc.

### Phase 1 — Core CRUD (no relations)
1) Sheets CRUD (model + migrations + policies)
2) Columns CRUD (types: text/number/bool/date/select)
3) Rows CRUD + `sheet_row_cells` indexing
4) Table View API with pagination/filter/sort
5) Jspreadsheet grid rendering (read + edit single cell)

### Phase 2 — Relations
6) Relation column type + edges table
7) Relation options endpoint + caching
8) Custom relation editor modal
9) Two-way relations + inverse column creation
10) Cardinality enforcement (`limit=one`)

### Phase 3 — Rollups
11) Rollup column type + validation
12) Compute-on-read rollups
13) Rollup cache + invalidation + recompute job

### Phase 4 — Views + Settings
14) Views table + view query layer
15) Database settings: lock + property management panel
16) Aggregates/footer calculations

### Phase 5 — Import/Export
17) CSV/XLSX export job
18) Import with mapping UI + chunk reading + queued jobs

---

## 13) Build/Install Steps (if applicable)

### Local dev
1) Backend:
```bash
php artisan migrate
```

2) Frontend assets:
```bash
npm install
npm install jspreadsheet-ce
npm run build
```
Jspreadsheet CE is distributed via npm.

### Production (Plesk / server)
- Use your standard asset pipeline. Prefer building in CI and uploading built assets if your server build is constrained.
- For imports/exports:
  - configure queue worker (recommended) because Laravel Excel supports queued chunk imports.

---

## 14) Non-negotiable engineering rules (anti-bug mode)

- Controllers: thin; only validate request + call service + return response.
- All writes in transactions.
- Every change writes an audit log entry.
- Schema changes blocked when DB is locked.
- Relation + rollup invariants enforced at service layer (never rely on UI).
- Add tests for:
  - relations: two-way sync, limit-one enforcement
  - rollups: calculation correctness, invalidation, loop prevention
  - filters/sorts: numeric vs non-numeric rollup sort rules

---

## 15) Appendix — Notion behaviors we explicitly mirror

- Relations reflect across two-way relation and can be configured as one-way.
- Relation display modes and “shown properties in relation”.
- Rollups are defined by relation + property + calculation and prevent recursive rollups.
- Database lock allows data entry but blocks view/property changes.

---

## References (product docs)

```text
Notion – Relations and Rollups
https://www.notion.com/help/relations-and-rollups

Notion – Database settings / Customize your database
https://www.notion.com/help/customize-your-database

Jspreadsheet CE – Docs (incl. formulas)
https://bossanova.uk/jspreadsheet/docs
https://jspreadsheet.com/docs/v8/formulas

Laravel Excel (Maatwebsite/Spartner) – Docs
https://docs.laravel-excel.com/3.1/imports/queued.html
https://github.com/SpartnerNL/Laravel-Excel
```
