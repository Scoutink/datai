## Pre-Flight Report: P1-002 (Integrate Sync)

### Current Implementation Analysis
- **File:** `app/Repositories/Implementation/PaperRepository.php`
- **Method:** `updatePaper` (Lines 334-400+)
- **Dependency:** `SheetDataService` is already injected via constructor (`$this->sheetDataService`).
- **Logic:**
    - Starts Transaction.
    - Creates Version Snapshot.
    - Updates Paper attributes (including `contentJson`).
    - Updates Metadata.
    - Commits Transaction.

### Impact Trace
- **Direct Impacts:** `updatePaper` method.
- **Change:** Add `$this->sheetDataService->syncFromUniverJson($id, $request->contentJson);` immediately after `$paper->save()`.
- **Indirect Impacts:**
    - Every save operation now triggers a full relational DB sync.
    - Transaction duration increases slightly (DB delete/insert).
    - If Sync fails (throws exception), Paper Update rolls back (Desired behavior).

### Comparison with Golden Reference
- **Documents Module:** Uses `DocumentRepository` which updates separate metadata tables.
- **Papers Module:** Now adopting the same pattern where "Save" triggers an atomic update of all related data structures.

### Test Scenarios
1.  **Standard Save:** Edit paper -> Save -> `contentJson` updates AND `sheet_row_cells` updates.
2.  **Failure Case:** Mock `syncFromUniverJson` to throw exception -> `contentJson` should NOT update (Rollback).
3.  **Performance:** Save large sheet (500 rows) -> Measure time. (Should be < 200ms for typical data).

### Implementation Plan
```php
    public function updatePaper($request, $id)
    {
        try {
            DB::beginTransaction();
            // ... (Version creation)
            // ... (Paper update)
            $paper->save();

            // >>> NEW CODE <<<
            // Sync Relational Data
            $this->sheetDataService->syncFromUniverJson($id, $request->contentJson);
            // >>> END NEW CODE <<<

            // ... (Metadata update)
            DB::commit();
            return $paper;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
```
