<?php

namespace App\Http\Controllers;

use App\Repositories\Contracts\DocumentTokenRepositoryInterface;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Ramsey\Uuid\Uuid;

class WorkspaceSandboxController extends Controller
{
    public function __construct(private DocumentTokenRepositoryInterface $documentTokenRepository)
    {
    }
    public function index()
    {
        return view('workspace-sandbox');
    }

    public function roots(): JsonResponse
    {
        return response()->json(
            DB::table('workspaceNodes')
                ->where('isDeleted', 0)
                ->whereNull('deleted_at')
                ->where('nodeType', 'workspace_root')
                ->whereNull('parentId')
                ->orderBy('title')
                ->get()
        );
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

        return response()->json($this->serializeNode((array) $root, $nodes->groupBy('parentId')));
    }

    public function listDocuments(): JsonResponse
    {
        $docs = DB::table('documents')
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->orderBy('name')
            ->limit(200)
            ->get(['id', 'name', 'url', 'description', 'createdDate']);

        return response()->json($docs);
    }

    public function listPapers(): JsonResponse
    {
        $papers = DB::table('papers')
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->orderBy('name')
            ->limit(200)
            ->get(['id', 'name', 'contentType', 'contentText', 'createdDate']);

        return response()->json($papers);
    }

    public function contentByNode(string $nodeId): JsonResponse
    {
        $node = DB::table('workspaceNodes')
            ->where('id', $nodeId)
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->first();

        if (!$node) {
            return response()->json(['message' => 'Node not found.'], 404);
        }

        if ($node->nodeType === 'document_link' && $node->contentRef) {
            $doc = DB::table('documents')
                ->where('id', $node->contentRef)
                ->where('isDeleted', 0)
                ->whereNull('deleted_at')
                ->first(['id', 'name', 'url', 'description', 'createdDate']);

            if (!$doc) {
                return response()->json(['type' => 'document', 'missing' => true]);
            }

            $relativeUrl = ltrim((string)($doc->url ?? ''), '/');
            $directUrl = $relativeUrl ? url('/' . $relativeUrl) : null;
            $extension = strtolower((string) pathinfo((string) ($doc->url ?? ''), PATHINFO_EXTENSION));
            $isPdf = $extension === 'pdf';
            $token = $this->ensureDocumentToken($doc->id);
            $officeViewerUrl = url('/api/document/' . $doc->id . '/officeviewer?token=' . urlencode($token) . '&isVersion=false');
            $officeEmbedUrl = 'https://view.officeapps.live.com/op/embed.aspx?src=' . urlencode($officeViewerUrl);

            return response()->json([
                'type' => 'document',
                'title' => $doc->name,
                'description' => $doc->description,
                'createdDate' => $doc->createdDate,
                'url' => $doc->url,
                'directUrl' => $directUrl,
                'officeViewerUrl' => $officeViewerUrl,
                'officeEmbedUrl' => $officeEmbedUrl,
                'downloadUrl' => url('/api/document/' . $doc->id . '/download/0'),
                'inlineViewerUrl' => url('/workspace-sandbox/content/node/' . $node->id . '/document-inline'),
                'diagnosticsUrl' => url('/workspace-sandbox/content/node/' . $node->id . '/document-diagnostics'),
                'fileExtension' => $extension,
                'isPdf' => $isPdf,
                'viewerMode' => $isPdf ? 'pdf-inline' : 'office-embed',
            ]);
        }

        if ($node->nodeType === 'paper_link' && $node->contentRef) {
            $paper = DB::table('papers')
                ->where('id', $node->contentRef)
                ->where('isDeleted', 0)
                ->whereNull('deleted_at')
                ->first(['id', 'name', 'description', 'contentText', 'contentType', 'createdDate']);

            if (!$paper) {
                return response()->json(['type' => 'paper', 'missing' => true]);
            }

            $paperHtml = DB::table('papers')->where('id', $paper->id)->value('contentHtmlSanitized');
            $paperJson = DB::table('papers')->where('id', $paper->id)->value('contentJson');

            return response()->json([
                'type' => 'paper',
                'title' => $paper->name,
                'description' => $paper->description,
                'contentType' => $paper->contentType,
                'createdDate' => $paper->createdDate,
                'html' => $paperHtml,
                'text' => mb_substr((string)($paper->contentText ?? ''), 0, 5000),
                'appViewUrl' => url('/papers/' . $paper->id . '?tab=content&mode=view'),
                'appEmbedUrl' => url('/papers/' . $paper->id . '?tab=content&mode=view'),
                'paperUniverUrl' => url('/workspace-sandbox/content/node/' . $node->id . '/paper-univer'),
                'hasContentJson' => !empty($paperJson),
                'contentJsonLength' => $paperJson ? strlen((string) $paperJson) : 0,
            ]);
        }

        return response()->json(['type' => 'node', 'title' => $node->title, 'nodeType' => $node->nodeType]);
    }


