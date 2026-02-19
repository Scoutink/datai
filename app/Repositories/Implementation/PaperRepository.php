<?php

namespace App\Repositories\Implementation;

use App\Models\PaperMetaDatas;
use App\Models\PaperAuditTrails;
use App\Models\PaperComments;
use App\Models\PaperOperationEnum;
use App\Models\PaperRolePermissions;
use App\Models\Papers;
use App\Models\PaperTokens;
use App\Models\PaperUserPermissions;
use App\Models\PaperVersions;
use App\Models\Categories;
use App\Models\Clients;
use App\Models\DocumentStatus;
use App\Models\UserRoles;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\PaperRepositoryInterface;
use App\Services\PaperIndexer;
use App\Services\Sheets\SheetDataService;
use Illuminate\Support\Facades\Log;

class PaperRepository extends BaseRepository implements PaperRepositoryInterface
{
    protected $indexer;
    protected $sheetDataService;

    public function __construct(PaperIndexer $indexer, SheetDataService $sheetDataService)
    {
        parent::__construct();
        $this->indexer = $indexer;
        $this->sheetDataService = $sheetDataService;
    }

    public static function model()
    {
        return Papers::class;
    }

    public function getPapers($attributes)
    {
        $query = Papers::select([
            'papers.id',
            'papers.name',
            'papers.createdDate',
            'papers.description',
            'papers.location',
            'papers.clientId',
            'papers.statusId',
            'papers.isIndexed',
            'papers.wordCount',
            'papers.readingTimeMinutes',
            'categories.id as categoryId',
            'categories.name as categoryName',
            'clients.companyName as companyName',
            'documentStatus.name as statusName',
            'documentStatus.colorCode as colorCode',
            DB::raw("CONCAT(users.firstName,' ', users.lastName) as createdByName"),
            DB::raw('(SELECT COUNT(*) FROM paperComments WHERE paperComments.paperId = papers.id) as commentCount'),
            DB::raw('(SELECT COUNT(*) FROM paperVersions WHERE paperVersions.paperId = papers.id) as versionCount')
        ])->join('categories', 'papers.categoryId', '=', 'categories.id')
            ->join('users', 'papers.createdBy', '=', 'users.id')
            ->leftJoin('clients', 'papers.clientId', '=', 'clients.id')
            ->leftJoin('documentStatus', 'papers.statusId', '=', 'documentStatus.id');

        $orderByArray = explode(' ', $attributes->orderBy ?? 'createdDate desc');
        $orderBy = $orderByArray[0];
        $direction = $orderByArray[1] ?? 'desc';

        $sortMapping = [
            'categoryName' => 'categories.name',
            'name' => 'papers.name',
            'createdDate' => 'papers.createdDate',
            'createdBy' => 'users.firstName',
            'companyName' => 'clients.companyName',
            'statusName' => 'documentStatus.name'
        ];

        if (isset($sortMapping[$orderBy])) {
            $query = $query->orderBy($sortMapping[$orderBy], $direction);
        } else {
            $query = $query->orderBy('papers.createdDate', 'desc');
        }

        if (!empty($attributes->categoryId)) {
            $query = $query->where(function ($q) use ($attributes) {
                $q->where('categoryId', $attributes->categoryId)
                  ->orWhere('categories.parentId', $attributes->categoryId);
            });
        }

        if (!empty($attributes->clientId)) {
            $query = $query->where('clientId', $attributes->clientId);
        }

        if (!empty($attributes->statusId)) {
            $query = $query->where('statusId', $attributes->statusId);
        }

        if (!empty($attributes->name)) {
            $query = $query->where(function ($q) use ($attributes) {
                $q->where('papers.name', 'like', '%' . $attributes->name . '%')
                  ->orWhere('papers.description', 'like', '%' . $attributes->name . '%');
            });
        }

        if (!empty($attributes->metaTags)) {
            $metaTags = $attributes->metaTags;
            $query = $query->whereExists(function ($q) use ($metaTags) {
                $q->select(DB::raw(1))
                  ->from('paperMetaDatas')
                  ->whereRaw('paperMetaDatas.paperId = papers.id')
                  ->where('paperMetaDatas.metatag', 'like', '%' . $metaTags . '%');
            });
        }

        if (!empty($attributes->createDateString)) {
            $startDate = Carbon::parse($attributes->createDateString)->startOfDay();
            $endDate = Carbon::parse($attributes->createDateString)->endOfDay();
            $query = $query->whereBetween('papers.createdDate', [$startDate, $endDate]);
        }

        return $query->skip($attributes->skip ?? 0)->take($attributes->pageSize ?? 10)->get();
    }

