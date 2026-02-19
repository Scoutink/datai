<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\SheetDataService;
use App\Services\SheetSchemaService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;

class SheetController extends Controller
{
    protected $dataService;
    protected $schemaService;

    public function __construct(SheetDataService $dataService, SheetSchemaService $schemaService)
    {
        $this->dataService = $dataService;
        $this->schemaService = $schemaService;
    }

    // Schema Management
    public function getColumns($paperId)
    {
        // Guard against non-UUID strings (like 'undefined')
        if (!preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $paperId)) {
            return Response::json([]);
        }

        $columns = \App\Models\SheetColumns::where('paperId', $paperId)
            ->orderBy('sortOrder')
            ->get();
        return Response::json($columns);
    }

    public function storeColumn(Request $request, $paperId)
    {
        $request->validate([
            'name' => 'required|string',
            'type' => 'required|string'
        ]);

        $column = $this->schemaService.addColumn($paperId, $request->all());
        return Response::json($column);
    }

    public function updateColumn(Request $request, $id)
    {
        $column = $this->schemaService.updateColumn($id, $request->all());
        return Response::json($column);
    }

    public function deleteColumn($id)
    {
        $this->schemaService.deleteColumn($id);
        return Response::json(['success' => true]);
    }

    // Row Management
    public function getRows(Request $request, $paperId)
    {
        // Guard against non-UUID strings
        if (!preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $paperId)) {
            return Response::json(['data' => []]);
        }

        $pageSize = $request->input('pageSize', 50);
        $rows = \App\Models\SheetRows::where('paperId', $paperId)
            ->orderBy('createdDate', 'desc')
            ->paginate($pageSize);
        
        return Response::json($rows);
    }

    public function storeRow(Request $request, $paperId)
    {
        $row = $this->dataService.saveRow($paperId, $request->input('data', []));
        return Response::json($row);
    }

    public function updateRow(Request $request, $rowId)
    {
        $row = $this->dataService.saveRow(
            $request->input('paperId'),
            $request->input('data', []),
            $rowId,
            $request->input('version')
        );
        return Response::json($row);
    }

    public function deleteRow($rowId)
    {
        $this->dataService.deleteRow($rowId);
        return Response::json(['success' => true]);
    }
}