    public function documentInlineByNode(string $nodeId)
    {
        $node = $this->activeNode($nodeId);
        if (!$node || $node->nodeType !== 'document_link' || empty($node->contentRef)) {
            return response()->json(['message' => 'Document node not found'], 404);
        }

        $doc = DB::table('documents')
            ->where('id', $node->contentRef)
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->first(['id', 'name', 'url', 'location']);

        if (!$doc || empty($doc->url)) {
            return response()->json(['message' => 'Document file path missing'], 404);
        }

        $disk = $doc->location ?: 'local';
        if (!Storage::disk($disk)->exists($doc->url)) {
            return response()->json(['message' => 'File not found in storage'], 404);
        }

        $contents = Storage::disk($disk)->get($doc->url);
        $mime = Storage::disk($disk)->mimeType($doc->url) ?: 'application/octet-stream';
        $ext = pathinfo((string)$doc->url, PATHINFO_EXTENSION);
        $filename = trim(($doc->name ?: 'document') . ($ext ? ('.' . $ext) : ''));

        return response($contents)
            ->header('Content-Type', $mime)
            ->header('Content-Length', (string) strlen($contents))
            ->header('Content-Disposition', 'inline; filename="' . str_replace('"', '', $filename) . '"');
    }

    public function diagnoseDocumentByNode(string $nodeId): JsonResponse
    {
        $node = $this->activeNode($nodeId);
        if (!$node || $node->nodeType !== 'document_link' || empty($node->contentRef)) {
            return response()->json(['message' => 'Document node not found'], 404);
        }

        $token = $this->ensureDocumentToken($node->contentRef);
        $officeViewerUrl = url('/api/document/' . $node->contentRef . '/officeviewer?token=' . urlencode($token) . '&isVersion=false');

        try {
            $response = \Illuminate\Support\Facades\Http::timeout(20)->withOptions(['verify' => false])->get($officeViewerUrl);
            $contentType = $response->header('content-type');
            $sample = '';
            if (str_contains((string)$contentType, 'json') || str_contains((string)$contentType, 'text')) {
                $sample = mb_substr((string)$response->body(), 0, 500);
            }

            return response()->json([
                'ok' => $response->successful(),
                'status' => $response->status(),
                'contentType' => $contentType,
                'sourceUrl' => $officeViewerUrl,
                'sample' => $sample,
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'ok' => false,
                'status' => 0,
                'sourceUrl' => $officeViewerUrl,
                'sample' => $e->getMessage(),
            ]);
        }
    }

