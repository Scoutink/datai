<?php

namespace App\Http\Controllers;

use App\Repositories\Contracts\PaperRepositoryInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PaperController extends Controller
{
    private $paperRepository;

    public function __construct(PaperRepositoryInterface $paperRepository)
    {
        $this->paperRepository = $paperRepository;
    }

    public function getPapers(Request $request)
    {
        $queryString = (object) $request->all();
        $count = $this->paperRepository->getPapersCount($queryString);

        return response()->json($this->paperRepository->getPapers($queryString))
            ->withHeaders([
                'totalCount' => $count,
                'pageSize' => $queryString->pageSize ?? 10,
                'skip' => $queryString->skip ?? 0,
            ]);
    }

    public function getAssignedPapers(Request $request)
    {
        $queryString = (object) $request->all();
        $count = $this->paperRepository->getAssignedPapersCount($queryString);

        return response()->json($this->paperRepository->getAssignedPapers($queryString))
            ->withHeaders([
                'totalCount' => $count,
                'pageSize' => $queryString->pageSize ?? 10,
                'skip' => $queryString->skip ?? 0,
            ]);
    }

    public function savePaper(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'max:255'],
            'contentJson' => ['required'],
            'contentHtmlSanitized' => ['required'],
            'categoryId' => ['required', 'uuid'],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 422);
        }

        return response()->json($this->paperRepository->savePaper($request), 201);
    }

    public function getById($id)
    {
        return response()->json($this->paperRepository->find($id));
    }

    public function updatePaper(Request $request, $id)
    {
        return response()->json($this->paperRepository->updatePaper($request, $id));
    }

    public function deletePaper($id)
    {
        $this->paperRepository->destroy($id);
        return response()->json([], 204);
    }

    public function archivePaper($id)
    {
        $this->paperRepository->archivePaper($id);
        return response()->json([], 200);
    }

    public function addComment(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'paperId' => ['required', 'uuid'],
            'comment' => ['required'],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 422);
        }

        return response()->json($this->paperRepository->addComment($request), 201);
    }

    public function getComments($paperId)
    {
        return response()->json($this->paperRepository->getComments($paperId));
    }

    public function getVersions($paperId)
    {
        return response()->json($this->paperRepository->getVersions($paperId));
    }

    public function restoreVersion($paperId, $versionId)
    {
        return response()->json($this->paperRepository->restoreVersion($paperId, $versionId));
    }

    public function saveShareableLink(Request $request)
    {
        return response()->json($this->paperRepository->saveShareableLink($request));
    }

    public function getShareableLink($paperId)
    {
        return response()->json($this->paperRepository->getShareableLink($paperId));
    }
}
