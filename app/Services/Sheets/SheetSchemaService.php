<?php

namespace App\Services;

use App\Models\SheetColumns;
use App\Models\Papers;
use Illuminate\Support\Facades\DB;

class SheetSchemaService
{
    /**
     * Add a column to a sheet.
     */
    public function addColumn(string $paperId, array $payload)
    {
        return DB::transaction(function () use ($paperId, $payload) {
            $paper = Papers::findOrFail($paperId);
            
            // Check if sheet is locked (not implemented yet, but keeping placeholder)
            if ($paper->isLocked) {
                throw new \Exception("This sheet is locked and its schema cannot be modified.");
            }

            return SheetColumns::create([
                'paperId' => $paperId,
                'name' => $payload['name'],
                'type' => $payload['type'],
                'sortOrder' => $payload['sortOrder'] ?? 0,
                'settings' => $payload['settings'] ?? null,
                'isRequired' => $payload['isRequired'] ?? false
            ]);
        });
    }

    /**
     * Update column metadata.
     */
    public function updateColumn(string $columnId, array $payload)
    {
        $column = SheetColumns::findOrFail($columnId);
        $column->update($payload);
        return $column;
    }

    /**
     * Delete a column.
     */
    public function deleteColumn(string $columnId)
    {
        return DB::transaction(function () use ($columnId) {
            $column = SheetColumns::findOrFail($columnId);
            $column->delete();

            // Cleanup index
            \App\Models\SheetRowCells::where('columnId', $columnId)->delete();
            
            return true;
        });
    }
}