    public function getPapersCount($attributes)
    {
        $query = Papers::query()
            ->join('categories', 'papers.categoryId', '=', 'categories.id')
            ->join('users', 'papers.createdBy', '=', 'users.id')
            ->leftJoin('clients', 'papers.clientId', '=', 'clients.id')
            ->leftJoin('documentStatus', 'papers.statusId', '=', 'documentStatus.id');

        if (!empty($attributes->categoryId)) {
            $query = $query->where(function ($q) use ($attributes) {
                $q->where('categoryId', $attributes->categoryId)
                  ->orWhere('categories.parentId', $attributes->categoryId);
            });
        }

        if (!empty($attributes->name)) {
            $query = $query->where(function ($q) use ($attributes) {
                $q->where('papers.name', 'like', '%' . $attributes->name . '%')
                  ->orWhere('papers.description', 'like', '%' . $attributes->name . '%');
            });
        }

        if (!empty($attributes->clientId)) {
            $query = $query->where('clientId', $attributes->clientId);
        }

        if (!empty($attributes->statusId)) {
            $query = $query->where('statusId', $attributes->statusId);
        }

        if (!empty($attributes->metaTags)) {
            $metaTags = $attributes->metaTags;
            $query = $query->whereExists(function ($q) use ($metaTags) {
                $q->select(DB::raw(1))
                  ->from('paperMetaDatas')
                  ->whereRaw('paperMetaDatas.paperId = papers.id')
                  ->where('paperMetaDatas.metatag', 'like', '%' . $metaTags . '%');
            });
        }

        return $query->count();
    }

    public function assignedPapers($attributes)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        $userRoles = UserRoles::where('userId', $userId)->pluck('roleId')->toArray();

        $query = Papers::select([
            'papers.id',
            'papers.name',
            'papers.createdDate',
            'papers.description',
            'papers.location',
            'papers.clientId',
            'papers.statusId',
            'papers.isIndexed',
            'categories.id as categoryId',
            'categories.name as categoryName',
            'clients.companyName as companyName',
            'documentStatus.name as statusName',
            'documentStatus.colorCode as colorCode',
            DB::raw("CONCAT(users.firstName,' ', users.lastName) as createdByName"),
            DB::raw('(SELECT COUNT(*) FROM paperComments WHERE paperComments.paperId = papers.id) as commentCount'),
            DB::raw('(SELECT COUNT(*) FROM paperVersions WHERE paperVersions.paperId = papers.id) as versionCount')
        ])
        ->join('categories', 'papers.categoryId', '=', 'categories.id')
        ->join('users', 'papers.createdBy', '=', 'users.id')
        ->leftJoin('clients', 'papers.clientId', '=', 'clients.id')
        ->leftJoin('documentStatus', 'papers.statusId', '=', 'documentStatus.id')
        ->where(function ($q) use ($userId, $userRoles) {
            $q->whereExists(function ($sub) use ($userId) {
                $sub->select(DB::raw(1))
                    ->from('paperUserPermissions')
                    ->whereRaw('paperUserPermissions.paperId = papers.id')
                    ->where('paperUserPermissions.userId', $userId)
                    ->where(function ($sq) {
                        $sq->where('paperUserPermissions.isTimeBound', 0)
                           ->orWhere(function ($tsq) {
                               $now = Carbon::now();
                               $tsq->where('paperUserPermissions.isTimeBound', 1)
                                   ->where('paperUserPermissions.startDate', '<=', $now)
                                   ->where('paperUserPermissions.endDate', '>=', $now);
                           });
                    });
            })->orWhereExists(function ($sub) use ($userRoles) {
                $sub->select(DB::raw(1))
                    ->from('paperRolePermissions')
                    ->whereRaw('paperRolePermissions.paperId = papers.id')
                    ->whereIn('paperRolePermissions.roleId', $userRoles)
                    ->where(function ($sq) {
                        $sq->where('paperRolePermissions.isTimeBound', 0)
                           ->orWhere(function ($tsq) {
                               $now = Carbon::now();
                               $tsq->where('paperRolePermissions.isTimeBound', 1)
                                   ->where('paperRolePermissions.startDate', '<=', $now)
                                   ->where('paperRolePermissions.endDate', '>=', $now);
                           });
                    });
            });
        });

        // Apply filters/sort similar to getPapers
        if (!empty($attributes->categoryId)) {
            $query->where('papers.categoryId', $attributes->categoryId);
        }
        if (!empty($attributes->name)) {
            $query->where('papers.name', 'like', '%' . $attributes->name . '%');
        }

