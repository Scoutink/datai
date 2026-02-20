<?php

namespace App\Http\Controllers;

use App\Models\WorkspaceNodes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;

class WorkspaceController extends Controller
{
    public function roots()
    {
        return response()->json(
            WorkspaceNodes::where('nodeType', 'workspace_root')
                ->whereNull('parentId')
                ->orderBy('title')
                ->get()
        );
    }

    public function createRoot(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
        ]);

        $root = DB::transaction(function () use ($request) {
            $root = WorkspaceNodes::create([
                'nodeType' => 'workspace_root',
                'title' => $request->string('title')->toString(),
                'description' => $request->input('description'),
                'workspaceRootId' => null,
                'parentId' => null,
                'sortIndex' => WorkspaceNodes::where('nodeType', 'workspace_root')->count(),
            ]);

            $root->workspaceRootId = $root->id;
            $root->save();

            return $root;
        });

        return response()->json($root, 201);
    }

    public function tree(string $id)
    {
        $root = WorkspaceNodes::where('id', $id)->where('nodeType', 'workspace_root')->first();
        if (!$root) {
            return response()->json(['message' => 'Workspace root not found.'], 404);
        }

        $nodes = WorkspaceNodes::where('workspaceRootId', $id)
            ->orderBy('sortIndex')
            ->get();

        $grouped = $nodes->groupBy('parentId');

        return response()->json($this->serializeNode($root, $grouped));
    }

    public function addNode(Request $request)
    {
        $request->validate([
            'workspaceRootId' => 'required|uuid',
            'parentId' => 'required|uuid',
            'nodeType' => 'required|in:folder,document_link,paper_link',
            'title' => 'required|string|max:255',
            'contentKind' => 'nullable|in:document,paper',
            'contentRef' => 'nullable|uuid',
        ]);

        $root = WorkspaceNodes::where('id', $request->workspaceRootId)
            ->where('nodeType', 'workspace_root')
            ->first();
        if (!$root) {
            return response()->json(['message' => 'Workspace root not found.'], 404);
        }

        $parent = WorkspaceNodes::find($request->parentId);
        if (!$parent || $parent->workspaceRootId !== $request->workspaceRootId) {
            return response()->json(['message' => 'Invalid parent node.'], 422);
        }

        if (!in_array($parent->nodeType, ['workspace_root', 'folder'], true)) {
            return response()->json(['message' => 'Children can only be added under workspace root or folder.'], 422);
        }

        $node = WorkspaceNodes::create([
            'workspaceRootId' => $request->workspaceRootId,
            'parentId' => $parent->id,
            'nodeType' => $request->nodeType,
            'title' => $request->title,
            'contentKind' => $request->contentKind,
            'contentRef' => $request->contentRef,
            'sortIndex' => WorkspaceNodes::where('workspaceRootId', $request->workspaceRootId)
                ->where('parentId', $parent->id)
                ->count(),
        ]);

        return response()->json($node, 201);
    }

    public function renameNode(Request $request, string $id)
    {
        $request->validate(['title' => 'required|string|max:255']);
        $node = WorkspaceNodes::find($id);
        if (!$node) {
            return response()->json(['message' => 'Node not found.'], 404);
        }

        if ($node->nodeType === 'workspace_root') {
            return response()->json(['message' => 'Rename workspace root via workspace settings flow only.'], 422);
        }

        $node->title = $request->title;
        $node->save();

        return response()->json($node);
    }

    public function moveNode(Request $request, string $id)
    {
        $request->validate([
            'parentId' => 'required|uuid',
            'sortIndex' => 'required|integer|min:0',
        ]);

        $node = WorkspaceNodes::find($id);
        if (!$node) {
            return response()->json(['message' => 'Node not found.'], 404);
        }

        if ($node->nodeType === 'workspace_root') {
            return response()->json(['message' => 'Workspace root cannot be moved.'], 422);
        }

        $targetParent = WorkspaceNodes::find($request->parentId);
        if (!$targetParent) {
            return response()->json(['message' => 'Destination node not found.'], 404);
        }

        if (!in_array($targetParent->nodeType, ['workspace_root', 'folder'], true)) {
            return response()->json(['message' => 'Destination must be workspace root or folder.'], 422);
        }

        if ($targetParent->workspaceRootId !== $node->workspaceRootId) {
            return response()->json(['message' => 'Cross-workspace moves are not allowed.'], 422);
        }

        if ($targetParent->id === $node->id || $this->isDescendant($targetParent->id, $node->id)) {
            return response()->json(['message' => 'Invalid move: cycle detected.'], 422);
        }

        DB::transaction(function () use ($node, $targetParent, $request) {
            $oldParent = $node->parentId;

            $node->parentId = $targetParent->id;
            $node->sortIndex = $request->sortIndex;
            $node->save();

            $this->reindexSiblings($node->workspaceRootId, $oldParent);
            $this->reindexSiblings($node->workspaceRootId, $targetParent->id);
        });

        return response()->json(['success' => true]);
    }

    public function deleteNode(string $id)
    {
        $node = WorkspaceNodes::find($id);
        if (!$node) {
            return response()->json(['message' => 'Node not found.'], 404);
        }

        if ($node->nodeType === 'workspace_root') {
            return response()->json(['message' => 'Workspace root delete is not allowed from structural delete endpoint.'], 422);
        }

        $descendantIds = $this->collectDescendantIds($id);
        $allIds = array_values(array_unique(array_merge([$id], $descendantIds)));

        DB::transaction(function () use ($node, $allIds) {
            WorkspaceNodes::whereIn('id', $allIds)->delete();
            $this->reindexSiblings($node->workspaceRootId, $node->parentId);
        });

        return response()->json(['deleted' => $allIds]);
    }

    public function deleteContentCascade(Request $request)
    {
        $request->validate([
            'contentKind' => 'required|in:document,paper',
            'contentRef' => 'required|uuid',
        ]);

        $nodes = WorkspaceNodes::where('contentKind', $request->contentKind)
            ->where('contentRef', $request->contentRef)
            ->get();

        $idsToDelete = [];
        foreach ($nodes as $node) {
            $idsToDelete[] = $node->id;
            $idsToDelete = array_merge($idsToDelete, $this->collectDescendantIds($node->id));
        }

        $idsToDelete = array_values(array_unique($idsToDelete));

        if (count($idsToDelete) > 0) {
            WorkspaceNodes::whereIn('id', $idsToDelete)->delete();
        }

        return response()->json(['deleted' => $idsToDelete]);
    }

    public function favorites()
    {
        $rows = DB::table('workspaceNodeFavorites as f')
            ->join('workspaceNodes as n', 'n.id', '=', 'f.nodeId')
            ->where('f.userId', Auth::id())
            ->select('n.*')
            ->get();

        return response()->json($rows);
    }

    public function toggleFavorite(string $id)
    {
        $node = WorkspaceNodes::find($id);
        if (!$node) {
            return response()->json(['message' => 'Node not found.'], 404);
        }

        $exists = DB::table('workspaceNodeFavorites')
            ->where('userId', Auth::id())
            ->where('nodeId', $id)
            ->exists();

        if ($exists) {
            DB::table('workspaceNodeFavorites')
                ->where('userId', Auth::id())
                ->where('nodeId', $id)
                ->delete();
        } else {
            DB::table('workspaceNodeFavorites')->insert([
                'id' => Uuid::uuid4()->toString(),
                'nodeId' => $id,
                'userId' => Auth::id(),
                'createdDate' => now(),
            ]);
        }

        return response()->json(['favorite' => !$exists]);
    }

    public function markRecent(string $id)
    {
        $node = WorkspaceNodes::find($id);
        if (!$node) {
            return response()->json(['message' => 'Node not found.'], 404);
        }

        $existing = DB::table('workspaceNodeRecents')
            ->where('userId', Auth::id())
            ->where('nodeId', $id)
            ->first();

        if ($existing) {
            DB::table('workspaceNodeRecents')
                ->where('id', $existing->id)
                ->update(['openedAt' => now()]);
        } else {
            DB::table('workspaceNodeRecents')->insert([
                'id' => Uuid::uuid4()->toString(),
                'nodeId' => $id,
                'userId' => Auth::id(),
                'openedAt' => now(),
            ]);
        }

        return response()->json(['success' => true]);
    }

    public function recents()
    {
        $rows = DB::table('workspaceNodeRecents as r')
            ->join('workspaceNodes as n', 'n.id', '=', 'r.nodeId')
            ->where('r.userId', Auth::id())
            ->orderByDesc('r.openedAt')
            ->limit(10)
            ->select('n.*', 'r.openedAt')
            ->get();

        return response()->json($rows);
    }

    private function isDescendant(string $candidateChildId, string $ancestorId): bool
    {
        $descendants = $this->collectDescendantIds($ancestorId);
        return in_array($candidateChildId, $descendants, true);
    }

    private function reindexSiblings(string $workspaceRootId, ?string $parentId): void
    {
        $siblings = WorkspaceNodes::where('workspaceRootId', $workspaceRootId)
            ->where('parentId', $parentId)
            ->orderBy('sortIndex')
            ->orderBy('createdDate')
            ->get();

        foreach ($siblings as $index => $sibling) {
            if ((int)$sibling->sortIndex !== $index) {
                $sibling->sortIndex = $index;
                $sibling->save();
            }
        }
    }

    private function serializeNode(WorkspaceNodes $node, $grouped): array
    {
        $children = collect($grouped->get($node->id, []))
            ->sortBy('sortIndex')
            ->map(fn ($child) => $this->serializeNode($child, $grouped))
            ->values()
            ->all();

        return [
            'id' => $node->id,
            'nodeType' => $node->nodeType,
            'title' => $node->title,
            'description' => $node->description,
            'workspaceRootId' => $node->workspaceRootId,
            'parentId' => $node->parentId,
            'sortIndex' => $node->sortIndex,
            'contentKind' => $node->contentKind,
            'contentRef' => $node->contentRef,
            'children' => $children,
        ];
    }

    private function collectDescendantIds(string $nodeId): array
    {
        $children = WorkspaceNodes::where('parentId', $nodeId)->pluck('id')->all();
        if (count($children) === 0) {
            return [];
        }

        $result = [];
        foreach ($children as $childId) {
            $result[] = $childId;
            $result = array_merge($result, $this->collectDescendantIds($childId));
        }

        return $result;
    }
}
