<?php

namespace App\Repositories\Implementation;

use App\Models\PaperAuditTrails;
use App\Models\PaperComments;
use App\Models\PaperOperationEnum;
use App\Models\Papers;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\PaperCommentRepositoryInterface;

class PaperCommentRepository extends BaseRepository implements PaperCommentRepositoryInterface
{
    public static function model()
    {
        return PaperComments::class;
    }

    public function getPaperComments($paperId)
    {
        return PaperComments::where('paperId', $paperId)
            ->join('users', 'paperComments.createdBy', '=', 'users.id')
            ->select('paperComments.*', \Illuminate\Support\Facades\DB::raw("CONCAT(users.firstName,' ', users.lastName) as createdByName"))
            ->orderBy('createdDate', 'desc')
            ->get();
    }

    public function savePaperComment($request)
    {
        $comment = PaperComments::create([
            'paperId' => $request->paperId,
            'comment' => $request->comment,
            'createdBy' => Auth::id()
        ]);

        PaperAuditTrails::create([
            'paperId' => $request->paperId,
            'operationName' => PaperOperationEnum::Modified->value, // Or a specific Add_Comment if added to enum
            'metaJson' => json_encode(['action' => 'added_comment', 'commentId' => $comment->id]),
            'createdBy' => Auth::id(),
            'createdDate' => Carbon::now()
        ]);

        return $comment;
    }

    public function deletePaperComment($id)
    {
        $comment = PaperComments::findOrFail($id);
        $paperId = $comment->paperId;
        $comment->delete();

        PaperAuditTrails::create([
            'paperId' => $paperId,
            'operationName' => PaperOperationEnum::Modified->value,
            'metaJson' => json_encode(['action' => 'deleted_comment', 'commentId' => $id]),
            'createdBy' => Auth::id(),
            'createdDate' => Carbon::now()
        ]);

        return true;
    }
}