        return $query->skip($attributes->skip ?? 0)->take($attributes->pageSize ?? 10)->get();
    }

    public function assignedPapersCount($attributes)
    {
        // Replicate logic from assignedPapers but return count()
        $userId = Auth::parseToken()->getPayload()->get('userId');
        $userRoles = UserRoles::where('userId', $userId)->pluck('roleId')->toArray();

        $query = Papers::query()
        ->where(function ($q) use ($userId, $userRoles) {
            $q->whereExists(function ($sub) use ($userId) {
                $sub->select(DB::raw(1))
                    ->from('paperUserPermissions')
                    ->whereRaw('paperUserPermissions.paperId = papers.id')
                    ->where('paperUserPermissions.userId', $userId);
            })->orWhereExists(function ($sub) use ($userRoles) {
                $sub->select(DB::raw(1))
                    ->from('paperRolePermissions')
                    ->whereRaw('paperRolePermissions.paperId = papers.id')
                    ->whereIn('paperRolePermissions.roleId', $userRoles);
            });
        });

        if (!empty($attributes->categoryId)) {
            $query->where('categoryId', $attributes->categoryId);
        }

        return $query->count();
    }

    public function savePaper($request)
    {
        try {
            DB::beginTransaction();
            $paper = new Papers();
            $paper->name = $request->name;
            $paper->description = $request->description;
            $paper->contentJson = $request->contentJson;
            $paper->contentHtmlSanitized = $request->contentHtmlSanitized;
            $paper->contentText = $request->contentText;
            $paper->wordCount = $request->wordCount ?? 0;
            $paper->readingTimeMinutes = $request->readingTimeMinutes ?? 0;
            $paper->contentType = $request->contentType ?? Papers::TYPE_DOC;
            $paper->categoryId = $request->categoryId;
            $paper->clientId = $request->clientId;
            $paper->statusId = $request->statusId;
            $paper->save();

            // Grant creator permission automatically
            PaperUserPermissions::create([
                'paperId' => $paper->id,
                'userId' => Auth::id(),
                'isAllowDownload' => 1,
                'isTimeBound' => 0,
                'createdBy' => Auth::id()
            ]);

            if (!empty($request->metaTags)) {
                foreach ($request->metaTags as $tag) {
                    PaperMetaDatas::create([
                        'paperId' => $paper->id,
                        'metatag' => $tag['metatag']
                    ]);
                }
            }

            // Handle Initial Sheet Data
            if ($paper->contentType === Papers::TYPE_SHEET && !empty($request->initialSheetData)) {
                $this->sheetDataService->initializeSheet($paper->id, $request->initialSheetData);
            }

            // Index if content text is provided
            if ($paper->contentText) {
                $this->indexer->addPaperIndex($paper->id, $paper->contentText);
            }

            // Log Audit
            PaperAuditTrails::create([
                'paperId' => $paper->id,
                'operationName' => PaperOperationEnum::Created->value,
                'createdDate' => Carbon::now(),
                'createdBy' => Auth::id()
            ]);

            DB::commit();
            return $paper;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function updatePaper($request, $id)
    {
        try {
            DB::beginTransaction();
            $paper = Papers::findOrFail($id);
            
            // Create Version before update
            PaperVersions::create([
                'paperId' => $paper->id,
                'versionNo' => $paper->paperVersions()->count() + 1,
                'contentType' => $paper->contentType,
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

            $paper->name = $request->name;
            $paper->description = $request->description;
            $paper->contentJson = $request->contentJson;
            $paper->contentHtmlSanitized = $request->contentHtmlSanitized;
            $paper->contentText = $request->contentText;
            $paper->wordCount = $request->wordCount ?? 0;
            $paper->readingTimeMinutes = $request->readingTimeMinutes ?? 0;
            $paper->categoryId = $request->categoryId;
            $paper->clientId = $request->clientId;
            $paper->statusId = $request->statusId;
            $paper->save();

            // Sync Relational Data (SheetRows/Cells) with Univer JSON
            // This ensures data integrity between the View (JSON) and Logic (DB)
            $this->sheetDataService->syncFromUniverJson($paper->id, $paper->contentJson);

            // Update Metadata
            PaperMetaDatas::where('paperId', $id)->delete();
            if (!empty($request->metaTags)) {
                foreach ($request->metaTags as $tag) {
                    PaperMetaDatas::create([
                        'paperId' => $paper->id,
                        'metatag' => $tag['metatag']
                    ]);
                }
            }

            // Update Index
            if ($paper->contentText) {
                $this->indexer->updatePaperIndex($paper->id, $paper->contentText);
            }

            // Log Audit
            PaperAuditTrails::create([
                'paperId' => $paper->id,
                'operationName' => PaperOperationEnum::Modified->value,
                'createdDate' => Carbon::now(),
                'createdBy' => Auth::id()
            ]);

            DB::commit();
            return $paper;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function getPaperById($id)
    {
        return Papers::with(['paperMetaDatas', 'categories', 'clients', 'paperStatus'])->findOrFail($id);
    }

    public function archivePaper($id)
    {
        $paper = Papers::findOrFail($id);
        $paper->isDeleted = true;
        $paper->deletedBy = Auth::id();
        $paper->save();
        $paper->delete(); // Soft delete

        PaperAuditTrails::create([
            'paperId' => $id,
            'operationName' => PaperOperationEnum::Archived->value,
            'createdDate' => Carbon::now(),
            'createdBy' => Auth::id()
        ]);

        return true;
    }

    public function getDeepSearchPapers($attributes)
    {
        $results = $this->indexer->search($attributes->searchQuery, 10);
        if (empty($results['ids'])) return [];

        return Papers::select([
            'papers.id', 'papers.name', 'papers.description', 'papers.createdDate'
        ])
        ->whereIn('id', $results['ids'])
        ->get();
    }

    public function addPaperToDeepSearch($id) { /* Implement if needed */ }
    public function removePaperFromDeepSearch($id) { /* Implement if needed */ }
}
