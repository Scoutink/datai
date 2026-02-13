<?php

namespace App\Repositories\Implementation;

use App\Models\PaperAuditTrails;
use App\Models\PaperOperationEnum;
use App\Models\Papers;
use App\Models\PaperVersions;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\PaperVersionsRepositoryInterface;

class PaperVersionsRepository extends BaseRepository implements PaperVersionsRepositoryInterface
{
    public static function model()
    {
        return PaperVersions::class;
    }

    public function getPaperVersions($paperId)
    {
        return PaperVersions::where('paperId', $paperId)
            ->join('users', 'paperVersions.createdBy', '=', 'users.id')
            ->select('paperVersions.*', DB::raw("CONCAT(users.firstName,' ', users.lastName) as createdByName"))
            ->orderBy('versionNo', 'desc')
            ->get();
    }

    public function getPaperVersionById($id)
    {
        return PaperVersions::findOrFail($id);
    }

    public function restorePaperVersion($id)
    {
        try {
            DB::beginTransaction();
            $version = PaperVersions::findOrFail($id);
            $paper = Papers::findOrFail($version->paperId);

            // Create a backup of the current state as a new version before restoring
            PaperVersions::create([
                'paperId' => $paper->id,
                'versionNo' => $paper->paperVersions()->count() + 1,
                'name' => $paper->name,
                'description' => $paper->description,
                'contentJson' => $paper->contentJson,
                'contentHtmlSanitized' => $paper->contentHtmlSanitized,
                'contentText' => $paper->contentText,
                'wordCount' => $paper->wordCount,
                'readingTimeMinutes' => $paper->readingTimeMinutes,
                'createdBy' => Auth::id(),
                'createdDate' => Carbon::now(),
                'modifiedDate' => Carbon::now()
            ]);

            // Restore from version
            $paper->name = $version->name;
            $paper->description = $version->description;
            $paper->contentJson = $version->contentJson;
            $paper->contentHtmlSanitized = $version->contentHtmlSanitized;
            $paper->contentText = $version->contentText;
            $paper->wordCount = $version->wordCount;
            $paper->readingTimeMinutes = $version->readingTimeMinutes;
            $paper->save();

            // Log Audit
            PaperAuditTrails::create([
                'paperId' => $paper->id,
                'operationName' => PaperOperationEnum::Restored->value,
                'metaJson' => json_encode(['restored_from_version_id' => $id, 'versionNo' => $version->versionNo]),
                'createdBy' => Auth::id(),
                'createdDate' => Carbon::now()
            ]);

            DB::commit();
            return $paper;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
