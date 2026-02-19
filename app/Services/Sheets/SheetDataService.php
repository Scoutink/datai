<?php

namespace App\Services\Sheets;

use App\Models\SheetColumns;
use App\Models\SheetRows;
use App\Models\SheetRowCells;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class SheetDataService
{
    /**
     * Save or update a row and its indexed cells.
     */
    public function saveRow(string $paperId, array $data, ?string $rowId = null, ?int $expectedVersion = null)
    {
        return DB::transaction(function () use ($paperId, $data, $rowId, $expectedVersion) {
            if ($rowId) {
                $row = SheetRows::findOrFail($rowId);
                
                // Optimistic locking check
                if ($expectedVersion !== null && $row->version !== $expectedVersion) {
                    throw new \Exception("Optimistic locking conflict: row version mismatch. Expected $expectedVersion, found {$row->version}.");
                }

                $row->data = $data;
                $row->version += 1;
                $row->save();
            } else {
                $row = SheetRows::create([
                    'paperId' => $paperId,
                    'data' => $data,
                    'version' => 1
                ]);
            }

            $this->indexRow($row);

            return $row;
        });
    }

    /**
     * Normalize JSON data into typed columns in sheetRowCells.
     */
    public function indexRow(SheetRows $row)
    {
        $columns = SheetColumns::where('paperId', $row->paperId)->get()->keyBy('id');
        $data = $row->data ?? [];

        foreach ($data as $columnId => $value) {
            $column = $columns->get($columnId);
            if (!$column) continue;

            $cellData = [
                'rowId' => $row->id,
                'paperId' => $row->paperId,
                'columnId' => $columnId,
                'createdDate' => Carbon::now(),
                'modifiedDate' => Carbon::now(),
            ];

            // Map value based on column type
            switch ($column->type) {
                case 'number':
                    $cellData['valueNumber'] = is_numeric($value) ? (float)$value : null;
                    break;
                case 'bool':
                case 'boolean':
                    $cellData['valueBool'] = filter_var($value, FILTER_VALIDATE_BOOLEAN);
                    break;
                case 'date':
                case 'datetime':
                    $cellData['valueDate'] = $value ? Carbon::parse($value) : null;
                    break;
                case 'select':
                case 'multi_select':
                case 'relation':
                    $cellData['valueJson'] = $value;
                    $cellData['valueText'] = is_array($value) ? implode(', ', $value) : (string)$value;
                    break;
                default:
                    $cellData['valueText'] = (string)$value;
                    break;
            }

            SheetRowCells::updateOrCreate(
                ['rowId' => $row->id, 'columnId' => $columnId],
                $cellData
            );
        }

        // Cleanup: remove index for columns that are no longer in the JSON data
        SheetRowCells::where('rowId', $row->id)
            ->whereNotIn('columnId', array_keys($data))
            ->delete();
    }

    /**
     * Delete a row and its cells.
     */
    public function deleteRow(string $rowId)
    {
        return DB::transaction(function () use ($rowId) {
            $row = SheetRows::findOrFail($rowId);
            $row->delete(); // Soft delete
            
            // Cells don't necessarily need soft delete as they are an index
            SheetRowCells::where('rowId', $rowId)->delete();
            
            return true;
        });
    }

    /**
     * Atomically initialize a sheet with columns and initial rows.
     */
    public function initializeSheet(string $paperId, array $initialData)
    {
        return DB::transaction(function () use ($paperId, $initialData) {
            $columns = $initialData['columns'] ?? [];
            $rows = $initialData['rows'] ?? [];

            $columnIdMap = []; // Maps temp frontend IDs to real DB UUIDs

            // 1. Create Columns
            foreach ($columns as $index => $col) {
                $newCol = SheetColumns::create([
                    'paperId' => $paperId,
                    'name' => $col['name'],
                    'type' => $col['type'] ?? 'text',
                    'sortOrder' => $col['sortOrder'] ?? $index,
                    'settings' => $col['settings'] ?? [],
                    'isRequired' => $col['isRequired'] ?? false
                ]);
                $columnIdMap[$col['id']] = $newCol->id;
            }

            // 2. Create Rows & Cells
            foreach ($rows as $rowData) {
                // Map frontend data keys to new column UUIDs
                $mappedData = [];
                $rawRowData = is_array($rowData['data']) ? $rowData['data'] : [];
                
                foreach ($rawRowData as $tempColId => $value) {
                    if (isset($columnIdMap[$tempColId])) {
                        $mappedData[$columnIdMap[$tempColId]] = $value;
                    }
                }

                if (!empty($mappedData)) {
                    $row = SheetRows::create([
                        'paperId' => $paperId,
                        'data' => $mappedData,
                        'version' => 1
                    ]);
                    $this->indexRow($row);
                }
            }

            return true;
        });
    }

    /**
     * Sync Relational DB from UniverJS JSON Snapshot.
     * Strategy: Full Replace (Delete All -> Insert All) for the given paper.
     * This guarantees 1:1 synchronization between logic (DB) and view (JSON).
     */
    public function syncFromUniverJson(string $paperId, $jsonContent)
    {
        return DB::transaction(function () use ($paperId, $jsonContent) {
            // 1. Parse JSON
            $data = is_string($jsonContent) ? json_decode($jsonContent, true) : $jsonContent;
            if (!$data || !isset($data['sheets'])) {
                // Not a generic error, but could mean it's a Doc, not a Sheet. 
                // If so, we just clear the sheet data to be safe? 
                // Or do we assume if it's a doc, we don't use this service?
                // For safety, if no sheets are found, we return true (nothing to sync).
                return true;
            }

            // 2. Get Columns (Ordered) - These define the schema
            // We TRUST the DB columns are correct. If Univer added columns, they won't be synced 
            // until the user adds them properly via column management API (which updates DB).
            $columns = SheetColumns::where('paperId', $paperId)
                ->orderBy('sortOrder', 'asc')
                ->get()
                ->values(); // Reset keys to 0..N

            if ($columns->isEmpty()) {
                // No schema defined, so no relational data can exist.
                return true;
            }

            // 3. Clear Existing Data (Full Flush)
            // Delete cells first (FK sanity, though likely soft deletes)
            SheetRowCells::where('paperId', $paperId)->delete();
            SheetRows::where('paperId', $paperId)->delete();

            // 4. Iterate Sheets (Usually just one 'sheet-01', but generic support)
            foreach ($data['sheets'] as $sheetId => $sheet) {
                if (!isset($sheet['cellData'])) continue;

                // 5. Iterate Rows
                // Univer row keys are indices "0", "1", "10".
                foreach ($sheet['cellData'] as $rowIndex => $rowData) {
                    // $rowData is { "colIndex": { "v": ... }, ... }
                    if (!is_array($rowData)) continue;

                    $mappedData = [];

                    foreach ($rowData as $colIndex => $cell) {
                        // Map Univer Column Index (0, 1, 2) -> DB Column sorted by sortOrder
                        // If Univer has more columns than DB, we ignore the extras (schema enforcement).
                        if (!isset($columns[$colIndex])) continue; 

                        $dbColumn = $columns[$colIndex];
                        $rawValue = $cell['v'] ?? null;

                        // Store in row JSON (using DB Column ID as key)
                        $mappedData[$dbColumn->id] = $rawValue;
                    }

                    // Only create row if it has data
                    if (!empty($mappedData)) {
                        $row = SheetRows::create([
                            'paperId' => $paperId,
                            'data' => $mappedData,
                            'version' => 1 // Reset version on full sync
                        ]);
                        
                        // Re-use indexRow to generate the typed cells
                        $this->indexRow($row);
                    }
                }
            }

            return true;
        });
    }
}