    public function createRoot(Request $request): JsonResponse
    {
        $request->validate(['title' => 'required|string|max:255', 'description' => 'nullable|string']);

        $actorId = $this->actorId();
        if (!$actorId) {
            return response()->json(['message' => 'No user available for createdBy.'], 422);
        }

        $id = Uuid::uuid4()->toString();
        $now = now();

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

        $parent = $this->activeNode($request->parentId);
        if (!$parent) {
            return response()->json(['message' => 'Parent not found.'], 404);
        }
        if (!in_array($parent->nodeType, ['workspace_root', 'folder'], true)) {
            return response()->json(['message' => 'Parent must be workspace_root or folder.'], 422);
        }
        if ($parent->workspaceRootId !== $request->workspaceRootId) {
            return response()->json(['message' => 'Cross workspace add is not allowed.'], 422);
        }

        if (in_array($request->nodeType, ['document_link', 'paper_link'], true) && !$request->contentRef) {
            return response()->json(['message' => 'contentRef is required for linked nodes.'], 422);
        }

        $actorId = $this->actorId();
        if (!$actorId) {
            return response()->json(['message' => 'No user available for createdBy.'], 422);
        }

        $id = Uuid::uuid4()->toString();
        $now = now();
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
            'contentKind' => $request->contentKind,
            'contentRef' => $request->contentRef,
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
        $node = $this->activeNode($id);
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
        $request->validate(['parentId' => 'required|uuid', 'sortIndex' => 'required|integer|min:0']);

        $node = $this->activeNode($id);
        $parent = $this->activeNode($request->parentId);

        if (!$node || !$parent) {
            return response()->json(['message' => 'Node/parent not found.'], 404);
        }
        if ($node->nodeType === 'workspace_root') {
            return response()->json(['message' => 'Cannot move workspace root.'], 422);
        }
        if (!in_array($parent->nodeType, ['workspace_root', 'folder'], true)) {
            return response()->json(['message' => 'Destination parent must be workspace_root or folder.'], 422);
        }
        if ($node->workspaceRootId !== $parent->workspaceRootId) {
            return response()->json(['message' => 'Cross workspace move not allowed.'], 422);
        }
        if ($parent->id === $node->id || in_array($parent->id, $this->collectDescendantIds($node->id), true)) {
            return response()->json(['message' => 'Invalid move (cycle).'], 422);
        }

        DB::table('workspaceNodes')->where('id', $id)->update([
            'parentId' => $request->parentId,
            'sortIndex' => $request->sortIndex,
            'modifiedBy' => $this->actorId(),
            'modifiedDate' => now(),
        ]);

        $this->reindex($node->workspaceRootId, $node->parentId);
        $this->reindex($node->workspaceRootId, $request->parentId);

        return response()->json(['success' => true]);
    }

    public function deleteNode(string $id): JsonResponse
    {
        $node = $this->activeNode($id);
        if (!$node) {
            return response()->json(['message' => 'Node not found'], 404);
        }
        if ($node->nodeType === 'workspace_root') {
            return response()->json(['message' => 'Cannot delete workspace root here.'], 422);
        }

        $ids = array_values(array_unique(array_merge([$id], $this->collectDescendantIds($id))));
        DB::table('workspaceNodes')->whereIn('id', $ids)->update([
            'isDeleted' => 1,
            'deletedBy' => $this->actorId(),
            'deleted_at' => now(),
            'modifiedDate' => now(),
        ]);

        $this->reindex($node->workspaceRootId, $node->parentId);

        return response()->json(['deleted' => $ids]);
    }



    public function paperUniverByNode(string $nodeId)
    {
        $node = $this->activeNode($nodeId);
        if (!$node || $node->nodeType !== 'paper_link' || empty($node->contentRef)) {
            abort(404, 'Paper node not found');
        }

        $paper = DB::table('papers')
            ->where('id', $node->contentRef)
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->first(['id', 'name']);

        if (!$paper) {
            abort(404, 'Paper not found');
        }

        return view('workspace-sandbox-paper-univer', [
            'paperId' => $paper->id,
            'paperName' => $paper->name,
            'manageUrl' => url('/papers/manage/' . $paper->id . '?workspaceSandbox=1'),
        ]);
    }

    private function reindex(string $workspaceRootId, ?string $parentId): void
    {
        $siblings = DB::table('workspaceNodes')
            ->where('workspaceRootId', $workspaceRootId)
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
            ->where('parentId', $parentId)
            ->orderBy('sortIndex')
            ->orderBy('createdDate')
            ->get(['id']);

        foreach ($siblings as $idx => $sibling) {
            DB::table('workspaceNodes')->where('id', $sibling->id)->update(['sortIndex' => $idx]);
        }
    }

    private function collectDescendantIds(string $id): array
    {
        $children = DB::table('workspaceNodes')
            ->where('parentId', $id)
            ->where('isDeleted', 0)
            ->whereNull('deleted_at')
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
        $node['children'] = collect($grouped->get($node['id'], []))
            ->sortBy('sortIndex')
            ->map(fn ($child) => $this->serializeNode((array) $child, $grouped))
            ->values()
            ->all();

        return $node;
    }


    private function ensureDocumentToken(string $documentId): string
    {
        return $this->documentTokenRepository->getDocumentToken($documentId);
    }

    private function activeNode(string $id): ?object
    {
        return DB::table('workspaceNodes')->where('id', $id)->where('isDeleted', 0)->whereNull('deleted_at')->first();
    }

    private function actorId(): ?string
    {
        return Auth::id() ?: DB::table('users')->value('id');
    }
}
