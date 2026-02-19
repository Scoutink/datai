<?php

namespace App\Repositories\Contracts;

use App\Repositories\Contracts\BaseRepositoryInterface;

interface PaperPermissionRepositoryInterface extends BaseRepositoryInterface
{
     public function getPaperPermissionList($id);
     public function addPaperRolePermission($request);
     public function addPaperUserPermission($request);
     public function deletePaperUserPermission($id);
     public function deletePaperRolePermission($id);
     public function getIsDownloadFlag($id);
     public function checkPaperPermission($id);
}
