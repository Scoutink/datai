<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\Pages;
use App\Models\RoleClaims;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class InteractiveRBACSeeder extends Seeder
{
    public function run()
    {
        $user = Users::first();
        if (!$user) return;

        $adminRoleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4';

        // 1. Find or Create Page (Lookup by NAME to avoid ID conflict)
        $introPageName = 'Interactive Content';
        $page = Pages::where('name', $introPageName)->first();

        if (!$page) {
            $page = new Pages();
            $page->name = $introPageName;
            $page->order = 15;
            $page->createdBy = $user->id;
            $page->modifiedBy = $user->id;
            $page->createdDate = Carbon::now();
            $page->modifiedDate = Carbon::now();
            $page->isDeleted = 0;
            $page->save(); // This will auto-generate the UUID
        }
        
        $realPageId = $page->id;

        // 2. Create Actions (Single "God Mode" Permission for now)
        $actions = [
            ['name' => 'Manage Interactive Content', 'code' => 'MANAGE_INTERACTIVE_CONTENT', 'pageId' => $realPageId],
        ];

        foreach ($actions as $action) {
            $existingAction = Actions::where('code', $action['code'])->first();
            
            if ($existingAction) {
                // Update existing
                $existingAction->pageId = $realPageId;
                $existingAction->name = $action['name'];
                $existingAction->save();
                $actionId = $existingAction->id;
            } else {
                // Create new
                $newAction = new Actions();
                $newAction->id = Str::uuid(); 
                $newAction->name = $action['name'];
                $newAction->code = $action['code'];
                $newAction->pageId = $realPageId;
                $newAction->order = 1;
                $newAction->createdBy = $user->id;
                $newAction->modifiedBy = $user->id;
                $newAction->createdDate = Carbon::now();
                $newAction->modifiedDate = Carbon::now();
                $newAction->isDeleted = 0;
                $newAction->save();
                $actionId = $newAction->id;
            }

            // 3. Grant to Admin
            $claim = RoleClaims::where('roleId', $adminRoleId)
                ->where('claimType', $action['code'])
                ->first();

            if (!$claim) {
                RoleClaims::create([
                    'id' => Str::uuid(),
                    'roleId' => $adminRoleId,
                    'claimType' => $action['code'],
                    'actionId' => $actionId
                ]);
            }
        }
    }
}
