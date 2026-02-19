## Pre-Flight Report: P1-003 (Integrate Sync into Restore)

### Current Implementation Analysis
- **File:** `app/Repositories/Implementation/PaperVersionsRepository.php`
- **Method:** `restorePaperVersion` (Lines 36-84)
- **Current Logic:**
    - Creates a backup version of current state.
    - Replaces Paper attributes with Version attributes.
    - Saves Paper.
    - **MISSING:** Does not update `SheetRows`/`SheetRowCells`.
- **Dependency:** `SheetDataService` is NOT currently injected.

### Impact Trace
- **Direct Impacts:**
    - `__construct`: Add `SheetDataService`.
    - `restorePaperVersion`: Call `syncFromUniverJson`.
- **Change:**
    - Inject `SheetDataService`.
    - Call `$this->sheetDataService->syncFromUniverJson($paper->id, $paper->contentJson);` after `$paper->save()`.
- **Indirect Impacts:**
    - Restoring a version now correctly reverts the relational data to match that version's JSON.
    - Prevents data corruption where JSON is V1 and Relations are V5.

### Test Scenarios
1.  **Standard Restore:** Paper is V5. Restore V1. -> `contentJson` matches V1 AND `SheetRows` match V1 data.
2.  **Failure Case:** `sync` fails -> Transaction rolls back -> Paper stays at V5 (Backup version not committed).

### Implementation Plan
```php
    protected $sheetDataService;

    public function __construct(SheetDataService $sheetDataService)
    {
        parent::__construct();
        $this->sheetDataService = $sheetDataService;
    }

    public function restorePaperVersion($id)
    {
        // ... (Transactions, Backup, Update)
        $paper->save();

        // >>> NEW CODE <<<
        // Re-sync Relational Data to match the restored version
        $this->sheetDataService->syncFromUniverJson($paper->id, $paper->contentJson);
        // >>> END NEW CODE <<<

        // ... (Audit, Commit)
    }
```
