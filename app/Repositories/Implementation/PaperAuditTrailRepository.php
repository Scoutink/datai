<?php

namespace App\Repositories\Implementation;

use App\Models\PaperAuditTrails;
use App\Models\Papers;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\PaperAuditTrailRepositoryInterface;

class PaperAuditTrailRepository extends BaseRepository implements PaperAuditTrailRepositoryInterface
{
    public static function model()
    {
        return PaperAuditTrails::class;
    }

    public function getPaperAuditTrails($paperId)
    {
        return PaperAuditTrails::where('paperId', $paperId)
            ->leftJoin('users', 'paperAuditTrails.createdBy', '=', 'users.id')
            ->select('paperAuditTrails.*', DB::raw("CONCAT(users.firstName,' ', users.lastName) as createdByName"))
            ->orderBy('createdDate', 'desc')
            ->get();
    }
}
