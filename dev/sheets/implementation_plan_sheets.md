# 📊 Implementation Plan: Sheets for Unified Papers Platform

This plan tailors the brainstorming blueprint to the **DATAI Architecture**: Laravel backend, Angular frontend, UUID-heavy database, and the **Unified Papers Platform** container.

## 0) Architectural Strategy: "The Polymorphic Sheet"
Instead of a separate module, **Sheets** will be a polymorphic extension of **Papers**.
- **Metadata Container**: The existing `papers` table stores title, category, client, and `contentType = 'SHEET'`.
- **Relational Core**: The specialized grid data (columns, rows, cells, relations) will live in 8 new tables linked to `papers.id`.
- **Infrastructure Reuse**: We will reuse `paperComments`, `paperVersions`, `paperAuditTrails`, and RBAC claims.

---

## 1) Database Schema (Tailored for UUIDs & DATAI Conventions)

All new tables will use **UUIDs** as primary keys and follow the `createdDate/modifiedDate` naming convention from `ORGANIC_MODULE_PLAYBOOK.md`.

### 1.1 Structural Tables
1.  **`sheetColumns`**: Defines properties (Notion-like properties).
    - `id` (UUID PK), `paperId` (UUID FK -> papers), `name`, `type`, `sortOrder`, `settings` (JSON), `isRequired` (Bool).
2.  **`sheetRows`**: Canonical row storage.
    - `id` (UUID PK), `paperId` (UUID FK), `data` (JSON - sparse map), `version` (Int - optimistic lock).
3.  **`sheetRowCells`**: Typed index table for high-performance filtering/sorting/pagination.
    - `id` (UUID PK), `rowId` (FK), `paperId` (FK), `columnId` (FK).
    - `valueText` (Text), `valueNumber` (Decimal), `valueDate` (DateTime), `valueBool` (Bool), `valueJson` (JSON).

### 1.2 Intelligence Tables (Relations & Rollups)
4.  **`sheetRelationEdges`**: Normalized graph links between rows.
    - `id` (UUID PK), `relationColumnId` (FK), `sourceRowId` (FK), `targetRowId` (FK).
5.  **`sheetRollupCache`**: Materialized values for complex rollup calculations.
    - `id` (UUID PK), `rowId` (FK), `columnId` (FK), `value...` (typed columns).
6.  **`sheetViews`**: Filters, sorts, and visible column presets.
    - `id` (UUID PK), `paperId` (FK), `name`, `type` (e.g., TABLE), `config` (JSON).

---

## 2) Backend Implementation (Laravel)

### 2.1 Services (The Engine)
- **`SheetService`**: Coordinates all sheet operations.
- **`SheetSchemaService`**: Manages columns and views. Validates that "Locked" sheets cannot have schema changes.
- **`SheetDataService`**: Handles row CRUD and atomic updates to both `sheetRows` and `sheetRowCells`.
- **`SheetRelationService`**: Manages two-way mirrored relations and cardinality (`limit=1`).
- **`SheetRollupService`**: Computes summaries (sum, avg, count) across relations.

### 2.2 Repository Integration
We will NOT bloat `PaperRepository`. Instead, we will use a **Delegation Pattern**:
- `PaperRepository->savePaper()` will detect `SHEET` type and call `SheetService->initializeDefaultSheet()`.
- `PaperRepository->getPaper()` will load the sheet's current View configuration and initial row page.

---

## 3) Frontend Implementation (Angular + Jspreadsheet)

### 3.1 Component Architecture
- **`SheetGridComponent`**: Wrapper for `jspreadsheet-ce`.
- **`SheetCellEditorComponent`**: Custom Angular modals for complex cell types (Relation Picker, Multi-Select).
- **`SheetPropertyPanelComponent`**: Side-panel for managing column settings (type, relation targets, rollups).

### 3.2 Features
- **Partial Updates**: Every cell edit triggers a `PATCH` to the backend.
- **Optimistic Locking**: Handle `409 Conflict` if two users edit the same cell/row simultaneously (based on `version`).
- **Lazy Loading**: Use the `PaperService` with cursor-based pagination to fetch rows as the user scrolls.

---

## 4) RBAC & Security
- **Reuse Papers Claims**:
  - `ALL_PAPERS_EDIT_PAPER` / `MY_PAPERS_EDIT_PAPER` -> Controls row data entry.
- **New Logic (Database Lock)**:
  - If a Sheet is "Locked" in settings, the UI hides property/view management, and the backend denies schema-altering requests, even if the user has edit claims.

---

## 5) Phased Delivery Plan

### Phase 1: Core Grid (The "Prototypical Sheet")
- Migrations for `sheetColumns`, `sheetRows`, `sheetRowCells`.
- `SheetDataService` implementation (Atomic JSON + Cell writes).
- Angular `SheetGridComponent` with basic text/number/date support.

### Phase 2: Relations & Rollups (The "Notion" Logic)
- Migrations for `sheetRelationEdges` and `sheetRollupCache`.
- Relation Picker UI.
- Async rollup recomputation jobs.

### Phase 3: Views & Polishing
- `sheetViews` management.
- Database Locking feature.
- CSV/XLSX Export via Laravel Excel.

---

## 6) Verification Checklist
- [ ] **Parity Check**: Count of `sheetRows` must match results in `sheetRowCells`.
- [ ] **Concurrency**: Edit cell A as User 1, then cell A as User 2 -> Confirm conflict resolution.
- [ ] **Relationship Integrity**: Deleting a source row must cleanup `sheetRelationEdges`.
- [ ] **RBAC**: A user with only "View" claims shouldn't see the "Save" request succeed.

---

---
100: 
101: ## 7) Initialization & Guarding (Fix 500 Errors)
102: - **Frontend Guard**: `SheetGridComponent` must verify `paperId` before API calls.
103: - **New Sheet State**: If `!paperId` (Add Paper mode), show a message: "Sheet initialization occurs after metadata is saved."
104: - **Backend Validation**: `SheetController` should use UUID validation on the `{paperId}` parameter to prevent 500s from non-UUID strings.
105: 
106: ---
107: 
108: **Next Step**: Begin implementing Phase 1 Migrations & Fix Initialization Guards.
