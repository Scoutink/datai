<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Contracts\PaperRepositoryInterface;
use App\Repositories\Contracts\PaperPermissionRepositoryInterface;
use App\Repositories\Contracts\PaperVersionsRepositoryInterface;
use App\Repositories\Contracts\PaperCommentRepositoryInterface;
use App\Repositories\Contracts\PaperAuditTrailRepositoryInterface;
use App\Repositories\Contracts\PaperShareableLinkRepositoryInterface;
use App\Services\Papers\PaperContentService;
use App\Services\Papers\PaperAssetService;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use App\Models\PaperOperationEnum;
use App\Models\PaperAuditTrails;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class PaperController extends Controller
{
    protected $paperRepository;
    protected $permissionRepository;
    protected $versionRepository;
    protected $commentRepository;
    protected $auditRepository;
    protected $shareLinkRepository;
    protected $contentService;
    protected $assetService;

    public function __construct(
        PaperRepositoryInterface $paperRepository,
        PaperPermissionRepositoryInterface $permissionRepository,
        PaperVersionsRepositoryInterface $versionRepository,
        PaperCommentRepositoryInterface $commentRepository,
        PaperAuditTrailRepositoryInterface $auditRepository,
        PaperShareableLinkRepositoryInterface $shareLinkRepository,
        PaperContentService $contentService,
        PaperAssetService $assetService
    ) {
        $this->paperRepository = $paperRepository;
        $this->permissionRepository = $permissionRepository;
        $this->versionRepository = $versionRepository;
        $this->commentRepository = $commentRepository;
        $this->auditRepository = $auditRepository;
        $this->shareLinkRepository = $shareLinkRepository;
        $this->contentService = $contentService;
        $this->assetService = $assetService;
    }

    /**
     * List all papers (All Papers view)
     */
    public function getPapers(Request $request)
    {
        $queryString = (object) $request->all();
        $count = $this->paperRepository->getPapersCount($queryString);
        $data = $this->paperRepository->getPapers($queryString);

        return response()->json($data)
            ->withHeaders([
                'totalCount' => $count,
                'pageSize' => $queryString->pageSize ?? 10,
                'skip' => $queryString->skip ?? 0
            ]);
    }

    /**
     * List assigned papers (My Papers view)
     */
    public function getAssignedPapers(Request $request)
    {
        $queryString = (object) $request->all();
        $count = $this->paperRepository->assignedPapersCount($queryString);
        $data = $this->paperRepository->assignedPapers($queryString);

        return response()->json($data)
            ->withHeaders([
                'totalCount' => $count,
                'pageSize' => $queryString->pageSize ?? 10,
                'skip' => $queryString->skip ?? 0
            ]);
    }

    public function getPaper($id)
    {
        return response()->json($this->paperRepository->getPaperById($id));
    }

    public function savePaper(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'categoryId' => 'required',
            'contentJson' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // Process Content
        $json = $request->contentJson;
        $html = $this->contentService->jsonToHtml($json);
        $text = $this->contentService->extractPlainText($json);
        $wc = $this->contentService->calculateWordCount($text);
        $rt = $this->contentService->calculateReadingTime($wc);

        $request->merge([
            'contentHtmlSanitized' => $html,
            'contentText' => $text,
            'wordCount' => $wc,
            'readingTimeMinutes' => $rt
        ]);

        return response()->json($this->paperRepository->savePaper($request));
    }

    public function updatePaper(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'categoryId' => 'required',
            'contentJson' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // Process Content
        $json = $request->contentJson;
        $html = $this->contentService->jsonToHtml($json);
        $text = $this->contentService->extractPlainText($json);
        $wc = $this->contentService->calculateWordCount($text);
        $rt = $this->contentService->calculateReadingTime($wc);

        $request->merge([
            'contentHtmlSanitized' => $html,
            'contentText' => $text,
            'wordCount' => $wc,
            'readingTimeMinutes' => $rt
        ]);

        return response()->json($this->paperRepository->updatePaper($request, $id));
    }

    public function deletePaper($id)
    {
        $this->paperRepository->archivePaper($id);
        return response()->json(['success' => true]);
    }

    /**
     * History Actions
     */
    public function getVersions($paperId)
    {
        return response()->json($this->versionRepository->getPaperVersions($paperId));
    }

    public function restoreVersion($versionId)
    {
        return response()->json($this->versionRepository->restorePaperVersion($versionId));
    }

    /**
     * Permission Actions
     */
    public function getPermissions($paperId)
    {
        return response()->json($this->permissionRepository->getPaperPermissionList($paperId));
    }

    public function addRolePermission(Request $request)
    {
        return response()->json($this->permissionRepository->addPaperRolePermission($request));
    }

    public function addUserPermission(Request $request)
    {
        return response()->json($this->permissionRepository->addPaperUserPermission($request));
    }

    public function deleteRolePermission($id)
    {
        return response()->json($this->permissionRepository->deletePaperRolePermission($id));
    }

    public function deleteUserPermission($id)
    {
        return response()->json($this->permissionRepository->deletePaperUserPermission($id));
    }

    /**
     * Comment Actions
     */
    public function getComments($paperId)
    {
        return response()->json($this->commentRepository->getPaperComments($paperId));
    }

    public function addComment(Request $request)
    {
        return response()->json($this->commentRepository->savePaperComment($request));
    }

    public function deleteComment($id)
    {
        return response()->json($this->commentRepository->deletePaperComment($id));
    }

    /**
     * Audit Actions
     */
    public function getAuditTrails($paperId)
    {
        return response()->json($this->auditRepository->getPaperAuditTrails($paperId));
    }

    /**
     * Share Link Actions
     */
    public function getShareLink($paperId)
    {
        return response()->json($this->shareLinkRepository->getPaperShareableLink($paperId));
    }

    public function saveShareLink(Request $request)
    {
        return response()->json($this->shareLinkRepository->savePaperShareableLink($request));
    }

    public function deleteShareLink($id)
    {
        return response()->json($this->shareLinkRepository->deletePaperShareableLink($id));
    }

    /**
     * Editor.js Asset Endpoints
     */
    public function uploadAsset(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'paperId' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['success' => 0, 'error' => $validator->errors()], 400);
        }

        return response()->json($this->assetService->storeImage($request->paperId, $request->file('image')));
    }

    public function fetchUrl(Request $request)
    {
        $url = $request->input('url');
        if (!$url) return response()->json(['success' => 0]);

        return response()->json($this->assetService->fetchLinkMeta($url));
    }
}
