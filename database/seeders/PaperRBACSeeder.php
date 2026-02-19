<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\Pages;
use App\Models\RoleClaims;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class PaperRBACSeeder extends Seeder
{
    public function run()
    {
        $user = Users::first();
        if (!$user) return;

        $adminRoleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4';

        // Pages
        $allPapersPageId = 'a1b2c3d4-e5f6-4a5b-8c9d-0123456789ab';
        $myPapersPageId = 'b2c3d4e5-f6a7-4b6c-9d0e-123456789abc';

        $pages = [
            [
                'id' => $allPapersPageId,
                'name' => 'All Papers',
                'order' => 11,
                'createdBy' => $user->id,
                'modifiedBy' => $user->id,
                'createdDate' => Carbon::now(),
                'modifiedDate' => Carbon::now(),
                'isDeleted' => 0
            ],
            [
                'id' => $myPapersPageId,
                'name' => 'Assigned Papers',
                'order' => 12,
                'createdBy' => $user->id,
                'modifiedBy' => $user->id,
                'createdDate' => Carbon::now(),
                'modifiedDate' => Carbon::now(),
                'isDeleted' => 0
            ]
        ];

        foreach ($pages as $page) {
            Pages::updateOrCreate(['id' => $page['id']], $page);
        }

        // Actions
        $actions = [
            // All Papers Actions
            ['id' => Str::uuid(), 'name' => 'View Papers', 'code' => 'ALL_PAPERS_VIEW_PAPERS', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Create Paper', 'code' => 'ALL_PAPERS_CREATE_PAPER', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Edit Paper', 'code' => 'ALL_PAPERS_EDIT_PAPER', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Delete Paper', 'code' => 'ALL_PAPERS_DELETE_PAPER', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Manage Permissions', 'code' => 'PAPER_PERMISSION_MANAGE', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'View History', 'code' => 'PAPER_HISTORY_VIEW', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Restore History', 'code' => 'PAPER_HISTORY_RESTORE', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'View Audit Trail', 'code' => 'PAPER_AUDIT_VIEW', 'pageId' => $allPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Manage Share Links', 'code' => 'PAPER_SHARE_MANAGE', 'pageId' => $allPapersPageId],
            
            // Assigned Papers Actions
            ['id' => Str::uuid(), 'name' => 'Create Paper', 'code' => 'MY_PAPERS_CREATE_PAPER', 'pageId' => $myPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Edit Paper', 'code' => 'MY_PAPERS_EDIT_PAPER', 'pageId' => $myPapersPageId],
            ['id' => Str::uuid(), 'name' => 'Delete Paper', 'code' => 'MY_PAPERS_DELETE_PAPER', 'pageId' => $myPapersPageId],
        ];

        foreach ($actions as $action) {
            $actionData = array_merge($action, [
                'order' => 1,
                'createdBy' => $user->id,
                'modifiedBy' => $user->id,
                'createdDate' => Carbon::now(),
                'modifiedDate' => Carbon::now(),
                'isDeleted' => 0
            ]);
            
            $existingAction = Actions::where('code', $action['code'])->first();
            if ($existingAction) {
                $existingAction->update($actionData);
                $actionId = $existingAction->id;
            } else {
                Actions::create($actionData);
                $actionId = $actionData['id'];
            }

            // Grant to Admin
            RoleClaims::updateOrCreate(
                ['roleId' => $adminRoleId, 'claimType' => $action['code']],
                ['id' => Str::uuid(), 'actionId' => $actionId]
            );
        }
    }
}
