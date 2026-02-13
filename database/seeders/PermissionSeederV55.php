<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\Pages;
use App\Models\RoleClaims;
use App\Models\Roles;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PermissionSeederV55 extends BaseSeeder
{
    public function run()
    {
        $this->runOnce(function () {
            $adminRole = Roles::where('name', 'Admin')->first();
            $actorUserId = DB::table('userRoles')->where('roleId', $adminRole?->id)->value('userId')
                ?? DB::table('users')->value('id');
            if (!$actorUserId) {
                return;
            }

            $pageId = '5f9f6e56-4e98-4cfd-a0cd-4a9a81472f3b';
            $now = Carbon::now();

            Pages::updateOrCreate(['id' => $pageId], [
                'name' => 'Papers',
                'order' => 100,
                'createdBy' => $actorUserId,
                'modifiedBy' => $actorUserId,
                'isDeleted' => 0,
                'createdDate' => $now,
                'modifiedDate' => $now,
            ]);

            $actions = [
                ['id' => '8f6f8bd6-c355-4fd0-8b5f-21bdb0d96363', 'name' => 'All Papers View', 'order' => 1, 'code' => 'ALL_PAPERS_VIEW_PAPERS'],
                ['id' => 'f8f4caef-5018-4f00-a31c-ab09a70fe85c', 'name' => 'All Papers Create', 'order' => 2, 'code' => 'ALL_PAPERS_CREATE_PAPER'],
                ['id' => '8fac6d7f-b6ad-462f-bf2d-1ef7426e96df', 'name' => 'All Papers Edit', 'order' => 3, 'code' => 'ALL_PAPERS_EDIT_PAPER'],
                ['id' => '05d3b031-5d30-4f71-b7e6-586101ad7f90', 'name' => 'All Papers Delete', 'order' => 4, 'code' => 'ALL_PAPERS_DELETE_PAPER'],
                ['id' => '2f2f188f-f1ed-43dd-9cca-4e1384cc4f77', 'name' => 'All Papers Archive', 'order' => 5, 'code' => 'ALL_PAPERS_ARCHIVE_PAPER'],
                ['id' => '105952c5-f91d-4de7-a8a1-f8628bcf4d52', 'name' => 'All Papers Detail', 'order' => 6, 'code' => 'ALL_PAPERS_VIEW_DETAIL'],
                ['id' => '31fcf6f0-f6c8-4495-8fc6-7566de8023f8', 'name' => 'All Papers Comment', 'order' => 7, 'code' => 'ALL_PAPERS_MANAGE_COMMENT'],
                ['id' => 'ce05f408-cd3b-4736-b65f-5383fab8ae89', 'name' => 'All Papers Share Link', 'order' => 8, 'code' => 'ALL_PAPERS_MANAGE_SHARABLE_LINK'],
                ['id' => 'e01e10f6-1c30-40cc-9d6b-f0eb1a9ed137', 'name' => 'All Papers Restore Version', 'order' => 9, 'code' => 'ALL_PAPERS_RESTORE_VERSION'],
                ['id' => '2b8c9725-5d19-4747-bf58-2347eb24ec43', 'name' => 'Assigned Papers View', 'order' => 10, 'code' => 'ASSIGNED_PAPERS_VIEW_PAPERS'],
                ['id' => '8ec20f6f-4f45-4a7d-90ad-201f1c5f4d90', 'name' => 'Assigned Papers Create', 'order' => 11, 'code' => 'ASSIGNED_PAPERS_CREATE_PAPER'],
                ['id' => '8b539f0e-1596-4ee3-a61b-fd230ea796d3', 'name' => 'Assigned Papers Edit', 'order' => 12, 'code' => 'ASSIGNED_PAPERS_EDIT_PAPER'],
                ['id' => 'cd1af019-c3dd-46b8-84e2-4872ec1e19e0', 'name' => 'Assigned Papers Delete', 'order' => 13, 'code' => 'ASSIGNED_PAPERS_DELETE_PAPER'],
                ['id' => '220de3b7-7af0-4f62-8af7-b69abf53aa64', 'name' => 'Assigned Papers Archive', 'order' => 14, 'code' => 'ASSIGNED_PAPERS_ARCHIVE_PAPER'],
                ['id' => '7bb7ceb6-05e2-4053-bb70-95ca5eca9ecc', 'name' => 'Assigned Papers Detail', 'order' => 15, 'code' => 'ASSIGNED_PAPERS_VIEW_DETAIL'],
                ['id' => 'd708119a-d6ed-485a-a1af-592f88ec58e6', 'name' => 'Assigned Papers Comment', 'order' => 16, 'code' => 'ASSIGNED_PAPERS_MANAGE_COMMENT'],
                ['id' => '7f94fa13-763c-4f66-9d9a-e459830bf64b', 'name' => 'Assigned Papers Share Link', 'order' => 17, 'code' => 'ASSIGNED_PAPERS_MANAGE_SHARABLE_LINK'],
                ['id' => '58d59555-4c7d-4a2f-95f4-4cbf0c0df3df', 'name' => 'Assigned Papers Restore Version', 'order' => 18, 'code' => 'ASSIGNED_PAPERS_RESTORE_VERSION'],
            ];

            foreach ($actions as $action) {
                Actions::updateOrCreate(['id' => $action['id']], [
                    'name' => $action['name'],
                    'order' => $action['order'],
                    'pageId' => $pageId,
                    'code' => $action['code'],
                    'createdBy' => $actorUserId,
                    'modifiedBy' => $actorUserId,
                    'isDeleted' => 0,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                ]);

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
