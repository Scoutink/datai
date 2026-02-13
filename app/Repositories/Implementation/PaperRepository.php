<?php

namespace App\Repositories\Implementation;

use App\Models\Papers;
use App\Models\PaperAuditTrails;
use App\Models\PaperComments;
use App\Models\PaperMetaDatas;
use App\Models\PaperShareableLink;
use App\Models\PaperUserPermissions;
use App\Models\PaperVersions;
use App\Repositories\Contracts\PaperRepositoryInterface;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PaperRepository extends BaseRepository implements PaperRepositoryInterface
{
    public static function model()
    {
        return Papers::class;
    }

    private function baseListQuery($attributes)
    {
        $query = Papers::query()
            ->leftJoin('categories', 'categories.id', '=', 'papers.categoryId')
            ->leftJoin('clients', 'clients.id', '=', 'papers.clientId')
            ->leftJoin('documentStatus', 'documentStatus.id', '=', 'papers.statusId')
            ->leftJoin('users', 'users.id', '=', 'papers.createdBy')
            ->select(
                'papers.*',
                'categories.name as categoryName',
                'clients.companyName',
                'documentStatus.name as statusName',
                DB::raw("CONCAT(users.firstName,' ', users.lastName) as createdByName"),
                DB::raw('(SELECT COUNT(*) FROM paperComments WHERE paperComments.paperId = papers.id AND paperComments.isDeleted = 0) as commentCount'),
                DB::raw('(SELECT COUNT(*) FROM paperVersions WHERE paperVersions.paperId = papers.id AND paperVersions.isDeleted = 0) as versionCount')
            );

        if (!empty($attributes->searchQuery)) {
            $search = $attributes->searchQuery;
            $query->where(function ($q) use ($search) {
                $q->where('papers.name', 'LIKE', '%' . $search . '%')
                    ->orWhere('papers.description', 'LIKE', '%' . $search . '%')
                    ->orWhere('papers.contentText', 'LIKE', '%' . $search . '%');
            });
        }

        $query->orderByRaw($attributes->orderBy ?? 'papers.createdDate desc');

        return $query;
    }

    public function getPapers($attributes)
    {
        $query = $this->baseListQuery($attributes);
        if (isset($attributes->skip) && isset($attributes->pageSize)) {
            $query->skip((int) $attributes->skip)->take((int) $attributes->pageSize);
        }
        return $query->get();
    }

    public function getPapersCount($attributes)
    {
        return $this->baseListQuery($attributes)->count('papers.id');
    }

    public function getAssignedPapers($attributes)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        $query = $this->baseListQuery($attributes);

        $query->where(function ($q) use ($userId) {
            $q->whereExists(function ($subQuery) use ($userId) {
                $subQuery->select(DB::raw(1))
                    ->from('paperUserPermissions')
                    ->whereColumn('paperUserPermissions.paperId', 'papers.id')
                    ->where('paperUserPermissions.userId', '=', $userId)
                    ->where(function ($d) {
                        $d->whereNull('paperUserPermissions.startDate')
                            ->orWhere('paperUserPermissions.startDate', '<=', Carbon::now());
                    })->where(function ($d) {
                        $d->whereNull('paperUserPermissions.endDate')
                            ->orWhere('paperUserPermissions.endDate', '>=', Carbon::now());
                    });
            })->orWhereExists(function ($subQuery) use ($userId) {
                $subQuery->select(DB::raw(1))
                    ->from('paperRolePermissions')
                    ->join('userRoles', 'userRoles.roleId', '=', 'paperRolePermissions.roleId')
                    ->whereColumn('paperRolePermissions.paperId', 'papers.id')
                    ->where('userRoles.userId', '=', $userId)
                    ->where(function ($d) {
                        $d->whereNull('paperRolePermissions.startDate')
                            ->orWhere('paperRolePermissions.startDate', '<=', Carbon::now());
                    })->where(function ($d) {
                        $d->whereNull('paperRolePermissions.endDate')
                            ->orWhere('paperRolePermissions.endDate', '>=', Carbon::now());
                    });
            });
        });

        if (isset($attributes->skip) && isset($attributes->pageSize)) {
            $query->skip((int) $attributes->skip)->take((int) $attributes->pageSize);
        }

        return $query->get();
    }

    public function getAssignedPapersCount($attributes)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        $query = $this->baseListQuery($attributes);
        $query->where(function ($q) use ($userId) {
            $q->whereExists(function ($subQuery) use ($userId) {
                $subQuery->select(DB::raw(1))->from('paperUserPermissions')
                    ->whereColumn('paperUserPermissions.paperId', 'papers.id')
                    ->where('paperUserPermissions.userId', '=', $userId);
            })->orWhereExists(function ($subQuery) use ($userId) {
                $subQuery->select(DB::raw(1))->from('paperRolePermissions')
                    ->join('userRoles', 'userRoles.roleId', '=', 'paperRolePermissions.roleId')
                    ->whereColumn('paperRolePermissions.paperId', 'papers.id')
                    ->where('userRoles.userId', '=', $userId);
            });
        });
        return $query->count('papers.id');
    }

    public function savePaper($request)
    {
        $model = Papers::create([
            'name' => $request->name,
            'description' => $request->description,
            'contentJson' => $request->contentJson,
            'contentHtmlSanitized' => $request->contentHtmlSanitized,
            'contentText' => strip_tags($request->contentHtmlSanitized),
            'wordCount' => str_word_count(strip_tags($request->contentHtmlSanitized ?? '')),
            'readingTimeMinutes' => max(1, (int) ceil(str_word_count(strip_tags($request->contentHtmlSanitized ?? '')) / 200)),
            'categoryId' => $request->categoryId,
            'clientId' => $request->clientId,
            'statusId' => $request->statusId,
            'retentionPeriod' => $request->retentionPeriod,
            'retentionAction' => $request->retentionAction,
            'isDeleted' => false,
        ]);

        foreach (json_decode($request->paperMetaDatas ?? '[]', true) ?? [] as $tag) {
            if (!empty($tag['metatag'])) {
                PaperMetaDatas::create(['paperId' => $model->id, 'metatag' => $tag['metatag']]);
            }
        }

        PaperUserPermissions::create([
            'paperId' => $model->id,
            'userId' => Auth::id(),
            'isAllowDownload' => 1,
            'createdBy' => Auth::id(),
        ]);

        PaperAuditTrails::create([
            'paperId' => $model->id,
            'operationName' => 'Created',
            'createdBy' => Auth::id(),
            'createdDate' => Carbon::now(),
        ]);

        return $model;
    }

    public function updatePaper($request, $id)
    {
        $model = Papers::findOrFail($id);

        PaperVersions::create([
            'paperId' => $model->id,
            'contentJson' => $model->contentJson,
            'contentHtmlSanitized' => $model->contentHtmlSanitized,
            'contentText' => $model->contentText,
            'isDeleted' => 0,
        ]);

        $model->fill([
            'name' => $request->name,
            'description' => $request->description,
            'contentJson' => $request->contentJson,
            'contentHtmlSanitized' => $request->contentHtmlSanitized,
            'contentText' => strip_tags($request->contentHtmlSanitized),
            'wordCount' => str_word_count(strip_tags($request->contentHtmlSanitized ?? '')),
            'readingTimeMinutes' => max(1, (int) ceil(str_word_count(strip_tags($request->contentHtmlSanitized ?? '')) / 200)),
            'categoryId' => $request->categoryId,
            'clientId' => $request->clientId,
            'statusId' => $request->statusId,
            'retentionPeriod' => $request->retentionPeriod,
            'retentionAction' => $request->retentionAction,
        ]);
        $model->save();

        PaperAuditTrails::create([
            'paperId' => $model->id,
            'operationName' => 'Updated',
            'createdBy' => Auth::id(),
            'createdDate' => Carbon::now(),
        ]);

        return $model;
    }

    public function archivePaper($id)
    {
        return Papers::findOrFail($id)->delete();
    }

    public function addComment($request)
    {
        return PaperComments::create(['paperId' => $request->paperId, 'comment' => $request->comment, 'isDeleted' => 0]);
    }

    public function getComments($paperId)
    {
        return PaperComments::where('paperId', $paperId)->orderBy('createdDate', 'desc')->get();
    }

    public function getVersions($paperId)
    {
        return PaperVersions::where('paperId', $paperId)->orderBy('createdDate', 'desc')->get();
    }

    public function restoreVersion($paperId, $versionId)
    {
        $paper = Papers::findOrFail($paperId);
        $version = PaperVersions::findOrFail($versionId);
        $paper->contentJson = $version->contentJson;
        $paper->contentHtmlSanitized = $version->contentHtmlSanitized;
        $paper->contentText = $version->contentText;
        $paper->save();
        return true;
    }

    public function saveShareableLink($request)
    {
        $model = PaperShareableLink::where('paperId', $request->paperId)->first();
        if (!$model) {
            $model = new PaperShareableLink();
            $model->id = (string) Str::uuid();
            $model->code = (string) Str::uuid();
            $model->createdDate = Carbon::now();
        }

        $model->paperId = $request->paperId;
        $model->password = !empty($request->password) ? base64_encode($request->password) : null;
        $model->isAllowDownload = (int) ($request->isAllowDownload ?? 0);
        $model->expiryDate = $request->expiryDate;
        $model->createdBy = Auth::id();
        $model->save();

        return $model;
    }

    public function getShareableLink($paperId)
    {
        return PaperShareableLink::where('paperId', $paperId)->first();
    }
}
