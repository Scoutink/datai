<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;

class WorkspaceSandboxController extends Controller
{
    public function index()
    {
        return view('workspace-sandbox');
    }

    public function roots(): JsonResponse
    {
        $roots = DB::table('workspaceNodes')
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->where('nodeType', 'workspace_root')
            ->whereNull('parentId')
            ->orderBy('title')
            ->get();

        return response()->json($roots);
    }

    public function tree(string $id): JsonResponse
    {
        $nodes = DB::table('workspaceNodes')
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->where('workspaceRootId', $id)
            ->orderBy('sortIndex')
            ->get();

        $root = $nodes->firstWhere('id', $id);
        if (!$root) {
            return response()->json(['message' => 'Workspace not found'], 404);
        }

        $grouped = $nodes->groupBy('parentId');
        return response()->json($this->serializeNode((array) $root, $grouped));
    }

    public function createRoot(Request $request): JsonResponse
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
        ]);

        $actorId = $this->actorId();
        if (!$actorId) {
            return response()->json(['message' => 'No user available to attribute createdBy.'], 422);
        }

        $now = now();
        $id = Uuid::uuid4()->toString();

        DB::table('workspaceNodes')->insert([
            'id' => $id,
            'nodeType' => 'workspace_root',
            'title' => $request->title,
            'description' => $request->input('description'),
            'workspaceRootId' => $id,
            'parentId' => null,
            'sortIndex' => DB::table('workspaceNodes')->where('nodeType', 'workspace_root')->where('isDeleted', 0)->count(),
            'contentKind' => null,
            'contentRef' => null,
            'createdBy' => $actorId,
            'modifiedBy' => $actorId,
            'deletedBy' => null,
            'isDeleted' => 0,
            'createdDate' => $now,
            'modifiedDate' => $now,
            'deleted_at' => null,
        ]);

        return response()->json(['id' => $id], 201);
    }

    public function addNode(Request $request): JsonResponse
    {
        $request->validate([
            'workspaceRootId' => 'required|uuid',
            'parentId' => 'required|uuid',
            'nodeType' => 'required|in:folder,document_link,paper_link',
            'title' => 'required|string|max:255',
            'contentKind' => 'nullable|in:document,paper',
            'contentRef' => 'nullable|uuid',
        ]);

        $actorId = $this->actorId();
        if (!$actorId) {
            return response()->json(['message' => 'No user available to attribute createdBy.'], 422);
        }

        $parent = DB::table('workspaceNodes')
            ->where('id', $request->parentId)
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->first();

        if (!$parent) {
            return response()->json(['message' => 'Parent not found.'], 404);
        }

        if (!in_array($parent->nodeType, ['workspace_root', 'folder'], true)) {
            return response()->json(['message' => 'Parent must be workspace_root or folder.'], 422);
        }

        if ($parent->workspaceRootId !== $request->workspaceRootId) {
            return response()->json(['message' => 'Cross workspace add is not allowed.'], 422);
        }

        $now = now();
        $id = Uuid::uuid4()->toString();

        DB::table('workspaceNodes')->insert([
            'id' => $id,
            'nodeType' => $request->nodeType,
            'title' => $request->title,
            'description' => null,
            'workspaceRootId' => $request->workspaceRootId,
            'parentId' => $request->parentId,
            'sortIndex' => DB::table('workspaceNodes')
                ->where('workspaceRootId', $request->workspaceRootId)
                ->where('parentId', $request->parentId)
                ->where('isDeleted', 0)
                ->count(),
            'contentKind' => $request->input('contentKind'),
            'contentRef' => $request->input('contentRef'),
            'createdBy' => $actorId,
            'modifiedBy' => $actorId,
            'deletedBy' => null,
            'isDeleted' => 0,
            'createdDate' => $now,
            'modifiedDate' => $now,
            'deleted_at' => null,
        ]);

        return response()->json(['id' => $id], 201);
    }

    public function renameNode(Request $request, string $id): JsonResponse
    {
        $request->validate(['title' => 'required|string|max:255']);
        $node = DB::table('workspaceNodes')->where('id', $id)->where('isDeleted', 0)->first();

        if (!$node) {
            return response()->json(['message' => 'Node not found.'], 404);
        }

        DB::table('workspaceNodes')->where('id', $id)->update([
            'title' => $request->title,
            'modifiedBy' => $this->actorId(),
            'modifiedDate' => now(),
        ]);

        return response()->json(['success' => true]);
    }

    public function moveNode(Request $request, string $id): JsonResponse
    {
        $request->validate([
            'parentId' => 'required|uuid',
            'sortIndex' => 'required|integer|min:0',
        ]);

        $node = DB::table('workspaceNodes')->where('id', $id)->where('isDeleted', 0)->first();
        $parent = DB::table('workspaceNodes')->where('id', $request->parentId)->where('isDeleted', 0)->first();

        if (!$node || !$parent) {
            return response()->json(['message' => 'Node/parent not found.'], 404);
        }

        if ($node->nodeType === 'workspace_root') {
            return response()->json(['message' => 'Cannot move workspace root.'], 422);
        }

        if ($node->workspaceRootId !== $parent->workspaceRootId) {
            return response()->json(['message' => 'Cross workspace move not allowed.'], 422);
        }

        DB::table('workspaceNodes')->where('id', $id)->update([
            'parentId' => $request->parentId,
            'sortIndex' => $request->sortIndex,
            'modifiedBy' => $this->actorId(),
            'modifiedDate' => now(),
        ]);

        return response()->json(['success' => true]);
    }

    public function deleteNode(string $id): JsonResponse
    {
        $node = DB::table('workspaceNodes')->where('id', $id)->where('isDeleted', 0)->first();
        if (!$node) {
            return response()->json(['message' => 'Node not found'], 404);
        }

        if ($node->nodeType === 'workspace_root') {
            return response()->json(['message' => 'Cannot delete workspace root from sandbox node delete.'], 422);
        }

        $ids = array_values(array_unique(array_merge([$id], $this->collectDescendantIds($id))));

        DB::table('workspaceNodes')->whereIn('id', $ids)->update([
            'isDeleted' => 1,
            'deletedBy' => $this->actorId(),
            'deleted_at' => now(),
            'modifiedDate' => now(),
        ]);

        return response()->json(['deleted' => $ids]);
    }

    private function collectDescendantIds(string $id): array
    {
        $children = DB::table('workspaceNodes')
            ->where('parentId', $id)
            ->where('isDeleted', 0)
            ->pluck('id')
            ->all();

        $result = [];
        foreach ($children as $childId) {
            $result[] = $childId;
            $result = array_merge($result, $this->collectDescendantIds($childId));
        }

        return $result;
    }

    private function serializeNode(array $node, $grouped): array
    {
        $children = collect($grouped->get($node['id'], []))
            ->sortBy('sortIndex')
            ->map(fn ($child) => $this->serializeNode((array) $child, $grouped))
            ->values()
            ->all();

        $node['children'] = $children;
        return $node;
    }

    private function actorId(): ?string
    {
        return Auth::id() ?: DB::table('users')->value('id');
    }
}
