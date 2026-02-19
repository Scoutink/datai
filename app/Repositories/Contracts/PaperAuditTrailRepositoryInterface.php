<?php

namespace App\Repositories\Contracts;

use App\Repositories\Contracts\BaseRepositoryInterface;

interface PaperAuditTrailRepositoryInterface extends BaseRepositoryInterface
{
    public function getPaperAuditTrails($paperId);
}
