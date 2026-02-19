<?php

namespace App\Http\Controllers;

use App\Models\WorkspaceNodes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class WorkspaceController extends Controller
{
    public function roots()
    {
        return response()->json(WorkspaceNodes::where('nodeType', 'workspace_root')->orderBy('title')->get());
    }

    public function tree(string $rootId)
    {
        $nodes = WorkspaceNodes::where('workspaceRootId', $rootId)
            ->orWhere('id', $rootId)
            ->orderBy('sortIndex')
            ->get();

        $grouped = $nodes->groupBy('parentId');
        $root = $nodes->firstWhere('id', $rootId);
        if (!$root) {
            return response()->json(null);
        }

        return response()->json($this->serializeNode($root, $grouped));
    }

    public function createRoot(Request $request)
    {
        $request->validate(['title' => 'required|string|max:255', 'description' => 'nullable|string']);
        $root = WorkspaceNodes::create([
            'nodeType' => 'workspace_root',
            'title' => $request->title,
            'description' => $request->description,
            'workspaceRootId' => null,
            'parentId' => null,
            'sortIndex' => WorkspaceNodes::where('nodeType', 'workspace_root')->count(),
        ]);
        $root->workspaceRootId = $root->id;
        $root->save();

        return response()->json($root);
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

        $sortIndex = WorkspaceNodes::where('parentId', $request->parentId)->count();

        $node = WorkspaceNodes::create([
            'workspaceRootId' => $request->workspaceRootId,
            'parentId' => $request->parentId,
            'nodeType' => $request->nodeType,
            'title' => $request->title,
            'contentKind' => $request->contentKind,
            'contentRef' => $request->contentRef,
            'sortIndex' => $sortIndex,
        ]);

        return response()->json($node);
    }

    public function moveNode(Request $request, string $id)
    {
        $request->validate([
            'parentId' => 'required|uuid',
            'sortIndex' => 'required|integer|min:0',
        ]);

        DB::transaction(function () use ($request, $id) {
            $node = WorkspaceNodes::findOrFail($id);
            $oldParent = $node->parentId;
            $node->parentId = $request->parentId;
            $node->sortIndex = $request->sortIndex;
            $node->save();

            $oldSiblings = WorkspaceNodes::where('parentId', $oldParent)->orderBy('sortIndex')->get();
            foreach ($oldSiblings as $idx => $sibling) {
                if ($sibling->sortIndex !== $idx) {
                    $sibling->sortIndex = $idx;
                    $sibling->save();
                }
            }
            $newSiblings = WorkspaceNodes::where('parentId', $request->parentId)->orderBy('sortIndex')->get();
            foreach ($newSiblings as $idx => $sibling) {
                if ($sibling->sortIndex !== $idx) {
                    $sibling->sortIndex = $idx;
                    $sibling->save();
                }
            }
        });

        return response()->json(['success' => true]);
    }

    public function renameNode(Request $request, string $id)
    {
        $request->validate(['title' => 'required|string|max:255']);
        $node = WorkspaceNodes::findOrFail($id);
        $node->title = $request->title;
        $node->save();
        return response()->json($node);
    }

    public function deleteNode(string $id)
    {
        $node = WorkspaceNodes::findOrFail($id);
        $ids = $this->collectDescendantIds($id);
        $ids[] = $id;
        WorkspaceNodes::whereIn('id', $ids)->delete();
        return response()->json(['deleted' => $ids]);
    }

    public function deleteContentCascade(Request $request)
    {
        $request->validate(['contentKind' => 'required|in:document,paper', 'contentRef' => 'required|uuid']);
        $nodes = WorkspaceNodes::where('contentKind', $request->contentKind)->where('contentRef', $request->contentRef)->get();
        $deleted = [];
        foreach ($nodes as $node) {
            $ids = $this->collectDescendantIds($node->id);
            $ids[] = $node->id;
            $deleted = array_merge($deleted, $ids);
        }
        WorkspaceNodes::whereIn('id', array_unique($deleted))->delete();
        return response()->json(['deleted' => array_values(array_unique($deleted))]);
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
        $exists = DB::table('workspaceNodeFavorites')->where('userId', Auth::id())->where('nodeId', $id)->exists();
        if ($exists) {
            DB::table('workspaceNodeFavorites')->where('userId', Auth::id())->where('nodeId', $id)->delete();
        } else {
            DB::table('workspaceNodeFavorites')->insert([
                'id' => (string) \Ramsey\Uuid\Uuid::uuid4(),
                'nodeId' => $id,
                'userId' => Auth::id(),
                'createdDate' => now(),
            ]);
        }
        return response()->json(['favorite' => !$exists]);
    }

    public function markRecent(string $id)
    {
        $exists = DB::table('workspaceNodeRecents')->where('userId', Auth::id())->where('nodeId', $id)->exists();
        if ($exists) {
            DB::table('workspaceNodeRecents')->where('userId', Auth::id())->where('nodeId', $id)->update(['openedAt' => now()]);
        } else {
            DB::table('workspaceNodeRecents')->insert([
                'id' => (string) \Ramsey\Uuid\Uuid::uuid4(),
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
        $result = [];
        $children = WorkspaceNodes::where('parentId', $nodeId)->pluck('id')->all();
        foreach ($children as $childId) {
            $result[] = $childId;
            $result = array_merge($result, $this->collectDescendantIds($childId));
        }
        return $result;
    }
}
