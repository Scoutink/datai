## Pre-Flight Report: P1-001 (SheetData Sync)

### Current Implementation Analysis
- **File:** `app/Services/Sheets/SheetDataService.php`
- **Current Logic:**
  - `initializeSheet`: Creates initial columns/rows from frontend configuration.
  - `saveRow`: Updates a single row (used by granular APIs, not used by Univer).
  - **MISSING:** Method to parse full Univer JSON snapshot and sync relational DB.
- **Related File:** `PaperRepository.php` -> `updatePaper` currently blindly saves `contentJson` without updating relational tables.

### Impact Trace
- **Direct Impacts:**
  - `SheetDataService.php`: add `syncFromUniverJson`.
  - `PaperRepository.php`: call `syncFromUniverJson`.
- **Indirect Impacts:**
  - Relational `SheetRows` and `SheetRowCells` tables will now be TRUNCATED and RE-POPULATED on every paper save.
  - Any feature relying on `SheetRows` (Search, Indexing, Reports) will effectively start working.

### JSON Structure Strategy (Univer Snapshot)
The `contentJson` is a Univer Snapshot. We target:
`snapshot.sheets[sheetId].cellData` -> `{ "rowIdx": { "colIdx": { "v": value } } }`

**Mapping Logic:**
1.  **Columns:** Fetch `SheetColumns` sorted by `sortOrder`. Map Univer `colIdx` (0..N) to DB Column UUIDs.
2.  **Rows:** Univer rows are indexed 0..N.
3.  **Strategy:** FULL REPLACE.
    - `DELETE FROM sheet_rows WHERE paperId = ?`
    - Loop Univer Rows -> Create `SheetRows` -> Loop Cells -> Create `SheetRowCells`.

### Test Scenarios
1.  **Empty Sheet**: Save empty grid -> DB should have 0 rows.
2.  **Standard Data**: Save grid with "A1=Test", "B1=100" -> DB should have 1 row, 2 cells with correct types.
3.  **Type Conversion**: Save "true" in boolean column, "123" in number column -> DB should reflect typed values.
4.  **Column Mismatch**: Univer has data in Col 5, but DB only has 3 columns -> Data in Col 5 is ignored (safe).

### Implementation Plan (Draft)
```php
public function syncFromUniverJson($paperId, $jsonContent) {
    // 1. Decode & Find Sheet
    // 2. Load DB Columns (Keyed by 0-based index)
    // 3. Transaction:
    //    - Delete all rows for paper
    //    - Iterate cellData
    //    - Bulk Insert (or optimized create)
}
```

### Validation
- **Manual Test:** Edit paper, look at `sheet_row_cells` table in PHPMyAdmin.
- **Regression:** Ensure `initializeSheet` still works for new papers.
