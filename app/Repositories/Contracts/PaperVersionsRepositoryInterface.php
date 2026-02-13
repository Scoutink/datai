<?php

namespace App\Repositories\Contracts;

use App\Repositories\Contracts\BaseRepositoryInterface;

interface PaperVersionsRepositoryInterface extends BaseRepositoryInterface
{
    public function getPaperVersions($paperId);
    public function getPaperVersionById($id);
    public function restorePaperVersion($id);
}
