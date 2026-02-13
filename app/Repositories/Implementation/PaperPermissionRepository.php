<?php

namespace App\Repositories\Implementation;

use App\Models\PaperAuditTrails;
use App\Models\PaperOperationEnum;
use App\Models\PaperRolePermissions;
use App\Models\Papers;
use App\Models\PaperUserPermissions;
use App\Models\UserRoles;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\PaperPermissionRepositoryInterface;

class PaperPermissionRepository extends BaseRepository implements PaperPermissionRepositoryInterface
{
    public static function model()
    {
        return Papers::class; // We primarily manage permissions for Papers
    }

    public function getPaperPermissionList($id)
    {
        $rolePermissions = PaperRolePermissions::where('paperId', $id)
            ->join('roles', 'paperRolePermissions.roleId', '=', 'roles.id')
            ->select('paperRolePermissions.*', 'roles.name as roleName')
            ->get();

        $userPermissions = PaperUserPermissions::where('paperId', $id)
            ->join('users', 'paperUserPermissions.userId', '=', 'users.id')
            ->select('paperUserPermissions.*', DB::raw("CONCAT(users.firstName,' ', users.lastName) as userName"))
            ->get();

        return [
            'rolePermissions' => $rolePermissions,
            'userPermissions' => $userPermissions
        ];
    }

    public function addPaperRolePermission($request)
    {
        try {
            DB::beginTransaction();
            $permissions = [];
            foreach ($request as $item) {
                $startDate = null;
                $endDate = null;
                if ($item['isTimeBound']) {
                    $startDate = Carbon::parse($item['startDate'])->startOfDay();
                    $endDate = Carbon::parse($item['endDate'])->endOfDay();
                }

                $permission = PaperRolePermissions::create([
                    'paperId' => $item['paperId'],
                    'roleId' => $item['roleId'],
                    'isAllowDownload' => $item['isAllowDownload'],
                    'isTimeBound' => $item['isTimeBound'],
                    'startDate' => $startDate,
                    'endDate' => $endDate,
                    'createdBy' => Auth::id()
                ]);

                PaperAuditTrails::create([
                    'paperId' => $item['paperId'],
                    'operationName' => PaperOperationEnum::Add_Permission->value,
                    'metaJson' => json_encode(['roleId' => $item['roleId']]),
                    'createdBy' => Auth::id(),
                    'createdDate' => Carbon::now()
                ]);
                $permissions[] = $permission;
            }
            DB::commit();
            return $permissions;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function addPaperUserPermission($request)
    {
        try {
            DB::beginTransaction();
            $permissions = [];
            foreach ($request as $item) {
                $startDate = null;
                $endDate = null;
                if ($item['isTimeBound']) {
                    $startDate = Carbon::parse($item['startDate'])->startOfDay();
                    $endDate = Carbon::parse($item['endDate'])->endOfDay();
                }

                $permission = PaperUserPermissions::create([
                    'paperId' => $item['paperId'],
                    'userId' => $item['userId'],
                    'isAllowDownload' => $item['isAllowDownload'],
                    'isTimeBound' => $item['isTimeBound'],
                    'startDate' => $startDate,
                    'endDate' => $endDate,
                    'createdBy' => Auth::id()
                ]);

                PaperAuditTrails::create([
                    'paperId' => $item['paperId'],
                    'operationName' => PaperOperationEnum::Add_Permission->value,
                    'metaJson' => json_encode(['userId' => $item['userId']]),
                    'createdBy' => Auth::id(),
                    'createdDate' => Carbon::now()
                ]);
                $permissions[] = $permission;
            }
            DB::commit();
            return $permissions;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function deletePaperUserPermission($id)
    {
        $permission = PaperUserPermissions::findOrFail($id);
        $paperId = $permission->paperId;
        $userId = $permission->userId;
        $permission->delete();

        PaperAuditTrails::create([
            'paperId' => $paperId,
            'operationName' => PaperOperationEnum::Remove_Permission->value,
            'metaJson' => json_encode(['userId' => $userId]),
            'createdBy' => Auth::id(),
            'createdDate' => Carbon::now()
        ]);

        return true;
    }

    public function deletePaperRolePermission($id)
    {
        $permission = PaperRolePermissions::findOrFail($id);
        $paperId = $permission->paperId;
        $roleId = $permission->roleId;
        $permission->delete();

        PaperAuditTrails::create([
            'paperId' => $paperId,
            'operationName' => PaperOperationEnum::Remove_Permission->value,
            'metaJson' => json_encode(['roleId' => $roleId]),
            'createdBy' => Auth::id(),
            'createdDate' => Carbon::now()
        ]);

        return true;
    }

    public function getIsDownloadFlag($id)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        $userRoles = UserRoles::where('userId', $userId)->pluck('roleId')->toArray();

        $userDownload = PaperUserPermissions::where('paperId', $id)
            ->where('userId', $userId)
            ->where('isAllowDownload', true)
            ->exists();

        $roleDownload = PaperRolePermissions::where('paperId', $id)
            ->whereIn('roleId', $userRoles)
            ->where('isAllowDownload', true)
            ->exists();

        return $userDownload || $roleDownload;
    }

    public function checkPaperPermission($id)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        $userRoles = UserRoles::where('userId', $userId)->pluck('roleId')->toArray();

        // Check if owner
        $isOwner = Papers::where('id', $id)->where('createdBy', $userId)->exists();
        if ($isOwner) return true;

        // Check User Permissions
        $userHasPerm = PaperUserPermissions::where('paperId', $id)
            ->where('userId', $userId)
            ->where(function ($q) {
                $q->where('isTimeBound', 0)
                  ->orWhere(function ($sq) {
                      $now = Carbon::now();
                      $sq->where('isTimeBound', 1)
                         ->where('startDate', '<=', $now)
                         ->where('endDate', '>=', $now);
                  });
            })->exists();

        if ($userHasPerm) return true;

        // Check Role Permissions
        $roleHasPerm = PaperRolePermissions::where('paperId', $id)
            ->whereIn('roleId', $userRoles)
            ->where(function ($q) {
                $q->where('isTimeBound', 0)
                  ->orWhere(function ($sq) {
                      $now = Carbon::now();
                      $sq->where('isTimeBound', 1)
                         ->where('startDate', '<=', $now)
                         ->where('endDate', '>=', $now);
                  });
            })->exists();

        return $roleHasPerm;
    }
}
