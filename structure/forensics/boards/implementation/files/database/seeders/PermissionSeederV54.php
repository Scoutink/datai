<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\Pages;
use App\Models\RoleClaims;
use App\Models\Roles;
use Carbon\Carbon;
use Illuminate\Support\Str;

class PermissionSeederV54 extends BaseSeeder
{
    public function run()
    {
        $this->runOnce(function () {
            $adminRole = Roles::where('name', 'Admin')->first();

            $pageId = '8e44d175-f17d-4544-acf7-b88bcf2ff001';
            $now = Carbon::now();

            Pages::updateOrCreate(
                ['id' => $pageId],
                [
                    'name' => 'Boards',
                    'order' => 99,
                    'createdBy' => $adminRole?->id,
                    'modifiedBy' => $adminRole?->id,
                    'isDeleted' => 0,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                ]
            );

            $actions = [
                ['id' => '53b1c8e4-46af-43ed-b4e9-c05f56ef57ab', 'name' => 'View Boards', 'order' => 1, 'code' => 'BOARDS_VIEW_BOARDS'],
                ['id' => '0815f423-6882-4d37-8fb2-a78e34b0e7f6', 'name' => 'Create Board', 'order' => 2, 'code' => 'BOARDS_CREATE_BOARD'],
                ['id' => '2f2a2d4f-c9f6-4b36-b95b-fe54d2391f18', 'name' => 'Edit Board', 'order' => 3, 'code' => 'BOARDS_EDIT_BOARD'],
                ['id' => 'bc7e0b5b-90d8-4e3f-b76d-575a72744d37', 'name' => 'Delete Board', 'order' => 4, 'code' => 'BOARDS_DELETE_BOARD'],
                ['id' => 'dfbf13ac-811f-4e36-a04c-a95cc267b8d7', 'name' => 'Manage Cards', 'order' => 5, 'code' => 'BOARDS_MANAGE_CARDS'],
            ];

            foreach ($actions as $action) {
                Actions::updateOrCreate(
                    ['id' => $action['id']],
                    [
                        'name' => $action['name'],
                        'order' => $action['order'],
                        'pageId' => $pageId,
                        'code' => $action['code'],
                        'createdBy' => $adminRole?->id,
                        'modifiedBy' => $adminRole?->id,
                        'isDeleted' => 0,
                        'createdDate' => $now,
                        'modifiedDate' => $now,
                    ]
                );

                if ($adminRole) {
                    RoleClaims::updateOrCreate(
                        ['roleId' => $adminRole->id, 'actionId' => $action['id']],
                        ['id' => Str::uuid()->toString(), 'claimType' => $action['code']]
                    );
                }
            }
        });
    }
}
